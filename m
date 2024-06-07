Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C61199222
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777836; cv=none; b=rtfMtHBoTJqCTbUWjLXgftP75ghasOofmjMpfXfVxX38Ywk7WWJ2nw4DKjRobdLfKptrnaaEH30Gi+h+Y1AvmImRVlq3XD/7AMc0vQlO1gJAH+m6viW6o+s8ha69af29Rm7Ec/U3mhduh43lXv2Z0O32N9GCUnuZ/7ayRk+K+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777836; c=relaxed/simple;
	bh=yCmJ7ZCK16aLQ+Q80yYQAtfP0wkjCSO8jpS4sMEugbM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zea6sj+oMMUUKFFuHLf65Xte/KBhwNar87bFoCwO+JeTWX85FBunb3Ir2fV98odKoqgzvKv4Q8qwXlr3hrrTkQaed5lPJsCfAvKPijbK2llFj2CzgEb9qn+92l9Fr/VTfCbsKq4um5OhQyNyJzWHFJMmcvRrOgHhiud+wHtFn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G85UJrbL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G85UJrbL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so24070255e9.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717777833; x=1718382633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnl2uf91JmNKof6pBpcQi+QoPKRhsPX1pvj9XIWifl8=;
        b=G85UJrbLl9qFaQyYdEEgxe5XQWRWT6NP4rGY7a0XPTpxor5cs5WjO35bbqJIzOrpQu
         n1K9F2GxmMvMH3446hs/NzuPy2G3oJE3vg2z+1zbQSeGeixLzQ6XC1pg0mnjV1EedEeH
         Oh7SlGIft2WCoU5UeS5WDbz7NSkJjP8fEEEqYkcqlDRkTys3ZQK+adrRGeIaGZfj1vuf
         C0aqTp0zobG608RUiu1qVsKIgVNLuDGVj6sJbkJQCZTn4LZNJuX4TNGfR5NhMN4bgkgf
         KrLYfMQsFxn6/ttbRTINd0R0vAmKFNHOeeNrX8Bjus0S/0PuBLE7RXV5HJwWG2Z5Lc/b
         WOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717777833; x=1718382633;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnl2uf91JmNKof6pBpcQi+QoPKRhsPX1pvj9XIWifl8=;
        b=hnVnE+UP2wcbtFqYmkvaWREFwT+GiKpszwUY5Di247pTq9Ho/MBjbh72IYZGgdDKn5
         S6Fg8TEhc8s2DFgAdqdaOEHAj1W2LOLgXgh5IQg8ylt2qo3y45716H0IimuD/BAVhrMy
         uIqS9NFOMuYndqR4hqXNG9SpI3SJN8BIX3Mffsyn+T60cYmwBnTiwt6lgaFCEISP8QQY
         F7bWAwsI/XuPzWNsUzIzYcQLKNfugo1cBoOwqRNPHtQQRpRPWm/32860woQdEe/Eu4IH
         Scw61FJVd9jDNGy29xCbcYDgCPo4t/ZIzRKUIqUM2AOJCje3ji5is1WZnuvbPCcVsJUB
         JVrA==
X-Gm-Message-State: AOJu0Yy2VElwTCB6OtbNbwZbR2IhCIKavyZHnQLYmurbVSC3dzIBJ/zE
	0/I5iFyJMaD2kKHdC8zMUKjopQidDxqTjf/E0y+bMJZGHeUdYylwS8XNgQ==
X-Google-Smtp-Source: AGHT+IGHy4OIhJOwMWbn7y6oSeY7Ax7HWxLpwiZ6qjx3/a5APKVnTTZo+BilUZYMLvxcOjBpJxEQlw==
X-Received: by 2002:a05:600c:1c24:b0:416:bc18:2a00 with SMTP id 5b1f17b1804b1-42164a3665emr29108085e9.38.1717777833046;
        Fri, 07 Jun 2024 09:30:33 -0700 (PDT)
Received: from gmail.com (200.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2d7935sm55879375e9.48.2024.06.07.09.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 09:30:32 -0700 (PDT)
Message-ID: <bbe775aa-1dae-4919-acdf-27051ea74076@gmail.com>
Date: Fri, 7 Jun 2024 18:30:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/2] format-patch: assume --cover-letter for diff in
 multi-patch series
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
 <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
In-Reply-To: <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When we deal with a multi-patch series in git-format-patch(1), if we see
`--interdiff` or `--range-diff` but no `--cover-letter`, we return with
an error, saying:

    fatal: --range-diff requires --cover-letter or single patch

or:

    fatal: --interdiff requires --cover-letter or single patch

This makes sense because the cover-letter is where we place the diff
from the previous version.

However, considering that `format-patch` generates a multi-patch as
needed, let's adopt a similar "cover as necessary" approach when using
`--interdiff` or `--range-diff`.

Therefore, relax the requirement for an explicit `--cover-letter` in a
multi-patch series when the user says `--iterdiff` or `--range-diff`.

Still, if only to return the error, respect "format.coverLetter=no" and
`--no-cover-letter`.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/log.c           |  2 ++
 t/t3206-range-diff.sh   | 14 ++++++++++++++
 t/t4014-format-patch.sh | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e9..d61cdbf304 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2255,6 +2255,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter == -1) {
 		if (config_cover_letter == COVER_AUTO)
 			cover_letter = (total > 1);
+		else if ((idiff_prev.nr || rdiff_prev) && (total > 1))
+			cover_letter = (config_cover_letter != COVER_OFF);
 		else
 			cover_letter = (config_cover_letter == COVER_ON);
 	}
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 7b05bf3961..a767c3520e 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -545,6 +545,20 @@ do
 	'
 done
 
+test_expect_success "--range-diff implies --cover-letter for multi-patch series" '
+	test_when_finished "rm -f v2-000?-*" &&
+	git format-patch -v2 --range-diff=topic main..unmodified &&
+	test_grep "^Range-diff against v1:$" v2-0000-cover-letter.patch
+'
+
+test_expect_success "explicit --no-cover-letter defeats implied --cover-letter" '
+	test_when_finished "rm -f v2-000?-*" &&
+	test_must_fail git format-patch --no-cover-letter \
+		-v2 --range-diff=topic main..unmodified &&
+	test_must_fail git -c format.coverLetter=no format-patch \
+		-v2 --range-diff=topic main..unmodified
+'
+
 test_expect_success 'format-patch --range-diff as commentary' '
 	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
 	test_when_finished "rm 0001-*" &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5fb5250df4..de9e8455b3 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2445,6 +2445,21 @@ test_expect_success 'interdiff: solo-patch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'interdiff: multi-patch, implicit --cover-letter' '
+	test_when_finished "rm -f v23-0*.patch" &&
+	git format-patch --interdiff=boop~2 -2 -v23 &&
+	test_grep "^Interdiff against v22:$" v23-0000-cover-letter.patch &&
+	test_cmp expect actual
+'
+
+test_expect_success 'interdiff: explicit --no-cover-letter defeats implied --cover-letter' '
+	test_when_finished "rm -f v23-0*.patch" &&
+	test_must_fail git format-patch --no-cover-letter \
+		--interdiff=boop~2 -2 -v23 &&
+	test_must_fail git -c format.coverLetter=no format-patch \
+		--interdiff=boop~2 -2 -v23
+'
+
 test_expect_success 'format-patch does not respect diff.noprefix' '
 	git -c diff.noprefix format-patch -1 --stdout >actual &&
 	grep "^--- a/blorp" actual
-- 
2.45.2.23.gd1e9f8561b
