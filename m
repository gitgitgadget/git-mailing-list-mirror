Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D34E8DEC
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628432; cv=none; b=ocsWRqo8TadfzdL2oSH9B+Q7pH5mOvLKLG1RILhGW6QoSISJLf2rcEheD7hxpfBl1ulMVto39ExL0xyekItAIxDjv8H2VFQoo192fUaqZ3Ty1HbVH25zKry/tlqc7CetBTlbuK/Jr8NZwGLksDp+fEyiYmFE8/lFgXYSDVlfuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628432; c=relaxed/simple;
	bh=O/1FUqcE2pyo7Lb/B3+aRaDbVGkR0iOtaWwzbb0pe8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBnUL5SJcmsYg9Vr8X+fgwQGzjqrl/2KaED0lfuteEFpURo8YLZKQPpIWdza1YqwPJLUgGQTVxSDc6xQ1ojqW7Ghddl3os/n0l9iMw9XwIY89Yk/Q+p9DxPPG4hP1gAqVTi8yir51SNk3KdmH9pl7/SXcTY5f7FmLFcb8wGJGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=IdrYTIfB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="IdrYTIfB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso19606905e9.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788628429; x=1789233229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/1FUqcE2pyo7Lb/B3+aRaDbVGkR0iOtaWwzbb0pe8U=;
        b=IdrYTIfBZB8v3Vsl7H5mdbPTVryt/ULGyFqqNR5SGIgF0WsGKH/GV+rp5uoq3/4Wss
         irBAm7XoU9By69DFkn8LriViO5CToYRQNm3dPZj9FJhihNZxp2j7UdKf5PScZX461Zjz
         bp5eycJ9xXpo/I7XBGXb2YX56RN8N9KLk7Zd3Y+FiWVlK6trkhsO4aXB+u1xdFdaYS7q
         7yr8+r3kDzIMkpsy1/OsGG693Fy+b+V4PQjTXvDkIj+wEa1wbpjL5ZsHlPedpdnR1lWx
         DoVr4AVLrdOJCQc4Cf2CkjdPQ99w2Dmz+yOUEtCyUAmK4W2riiHQtzRme8mqWY81sSbX
         hsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788628429; x=1789233229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O/1FUqcE2pyo7Lb/B3+aRaDbVGkR0iOtaWwzbb0pe8U=;
        b=YqQzL31eozj8vXjyRUT9NOnzmm3p3p22icEVDNjmZVx+hStGNDJs7G7c+hfAaI6qsg
         LBZIVsOFviUSpiwTqMbDx4i+g55OSZXhjSmku7KLKaXa4l2rik0yDjlKKPMHEC9UjBJB
         ATzD24kBAWtERVxX2uJSP5JVSn2OnDawiEvsaVrm90x30IuLH055TB64UwIse2LngiOY
         h39tIS5u0axQDOdUyWO8vzeebVJR7xlvSD3CWjDIvT+T+owYcxJ7GhiTj6psDjejZS03
         JMIw/mT5bcHp0LYfng1Q4n0GeIqVXusQs+rTQyiiqGDPEFuSXRFfB3fj5FG4KNwSrvxv
         Bg8Q==
X-Gm-Message-State: AFuF++merbdqgQhetY7Ovj2a9IFFIwvGjLti2kvtxC2ROsxcUShZJrZ3
	PeRPB94nVfBhE5CCPm4T9GtT+QG6j9b0lVGkkiCn6fzjnMshbAMBGeZXRomaElUDpvgea5BUFKQ
	KRh80SO1QmODh
X-Gm-Gg: AYBFou1lQe5MW3LPhuNLcG+AkWARtjUUPLNOMm31YsfZJroSxCaahwWyNgPSbFVOxW0
	RTNJZBp0kcFJ2GhupFWI319o0wg7pKFTcH37dt2/9kOA9+5z0KNBP73Hbk1+sTsY/yLvSoh9zsm
	fYyQRCjczOc4kFsdN6M+rsSxiePLE7li9GV+ric5YwkbTMOVroJFvl9C+ttoIyU+Samyrk9vPHd
	KzFdEd15ByIfelpm87ba/ue2VEckg8vmp/SLbU0qG3hqIRD1vZ+KYZEXpxdwHMk/3uJVr52tbNp
	aFNlxOeetRHC4JhinE0PXObfMlN1KknGF3BMMZCwvgqKLw5E0LHdkeooS1tjY0M4s/kE6JS0hGI
	8LoxBOsF3Wzpj2mgBLY31icgcJ2CfKxK75FaQeKbw6Cqi+08cjgMAzn5UG0zhqpvRqIl3g0L/ua
	JYQOCBMb6dDbcDmcn/soFgQ3ZGvGfq8e5wIYdMEWmTNkCXmHcxXGaJHeOp/nB/TXY+S448e4aUv
	Y1mo/Q=
X-Received: by 2002:a05:600c:190e:b0:49c:fa21:1c82 with SMTP id 5b1f17b1804b1-49cfa211d3dmr112400525e9.23.1788628429205;
        Sat, 05 Sep 2026 10:13:49 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm6605225f8f.5.2026.09.05.10.13.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 10:13:48 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting --no-commit
Date: Sat,  5 Sep 2026 20:13:47 +0300
Message-ID: <20260905171347.34775-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <639f29ff-59f3-403d-acbe-e6173a8fbf04@gmail.com>
References: <20260903125524.67889-1-f@lex.la> <xmqq7bl29g2p.fsf@gitster.g> <20260903214553.53942-1-f@lex.la> <apqSXT4lT7v0ILjp@pks.im> <639f29ff-59f3-403d-acbe-e6173a8fbf04@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:
> In this case I think it is worth checking as we can do it by adding a
> single call to test_ref_missing to an existing test and the logic
> around when we do and do not write CHERRY_PICK_HEAD is a bit tricky.

That is the justification I should have given. Whether the ref is
written depends on the command, on whether the merge started, and on
--no-commit, all in one condition, and the conflicting --no-commit case
is the one nothing checks. v3 states it that way.
