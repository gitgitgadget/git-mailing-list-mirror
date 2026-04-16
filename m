Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB026A1A4
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362008; cv=none; b=M9pcEVeqN2KHL9KQ+sMde7fVUGWv5xxbAlbsOEabkJaiEceFllFG+md5q9gCZTKNmmoFdYbLOG8621UIeh7O0hft6LhhK0uK7jqPKT1L/s6C85oVMinl0JqS7ZOA47JxkxDOpvUd6RBAjOjzPEZ0RkwYJIPoBTyQBeraIow7TrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362008; c=relaxed/simple;
	bh=o7i8kEKYnvzIizkiN4VjniqsNnaYx2LB3TWfctwAGhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuqqBVIoXpTblBBFObotQiLeEiTiOW+mYy+AnFCuneSvcCfPMH28Nkf6hzHPJvdhjfVSoQTG0bbG4EKIvx+kNTBIPoxeg3VAHRwe8pOyv0ATwv/YFRTcGhdYowKd4nzK2UfuH9vHNJ5SV6qB46DG3l9isKE3gjO4Vw3ozgraUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv7zSxnB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv7zSxnB"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dcdf60427so7992844e87.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776362006; x=1776966806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT+ewZYVIcbyn7Icpt8OFml24I8w/vehYyvzhcnLJrA=;
        b=Hv7zSxnBrCKYMTm6FdeKOMYzNCuLwAcotNqR52bwQFUAdY4Hk0hwizn7RFqd56kTEI
         m0GS2BXtB05rz+uTrq3RCbE6AYdvKUBqa/6aDg/JQhzU4ty7xnh3OFNOr8s2lrAM6LNq
         L2KVhzwY/eud7sjdyBGela7f7Q5S4/Vq9TxBJ2L3m8Dg3wA9qyHwDiosRKQomKVGzOq1
         jCSU8O+TEYpYA0ey/3x8PFpzGSErlZZAZ74Yyb0gpNJ9Iqci3M8omH8yy5vamsbvAP5F
         EE9fXf/7I+cjqdq0O26GYPma3oQr6Zvt84gi7sEggjDA000NFATPoRUVy8p4zex+CQv7
         naww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362006; x=1776966806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FT+ewZYVIcbyn7Icpt8OFml24I8w/vehYyvzhcnLJrA=;
        b=Z0THWikpZsxHpC3wiNK1rePOfK7rOcdmyFdOEtDeSoyD1786+JxxeV9/riFwtFFfsK
         7pAlcNq3FaLuos95X+27nkw+PYuwjuqbkFUmxl/iBV7sDQRgnR1lLP+WIH63efQ9B0LD
         XF1RhR3oSEXoiDfpsG8HSyi7ZPfEPevzfDcR8pjYSgsCPm51FGLATMlAbNeSEu4ZKd3Q
         dI2RIApc7wlzJkTbh0OEhPCxdhU70Y0B1sqBtk9nDZS90tlZjZjw7KLw+auEfZsdUwYO
         LD8dF30QXItwEIgB1vqyph0QiMdqoQvYrvRO9RGPcAG4J7wTEM/gbpqPbbB69pGYbUPS
         V0gQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CuGccpCJZSEQA/MSar66DK85XtpVerUwyQe9NkB5B1d9yVulc7MlCpPRG8cQ4eQc8Em8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jNpVcQ0XKZlSeUmLSd3K6rVnEN1lS85cFrcYz+cwv/XyAjPS
	UofWm3orhIeWyCLBwlgDMBtz6JnJB3UX/WNjVnFMjQgG/YUORVbqOE8T
X-Gm-Gg: AeBDies0dlC+hJTreuhh55PO7+hNZU76amfwXjxKicLFD8yIO07YoWEfHzxHwfC1yxv
	ceBThLlYTd/RQBZylgqLvJTXacXHC9fKRI9SgSjwVZEMQBC3moy4oLG2VGajAwD4Ie/L7PJGCfJ
	/mPYqS/RPx/CGV6fmOsYz4Vo79FAkpIDmmdLPB2OCrKPce7eBJ3MLBeurc1H2G8NG2QdtE6h2Fp
	KwZZTvOoH3bnidcybjXvR8QxrLSmDRRUmg8yQTu+tsJdjnpwHu5PZjJzc/tMeDc7w9Bdye//L8d
	cvveJKXo8tQmy5jWuGOa2Do/vrzvh/8pccu3XVwPJETmGxuU0KHrtmjzc7bz42EcMaWE+bGNuqY
	H4+BM9NnyBcLEGYPous1h7pyoCfAWdccSQrdZgwMRBl2j+UFAKDxBT7pcUpIyMnsicLwTNz/yFy
	ImowCEbG++quDYVrxy4eMT4i2M995L3YTfHkqc54Wu9xkVzkTD4FCx5QWEUUh+QpISxY43mN6AD
	xXgTsoqdAXBXMF7tS4dy4RLKRg=
X-Received: by 2002:a19:521a:0:b0:5a1:1496:922 with SMTP id 2adb3069b0e04-5a415566f77mr71704e87.33.1776362005440;
        Thu, 16 Apr 2026 10:53:25 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a2fbae2sm1445714e87.63.2026.04.16.10.53.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Apr 2026 10:53:24 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu, 16 Apr 2026 19:53:23 +0200
Message-ID: <20260416175323.92708-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <xmqqpl3z3qwg.fsf@gitster.g>
References: <xmqqpl3z3qwg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I am not sure.  Have you actually tried to apply two iterations (I
> think it was between v11 and v12 but please double check) on the
> same base and ran range-diff, and compared the result with what I
> complained about?

Fair enough, it's not great!

> And that is why I kept saying that the cover letter needs some
> comments written by the author to guide readers which parts of the
> changes are notable.

I hear you loud and clear! Next patch will have a better cover letter
if or when it comes!


Harald
