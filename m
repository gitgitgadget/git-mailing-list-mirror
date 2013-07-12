From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 23:34:46 -0700
Message-ID: <7vmwpsnv5l.fsf@alter.siamese.dyndns.org>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-2-git-send-email-sunshine@sunshineco.com>
	<7vli5crk8l.fsf@alter.siamese.dyndns.org>
	<CAPig+cQvnKSxZ5M6zW_r6Y9xwZ0Ch99JDq4SccYXCRof9svsOg@mail.gmail.com>
	<7vbo68pbwm.fsf@alter.siamese.dyndns.org>
	<CAPig+cTwXe7rSKUgJPVHbAvrxYbmL77xNXtLyUeRnd8Taxtrdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 08:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWwQ-00022F-89
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab3GLGeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:34:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192Ab3GLGet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:34:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D9B12C02C;
	Fri, 12 Jul 2013 06:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4WCkRJkXpKCE8Uu8GW6W2Czn62s=; b=jj5e2n
	dF9WugXeOeyx3BqmQ1DGsViUiMbtjzXrZMMX2+g9kwXHZI5pWe1F+PPNmbGDZs+r
	i0Tl3zquSdptymCH+MmqDLwvDgxCsCXvseIKMlAHZXV2zWj25KZSxwRSMvi44LED
	Kx7vNRcEpZR2W9A/Mkjn1jXqPb1XCaub0LkAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C3AOkDtfYyj7NpfrDRiQrE4QJPkD7ETQ
	4EElgG9eLKqe3xh6un9Sk+0UfOlN97YeweDPYux+WsN5CoZRigVBnl7kz8XvNXJZ
	aiyX6SfMgTgbTetG1gBwQpF75xhEgjwCtOE9ySj6nRsSqox+o2ej1VrfPJK9CIpT
	qsPu3aAljZo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 540632C02B;
	Fri, 12 Jul 2013 06:34:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D3452C027;
	Fri, 12 Jul 2013 06:34:47 +0000 (UTC)
In-Reply-To: <CAPig+cTwXe7rSKUgJPVHbAvrxYbmL77xNXtLyUeRnd8Taxtrdw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 12 Jul 2013 02:24:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25AFC416-EABD-11E2-9D00-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230178>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I find it easier than your original, but I do not know if you would
>> want to repeat the "Name... or <user@host>" at the end.  It does not
>> seem to add much useful information and is distracting.
>
> Next attempt:
>
>     For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the
>     command-line or standard input (when using `--stdin`) look up the
>     person's canonical name and email address (see "Mapping Authors"
>     below). If found, print them; otherwise print the input as-is.

Nice.

> ... Is it desirable to do so
> or should the user have more fine-grained control? ("xargs -0" comes
> to mind when thinking of a null-termination input switch.)

For the purposes of check-attr and check-ignore, a single "-z"
governing both is sufficient.  I think you already got that from my
4-patch series, but the core reason for that is :

 - when "-z" is used, the user knows the input paths may need
   protection against LF.

 - our output contains these same paths.

 - which means our output cannot be expressed unambiguously using LF
   as record separator.

For the purpose of check-mailmap, I actually do not see much point
in supporting "-z" format.  We do not even handle names or addresses
with LF in it.  The mailmap format would not let you express such
records in the first place, no?
