Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AD3009E1
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191708; cv=none; b=PvsSoCBoivNwzvf/ZKpz8g+Ef5+wYzrI8rEyupNRG1zTiTWBNnfKW8NH2OlMztgUEFi8f672i/wtP/JL0qRDk8y53qgTlf4ncg9rbJ6Kzy5+1lJ0BlQvHXQqCP84cg9Gjjek6yogm/Q8m2PnotoM9v/5mcfIRtTbVl+JBhIo17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191708; c=relaxed/simple;
	bh=HGOiodMQLCt/xXc3RbFO7gf8h3N99U+ajzdx2vt5hGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mO/sn6iPF4acg7q/f1P+/ri2br2GPl/4Aw78htbjL7TQs3xZI3y1QnJezfaZ4mc4f0+slD8+C77zY1K/+fvDx70Yxuy6ezlDfJAc5p1AWMuxytXzVBp0r/jZdxHrOc9sGQyKIgCSYOr3jmPICfgB310gl4N/s2g6srzVsxlbxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEOG2fiK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEOG2fiK"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38df1889fb9so64026541fa.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776191705; x=1776796505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFjNncvtMOQeOeKY5zfIdxg2sivC7IskroyL8P1GXT0=;
        b=CEOG2fiK2rv42kJFPl4gi0Q5pafmFqGTxqeFmg0nnuigsVOMuji1JbM6CASeDfI2SI
         7fnCEtww8XX3B1sHvJPBEV1MgDgmfLEFL+3TXG7Bgd4+ekWyOp7MyL9WgvvzfDEw5oRQ
         RA47jwxBqUmWdeFiHGDsIBvQ88YVr21UsyABclG5MnZD3/F1oIc35NpVYtE+niUt6QA4
         8LC3dpdRJ9CxqZ8g5l3MrfNz07nrUdyDofd7OHv/axtWbZx3Q1VaJtyQA/1+q68gtccl
         L/1by6CaPobwk5+el025rDiR5GB3CcYvD5iBOfTi431B6TE4KCh9sSRNSrJjUcAW1diQ
         +Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776191705; x=1776796505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFjNncvtMOQeOeKY5zfIdxg2sivC7IskroyL8P1GXT0=;
        b=pveEpuoaU8cPESgerdfUwHFpL8fhlOH/Jj8VZkyjAxItotaiyQRv/qDgCb8AqzmZYA
         jfw3o8wTOgq4e2nluFPDQHAiMUcqTXTr6iY0pbBPCiEWcMwVLEOOYkTGlB12WUXLkFAT
         SWuA8DDwFpUwC6H57xep9ZBi2cGhD2436+tTgqLje0ELkBBVTb4o70nqlk8qQtnSzMdL
         YYDAsstiA+asGNvJVYEVDBqkwarfJNZTe7GHYZR+IjtNFK0OUHcHwiH8FPCv7os6Zffu
         6ca3ICu1EvdslYYLGEUV6iwYusc0HrqZahq9x76cDj6VhqvpQESUhOoK5eZwaTKxjUZ/
         DgAg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZoF1u+6etYKlfBYKJjQtyARn10reWTpmTqSEA6LAektSFlrYx3rUs/AyNavpNnnLbmmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymEHSZtrLaDMSTQ35TTZghZFDsjWzZNYbj4OiPxW5m8S140piM
	T8XZj6306GTMfIE5QtXBPkAQKC4Sv+ptfrWOfWLLDacPrQPZR2/EksOHgUY8WvWs
X-Gm-Gg: AeBDiesMNWWuRYN9PxJcfPepRaTHz9a67wXuOO4uXZXe/7Ywh1Cn7ZJBbZ9LdM09ylu
	Nmz034QI6KI3LD57MK8tyFPaEkfdoWFyahJr2YX1TtLHRRvjY6Bqqb4jaKWB743g8ZH99dvsWXL
	fnudEaPf065kL7YQbPbcCr0sQmNLzCjKnzslCiWLGnr/630SXQ6zCmy0r/4vZcO+f4FJKTexSGO
	91uvmkv8D9gx5Yfu0Ep5ObXJoYy8Ic1W/lVkV6gS4teIoHKJASafyHm+jBhU0IQlvg7f0AJ1MhK
	Nk3cw17QAwZn9/EeIbRXKbo9p4UQ/lizYaQoqB9pGz2vQQRglklJU6QKB0edO9ptNM/jONnQ3iX
	QfZ7zNPo3GN5Izjjl9hTvnv3Wx0Rbm1BMB8vxP6NNYdkc+7B11w669rsSAvqBShfUeZqGJrS6Iw
	kKOnsJXcNenyIniQxVg5yrEFF07frYGfNvYSqg49arEafgrMmtixnlyXc2GATqa+SNE8fdp17Br
	RQ8mS0HF5Q5/pJBRHrG7+cgFic=
X-Received: by 2002:a05:651c:f0f:b0:38e:58c7:cce with SMTP id 38308e7fff4ca-38e58c72bcfmr45786921fa.9.1776191705238;
        Tue, 14 Apr 2026 11:35:05 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e4926eb14sm34586221fa.2.2026.04.14.11.35.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 11:35:04 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 14 Apr 2026 20:35:03 +0200
Message-ID: <20260414183503.53180-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <e651e491-e59f-462a-9e81-35546112ce57@gmail.com>
References: <e651e491-e59f-462a-9e81-35546112ce57@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > From: Harald Nordgren <haraldnordgren@gmail.com>
> > 
> > Add a silent parameter to create_autostash_internal and introduce
> > create_autostash_ref_silent so that callers can create an autostash
> > without printing the "Created autostash" message.
> > 
> > Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> 
> I wonder if we should just update the two callers of 
> create_autostash_ref() instead of adding a new function but the 
> implementation looks sensible

Good point, I will update it!


Harald
