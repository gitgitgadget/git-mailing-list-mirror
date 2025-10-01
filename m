Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B402FC871
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331299; cv=none; b=AvqVUEhYksVfj4qYqwjoLTGWsZV6WrvMU0tNIuO/LieoZEJPEADzLduxPD0r/4xJb9oLItjJ1oO3ocWKuCbckDnt83fHlN7mc1lQ1ZDLtZgU0VONx+Sgh2yQlA5U0WREn7YJNQQ2nfsVbEhza9UlT5ZvRG4tdiZaJt1FZ8yVhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331299; c=relaxed/simple;
	bh=Ex4ws7Lvxq149Vm196R+H01ECv1DQxxJFFFQruKmV9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNEvFv2zvSPcdLCtSc+VYGDZ6ixLqsQ5Ow53YO/q6Qi6qqZ0D5Bialv5/26OUXP4ewcxUMRsZG2R+3DfAY+9zus2mJxaX5NaxvbzSMZshbK+F7krICbl7mgvwjkGVmmN819fCaE4CHIi2KSYjZ4iRKDf0TotVHvfWx0Rw2ywy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PHEulZ93; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PHEulZ93"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so109693065ad.2
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759331296; x=1759936096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BB9PKOQ8YH7cQB+vNIsMwwdjfTeeteVJFWOUhRdoy8g=;
        b=PHEulZ93nEuSPa4NDhFVY6GN3KEXwAMd1c9nrjBsiN37KLTF4Ko4+m2JhT8SQFUt2Z
         uGfM/bbH6GGD392PDLEp02dwM7vUvNV2iKlxizH13Lnr4VfCuXmTM9B8IdEEBDvQ/YGA
         US32nGHBggZwpcJKeeCENSkhVfPz6FC46sugXIPtEqEDR7ACkzwaW8YUJ7eC0VJEohtf
         i7ZjVnO1wjlLamltSlcIg0pNuKAmX/IFe8j7oYLQtqjkmXlanoH6xPWXyui52P9allJm
         FBZ7GI89EHXq26OQlxeaNuqv8QXsWm1Yn2wwrtK64x7uTu4fDF667ff0AJ32RgV22WeF
         Y/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331296; x=1759936096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BB9PKOQ8YH7cQB+vNIsMwwdjfTeeteVJFWOUhRdoy8g=;
        b=MURI6l0lZqOgOxq97TRxAlw61e+tUllxjyTibt26fyRZFSNOFdD6l94m5arak8ZlWP
         OjIIIxIJblJov4au/E7I4KhWhV/ScszlQWqjNvypdEj9+bhL2RGfnmghCtC2oO6GafXl
         AuY5l7m9BSRd5OpZB7vrMduKRTSga3YlWKR4fpAS4Nj9oH37kV0XI16RpCdw/cLmwQ1A
         PSmQr7n/1V1gfSFSjSrgKhPf3oboVb6XSLKv04PfTXynlE+Nxpfoqm7j5+SKBtG2n0K7
         G4CjhPqegskaaunjr+7Fmrrb+UY3LfKaQVAmHjHZo3Ny550795i/G3xgPnrp+GvLdUrS
         /ZYw==
X-Gm-Message-State: AOJu0Yy8W8eTFvfHWuh2zUzo11Thuu5jmFtYaQ/nSLhvjirw3AtMYhQZ
	pC9gVMOEttd2Z03t1JuPlvTXmqFHeIk8i3JgrQQlTcrAorxf9XbOvcmwW1WwejIJqVV3K2RpJVT
	L7AOo
X-Gm-Gg: ASbGncu9F7MpOW3oPDs5rP+WM6F71d9oV1c3RQRpQpimafLoDTSLHhUmvRm58cyLNAu
	iDCv3VLxXu1M6wKH6tujRLnLD+RgH9OTLOHMylrvDQ4kPiHOfCNDxVEeqXD8OrOmfS5GW7Nexol
	/0RxhDgqWp33Ir1lQIK2i+QYbFFeu2LPKEF86zd1+NeGD6eSZ2NN59JWwSjXoYCxlxV0hplrLm3
	mwBFWx9s2JnXYXDvAJEigsNiXSG0emoLCQAzlr31dqF/en7pmafLl2Fctebzky78Vp/NCtaw2xJ
	pYja60yPmZLRsJDlBXmdzfqGfD7Xwh5VOU2bLsE+KTKUgbrzXQbWrk0l+7BV+2PJXaCWxwO7r7X
	DEThjqeRBkdTgfv/OEaSrY53MjGaIB/JLhwpV5c2XwBQDgCOgRkrpdgaNcMRBjVAK4rdfPbYk3D
	G582leiOMzTSeduok=
X-Google-Smtp-Source: AGHT+IHloiWX/TEDDCgLmrd4pbka+2k++Y8Qf9Qn0R3uH8lQBlfY7KaOVl4XqynmqFFBqF3xxcn3lA==
X-Received: by 2002:a17:903:15ce:b0:264:70da:7a3b with SMTP id d9443c01a7336-28e7f441e97mr49719735ad.49.1759331296221;
        Wed, 01 Oct 2025 08:08:16 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821f8sm187106925ad.73.2025.10.01.08.08.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Oct 2025 08:08:15 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Han Young <hanyoung@protonmail.com>
Subject: [PATCH 0/1] files-backend: check symref name before update
Date: Wed,  1 Oct 2025 23:08:04 +0800
Message-ID: <20251001150805.9652-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Young <hanyoung@protonmail.com>

In the ref files backend, the symbolic reference name is not checked
before an update. This could cause reference and lock files to be created
outside the refs/ directory.

Below are the original bug report by Sigma:

  $ echo ref: refs/../HEAD > .git/HEAD
  $ git commit -m "test" --allow-empty
  fatal: cannot lock ref 'HEAD': Unable to create '/home/sigma/headtest/.git/refs/../HEAD.lock': File exists.

  Another git process seems to be running in this repository, e.g.
  an editor opened by 'git commit'. Please make sure all processes
  are terminated then try again. If it still fails, a git process
  may have crashed in this repository earlier:
  remove the file manually to continue.

In this case, while trying to update the symbolic reference refs/../HEAD,
the lock file conflicts with the ./git/HEAD.lock.

If the HEAD points to refs/../foo, a reference file named foo will be
created under ./git directory.

Han Young (1):
  files-backend: check symref name before update

 refs/files-backend.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.51.0.373.gaf4ee0e35.dirty

