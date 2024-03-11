Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBFC3C460
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158110; cv=none; b=q3XMzkNApkse1QEg8xvVRK5Hi7jxcgVK/NpWihz/6oTpVj4qwnHqBHf5bBzFXqcThtgVw6ntN6nC/2LRsZeaY+ITuSHlElF5cuxXsWCVMCmorwvRdLF0MLFjyHMFq9Z8vdjxGpafrqofvZrCDL+s3/0INkvWmVx/jraurHME8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158110; c=relaxed/simple;
	bh=5ry3J91wDTFGcFaLUolNrxS91BH6ilWsw3/Zw+J6TXs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=THVGSN4064okECTh5xrip4ILhA1ppIpbttIDYX/K+W1nnsg7IihMDTLZfOUUHUtVE+EoZ/vzdr9S75uVy6C++dkgqGpWTpfIzKRTBvphfAQ4ClWrjSSJG/BVs7E7q6aWW5o2j7OTaf7GzeJdY7+fB/y0ThPNSGmvbnEX8Ducimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edwardthomson.com; spf=pass smtp.mailfrom=edwardthomson.com; dkim=pass (2048-bit key) header.d=edwardthomson-com.20230601.gappssmtp.com header.i=@edwardthomson-com.20230601.gappssmtp.com header.b=Nv7dYhbR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edwardthomson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edwardthomson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edwardthomson-com.20230601.gappssmtp.com header.i=@edwardthomson-com.20230601.gappssmtp.com header.b="Nv7dYhbR"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso3809498a12.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 04:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20230601.gappssmtp.com; s=20230601; t=1710158107; x=1710762907; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ry3J91wDTFGcFaLUolNrxS91BH6ilWsw3/Zw+J6TXs=;
        b=Nv7dYhbRoR9P6WiOz024V8FAeViVd14y/B2FYTZHlI7DxcCxWrG545bcAMXpR613+W
         WJPsnKZ5xZPU0pmQrT5hUxPw5GUYgd1VFSVJA7f+k1BcCC5vz3KwNRlFv63kRkini7Vd
         H54kgMY4qllEVHlkTz0EXLRbxpxImgTnYVCIex5f1/uIeziGzNNwoHUMj7qaQOxHshFS
         Ux/1XhvPfhqNtoOVSDHW2gmy3Q2DK4P0m4BVwOHh6QPzUzMaCPP7o+qmcd1ifkcmA3iU
         iEaoTeYZseQvfows5wmGOIPsRDy6B5tB/Ks61/ShzyYD+REcB9MEcXkNdOHocWm94VEB
         R9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710158107; x=1710762907;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ry3J91wDTFGcFaLUolNrxS91BH6ilWsw3/Zw+J6TXs=;
        b=E19o+EPfMX4tuALBsti72BvEUkJWlUr8mCMZ3JTge0FLcpgTXvklFOS4detUOSQqTL
         WedQqVKdUA+ULTcC8h8A7HK2LZAB/Nkn8otJHWcmTvUUo123T5y1Gc735bJwy+16S7Jv
         RacDGRpjM8tRDeGmFakyJy4fAuTkDiQFEJqntM3MkYqakqdS5yCftJYFZSakOKcf2Pxd
         izQbPpX3YR6kL5yHBHZBJr0Y2n+iIfRlJSl898Ug702nLsYG7mv+1b1uV1vJG9DgotvA
         iO1XJIfnJ3XSy36nuyEXV2nFNzg74ZMDolfcjvDljYFOFuoXEWOAPRnD2s8NkpFcgqE1
         rSLg==
X-Gm-Message-State: AOJu0YwLGLx6nYSsLHR6W9Fuz7VXqqnXC9Ex6zX6E1vGIJZjHweBgVS9
	q/YmoGdpPIMZkj3VAFfg0/Vgo+NhGSR2QFn/AlulF7CzvzMx0frQolVRhYc3ourMGBl83KxxgeP
	ajfcVNbsQ39+6/YYl0wYp4W04kx9UC1pyj6LnQXdiRQU52rcC0g==
X-Google-Smtp-Source: AGHT+IE88DDi8kbrMcP1CwrOZAIk9Ybrje2MAeQJ22jvx3++p+HR4XWwRSIjdfcxVRkXWs7oqA4BdqVOqHMDBp9O2JI=
X-Received: by 2002:a17:90b:1084:b0:29c:2644:8d27 with SMTP id
 gj4-20020a17090b108400b0029c26448d27mr191542pjb.29.1710158107055; Mon, 11 Mar
 2024 04:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Edward Thomson <ethomson@edwardthomson.com>
Date: Mon, 11 Mar 2024 11:54:55 +0000
Message-ID: <CA+WKDT0fAASYE_ZhSxATv2NUnYceOP-_EF1kqKNFSOWU4QdPVQ@mail.gmail.com>
Subject: repositoryformatversion and extensions
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

While looking at worktree configuration, I realized that the
extensions.worktreeconfig configuration option was honored even when
core.repositoryformatversion was unset, or explicitly set to 0.

Re-reading the docs for repository-version, it doesn't explicitly state
that extensions _require_ repositoryformatversion >= 1, it instead
states that:

> When reading the core.repositoryformatversion variable, a git
> implementation which supports version 1 MUST also read any configuration
> keys found in the extensions section of the configuration file.

Despite that, at least one extension (objectformat) does require
core.repositoryformatversion >= 1. Though, do note that objectformat
is not mentioned in the repository-version documentation.

What other extensions require repository format version >= 1? Is
core.objectformat the outlier here?

Is there documentation on which extensions are supported at which
repository format versions?

Are there other extensions that are not documented in repository-version?

Cheers-
Ed
