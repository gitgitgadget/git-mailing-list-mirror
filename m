Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17552C8D1
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610487; cv=none; b=U2WXMw6/LwtuheVM7IW0s2qBwy3AipzmYF0dLgovF/6MNLzWVM4036ryOIHwO+H0XO+4kzBxSMUx6752KY1MqtJaz5tmXsNu1f0wsoBpJ0ylPUL8TFKPdoUOOubFeWqILcjM11gJgwQd6/nICvWdlqG+FnaLwWWzLYaGa5OKpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610487; c=relaxed/simple;
	bh=NV8d9hGsrhIkICDwniHZgHm0DCaBjxn8vtPppg1btHs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=DqJDPzuUYSQqQDkr7z2jV6zGsF06h03Ll0QVb0o46+Cr8G7Ytna/BdxEvDKIOQiOCZmhS/wq/f2sTgG1O/gbx/aRk15dApMVbGrcWLm80Sii8Ys53fVfdJ8KfUQM3kD2jX5wm9Gy1/MAF6zDVlBw9IB1lmp7y66w35AA4kn/WlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD10R/ir; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD10R/ir"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35dc36b107fso41532f8f.1
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717610483; x=1718215283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+y3Kkv8ujQKfYM4UQadMjGGH1D5jcGeGCBhORcg/9w=;
        b=XD10R/iry9gLZLMCLEM3RZr4e9d71Jg/zjRqurtcCI1yb2O5+PlOAVlp4980A+ryuB
         6QPgGpuLebaR9hEJglBHeqQQs5LZIm1adfZ7Mh6aUBtgUIdqgjSHcIj+NswEhfSJYr1/
         1dkLOBUBGf5DalEBkjLm9Vq684J61RvaKIJrjC9SGgF9GtoJgES/RYDLGXdDmOx2QVX0
         klCptWAZDG/l525YoJ+E1CpZCbze0QWpHOlLiBP4gJq8k6dku6XXxKaQ2K1iZXm1LGDJ
         YsFpbjvXQ1OkAzsTM+VSqWvQEqXzdT3R1YCVgU4q58VDIDUs4uXUKbg6ydm5oOB7/+fU
         x/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610483; x=1718215283;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+y3Kkv8ujQKfYM4UQadMjGGH1D5jcGeGCBhORcg/9w=;
        b=FOU5MAXn6gStE0wTfS6CQZaj04hMoy7Gr50Y8KOv48/ti3w+/pH6YKmE4FtCrVRasQ
         Wow0u0H58Z7WTPxj3rHh5req05Uh/i8kdHjRm8xSArWGxLt5ryBrnUYbvrcwrpuvth8q
         bGGU8+ALp9+GXLgRjUhM8OfdaajNZdMuwUHY/IkbWXvEcpREHKI2n4kvCbSEU3gmHjSD
         6iIMVvrbZT/RIzXx88zkMNPKIKueW+NPwzs3PzhL1sPVz3ybAyE/N+L56aCXzZuLPO1q
         vhF5RDDqqBynsyuJQZVv+OD7f6+GX31C0cAVLiXsdJguBiiQDxETcZoAf5Rx5gWOZGfO
         13TA==
X-Gm-Message-State: AOJu0Yz53rJwLFJB2MbL/CuARxfLNZ1ZEXC7iZN/UnSnZYj6icE0X/8w
	CiVyqOxsTviQau25vmTVz5jSITakgvr9CjifIvgnggc2wY1oGXOsMi/tFrv0
X-Google-Smtp-Source: AGHT+IFVPHHKYA8WXqmXV9rzRz48gmYo5pGVBb/0ki064THCZhbvhKHQmlydIAuJCLuumsGPtWSSQA==
X-Received: by 2002:a5d:6a0f:0:b0:34f:f540:bdbc with SMTP id ffacd0b85a97d-35e8ef09a6amr2606893f8f.38.1717610483147;
        Wed, 05 Jun 2024 11:01:23 -0700 (PDT)
Received: from gmail.com (19.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd03fae7csm15413211f8f.0.2024.06.05.11.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 11:01:22 -0700 (PDT)
Message-ID: <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
Date: Wed, 5 Jun 2024 20:01:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] format-patch: assume --cover-letter for diff in
 multi-patch series
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
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

This is a hopefully more curated version that better explains the
current situation and adds a couple of tests.

Thanks!


 builtin/log.c           | 2 ++
 t/t3206-range-diff.sh   | 6 ++++++
 t/t4014-format-patch.sh | 6 ++++++
 3 files changed, 14 insertions(+)

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
index 7b05bf3961..5af155805d 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -545,6 +545,12 @@ do
 	'
 done
 
+test_expect_success "format-patch --range-diff, implicit --cover-letter" '
+	git format-patch -v2 --range-diff=topic main..unmodified &&
+	test_when_finished "rm v2-000?-*" &&
+	test_grep "^Range-diff against v1:$" v2-0000-*
+'
+
 test_expect_success 'format-patch --range-diff as commentary' '
 	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
 	test_when_finished "rm 0001-*" &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ba85b582c5..c844fbfe47 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2492,6 +2492,12 @@ test_expect_success 'interdiff: solo-patch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'interdiff: multi-patch, implicit --cover-letter' '
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

