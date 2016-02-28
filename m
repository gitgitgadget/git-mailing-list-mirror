From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Sun, 28 Feb 2016 04:59:45 +0000
Message-ID: <20160228045945.GA14289@dcvr.yhbt.net>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, k_satoda@f2.dion.ne.jp
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Sun Feb 28 06:00:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZtT2-00061N-Pk
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992798AbcB1E7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 23:59:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39485 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992728AbcB1E7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 23:59:46 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B79620310;
	Sun, 28 Feb 2016 04:59:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1456597724-26497-1-git-send-email-tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287741>

tboegi@web.de wrote:
> --- a/t/t9115-git-svn-dcommit-funky-renames.sh
> +++ b/t/t9115-git-svn-dcommit-funky-renames.sh
> @@ -93,7 +93,7 @@ test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
>  # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
>  # > "Private use area") when creating or accessing files.
>  prepare_a_utf8_locale
> -test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
> +test_expect_success !UTF8_NFD_TO_NFC,UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '

Please keep lines wrapped at 80 cols or less.
(I need big fonts)

> @@ -105,10 +105,10 @@ test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
>  '
>  
>  # See the comment on the above test for setting of LC_ALL.
> -test_expect_success 'svn.pathnameencoding=cp932 rename on dcommit' '
> +test_expect_success !UTF8_NFD_TO_NFC,UTF8 'svn.pathnameencoding=cp932 rename on dcommit' '
>  	LC_ALL=$a_utf8_locale &&
>  	export LC_ALL &&
> -	inf=$(printf "\201\207") &&
> +	inf=$(printf "\201\207"o) &&

Why the extra 'o'?

>  	git config svn.pathnameencoding cp932 &&
>  	echo inf >"$inf" &&
>  	git add "$inf" &&
> -- 
