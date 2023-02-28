Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C374C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB1Xj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjB1XjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F0211F2
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so11279511pjq.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxNjxDkeNjgZcquqBLRA26yLYAectYct0U6ehvmfJK8=;
        b=XZor2IkP3D8O17fduKFU9jEXoOm0mJj7A8S2y1bow0h8257KMJVVY7lDY2/JCq/XBj
         xFS3vKNxXSDD5oXPjuo0DgiKd4uNLlEz2DPRHE9zsPat4Xug9aD6Fejw9XRlNtjejoDu
         vUklCMYsRdmIrLGdZxKN+RssqK+iN/4bt6rRxnb+7CvL2RuXytJIlqpgPJrutOyO3xc0
         wMRucJGvD0xq1cRwO3Z37KknDJ9yk8K5P1hIY/bAIcAlpfpCYD7pG3tx5wb4ad2WLP3G
         a2pbNzCLJbtclfvu1y+a6LyXNSvwFXKrB8ViNEhT+AZ50OLr5qfFUBXc/utEEd7ft8NB
         yh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxNjxDkeNjgZcquqBLRA26yLYAectYct0U6ehvmfJK8=;
        b=2iVBJNgZNQ1/pKXJCALMkHYtvcwhAbrYyOYxevBj6CPCgyeqckqNJKH6EvqrGwT9ZD
         Nsz8U62q0FwyotBd5XobUIhIy5v8bfce1VoI/GW627K2ekrSJ5zlODLP3kLsIyUXmOJJ
         xZh0nRActga1zfpEn3NlQTTonqeLGOC2SImBN+rP6/QevXeSPE6+rGd4+/ARE5zF7Gpn
         NCAUOlxtJHuRJSVta4vZSR/EcvTLkn7ljXQKQOBQ7niLwirDdWganM8JU3qcVoJ1PL6d
         NlqQzvScX+aMwacuXz4DWVoT2uojfnFZmhS+aQR/NG3NIqncVvfdOThCIQjSauQB29zU
         MBfA==
X-Gm-Message-State: AO0yUKUSxhp+Yu3+QTZUv2i7PTcHgNtO/wGC3DRzQ23tJkIqBnGYF3q/
        oLcWIevSA5JaPSO7FyGhGXosKcJGaLE=
X-Google-Smtp-Source: AK7set/JH+wfgtm0BOo4oROKdAx5WHCqQcIt9NkPiZq5ycoUndz+NQIf+w6g+FOcOwvxEB4SwOsFyg==
X-Received: by 2002:a05:6a20:3d8c:b0:cb:b92c:b46e with SMTP id s12-20020a056a203d8c00b000cbb92cb46emr4896451pzi.9.1677627557931;
        Tue, 28 Feb 2023 15:39:17 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78693000000b005dae7d1b61asm6559286pfo.154.2023.02.28.15.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 05/20] t5551: lower-case headers in expected curl trace
Date:   Tue, 28 Feb 2023 15:38:58 -0800
Message-Id: <20230228233913.684853-5-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com>
References: <20230228233913.684853-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

There's a test in t5551 which checks the curl trace (after simplifying
it a bit). It doesn't work with HTTP/2, because in that case curl
outputs all of the headers in lower-case. Even though this test is run
with HTTP/2 by t5559, nobody has noticed because checking the trace only
happens if GIT_TEST_PROTOCOL_VERSION is manually set to "0".

Let's fix this by lower-casing all of the header names in the trace, and
then checking for those in our expected code (this is easier than making
HTTP/2 traces look like HTTP/1.1, since HTTP/1.1 uses title-casing).

Sadly, we can't quite do this in our existing sed script. This works if
you have GNU sed:

  s/^\\([><]\\) \\([A-Za-z0-9-]*:\\)/\1 \L\2\E/

but \L is a GNU-ism, and I don't think there's a portable solution. We
could just "tr A-Z a-z" on the way in, of course, but that makes the
non-header parts harder to read (e.g., lowercase "post" requests). But
to paraphrase Baron Munchausen, I have learned from experience that a
modicum of Perl can be most efficacious.

Note that this doesn't quite get the test passing with t5559; there are
more fixes needed on top.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch-smart.sh | 55 ++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 29d489768e..a81f852cbf 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -35,30 +35,35 @@ setup_askpass_helper
 test_expect_success 'clone http repository' '
 	cat >exp <<-\EOF &&
 	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
-	> Accept: */*
-	> Accept-Encoding: ENCODINGS
-	> Accept-Language: ko-KR, *;q=0.9
-	> Pragma: no-cache
+	> accept: */*
+	> accept-encoding: ENCODINGS
+	> accept-language: ko-KR, *;q=0.9
+	> pragma: no-cache
 	< HTTP/1.1 200 OK
-	< Pragma: no-cache
-	< Cache-Control: no-cache, max-age=0, must-revalidate
-	< Content-Type: application/x-git-upload-pack-advertisement
+	< pragma: no-cache
+	< cache-control: no-cache, max-age=0, must-revalidate
+	< content-type: application/x-git-upload-pack-advertisement
 	> POST /smart/repo.git/git-upload-pack HTTP/1.1
-	> Accept-Encoding: ENCODINGS
-	> Content-Type: application/x-git-upload-pack-request
-	> Accept: application/x-git-upload-pack-result
-	> Accept-Language: ko-KR, *;q=0.9
-	> Content-Length: xxx
+	> accept-encoding: ENCODINGS
+	> content-type: application/x-git-upload-pack-request
+	> accept: application/x-git-upload-pack-result
+	> accept-language: ko-KR, *;q=0.9
+	> content-length: xxx
 	< HTTP/1.1 200 OK
-	< Pragma: no-cache
-	< Cache-Control: no-cache, max-age=0, must-revalidate
-	< Content-Type: application/x-git-upload-pack-result
+	< pragma: no-cache
+	< cache-control: no-cache, max-age=0, must-revalidate
+	< content-type: application/x-git-upload-pack-result
 	EOF
 
 	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 LANGUAGE="ko_KR.UTF-8" \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
+	perl -pe '\''
+		s/(Send|Recv) header: ([A-Za-z0-9-]+):/
+		"$1 header: " . lc($2) . ":"
+		/e;
+	'\'' |
 	sed -e "
 		s/Q\$//
 		/^[*] /d
@@ -78,31 +83,31 @@ test_expect_success 'clone http repository' '
 			s/^/> /
 		}
 
-		/^> User-Agent: /d
-		/^> Host: /d
+		/^> user-agent: /d
+		/^> host: /d
 		/^> POST /,$ {
 			/^> Accept: [*]\\/[*]/d
 		}
-		s/^> Content-Length: .*/> Content-Length: xxx/
+		s/^> content-length: .*/> content-length: xxx/
 		/^> 00..want /d
 		/^> 00.*done/d
 
-		/^< Server: /d
-		/^< Expires: /d
-		/^< Date: /d
-		/^< Content-Length: /d
-		/^< Transfer-Encoding: /d
+		/^< server: /d
+		/^< expires: /d
+		/^< date: /d
+		/^< content-length: /d
+		/^< transfer-encoding: /d
 	" >actual &&
 
 	# NEEDSWORK: If the overspecification of the expected result is reduced, we
 	# might be able to run this test in all protocol versions.
 	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
 	then
-		sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
+		sed -e "s/^> accept-encoding: .*/> accept-encoding: ENCODINGS/" \
 				actual >actual.smudged &&
 		test_cmp exp actual.smudged &&
 
-		grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
+		grep "accept-encoding:.*gzip" actual >actual.gzip &&
 		test_line_count = 2 actual.gzip
 	fi
 '
-- 
2.40.0-rc0-32-ga0f05f6840

