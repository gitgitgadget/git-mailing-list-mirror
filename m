From: Armin Kunaschik <megabreit@googlemail.com>
Subject: [PATCH] t0008: 4 tests fail with ksh88
Date: Fri, 20 May 2016 16:31:30 +0200
Message-ID: <CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 16:31:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3lSh-0001c9-W0
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 16:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbcETObc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 10:31:32 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35234 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbcETObb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 10:31:31 -0400
Received: by mail-yw0-f194.google.com with SMTP id n16so1795910ywd.2
        for <git@vger.kernel.org>; Fri, 20 May 2016 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=qdi4hKr+Nrrkj2KQq7orNHKoHjqmGPXgn6YEjhTWaso=;
        b=zXQqQ18XRQVZzvFSeuyxyA7Uyg1JqSbRwc2Isll0730XDv1/2kmDU8/05f5r/JJgql
         ZQi51xQvm8Q2QSfnCC8Jzf5D4ZgyoBdJq90xkeLXKwcjEW3tLiZiY9zNU5inhDEMiRL4
         xnkEhi68iqEitKvRS5OIX8rl4V1eq9UstIarpe//mtgqxsiQHdg05eX3pEmrtr9FEo9i
         Zo7+C/r9uiEAi+SVXWBwqrjK3MBIu+G/hWfZc4phE/LfWF+t2b/gUH+Kzp3oa6fxnTbq
         AY2nV4IX+B1CvLui4BdYQbETGmBvmla0PUIU8GRLn1yNo5JTpvLEqjS2A51twwoV6Y3f
         rowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=qdi4hKr+Nrrkj2KQq7orNHKoHjqmGPXgn6YEjhTWaso=;
        b=XpjfBD7fBQ5HPgYG1/jl6opuv6vch26yrrHzuSHIo3cCo47NItCqqtus7PVl+CFDnA
         ew8EePT3rUOBY8UN360A9QgL4d4R77PcSy3Clq5Fwo0KODYpQM9PIy2CuWlSeId4cXkk
         MbwC2e2GbA5gtJ2txmGFALC5ITmxTjndi8M/QwDYtJHc0hs43138vbyRRDCsCDy+/DO3
         xLguTVhQweJTR8OZLyvHNHla5Dx4e5IfQK+auwCxm0Jx+wg/3rqP9TSc+lQv+1rnBPR9
         0StjTLGGx9pQobuj4jvmpXqzqJDEHP+1KUk0UT3HZhMFZ2V0zC2Ij/78kL49p842T3MT
         Pe8g==
X-Gm-Message-State: AOPr4FVMqwDE52s1xHK0+R9yl9AobKDKHBQQXPSU+M8kEHe1no4nDnfOgZ00VwTaNNe5VHTkJaOc8cxX7e3WkQ==
X-Received: by 10.13.204.69 with SMTP id o66mr2039819ywd.168.1463754690403;
 Fri, 20 May 2016 07:31:30 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Fri, 20 May 2016 07:31:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295171>

From: Armin Kunaschik <megabreit@googlemail.com>

\" in the test t0008 is not treated the same way in bash and in ksh.
In ksh the \ disappears and generates false expect data to
compare with.
Using \\" works portable, the same way in bash and in ksh and
is less ambigous.

Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Armin Kunaschik <megabreit@googlemail.com>
---
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 89544dd..b425f3a 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -605,7 +605,7 @@ cat <<-EOF >expected-verbose
        a/b/.gitignore:8:!on*   a/b/one
        a/b/.gitignore:8:!on*   a/b/one one
        a/b/.gitignore:8:!on*   a/b/one two
-       a/b/.gitignore:8:!on*   "a/b/one\"three"
+       a/b/.gitignore:8:!on*   "a/b/one\\"three"
        a/b/.gitignore:9:!two   a/b/two
        a/.gitignore:1:two*     a/b/twooo
        $global_excludes:2:!globaltwo   globaltwo
@@ -686,7 +686,7 @@ cat <<-EOF >expected-all
        a/b/.gitignore:8:!on*   b/one
        a/b/.gitignore:8:!on*   b/one one
        a/b/.gitignore:8:!on*   b/one two
-       a/b/.gitignore:8:!on*   "b/one\"three"
+       a/b/.gitignore:8:!on*   "b/one\\"three"
        a/b/.gitignore:9:!two   b/two
        ::      b/not-ignored
        a/.gitignore:1:two*     b/twooo
