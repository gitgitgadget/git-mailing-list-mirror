Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5B267384
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892666; cv=none; b=XF19u2KWuF33/g0z5Tn1xl/biwCUODkxaXGjYf1EQOtsU9FsB4rMh+6LdIru/8epi23YsfREU7hFRerAMa0XWB4fMitDy83zbSbqpKL4hg3OIjbiPmlJ8ojSaIpL4dOjTo0nxu1kjPZQNTEqWUzwxEawUF5nvOBY5l+00aqBapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892666; c=relaxed/simple;
	bh=CZDIN2iNT+5J0K3ClvIWFNi8uzZqiggQO34mgSuOARc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBVGiZPxZCkRqxbiTWhsGX5Cs3yLK1fArzGAar5sG65ZlnM0uW/YCpWbmhHqwWZYvgUH5MWV9sf1mDLE8iLho0/3YZ0oZcx7l+cOZgz36QWI1pqz09zTv8q/BjXP9uR6VKf2Hi6vyNQ37/IdOO7ZSeic62KsYqfBufT7dUwgecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=FHqsmxOo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="FHqsmxOo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so34790365e9.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1739892663; x=1740497463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOjmoujGXrNSarW+M+IiCievIUP8NBhJv073C7H5pD0=;
        b=FHqsmxOofLVYLja6GedEBECPCu46lMPCiS/Ok3PCgpNceD0ww0nzYPAUmdOFDbN8fK
         9AEeMqR1nM7XuuilKbjnZ/xtD+xh0sf2OwkL54hNjvnsMNMRwA91whUx/UO2pl1VkiKC
         saBE9U7uN9oXvXLv+dTOYV9VZMFBWsnrnj/Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892663; x=1740497463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOjmoujGXrNSarW+M+IiCievIUP8NBhJv073C7H5pD0=;
        b=uH2W25ZXWlYDtb6x4+7hZ1OxaDzb2BJMCmKG7zCLcqLB46EUPZJ0n5Es3uR8zeiMLb
         PjCgi+qmZO4mA8TyP/UNkrXmpRT+VfhR7A0o9ONHS1GSGPGtGHOsUDaFpWrdXVjdAX++
         TDXattElhnJrrWEgTg6ftCfQGYv7FImv/naPGNACC7Ja5U01te2lZkS2DuOO9uBPFELo
         HPjHBicCinya4uoS1wWf/iPiFkTbtSYE+Ae4nDZDWvqs06mR0WCN+0cZv60QMQswjgCH
         AalNA3Tm9bm6I3h7VUvpcDdBsEXBGV83pLjIBASaQ1IvEu2T4RdBOkfKCLUVRNfIyfb2
         lyHA==
X-Forwarded-Encrypted: i=1; AJvYcCXhzSrxKAJwhwQcqYKV0eHencWh47yNKLByEUPyV2Ji7oKlTMd38bnPYnn1XHctJD2ZF+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+zvE+DsVF1C9hpk8rt4sUQu17VTKnrzvsqKaqwLhBEOi9XmC
	OPOz5mJWHaZDNNwU6p40rZQOuQ6lMLxTLm6SHvtOibyx3ZcfhI1zRqZpKuKAxA==
X-Gm-Gg: ASbGncvFTW7DPWEVGdnJctq27rYFM/zGvV8I/fSoqE1QSffgEzmPMihz17lC0yqEZhg
	k5nUQ0aB4H0/h01KyQlZ2+MsB1+gsB2hipRvQuJRk/OQ2YEZy68HFS+liGikR4iqNIeV49GjivN
	cFjj/5Hhcg4+RJ2F9HrlUsYPOvs0BJW6uBjBVrMMSbaaSohgUN8EcqzXANFZp42UnnuDfPicsXo
	KtogPXnIr105a5qaqplz45BOULXLmaUc7GKkqbTneo16lH+6A2fZPPTgQi3s7KiIqP6EakDS+1E
	qpdy1BFLj03+bKkE0QpT2fQC66+giRxYX2YzppUXv8Xf6nBzJcswcLKOVZQbvtx+6lJPGd/IW6t
	s70JBB81mjRA8SLjDYKs=
X-Google-Smtp-Source: AGHT+IHcX0AlglQ2R0E+bnnWK+8hY1ezOapLLfpzc2qJZUnmnTNQYtE8NTS+EARf9pvX36UZbLXYOw==
X-Received: by 2002:a05:600c:1d23:b0:434:feb1:adcf with SMTP id 5b1f17b1804b1-4396e75022emr92286075e9.25.1739892662817;
        Tue, 18 Feb 2025 07:31:02 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b0aa4e9sm115080455e9.16.2025.02.18.07.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 07:31:02 -0800 (PST)
Sender: Peter Oliver <mavit@mavit.org.uk>
From: Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 51IFV1eZ063560
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 15:31:01 GMT
Received: (from mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) id 51IFV1j7063559;
	Tue, 18 Feb 2025 15:31:01 GMT
To: gitster@pobox.com
Cc: ps@pks.im, git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: [PATCH v3 1/2] meson: bump minimum required Perl version to 5.26.0
Date: Tue, 18 Feb 2025 15:30:42 +0000
Message-ID: <20250218153043.63535-2-git@mavit.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218153043.63535-1-git@mavit.org.uk>
References: <Z5c4OzzHWOo30Hu6@pks.im>
 <20250218153043.63535-1-git@mavit.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) dropped support
for Perl versions older than 5.26.0. The Meson build system, which
has been developed in parallel to that commit, hasn't been bumped
accordingly and thus still requires Perl 5.8.1 or newer.

Fix this by requiring Perl 5.26.0 or newer with Meson.

Signed-off-by: Peter Oliver <git@mavit.org.uk>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0064eb64f5..f01d81b39f 100644
--- a/meson.build
+++ b/meson.build
@@ -755,7 +755,7 @@ endif
 
 # Note that we only set NO_PERL if the Perl features were disabled by the user.
 # It may not be set when we have found Perl, but only use it to run tests.
-perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required)
+perl = find_program('perl', version: '>=5.26.0', dirs: program_path, required: perl_required)
 perl_features_enabled = perl.found() and get_option('perl').allowed()
 if perl_features_enabled
   build_options_config.set('NO_PERL', '')
-- 
2.48.1

