Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDC37B
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091177; cv=none; b=YPFtL+lUK3tF++nlEaYa2A1yrkcpU9P1tUQ1YeeuMZTYWjXH0ZAci7LBQz/NxJWJ1Jl7MVbr9Gc40Ttw9Ky+DJY3WwTuwGdwdpXSmtLalg4uR19CsAl7w+8Je8I7HqoTyrItrkrZf/rsLe/YSb1QQnlOR/kJi+aYt85o6VOYmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091177; c=relaxed/simple;
	bh=5kDmCkE6aSdCZQlUEGCZKs0Wga1/nqp2UJuivy9Yij0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TvHk9fPT/TKQad/KsBANjfiEhE2nq8AOx0VbJXawGCwZwyeCdav64EbqW6hNJTOBSXcBMyPpSAGQDOGPoWxVFl3hjXts2ErJ8CeLeLrXjlE6Q8BtlnotYZzFDMIxEPDOhGqucGfMLMNMnBy8E/WWABQ/jdA+nIzI3+I92tVwXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWFAwuMb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWFAwuMb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b498ed12dso11420185e9.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091174; x=1714695974; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1mzvCb7c3aBNOXmdvRmGBEIZtu18iN0xvOe07d65Kk=;
        b=HWFAwuMbzzhzo9DY2gc3Rd/nY/FCDclZWIh+k2Pr54siiAqFn3sWLF1YMQ8uQKiJQ+
         40AzkUw+MVd3bhfG1GvzimGIwIq02dOKm/eVWdpPkjvOMq7eaXxmvzuBbApPlIwW8gUB
         blVMGZ9tf3Jl2FtWLPYsznGGpILWcvoVG+SCkhgZDqvicPuo6xC8cj/hrPQimL9Ibh9L
         yKdSBhowTkiSYsFm1CBBgjSE34mX7BMmyAfuLPEeCIl2Z59ywJOaYINrAqheSAl5eF/R
         8QJ577SFz/1jNVhRGbpYY7R74E4Mp9L/feAAio3dgduHBtvLOoLwsJ++hMiRw2zuWVd3
         f3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091174; x=1714695974;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1mzvCb7c3aBNOXmdvRmGBEIZtu18iN0xvOe07d65Kk=;
        b=mcxxlWAqDyEMno/hGLZtFTH1jBMkkHdJl9dZ2zyefSOOhBUApDXCHf1Y8iS59Gz7hO
         m6ZsTC6sFyHQBX9JDygfhTm2IC0XS4/PYfUQPtiml8Rk5q8rc3Rfv34QbUWMBPSc5kXQ
         xYFfW4m6YjD3zN/7mUeOwUzbGDCxiGRmpvB16Ak3QThJvBxKR/Pjt9/s7DQHq6rlYK+T
         tnNgV5QDaiVg6PxfLtsBRT6CDIFj4IrF9HfV5/t6xGDkZRsJDfCeMegMFOms+clXqvLx
         m4EnME1/OLNn10Qyo3PQM57xtUxqfAHcr+OUNhroINghpJG08HvlvEkKPWYxLKDl2Tis
         oewQ==
X-Gm-Message-State: AOJu0YzY3w3e1905VXpmJECPCn5mf7fJsvByI875gsKWifL1AZ35YSMU
	Pirq0pcBKZDpS8lqWYRbGQen1CHNICH3+E7x/C1bV1wPtyPWvfrzNxieMw==
X-Google-Smtp-Source: AGHT+IHXpl69UjmbqlkvUcosB0TDw2a82109JNPMwispMd/3J+lwF4xLHtiSlcd8z00Gc+k99RBchw==
X-Received: by 2002:a05:600c:1910:b0:41a:e5f5:99f8 with SMTP id j16-20020a05600c191000b0041ae5f599f8mr920492wmq.18.1714091173679;
        Thu, 25 Apr 2024 17:26:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b0041a3e724fc5sm17187349wmo.19.2024.04.25.17.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:13 -0700 (PDT)
Message-Id: <4ad0fbbb33cab9d5841689cc5660befe6921d515.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:02 +0000
Subject: [PATCH v3 02/10] trailer: add unit tests for trailer iterator
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
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
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
 t/unit-tests/t-trailer.c | 174 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)
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
index 00000000000..c1f897235c7
--- /dev/null
+++ b/t/unit-tests/t-trailer.c
@@ -0,0 +1,174 @@
+#include "test-lib.h"
+#include "trailer.h"
+
+static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
+{
+	struct trailer_iterator iter;
+	size_t i = 0;
+
+	trailer_iterator_init(&iter, msg);
+	while (trailer_iterator_advance(&iter))
+		i++;
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
+			 * at least 25% trailers and is Git-generated (see
+			 * git_generated_prefixes[] in trailer.c).
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
+			 * trailers) but is not considered a trailer block
+			 * because the 25% threshold only applies to cases where
+			 * there was a Git-generated trailer.
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

