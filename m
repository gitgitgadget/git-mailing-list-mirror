From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 15/15] t4032-diff-inter-hunk-context.sh: replace using expr for arithmetic operations with the equivalent shell builtin
Date: Thu,  4 Feb 2016 10:20:59 +0000
Message-ID: <1454581259-57095-2-git-send-email-gitter.spiros@gmail.com>
References: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 11:21:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRH2M-0002U6-AU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 11:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933486AbcBDKVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 05:21:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35977 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933439AbcBDKVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 05:21:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id 128so11459680wmz.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 02:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8egYww38iea4HCd7kovgDiAf2t4ilmFhTuhblSWEaZg=;
        b=AriW2cp44VskN2X1Q5U6uv6zdbRzzQI0H0sscCOpeqMvlIYKi+TxwmBO8XZg9pqKTe
         vZFu9Crmn2l3Grk06jkzQl87HK+YQLO7rKQwLpZ7gdbzOztkX9Lv+iSgsvrW9Mb0f0+h
         dS+gE/CSRFrLwKbH4lg/ZD9n9KklJAQ6ANmuNDn0AA9ZEy+nAWTpJtpcX+G/QJHe6E9J
         H3rmGcz8S5pXmqGpP3lF6MlGN9Tw31ct6WCJ59vX23R17N3M28Lnv/n2tik0oisVEghm
         s8gQyu+z+fVdWnBCSEWbUDiRmqpcEP+DKDoDim6rT/6m8p3UzBqi5XuB1mKQqRF2I3uE
         TMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8egYww38iea4HCd7kovgDiAf2t4ilmFhTuhblSWEaZg=;
        b=eTO8xm97DdzXlRTETI/N309+wVacXp9VeLsyo8T9wezx2eAaoMtXlW2KxoYFd4SpCw
         TBFOLIbLFrKaKed01x+byGzD1OolqofGp7aCBOCHY2Flbm275dKoqjnIoA2iABNfG38g
         WyrusSeYVhlPyoXHWTEgBgfDMg8wuuWzwWeRnRnw+7MW2vqTHd31WboraYtj8l8DWMOu
         bTBECMzxtfCc26Qe+Kwg67gLILAEq6/dnUfTtfUPEP1m9TL8sPZ7wTzU7Zxb3nQyyn1I
         RIsxFiNuckj3FXSTyF8yJGIAYtC3WIPTh8FeHmwEFXJtdjTpxDk2sgdyeR+DXQHM522B
         syUQ==
X-Gm-Message-State: AG10YORfCOkpdSzMGsqLs03Qab9rjSVS6L8N7jZWqD8u8Sqxzd8Xg5EZhzcfme0CAN0RYw==
X-Received: by 10.195.17.198 with SMTP id gg6mr7233033wjd.15.1454581264118;
        Thu, 04 Feb 2016 02:21:04 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id u4sm10636107wjz.4.2016.02.04.02.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 02:21:03 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc3.377.gb2ff043
In-Reply-To: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285449>

expr is considered generally antiquated. It is best to use for arithmetic operations
the shell $((..)).

To quote POSIX:

    "The expr utility has a rather difficult syntax [...] In many cases, the arithmetic
    and string features provided as part of the shell command language are easier to use
    than their equivalents in expr. Newly written scripts should avoid expr in favor of
    the new features within the shell."

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t4032-diff-inter-hunk-context.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index e4e3e28..0b0b60f 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -10,7 +10,7 @@ f() {
 	while test $i -le $2
 	do
 		echo $i
-		i=$(expr $i + 1)
+		i=$(( $i + 1 ))
 	done
 	echo $3
 }
-- 
2.5.0
