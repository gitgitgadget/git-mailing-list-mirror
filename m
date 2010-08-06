From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: Replaced /bin/sh with /bin/bash to make scripts
 with Bash syntax work on Solaris.
Date: Fri, 06 Aug 2010 09:00:12 -0700
Message-ID: <7veiebafzn.fsf@alter.siamese.dyndns.org>
References: <1281099365-11978-1-git-send-email-asgeir@twingine.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Asgeir S. Nilsen" <asgeir@twingine.no>
X-From: git-owner@vger.kernel.org Fri Aug 06 18:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhPLT-00028I-59
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 18:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933157Ab0HFQAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 12:00:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878Ab0HFQAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 12:00:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2B24CBED7;
	Fri,  6 Aug 2010 12:00:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7d7hldDu900aSYXu1JiYyjYfcHQ=; b=e6vr0o
	497brVyplx8AAZMdYj1ua46pv59a9l9qDYTWp+Ls9SomGG7RX19Xqrt21+0pJI2w
	9bKXItAxb+gxF+xIKazk7KQaRdV3LMN7jEBmU9rx0uawoT12LXRL0DVj/94v3m00
	E2sVSvftOOmSKs9O3rIMhyO09pUvf/GcLWN68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sD56F513tKviC18O9wXDeLjdZr5Mmzu7
	XMlHfu+5Gw3Nn+uW/vH8RrLRAFwOjaaRKc9Xlm7h8zJtbwq8UmkMoc7/PK9SnYGj
	6mStXZP732arTvFqB05rAC1nkuPQTu6qJKrs9UuU3B+YZB0vEJmn1oGsMA3IWmAe
	Pe6Xi6tk0Oo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B3ACCBED6;
	Fri,  6 Aug 2010 12:00:16 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3FB9CBED4; Fri,  6 Aug
 2010 12:00:13 -0400 (EDT)
In-Reply-To: <1281099365-11978-1-git-send-email-asgeir@twingine.no> (Asgeir
 S. Nilsen's message of "Fri\,  6 Aug 2010 14\:56\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4765A34-A173-11DF-BC2D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152792>

"Asgeir S. Nilsen" <asgeir@twingine.no> writes:

> Signed-off-by: Asgeir S. Nilsen <asgeir@twingine.no>
> ---
>  contrib/ciabot/ciabot.sh           |    2 +-
>  contrib/examples/git-checkout.sh   |    2 +-
>  ...
>  contrib/examples/git-verify-tag.sh |    2 +-
>  contrib/fast-import/git-import.sh  |    2 +-
>  contrib/git-resurrect.sh           |    2 +-
>  contrib/hooks/post-receive-email   |    2 +-
>  contrib/hooks/pre-auto-gc-battery  |    2 +-
>  contrib/remotes2config.sh          |    2 +-
>  contrib/rerere-train.sh            |    2 +-
>  contrib/workdir/git-new-workdir    |    2 +-

Thanks.

The ones in contrib/examples used to be part of git and they were meant to
get their shebang "#!/bin/sh" line replaced by the toplevel Makefile to
whatever shell suitable on the platform.  As you already know, /bin/sh on
Solaris is non-POSIX and we recommend people to use a POSIX compilant
shell.  The current Makefile suggests /bin/bash on Solaris, but either ksh
or /usr/xpg[46]/bin/sh should work.

So a NAK on contrib/examples/ part.

And replacing /bin/sh with /bin/bash for everybody is _wrong_, as bash is
not the only POSIX compliant shell.

Some of the scripts in contrib/ may be using bash-specific construct, but
I think they are already marked with "#!/bin/bash" on their first lines.
If there are some that use bash-ism without "#!/bin/bash", we should first
try to see if we can reasonably rewrite them to avoid bash-ism, and mark
them as bash scripts if we can't.  I wounld't be so surprised if there are
some, but what I sampled randomly while writing this response were pure
POSIX as far as I can tell.
