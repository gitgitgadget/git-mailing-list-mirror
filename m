From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/5] submodule sync: test syncing one submodule
Date: Fri, 25 Mar 2016 11:39:15 -0700
Message-ID: <1458931156-29125-5-git-send-email-sbeller@google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	sunshine@sunshineco.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 19:39:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWdx-0005K8-BM
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbcCYSja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:39:30 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33521 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbcCYSjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:39:25 -0400
Received: by mail-pa0-f53.google.com with SMTP id fl4so51173796pad.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICh6Yn2XtOwgdUZFWGAkKa+i49pkmcI+6MLpcSjA91U=;
        b=nF415AEdL8SIGBG8ERDi1THOliOrWGzwQmNIGp9ihnt6XgEUtYW4Kd87M4xYlH2gOU
         my+ixcPR8k5dhBlE+dKBaFD8TGRNVeRxhabShg2JDtC3aFYgRUynjmcmIaRDGvIJteOd
         0A/KU2zz9OKF16za5HcalZ1vkyIqy6LniHVHBhwB7pirZZRRtdg59Kktn85OpGHHkx+S
         1O9JoZ3Ja81YwdpjBUsjZp2ZV4yRQdVX19i0TAzlO7vhHejXh3g/2Ed/OvFLW5hZsBdj
         Xg90LxC6eyjovL8o8BxGFxTSn+ZR39Pvi8OgKAd+sb0U7CguUgfvAyBQEXzimwOb9B+6
         hKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICh6Yn2XtOwgdUZFWGAkKa+i49pkmcI+6MLpcSjA91U=;
        b=nC8rj0yPScM1/KwgXU0TYQIs2ZWmMm9EzHQHZL74VwbYLlFLHdbV16iUWCX9iqKjyM
         7RpZ6F9YH4T8N/sDTFwesIcJWgfbt+HIsuIXbSnhnX7XHyYqNyQt31+LzaUS/tJg8LkR
         AnABelyq6WPvFvgvrXFeKuW7iKwxc10cqRZ5WAQix23iBmaUG8KjE1PcNLyh035Nc3kq
         cdRC1bcEojFxmFQQXpy7z7ioA6+/c17NkyJ3vGLlFUZNpjHCut/Hfs/SnJKYADgYEICJ
         1AYDWKhKIxsIyCZe9wwBlfHvfTbRY/qwj6HLCj3/i5naNyk6pZR2TMFSSqKZ9caFd9UY
         ZQdw==
X-Gm-Message-State: AD7BkJIE0J+27I5Oa0ZSyfT511F+P9tWEYPa6UtWDzr2QmxazZSjxd82+1y8jMDU0e9zv0EV
X-Received: by 10.67.1.237 with SMTP id bj13mr23413646pad.130.1458931164452;
        Fri, 25 Mar 2016 11:39:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e4a5:c9cf:82bb:5195])
        by smtp.gmail.com with ESMTPSA id o71sm17947839pfj.68.2016.03.25.11.39.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 11:39:23 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33.dirty
In-Reply-To: <1458931156-29125-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289939>

The current test suite doesn't cover syncing one module only.
Instead of adding a new test, we can change existing tests to cover this
part as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7403-submodule-sync.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 79bc135..5dde123 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -28,6 +28,9 @@ test_expect_success setup '
 		git submodule add ../submodule submodule &&
 		test_tick &&
 		git commit -m "submodule"
+		git submodule add ../submodule submodule2 &&
+		test_tick &&
+		git commit -m "second submodule"
 	) &&
 	git clone super super-clone &&
 	(
@@ -149,15 +152,16 @@ test_expect_success 'reset submodule URLs' '
 	reset_submodule_urls super-clone
 '
 
-test_expect_success '"git submodule sync" should update submodule URLs - subdirectory' '
+test_expect_success '"git submodule sync" should update specified submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		git pull --no-recurse-submodules &&
 		mkdir -p sub &&
 		cd sub &&
-		git submodule sync >../../output
+		git submodule sync ../submodule >../../output
 	) &&
 	grep "\\.\\./submodule" output &&
+	! grep submodule2 output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
@@ -177,7 +181,7 @@ test_expect_success '"git submodule sync" should update submodule URLs - subdire
 	)
 '
 
-test_expect_success '"git submodule sync --recursive" should update all submodule URLs - subdirectory' '
+test_expect_success '"git submodule sync --recursive" should update all specified submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		(
@@ -186,9 +190,10 @@ test_expect_success '"git submodule sync --recursive" should update all submodul
 		) &&
 		mkdir -p sub &&
 		cd sub &&
-		git submodule sync --recursive >../../output
+		git submodule sync --recursive ../submodule >../../output
 	) &&
 	grep "\\.\\./submodule/sub-submodule" output &&
+	! grep submodule2 output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
-- 
2.8.0.rc4.10.g52f3f33.dirty
