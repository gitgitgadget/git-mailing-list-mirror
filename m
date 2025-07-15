Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9751285043
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605864; cv=none; b=eEDpfPM8JB5qkV5DjYTHBBmtiWK/6kC2+Z9Jt0KK/Z7TAbp+xy/NkGomD29+nXXCd37KCQC1uFClhmiDXN4H+kbPINGdoFYFLh/g7q+XyK8ttb/1vy/5d2UWFmddW1ZhzasNQCXEbgR+j5XLssuopiHHRGYNIXsAdFRhBy8XZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605864; c=relaxed/simple;
	bh=LrfDC4I0hlMEs33S/9XCqwWn34zBGlTqqPHcTsiD2I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpZlFwpOnnU8Yqo6W9s142Iv93jPCZg+dmkSEVrOgipoLySmybTZQxlBolH/Uff9y7rOl7f8UFqxuAr/u2nLLC8b32oBRmmtCxdXUTl9R4YdXEByg7Zf4GPBnNQri5Eb0jh1DxsvgwLqXsz01omUBRIdkr5V3q4Wd9bcb9/gQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ/BnEoJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ/BnEoJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fba9f962so180425b3a.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605861; x=1753210661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT0hW0PtF7A52mDrJuGrGU1Y6VMZUknhe+4iSxL0nLU=;
        b=AJ/BnEoJCNFCbp9g3mMxkKUvD4aj/khmhAPhQngSBGuzDsbtquEdWTPNiqBqWyXtWA
         7SJsk8hgIsnQV0JjruzmAJn0duHvqrWidOscxKr2CWeLu/ZsuqgHATf9E3x2tke3l3Oy
         gqf9gZSlu2NMTppxtoxd5vb0bF0kJe+9/6EdugfnNF6ZTkzyihkuEP2uSWQrBWblO/VB
         yHye7V/wR3xlQdWjU6gZB/x96Bo9lY9l7GEkMXIznzj6Iydj2SB61Czl9iivB7Os14Ke
         mWVyTMKcO781c+VnQqIENr5ksNbEhmBHgg8tgECxbxHm3zDNqS/7khSNkjMDLueT3iB9
         fSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605861; x=1753210661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT0hW0PtF7A52mDrJuGrGU1Y6VMZUknhe+4iSxL0nLU=;
        b=Qih1C3ED/cvyOADjJ1muyvl49vqXgu8hJfbU8BsyNufqu38ReV1TNw1N104tJlTdD6
         yFYRP6ZGeQl/2/uKZVcCA6yubR8pa5z1og03SJKE2EwA2ND4dyWMwmKGQjk7pNiT/G6Q
         23cWs8Nzf+v2sWNUuzl8Po9MuLgGu1Sa6Z4J20jNPJUVrXaAIhPW9M165+V6tX1HENRY
         UNQN8RRDptbKeWiBDeosftKuX/0B6+/Qc9vFaG+jI4pDKqnQpWNHM6p1hPM+mgbncWGq
         f/ZhwC49vYMK2q373QKNBby9zlvMxUsmN03qkJ4MOYt8ZwbNDv4Fpj5GdxK+C8z4cxsB
         GtWw==
X-Forwarded-Encrypted: i=1; AJvYcCVqfI8TB88SjR1uh01mECgPH7TzmQNnMfsAbFT7apqYJVNxrDTBft7Z3gf2qK55GhEAcoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWAKXdAL7+psUWn/Hz+axXSJlkhvFMcqTIs8LesPDRPp7sRrZ
	4M4itd291vdkpkyQR9rWG7ySsyZn3dT4KQATkqae1c0vYqv1wKjDBUT9
X-Gm-Gg: ASbGnctI7ALYpkneU++7ApvarbYHhOr4pxa+jrWIv2k2/L6iE2X/pu/8ho8nbwgK8Et
	xZZsZJDqEmsF9WIbqgcQkAVv0VhXOwPSwtTJ9j4fjrrwpHEsghHlDXSFMfaTKKICMXa6/oweLj0
	cqCO4TFe6jRjE1qInwJf2w8lw1XSIWh1dfInm7UtY6lZq0nDtrokIkbdkwfMSFITNTM9xcjthTr
	yPKd0TmZspxRmR3E8SjKpwrW6Wkd27OGSAySwGp8Wo6TVdIV83CHriDH3mqFcAZFelVk6cBTuAF
	bctDTQs9wKdEIq283kNZaB2/8DFvNT9lLJuhf0TcpMY1UpYPOR78a1TaGMeA56qghju+RyTQoTb
	pi91KOXvq4GMK1wLmwy6PzbPOXrgDqiOZfVw=
X-Google-Smtp-Source: AGHT+IGue2AyxLJK54+WThCNHkGc7F4tRusyhGGWbvJGFzr/+OHymXOWcjFwOOBSB7Cn8ucxX6BVDg==
X-Received: by 2002:a05:6a00:138b:b0:742:ae7e:7da1 with SMTP id d2e1a72fcca58-756ef194453mr480714b3a.0.1752605860957;
        Tue, 15 Jul 2025 11:57:40 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4aabdsm12317126b3a.124.2025.07.15.11.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:57:40 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v4 2/2] config: set comment_line_str to "#" when core.commentChar=auto
Date: Wed, 16 Jul 2025 00:27:01 +0530
Message-ID: <2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752602474.git.ayu.chandekar@gmail.com>
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20250715185701.NuJpDo51I1_7scYqYWYccgJtxjasso8mQLPF5s8hxtw@z>

If conflict comments already use a comment character that isn't "#", and
core.commentChar is set "auto", Git will ignore these lines during the
scan using ignored_log_message_bytes() and pick a new comment character
based on the rest of the message. The newly chosen character may be
different from the one used in the conflict comments and therefore,
these are no longer treated as comments and end up in the final commit
message.

For example, during a rebase if the user previously set
core.commentChar=% and then encounters a conflict, conflict comments
like "% Conflicts:" are generated. If the user subsequently sets
core.commentChar=auto before running `rebase --continue`, Git parses the
"auto" setting and begins scanning. It first uses the existing
'comment_line_str' (which is '%') to detect and ignore conflict comments
via ignored_log_message_bytes().

Then, Git scans the rest of the message (excluding conflict comments),
sees that none of the remaining lines start with '#' and decides to set
comment_line_str to '#'. Since the final commit character differs from
the one used in the conflict comments, those lines are no longer
considered comments and get included in the final commit message.

Set 'comment_line_str' to '#' when core.commentChar is set to 'auto' to
reset any previously set value.

While this does not solve the issue of conflict comment inclusion and
the user visible behaviour stays tha same, it standardizes the behaviour
of the code by always resetting 'comment_line_str' to '#' when
core.commentChar=auto is parsed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index eb60c293ab..bb75bdc65d 100644
--- a/config.c
+++ b/config.c
@@ -1537,9 +1537,11 @@ static int git_default_core_config(const char *var, const char *value,
 	    !strcmp(var, "core.commentstring")) {
 		if (!value)
 			return config_error_nonbool(var);
-		else if (!strcasecmp(value, "auto"))
+		else if (!strcasecmp(value, "auto")) {
 			auto_comment_line_char = 1;
-		else if (value[0]) {
+			FREE_AND_NULL(comment_line_str_to_free);
+			comment_line_str = "#";
+		} else if (value[0]) {
 			if (strchr(value, '\n'))
 				return error(_("%s cannot contain newline"), var);
 			comment_line_str = value;
-- 
2.49.0

