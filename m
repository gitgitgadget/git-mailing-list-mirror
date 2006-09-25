From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/5] gitweb: Strip trailing slashes from $path in git_get_hash_by_path
Date: Tue, 26 Sep 2006 01:54:24 +0200
Message-ID: <200609260154.24488.jnareb@gmail.com>
References: <200609260153.08503.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 26 02:00:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS0Mv-0005e8-FF
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 02:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWIZAAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 20:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWIZAAH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 20:00:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:6744 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751777AbWIZAAD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 20:00:03 -0400
Received: by ug-out-1314.google.com with SMTP id o38so538801ugd
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 17:00:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=akYvIKu/LFTc3DcMMHnCdcZ/ttju+ky0uu9//ilNUDnsamZtgF6QkLPuHxS8jRR6XancyLJpz3o/zsPoFc/qF68+wNcoPgfs9J49iK0LNQl2OsRJTwyBZVglgtSA7TMNnC65KeKw3uSK0fk4OgyZ2G3BXCztieLutO6W4ej2sUQ=
Received: by 10.67.101.8 with SMTP id d8mr85923ugm;
        Mon, 25 Sep 2006 17:00:01 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id s1sm2153117uge.2006.09.25.17.00.00;
        Mon, 25 Sep 2006 17:00:01 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609260153.08503.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27758>

It also removes unused local variable $tree 

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 66be619..2ad7eed 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -710,7 +710,7 @@ sub git_get_hash_by_path {
 	my $path = shift || return undef;
 	my $type = shift;
 
-	my $tree = $base;
+	$path =~ s,/+$,,;
 
 	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
 		or die_error(undef, "Open git-ls-tree failed");
-- 
1.4.2.1
