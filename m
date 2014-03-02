From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH v3] write_pack_file: use correct variable in diagnostic
Date: Sun,  2 Mar 2014 15:30:11 +0800
Message-ID: <1393745411-30980-1-git-send-email-sunheehnus@gmail.com>
Cc: sunshine@sunshineco.com, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 08:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK0s9-0008VS-Ac
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 08:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbaCBHbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 02:31:35 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:53021 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaCBHbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 02:31:34 -0500
Received: by mail-pb0-f45.google.com with SMTP id uo5so1791564pbc.18
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 23:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Pp+JylHTtxsrSuystXYwlwZyemFfnnu98/nIZGMCqiY=;
        b=cIHFo8BxKKp73i7vRPy7DBqhnxbEMS37YO/XIW3s8kwPIf/Jyo5KDx9hYiNt67mBa5
         ewPY32mEYXTp39RIpqO24yJRKV31zvSgOcHwLjVkJ1n1jCkhGio/JrVn4LdA/56Lyc9j
         2WnrVJoyv1pcChvCUr3ZG8fMekV78sgpup0n6weHBwdn+ySOt0IngmXhYTxbqwxDAg+A
         Tv7A5zWXXADFweKaMRUVK5NOEoNsvwhtpHhoxNIuO8tdQmzhDKk9Mo9ohIoarsvmiwRm
         I6KjFl08owMfsxYVeX3g1zWSYBbaTVKy1lDyOvITa4O8IT1Lr9VY5GUpj9NgBrb++fPi
         NHWw==
X-Received: by 10.68.203.135 with SMTP id kq7mr12872347pbc.85.1393745493921;
        Sat, 01 Mar 2014 23:31:33 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id os1sm55492969pac.20.2014.03.01.23.31.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Mar 2014 23:31:33 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243135>

'pack_tmp_name' is the subject of the utime() check, so report it in the
warning, not the uninitialized 'tmpname'

Signed-off-by: Sun He <sunheehnus@gmail.com>
---

 Changing the subject and adding valid information as tutored by 
 Eric Sunshine.
 Thanks to him.

 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..4922ce5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -823,7 +823,7 @@ static void write_pack_file(void)
 				utb.modtime = --last_mtime;
 				if (utime(pack_tmp_name, &utb) < 0)
 					warning("failed utime() on %s: %s",
-						tmpname, strerror(errno));
+						pack_tmp_name, strerror(errno));
 			}
 
 			/* Enough space for "-<sha-1>.pack"? */
-- 
1.9.0.138.g2de3478.dirty
