From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Sun, 10 Jul 2005 23:48:50 +0200
Message-ID: <20050710214849.GA18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <20050707221443.GB7151@pasky.ji.cz> <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net> <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org> <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org> <7vy88ica8e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org> <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 00:16:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drk5l-0003pY-CN
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 00:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVGJWNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 18:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVGJWMf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 18:12:35 -0400
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:25796 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262149AbVGJWIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 18:08:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id DF8F41D7358
	for <git@vger.kernel.org>; Mon, 11 Jul 2005 00:08:08 +0200 (CEST)
Received: from lepidus.kulnet.kuleuven.ac.be (lepidus.kulnet.kuleuven.ac.be [134.58.240.72])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 1C47C1D7399
	for <git@vger.kernel.org>; Mon, 11 Jul 2005 00:08:07 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by lepidus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id CFEF638007F
	for <git@vger.kernel.org>; Mon, 11 Jul 2005 00:08:06 +0200 (CEST)
Received: (qmail 10939 invoked by uid 500); 10 Jul 2005 21:48:50 -0000
To: "Eric W. Biederman" <ebiederm@xmission.com>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 09, 2005 at 03:09:02PM -0600, Eric W. Biederman wrote:
> The current intelligent fetch currently has a problem that it cannot
> be used to bootstrap a repository.  If you don't have an ancestor
> of what you are fetching you can't fetch it.
> 

Not sure if this is what you want, but you could use the
following gitweb patch (to be applied on top of my previous
patches) to get a git tree snapshot for bootstrapping.

http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=summary
http://www.liacs.nl/~sverdool/gitweb.git/

skimo
--
Support pack snapshots.

---
commit f76a442a0e2166b3f17db0e496545a600a33f94c
tree f8f089ab738864e69e0155b10262dbec832b4a11
parent 8392280de17a89a451c1f7db4e268f2047d4aa83
author Sven Verdoolaege <skimo@liacs.nl> Sun, 10 Jul 2005 23:56:42 +0200
committer Sven Verdoolaege <skimo@liacs.nl> Sun, 10 Jul 2005 23:56:42 +0200

 gitweb.cgi |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/gitweb.cgi b/gitweb.cgi
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -2058,8 +2058,9 @@ sub git_snapshot {
 	      "<th></th>\n" .
 	      "</tr>\n";
 	my %types = (
-		'Bzipped tar archive' => 'tar.bz2',
-		'Gzipped tar archive' => 'tar.gz',
+		'Source tree (bzipped tar archive)' => 'tar.bz2',
+		'Source tree (gzipped tar archive)' => 'tar.gz',
+		'Git tree (pack file)' => 'pack',
 	);
 	my $alternate = 0;
 	for my $type (sort keys %types) {
@@ -2094,6 +2095,7 @@ sub git_serve_snapshot {
 	my %info = (
 		'tar.bz2' => [ 'application/x-bzip2', 'bzip2' ],
 		'tar.gz' => [ 'application/x-gzip', 'gzip' ],
+		'pack' => [ 'application/x-git-pack' ],
 	);
 	if (!exists $info{$st}) {
 		die_error(undef, "Unknown snapshot type.");
@@ -2101,7 +2103,10 @@ sub git_serve_snapshot {
 	my ($type, $zip) = @{$info{$st}};
 	print $cgi->header(-type => $type, 
 			   -attachment => "$project-$hash.$st");
-	open my $fd, "-|", "$gitbin/git-tar-tree $hash '$project-$hash' | $zip" 
+	open my $fd, "-|", ($st eq 'pack' ?
+		"$gitbin/git-rev-list --max-count=1 --objects $hash | ". 
+			"$gitbin/git-pack-objects --stdout" :
+		"$gitbin/git-tar-tree $hash '$project-$hash' | $zip")
 		or return;
 	undef $/;
 	print <$fd>;
