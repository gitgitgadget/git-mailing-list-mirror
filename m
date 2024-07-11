Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2141A0737
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739504; cv=none; b=uN3T2+C12Qq9CimOuVhNumTH+9UtL5NwUvrQWOoKDWI2+lUHUxllKkgGgeD7kXrnzEmP+xdVQyfwOCrST4/Gp27Oid7opRp0DJTKMxUE1IEmdZSOz22Ed6aa+2ieNPKYRQk6HIaYajuA10MtjbhIs4RXd6bJeFvniuRcMOs5rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739504; c=relaxed/simple;
	bh=MIwsxKQCc6L1ypFrSWOoIhAUtc7BOba8IDgNM12CZxk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uPuCdXG/qKpem5qlX3a5UIhXRm0D871hoGRUFkYj2JEt4M9Hwgnapf0LAbrjfLfh/TOPjqONiDKc/doDK0aCUoV4qqNq7WfsySba4V3Sp3t2rPELui6hSQ+FkJQ36VQRMhO9gAbG33CbHIPjfFEZuCRHxdf+hVKrUCgfCU3BJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ouy2BSYt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouy2BSYt"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso12940101fa.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739499; x=1721344299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpbfQ6cIUNHUjgSnKnj7SnzmfwlwJBl0mHg3GxACDxI=;
        b=Ouy2BSYtyaCeszQBg6hzV8FOH+Pr2R39Lb3FUXQWJdyZiyUHCC31a7pZmuQdaSh8uW
         YmXye2cRusb6mP3DAlT12I4PoImlJ6bNeJfVf/xCW4+MfmJJ6uE8pQncDMZZT0dTuH37
         IlC5KmFkUeNHOobyMpxP3dH03x7XESeqzpDno3fLWRmRGmlPMhtW1pOESIRUAgVyqPw4
         pwZzSkXgP9QRETOoEKTNDXRZjAXUc0PnGGy69qRHQRnXpJpsjnkzxjJDwMMOAk+F1Pxk
         x49HbSVQuP6ifckPQD7g46C+Np25dAL7p6IEhueQ5sUdVRD7fFUy8YBHyg1cIDcy2O5F
         Pbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739499; x=1721344299;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpbfQ6cIUNHUjgSnKnj7SnzmfwlwJBl0mHg3GxACDxI=;
        b=Cm3MHQ5Mivkl8oybeinYOYJz/GiIOywYxNPHAiJIHItCKMAq7tC2QdcIlUYzN7SFap
         eITC1ghZ6eRqtnYvj5t/aiRSoElZk3klmiMlyzcjPE/Xig7US53niA0waU+Ru7KydTqL
         YQKLfBuFL6on5dfr6jVt689XRM4cMy2H+LX0wAf/r6qoztpTkzG48id45j65vvSGDbRY
         HmcEAaaVMjOzZMxqeoRpLQEbsz4k8HUj4Z1H4Sn6AuDiBjFHwYJRgwkx3um+cvsTu4Ag
         qaysa/OAFT7bcUABPBhaGgkVqfPeyKSfgNSua2kG1IuJs4BFXIpRY412Pn4l0ZbxASYI
         GWPw==
X-Gm-Message-State: AOJu0YwRMPg56aHTNSJNHA9N0EIDf8xH4IIdS7cIs9ltBdgRX/YHdIb4
	NDoezMvVYGW23+ma5oUS7Cxa07yt5lbC3G1/goFj4vbrHXh07Mf4aBj38Q==
X-Google-Smtp-Source: AGHT+IEr64iGWMRkOznB3n5fj0jowARfmYLuSmlpfZ4Ro0fke/mABjLzrJJgcegVLuOUkaJLPxxsJw==
X-Received: by 2002:a2e:8e92:0:b0:2ec:68d9:f3d2 with SMTP id 38308e7fff4ca-2eeb30dbdf9mr59700911fa.20.1720739499448;
        Thu, 11 Jul 2024 16:11:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25babbsm3381565e9.20.2024.07.11.16.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:11:39 -0700 (PDT)
Message-Id: <91ebccbc39f21fa73af8bc8c81af721f1ca201bd.1720739496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 23:11:31 +0000
Subject: [PATCH v2 2/7] strvec: declare the `strvec_push_nodup()` function
 globally
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function differs from `strvec_push()` in that it takes ownership of
the allocated string that is passed as second argument.

This is useful when appending elements to the string array that have
been freshly allocated and serve no further other purpose after that.

Without declaring this function globally, call sites would allocate the
memory, only to have `strvec_push()` duplicate the string, and then the
first copy would need to be released. Having this function globally
avoids that kind of unnecessary work.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strvec.c | 2 +-
 strvec.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/strvec.c b/strvec.c
index d4073ec9fa2..f712070f574 100644
--- a/strvec.c
+++ b/strvec.c
@@ -10,7 +10,7 @@ void strvec_init(struct strvec *array)
 	memcpy(array, &blank, sizeof(*array));
 }
 
-static void strvec_push_nodup(struct strvec *array, const char *value)
+void strvec_push_nodup(struct strvec *array, char *value)
 {
 	if (array->v == empty_strvec)
 		array->v = NULL;
diff --git a/strvec.h b/strvec.h
index 6c7e8b7d503..4b73c1f092e 100644
--- a/strvec.h
+++ b/strvec.h
@@ -46,6 +46,9 @@ void strvec_init(struct strvec *);
 /* Push a copy of a string onto the end of the array. */
 const char *strvec_push(struct strvec *, const char *);
 
+/* Push an allocated string onto the end of the array, taking ownership. */
+void strvec_push_nodup(struct strvec *array, char *value);
+
 /**
  * Format a string and push it onto the end of the array. This is a
  * convenience wrapper combining `strbuf_addf` and `strvec_push`.
-- 
gitgitgadget

