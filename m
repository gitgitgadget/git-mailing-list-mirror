Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114211509A0
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327412; cv=none; b=WkU6qE0Kza6n5ENgwAt5YG7layhJtZcvECn1WvnVEps5RFMyERLR+Em1KJ9BsmeZ2YryqhZgnV4uxpA8M4ed+QX7tR4jJy1HNV4HGZCenPwT95yWxOnypWKg10m9xLUxSF5ngl2f7DvoyQ0x3eMehik5eX7dIWjpYTDW91fYmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327412; c=relaxed/simple;
	bh=XNdC8dZtQ99iV00knh8tnpgtXSLD+78odp0lIDcrsTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nG+BzBVUcPH2oG4sflZ7Vz34yLVLk101dVs7bXDY8/naMbgS/FdwKXp1sHk+mQvxeElu0k4RF3fDrtf3mwkyzIC51NLkq03mRgSAQkjNzhA7MNJFvxXFU5yhSgQ+Z+InXI8PYELpV93Ts1gJ/E5JZm4kk1nTsE0dyjN+Oei2HrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3RB1QKg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3RB1QKg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso8290085e9.1
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759327409; x=1759932209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bASCUWs+BxsXuyIsWDEjmPpiONVWstbgdaRpdcyyMcI=;
        b=m3RB1QKg0yJGUrZ/iA8rs9X5oeqvy66lsTyRmfW8kUB/N4uMGl1sEhLBJ3dLEksWZu
         W5dgvz2yw+y8O0cDWGhx+eY8ckNllGg0P2lBSq3TFH6jw8G21nL3FWXH0wF87s8snl2Y
         HcTTMMZ4vYpy4XE5Dob8tbrRSDHhiAzAYzJjt6f5rYjRpQbVFtnELwwawaDCnqVkc55/
         UnF1ntk1WPMeG23+j+5mAUlP0ojifHg5LYLm6mlKTUcuTIwFcP05/gltNqmf7tbkq9KF
         nG9sBGbL5WoJohPMmPurGJ4EwGt7Xp38lXVKw5Gtl1ZnihuRGJtOjjzH5hT0Sm2tECpy
         KqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327409; x=1759932209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bASCUWs+BxsXuyIsWDEjmPpiONVWstbgdaRpdcyyMcI=;
        b=HQtoMChBHjiF35Tjx7hqMhNhPAyntcadZBEOupV2un5B3fOGLZiuIdVIEmr0Ch8Udh
         RZmAKK+YRB6FE6WWcf6Jgki6NSeLKlMOOwSnv/dI8rzl6QVkwbGsbV0Xqlt812RfxK9T
         EEeSdV0/40MEj5Dj6zDdXE9J/eZo6xBAtjT0ZBSnO8S9Bopl7hmNSGBvYLWwGsBNisXT
         fQGn1kgUDoX4hxOB0Jbq5mu1GVd8/ZDrO/zWDejLZw28IY6coe1MZQJ6u+3eGZRtyOVA
         mavxK8J+EKtdMLTkwiVrMUrLxxse2t/u842MO/6saINApKsTKcMyYYpN0TAc1+mPiSuL
         i0XQ==
X-Gm-Message-State: AOJu0Yy+VlTYDf9UHGIRLlIi7cyBqgZ3WZQ8y+37I4ZdHLQNqNlgE0Iy
	PLFaNFV1/Hl0IyKoTPM/mLWyo2mcb+OE0ZljYbZSzgmELHsMCOHgi51krUX8UpFh
X-Gm-Gg: ASbGnctG2gW0NlwRbPftdBkUGzdFLx9bknT2mPni1sNAGvN4Gf/sP49XAjArgJ+RUdg
	x15AWnetKjZteAMOwqsLiw2KlndDqOG7rmVgJCwrmK2HfsCPDOCKAaOjegu4R98zGWVg1MjiChC
	GDDiHHQCf1UhOd7kXzelpUuOba0uF42eikRoAVODot3acKDilbredViZT5ql0wpV1jtvfPdzZz6
	wn1+Zfn24Z4MZZy4V/aXZWJa+v0Wj3w25wsQEiwMlkViP/IAjXX2q7YG0Z9FMAYe8a+L/blPVuA
	x8I/9b+jQ19AzVbJfKJhuYl37e7bDfyvh/DrLd7mUQM5sdZH16wpB08eN+YhyGn3YdXqcdX1Y0h
	bjOjcRY6++6XD2/FCoZG4GOJ69sF4wG+33QkyPf5JUlKfdVqb8ihxlg+4AizA+l2fD7G17SNEYw
	==
X-Google-Smtp-Source: AGHT+IE3Lg5Umf/+/mBexMQuLUcbvlyCj8w3eWwfN9LrHOKEondcBELTEJdRY5L+azjVMDXsQT2GGQ==
X-Received: by 2002:a05:600c:c08d:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-46e58cea5b9mr54036045e9.16.1759327408563;
        Wed, 01 Oct 2025 07:03:28 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a029a0sm40057675e9.13.2025.10.01.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:03:27 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Rick Sanders <rick@sfconservancy.org>,
	Git at SFC <git@sfconservancy.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] SubmittingPatches: add section about AI
Date: Wed,  1 Oct 2025 16:02:50 +0200
Message-ID: <20251001140310.527097-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.ge34f015aea.dirty
In-Reply-To: <xmqqcyalm0mh.fsf@gitster.g>
References: <xmqqcyalm0mh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As more and more developer tools use AI, we are facing two main risks
related to AI generated content:

  - its situation regarding copyright and license is not clear,
    and:

  - more and more bad quality content could be submitted for review to
    the mailing list.

To mitigate both risks, let's add an "Use of Artificial Intelligence"
section to "Documentation/SubmittingPatches" with the goal of
discouraging its blind use to generate content that is submitted to
the project, while still allowing us to benefit from its help in some
innovative, useful and less risky ways.

Helped-by: Rick Sanders <rick@sfconservancy.org>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

---
This is inspired by the "AI guidelines" section we already have for
mentoring programs (like GSoC or Outreachy) in:

https://git.github.io/General-Application-Information/

which was discussed briefly in a PR
(https://github.com/git/git.github.io/pull/771)
and in a small thread on the mailing list
(https://lore.kernel.org/git/CAP8UFD37_qsTjM97GK2EOWHteqoUKdwxjKS-SU629H2LnbTTtA@mail.gmail.com/).

 Documentation/SubmittingPatches | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 86ca7f6a78..04191e2945 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -446,6 +446,34 @@ highlighted above.
 Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
 
+[[ai]]
+=== Use of Artificial Intelligence (AI)
+
+The Developer's Certificate of Origin requires contributors to certify
+that they know the origin of their contributions to the project and
+that they have the right to submit it under the project's license.
+It's not yet clear that this can be legally satisfied when submitting
+significant amount of content that has been generated by AI tools.
+
+Another issue with AI generated content is that AIs still often
+hallucinate or just produce bad code, commit messages, documentation
+or output, even when you point out their mistakes.
+
+To avoid these issues, we will reject anything that looks AI
+generated, that sounds overly formal or bloated, that looks like AI
+slop, that looks good on the surface but makes no sense, or that
+senders don’t understand or cannot explain.
+
+We strongly recommend using AI tools carefully and responsibly.
+
+Contributors would often benefit more from AI by using it to guide and
+help them step by step towards producing a solution by themselves
+rather than by asking for a full solution that they would then mostly
+copy-paste. They can also use AI to help with debugging, or with
+checking for obvious mistakes, things that can be improved, things
+that don’t match our style, guidelines or our feedback, before sending
+it to us.
+
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
 
-- 
2.51.0.195.ge34f015aea.dirty

