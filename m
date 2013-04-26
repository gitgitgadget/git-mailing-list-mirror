From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 20/20] remote-bzr: export HEAD
Date: Thu, 25 Apr 2013 20:08:08 -0500
Message-ID: <1366938488-25425-21-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXBH-0004N5-89
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab3DZBKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:24 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36087 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab3DZBKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:10:21 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so3080763obc.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dZ9HNpqP7xPrSaSiV8cALDsU4ESrmbcX/owJ1LGV8TI=;
        b=IgUjxxEGCsX2pnfbm7pJ0Y4G6AnmzVYwsKTwlKyT4/2SO2gx02FCbeK9hMbbWa0Ysv
         N1cOwkfyeUw6sNZvYzrHbGdNw8LozkaFvdZRlcem4X/iRMoSh7pUq2/Qxf3ooHFdGfJF
         Ba0uDWtSX8EnDos//d12Iu4+N1q3sCnOrB3Bv6CAPxeM5YValyCP5KTVQGatOTdPX8uL
         B83hL3/Vkz9sNsSEG0w81rXZ3GvsXhGrNLujYTbc+5yoXHhLmw6l+JSaeInxsfWmiSNI
         1WSGH3PcfSW4qMIis/6qqsJ2s/zec1Wnft/2Am9KFTCVhKhtz+F1qjI9KOUtZjDAQ6kF
         5mrg==
X-Received: by 10.182.171.99 with SMTP id at3mr16599389obc.25.1366938620878;
        Thu, 25 Apr 2013 18:10:20 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pq6sm2990536obc.11.2013.04.25.18.10.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:10:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222501>

It probably doesn't make any difference, since we usually fetch along
the 'master' branch, and when we don't probably the current
transport-helper code doesn't work correctly.

But if it did work correctly, this might be useful.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 3c59a18..41c26a7 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -412,6 +412,8 @@ def do_import(parser):
 
     while parser.check('import'):
         ref = parser[1]
+        if ref == 'HEAD':
+            export_branch(repo, 'master')
         if ref.startswith('refs/heads/'):
             name = ref[len('refs/heads/'):]
             export_branch(repo, name)
-- 
1.8.2.1.884.g3532a8d
