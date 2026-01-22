Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6F3904EA
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109880; cv=none; b=NwW8BRZ3tVc3a5r3f2oiySoi9JdG9fQSoZLTfiZH74l5CU4DugOih9BEt0iRLRVVredxJeju+bvdcciW5+Cr8WlQ2DuBC5j2rHNED3TY4RngtIBm5nxBjKgfcXLVdTclfYlu1em2xzBfHeBIJBHtog0jHOpA+aWKNmZnCIFgvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109880; c=relaxed/simple;
	bh=YEXVfmycQ40KKJj1MbYCBRn5B1r8Q/VjiiLUyrVoSyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tf76DVGJiLKtFdr2Q8xjpKStfE5My8ZS44haeASulIjblc1g1UVh2wJuvAf+73+XDhix0cjQe8/nPBWyDNn+Dz7/WFzAf6db6ddknRRImkF2D/avBJfcT+QJeAlQo3e77CumGDs3Vgcdd+VP0GZTKsUM7pe6kuxfvXipDoQ4P/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl3d8B9V; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl3d8B9V"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-382fe06a9c4so10526061fa.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 11:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769109872; x=1769714672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TtuwgqEfRqn3xv+T+isTYS4SC8rvWMPwMzBOCTejnk=;
        b=Pl3d8B9VT4smeMdG56WR34vjVjfX+4kFtpMwegVty0/as1SmWtBfpfF66VLRLkBqWI
         eYAAfISXL+MzhLKxYMFmrsUdTPBmtfBP4pUvIuo1XHcgsFIVyN3iW7TF3APMw6hLdR+L
         MSanGtCo/6zBwXG6S2OdQ1BRMUuP2kZLFEtwl/RjYrBu7f5oV4NWHUzS+8kj0h6tDWk8
         L2/ikzEyuYWtLyucyiHTyt5NEYDDH5sYA7BchmJOYpUANvgO1eYMCMIkpb1IAd03EGGi
         DAJzR3UDTmTVEY098FzWV/qFleoVvMOUWT8tEAsc0Y+i9pz15hzdlYrzeejroEMZ8nmI
         0hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109872; x=1769714672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+TtuwgqEfRqn3xv+T+isTYS4SC8rvWMPwMzBOCTejnk=;
        b=sZbQGRsmXC2Q5T9r+OOxkgNwlZ98UD75qyiC7Ojqt9eup1bIlZrGM9NDAfjzpyUo+I
         f2nCbtikQaF34ZjatTiRhKVxRnBSnD+7jFcuGoQRR1OyRUDYcjHuIvQsqKnLkB//9f+2
         plZHjWpfhlFSSDZmCJL3Yb3KIz8AmWELIzNVnOh5UIRjMyvlwgO7F4uH9fUTxgHnUtyR
         pxXCcQ92/s+TgTMw8lqFP6frPBC0VAK/CkIeAIP3nzTrysiYA7UHy/GXoTrRFARLDJvX
         zT6SzZeiODfaUhk5Ff6UudbgGFWBK4wiBytFBOLKXKqfm38jJN/lcbcpmieMobYhm4Su
         wuJQ==
X-Gm-Message-State: AOJu0Yz9s3uULp4oOe+qOZh8aruzs8+gsb8/5axtp30NVHZ7nLd8fy+J
	sg+/3y8sdw2JlMHJ6ZoiRDYh6AAbQzEZWTA1P11LrcZoJXbLzkyJPqVT
X-Gm-Gg: AZuq6aIH+jzF4iT6F1qdGsVkIGzGdGvGxVIqCLLAKt6gNPtvefMooBterRrZ81v6VH5
	MlH9K+seNlUl+emdCR5OI6fnQiJRBrI6pQwcr5wv3QkxBtfG8ageM7xtmxAIgmJ9tIVProL3YCY
	JypspVdegIJzDEe/7rhScALh4B5r6SELZ/IwCaHM3cZOPZ7O/FpfxMVw9QBM5Umqe5Lkn04PBLO
	EiFotgm9EBtSGKSn9kczSWd49wp2QYvfOp/HEk7Ip3QROxNCo5vwE2bljxfyzOCnzR7b/fyYQ9/
	90S86GCUeJ3VWuwQ7USt+zstA9ImJuF+1QjrJ6uuylYm/X8zGg2AxB8rYeez+ALmDVpRH7Urbc0
	4kchwxTi4Gc9vtbMkXDKLzNDIRsyssiZFAV67zQ7EtZxvNv5jsP3C7NWyXLRjOfcA6dxxHjT0IK
	u7Z7TsQaJ/uFvBXnhuPbrKgikr9zLrYPO7wxw8HrxAitrcQsgw0cOoqQ+XN2bV/bn3YCX1/xBfk
	ChwRLebdQ==
X-Received: by 2002:a2e:a98e:0:b0:385:c7d3:aaaa with SMTP id 38308e7fff4ca-385da0c9bbbmr874031fa.42.1769109871723;
        Thu, 22 Jan 2026 11:24:31 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da017b5esm841901fa.19.2026.01.22.11.24.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 11:24:31 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v27 0/2] status: add status.compareBranches config for multiple branch comparisons
Date: Thu, 22 Jan 2026 20:24:30 +0100
Message-ID: <20260122192430.76552-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqsebxmp3i.fsf@gitster.g>
References: <xmqqsebxmp3i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> But the patch you sent was not using "git send-email", was it?  I am
> not sure where those annoying and unused CC addresses comes from,
> but it would be from GGG, not from "git send-email", I suspect.

Yes you are right, I misunderstood your point about the CC's.

Patches are 100% via GGG.


Harald
