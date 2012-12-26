From: Junio C Hamano <gitster@pobox.com>
Subject: Re: generating format-patch options from an e-mail
Date: Wed, 26 Dec 2012 12:35:28 -0800
Message-ID: <7vbodgo8kv.fsf@alter.siamese.dyndns.org>
References: <20121226200623.GA29446@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 26 21:35:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnxhd-0006Io-79
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 21:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab2LZUfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 15:35:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab2LZUfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 15:35:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 757C8AAED;
	Wed, 26 Dec 2012 15:35:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5+BagMbZESsOCbadfpXhF1fkguQ=; b=dv2f7E
	8TMUzEz8W/t+ugyOcOzYLph1SO9G3QLyhlRnEmOQzDnehyJ8IxzKxoOpZYufki0z
	t+YybBPgdw7SmcGA1SnEhUJWA0sDarhAbIDH7AgHpVKHXO21H3AClt8VGusKoea4
	fh3+ukpcZV5jMxdg+g9/D5K0NZ/Wnpf9DX7io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Us5tiAZTvEuQ5SQpDoFicSDdSL8zkdaX
	eB1JTGEZ7OsMeJWD4xagy8OczHx9rnFbvGHKwjSS7xNsRR46n87Q26T938+WXyr5
	fM3fAobVfyM4tMXF5Eg60TWu2ZRmUaVdRxjJiZVXhG9RZ85pr3ue4QNbiSOOB82b
	Gn157kdpJi4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62BBCAAEC;
	Wed, 26 Dec 2012 15:35:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7B12AAE9; Wed, 26 Dec 2012
 15:35:29 -0500 (EST)
In-Reply-To: <20121226200623.GA29446@simaj.xs4all.nl> (Simon Oosthoek's
 message of "Wed, 26 Dec 2012 21:06:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9CFD99A-4F9B-11E2-89A5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212151>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> Hi all
>
> I've been very frustrated by the process to setup a commandline for git format-patch, to include everyone in the cc list and reply to the right message-id.
>
> In my frustration I created a perl script to generate the options from a saved e-mail, I realise that it may be non-general and perhaps it could be written better using a module which understands e-mails, but well, it worked for me ;-)
>
> Anyway, I could imagine this as optional flag of git format-patch, so you could say:
> $ git format-patch -s --in-reply-to-email <mboxfile> a7fe7de8
>
> But I'll save that as an exercise for the reader (or the future)

I think a much more general approach would be to turn your script
into "get-msg-id" script and use it like so:

  $ git format-patch --in-reply-to $(get-msg-id <mboxfile>) a7fe7de8

Then you can reuse that script in a context outside format-patch,
whereever you need the message-id in a single message in the
mailbox.
