From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/3] difftool: Disable --symlinks on cygwin
Date: Tue, 24 Jul 2012 20:14:24 -0700
Message-ID: <1343186064-49350-4-git-send-email-davvid@gmail.com>
References: <1343186064-49350-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 05:15:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sts4N-0002cl-P3
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137Ab2GYDPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:15:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64136 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab2GYDOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:14:35 -0400
Received: by yhmm54 with SMTP id m54so262339yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ffncpiQvOVoAMpbLU3hfkOkdGqV9eZfJpr4tMZ3Awtc=;
        b=nU92IPWoxfJCoorBzKSe8vYHOsN5s7Ufci6IC7iITkwpYyWsp5vAqfpAW8AUAWIoBR
         I09MhJZBGVVChtF3fre5HQMWYLXrChrrbjKLl1tq6gSGG/m4T/YGOpToEnOinmUuB4UM
         iuvEmZd0ISIkYzcqa3ZrZrvFr0kRlszarZXA5ObRmJikrZIT+suEphGRNNSjl2u/Mu0o
         1R6Q3oB1KiQSR9nIshA5JL9ix7VVpbX4PaJeODhVZPNRnHmhAms6F1aGz4MeD3UO/Jot
         k+Z1rM4J97pAvl7PtxkNqmrxpaMb1Yxph77ke4qjE9VvIGrUXwSpMW9UoXIKvmjAYpuJ
         YfZg==
Received: by 10.66.73.98 with SMTP id k2mr9267027pav.73.1343186074864;
        Tue, 24 Jul 2012 20:14:34 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ms9sm13401672pbb.43.2012.07.24.20.14.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:14:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
In-Reply-To: <1343186064-49350-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202103>

Symlinks are not ubiquitous on Windows so make --no-symlinks the default.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
I don't have cygwin so I can't verify this one myself.
Is 'cygwin' really the value of $^O there?

 git-difftool.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 591ee75..10d3d97 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -291,7 +291,8 @@ sub main
 		gui => undef,
 		help => undef,
 		prompt => undef,
-		symlinks => $^O ne 'MSWin32' && $^O ne 'msys',
+		symlinks => $^O ne 'cygwin' &&
+				$^O ne 'MSWin32' && $^O ne 'msys',
 		tool_help => undef,
 	);
 	GetOptions('g|gui!' => \$opts{gui},
-- 
1.7.12.rc0.15.g8157c39
