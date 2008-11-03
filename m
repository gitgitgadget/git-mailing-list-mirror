From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git log --walk-reflogs --pretty=oneline --all
Date: Mon, 3 Nov 2008 22:01:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811032158540.24407@pacific.mpi-cbg.de>
References: <ee2a733e0810300819r373ce1eeta335a39a0fcb77df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:56:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx6So-0001MG-1Y
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 21:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbYKCUyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 15:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbYKCUyH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 15:54:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:56920 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754216AbYKCUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 15:54:06 -0500
Received: (qmail invoked by alias); 03 Nov 2008 20:54:01 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 03 Nov 2008 21:54:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GSj0YnJzGYknTX5QHB1pcWbQ6MXwrZdHgDqdxoQ
	ZTDQ3kP1JEm+5N
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <ee2a733e0810300819r373ce1eeta335a39a0fcb77df@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99996>

Hi,

On Thu, 30 Oct 2008, Leo Razoumov wrote:

> Take a test repository that already has several commits in it, do the 
> following and watch the results:
> 
> sh$ git reflog expire --expire=1.second.ago --all
> sh$ git log --walk-reflogs --pretty=oneline --all

Like so?

-- snip --
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 5b24f05..d253067 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -216,4 +216,11 @@ test_expect_success 'delete' '
 
 '
 
+test_expect_success 'expired' '
+
+	git reflog expire --expire=1.second.ago --all &&
+	git log --walk-reflogs --pretty=oneline --all
+
+'
+
 test_done
-- snap --

> I am using git-1.6.0.2 and that's what I get
> 
> sh$ git reflog expire --expire=1.second.ago --all
> sh$ git log --walk-reflogs --pretty=oneline --all
> 60684d9df4193d91ef679173ef211275b9ad457f
> 810948facab2268139a1d4aac1368282e5ef1a9a
> 56f321d71b1bf6180977e9e3ff23836350ea2921 020
> 9e7f5cfb0fa20c44747f3d9111ccf161a2892
> 6160d0084fb8b02c3c1b5f1dd835d921d53ec86a
> 84de8b17fcab52a9c00587b81eb043c8614b37c5 68762f
> c23396e88e8ef8a1497d4f340a1bd69fa4
> 96bb86bfdd5f506ef233608c2ca8d58a13c834dd
> 287c7e907cd41dba25454d5708262e73a80c2bbb 2fcde3a98
> 09755d33f4b4093b1f2ef319f7ebe36
> 8e5b9847a38905e9d921d231c712c54720a4de5a
> 6ecfbc2bde9b771fba56d4b85ad2952b4fe0405c 0b71dc288ac2
> af4a2670e608c22e26beee272fd0 455601d6f414e400bfabb6410074b6ebee2696e0
> e78e5c0b98dfd44cc9e1e5d56a1e094d295a7c97
> 
> First of all, this log's content is next to zero. Secondly, all
> reflogs are already empty and I expected no output at all.

Well, in my test there was no output at all.  Just as expected.

Maybe you can come up with a test script that reproduces your claims?  But 
maybe your Git version is substantially different from mine?  Mine is 
1.6.0.2.763.g72663.

Ciao,
Dscho
