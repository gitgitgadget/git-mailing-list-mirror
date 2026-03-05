Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3741862
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692743; cv=none; b=ubgeneX/94VBjc2eeFGFrmKr808LGYow6TvJht7rlYB5YCbGQMWp0G/VO3oengWLUVdxGWbUAGj8AmScrA6TZU/xfJp7PcbKyOt/CXhhAk4FfMvTUao8GVUcysC9IJ8N7qgAfiRACZZ/U0/Hkbrjoz+wCMp92vKXUlaMC8fWgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692743; c=relaxed/simple;
	bh=g0IiCcQ5/9fkChIGC9SWIGwSTjwuYovYtGjs6XiAVd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYH/9uS5MCZmWSe+s1PFI01mDvgJ6wolWYoGoLAbVCxYECmS4wkyB/KdadqKA8cIAt+SeDAMtXwtsmhOJprQzfmU08675aAY0HAw0rmslhSQr5xTw34Yn1/HGYYeQ28TutXLUDqYLLcWzg1NBuWS2GYFU+hGArluU0qu8tbi1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHhDVwkz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHhDVwkz"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cbb2329e7eso777904285a.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772692741; x=1773297541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0IiCcQ5/9fkChIGC9SWIGwSTjwuYovYtGjs6XiAVd8=;
        b=LHhDVwkzbnYGbGeTW1YXGC2FPbOWC72n8QbDvBIT/QFfe0/yyEKDG400cDOkwhFrur
         YPnxhB81wtB7ur60bsrODfzmkbFrgD+tggYDnI0oyWJNm/3d8Jekqx84eznidanANuMI
         i0o8WT4zOejhesKLf8Hf0SJMGh8I2iYucOo11SBsHQZyxzm27z99EnylP6fTsYvX/VrK
         zEJPbTSm6Pt7ZHjTKKEBhzFOMBQQ4U9lVVlzJTuwm4NpTJ3bLgHFUVb6j1PSSxwyMaLS
         /DKW5cCYFDT9Fv/xciMS+FdW1grtWCqIzc50aQ2hAYUhB21CuAMZJ9c/Svl7YgS8m/5u
         TZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772692741; x=1773297541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0IiCcQ5/9fkChIGC9SWIGwSTjwuYovYtGjs6XiAVd8=;
        b=V7KZwU9yqOnGL2VNGFa+avc2K6Dyq5+VukdxegZDHQRRVtJKRjz/zEKxLm+CjZ55AH
         G7yuBeOozzb6xwSZntKEPwOgARJaeYYH5/i0dDl/fargkjE70Kbu2jaFaE7zvdrfhc3/
         sbaOU9P/CNuf0UuslrIOIlPHI52XTvU3Km4KakqEHBiFlJV0fLHFWscAwsnhE/AyLzcd
         M1TtzpssBZo8sDX4IgkBtMSIwGPW96KqD/SyFqEQFwqmvNUo2HYfxZ2L4BNeZZSyw4hA
         zHbchOtK72VfajNonOGVTs+A7kmed24OJma2unOWiN7psq11weq3enpabH7yr9xTlQ8d
         zfGQ==
X-Gm-Message-State: AOJu0Yy1DthFLWuuya4XlDIAFkFxKA+7ab3U+Zieg9AJpznJMezZEJrW
	TghlIQzvZj6u97KPAmoxw45DdIWeF0Y0SuAgSb8vYDdw/Vf9DTzimQAVp8+6ig==
X-Gm-Gg: ATEYQzz3eYQbij2Zn1RBc/uzw/knaw4TxwQfqp2LDSpBL0owlftJ29tXGq++FZbuwki
	3w+CBdGDVJnQRhrx8BpbTIoeeQLBWtA/78sxcmV0vQSfzsPOa+Bn4jSyzXWEqVk0kmK2pEJce3Q
	cBtQjAKKjGTZkynmuuJYO4c6ZL5HnsU5wPLUx+J59w8yRwJqArTd775RJWjHu1mbXLkyhmX8dKW
	mTUCe6dITuh1YXPXq9NQsNFOul4dX8xTzfkZaw6H8OXum1t1fpCTagBwj/uYm21ispiZE5vSWHM
	OxYQLVb7/kG25HHokGbXMExwXacIDXmTViPiHRFnjwB4+Ka1UFkgv6e3TMfOqMgCqmEZh1OQ9TZ
	5Ti73jv/a4AviYnqyRasUWh1f7MNEfyS4+AjAn3D7LrUaQceU4AghCmARaEdw9092/wF+483PDX
	VU9691LCQZPG46ATG0LSQwvZOwCsUOdIErEjze4/imv9KMxSd10acsJG5rPWvsCUz1xb79AYMYJ
	zTkcB5c9Q==
X-Received: by 2002:a05:620a:170f:b0:8cb:b062:c2e5 with SMTP id af79cd13be357-8cd5af19e93mr548755385a.27.1772692741016;
        Wed, 04 Mar 2026 22:39:01 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ebb09772sm110146976d6.12.2026.03.04.22.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:39:00 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	paul@paultarjan.com,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v9 09/12] run-command: add pre-exec callback for child processes
Date: Wed,  4 Mar 2026 23:38:58 -0700
Message-ID: <20260305063858.37393-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqv7fa52x4.fsf@gitster.g>
References: <xmqqv7fa52x4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> I didn't mean to suggest using a generic mechanism to _replace_ what
> you added.
>
> A truly generic callback mechanism that will be useful can and
> should wait until we see real use cases for one.

Haha, got it. I'll put it back and let you mull it over for another
patch.
