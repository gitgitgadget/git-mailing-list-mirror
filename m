Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC97323E
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749353257; cv=none; b=EoUDMH4T7jOEuDKB+VyXpPXjVCtL/GUCHrJcgVce+EQRpc0rzMiIJ2XyFMTe5UtgxxhFbp4iukDfZUgijPt8/bUDiTCD7kJAhOznO/lAg1TKm6sAPg415qE+IvK+bkEzL47KnGTyuQ/qS3U1XgbjYMeVTfga7NNiYM+Bes8Uyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749353257; c=relaxed/simple;
	bh=sW7DWDWF6W8Q/AKciT8YZwpot6MPdrRQo0u7Xz+hQ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEhS76d2Fh8UxbDi4U60Rp4FVDBZh1c/GpY42JK1EWwoqcoCMsn2pWnI284E6ZCPo4k+4gmD7yySEuzgYlI4BnVrujn232xvWi8/HKC8LgqwkEUecGDvGjfqWyxv8gLDWY6bz/dN6+lvSw6E5Am/q5sCSO3igWWiPAkMR93w840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnbvjv+O; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnbvjv+O"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2345c60507bso23314455ad.0
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 20:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749353254; x=1749958054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7f0GrP4y/u6ixSdbaafjtkx12kXN5Yz70htCLRIKXM=;
        b=jnbvjv+OJaKsAw2kZrplMCHwSt4qgvyOB2LFLm+10Uunr9CTO/+UqD6MfKWWMg+JxC
         F1atqqsJt9t8MYYnUuNBqkYGQ80vW/KXCqnS04jTJuMzTtALeUWoIuY/VACsLR1OLKxB
         +8P6BONemCpA0xVokas6VDvzh3KNrObwlBECK0dO6rX9C/1JmVnWX985fPnhiiXPaED2
         Hq4ewFqbGlXndD/CwSvOC2JSbRBSevw1GTkqKPZQOCC4ENs8MxYxUsREflclOJskGuQA
         XDDNKjG/aynvk6I9W3EEvrhV+8e8TLZT2d/wQXICWBOU7z4IA89Y3R+TwbFKB+tuyuWn
         tCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749353254; x=1749958054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7f0GrP4y/u6ixSdbaafjtkx12kXN5Yz70htCLRIKXM=;
        b=ZU44MqXYVWSR7yUO4uDAaiOfbJEQ/sRYwv2kh8R8kP4ipTOhiCNbRsn77QEyjjMS2p
         8LeyUX/L6Rj4qTk/mT/PRqpIpfc0Ch918f5uUfSXYmEWliS8hVvXlO5OsVuTi7EwRWtD
         WRaPk+PCzgWZZzPf8ORl1a4E8ozOBUJhGAzdO+T2fbj+n11BhI3EKPTEiSyAPD7OZ6Me
         ASzzI66IyXkaoGvvjLin1IBd5+FjR12sQRGhYf1lRgk52MtlXgqLD5zw9KrOiTEdYqD2
         CLVOpIi8bkPSDWXsbiCjtJuFL9v+pXaPCP6dubmJ0PbN1F5dy83kM9ugCa/xEKo8qxa5
         /A5Q==
X-Gm-Message-State: AOJu0YzfntacQtIPXkvibKQlnAFUtK+QrIG2hMD95Du6OB/ACHWFeUtq
	wiy/J3faqzOjNCzDujHVpV6CoCIe/68PXDtm3q3Am796v1kJYHB2fs2A
X-Gm-Gg: ASbGncuSy0YVj68ISQ0BwpD8sKeYSLqrJzw46C6mujcNE0StY1JR/SuFm52ilvDGYvO
	TccEG3VyGj+YE+PRxRjnV0625vq/aMkxmjt+vta8T/AYcZH7eMImknkSz6FnZpPZYbmoFIOQOep
	8scTAFkc0lD0HFXxY3D3CACd7qKLDK3t0Cb+YomYXtVa2S7agPvrfYsaTcpM9z1z/w7btG1PP7c
	BCFWTaaxyI7Qx38Oo0CmBYGc15LgRbXvA3F3SEQ3OYJsmXDZGbI2hG6BlDmcf8Kd5FBrd+aiHPj
	3Qj1h+zuKTfh+Ve6N6v4FvYH/MSpcH2Drnpqaab7MbHp6aFb/zsggQBJxc1kJUI3k2CHKrWdMqg
	KVw==
X-Google-Smtp-Source: AGHT+IHZ3Wt4HLb+qIzzPJTF1/6QdCDCradpiAOAgDC+1wQmvFXD6GFecNCE71c2pb1tneH9bCzHHg==
X-Received: by 2002:a17:902:db10:b0:235:ef67:b5a0 with SMTP id d9443c01a7336-23601d977c9mr132510095ad.36.1749353254501;
        Sat, 07 Jun 2025 20:27:34 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405189sm33442095ad.148.2025.06.07.20.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 20:27:34 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v8 0/2] Avoid submodule overwritten and skip redundant active entries
Date: Sun,  8 Jun 2025 08:57:03 +0530
Message-ID: <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch i.e. prevent overwriting .gitmodules entry on path reuse
is exactly the same 

The second patch however i.e. 
skip redundant active entries when pattern covers path
has changed logic 
with the helper function being code maintainance because 
of the duplicated logic. I've tried to wrap it as much as 
possible to it's own core need without having to change it
unless the core way of submodules addition and active status
itself changes.

The CI was tested in which 
the only compiler error I found was 
osx-gcc
Which I suppose is already addressed,
apart from this all of the other tests 
ran successfully which includes the 
t7413 (prvious 9) and the new one.


K Jayatheerth (2):
  submodule: prevent overwriting .gitmodules entry on path reuse
  submodule: skip redundant active entries when pattern covers path

 builtin/submodule--helper.c    | 60 +++++++++++++++++++++++++++-------
 t/t7400-submodule-basic.sh     | 23 +++++++++++++
 t/t7413-submodule-is-active.sh | 15 +++++++++
 3 files changed, 87 insertions(+), 11 deletions(-)

-- 
2.49.GIT

