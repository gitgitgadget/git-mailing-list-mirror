Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F98181
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782929; cv=none; b=a+/BfDDVNNgFTvn27SNfIjAj4zQjs/nOby6QvwBUZr9gxV8bruQ3mYnzQHvNoZV8ZgvXVynPGlzykbEGaCqaxBdV9CcpS2NhMW517d55MmbpZnTLkgzwwaZRZxFokCO2RVJa9mmGwCnfGgyqZWWNvzOZJGK+OmalDqUHjwuu3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782929; c=relaxed/simple;
	bh=Nmntd0gmV9xulZ+kIsSFWIcPSAh3xkjD0dUBcaG8YRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSq/XYE/1gERupx7nyizLkSVLFxXuPzNLo0RejfOsDGTCvZlHNhv6oVlTpqWfaCKVyzoTdfKvotguwxfN3uqqrO0UrLyNQKQuwTbuLjZ0jwLFBXczcvwL4l6/NpPZp8n8+D436D8tPEqmR19dvuXO1733kStnHmFQ5LdlIeiIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCYpBsGh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCYpBsGh"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso3208004a12.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707782927; x=1708387727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPnFAli+NGABw4dGrQcWOE4QG6tlvS6O9f+m5O8+0FY=;
        b=fCYpBsGhWU7MLj+ExfuaeG/KRhR8tciVG9lLtC8dw++/bOc2ot4IvG+ftC5OOwgRhN
         ro/Id6KtWudaQWC/zs2xYdlYgrR7AKueslaiqcP6b7x9ACBbFqGszf9dS3CHfIhe7KZW
         kC15bTC/Uz+KFFyNK4JJgc1fQVId+8DZI271PMFHE1pI5U9yAm4+vZFyO8bcfK2iHi+Y
         nLfRe3IIFqZYpfHP2Ys2rw4AcY3nMiMhKOggUFQ/0EqulU7s4EPapOFvIkJWiAmXC53o
         AeoMSuRLVYuEVFZ3bl4VTyGeE8DSPut/Llk6lrgmLDPqyyHRF1MaLRpBIUnSCYpoEehC
         4NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707782927; x=1708387727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPnFAli+NGABw4dGrQcWOE4QG6tlvS6O9f+m5O8+0FY=;
        b=iqGnpB+uuii+kYzoN4+egIj+qFMrVCEbA5lpRcDSSNpD51HhonGMgy0wvqcQNXoooH
         Z6V9dSXrF2pPiCOJW1hUfUVG+/FLNiKi9DomuBBAdB17YY3qCZmq+exFKhCs7brZn03K
         tyuUCJocfqCtRiccI2q9km2BXz+kA3jWlVkoYqlBEvIGUn5Kar96sHssJZ8NcfwRwkdo
         BKhdVNdxHX2E9+6AIcr/fywKyfIwG6upFTVH7iz1Gnp9GQPvgPoOHkdUHz2LigfhQ6vB
         NvSZ3M7R7DKWrdI78EPT9qDtRXwnIN0+Qz2fvLLs24XEc3lRjYCs0Gn2tWoa1lyOpXVA
         1X7Q==
X-Gm-Message-State: AOJu0YwPM6QQJPk0fG46fNwn4ImRVzHev0iFYTODJSoFqRNVcZT43bfC
	03m2O72VCKH4szsZAh2hF/Lju7wl3i2dESX7ecebtj840rYxp/nkB57TxDsDz0g=
X-Google-Smtp-Source: AGHT+IFFCk9JzWJ9xf6dHlv1UDqH6QT3kNx+RJlzhkyT4/jOMr2AhWsHK9zGu73CslIcr4RxL+QbqA==
X-Received: by 2002:a17:90b:1013:b0:298:a351:855f with SMTP id gm19-20020a17090b101300b00298a351855fmr491013pjb.38.1707782927063;
        Mon, 12 Feb 2024 16:08:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXMdp7+H28rm1DxE5x1LiSfipR6MQbqAiVY0D/InqPK4lgsw72aPpW8TrtfE20l5OyYa58FmY/GkDgT9nYnQf1s0PPQUk8UG58IbsjkWalV6IMshPJPtHRoO3E7AKfywd6DdmikSkuty0JcKJVAOkFxFoRqpEj3tH/OVc4Hd+6jUJjWf1hFQJc
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090acb1500b00296b57ac914sm1097980pjt.38.2024.02.12.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:08:46 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v6 0/2] add-patch: classify '@' as a synonym for 'HEAD'
Date: Tue, 13 Feb 2024 05:35:27 +0530
Message-ID: <20240213000601.520731-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211202035.7196-2-shyamthakkar001@gmail.com>
References: <20240211202035.7196-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I just noticed after sending v5 that, in one of the tests, while
moving it inside the loop for also testing '@', set_and_save_state was
not used therefore the subsequent tests after the first $opt will not have
the changes for which we prove 'y' thereby making the tests useless.
(Although it would not fail regardless of this). This got unnoticed by
the previous reviews since v1 and me as well.

Apologies for the oversight and noise.

Ghanshyam Thakkar (2):
  add-patch: classify '@' as a synonym for 'HEAD'
  add -p tests: remove PERL prerequisites

 add-patch.c                    |  8 ------
 builtin/checkout.c             |  4 ++-
 builtin/reset.c                |  4 ++-
 t/t2016-checkout-patch.sh      | 46 +++++++++++++++++++---------------
 t/t2020-checkout-detach.sh     | 12 +++++++++
 t/t2024-checkout-dwim.sh       |  2 +-
 t/t2071-restore-patch.sh       | 46 ++++++++++++++++++----------------
 t/t3904-stash-patch.sh         |  6 -----
 t/t7105-reset-patch.sh         | 38 +++++++++++++++-------------
 t/t7106-reset-unborn-branch.sh |  2 +-
 t/t7514-commit-patch.sh        |  6 -----
 11 files changed, 92 insertions(+), 82 deletions(-)

change since v5:
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 0f597416d8..453872c8ba 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -29,6 +29,7 @@ test_expect_success PERL 'saying "n" does nothing' '
 for opt in "HEAD" "@" ""
 do
        test_expect_success PERL "git reset -p $opt" '
+               set_and_save_state dir/foo work work &&
                test_write_lines n y | git reset -p $opt >output &&
                verify_state dir/foo work head &&
                verify_saved_state bar &&

-- 
2.43.0

