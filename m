Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CE158D7A
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699824; cv=none; b=YVfz3euEelNlPKfNjzuonO3NgmBF6hVl7q50iqrnfuUxdXDtU8Y7veuA+wDoIdmF9clwnIHSWd18fQCBbNpLw8fZBQo6/kdQ7M1t1oRVYROtkgHmVJPY2bbmwiuivUPUM2SHmOVXEK1Ro4CN7AwWBIlbz6ZTnbIMsmZpWVbr0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699824; c=relaxed/simple;
	bh=Q/vav+OXIO6b1yL8IdPsVVRPa2Pwaw4Ysqwzc/OfNos=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LN6AxMuK7TBnUbenQBUQgBWqL2nmS0bqFLKa5sGvSG2Nh2t5o/pJssUOvKW04t6ARmDE5z748f0flbaLZULe7D54QYQjYeGoMjIb44Ff3zhHW/VbaI1EyHkFn8TjczK0CKeOpy1vHqnPb/zx1+ZDMdhI/mnAZyotlqyuo7ziF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN6bSx0p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN6bSx0p"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-416a208d496so9292825e9.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699821; x=1713304621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZJ/1Z/ekxi+FA3GjXSC2OdJc+FvCkeYQzt915jLjfk=;
        b=LN6bSx0poAMoIs0apFa8PDwh62TRLQ+dBfqacx26d/XODKu9F0gTugPBBlsxUsKIAP
         v3uFhr/IDziQDX12i+GjZXGksEPbv8Lahe0dFyKx4LEjF8Xdlad5MkYwaA7xfHMUftbt
         eVq1qlbHCOBEINx9bJKdgFc41ruBh1b63iW0KoCHKN0Dq/NlstnERYiPnVscsbexTn1Q
         wqpq5Vg7Km/1lKZSZag19TCTzgaKqbSBkDlMbdrEP8eT6V4wvFLhWcB6MuUhW0UbXCEB
         mRDzErIOSFJrEGhsSmSKD3UiuHJH/lowvFX3MFqQHKSPmE7OILSavXAN8C3v3EZBm53h
         aO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699821; x=1713304621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZJ/1Z/ekxi+FA3GjXSC2OdJc+FvCkeYQzt915jLjfk=;
        b=cZMiAGYTOGEnVG+8x/2kJSu0c094oLPB5HP6dIfx8uzjPGWxJjBE2OmqcBMhf0Eygm
         gOo8+tXwli5nqg2A6iQ2aUmBREgmJvNKjvs9Hio3tcoXYkLuiEd4ZBwx1wCrwFxEN3HO
         MiPS6FTI2LaLPRO1uflGhWP5/lVtpePsYPTNv23Z6dcsSGEJzybGL2JrH1YKeZTp/wbu
         Ybz4vqfVvv+ypO65SnhsYHjjcJmrtY7rmXAiMsVstFjkTFCHq5JD4oQ1PQ6hk/gKevTi
         AOwtIU+gXngp37Dcrrm517MhYF5H/aKgwf/42VuVoDvlakWjR3dSSMkiFNk1Wg+PRkoe
         Z5CQ==
X-Gm-Message-State: AOJu0Yxr8KLNeNH8ijnCHYEq8mJEMugUsJBBgCiGK5wH/3nUZLtHQPg/
	F/zHa1++vnnE/xydC3aNkSQUTLwMypDt5PRJPkd2tGBDXf/DIopfa2xyYc0m
X-Google-Smtp-Source: AGHT+IHp3dTqgur/YdjZvIODpS8j5d2F1a4CQu02kqjatC5+Pygp4bONW7q3lKasqEj/9tyJtHkXXg==
X-Received: by 2002:a05:600c:d3:b0:416:3365:b9c7 with SMTP id u19-20020a05600c00d300b004163365b9c7mr656552wmm.13.1712699820847;
        Tue, 09 Apr 2024 14:57:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10-20020adffc4a000000b00343a66f6be4sm12367423wrs.24.2024.04.09.14.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:57:00 -0700 (PDT)
Message-Id: <ef26bdb75c51e780e13d2f1435c9d6b85e0d720d.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:51 +0000
Subject: [PATCH v3 4/8] SubmittingPatches: quote commands
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c1933c97cb7..8594a3dda36 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -403,7 +403,7 @@ Before sending any patches, please note that patches that may be
 security relevant should be submitted privately to the Git Security
 mailing list{security-ml}, instead of the public mailing list.
 
-Learn to use format-patch and send-email if possible.  These commands
+Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
-- 
gitgitgadget

