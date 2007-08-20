From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Suprising error message from "git clone"
Date: Mon, 20 Aug 2007 23:13:38 +0200
Message-ID: <vpqy7g5zz7h.fsf@bauges.imag.fr>
References: <vpqwsvqmfhw.fsf@bauges.imag.fr>
	<7vr6lyrlbb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 23:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INEZb-0005iv-Jx
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 23:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbXHTVOB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 17:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbXHTVOB
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 17:14:01 -0400
Received: from imag.imag.fr ([129.88.30.1]:44096 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbXHTVOA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 17:14:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7KLDcZH008910
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Aug 2007 23:13:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1INEZ8-000801-7R; Mon, 20 Aug 2007 23:13:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1INEZ8-00060r-5A; Mon, 20 Aug 2007 23:13:38 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
In-Reply-To: <7vr6lyrlbb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 20 Aug 2007 13\:40\:56 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Aug 2007 23:13:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56262>

Junio C Hamano <gitster@pobox.com> writes:

> Untested but something like this should suffice...

Jest tested, it works fine.

> By the way, could you possibly drop Mail-Followup-To: please?

Err, what's the problem with it? I don't wish to receive duplicate,
and I ask your mailer not to do so. I don't care too much if the
header is not honnored, but what you have to do is just to followup
without bothering about it.

>  git-clone.sh |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/git-clone.sh b/git-clone.sh
> index e4a9ac4..18003ab 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -99,6 +99,7 @@ origin_override=
>  use_separate_remote=t
>  depth=
>  no_progress=
> +local_explicitly_asked_for=
>  test -t 1 || no_progress=--no-progress
>  while
>  	case "$#,$1" in
> @@ -109,6 +110,7 @@ while
>  	*,--na|*,--nak|*,--nake|*,--naked|\
>  	*,-b|*,--b|*,--ba|*,--bar|*,--bare) bare=yes ;;
>  	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local)
> +	  local_explicitly_asked_for=yes
>  	  use_local_hardlink=yes ;;
>  	*,--no-h|*,--no-ha|*,--no-har|*,--no-hard|*,--no-hardl|\
>  	*,--no-hardli|*,--no-hardlin|*,--no-hardlink|*,--no-hardlinks)
> @@ -281,7 +283,8 @@ yes)
>  			then
>  				rm -f "$GIT_DIR/objects/sample"
>  				l=l
> -			else
> +			elif test -n "$local_explicitly_asked_for"
> +			then
>  				echo >&2 "Warning: -l asked but cannot hardlink to $repo"
>  			fi
>  		fi &&
>
>

-- 
Matthieu
