Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765161AAE01
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067923; cv=none; b=KltPEwoc7v6UhLBS6WYhEVdgWP5dPDm+5zjr78ZOgNpBKT0zC3DFXySSzvJrKksp7TtLWEv6jNn5gwUUBRBeUMfCJnoOkJ1yAI4xbbhQibhKCg0XiGSnR+wyYrDHMQYmjaY32vTysKJLpgNIANaznFahp5iqWH0Faxp0+26CNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067923; c=relaxed/simple;
	bh=4z/qYo9lkwA7XXx1E+RdaQr4SoUHIu5tWkjVhuDAMag=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=JB1Fk/keqh7oZlg7u43mOVGwO9pVnPAFEgPe3VbW5hblMsX51yDjaA5PF7As9s0FulpCXjsNqpiTdGThd+RmF9dLzL9634K4F/HBNKUADjwRkBmuBG7Y11RK8Vt1l/hhqDYMQczbdmAOAodjemhnik6tdL5rt5vmDg33Yg59nGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFUQ2ARf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFUQ2ARf"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so7408832a12.2
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726067919; x=1726672719; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg9X+dnn538s5OOieKbxupsz/UM2rJzKyhogJujuX1M=;
        b=eFUQ2ARf2xddKBinxiXOMe+V5nwYFu53suO2jFjnF/f3eDMeSu1uncU+eCLv81qsMb
         HfYDpepIJz4mOXPCA4QeIJB0xu9QzgdoRLez/XTvbpwQS5BGKqGuSZyYsm8vuYratj+1
         axPbaPuKhyMmgVDzEVrM5x+1yEqXSB0lY/OErUz/VSLEWvdVrqtIVFefw5Ox/NI4gUqz
         ie+Yp1OoAmCPkA21qstr/jtwD41pLFp2GPxqibX5qto5YcfqJSKVXJPtLbB8Nxssl7nl
         Qfazo+jMPNSt1u3ZwkiKC5ePt5OGBuOHmRl5YdFEdSaG9T99AblQZR6jxvGQrbDfCbYr
         yJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067919; x=1726672719;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qg9X+dnn538s5OOieKbxupsz/UM2rJzKyhogJujuX1M=;
        b=iyEvVlDeduzWaPsT0AaghbcqyjlVGRaq959cKhtKa3fCfNcUXqClltkw7/8gYzYYey
         3iZP3Dhstf5aV00gNsLNF+suzkd0EaQBPATMOikJ+vjZSqn0nTmJiieUvAK+HvwfMclt
         QoInyuB2GwUXF/P7s6/5JPrHi9N/NPLm2Lt8YxHCu1oPxVennnCyi/FbR25kuymDhjdw
         WSqi8PBfsUI0/WtAXIMFymIB4ZjpaZNnot5ul/5TNxfFmgiVIBQG6S/LgN5h2wNrzTwr
         wOy8ElYQZpDtGy9Iy9TCzcUDTYzJdPshKeMAX60sSbgUi6/2Pl8qtcepViJ8d0nFQ05H
         s73w==
X-Gm-Message-State: AOJu0YyQUo545NSsmc6NaIKeYzaha4ugXqpH3hPu89tXkrxaH0hNm31I
	FwGGotYs7DuLa0swZ1TaG86eATyQqbDC/hgAIX8zBx3hgk6P50jx1SpiQw==
X-Google-Smtp-Source: AGHT+IGKH58qaBUr9ZLgy8lPdnsIA9PUu/Hkx74nctvsqy5UKDY9AUDv8NpQH8NmQ44mpeLrsHxc4Q==
X-Received: by 2002:a17:907:96aa:b0:a8d:6921:e179 with SMTP id a640c23a62f3a-a8ffab84899mr441027466b.39.1726067918178;
        Wed, 11 Sep 2024 08:18:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5da53sm620603466b.209.2024.09.11.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:18:37 -0700 (PDT)
Message-Id: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 15:18:33 +0000
Subject: [PATCH 0/4] remote: branch setting fixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Han Jiang <jhcarl0814@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

This series fixes some rough edges when setting remote tracking branches
with "git remote set-branches" or "git remote add -t". Han Jiang reported
that if there is no fetch refspec set for a remote then "git remote
set-branches" silently fails. While investigating that I noticed that the
code does not check that the branch names are syntactically valid refnames
and so can create invalid refspecs. This series fixes both issues.

Phillip Wood (4):
  remote: fix set-branches when no branches are set
  remote: print an error if refspec cannot be removed
  remote add: use strvec to store tracking branches
  remote: check branch names

 builtin/remote.c  | 41 ++++++++++++++++++++++++++++++++---------
 t/t5505-remote.sh | 42 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 12 deletions(-)


base-commit: 4590f2e9412378c61eac95966709c78766d326ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1789%2Fphillipwood%2Fremote-set-branches-missing-fetch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1789/phillipwood/remote-set-branches-missing-fetch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1789
-- 
gitgitgadget
