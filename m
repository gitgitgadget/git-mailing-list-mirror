From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix error in generating snapshot
Date: Thu, 26 Jul 2007 00:17:26 +0200
Message-ID: <11854018464134-git-send-email-jnareb@gmail.com>
References: <30e4a070707250627l29ce4794x97d03b8232352cae@mail.gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 00:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpAr-0001Nd-B9
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276AbXGYWRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 18:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbXGYWRh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:17:37 -0400
Received: from hu-out-0506.google.com ([72.14.214.228]:12243 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbXGYWRh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 18:17:37 -0400
Received: by hu-out-0506.google.com with SMTP id 19so4892hue
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 15:17:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=scjltRcOqHX79zd6Vxg1jzJoogt5uuDJ67Q1z69+/i+e0Lvmv0A9+8rRnJuZwoJNEXIUlA1JBPwwMvje8Pou/pX1ueCCY2Qed86LliheM7tdIYO/aP3HarKI17BSg0n09WytP0+3IMSKMP5CTBs8nIn3EpE6ygHO1gXnMTl8U0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gaq/dAts6uJIzsRywTp9LZQp7egJGieJfIZ9d9lWUywenSJdpQLEx/x61cAiepd5ZyaN+FOesp7P8u7tL665CvmpbQrQH22ChKFJn4KTY87uPSq3/GnMoXsJZxb1yT5YOuXErTtWprXFASsuBxAvE+HQorg5ShO7Gro9nqBObtE=
Received: by 10.66.218.3 with SMTP id q3mr1690614ugg.1185401854278;
        Wed, 25 Jul 2007 15:17:34 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id b30sm2287921ika.2007.07.25.15.17.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 15:17:33 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6PMHRkR011966;
	Thu, 26 Jul 2007 00:17:27 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6PMHQVT011965;
	Thu, 26 Jul 2007 00:17:26 +0200
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <30e4a070707250627l29ce4794x97d03b8232352cae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53724>

There was an error while generating cmmandline to run git-archive:
there were no whitespace between two options.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0acd0ca..b381692 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4343,7 +4343,7 @@ sub git_snapshot {
 	my $cmd;
 	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
 	$cmd = "$git_command archive " .
-		"--format=$known_snapshot_formats{$format}{'format'}" .
+		"--format=$known_snapshot_formats{$format}{'format'} " .
 		"--prefix=\'$name\'/ $hash";
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . join ' ', @{$known_snapshot_formats{$format}{'compressor'}};
-- 
1.5.2.4
