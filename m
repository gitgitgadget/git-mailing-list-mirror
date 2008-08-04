From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH] correct access right for git-svn-dcommit test
Date: Mon, 04 Aug 2008 11:44:06 -0400
Message-ID: <489723C6.7060806@kitware.com>
References: <20080725060037.GB14756@untitled> <4889F215.9020804@kitware.com> <20080726054547.GA20494@untitled> <488B2FC5.4080801@kitware.com> <20080803220251.GB3006@untitled> <20080804141820.GT7008@dpotapov.dyndns.org> <20080804151424.GU7008@dpotapov.dyndns.org> <20080804153024.GV7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:45:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ2FB-0000i4-MO
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbYHDPn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 11:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbYHDPn4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:43:56 -0400
Received: from public.kitware.com ([66.194.253.19]:43132 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbYHDPn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 11:43:56 -0400
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 87B2D230C;
	Mon,  4 Aug 2008 11:44:31 -0400 (EDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id 7A7EA3EC;
	Mon,  4 Aug 2008 11:43:55 -0400 (EDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <20080804153024.GV7008@dpotapov.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91375>

Dmitry Potapov wrote:
> The tests requires anonymous write access. Therefore, "anon-access =
> write" is added to conf/svnserve.conf. But because it was added to
> the end of the file, it is impossible to guarantee in what section
> it will be located. It turned out that on SVN 1.5, it was placed in
> the wrong section and as result the test failed.
> 
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
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

I just tried this patch and it does fix the test on my system.

Thanks,
-Brad
