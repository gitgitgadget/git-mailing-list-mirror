From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Sun, 11 Aug 2013 22:40:59 -0700
Message-ID: <7vr4dz1n6c.fsf@alter.siamese.dyndns.org>
References: <1376256387-30974-1-git-send-email-stephen@exigencecorp.com>
	<CAPrKj1b=QTdqVH+JtukJrfEc=EqxWOEYE4YG7oSY7413uqdKfg@mail.gmail.com>
	<20130811180915.390d660a@sh9>
	<CAPrKj1aMURcVoaiJ+WS64ekafUZgSagKrYSknTUk3+TL6tCETQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Andres Perera <andres.p@zoho.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 07:41:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8ksO-0007KO-8K
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 07:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254Ab3HLFlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 01:41:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab3HLFlC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 01:41:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A26533D72;
	Mon, 12 Aug 2013 05:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vXO1dRBfDSgMegVhxPW6xSEPs/c=; b=qj9G8z
	+FS0ybL3DEEvngZ94bm5dTWchmfPuCzevW65u+CzjMjApEZoj3atCK8oKwzOpJxu
	HPqTIR2KKSmHPpTe3TolsAR1dR3nkUJMFlpLeIztdsKJUAHu7YJCaaYDRzNeK+KC
	2iQhQrKOu84Zg0orEULLLMLyBVZUw7YvNOKME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6sj1v3/9E+G+SdSfXb6RMGfr6Btle0q
	hLCJkLzRQx2ZLMpwLUyi9LfiCNXZB7sfvy48rdIzdG0KikA0/A92ounDqiUxaNzi
	3/YXALLRmG3OHqZB5Db7NpuvMJVFr9rA8yOzUxn3OkPbl6Tui2Iiy90HsxgnPHMS
	4vOChZQi8A8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0057B33D71;
	Mon, 12 Aug 2013 05:41:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E9D133D70;
	Mon, 12 Aug 2013 05:41:01 +0000 (UTC)
In-Reply-To: <CAPrKj1aMURcVoaiJ+WS64ekafUZgSagKrYSknTUk3+TL6tCETQ@mail.gmail.com>
	(Andres Perera's message of "Sun, 11 Aug 2013 19:01:07 -0430")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C57E5C5C-0311-11E3-A274-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232151>

Andres Perera <andres.p@zoho.com> writes:

> i just realized that there are ambiguities:
>
> pull -r (true|false|preserve) foo
>
> there are 2 ways to interpret this:
>
> pull --rebase=(true|false|preserve) foo # pull from remote named foo
>
> pull --rebase (true|false|preserve) foo # pull from remote named
> (true|false|preserve), branch foo
>
> options with optional operands usually require that the operands be
> concatenated with the option argument.

Yes.  This command line option should be like this:

 - "--rebase" and "--no-rebase" are accepted as "true" and "false";

 - "--rebase=preserve" should be the _only_ way to spell the new
   mode of operation (if we were to add "--rebase=interactive"
   later, that should follow suit); and

 - "--rebase=true" and "--rebase=false" is nice to have for
   consistency.

Thanks.
