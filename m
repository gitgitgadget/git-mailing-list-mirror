Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72912E75
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625675; cv=none; b=QB+31m/Fw0bdzcgrBE8ShR0CZ+81QwwM5BB2RJjq0yf+9nTU3ZbBHiZCHCr/XixdJ7116WzQ8ui0ui6bQHJRcrH/UtDS+TynCzAMCc2QDG0C7NH2uXUk9abfjBC2TBCtUep9I8J7H1EhG0wp/nBCfTerT4kT74pG7eGslKzV980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625675; c=relaxed/simple;
	bh=g6JeJcLryUUQ1Z+s9u08hvV+Ey/BjT/kf7oFT8phA2k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=szebRBy4weohEs1uNJWifTK5AUDNZzn6WxRA1MLG3RQpAo7AMwrGd6VIHw1xMzInPyYoID4iDOJ+FGcSGy+rnNgPvKpaDL70fimaK++ed8WHyrBWDWqO6OC6Vl/2KyoI+2AGSgagKzuKxYWmtk+y6Mo/YXaje7JiXZK0+gv1sbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmDIxHpR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmDIxHpR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34e040ed031so450057f8f.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625672; x=1715230472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFyr8DwpcDs6uJW2CB97JjAvFQRz2zEA8znyg8RYS+U=;
        b=hmDIxHpRjtUqGLmAe5sLGQRissTfRg4JQ9gw6q5z/r4Ebm4QSb4AbhXSPJoT8IhOCo
         v7lWr/kQ8HS9lAGQ5P4I/hbHPHfu8C2FbnYr+ky2VHqOYMKUFQ69GKHln7TwRspnYK/A
         g4Oe3j+oT4bqEjZzzuzWklairncRiCAJcoWJCkP1R/SdJ2YY74Hmvu700p0IFQeYgack
         8k6Q7paExDAoBp7O+f5VkkyuKCD61cqd/KeycBp4CcqSE2s6xE79pFPk8/QlANExBiy7
         40/CpEUaMxe23Pz24PZ5R47ZkDXvDFBJXvSwwGhRBjvRrdZlFoX4/3A18ws9OURlUsfJ
         Iifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625672; x=1715230472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFyr8DwpcDs6uJW2CB97JjAvFQRz2zEA8znyg8RYS+U=;
        b=N12Jxqg5gLV3KFhaR+QTOLs9sljpTHjksTm+xNzM8cJanH6ShyU4lqIRw+IIoLNpc3
         92BvyrBGn01AISVUHgS94mkWFZ+Fiqe5oVGavnMdzjBqUEX4NPww1TYCJAkRbSnElPfi
         vy0KTfPALvxe5CCJsMLWthu4xutmQco8vsRp75q9yw5VbJKlApaLkEsC5vOKAB82iQYp
         3o139TGX0kmGrJpAhbghbqW9HIaI4iunkVYBuUEdYFyi8H3e7q4xQlUu61EI+c/A/Om3
         dO98EKTe3m+0Q8PT0bFJ48czsulWv0NXTZr1zjkhSTsdqqjCI2hfhId82STkHLxqrhMC
         G1mA==
X-Gm-Message-State: AOJu0Yy42CrPJtSBSMY3L7PV40Tx+qMCg7oV0HzFysjtWiv0HuYNZqAU
	wGQs57D6kQn1CTl+hhTBpWvPac/FoFi0QuJUErQO51SWUcPYTyIrIWHe5Q==
X-Google-Smtp-Source: AGHT+IG5E7MzIEkYxowJMzpd+aj6jHqhauUSXHx6D2CzWs+yWVrjJ81GXUCNXS21hCSXl0m1F7s+GA==
X-Received: by 2002:a5d:6047:0:b0:34c:f8ad:f782 with SMTP id j7-20020a5d6047000000b0034cf8adf782mr2556485wrt.40.1714625671766;
        Wed, 01 May 2024 21:54:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0034d9e5411ebsm248618wrc.45.2024.05.01.21.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:31 -0700 (PDT)
Message-Id: <b503b539c6fff7a3894c613dfc603a8241c790a1.1714625667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:19 +0000
Subject: [PATCH v4 02/10] trailer: add unit tests for trailer iterator
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
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linus@ucla.edu>

From: Linus Arver <linus@ucla.edu>

Test the number of trailers found by the iterator (to be more precise,
the parsing mechanism which the iterator just walks over) when given
some some arbitrary log message.

We test the iterator because it is a public interface function exposed
by the trailer API (we generally don't want to test internal
implementation details which are, unlike the API, subject to drastic
changes).

Signed-off-by: Linus Arver <linus@ucla.edu>
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

