Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E291917F3
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164275; cv=none; b=MdDJ43Shygye62fMYL0ZmWAo1C7PU20KUn1WgRVrVtEa38/j7N/72s6z2ttYnavq93uft5nrG+xjFlqLY+xWOu6k+7vrnOihWlWI9pmRuOM4CPeRypjtqZkfW2RGMF2PbTpV3m2QXfQ2KMYiN+iVmDVs5rwFgG61xJR/VML8VXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164275; c=relaxed/simple;
	bh=u/3s6SAwAXABIqzkuyobOBuaRbMSzIJib4Kl0CNkDtc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=K+1/6EGOZmoCjn75B67kTTfKt11fwSh+BCAvjD+cqzwjjA8oWsnFLHIVPcBM9CiGuqefCvrq6s+DmpWmmiPn/6zjTj1KCmjZzsePaGc8sMnUE8aSYicqDpNFnGFLxEFm9asoN+yx2th4rDrSukEv5ydQlQmwVUtTO5y/Vev7ykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja0sSUG/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja0sSUG/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so4779269a12.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164272; x=1724769072; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ziaimul1dth0OZKEpGx1K5h0ozE8XqEDv4gpJpj/9Ik=;
        b=ja0sSUG/vOclLUQePmI5piT/CP7YHCXq3ZiUECGDnsRlr5hzr+bXw4MSFelgGYPDBu
         +SRHFeHs1ysvxVZWcY+ZgRCeZ+5sAypwPG4gOUJchLxKTlVzDnSlKDoCHI1TK40zrHsA
         lrppQlsw4fCdYwyYhXbR0whvEojjSxvZFyW3peQe1B0IrPpLeJfJFMNF/T1F3VjNloAI
         YWYFLTIuKijSFWN/cfHBn0vjJuLq2GrY2UerTdKnVBQ6DkyjRBDhg4U0TzpPPJHO7Yzn
         ixX7po9kaRSFDCjxUrNpI2wFL/pl+i1jR6jSZ/F2pS5qoW7OxMbD7i+g2JfflmtYgumn
         Rw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164272; x=1724769072;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziaimul1dth0OZKEpGx1K5h0ozE8XqEDv4gpJpj/9Ik=;
        b=aZbfKRkbycWmLzytAI9DyE3gYewaTkv2zwn3d43qPuR6uJR7A6qBEBwIIw/29BeEDm
         gaefwZGggGQuWErHFf9UddfFEr+xhSdOJB3+q6EBejdO/4yxTvvMiukF5l4uEW1U7Xt0
         zIFfniN/n1bLB0dbqB0KHfLTs9opx1CoRJEtexWKg85GVCBa4vx2Q+psslxCnaZfNuPS
         suJbR+BSc4m2q7Ee4fPuL5FTT9bVIGAYwpU84zsMt4CwPELAIQtdWhfyzv/ik7imSX1d
         dYLlcS234oUDrLpUCvN3GG+/eeSjXgN+pNH7iSkmJ566Cc5Xinm9jdjsdMVuB95PqZJ/
         PYfQ==
X-Gm-Message-State: AOJu0YyqpEXmC0cBidocpC37oCd0NFYtQyCX22NpApWQOuKuGwBILgpl
	EvMq1sLurJIzcGDmelbjV8Cr3+eQ8xDRBWu6GD91OHLTecxdtR7XuqrxTA==
X-Google-Smtp-Source: AGHT+IGC/+XvQX6zj+pVufKjBpBCseL6+ni8UE7lpPL9cPgscV4Q0TcvZkqqsan93ylm7TMqXoxoiw==
X-Received: by 2002:a05:6402:5114:b0:5be:e94b:dc2b with SMTP id 4fb4d7f45d1cf-5bee94be4ffmr5459259a12.8.1724164271424;
        Tue, 20 Aug 2024 07:31:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7ed31sm7093978a12.67.2024.08.20.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:31:10 -0700 (PDT)
Message-Id: <pull.1775.git.1724164270.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 14:31:08 +0000
Subject: [PATCH 0/2] Update the win+VS build definition
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

These two patches have been in Git for Windows' fork for quite a while.

While the win+VS builds are not run in Git's CI builds, it is still a good
idea to upstream these changes.

Johannes Schindelin (2):
  ci: bump microsoft/setup-msbuild from v1 to v2
  ci(win+VS): download the vcpkg artifacts using a dedicated GitHub
    Action

 .github/workflows/main.yml | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)


base-commit: bb9c16bd4f1a9a00799e10c81ee6506cf468c0c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1775%2Fdscho%2Fwin%2BVS-updates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1775/dscho/win+VS-updates-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1775
-- 
gitgitgadget
