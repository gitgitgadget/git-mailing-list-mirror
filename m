Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4A33EE
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793725; cv=none; b=pGazOUjwrqiqv2vWI6BxZOzbljAsKw9eE/2DUwSRhlvNJaAG3IEJ5exc1dV1GDBAeI6cc1h0wTN3lczNRdvlEN7DzBxDPKQF1KW1KQpnH1zp9NUED0lwsmWVPZ2r17++wn+FQBvEuEb+hVoloE+eoYc27DtzfmIijIUYwFYBg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793725; c=relaxed/simple;
	bh=otgcU1lATHEunXbgsXm69q3MnrEupIXRLZfF9DU3YAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eqJQN9Yp5pBXv5Is+/akcX+/AL3xT+67bk0tAAr4Lo2SNLYhh8rmqUTGmmnc/eKcx45SCuVLkezXW3NBW5sk29Iwiqv5KoDetWKdPfAMQpi/MngZZ8uDYEXKi56ekb3Et7IZv/75aDG0Q/eglpCOvgMiCQevfSGzxu9FdOoHlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF1Qdl30; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF1Qdl30"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4214f52b810so30360475e9.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717793722; x=1718398522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUj9pWV3CJ8m9aJXpvgM5FWbG4XhvaY8k+qRdX9PLQo=;
        b=VF1Qdl30Vqj6vOgi+LFiOl7goGWmPKsjK1zRZ41kNNy47ms9KyUqKmaZeqgOVwL/5f
         ECfaUXW9ZmWwK+peobNwbMIAUq5nh/zuSKea/e+OniJXBLU89es6D0LHGBS8aY5y8b2L
         B41fj5k4doi5zARqmQNYYcp3RFB2yDqVteojxhKlcAZYI/22WwMaK2TWDy5DGEOMIy5r
         9OO5Y9nsMGzvulvZOiuCYwg6EL5YJC8S8KHi14Z+Zfi5nnkZLnlpsLJKTLceGQzj+UqD
         vresDuvevBGmAcNUQHMcFDokMHT3abeCvB3Fh/PMsgHPxRMHS3uR3WfWV8iviIJUb+ph
         ZjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793722; x=1718398522;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUj9pWV3CJ8m9aJXpvgM5FWbG4XhvaY8k+qRdX9PLQo=;
        b=LS33umpjgPqLrUBblo3ADCEKoo/ogTjwh+8gS5Fi7eQGwJhhbS9pV1ycDNX08PTl8Z
         KqIi3lhZYqt318GR7POURQPKeCC6EqtOIPO4xiailShLg1g0jq8Dfe4krTX3NF+CTq1E
         ucVwhXkkDNxoQGX67PEqABEUIEuLeiQme5EZu+V2lwbY2/NJYhGdGy8Iuz1H6EUNeT/z
         eZTDDMvvsFoNr6q3cg9+2Ld+BDUbSGQ6Bgzu9+HRhq2+Sbl5D2Is5oU2bpWBC50I1y20
         u1V7rgctJH3cvj+nO1r+3KxFAsIYggtIYmS9IECPXwrHR4buNwDYInnAp1d8KP3G9hp4
         GLrg==
X-Gm-Message-State: AOJu0YwdPbDBB1pRr0Y2szbX0gcS2U8+OWylBODevKl5VG0+2dM/nlPD
	OItVlEKQbgN3QiF9kktWMpqWSkrOuTMjeozs56v8jmmk03VL9hV5kkSlYA==
X-Google-Smtp-Source: AGHT+IFIx6QXgMBhrvGIApKp9O3KeDKh6wE01yIVL646Ep8nZd1+/DAGDgoIdy/HIK7hNGS8Sku+Pg==
X-Received: by 2002:a05:600c:1d18:b0:41a:47db:290c with SMTP id 5b1f17b1804b1-421649eb9d6mr33691765e9.5.1717793722363;
        Fri, 07 Jun 2024 13:55:22 -0700 (PDT)
Received: from gmail.com (218.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29653sm4658941f8f.21.2024.06.07.13.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:55:21 -0700 (PDT)
Message-ID: <23bac6b9-1bb1-43fa-be49-c77711b0ece8@gmail.com>
Date: Fri, 7 Jun 2024 22:55:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 2/2] format-patch: assume --cover-letter for diff in
 multi-patch series
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
 <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
 <91014071-13f2-46d3-aae7-75c8ea036786@gmail.com>
In-Reply-To: <91014071-13f2-46d3-aae7-75c8ea036786@gmail.com>
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
index a252c8fbf1..1088c435e0 100755
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
