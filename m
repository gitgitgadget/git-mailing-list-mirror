Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2671B960
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733645550; cv=none; b=Mfxt1Jc/TzDUayuXoyRG097qPd2Ou9d5mVqCFLVfG5f1TA39Wz4smteNVlueuVdzIC0IX6UNGkDKKOOE+F+NoHXpp22H2e07l6hEFuAyVCCwJe8cFmr3xN2IYneHlUQaIL/9u2lwgs/07ILGMPDG+pAWrjr3vkoJw1qb8btbXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733645550; c=relaxed/simple;
	bh=7+7rujhOquUS15p/BifQEefYMl/f58o/9k7GGREsCl4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VnaoiIDwalP2r+dvcFhm6z7aVkhKLc1VR+G1RY/X8WT08qxCHziFunLCgrzR0IM74u1Kct3SJy+x/dcvv1MA5RLVO7GMbldWh2owKsfluF3kTz7clehwu4LCb4gkDU2X8Y7GjjjuY8KseMfL7AVRTHMN4PIU1Zy58S3S1VYfBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvkycgcS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvkycgcS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a90fed23so22092685e9.1
        for <git@vger.kernel.org>; Sun, 08 Dec 2024 00:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733645547; x=1734250347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpwpcs+ryRwJIgEjxi5IvAb6h6sG1dquLLkXWwk8Hiw=;
        b=UvkycgcSIztMwNpeIbd1tJnZ4n/F5018W3tsoHcBW+EIFm8y+s0QFs5DMcLLNe8BB7
         baSB9uXQgMSbJaEXoj8bk4a3U/yFML9Ms8xCWHq/KKKvFQ+HQfSw8JaOtSUE2d3d8EWy
         Vct+x7SkLWmJqZJyoe16J10CTbN1j6bYK7q80aNXhhavYDr4yCqZSF/04MB3evs/A2zd
         DAu1/6uQhzGuZKGFdBlXh+5M7M31ZZPn6m6ORy10A1vkHyGW+BbVBLT9AgeZx2weKF93
         Fkpn1dy5L3/UURE+BoGgx9sPTGxOU/5GzxA9/+5cfVYPSQWJHuvBWYQ3PVTAwvtiEo55
         XdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733645547; x=1734250347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mpwpcs+ryRwJIgEjxi5IvAb6h6sG1dquLLkXWwk8Hiw=;
        b=AiGaSZRv8GS+qCGEvUYkQDKZWoaQTrCvuEcG39YXmi1ap4psfz8t9qDcVrprZ1laar
         OukEPYQK3gqZ2lt02y1qYlbg8R/SANhnnIK0pGjNppHiUhWCmGbt00Aznj2y3n2cdsgH
         g8MonylNtbUYz8X1BvP3shRWsEqjc0+kM2O1lF6Ymvd8ILcF4TrwMNexSuUBKfQOf3fM
         fDkt0jDouQCg3lZpbYx3PxRH6AJndUU2yua6pxMj+RL5L8KiPuqnK8Qc9gUdMZb1MdPD
         jsKql/y5bIIDGwDO45M7wDx6eqxKFBlp/9JfDhbRi3zB79TFLE8TVZiyEPUnlrL03TUK
         ftFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Ojxg11SqtQ4gnnrekk0CuaRvoJl8nURQpUcaTqQ8Izce2b+2DAEoev3NBwBye+BuBIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaR1obY6FXYwT0RXv9PzSaBAivdQwpiFJOp8w5VyuO81CVwmCj
	u4iQBd2EWFzkUxMbcVo7M43kp4juI6bVz3RQmjUM6c7R1vIIVL1+
X-Gm-Gg: ASbGncv9NPZB5tYb4hLUnygGeXYc3H3NcebuZJZsccfRvdJjWv9d2KZ4DoUkpHchAgN
	PRpKUIuJ1O7kJMS2sqvmHQ3gtJqlB4BFPxQDW9FzVPCt3QtpH6RUVu2NnU29ysjskLg3DubgKap
	J62WO2yGQa15p34vVndCr5UwnfGXjZgHLP2UwwJQS/3YKzTOZ2yP7RnbTHDyQQJ0Pf93baEdbZM
	YKkAt5xB5UL+VAi1lJM0RkRFRYkve2eso9zm/KM
X-Google-Smtp-Source: AGHT+IGHaK3Y7bktaig6AXspaCW0W+hd9ea4MZc7K0ZLyg9ATi6MrWDGhf+tdfSlviOWvfHD/TK2hQ==
X-Received: by 2002:a05:600c:198b:b0:434:a10f:52fa with SMTP id 5b1f17b1804b1-434dded657fmr59971255e9.32.1733645547081;
        Sun, 08 Dec 2024 00:12:27 -0800 (PST)
Received: from gmail.com ([88.14.46.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f4dfdcdfsm9246855e9.39.2024.12.08.00.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 00:12:26 -0800 (PST)
Message-ID: <ec2a47c1-9bfd-4c80-a495-22154e6c0d24@gmail.com>
Date: Sun, 8 Dec 2024 09:12:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] commit: use `advise_if_enabled()` in `read_graft_file()`
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
 <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
Content-Language: en-US
In-Reply-To: <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have a deprecation notice in `read_graft_file()` since f9f99b3f7d
(Deprecate support for .git/info/grafts, 2018-04-29).

This deprecation notice is shown using `advice_enabled()` plus
`advise()`.

Let's use the `advise_if_enabled()` API which combines the
functionality of both APIs and offers some advantages, such as:
standardizing the presentation of the help on how to disable the
advice.

The test we have in t6001 "show advice that grafts are deprecated"
does not need to be adjusted due to the changes in this step.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 commit.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index cc03a93036..8d92bc1044 100644
--- a/commit.c
+++ b/commit.c
@@ -267,16 +267,13 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
-	if (!no_graft_file_deprecated_advice &&
-	    advice_enabled(ADVICE_GRAFT_FILE_DEPRECATED))
-		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
-			 "and will be removed in a future Git version.\n"
-			 "\n"
-			 "Please use \"git replace --convert-graft-file\"\n"
-			 "to convert the grafts into replace refs.\n"
-			 "\n"
-			 "Turn this message off by running\n"
-			 "\"git config advice.graftFileDeprecated false\""));
+	if (!no_graft_file_deprecated_advice)
+		advise_if_enabled(ADVICE_GRAFT_FILE_DEPRECATED,
+			_("Support for <GIT_DIR>/info/grafts is deprecated\n"
+			  "and will be removed in a future Git version.\n"
+			  "\n"
+			  "Please use \"git replace --convert-graft-file\"\n"
+			  "to convert the grafts into replace refs.\n"));
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(&buf);
-- 
2.47.1.407.gf6b6eee3e5
