Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRIdK3Pu"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B3C1
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso85939f8f.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680721; x=1701285521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot6cmyfDWJ74BZuAkV7cUFae3QAbrLchR33HOSRbevc=;
        b=TRIdK3Pu3840rOh8g2ssRAOyJk6musAE755tI35R3B3K9Aa+s+TyOumwRfO+LMQ/aR
         l+PcEOVvI1oHntzPperGlXuKqgb+talpceU1utfM/NtdFxYQzcX2pXgO0gwI+IcfCZAM
         iKQlrT1L9m0E7i75Wo50ZFIPzcLF+W1Z1MqGpAlSnjvtcC8IEegEzmVaD3kfC24ptuRz
         boM57siE+7wUUF0fMAHtq58d5rYthn8w4ebYEsJiLbqpNERigBjb6Ajr+1jpDrIlKqpB
         2rqMYCnmLbWUCLC/qhy1fyI4a/nIqu7e81LCsjHmi01q5cnhCQ0Z60Fwz+lnSaWqeeiV
         28FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680721; x=1701285521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot6cmyfDWJ74BZuAkV7cUFae3QAbrLchR33HOSRbevc=;
        b=Z8CHV0v+9zcL4eS4Lc5G3MkfB4kdtZw+pjGCZGGdAjTpgm6EjNAi3wIBRh4ofUDWOh
         8xTtZ5C5ym25Lcd/LRKYlSDIshLev9z9FAs5+1TMha7oiBGmhWKE/Db98zD1FUC7/hyH
         c7IshxiuEOEBBNCCzW89ZC7SAwFb3eXGFGdbLoiBeyg507hEIeT3UOsALbGOI7Kw0Kwm
         dD0B1PpihGjWT4tKITY96Pdbf5zR+OyiOXmZKYjh3jkMR6qDl/BGAjjMb7WS+w/mmL7e
         cD7WFo0qDPHW2Ha8iX3wc+4CSHr1TJIAfDN3FJRDNnqi6gWPsqaehXhpvxtqKvTgUM/C
         AXxA==
X-Gm-Message-State: AOJu0YyTa7/GurHoCVPtZaIc//kDNJmB54C0Joju4PbggSJK16RlbwK9
	5VbPfqTy/1vL8+GQ5gR7DjyC1fKaJxI=
X-Google-Smtp-Source: AGHT+IH7+JyAEQaBbTyONMowOLvZEaL6NT5wK1n8oTJHqDq+gQmGgTwJvEAErF9S+6EpsAnVJAWxIw==
X-Received: by 2002:adf:fd11:0:b0:332:c65a:8f1e with SMTP id e17-20020adffd11000000b00332c65a8f1emr309599wrr.19.1700680720788;
        Wed, 22 Nov 2023 11:18:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d610f000000b00332cc24a59bsm120311wrt.109.2023.11.22.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:18:40 -0800 (PST)
Message-ID: <e50160fedc0ed6c07f705532878191b4c53df4f8.1700680717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
References: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Nov 2023 19:18:36 +0000
Subject: [PATCH 3/4] t0211: test URL redacting in PERF format
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

This transmogrifies the test case that was just added to t0210, to also
cover the `GIT_TRACE2_PERF` backend.

Just like t0211, we now have to toggle the `TEST_PASSES_SANITIZE_LEAK`
annotation.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t0211-trace2-perf.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index cfba6861322..290b6eaaab1 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -2,7 +2,7 @@
 
 test_description='test trace2 facility (perf target)'
 
-TEST_PASSES_SANITIZE_LEAK=true
+TEST_PASSES_SANITIZE_LEAK=false
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
@@ -268,4 +268,23 @@ test_expect_success PTHREADS 'global counter test/test2' '
 	have_counter_event "main" "counter" "test" "test2" 60 actual
 '
 
+test_expect_success 'unsafe URLs are redacted by default' '
+	test_when_finished \
+		"rm -r actual trace.perf unredacted.perf clone clone2" &&
+
+	test_config_global \
+		"url.$(pwd).insteadOf" https://user:pwd@example.com/ &&
+	test_config_global trace2.configParams "core.*,remote.*.url" &&
+
+	GIT_TRACE2_PERF="$(pwd)/trace.perf" \
+		git clone https://user:pwd@example.com/ clone &&
+	! grep user:pwd trace.perf &&
+
+	GIT_TRACE2_REDACT=0 GIT_TRACE2_PERF="$(pwd)/unredacted.perf" \
+		git clone https://user:pwd@example.com/ clone2 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <unredacted.perf >actual &&
+	grep "d0|main|start|.* clone https://user:pwd@example.com" actual &&
+	grep "d0|main|def_param|.*|remote.origin.url:https://user:pwd@example.com" actual
+'
+
 test_done
-- 
gitgitgadget

