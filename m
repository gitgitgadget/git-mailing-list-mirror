Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8D13AD15
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308532; cv=none; b=SJPi1AY5Fr+XQwaJ0SvQb9usmGRHW1jy8cgv5kvQ443JqD/gKY3z8mQ1qdAX86ZM7Cd/44awK2EoBBWYgrkBFHOI7ZOJyvhljbMF2lfRp7zhgF1bK/hxlLm+AUG5MaflgPdsB2WLBGX/uYDkX6mIxVfwcttqAhQ+kP/aqmyNto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308532; c=relaxed/simple;
	bh=6EvzbT0ZwXyzqn26rJHk9SzoxP/hJiQdJpzmoErjKwM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dWwCEjOUAq5vWsm5VN73yr11jfQKmI8MXEW7w2f8MgA8Wb5GDzFHxfzW+VfEvJh+sjQU10bT2VbkZrbG5hfSIT4D4b1IkEhJAsk2skhJVKK/grsMEagFQTffJAFtlLf3V0goPDPX/mVSPP6g4I5DD/hhZEmMlSnfuzNnNrqIdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOtf444S; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOtf444S"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41881bce4b5so17400745e9.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308529; x=1713913329; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnRIMveJaHMSHtDNWkRV5TTqCFbIOfzyBizh9rp/a0c=;
        b=bOtf444SdY1t8Q6vdVKNOcwXycQZpYx5IsJQhAn4isZPPjkLgKwYZx2ofr94I7mDs9
         9uCe+YkkV38s9w2gRfd0/DKrypiEDsp4SFwFkC1HnrMgA0+HXER63p6zMjmtuDtnqjjN
         MGr5CSPS/PfAo8OQpI67XM2PxfeTSRGcgPAd6n+AYTEAvBWy4ZHXp5yZYzLOiDk7N9BB
         fYJWB6Z94B269MBl3ngMfVID0xThfy8fQgovPeSQOJbCumhOrolpy/5VczIgl/7YnN8w
         4YLvkPyDu3biDkZImQiujXL7KDE7hawCCs/hOe+PBaOiuWzt+VCfxsnmAlt5QOzTMqFF
         A2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308529; x=1713913329;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnRIMveJaHMSHtDNWkRV5TTqCFbIOfzyBizh9rp/a0c=;
        b=UBSS725hvswBU8uz1/QLQPn+B+j0Wyl7NLxM2IqtsjFOuO9u3ysdfa9tp7XL13Z93w
         kv9stjq7Y6i4gGSJ+tenhQ7vWfWuBAZbrsaXJ8KRn/Rxdzi5KUUufh9N9DQuZ+euUW+Z
         /tsBNi3OrjdPlAV0azdcmo9wEFKIPywSW1ZH82LPLcGRFBNKjsjuryR5eGJDrbAVXUTo
         oerpARkk9022JeAkH1sPnjv7KdHoxvheiO1pBzdfKICthmeZyTiWxLyHsS7jijYPEnZf
         E/YTjnqnjF7BzFraEVpDcEbdacQNUYVxmb6/2ouztd7ZQjaPlaNA0+HrJzPznnoxST1a
         kBXw==
X-Gm-Message-State: AOJu0Yzi5ja59UYAyReLAsXYgA0eTVJGpVpr8AnoZZqCZjNOsbh3+nYy
	HDj0Z/4UY/xPjDQcwgmKi4E/GyXjPOhehUpniGKtZkdgpT0vksezXo6VXQ==
X-Google-Smtp-Source: AGHT+IErcoyY2dWrl8Q3jm2cbDdqY+QG0ovN2QWvpg8OydStGWIscPTJoATafaXST6dit7dn+5AJ+A==
X-Received: by 2002:adf:f352:0:b0:343:81ea:c539 with SMTP id e18-20020adff352000000b0034381eac539mr11152342wrp.28.1713308528853;
        Tue, 16 Apr 2024 16:02:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b00347e1304639sm6062434wrr.48.2024.04.16.16.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:02:08 -0700 (PDT)
Message-Id: <911d4f2a0e51786c506d9dff3e88561362b108e4.1713308518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:57 +0000
Subject: [PATCH v5 8/8] SubmittingPatches: demonstrate using git-contacts with
 git-send-email
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 1700132a3a4..b616422197f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -418,6 +418,13 @@ trial merges of your topic to `next` and `seen`, you may have noticed
 work by others conflicting with your changes.  There is a good possibility
 that these people may know the area you are touching well.
 
+If you are using `send-email`, you can feed it the output of `git-contacts` like
+this:
+
+....
+	git send-email --cc-cmd='contrib/contacts/git-contacts' feature/*.patch
+....
+
 :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
 :git-ml: footnote:[The mailing list: git@vger.kernel.org]
 
-- 
gitgitgadget
