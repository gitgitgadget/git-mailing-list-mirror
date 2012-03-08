From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] archive: fix archive generation for empty trees
Date: Thu, 08 Mar 2012 18:46:11 +0100
Message-ID: <4F58F063.4060600@lsrfire.ath.cx>
References: <1331165362-78065-1-git-send-email-brodie@sf.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Brodie Rao <brodie@sf.io>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:46:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hQ4-0003lQ-Jl
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 18:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab2CHRqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 12:46:18 -0500
Received: from india601.server4you.de ([85.25.151.105]:39049 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab2CHRqS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 12:46:18 -0500
Received: from [192.168.2.105] (p579BE4A1.dip.t-dialin.net [87.155.228.161])
	by india601.server4you.de (Postfix) with ESMTPSA id 851882F8042;
	Thu,  8 Mar 2012 18:46:16 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1331165362-78065-1-git-send-email-brodie@sf.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192624>

Am 08.03.2012 01:09, schrieb Brodie Rao:
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 527c9e7..404786f 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -360,4 +360,20 @@ test_expect_success GZIP 'remote tar.gz can be disabled' '
>   		>remote.tar.gz
>   '
>
> +test_expect_success \
> +    'git archive with an empty tree and a prefix' \
> +    'git rm -r .&&
> +     git commit -m empty&&
> +     git archive --format=tar --prefix=empty/ HEAD>  e1.tar&&
> +     "$TAR" tf e1.tar'
> +
> +test_expect_success \
> +    'git archive with an empty tree and no prefix' \
> +    'git archive --format=tar HEAD>  e2.tar&&
> +     test_must_fail "$TAR" tf e2.tar'

This test fails for me, i.e. tar does not complain about the empty 
archive (GNU tar 1.25).  Perhaps use git archive -v to generate a list 
of entries?

> +
> +test_expect_success \
> +    'git archive on specific paths with an empty tree' \
> +    'test_must_fail git archive --format=tar --prefix=empty/ HEAD foo'
> +
>   test_done
> -- 1.7.9.2
>
