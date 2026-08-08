Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15133B14B6
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219724; cv=none; b=Se2Ad1J3DATvZkiis5n5KbNPeSiDLx6fX+fNqBFUFno382/1aCU/tSdb9xHscTzHrC0mq87mOQQUBZsarpuZTIJs6GhpXJnMndGhWNJon0g5h2brqKzf40xLqkdGMFrdYDwVfQo9HQHyivAf8SA/6zvPrlFA/R9ZsE5U/Vt3U74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219724; c=relaxed/simple;
	bh=E7ToZUB3MW3M0T66A87XACfNQmtPikQZoRl7fXxvwo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQHPQ5QujwLIgOI2dGArqLg4AELIaUHpRTyqRHHCMyOlPuP8FP3xYrAnzMBZXOSEKohcECNGu9Nq7ei9k4CPH972magYTHM1gizwBUn6hQr5wbdrHc7eG/QziJ7Q3j22KiS0Qm5udpcAhZG2mpOogU0CFZ723EH1XwqjA2yBogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvVposLs; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvVposLs"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c999f162c9aso328359a12.3
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786219720; x=1786824520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E7ToZUB3MW3M0T66A87XACfNQmtPikQZoRl7fXxvwo8=;
        b=pvVposLsnOmvkgIYcqnjsBHGA25diPVBrCF7FfH/3POpfME8v5ksI31UV2yhg7fopr
         kqWuDC+JyoV8dTsvPzTECPCYppHLVFfLJVbaszKRvlyGBjUbQhS+EcTIvsBs44pnPn5L
         P8x6anLX72Ji1g3n1U0Ugkr7vdbC+WYXZXFZsQA+nl/M1TqR0xuvUIm7K2/JnidMyYdO
         5sUBimAOx+Jj5UmL3YVVucfusyjQfAorxcStHHzCuxyIdOBsKbM2NsaTsMtKWSGtZjw+
         d5E+DbZYgowa4yNYWkcDFRg5GMWTGHBWgnQXVCOEMxy0l3bvqLAJbZug0OC77EuRyTBI
         TE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219720; x=1786824520;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7ToZUB3MW3M0T66A87XACfNQmtPikQZoRl7fXxvwo8=;
        b=USJmsAG4X/rn9BDfuHWGk9xpuRGVDsc15no1RxwAwQpzAnE4IcUtgijamCMZoQcX5a
         JPk91rKajL+8421U1LWOisect4dc2FRk8hGxDKAhOnHPFKEa5QoqxwihwVjppL5j7sIR
         ssNVrt3IEgSOvbjHnv3D09fooFI/x9nQZ5cxW+UfBUCE+ihFr2YqOR8DLzdhr8taRAvI
         oWHO9pqls/dcPnRf7hJhZNfgmntyiiq2Mys/Ncuiv2YZGs8tOsLEuBWFvK+tCwabi7Sx
         ZXzcFWz4/W88G3Xr788lsXa2Ly+zabl07XZl7OzVMsOrNVDq/fWdwwMwXej9QnhzkHmy
         3unQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxE9Upv/B5p2v4YgQxYhMK8T6f4vjxUucE4yXpubGI7ofY26S9hgsN813y2t81w3C9Waw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOLVZc7kJIb8oK5ToaIQT+FR9d2XOTrfOXIb3xinl4fW+7HiD
	pLn2K7fp3EnLF6EQMruW32KMoIYF7VEV0a/hQ8YAmEC7TTq8vrEf9TJiiZPwYe1s
X-Gm-Gg: AR+sD13z8pHAeB/XgQhr78PuAUMgwwlSRLm8PzsJuF/oMXexH4EHBeSoOiGucJUBIbI
	uXaGDheqWBv/h0lBuhPFgylgN7BeE/m2CYwAfNmI9rCEB4l5qtMPqHW/oDWPobLIWvu4Do5biBC
	FvwpwU0dKPpiaKvzCTry7N/6cIZDSyNKspc5rWZyIMTGHzPlw9o2RzABHw1spjfZqUVmK+d+Kmg
	x5+uElqzHgal2hVYMk2ILW/YmZmFHxIwkmmhHeiMDa/vwdio8nrFqZPffWgLCi/bXUcgjgFrgPT
	s3U40CgaIe2hxljc2naloMIILQO0u//gBRroFOAhiF52T05rfggDWs+o0tppg8EFukLMmswLfOB
	5QvXWyP8ljbnKNopzbnQKQmSyxtIGL9hu7DqEdRTmfWxY2LgmvfepktjpsjvqyTdCcovRpTjBtL
	oxMsWNCVT7itjWX/Rr2qXGuAgY82t6KJh5Ww6CvLKhl8+D1zppSpZEjoSCpSmv4FNrzHidK0hzl
	kGjHfDzwq7foloxw49DwtYW
X-Received: by 2002:a05:6a20:4321:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3cb85e6689fmr34985802637.18.1786219720174;
        Sat, 08 Aug 2026 13:08:40 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c0a:12d1:b9ea:d631:a4bb:ce94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a9220sm24623442eec.7.2026.08.08.13.08.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 13:08:39 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: l.s.r@web.de
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH] object-name: avoid use-after-free in get_oid_with_context_1()
Date: Sun,  9 Aug 2026 01:38:28 +0530
Message-ID: <20260808200832.24313-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <506880fc-5557-46a1-b26d-63349781849b@web.de>
References: <20260807195941.99473-1-diy2903@gmail.com> <506880fc-5557-46a1-b26d-63349781849b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Original-patch-by even, no?

Yes, that's more accurate I guess. I'll update this in a v2.

Thanks for the review.

Shlok
