From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] t9143: do not fail when unhandled.log.gz is not created
Date: Mon, 6 Dec 2010 11:23:26 -0800
Message-ID: <20101206192326.GA12383@dcvr.yhbt.net>
References: <4CFA27E0.8070308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 20:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPgf8-00051y-Sl
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 20:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835Ab0LFTX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 14:23:28 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53610 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab0LFTX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 14:23:27 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02481F97C;
	Mon,  6 Dec 2010 19:23:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4CFA27E0.8070308@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163018>

Torsten B=F6gershausen <tboegi@web.de> wrote:
> Commit df73af5f66 is does not let the test case fail,
> when Compress::Zlib is missing.
> But:
> On a MacOS X 10.6 system with missing Compress::Zlib
> using svn version 1.6.5 (r38866) the gz file is created.
> Solution:
> Check for the existance of the unhandled.log.gz file.

I wonder if your system could have multiple perl installations and
git-svn is calling one while the shell scripts are calling another.
I'm not sure if there is another way the gz file could be created while
Compress::Zlib is missing.

> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>

Torsten B=F6gershausen wrote in <4CFA27DD.7030105@web.de>:
> Now we do not depend on internal implementation details of svn.
> And the code is 3% easier to understand :-)

I agree on this point completely

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  t/t9143-git-svn-gc.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9143-git-svn-gc.sh b/t/t9143-git-svn-gc.sh
> index 337ea59..8a95d78 100755
> --- a/t/t9143-git-svn-gc.sh
> +++ b/t/t9143-git-svn-gc.sh
> @@ -37,7 +37,7 @@ test_expect_success 'git svn gc runs' 'git svn gc'
>   test_expect_success 'git svn index removed' '! test -f =20
> .git/svn/refs/remotes/git-svn/index'
>  -if perl -MCompress::Zlib -e 0 2>/dev/null
> +if test -r .git/svn/refs/remotes/git-svn/unhandled.log.gz
>  then
>  	test_expect_success 'git svn gc produces a valid gzip file' '
>  		 gunzip .git/svn/refs/remotes/git-svn/unhandled.log.gz
> --=20
