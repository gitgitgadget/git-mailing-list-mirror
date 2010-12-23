From: strk <strk@keybit.net>
Subject: Re: git-svn author file and svn2cl compatibility
Date: Thu, 23 Dec 2010 09:11:20 +0100
Message-ID: <20101223081120.GA60001@keybit.net>
References: <20101222184110.GA53847@keybit.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 09:11:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVgGo-0001El-To
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 09:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab0LWILY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 03:11:24 -0500
Received: from host147-8-static.59-217-b.business.telecomitalia.it ([217.59.8.147]:2612
	"EHLO freek.keybit.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab0LWILY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 03:11:24 -0500
Received: (from strk@localhost)
	by freek.keybit.net (8.11.1/8.11.1) id oBN8BKx68793;
	Thu, 23 Dec 2010 09:11:20 +0100 (CET)
	(envelope-from strk@keybit.net)
Content-Disposition: inline
In-Reply-To: <20101222184110.GA53847@keybit.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164121>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I attach a patch implementing the added support.

--strk;

On Wed, Dec 22, 2010 at 07:41:10PM +0100, strk wrote:
> The svn2cl tool [1] supports an author file to use for
> generating the ChangeLog.
> 
> [1] http://arthurdejong.org/svn2cl/
> 
> Format of the file is:
>  nick1:Name <email>
>  nick2:Name 2 <email2>
> 
> It would be nice if git-svn could support the same format
> in addition to the one using ``='' instead of ``:''.
> 
> That way you might have the authors file already available
> in projects that made use of svn2cl.
> 
> Does it make sense ?
> 
> Please include me in reply as I'm not subscribed.

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Also-accept-svn2cl-format-for-authors-file.patch"

>From 0e6d6f3415b6d206e9cd8001ed4ce994e4150c39 Mon Sep 17 00:00:00 2001
From: Sandro Santilli <strk@keybit.net>
Date: Thu, 23 Dec 2010 09:07:10 +0100
Subject: [PATCH] Also accept svn2cl format for authors file

---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 177dd25..6fd0f7f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1424,7 +1424,7 @@ sub load_authors {
 	my $log = $cmd eq 'log';
 	while (<$authors>) {
 		chomp;
-		next unless /^(.+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
+		next unless /^(.+?|\(no author\))\s*[=:]\s*(.+?)\s*<(.+)>\s*$/;
 		my ($user, $name, $email) = ($1, $2, $3);
 		if ($log) {
 			$Git::SVN::Log::rusers{"$name <$email>"} = $user;
-- 
1.7.0.4


--cWoXeonUoKmBZSoM--
