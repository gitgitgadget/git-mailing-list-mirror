Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941F64AA4
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718519; cv=none; b=S775eNeHiIXghhfpr1mFMMVLjzcvVWdPowCSdBt4RDbHrow42qRboZHJNb8vjHSJn71waImHlMqJ2KD3wy18ceslFM6IjirCtOc5ScSaKAROOlTbC/KQr0HtkQvgPFC22Rx6A9Uij+WGxME34xNQGr2JoGnO4mwY/r7zZgyESLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718519; c=relaxed/simple;
	bh=z4VMpgprphVuU7QqhmLjG9tQK2GshBeBeenjNfiI9Xg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KyPmhZV+0W/2Fa5Teic/np55jMmQUblge/SBXh7mefUiL6L6rfl02+uFdHs7rGeB7Y1FJHKQbnwIz2uikV+M5f9Ntv+fLmkvsyioHvib96/l7dvxuE8Za2jLzyU08b2FXzwvBHxcqqxotvR2pFnlp2mehNSR6HmEP7HLq9sz2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKGRk04K; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKGRk04K"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2046468a91.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 17:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785718518; x=1786323318; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=76c9x6E22TWYu7NwCjum4KBWom8sNzTZextBffHpe60=;
        b=dKGRk04K533pfcf/QzCozP4wFx0tj4WlbwnrN2tLU09xlepXzyO64suFO84dyPjg/o
         ZBIjfvS30d08okB6o7490x35W2lH0heRCeSaOUeKyrdexmAF7Fa3E457ZnIm0FYBvgRV
         CwV0dKgh/K63WTsMKTbn5BUuqdKL1+C4XcID07qqsgmCOzxHMSsqfmAjmvO+02D7fIcP
         epXTQ+hiQGabFw9kTJPc9TMoZA9eU1zGkxW697kqCLvJ8vUgtmUZEkbz9WVic/dj/f0k
         0WnUXy1yC2hkAO42oz1yRxOVK6g7wzUj5s/aT8kyGzzXUliU84fujo6hoYSqKBNo4Nag
         Y6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785718518; x=1786323318;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=76c9x6E22TWYu7NwCjum4KBWom8sNzTZextBffHpe60=;
        b=bwZ0cWzuUahBgLKRyOuWbzP+BvHRsa2tzj4/KFIUTf/c3BX311kwaaAbx+PIJsPOxp
         r8hBtbHBMlgPHKxoyXlDrlN/zYNTnwVzUc33mXmSq7NCmm8tRLGiaW8uMonMqCF2v3Xl
         on3jyrSlYvfWoxAh6T5PswhbEegHXgGIGcbtMQvdEI6Nmy5FLdWDbTOrVfQ34OUz0Ock
         vcb/O3UYXGApLiW2sZMY5bvuQmFKSi/1/mp4BPBywmuNld4zdDiyvI9S7SLjW9Tc8bLu
         lIsJorxQKmh/R1fsCWpIU96P0nNNB9xK+DlEtIQQmwjz9cufN4Vs0sF/AxGz2pBDEHRo
         wWkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMoZkB1KVyRyMRxW5iarSJdC9q/OfADdw6jb3dNrKQudycGbvWE+wt05Xm1IE0G4cZZH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7KKtRBsV08RDo8s8b6WsGtodD+KPDqFCOorKejJjI9Px/F/d
	sCEvfIqyOZxW31NEJGEHLrYsiJf7R2YDPA8Doxh1OVDO8kDZWDnFlK+R
X-Gm-Gg: AR+sD10pBPcFkUlkHDb9lFaaLb3DZnQyL7IsPyyJ8WEQaNgPcIvHEUmo5wSWqJ+3Xlf
	rbZj9pScFPR7UxPQ964ol+vCLvfftkWADsY1yRL+zzGF/Wy/Nsi3E7fjJbN3NNQOoT2V9joJbf2
	7hQ0HcDpinxi928uyi9Rn8qSLaMOT06v0a9KgFLFGOi+eyrO1x4DLbGYTKT0dfykuFC0SQGK+4h
	uT0Raey22Y1Ym30J5DCaQnIv5DPdflVzOi5CumS+YgjTTngEEZP9+YjrahoRXKGrc2uC7w1ns2g
	5Q6zvdZ0yVsJFDifBJyY5Ty37mMSJERE3sSHKNP6VfhA4ievnMqUDGKMNuXQMk/GFnLHxmGdoKz
	BT+dVwQevizSbld9n50jsU3Kiafp8VsnatsZb09aZVD86Y1lZ0N0ujOxoA89oxPQ2MK5VLqZr/A
	RmrcpbI8J5ftl7o4mTEZTu6jpV+df/LAv5WYV0EBzz
X-Received: by 2002:a17:90b:5288:b0:38f:1e1a:5164 with SMTP id 98e67ed59e1d1-38fbc52ab50mr7309995a91.37.1785718517639;
        Sun, 02 Aug 2026 17:55:17 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::4bd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm24388949c88.11.2026.08.02.17.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:55:17 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Arijit Banerjee <arijit@effectiveailabs.com>,  Junio C Hamano
 <gitster@pobox.com>,  Arijit Banerjee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,  Arijit
 Banerjee <arijit91@gmail.com>
Subject: Re: [PATCH] index-pack: speed up promisor link recording
In-Reply-To: <am_hWvag32v8yuNM@fruit.crustytoothpaste.net>
References: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
	<am-7_wSb-GNefKlB@fruit.crustytoothpaste.net>
	<xmqqcxw02lao.fsf@gitster.g>
	<CAFwoC-6EvoD-u7oceETi90MJ-FQA2zihdkn1i1wckKfoYRTKOw@mail.gmail.com>
	<am_hWvag32v8yuNM@fruit.crustytoothpaste.net>
Date: Sun, 02 Aug 2026 17:55:15 -0700
Message-ID: <87ldaonhu4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If Company X includes LLM-generated code in their proprietary product
> and it's found to be infringing in say, Germany, then they can simply
> not distribute their code in Germany.  Git cannot do that: it's
> distributed in Linux distributions around the planet, even in countries
> subject to sanctions, such as Russia[0].  We must comply with the
> license and the law everywhere in every country or we risk liability for
> our contributors and distributors.  I, for one, am not willing to be
> sued over this project and the project does not have the financial means
> to deal with extensive litigation.

I generally agree. But some countries have more respected legal systems
than others, to put it mildly. I certainly hope that being extradited to
one of the sanctioned countries isn't too large of a concern.

Collin
