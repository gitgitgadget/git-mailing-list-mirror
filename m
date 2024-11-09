Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E389145A16
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144537; cv=none; b=rFS7/d5Ke3VN6RUsG29rucuITOB/JVyZXrLXiXjtT/aGZTGRwsdlBx2bki6biUFU8jlO+PbQ/MfgIs9Jl9r6nY6J6k7bsjrYPEXpn99HLA/To4ku63mkqsk24J2mvlsXW/fTGj3d80MmjNU6W4yd4f2ojTEXPOsad7HHOEtUlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144537; c=relaxed/simple;
	bh=yVR+AAcxjMvJ3baWLaEEmTGllwvQhxiYsjN3iQl6zZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAfHyzNahrni79GreM6UfSZ96sQIIGqnkySTlp8tIaO6FVzUWkHEa4lcbeS+vMR3E3zmv9Mm12d1T7OZa2ZOYxs+MZgs62zV2EgvvNZJhEVaAQZAriuEoZZm5+WGQY45wVbj9NnsIIZtpKIuPETzcROUa0TPyWQmsNh6waque9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4fL0KL2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4fL0KL2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca1b6a80aso34208735ad.2
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 01:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731144535; x=1731749335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtEXEZ56WLHh4ZSZZGtoRTfcuJXOWI3+hHHuG6LmYas=;
        b=O4fL0KL2iKRY9Atwb0t6uxwNaKfS4qxAh2/2iTHxdLDy2lL0zlGPWK9pQVm116rCjW
         Bq89nIIXOiBV/L6QfPM/2PELQ/+TZUQ6EXPsAY+M5UILJ/H/fN1iwdxAaAEttStlgSuv
         5tuCQt5ovACPLmaIlVwOQPNv+N17s6m867F+5fePOw5GUqe3SJqjo2oRZ8DlRLYM75MF
         dT/T/A1J4Ne6Dbizo3fsf8B9HhaWKkoWtP3BA9aiQOUB9JKj2AMOowDMEcuyTAvKwAV4
         /YvisjTPRzR048dl4ItrVOo2ge5s36VpMx/GaWgem9AxzNgDIWgNDGnJmVEReHUWZrM6
         ZOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731144535; x=1731749335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtEXEZ56WLHh4ZSZZGtoRTfcuJXOWI3+hHHuG6LmYas=;
        b=DpRwWkC60iuGeouE2xnbPveWOthYUmDhP7zHFczpbtAUElk4kJSdnfMMvPmBcwMiRG
         naM4hT49Q/1Fsj7B/1ivg65y803Wnx/zgmc9bhJGtOav8X/5RyNRvZu9zz9NvPi6wgP7
         IJ1CRUmhvD6DrYPlI6Lb/AVEn99l3kB4HLyosr8WpbYBENxz4/QuLJ86qNumqvWhiWsH
         ngSTGqDLhtZXrAMBBs9h5ujPjaYoHX4Hs13Cc++NNjFh3ZvybTo7OuYzQdPcZKZLJZXU
         29rAtqGSu+QzP33BRTPS0gWAt6bwaEr0wuxCaW9xutYNbw3IE3VTM8AFRuf0hvJ1Go3H
         i1NA==
X-Forwarded-Encrypted: i=1; AJvYcCUM55gcEghg103CJqD8Xh4IEwdi9JG46/ysDKbpmtDhI+ToVVEEALc6oBrm8618AYstCwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDetejmWyp2SJUp6yaUVkBvXhYzS/ZX1JfyEgNcU7Kpkc17iF
	0gF6O8XjpXll2EOZ4bMbct+OhkJgsO62Lp4u/VNzP66RT+FVg+hD
X-Google-Smtp-Source: AGHT+IE0/AAqOwZGCJluB6v5KYsRjqAZEmt6gSqqCmhmgUrAzZPhdt51+eWmD7BwywgCNhwVuyFduw==
X-Received: by 2002:a17:902:cf0b:b0:20c:6bff:fcae with SMTP id d9443c01a7336-21183c7e1bbmr66416345ad.5.1731144535446;
        Sat, 09 Nov 2024 01:28:55 -0800 (PST)
Received: from localhost.localdomain ([103.171.210.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41651sm43309455ad.134.2024.11.09.01.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 01:28:55 -0800 (PST)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: gitster@pobox.com
Cc: abhijeet.nkt@gmail.com,
	git@vger.kernel.org,
	me@ttaylorr.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: [PATCH v6 2/2] t5300: add test for 'show-index --object-format'
Date: Sat,  9 Nov 2024 14:57:39 +0530
Message-ID: <20241109092739.14276-3-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.47.0.107.g34b6ce9b30
In-Reply-To: <20241109092739.14276-1-abhijeet.nkt@gmail.com>
References: <xmqq4j4mv5o6.fsf@gitster.g>
 <20241109092739.14276-1-abhijeet.nkt@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 88a09a557c (builtin/show-index: provide options to determine hash
algo), the flag --object-format was added to show-index builtin as a way
to provide a hash algorithm explicitly. However, we do not have tests in
place for that functionality. Add them.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 t/t5300-pack-object.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 51fed26cc4..bb6a22b438 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -527,6 +527,20 @@ test_expect_success SHA1 'show-index works OK outside a repository' '
 	nongit git show-index <foo.idx
 '
 
+for hash in sha1 sha256
+do
+	test_expect_success 'show-index works OK outside a repository with hash algo passed in via --object-format' '
+		test_when_finished "rm -rf explicit-hash-$hash" &&
+		git init --object-format=$hash explicit-hash-$hash &&
+		test_commit -C explicit-hash-$hash one &&
+		git -C explicit-hash-$hash rev-parse one >in &&
+		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in &&
+		idx=$(echo explicit-hash-$hash/explicit-hash-$hash*.idx) &&
+		nongit git show-index --object-format=$hash <"$idx" >actual &&
+		test_line_count = 1 actual
+	'
+done
+
 test_expect_success !PTHREADS,!FAIL_PREREQS \
 	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
-- 
2.47.0.107.g34b6ce9b30

