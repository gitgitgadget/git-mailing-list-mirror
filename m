Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8D31A57E
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570715; cv=none; b=j9DQWiNRrEK3JH4h7huFjD1D/o2djgxZqjDSESA6PaO66LMq1CwGgmu1J96ne/mr8d8rjPD+Rv6GV1EMmeUNUiYeqo98JKHoPFtacTunfTEn5eZ6Nq6QIIv6whpTbV6eo1LvjxFgpGNidh+hZENdZVRZ3MfO13+kDG2WfDOFlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570715; c=relaxed/simple;
	bh=At1/Svq2Yi0nc+CCONz+TXyna2MMhEGmHRQLDwkPwic=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Sa6tSlYaV+RKBqFujdTbmx4Ao1rNhVLAE2fcqTQcLVTXOe9hE9bDRX2CzBPgynoC4NLG9zJPQOb1jKY5AP5tFOk8meEhPQj0AChQn/uOCH4SmwjxPVKnBrdGX9nMi+IWxv7vYZBX9f6vBq3ghdRISd6d/u1RY6bIvuvBDuiOF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoJxomaa; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoJxomaa"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42487ec747eso32348265ab.2
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570712; x=1759175512; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoiqsHfrzKTczLvwTrlXS/z94nduZIZMqlZcRTbrgVA=;
        b=HoJxomaaRgljQAFTt4ArGuH/4cV7/sZS/Ogq7g00/zz0nagp4sZD9NlvSY65ihnv7P
         sNZ6R3e0+EUmKlAI4B30eu93xWKHOsd5Oeyn7hqXxB1RG8y91zt4DfeA1B7TNIXbNzZh
         MrJyyKTr3oCqOnmzcaudks6HwNVH7HvqUhpfkwodmAjKwfP5liNYfH/iIRfx4JzAb01x
         hq68YB/S/Jc2Xa/dfmkkLAbM2OqewqvZ7mZ4EsA2Lmf54LlJU5KTKUq6QoeZFMsoL0bJ
         BAwauEAs0Ps1qzMJPQHF3NljOX0arMbe/jxgs2svRu97imiUalTiiLsvQVIlSrk9s04l
         brkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570712; x=1759175512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoiqsHfrzKTczLvwTrlXS/z94nduZIZMqlZcRTbrgVA=;
        b=VRrokuoNxhq7uRAhPvdf9+OxqcszMWwxYy31scasd09PiHjZ55F3D1oq9rk65cimMp
         LQmxeVWTMZBs5HeN/iGQ6wuexdEmRkFfsOri+vwZpMzJWpgW9rQ6hTRxp6mYNB85TuSe
         n+dvoLmsO3RmfhrhQDOiF38sxreMfL3yj0e5v59nYTM5eJNsTrAyU+4Pz1M2dFpfAS5Q
         YNdUBERiIbLvZZrkplGWe98NqsKg6t7Orhlm5QjvLW2lThnnQmncL0ggr8Op1lCJu4x7
         xT0PlFOwD29VfYb1VmqG0GLeZ0yruYBDNufERMkRE1LXpiFGpJabEx7FC3OROo+z0NeW
         n83A==
X-Gm-Message-State: AOJu0YzyeK5DbL2yJpvOaP8pX1sNSD5XCYEYSFNbxVA8q3vcHMd1CPcL
	T67nuruRXCLPZ4DfWkEw8DZ8Bq+EolnxbBU0B9/qmKy5Nmg77H8wUPuo2oqE2w==
X-Gm-Gg: ASbGncuKIExDlX5WQv7MarUvmupwH4wUjW5LV4EjjViyyb6bx5TCGlzKXuPmjitnoYC
	c5O5RoJ69UtqAOGpc1hkQTLl09mkwBWKunyfHHVKFMPCoLFhHCfvPuz77O9sd0sMXpFQEwF+lA3
	X5gzazIk//ReGjblgnHl3aXR8JVifGRhTXdbVCcJGirCvpg5stlat8UAP1R6o3dHFh/li2L1HCv
	JpJnPDsEBBfTQldUtuT71W/6h4sny+46HrwQRmPqalZBPcTIDopxnM+hS+4/sa2I10JajFJQa9W
	btopE3tTJxq3JBMRdZiAvF1mf+GocM6RB+4R/3MlLd1+12vWfUnRswZ9uQrkiZi7+RRlRs1TqBd
	Z/z9nhCWgYQJuBPpo7K38pi8kBA==
X-Google-Smtp-Source: AGHT+IG06noqqChB+b+6MX1Lk1EdHOeNoUxQjyFkX15HdxY46FSASXkM3MjMqk69t+7MOO5pAo0ugw==
X-Received: by 2002:a05:6e02:2706:b0:424:80f2:29b with SMTP id e9e14a558f8ab-42581e060bbmr2644805ab.4.1758570712027;
        Mon, 22 Sep 2025 12:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d54137b65sm6147211173.64.2025.09.22.12.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:51 -0700 (PDT)
Message-Id: <d84658ac83e529ecc6e72a54bd3831dfe1b46f89.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:34 +0000
Subject: [PATCH v4 05/12] xdiff: delete superfluous local variables that alias
 fields in xrecord_t
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Use the type xrecord_t as the local variable for the functions in the
file xdiff/xemit.c.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 40fc8154f3..2161ac3cd0 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -23,12 +23,11 @@
 #include "xinclude.h"
 
 
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
-	long size, psize = strlen(pre);
-	char const *rec = xdf->recs[ri]->ptr;
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
+{
+	xrecord_t *rec = xdf->recs[ri];
 
-	size = xdf->recs[ri]->size;
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0)
+	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
 		return -1;
 
 	return 0;
@@ -111,11 +110,11 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec = xdf->recs[ri]->ptr;
-	long len = xdf->recs[ri]->size;
+	xrecord_t *rec = xdf->recs[ri];
+
 	if (!xecfg->find_func)
-		return def_ff(rec, len, buf, sz);
-	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+		return def_ff(rec->ptr, rec->size, buf, sz);
+	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
@@ -151,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec = xdf->recs[ri]->ptr;
-	long len = xdf->recs[ri]->size;
+	xrecord_t *rec = xdf->recs[ri];
+	long i = 0;
 
-	while (len > 0 && XDL_ISSPACE(*rec)) {
-		rec++;
-		len--;
-	}
-	return !len;
+	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
+
+	return i == rec->size;
 }
 
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
-- 
gitgitgadget

