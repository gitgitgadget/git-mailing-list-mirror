Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512D15ECC4
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619267; cv=none; b=IvLrBvG+gyiksTY30DzKaxSD8HYssSXKXEaOp72MOYuALESgvmD5lWgprXVZiZ1FegN8z7ACUmoIaGfvnem4DSrLdQ/m47WPpbbwEcucecQtJYg858k52ztTQzQ7PxJM2sRU77BpTIUxMRR2KtMctZElh7opNHNaiTR/tjpwkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619267; c=relaxed/simple;
	bh=0HgAloaxvfDj0tJ3VCpDxWnv9J7PFgUQMBINxHeiBi0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XXD8uHPw5sQma3w247RTqlyGdIfcMXWs/97Fe90K731iz0RmyrV5vTRfhqc6dT2de66Jum/5A5dxAlWf9uurBSY/T+eS5SjhKmHZyGdC/Ja1YVhVKzpTHl6KRKbMQzUivSLAV3jubrTlwLbah0wkh407n6YnJ14deXNjSjp0FGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdYxYaNY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdYxYaNY"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42155143bb6so3070145e9.1
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717619263; x=1718224063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9HpWULQ5U/oLnRwGnHoTdoD+mPdiuYXoQ89apvFYJZM=;
        b=FdYxYaNYznhKCsYGyyVAQ5C1F0tBo/2xx2iI6ZlGdUxBeoxvWlkSYzrmtvuwx1dMUc
         3VCovgNZGoIuWftzJfSTmd2OBG01yDkbGZKWltN1rSbcZgaFfp8DjJjc45FQNgHRYGMd
         XI+TH/yvJGqOertBizmP/+LybpEAhCM76meAoFoH8W6lioc2Xznj0s5ROwqVP0qvyABJ
         6UOYaOUCDRwQHfaA9CJPa3EXcW3OmsAlsuPXBG1tunjmOuVpxnhMH5Cn/c8ISewFaW8f
         n3kFcTVzfhxlPQNyfh8vlJuUj5lGQphclQEWIntXZA0jjd+4YJ6Aa9pfgzQnk5eh4jZg
         TrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717619263; x=1718224063;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HpWULQ5U/oLnRwGnHoTdoD+mPdiuYXoQ89apvFYJZM=;
        b=U33vM/Dn4BHCCplklDlRRHE09Ys3HJ6uh1PDF4z0hJpjPvQHeOVkCQx9E85LubnT5P
         x0RZ3LYbVkeyKyrv13GmfxKQ6Vv2Nzvgq8GZnkU53HnDaSBmxVC4prFxfLOPOqTKUE6C
         sPWXhOyN1+Wr1iZFkP8wKAj08DRqQuKYh4qTJr1lN128igkF3Zd00aUN5snm/giln7qG
         lj2b5jSs7ZDWYHTpsJvNO/9KCxdTnjLs2rDHIwukhZT4ifl9ycl95XBX99dNgPJbalvy
         WSZcEYGoa1BKzIKPVR6NoK9Uj36DOt111xpbMcCNzEwoGn6WAo5GQcumpJse6xmQc/BL
         PzKg==
X-Gm-Message-State: AOJu0YwEQ/JRhUOyr4+b8RhxKXlA/8TACzmZ37bwVfKDZgCEzNm5IqjI
	9bexeGN220QBbDJdB+pYbWzc0SBu4znxUjUOV3gopQxzYNm0nxcpWrkyiw==
X-Google-Smtp-Source: AGHT+IHxkV3kpgPVHnnqNI+Gcnl+dM8NOAkGHkrBNP3KcFpMA7SvE6n2187smx9D5Q/bJq6tNwS06w==
X-Received: by 2002:a05:600c:4755:b0:41f:f592:2fa3 with SMTP id 5b1f17b1804b1-421562df560mr31391565e9.11.1717619263288;
        Wed, 05 Jun 2024 13:27:43 -0700 (PDT)
Received: from gmail.com (52.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215813c43esm32401235e9.42.2024.06.05.13.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 13:27:42 -0700 (PDT)
Message-ID: <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
Date: Wed, 5 Jun 2024 22:27:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] format-patch: assume --cover-letter for diff in
 multi-patch series
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
Content-Language: en-US
In-Reply-To: <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
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

Range-diff against v2:
1:  ff67f24022 ! 1:  8dc5f16d83 format-patch: assume --cover-letter for diff in multi-patch series
    @@ t/t3206-range-diff.sh: do
      done
      
     +test_expect_success "format-patch --range-diff, implicit --cover-letter" '
    ++	test_must_fail git format-patch --no-cover-letter \
    ++		-v2 --range-diff=topic main..unmodified &&
    ++	test_must_fail git -c format.coverLetter=no format-patch \
    ++		-v2 --range-diff=topic main..unmodified &&
     +	git format-patch -v2 --range-diff=topic main..unmodified &&
     +	test_when_finished "rm v2-000?-*" &&
    -+	test_grep "^Range-diff against v1:$" v2-0000-*
    ++	test_grep "^Range-diff against v1:$" v2-0000-cover-letter.patch
     +'
     +
      test_expect_success 'format-patch --range-diff as commentary' '
    @@ t/t4014-format-patch.sh: test_expect_success 'interdiff: solo-patch' '
      '
      
     +test_expect_success 'interdiff: multi-patch, implicit --cover-letter' '
    ++	test_must_fail git format-patch --no-cover-letter \
    ++		--interdiff=boop~2 -2 -v23 &&
    ++	test_must_fail git -c format.coverLetter=no format-patch \
    ++		--interdiff=boop~2 -2 -v23 &&
     +	git format-patch --interdiff=boop~2 -2 -v23 &&
     +	test_grep "^Interdiff against v22:$" v23-0000-cover-letter.patch &&
     +	test_cmp expect actual

 builtin/log.c           |  2 ++
 t/t3206-range-diff.sh   | 10 ++++++++++
 t/t4014-format-patch.sh | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index c8ce0c0d88..8032909d4f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2277,6 +2277,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter == -1) {
 		if (config_cover_letter == COVER_AUTO)
 			cover_letter = (total > 1);
+		else if ((idiff_prev.nr || rdiff_prev) && (total > 1))
+			cover_letter = (config_cover_letter != COVER_OFF);
 		else
 			cover_letter = (config_cover_letter == COVER_ON);
 	}
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 7b05bf3961..4a597466a2 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -545,6 +545,16 @@ do
 	'
 done
 
+test_expect_success "format-patch --range-diff, implicit --cover-letter" '
+	test_must_fail git format-patch --no-cover-letter \
+		-v2 --range-diff=topic main..unmodified &&
+	test_must_fail git -c format.coverLetter=no format-patch \
+		-v2 --range-diff=topic main..unmodified &&
+	git format-patch -v2 --range-diff=topic main..unmodified &&
+	test_when_finished "rm v2-000?-*" &&
+	test_grep "^Range-diff against v1:$" v2-0000-cover-letter.patch
+'
+
 test_expect_success 'format-patch --range-diff as commentary' '
 	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
 	test_when_finished "rm 0001-*" &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ba85b582c5..b96348eebd 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2492,6 +2492,16 @@ test_expect_success 'interdiff: solo-patch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'interdiff: multi-patch, implicit --cover-letter' '
+	test_must_fail git format-patch --no-cover-letter \
+		--interdiff=boop~2 -2 -v23 &&
+	test_must_fail git -c format.coverLetter=no format-patch \
+		--interdiff=boop~2 -2 -v23 &&
+	git format-patch --interdiff=boop~2 -2 -v23 &&
+	test_grep "^Interdiff against v22:$" v23-0000-cover-letter.patch &&
+	test_cmp expect actual
+'
+
 test_expect_success 'format-patch does not respect diff.noprefix' '
 	git -c diff.noprefix format-patch -1 --stdout >actual &&
 	grep "^--- a/blorp" actual
-- 
2.45.2.410.g52d620e86a
