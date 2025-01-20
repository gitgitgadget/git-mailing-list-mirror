Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9D10F9
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389087; cv=none; b=XBwwrds1TWFLahwuqYpLtl+/KvBri/5QoPruEPAqLY0VyOKUctbfnR36mQVVEInnGyL+T2ci9tnolK3FcbRohLo7cKJUQIx8gBma5eeMUXLKeEWff6xflXz5A62paqNf1kmE8bUqCLG3aAT7RMuWYB72YqMwgtfANXREcqmPwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389087; c=relaxed/simple;
	bh=VU5s1Bgqx+4QblLO8be64WmcLZsuIH+UqpDBzs9LPQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrE9eJWaE83zy654tdraflyna03Fvrag05xzvDxn/JhhqSsVVoXjBzXkwHaWRA5st90BUEY5b1rTAz3hBZbBezQf2/TClJNVnLQpHOBKgG3NECJ4wmu42/U5RDVhyIeH5sW8bvFQAq1kg0xLo5Oz/950uAo77V/Y5FVCvsX67VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=d4YazMzw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="d4YazMzw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436a39e4891so31579775e9.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1737389083; x=1737993883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD01+Z/j8kUynkqyzW2DnzpN3ogXImWOGN49LgGeDkA=;
        b=d4YazMzwLUxsASoENfrq7MBKvr9kM0W9mHbfVrCTxP+akhc90G2/whe5dFRJyfEtXY
         yblGdYIqA5IWeyNlo7U9P+YkC1R/6RwhA/qVWCplo6oA0/9lMtDlmcM074NcdyZ6raa+
         yVo6obdLxLKGTLQ25TNFkUBnwY8+/EZNOWqDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737389083; x=1737993883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iD01+Z/j8kUynkqyzW2DnzpN3ogXImWOGN49LgGeDkA=;
        b=MXQd1izyzOqwep8uhjreKFZeuGp25Q0SO6pxHgDj2WWvRh0a8jXwrSVj9z2oo9YzFz
         Q2dPNpK47rBG+IC7I5F9ReVXqzyri9cQ9rC1YcTmuItJg82gizfrHTZm2SlLurw8fI5c
         +Z0ezMpvAppJBE8WKUfb9jqkn/BaSTM/Y1DcTdrqStdLvz3JX0vpRgzt/TiBKeX8FLV3
         7WgQ9IeMhHZVag1yv6uPYks/uawVoYT3gWlVhZx7h95Wx00VFvnbogOtGwLvyzZWGADU
         A6I9ct6beW1tGqhetM99YjDf1T54nXZxEbZoioi63EMewdYG+KmywUBYxfOxtl1srXNG
         q8kA==
X-Gm-Message-State: AOJu0YzeaWQL5DYd4azpoGFMPNgauG/E9ybTEXddrQqJyuccp0nnadiR
	o77dseNVbud0dbDTSdIcSHdV5ArlV7SHNRTPl//lbpCUaHULeveAMtEjawESRrhXE20o9bbzLIs
	=
X-Gm-Gg: ASbGncsXAsLuPeGD/MWAIHDvAlkxC5WvTdIiFyS4ndUa7dXP88ZODmi/fOtTlgTyglx
	obLrid4T/LXFZbYaQnxXVIIF8JzFA3c1OLRm0QzhTPRjPNQoNWc5k7QEZgwmPSTf3RW2D+elRrZ
	6/BrMgRHrAu9hQeXgaz4lgNUQka0O+oz727sr1NV+VlluBbMIv56jofv3HE0BEJuMTgf4druSpm
	+NQKOxcfs7vEmv2FMHZ+YIUwAPFqIwCA2IS2EOsCG5blKNWpDk8pUdNJnr88sfvr3fwFDXLKlvS
	MsgCx84BLTq7O2hGpM9pEgi8m8uaC1FUb/QQm/KSSDVQCTsRLd3+gCpQqS7jF2Xy0LM5iuJAiA=
	=
X-Google-Smtp-Source: AGHT+IFjVV82s9wGJ80KM1k97fB07BM9eKekQYFZ8yLkzAztWbl1rcVm89lpaybxIajChYSWkAkkGg==
X-Received: by 2002:a05:6000:e4a:b0:385:ed16:c91 with SMTP id ffacd0b85a97d-38bf566f3bemr10112608f8f.24.1737389082618;
        Mon, 20 Jan 2025 08:04:42 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753ca42sm200895935e9.35.2025.01.20.08.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 08:04:42 -0800 (PST)
Sender: Peter Oliver <mavit@mavit.org.uk>
From: Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 50KG4fBK121520
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 16:04:41 GMT
Received: (from mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) id 50KG4f62121518;
	Mon, 20 Jan 2025 16:04:41 GMT
To: git@vger.kernel.org
Cc: ps@pks.im, Peter Oliver <git@mavit.org.uk>
Subject: [PATCH 2/2] Fix Meson Perl version check
Date: Mon, 20 Jan 2025 16:03:01 +0000
Message-ID: <20250120160301.121245-2-git@mavit.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120160301.121245-1-git@mavit.org.uk>
References: <20250120160301.121245-1-git@mavit.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Command `perl --version` says, e.g., “This is perl 5, version 26,
subversion 0 (v5.26.0)”, which Meson interprets as version 26.

Signed-off-by: Peter Oliver <git@mavit.org.uk>
---
 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index f01d81b39f..bf129205ad 100644
--- a/meson.build
+++ b/meson.build
@@ -755,7 +755,11 @@ endif
 
 # Note that we only set NO_PERL if the Perl features were disabled by the user.
 # It may not be set when we have found Perl, but only use it to run tests.
-perl = find_program('perl', version: '>=5.26.0', dirs: program_path, required: perl_required)
+#
+# When checking here, it would be better to say,
+#   version: '>=5.26.0', version_argument: '-eprint "$^V"'
+# but that requires Meson 1.5.0, which at the time of writing is rather new.
+perl = find_program('perl', version: '>=26', dirs: program_path, required: perl_required)
 perl_features_enabled = perl.found() and get_option('perl').allowed()
 if perl_features_enabled
   build_options_config.set('NO_PERL', '')
-- 
2.48.1

