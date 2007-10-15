From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Make the output of "git svn clone" less confusing.
Date: Mon, 15 Oct 2007 17:21:10 +0200
Message-ID: <87k5poflp5.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 18:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhST4-0000XD-76
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 18:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757794AbXJOQGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2007 12:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757475AbXJOQGq
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 12:06:46 -0400
Received: from main.gmane.org ([80.91.229.2]:52955 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756861AbXJOQGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 12:06:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IhRwN-0001mZ-98
	for git@vger.kernel.org; Mon, 15 Oct 2007 15:33:11 +0000
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 15:33:11 +0000
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 15:33:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:ho6kh4Vv+gJn6VhCN9GKepLCMlw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61010>

The problem is that the first thing it prints is

  Initialized empty Git repository in .git/

even if actually created a subdirectory and changed into it first. But =
to the
user, it looks like it is creating a .git/ dir in the directory he/she =
is
started git from.
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

This change makes it more chatty, which might not be a good thing. But
I think the previous output was worse.

diff --git a/git-svn.perl b/git-svn.perl
index 777e436..d4450ca 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -286,6 +286,7 @@ sub do_git_init_db {
=20
 sub init_subdir {
 	my $repo_path =3D shift or return;
+	print "Creating directory $repo_path\n";
 	mkpath([$repo_path]) unless -d $repo_path;
 	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
 	$ENV{GIT_DIR} =3D '.git';
--=20
1.5.3.4.213.gb3127-dirty

--=20
David K=C3=A5gedal
