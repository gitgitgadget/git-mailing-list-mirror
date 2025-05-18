Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712A156C40
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553690; cv=none; b=SsFtKOpOdgD0SeOtH5m3JvRaMZyIxYUbuBiDes3wY6FdORQ3pVeHs/rxN9DulyuhjcBNbS0ZAXS8uoN/jZxsj9F4cErEitTR5TeRwxQtDCUJRCrD3ivRPGmDK+idPfWkqFK3TXAa4qSubz38LNT1awnnrGjjCj0oT0HpGTPZbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553690; c=relaxed/simple;
	bh=ZlYBiLF5i6IQSEBvePfdvhhc5ZlcBHzCUCy2y4qZrk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5Bbr2z6lNqUGqd0X70Sn1OyC4qn6G1zqCfxrCbJ1thudhQ9/zSuiVm/xIcXg1R+vuQ0366wG8kZtnHjhO+w83rpJwiqZh5qY2/EO8eZGHb/mG7r2YvZnm1DXdA/5odoiTTYOZIduQwM9fDR4KNv3FkL//e9P34ayYS+pfhu5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiIXSKRl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiIXSKRl"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so2872337a12.2
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747553688; x=1748158488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElxwHECmMhJf7y+DUrpk2gmbGEMKklDzMDV5M57jHqI=;
        b=QiIXSKRlKlt9cfql+UcJOML4+cfPc6et1qKuQBvHQcFG9fl5pRCvra1zSYvyeB48sI
         1BaqA73pqP99N4FLrJgppbKCVYgdZM2BW/E9nVacFnL+YnqNO8FJ99zdf06Eokejh+Os
         UtuYWAE/IepLAdf5yTYUcpOUmEtKggI26zEKPpZDHZvKBJWhkZpL6aPObzJVCo1gfUZ3
         u4XzsJEv1N0+lZJFShw1LmgHCoD8qOFQIBLewxZojVJ4cHXjr3oyQLSZkXsKLSSBb3cJ
         W14/xvlt/FnhcvJtzA7GJoz8T2IQn7twWy2ItG+jzH3rphIt+3a4mbbaPAzul5Cy9Jo1
         K6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747553688; x=1748158488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElxwHECmMhJf7y+DUrpk2gmbGEMKklDzMDV5M57jHqI=;
        b=hQ1q7Oll9+nuVn3zGh+b3BTHKHB1+uCNuwZtGLky4GSOTtxqcnYQsodLH1zoazA1b2
         67ALJbwiponN7Pv0juJFGenw9BSi9TOLh/cDmnM/tKYtAOh4ybahrjSdWnfvg51CV15b
         DsxBdbXTzpPD9sKCUFzxyiQg6V7CBTdkR12ttmio2Uui8QmWRN5e0ydpsWKZKBoBD0DN
         CjZPdqK8CtC+JSqhHVEfyP7kAUQ86QX4y9I1/77O5w616HWLFvhG/tA005/tm8HSpwYz
         Hea/8JsNFQdka4XxwYs2Csnc6NYhCdTPIPc4ROHeTv6fMjJinmeh+7e6GZzcNQwSgVzN
         Kbbg==
X-Gm-Message-State: AOJu0YyScYZD0yhQIGmFE5E9wHZe81vzGN5Bdv99gZaEb6kgvN2fo8Kb
	jrO/JDV12XL/F1R1PkRRqIGfqvpqprKZTVkrPs9Xp0Em7/l8m3YyaKIr
X-Gm-Gg: ASbGncuFt5dg98rIxy1I4iDVou7ezfjnC37n75PAKCDB2V11Qj71VROURnenOdRNDPo
	nKCn5sfQzkDuP49kG5Yjr//ZgQ80tPuSu10vDaUPDi28WOTME8IcQaXdXzYxrnknhAC/sPb3/z4
	zHu8pJ61IggW1hlbWeddBBQakdZwuWgC/Ycmvs068qpbKuPpNR8nSVTprI/r63p2gsw/WfXPMK0
	fSrnbGmNKX6NEj8yBFdlLM6tBFiLVh10Lo8fNl0P8NZ3HbNidYVzx8Mi+E3/mrXZcO8OF5VEXiX
	fwEF05u980MVEECGWS1m/tX5O3sgc1H11UERi3Rxr4/+26k5Eo71fFFMVw96mHvFqIA=
X-Google-Smtp-Source: AGHT+IFtdGL9aIzpCN5m2skNXU81GgqWl/uFS/smD/e4jz0LDQ21Yl5LJrNCwudu6FKUWXSIbMtrLg==
X-Received: by 2002:a17:903:2990:b0:22e:5df9:8f67 with SMTP id d9443c01a7336-231d4596da5mr143289685ad.34.1747553688336;
        Sun, 18 May 2025 00:34:48 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed897asm39847715ad.250.2025.05.18.00.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:34:47 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v3 0/3] Update MyFirstContribution.adoc to follow modern practices
Date: Sun, 18 May 2025 13:04:39 +0530
Message-ID: <20250518073442.72666-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <xmqqa57bqdxt.fsf@gitster.g>
References: <xmqqa57bqdxt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes are made to MyFirstContribution.adoc 
to make the tutorial follow modern git practices.

The tutorial codes actually help newbies like myself to actually know what is going on 
in the source code as the Git source code is vast.

Therefore these patches.

K Jayatheerth (3):
  docs: remove unused mentoring mailing list reference
  docs: clarify cmd_psuh signature and explain UNUSED macro
  docs: replace git_config to repo_config

 Documentation/MyFirstContribution.adoc | 55 +++++++++++++++-----------
 1 file changed, 33 insertions(+), 22 deletions(-)

-- 
2.49.GIT

