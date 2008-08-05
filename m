From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] correct access right for git-svn-dcommit test
Date: Mon, 4 Aug 2008 20:18:16 -0700
Message-ID: <20080805031816.GA9505@yp-box.dyndns.org>
References: <20080725060037.GB14756@untitled> <4889F215.9020804@kitware.com> <20080726054547.GA20494@untitled> <488B2FC5.4080801@kitware.com> <20080803220251.GB3006@untitled> <20080804141820.GT7008@dpotapov.dyndns.org> <20080804151424.GU7008@dpotapov.dyndns.org> <20080804153024.GV7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 05:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQD4y-00048c-Sa
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 05:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbYHEDST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 23:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756732AbYHEDST
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 23:18:19 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51894 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756140AbYHEDSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 23:18:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2B1572DC01B;
	Mon,  4 Aug 2008 20:18:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080804153024.GV7008@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91418>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> The tests requires anonymous write access. Therefore, "anon-access =
> write" is added to conf/svnserve.conf. But because it was added to
> the end of the file, it is impossible to guarantee in what section
> it will be located. It turned out that on SVN 1.5, it was placed in
> the wrong section and as result the test failed.
> 
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>

Brad and Dmitry: Thank you both very much.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  t/t9113-git-svn-dcommit-new-file.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
> index 8da8ce5..ae78e33 100755
> --- a/t/t9113-git-svn-dcommit-new-file.sh
> +++ b/t/t9113-git-svn-dcommit-new-file.sh
> @@ -28,6 +28,7 @@ start_svnserve () {
>  
>  test_expect_success 'start tracking an empty repo' '
>  	svn mkdir -m "empty dir" "$svnrepo"/empty-dir &&
> +	echo "[general]" > "$rawsvnrepo"/conf/svnserve.conf &&
>  	echo anon-access = write >> "$rawsvnrepo"/conf/svnserve.conf &&
>  	start_svnserve &&
>  	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
> -- 
> 1.6.0.rc1.74.g1e94
