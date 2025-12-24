Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6B8460
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568670; cv=none; b=bvj0hdiymFmnciuFD/4kNMVrqRXOeZYcM43uz7HUGOZQoIqhhe0Bv/uSYHJa9eUfvitrJx53XjyJxrB14QWnOc9Wi6n07vGpro6bEApxCycwwufii4PgeYEDYi1J1PY5/BM/+WSaHxjqSOVm4HUTiHfT2Yp8436b3satGlvz9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568670; c=relaxed/simple;
	bh=L/6dhl8ojT3j+X6GOijim8C1EVdPC4Q9BxqGTtp1NSQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XsAA0ea4D6s+BO4Vr9fgXfEtYuHXhOGczc/Fh151J95kiYnkYejUXCe7pGWbt2nkDDj9W++yM9tMRXaJ5MoD6gMpUCt+ylOxC7I2CR1JU5wFU/P9e3+RcZf+fo6jZmO4kWHsNGgs2Wu8wY8YaWWY2VyEJ6x0XmM3QCrMTviNpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaTejUV+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaTejUV+"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso5845595a12.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 01:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766568667; x=1767173467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNc1wZMYKyybnTIeJqXWLJT3xaq3Trpdb67+A7AsZHQ=;
        b=KaTejUV+/NjLdRcKprsYg56WWDLr3u06gB2sdGukcTCnyx/yZO9wPOxXLJ1McdWBMp
         h/HWumPg4tO4cKWLPYIqIkbyZT3Z0mUDNgn8PHmI7no3ewC5b1sVuoz8/LQzZ8Jl6Nsr
         q/6h+3VmDNxXfuE8+tTLSx6W44I3hTIGKVA2XkIzGXcYhLo334tF6/5MHJbFnVljvCij
         gEw/HWlbsM2/nUDCXr5RrtLLQGoDesD54nr3rpcnw2x50eTUYzJHu8njdlZspiFBjGU+
         q43UcpnO5aLQvh/gdg9xKueFRXqYJ3wXRhy6Q4cjRACHTgr4KsVL8pDLstFBMLkFNh8R
         9WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766568667; x=1767173467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNc1wZMYKyybnTIeJqXWLJT3xaq3Trpdb67+A7AsZHQ=;
        b=qcKZr7UKmG59rcjUXHBjUeZECVg3pCbewWMQdxgPglu6hOV5YPf2Tdziyc0uiy68jv
         rh0cOKWMChVMXM+8gTpfPAkxt/s56E3xInFrEBEij8GJX+BTu03YVBuOin/x3oAIotwA
         k5gHhS6Vh98dorulrHPc17weWIfGf/aVPk62DGWG556CrEFX390+7QgH/v2G7fAQGIsi
         kIFSd82HrRqR78HzvdagrKcvnV7Xz/Ji2ae+vhGQTVtVo+Ka/XOPu1ZA5/aizPopQjM8
         lBv36FLle8Hql2iVKrvqe0G4AH7MxlfLUuHQSBW1xntCOrWnycbEYJnjz02ciPHQ/NYn
         0Nqg==
X-Gm-Message-State: AOJu0YwrE5M6gfEfS4DrPs957rQ6DFl1+gvOUz/IhUoAwZT1Pf0IFlB6
	cf5AkU7l75MYfZVT8NC2LkXxDKCF6B7nQjRlXOraB0S5HhNLPgIfJP0Oe0fMellO
X-Gm-Gg: AY/fxX71Vm/+8g3GdYMGB5E2F2f0gTCC4EHQ4lmug5KlULNPjpRg1yuD/6zJmcvy2eI
	Fkbbp65VAEFxY1ItjcjMm7vYGWEZJkZBdoA2AflvPkA7mE1Sg6BLEISGTQ0of4YsxezqgWzaBa1
	gk0zgnMVpVZHuMqIYv8eKmkYFloarq/SgUPuUfVAmKj1JQjsWN4Lfmlos97fQ9kHqTwsdTxdrFo
	bqmQTAUFdSHm5WJfotkIbt8k37Aw6F0pNAVVWL0eyXrvtoiZY1mHunhFf8J9BC64Rg7kizu3Fk9
	i6/7VkZqb/boPGl9HkcPUeNwK2NuvOUsFxOvbjgQoqFknh7N052wZBQAcl4qKcJRbIplO6APbWK
	dFaDa5r3ZyrXUs61GnFEYIkswHPVnlrYxyMizXuwOVyqOldZMknzXkjBfY2IMSgik4/XfW1EgwP
	BEvqy56L/SmjLY
X-Google-Smtp-Source: AGHT+IEgUkKgBMW0VmIbTxZ11LY2yVD8JZ5twr9t+XhNTD78DjqRcHeDAMU9TaQbqEG/BQ3THc86Qw==
X-Received: by 2002:a05:7022:e04:b0:11b:d211:3a64 with SMTP id a92af1059eb24-1217213fb1fmr21287972c88.0.1766568667156;
        Wed, 24 Dec 2025 01:31:07 -0800 (PST)
Received: from [127.0.0.1] ([68.220.57.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm75025280c88.12.2025.12.24.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:31:06 -0800 (PST)
Message-Id: <pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
References: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 09:31:02 +0000
Subject: [PATCH v3 0/3] status: show default branch comparison when tracking non-default branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net

Harald Nordgren (3):
  status: show comparison with upstream default branch
  Simplify default branch comparison logic
  Use repo.settings.statusGoalBranch config for status comparison

 remote.c                 |  93 ++++++++++++
 t/t6040-tracking-info.sh | 317 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 410 insertions(+)


base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v3
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v2:

 1:  a3800aed18 = 1:  a3800aed18 status: show comparison with upstream default branch
 2:  417f2075fb = 2:  417f2075fb Simplify default branch comparison logic
 -:  ---------- > 3:  c9ec5d9610 Use repo.settings.statusGoalBranch config for status comparison

-- 
gitgitgadget
