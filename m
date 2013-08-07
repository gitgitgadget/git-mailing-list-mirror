From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 3/4] pack-objects: do not print usage when repacking
Date: Wed,  7 Aug 2013 16:00:48 +0200
Message-ID: <1375884049-14961-4-git-send-email-stefanbeller@googlemail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
 <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: pclouds@gmail.com, iveqy@iveqy.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 16:01:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V74Iz-0003tU-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 16:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513Ab3HGOBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 10:01:10 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:35496 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab3HGOBI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 10:01:08 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so862262eak.22
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vlgzmm7qz6tQqUUJvzJj+z6T0Dx39jf1aosE6bzTFxo=;
        b=Fa0yKOjOwD/8SR/yAroE2VfB8Y++x0OZmYSGaJvbWWH/z4u34BHB196tfLj66CpP5+
         JVecMFpXiIlIRpZzBVpnxZpqwAQ0TzXzQdwc97Qz5s0vzzdc0X1xCc6rVu0Vrk+kwGKX
         hnbtzHcGhrTOGK1ePImKb2m+7Do4FXart2zYLlLcEw81msSSKV1d6AXs9Rg9nXNu/u0Z
         yhKbGLG2vQIlEJ4AQsptaYHkF98STGlWs2j0872CHYZWgobQcb0GWf/6jDkrSEP030O7
         Yjl16nYJe8VVc7i565GoagGeQNNSYGQz8hqDhKVpCS5aUca+U1yz/kQDfZh/gmavFFvM
         nSzQ==
X-Received: by 10.14.176.8 with SMTP id a8mr3351351eem.12.1375884061343;
        Wed, 07 Aug 2013 07:01:01 -0700 (PDT)
Received: from localhost (eduroam-69-67.uni-paderborn.de. [131.234.69.67])
        by mx.google.com with ESMTPSA id f49sm4237155eec.7.2013.08.07.07.00.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 07:01:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.g2793d0a
In-Reply-To: <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231826>

---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1742ea1..0bd8f3b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2585,7 +2585,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		base_name = argv[0];
 		argc--;
 	}
-	if (pack_to_stdout != !base_name || argc)
+	if (!(repack_flags & REPACK_IN_PROGRESS) && (pack_to_stdout != !base_name || argc))
 		usage_with_options(pack_usage, pack_objects_options);
 
 	rp_av[rp_ac++] = "pack-objects";
-- 
1.8.4.rc1.25.g2793d0a
