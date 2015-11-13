From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: unwrap tag refs
Date: Thu, 12 Nov 2015 22:36:16 -0600
Message-ID: <87h9kqwm67.fsf@waller.obbligato.org>
References: <1447388144-23806-1-git-send-email-git@rob.dqd.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Rob Mayoff <mayoff@dqd.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 05:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx66b-0002LJ-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 05:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbbKMEgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 23:36:24 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:60634 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754507AbbKMEgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 23:36:24 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1Zx66h-0004tw-Nn; Thu, 12 Nov 2015 22:37:03 -0600
In-Reply-To: <1447388144-23806-1-git-send-email-git@rob.dqd.com> (Rob Mayoff's
	message of "Thu, 12 Nov 2015 22:15:44 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281233>

Rob Mayoff <mayoff@dqd.com> writes:

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 9f06571..b051600 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -245,7 +245,10 @@ find_latest_squash()
>  		case "$a" in
>  			START) sq="$b" ;;
>  			git-subtree-mainline:) main="$b" ;;
> -			git-subtree-split:) sub="$b" ;;
> +			git-subtree-split:)
> +				sub="$b"

Why include the above line?

> +				sub="$(git rev-parse "$b^0")" || die "could not rev-parse split hash $b from commit $sq"

This seems like odd quoting.  Would not this do the same?

				sub="$(git rev-parse $b^0)" || die "could not rev-parse split hash $b from commit $sq"

Perhaps I am missing something.

> +				;;
>  			END)
>  				if [ -n "$sub" ]; then
>  					if [ -n "$main" ]; then
> @@ -278,7 +281,10 @@ find_existing_splits()
>  		case "$a" in
>  			START) sq="$b" ;;
>  			git-subtree-mainline:) main="$b" ;;
> -			git-subtree-split:) sub="$b" ;;
> +			git-subtree-split:)
> +				sub="$b"

And here too.

> +				sub="$(git rev-parse "$b^0")" || die "could not rev-parse split hash $b from commit $sq"

Same as above.

                        -David
