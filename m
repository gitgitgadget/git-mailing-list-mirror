From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Convert "! git" to "test_must_fail" git.
Date: Tue, 20 Jul 2010 14:42:17 -0500
Message-ID: <_BUqzkdWhTIktk0rYFvr9jdvISwfrShKmEsXaqgCBwm0X5Urcv2osQ@cipher.nrlssc.navy.mil>
References: <20100720181431.GA12857@localhost.localdomain> <fe4308a0ab1c3d7296efa986d5cfe63c6ff4014a.1279652856.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 21:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIhu-0008Ui-7D
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab0GTTmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 15:42:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54675 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab0GTTmU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:42:20 -0400
Received: by mail.nrlssc.navy.mil id o6KJgIQq004395; Tue, 20 Jul 2010 14:42:18 -0500
In-Reply-To: <fe4308a0ab1c3d7296efa986d5cfe63c6ff4014a.1279652856.git.jaredhance@gmail.com>
X-OriginalArrivalTime: 20 Jul 2010 19:42:18.0265 (UTC) FILETIME=[A98C3890:01CB2843]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151357>


Are you sure these are working properly?  If I recall
correctly, test_must_fail does not act the same as '!'
when a '|' is involved.  I believe the '!' negates the
result of the entire statement, but test_must_fail only
operates on the arguments preceding the '|'.

The rest looks good, and I'm surprised there were so many.

On 07/20/2010 02:09 PM, Jared Hance wrote:
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 8a63227..b20edff 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh

> @@ -134,7 +134,7 @@ do
>  	'
>  
>  	test_expect_success "grep -c $L (no /dev/null)" '
> -		! git grep -c test $H | grep /dev/null
> +		test_must_fail git grep -c test $H | grep /dev/null
>          '
>  
>  	test_expect_success "grep --max-depth -1 $L" '
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index 13766ab..9e86e9f 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -245,7 +245,7 @@ test_expect_success 'dcommit $rev does not clobber current branch' '
>  	test $old_head = $(git rev-parse HEAD) &&
>  	test refs/heads/my-bar = $(git symbolic-ref HEAD) &&
>  	git log refs/remotes/bar | grep "change 1" &&
> -	! git log refs/remotes/bar | grep "change 2" &&
> +	test_must_fail git log refs/remotes/bar | grep "change 2" &&
>  	git checkout master &&
>  	git branch -D my-bar
>  	'
