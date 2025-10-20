Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1532D061F
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984404; cv=none; b=WeeEu7UpbTrJGq8yiUFOKhtDbFRxkr4BIceGgnuFyYre9SeE4nV833uXtb2UA5T1ECNCNbVWEVXGXa1B++Cw+SzwFi+u5auSyX9ryHOEMzjEkP1MI0SRoQE7iRFKR/VT0SyAo4KSzjUnPh/JI2WHytvIYZ/suilOACBDaROxQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984404; c=relaxed/simple;
	bh=4uDFLG5za3M26CzNT+CKy8SBhlLYVoeTgUBzRbz/9bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdFTvdOgeSWnvdYz9RH+ySk7K+62k5E9IdA1inP4JkDLAHrmu9efvZdqNZBLfV4IK3g5gANa8Pd6IbX+8dvJRvHLM5weIfj6o7ri0GX7UGQOHjST3AXD8mzrBsk+kjU0VTuDwiKSJ00Yh+DdbEg10pcz2coET/S06hA3AHy+hZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwU/CvBp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwU/CvBp"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781206cce18so4758600b3a.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760984402; x=1761589202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9TVDcQVMEiRFwjvUsgR+McSehncg/cp2lxFKTsgcuc=;
        b=CwU/CvBp3Nm8YgVkJbnhVl+azkbICdVxgsMSTTrsYsEM1q7ee/lpy58KHbRg8X64zf
         yPPXVipi2QRIT3BAqZKvQ+BUwzpMQJiCi4VAP1o0tNCDOYIPg7zTC7ivBBOgMHBiiczz
         4qpCv24SUCz9pcdbVOdjZIfp/eiVQgHOu9sOasJQaDy8t0sbh2jOuUSQLwgvuoaQ5Cof
         aBg4LFOTy9dpm4t8DpLyI1PR48PUmWtVX/WiPzwKSpDZdsXdvFDnTHyYfuslNGVX5ofS
         FNZ3Zjrrb9iG26RmC/oSzpfEcoCX2ttod9ojqbrGteK6wvT5L/yu99FIVrqXSwCc+awv
         zOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984402; x=1761589202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9TVDcQVMEiRFwjvUsgR+McSehncg/cp2lxFKTsgcuc=;
        b=soa3wcVLv7fRBZ8CyTUAJJGhoShziYoLHtgqr3ntiyg0lKxadYpnuBybhINqgric5m
         TL5o0k10uAvpsLVgITbN1dicbNrr0HJHoOIHEDON35DPaVo4kkL9Co5M1bXOgmsdRrd2
         kTTDI0ILbQugPhC+zYYGoeZ/8bfp5BCZm3RTFcHYGXkh5sLqMCyjj7YfmKdRpKecSQl6
         58GQsY+tUVPW+5VevxrkqH3oAjiiPwrsgTDyLr1dUnQuXY9fyOUftXh6c0pUqi/lfqPF
         9HnbJB62R3S73n801cRp0YwNxSS8zwDZ3bxTJVAaYTju7YdIGyXZQizcSZHNTXL3rceF
         9+dA==
X-Gm-Message-State: AOJu0YyDmdhbF+awYecG6riDMA7AAy5CvXn3E/iDFuvyb067S0kwQrEp
	N0oVrGhg+xn1gH20i6R1ikEt8WRW+qZJDI1nJGjrlU+wD0tkNSqg1ltbD6MAfacc
X-Gm-Gg: ASbGnctPZkIYAVjR66eFsb7RqjXi8zYxjJrvHR7MH246cz/P17kLFky7jA0mWbIKI4R
	oU2wVN36j1dp3QTWz/FJhu0CZUgJDwMYc67kHgM15WieRIQgr1GaVwDs3k40VdbO1s+AkjjH4Xs
	glTEDPskjqekdV19/ce7elfZezIAjUgjF1aovTK4TAtgH6WlUlUpiZm05GQdCbC0Rst7+Zk1dbC
	v5BFo1tPgrYk4SLneGgk8+EeqC27VsJ6uXMFk7NwOO2q4S6uKxiXFT7R0Hc7VkRYsQ+Vjow3YJr
	xv6ZeiuanJ5ZcSb4WdyYbAt01T8rCO8iSOVVWAwndx7RYnkvlRfKQDvJ9bLr9gAHQ1DaHyxVakU
	iWMrMLUQAwENxLuLd2Pwm8ylTVeFt4StNrp1WRZPtPCxKOpgq/kK+EQ3FggD++40wUFKHHrf1C+
	+zBtPPdvEBJx97B9kH77n+VvB/fxnhvjLMTp0cNA==
X-Google-Smtp-Source: AGHT+IFk89AJ+wb0hvWmNwubepmaVv8cWNWE3NWMHCUPKKUSqQTYkRLFgMairdX2iTl2Xv7c35NlvQ==
X-Received: by 2002:a05:6a20:7347:b0:2ab:a456:9b09 with SMTP id adf61e73a8af0-334a78fddb3mr20018665637.15.1760984401670;
        Mon, 20 Oct 2025 11:20:01 -0700 (PDT)
Received: from localhost.localdomain ([177.118.183.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm8099382a12.10.2025.10.20.11.19.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Oct 2025 11:20:01 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 1/2] repo: factor out field printing to dedicated function
Date: Mon, 20 Oct 2025 13:19:46 -0300
Message-ID: <20251020181943.6314-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020181943.6314-1-lucasseikioshiro@gmail.com>
References: <20251020181943.6314-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the field printing in git-repo-info to a new function called
`print_field`, allowing it to be called by functions other than
`print_fields`.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..3b071e9a50 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -77,6 +77,24 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			struct strbuf *valbuf, struct strbuf *quotbuf)
+{
+	strbuf_reset(quotbuf);
+
+	switch (format) {
+	case FORMAT_KEYVALUE:
+		quote_c_style(valbuf->buf, quotbuf, NULL, 0);
+		printf("%s=%s\n", key, quotbuf->buf);
+		break;
+	case FORMAT_NUL_TERMINATED:
+		printf("%s\n%s%c", key, valbuf->buf, '\0');
+		break;
+	default:
+		BUG("not a valid output format: %d", format);
+	}
+}
+
 static int print_fields(int argc, const char **argv,
 			struct repository *repo,
 			enum output_format format)
@@ -97,21 +115,8 @@ static int print_fields(int argc, const char **argv,
 		}
 
 		strbuf_reset(&valbuf);
-		strbuf_reset(&quotbuf);
-
 		get_value(repo, &valbuf);
-
-		switch (format) {
-		case FORMAT_KEYVALUE:
-			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
-			printf("%s=%s\n", key, quotbuf.buf);
-			break;
-		case FORMAT_NUL_TERMINATED:
-			printf("%s\n%s%c", key, valbuf.buf, '\0');
-			break;
-		default:
-			BUG("not a valid output format: %d", format);
-		}
+		print_field(format, key, &valbuf, &quotbuf);
 	}
 
 	strbuf_release(&valbuf);
-- 
2.50.1 (Apple Git-155)

