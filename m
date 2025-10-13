Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CC2FD1D6
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353634; cv=none; b=LJrjOQWmhsum6xqRxYnfGWlYkNuGzP3/38DOLF+l9cwWrT0HLtAlE2fdFF/2SnPtZdu73j6kEEcNS7rRK6a4zyU4BreTvU+FYXVbv+1DAlbcHY7jgdUyHjc4476NeIv7a/C33wrbfM+sYP1lAQ9GWGY9UcPPTkJcXufErIpbVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353634; c=relaxed/simple;
	bh=ETkNwRsVLGnhktEPAhNQjzI/v1ZLxL3pfFNpuSyd7U8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sLAtFNkTkSoqyuphKS34UNfwlLDsB+bBtCCxxcGgqvJyWZ8CmLyC4Vgbp40gKW+TH5a2Zeu1whEsABs1dvivVusE/xphd4MfVXsF7akRfHPEn7o3PVaky+NKcGQP0UhK1I+awBdHzJSo7xIXHJUP9h26S6mlluAXwKUEW5yfvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5k8fFGD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5k8fFGD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so5261298a91.2
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760353632; x=1760958432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ETkNwRsVLGnhktEPAhNQjzI/v1ZLxL3pfFNpuSyd7U8=;
        b=S5k8fFGDml/nDaACg8lhhM1AFh8ijw3pdJo8IKrYBL/erFXzNlKj3tryT9A1X3PMPp
         nRJzJv1HrvIlLf8E7TKgoxpsp6vLFa8dQPJRm3pyk2opYcyj8RedPtE+ni6fwr31XcXB
         129uctDJVv032sD+jGTr6wSq9gpdwkMwphbjsM/xZ7mwOtdpTw3Vhl/GPqgKNH05FJP7
         KuaykCO3YV5tSGYOpP4xRzNIJfhRPK7q/WNlWwmx69xDQiZWgyS0h3NG8zSxKMXzGj2C
         1dq13p3UxumQ0UXzVPGmNySYl3fx2evstdKOFANwMYTIuRq8i1ktBvmiCIdfpn/uwqCW
         TlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760353632; x=1760958432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETkNwRsVLGnhktEPAhNQjzI/v1ZLxL3pfFNpuSyd7U8=;
        b=NffSAsXk0S5blQTwTtJV5K53osxWk78sBtmdXjCBaTUDwE4HcRIgyFYzEj/twnB2G5
         HacAunOhFNCJyhv3Wtg99CHOvisCHrVra6q+5+4B1edNQnThqCHmC6xuyOuqcUorWrAk
         tTdG9fPaAYmxMWApkRuk1PJw/jnXbjTNORc7rtUn9SJNA5AXuN0LknkKc5nLQOr5vsBr
         S68kZSHTVNoTxZJR1qIx5dmPqCo2nl1H51iQ6F/lQNtxCeUduSZEshk2SZNEclcycEPa
         +4kBfZidrwE4vszwIJ/i2rsGJ6FpvTd6tskPBrrjNiIK+Vt2KvmjF8hhsR3KY+FA/Oi8
         rJ0Q==
X-Gm-Message-State: AOJu0YxYpbDwtKVi/TX2o2ClqCi78k+Z6gXAHWUGy6hdNQ+UjFFoGlDi
	Zu2OFi3ZDuL6+cvf6jOxZfUBYGy1usfSVtMDFxTj9wZmmbBYtQe4TDwF07sie48geKobw6jBgTj
	+ksTO0X53L6rUhoO+qwT9Oy96Q+D/B4tcQSwPhpX8tw==
X-Gm-Gg: ASbGncsIHHrUpg21jMGnsB9DIERzMXSlanSoDA0KDk7H7ctO5fj7zpUxGEQQUv66F4f
	DVDre1r3js8MQ5HEa7FyKZsB25+uTNFvUPGItnxiWpj+gyAfiUNlGTxa0BLatr8fTHGhoEOlj7W
	LEtmkL3tnSeN3JPvWV35ngm5WfLwcnSnRwZew1ll3VhgBFobuoD0wzf1dvBgQL7HSEKsN4qpR6+
	1aSjb8DC5ZzgpszfC2/0DS8k7PQo/e+dYSk5R5CjOJ8PeFX4NlROjg88VNQQimU3Uu4p6iNsoLF
	PqCrwJuS6PMPtq0eWM8V5nBIsdPd0I2cc/yZNDDFwif96Jrlsk98NWtwHuFGJyRqNd3dBziLBcw
	9sh/UCh9a16Q5pjU=
X-Google-Smtp-Source: AGHT+IGjDmwzk/IyG+Ga8gBWqzo9c8cAS9iFjRc6UfC5I5pgsImH9FE3frmP+9D7INc7MiE4LUMWJqGH6/ROSyV6Q18=
X-Received: by 2002:a17:90b:2f04:b0:335:2eef:4ca8 with SMTP id
 98e67ed59e1d1-33b5139a385mr32002473a91.33.1760353632328; Mon, 13 Oct 2025
 04:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Solomon Akpuru <solobarine@gmail.com>
Date: Mon, 13 Oct 2025 12:06:59 +0100
X-Gm-Features: AS18NWDWQWFvAtgwuy6NSepFdZB1p7FCwFPE9t8hOmM2iX46SDaolopCYsmaRDI
Message-ID: <CA+tvzBVNSd4MfxmOSzNoSumM6jgfeJuhD16QtBmbqeoyt9b5JA@mail.gmail.com>
Subject: Subject: [Outreachy] - Introduction from Solomon (Solly) Akpuru
To: git@vger.kernel.org
Cc: christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

My name is Solomon Akpuru, and I=E2=80=99m excited to start contributing to=
 Git.
I=E2=80=99ve been getting familiar with the codebase and recently found the
=E2=80=9CModernize Test Path Checking in Git=E2=80=99s Test Suite=E2=80=9D =
microproject.
I=E2=80=99m currently preparing a small patch for it and wanted to introduc=
e
myself before sending it in.
I am looking forward to contributing positively to Git and the community.
