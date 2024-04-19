Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F1B676
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504162; cv=none; b=lYsSoInFmlCGzJccwmLx98em9JvzAiDnnoWXm8ZXIqj0R8pQJBStVNsMBqFtmTJRlAtPrDBz4RuylXae4pj29Un4jIWSHr9TcQ/8aTe2TTjp/odD3/8a320dX+3YB/brxIBTFuG4YLjc4DK7FgFI3QnNW8DHNMBpyFy5m6Neimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504162; c=relaxed/simple;
	bh=wj9dMchDfB7R2zikuPNhoW1Y61vQzfq+pHOwYVpDRhw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e+3bIVZt0okouCuiKhyLENr7grF3aW4d54lIga5gYka7Qzp2Hwd96idzDpozGJW1VNn7eD/e3HXwmgxQLEK4VNUl69qEvVyyICs8uCtHUscPR9sY+EIF605eeU+gTBH+PJZfT9ghYkv9Ba87IXMhnIXqH8RVGGDlOh2CuFWiPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T09YnAq3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T09YnAq3"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51beae2f13so180293666b.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504158; x=1714108958; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUZDovbc7FZmvnnROI4CKNpCadCTv6oxoXIe8y7i6iU=;
        b=T09YnAq3FO/08ZjjDgti7LbiUWFJDCAxAM0ZpHYHIWplrGGe+3/PGfTwLToZ7ugAgJ
         FB9O1gizITb/6z/COAqIetRdf2pdGczrn6pB8vNagLezss0QN1TuYq1b3HTsnnFzOgM7
         VFfK35RBYQa5ohkLnnLtPajFh7CI/wMc3V+bhLRh9K8FClbNtko8YuT5+cwTOPdCjWQQ
         7et6MZH+ccOYq1jf8H9+c3Hgog/ioz+KduhGS+6FYRod3x0BMqVtX8LTDCGy4RrnCtej
         fG2hEZ8TRayAGCaOC5/l98n4DC/vpjLE9KLNY4ULIHk0J/JC3ku3pRqdtGdvFtPjewQs
         XVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504158; x=1714108958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUZDovbc7FZmvnnROI4CKNpCadCTv6oxoXIe8y7i6iU=;
        b=oQ1pSwY9DpV/xcJkQUwCizIv8wlf7LvABWFWrkyIuWRMS9DsyEveb9o8yIQ9O59WkN
         SmJ2exnc68dRpKftiWNS27N+UyDg1VyTN0l8zqCrMp5nmZ9Tm31/feOXAK5fV1hwIEf9
         YP7nwu76bwj7+vvCFkyrKeSQgMvWm8p5Zx2r1oyH7N8MniW/qyVS4rusry1Tqj2Qn0oB
         PrQZdoBxR0x8tS2yyRByQj5gUj6aiA1qW8KNATwsrqUbFihli7h3rCiCnob3YkgQP5BG
         w8bkZUH2hmmgiFOtOq8Qrj3i5dD4z5OdwGyZdUQTfwhXz+BAkzhKjO+Nr1YNHGnlgQbA
         VB1w==
X-Gm-Message-State: AOJu0YxS3qNNr/R8n3jjpqVQ4jxgtXZGmjj8+/2MLyeGB/XicYppgTgA
	yP/PBkyX3Hq9c1W50z+h4/M70yV87Fmc8ED6fsg8Djur3ML8lMKjcjZG6w==
X-Google-Smtp-Source: AGHT+IHdjfi78re8oyQjj9FSqN/ZIK1qpz9uUzWf6hREe1S4djqhz6QHN6bGoFoLn1Z+jB4mdJ3ihQ==
X-Received: by 2002:a17:906:6690:b0:a51:ddc6:f9c0 with SMTP id z16-20020a170906669000b00a51ddc6f9c0mr588984ejo.45.1713504157879;
        Thu, 18 Apr 2024 22:22:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jp4-20020a170906f74400b00a4734125fd2sm1714523ejb.31.2024.04.18.22.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:22:36 -0700 (PDT)
Message-Id: <e1fa05143ac63e8fe8dbc8ccb76a89b7a008c412.1713504153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 05:22:27 +0000
Subject: [PATCH v2 2/8] trailer: add unit tests for trailer iterator
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Test the number of trailers found by the iterator (to be more precise,
the parsing mechanism which the iterator just walks over) when given
some some arbitrary log message.

We test the iterator because it is a public interface function exposed
by the trailer API (we generally don't want to test internal
implementation details which are, unlike the API, subject to drastic
changes).

Signed-off-by: Linus Arver <linusa@google.com>
---
 Makefile                 |   1 +
 t/unit-tests/t-trailer.c | 175 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 t/unit-tests/t-trailer.c

diff --git a/Makefile b/Makefile
index d3a3f16f076..5418ddd03be 100644
--- a/Makefile
+++ b/Makefile
@@ -1347,6 +1347,7 @@ UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
new file mode 100644
index 00000000000..147a51b66b9
--- /dev/null
+++ b/t/unit-tests/t-trailer.c
@@ -0,0 +1,175 @@
+#include "test-lib.h"
+#include "trailer.h"
+
+static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
+{
+	struct trailer_iterator iter;
+	size_t i = 0;
+
+	trailer_iterator_init(&iter, msg);
+	while (trailer_iterator_advance(&iter)) {
+		i++;
+	}
+	trailer_iterator_release(&iter);
+
+	check_uint(i, ==, num_expected_trailers);
+}
+
+static void run_t_trailer_iterator(void)
+{
+	static struct test_cases {
+		const char *name;
+		const char *msg;
+		size_t num_expected_trailers;
+	} tc[] = {
+		{
+			"empty input",
+			"",
+			0
+		},
+		{
+			"no newline at beginning",
+			"Fixes: x\n"
+			"Acked-by: x\n"
+			"Reviewed-by: x\n",
+			0
+		},
+		{
+			"newline at beginning",
+			"\n"
+			"Fixes: x\n"
+			"Acked-by: x\n"
+			"Reviewed-by: x\n",
+			3
+		},
+		{
+			"without body text",
+			"subject: foo bar\n"
+			"\n"
+			"Fixes: x\n"
+			"Acked-by: x\n"
+			"Reviewed-by: x\n",
+			3
+		},
+		{
+			"with body text, without divider",
+			"my subject\n"
+			"\n"
+			"my body which is long\n"
+			"and contains some special\n"
+			"chars like : = ? !\n"
+			"hello\n"
+			"\n"
+			"Fixes: x\n"
+			"Acked-by: x\n"
+			"Reviewed-by: x\n"
+			"Signed-off-by: x\n",
+			4
+		},
+		{
+			"with body text, without divider (second trailer block)",
+			"my subject\n"
+			"\n"
+			"my body which is long\n"
+			"and contains some special\n"
+			"chars like : = ? !\n"
+			"hello\n"
+			"\n"
+			"Fixes: x\n"
+			"Acked-by: x\n"
+			"Reviewed-by: x\n"
+			"Signed-off-by: x\n"
+			"\n"
+			/*
+			 * Because this is the last trailer block, it takes
+			 * precedence over the first one encountered above.
+			 */
+			"Helped-by: x\n"
+			"Signed-off-by: x\n",
+			2
+		},
+		{
+			"with body text, with divider",
+			"my subject\n"
+			"\n"
+			"my body which is long\n"
+			"and contains some special\n"
+			"chars like : = ? !\n"
+			"hello\n"
+			"\n"
+			"---\n"
+			"\n"
+			/*
+			 * This trailer still counts because the iterator
+			 * always ignores the divider.
+			 */
+			"Signed-off-by: x\n",
+			1
+		},
+		{
+			"with non-trailer lines in trailer block",
+			"subject: foo bar\n"
+			"\n"
+			/*
+			 * Even though this trailer block has a non-trailer line
+			 * in it, it's still a valid trailer block because it's
+			 * at least 25% trailers and is Git-generated.
+			 */
+			"not a trailer line\n"
+			"not a trailer line\n"
+			"not a trailer line\n"
+			"Signed-off-by: x\n",
+			1
+		},
+		{
+			"with non-trailer lines (one too many) in trailer block",
+			"subject: foo bar\n"
+			"\n"
+			/*
+			 * This block has only 20% trailers, so it's below the
+			 * 25% threshold.
+			 */
+			"not a trailer line\n"
+			"not a trailer line\n"
+			"not a trailer line\n"
+			"not a trailer line\n"
+			"Signed-off-by: x\n",
+			0
+		},
+		{
+			"with non-trailer lines (only 1) in trailer block, but no Git-generated trailers",
+			"subject: foo bar\n"
+			"\n"
+			/*
+			 * This block has only 1 non-trailer out of 10 (IOW, 90%
+			 * trailers) but is not considered a trailer because the
+			 * 25% threshold only applies to cases where there was a
+			 * Git-generated trailer (see git_generated_prefixes[]
+			 * in trailer.c).
+			 */
+			"Reviewed-by: x\n"
+			"Reviewed-by: x\n"
+			"Reviewed-by: x\n"
+			"Helped-by: x\n"
+			"Helped-by: x\n"
+			"Helped-by: x\n"
+			"Acked-by: x\n"
+			"Acked-by: x\n"
+			"Acked-by: x\n"
+			"not a trailer line\n",
+			0
+		},
+	};
+
+	for (int i = 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
+		TEST(t_trailer_iterator(tc[i].msg,
+					tc[i].num_expected_trailers),
+		     "%s", tc[i].name);
+	}
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	run_t_trailer_iterator();
+	return test_done();
+}
-- 
gitgitgadget

