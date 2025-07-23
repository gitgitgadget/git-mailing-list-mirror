Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC351F03C5
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295190; cv=none; b=u72meeKApW3iaBaY6Gr5ZT6rHYQO8hIui8Yk6zUBDxD6sNN3K/Ljw7gdlvpNBb1FR5f8Fipi1dJ+zN6rq+FDivorYHOpTF5SuHcLH4eyfEdxL+vY5uW/Lw5KJoRJ1h3k9ZKLb9XxZj/juNsGBD3H+V/eD/p+vMqA9FYcvSloBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295190; c=relaxed/simple;
	bh=dD+kJ8vxIB+HLmq/2FKKoxAulM5NUgE6lL5BY7KGhBU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QYrZNnNcFoNtsrw1dsOghSzmGCs2T89ErszmooRZS4TJ2o01GbEbj0NrYh8Dd/Ay4zva313wCe4pnzaW71Qv6OBeQ53Lf4TIuQ83y6x3IIlPumuQ25uX9jHveqEV7MBRHV/mrWyFI/QpoO98hBfq0H6HkiXb2xh4IcSE+9LlXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv2Xy81R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv2Xy81R"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dc5bcf49eso1460795ad.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753295189; x=1753899989; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dD+kJ8vxIB+HLmq/2FKKoxAulM5NUgE6lL5BY7KGhBU=;
        b=Uv2Xy81R1WCm9Y2iXMXAM+Nt/GL3sR4rLuZSKTEHUbO+4bN6n78UiJ/+odexmTqIXG
         g7ROkZZm2Y4my+acalVDisPUWmdDOUMj3NChjZnR+bArpLDJBaBpdXGssUzDSRMHmWEn
         y6AeQgchkpQdXZ0l9usk+MTQJBGMMVqZ47Kp03guwqq5XImsC0RmZ5P1KcqtKLsX5OIB
         1JlizTSsNEExlBrKHUs8rLD6yf+JalTRwgZkQrUlhfwTpkeDBmzaCbOitQwP8jiQZG1J
         a4krp4fXRyliUN76rjPTFHFZ7UA6Ql33O+BCTwdo2wAxnVDiTh7XXq3kbw8DOt0MjwC7
         uvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753295189; x=1753899989;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dD+kJ8vxIB+HLmq/2FKKoxAulM5NUgE6lL5BY7KGhBU=;
        b=QS+sBiFVItL4MWFq2dXLcf34uU1RzF3OTw1YIt6miBjl/0yHOb12GK6kHvGTeqXm0p
         SNU495PhkClsswelbKw4FBkpmBr4b4GOlMhiONbf2oZaPKrqcK3PkJM3PLT4JGLDEoNa
         xorc+oA+AJcf1CKgyFCi86r547LyrdMthuDojxFERvV/I6OuCyEsxyIWcYcRpBABxnqk
         z5MEjuED1hu+VDE7Tno/fO8zvtzHHjm2dpjiIsozZ1P1ScXGbqqJCCLcSKD4ArgFvCjz
         G7p853+o/dMYcIq3DLyf8LXRDC0nszmN12ULrZTtNUCHAwfHM6GnwdrQdAB0FpbljjU8
         K7ig==
X-Gm-Message-State: AOJu0YzXv46rJS3lHq+0ErAABdyeg5MkmhYScc2kdj2IW1Y8g1Z5kDVf
	RSuy4jStGxJsCXprBNG6DcINvFvph39GNisf/2k0XBxEM/Jx4whs+qaFL97+KuDe
X-Gm-Gg: ASbGncvcY0JgjBLLEl4JN9pts1X4SVGmITXVVytMmcWedrI+hFG8o/25YCG8JxCOZNo
	b6m5KdzRIIhY4Gg9Lq7WKm2fUptUuEqqabWu+5vkdFdG11i6xTLaDkKA/IwhGunvtM6P3dFMq5O
	OudvycTxgJoT4t9qbCNmTFCyWJB4IJRvxhsBN3wfHeDPTdaJP8r+Xqua9dM+h7ADj/Y1ZHB+CTd
	gBsSKFK6V9dYiMdqjXa1fk8//iWaV4hq22YdiDUAjzMoMKJ8EBcgDUtOeqmZB3v14dikbBLEoq8
	ZkIbomnqRR24rhcLPXock7pLGymLb5WvZCMNbkUh+/mCiVYQtB1yw69LGXuJ0S8RZJK98StOhNH
	J/5OhAITbGFxiKEnl7ZAsOEnL5e2/tNHgBmrAZWh1KHTp+Uem9uVc7bKHS5iqCQ==
X-Google-Smtp-Source: AGHT+IHYNtwqMnYINzDhtU0stAf+oV7wR7XYYcghmmFagExuPejQAILy1w69wOgsU+Az8eQWBPSTOg==
X-Received: by 2002:a17:903:fab:b0:235:779:edfe with SMTP id d9443c01a7336-23f981b4139mr62808965ad.43.1753295188591;
        Wed, 23 Jul 2025 11:26:28 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6eef9csm101299445ad.182.2025.07.23.11.26.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 11:26:28 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <ldomqfgzts2fs3zuzuyfpsp4jsuec7a6ooisztqx6pe2373jzx@mqzh62weo2jm>
Date: Wed, 23 Jul 2025 15:26:14 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk
Content-Transfer-Encoding: 7bit
Message-Id: <B2B2D8E4-DD78-4ACB-921D-A8747A0AB0CF@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-3-lucasseikioshiro@gmail.com>
 <ldomqfgzts2fs3zuzuyfpsp4jsuec7a6ooisztqx6pe2373jzx@mqzh62weo2jm>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Ok, so each key has a corresponding callback that is used to get its
> value. This works fine when we have one operation/callback per key, but
> I could see this being a bit inflexible in cases where performing a
> single operation could be expected to generate multiple keys worth of
> information at a time.

For git-repo-info it wouldn't be a problem, as we return one value per
requested key.

However, I plan to add a feature in the future for requesting a group
of fields. For example:

$ git repo info layout
layout.bare=true
layout.shallow=false

which, of course, is not what exactly you mean :-). But it is a similar
problem of requesting one key and getting several key-value pairs.

> I certainly see this being the case with git-repo-stats where, for
> example, interating over references will produce multiple keyvalues
> indicating the number of branches, tags, remotes, etc. But, maybe for
> git-repo-info this will not be as much of a concern?

For git-repo-info it isn't, at least by the planned set of values.
However, given that I have plans to add the previous feature, I can
try to make it flexible for doing things like:

$ git repo stats object.count
object.count.blob=123
object.count.tree=456
object.count.commit=789

So you can use the same code for outputting git-repo-stats data. By
now, I plan to finish the basic functionality (i.e. finishing this
"skeleton" and adding the rest of the proposed fields), then I'll
think about this feature.

I think the current solution is simple enough to being refactored to
support this kind of thing in the future.

> If the user does not input any keys, we simply do nothing. I do wonder
> if this is really the best default behavior.

In previous versions it returned all the available fields. There was a
`--allow-empty` flag that allowed to request no field.

After the discussion in [1] we agreed that it would be better to return
nothing by default and add a `--all` flag for returning all the fields
(or a default set of fields).

