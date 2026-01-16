Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BA311C2D
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602382; cv=none; b=eQsbiF3TDAmt678UVWgQvsmQxJvbo9hwKharwzQiVBEZMSZsEyuFkdlgAIzDzMyy67q0Sq8vMdXsZ6k7orQgy0jqg6aidBMrs5XsCVb6AeTW4+FpfPdcbs5lCDP+kccbt+PA3N4zV8WXLq9MOBv0AJp3GKkQdi0NvZKBqEyEJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602382; c=relaxed/simple;
	bh=ZtFVzYCML55A0wA+JwhAHgRpzZ2e1fEUXyYJ8dDlpY0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eWA9EB8emsf+z1VpK7sIBodC/x2cDq93GDXVVaGs5Cj3hBEzJSZai06pz/iwYS5RCaPNjR2iPFlJpF/m5OV/aDyNcvWtxDInHWFthXGyLltZgx12X2wW0SjhvWP+gPy0ZyNwOdbSpi6xhjk55ZFQQIeggZUFLC7vM0zlrYYiOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT4guyXA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT4guyXA"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8888a444300so26097686d6.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 14:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602377; x=1769207177; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxnQ8FM9AcWDvtL6GvCI/J9nSMkkBTNW+21DDrzkBPA=;
        b=UT4guyXAUIGZmEdbSvacWHWUfOLjwWPTENfGIgMcpHVhwzCz+bq8D7LgQxPst2x5cQ
         SeU5as477A3n30gb1T/gGdmZpaYbOffC+E7AK8uxkYieMyxKfXZzID5xs9bHOjmV+Ly7
         Hk+CvL9/3Ue9JfPUQT35Z5UwpRnwaNoc9QXN6HsTFzsptp1Sh7qEIJc/jZ5J5yC+7MtI
         uBcT6HOuynt7kzm+L5s/h36AVxAf72g6pE0AkYCABN8AryFAtBR7tzDsLYYwkyvuVLnP
         ZZAP4GpIMUDuwuKzuQB071LCyZG6ATgcUTofN17i95gzCqxJf8pUE+MHp6/epNOoUlml
         /yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602377; x=1769207177;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dxnQ8FM9AcWDvtL6GvCI/J9nSMkkBTNW+21DDrzkBPA=;
        b=nN4yGeMFIzeVqPa6BzhjyV393AGqcj483gd6DzP5jFJcGO3VeOEzL+cHkU4SVD6OTu
         fJe9ie9TLKuVTf34+LKzTXH89OGH41Y3ShRSxNq3PDL5GUNRSHQaCYIMi1UFdJtYYX10
         ujWcR+gMUfBriAijNCqbC8xPEUNhoglWfD9waTXVNxZt/Eu/eRTGY3GX30bIvurWZOwA
         I8rcguzDldxrBNmAzJzo7aQC6OzCe3TRgaL8qh0r57IV4FjemOpGFzVofiXeGYPqx74n
         11nvjdns1GqlyFvs8z5w46dNj6MoWLOEIDeyk+5V8Mzvxj8TWH2LM+xrL5F1/RLbOado
         D/8A==
X-Gm-Message-State: AOJu0Yw3tzhtxJzhkQg99rzs7VcNP+U/9H9EHJIe/ZX0q3/Omg0mdU9X
	3WFd8mGAg4Ix5Zlq9j4S/+L+RefVVakiFvekrV6+sVb3sFyUmux0t5SI5uIuAA==
X-Gm-Gg: AY/fxX78nyi4D7ebaqFFvCMt63wdIwg4t9P8i88mmq5WlLBFgNGgSQXm+AB6lmUpAfq
	g3iZi/O0SiRD/r4s1cOdEU8UvA0BzPlwhVHbgNuF5qANodSQvKtltsM5YEicp1uqIRlSl+wCBoX
	iVJUBoKLe2hSRJO/6ZfAX1NxB060spXhF23IP0aLPVKZcQwEM6eYG+XyV2+i1uhAswCk/fDdd3/
	NTRhYGK/mEwHxR9fC150M7DmmCs7KBFo7J2GC158gIu6tgZdVdtV7+oPgmMlK9zdRx3QoVe1qyf
	E+byE6MHMjwH5xa0GqI4e42X/pQcqi93BObaRdUgclhZoJZ3BZJvgAeoMXxBJqUG5RA6H1z99w+
	/HhVksEYeee6sH0jB/iWUuJnU0b6rog5Uedz2RlrQIoozpn7Mgk8hrzQFXKgePbzy+WOmXycCL0
	pVimLFjjNLFUGfoQ==
X-Received: by 2002:ad4:5bef:0:b0:888:4938:49e6 with SMTP id 6a1803df08f44-8942ddc1868mr72770426d6.70.1768602376714;
        Fri, 16 Jan 2026 14:26:16 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab202sm320385585a.11.2026.01.16.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 14:26:16 -0800 (PST)
Message-Id: <e6b71af0cad3311a15a66b49f286beb0c4b8c335.1768602373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
References: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 22:26:09 +0000
Subject: [PATCH v3 1/5] sideband: mask control characters
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andreas Schwab <schwab@linux-m68k.org>,
    Ondrej Pohorelsky <opohorel@redhat.com>,
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The output of `git clone` is a vital component for understanding what
has happened when things go wrong. However, these logs are partially
under the control of the remote server (via the "sideband", which
typically contains what the remote `git pack-objects` process sends to
`stderr`), and is currently not sanitized by Git.

This makes Git susceptible to ANSI escape sequence injection (see
CWE-150, https://cwe.mitre.org/data/definitions/150.html), which allows
attackers to corrupt terminal state, to hide information, and even to
insert characters into the input buffer (i.e. as if the user had typed
those characters).

To plug this vulnerability, disallow any control character in the
sideband, replacing them instead with the common `^<letter/symbol>`
(e.g. `^[` for `\x1b`, `^A` for `\x01`).

There is likely a need for more fine-grained controls instead of using a
"heavy hammer" like this, which will be introduced subsequently.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sideband.c                          | 17 +++++++++++++++--
 t/t5409-colorize-remote-messages.sh | 12 ++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 02805573fa..3c74f3bdb7 100644
--- a/sideband.c
+++ b/sideband.c
@@ -65,6 +65,19 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
+static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
+{
+	strbuf_grow(dest, n);
+	for (; n && *src; src++, n--) {
+		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
+			strbuf_addch(dest, *src);
+		} else {
+			strbuf_addch(dest, '^');
+			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
+		}
+	}
+}
+
 /*
  * Optionally highlight one keyword in remote output if it appears at the start
  * of the line. This should be called for a single line only, which is
@@ -80,7 +93,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	int i;
 
 	if (!want_color_stderr(use_sideband_colors())) {
-		strbuf_add(dest, src, n);
+		strbuf_add_sanitized(dest, src, n);
 		return;
 	}
 
@@ -113,7 +126,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		}
 	}
 
-	strbuf_add(dest, src, n);
+	strbuf_add_sanitized(dest, src, n);
 }
 
 
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 516b22fd96..f4712f4161 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -99,4 +99,16 @@ test_expect_success 'fallback to color.ui' '
 	grep "<BOLD;RED>error<RESET>: error" decoded
 '
 
+test_expect_success 'disallow (color) control sequences in sideband' '
+	write_script .git/color-me-surprised <<-\EOF &&
+	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
+	test_commit need-at-least-one-commit &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
+	test_grep ! RED decoded
+'
+
 test_done
-- 
gitgitgadget

