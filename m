Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF516078B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927781; cv=none; b=oa31suuiRwuWTXLaNgKYhjQNrf/8pUGJV0s+tAexHajfN78B8FNDzbvBs/neLKuitQJdn+ZIKjZPPclHkJdKnWJFThkhZRa0nf8eaWI6tLw3uYa45o2+OLAZ3dC9X7cUltL61N0IGICpkw1wks2ycUjwEIhs5l2gCt3i0l6s67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927781; c=relaxed/simple;
	bh=v8nFtJo0o0ppRq/iCp/fWI6vgrwxEa7vZ5AGr6cHNgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=kDAtNYdDMVPNMKLVxiDraUldWzL3w8c6v5QsvTMREsGo14JPCMUsTQwxwp47muDDf25kr3fdyiWgJyvsLk/tWOJJXqYA9WfTxEmC8O2esroHigWdo8/rBNTQko2+bweaAbo6Pb6AhTBOR6tu6n8+8XGNEFXBpxsCha+sMxebD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkbZb8B0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkbZb8B0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc5549788eso2366905ad.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722927779; x=1723532579; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8nFtJo0o0ppRq/iCp/fWI6vgrwxEa7vZ5AGr6cHNgc=;
        b=NkbZb8B0AV4A1vvuZ9zCfUuH2ONNVizsC7kK/yBatvwMPTPAoglxATvPKqT2LvYqHO
         64fOQFNYltEq6KLOcYZYTRtzlYKChscS/BUGMF1NxLgr26jCv+fLXXs1G5MmYtkZ5Loi
         sxd8qGiAbt5exyWwIbYCvKw7rSQ4m55xBqbYdaBMzOG5QonLMc0tCgvlVh9iDpwh7fxl
         mn9hvBF91O1c9AJUYZtvYhlNMaayHV2g6p4+vaobbqgVZOtcxe62MFige9djqI8/THsZ
         To6UuUqFP0gXEUhYL8D/xC1+EmIo8BhZ6UMU6FWeQcDa5HhKtEFvVddFSPtqMI1kZbyD
         Ia2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722927779; x=1723532579;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v8nFtJo0o0ppRq/iCp/fWI6vgrwxEa7vZ5AGr6cHNgc=;
        b=peQjPCq6o4r8Dt5HnZTHwBOKsgSs0RkUS6EdkzG4VTvKa+6+DI5I0ZbZ/MCa8sS+02
         nezV+AGrLgfS1PSNBA2cvZk7Tv3t9CUkFfWeFGQ/sBbW7ocztGXKFhd/otIRQ4D5ORIG
         LWSnhC4GKGbJWsF5Ci7w7vn9ZMc+kRdB3WUtuUC7SaHV4Sw7ty4YpdBDILNYf2zeFWm+
         orDyhiuf4I3zDtjnL06uTlq+yygV516Y+/7XvYKZ5noIMN81Bb+WaaQ/52wVuWXH9Jc8
         AgTLnZpHOcS9H/wvapBFbHPexDfxdTxll5+T6pbsg2Zfv6Y5E13qVSAVAgNHY27nMNXR
         OW0w==
X-Forwarded-Encrypted: i=1; AJvYcCVXbC2ujzwEFaTDEzPdqXCUKVjMnl5+nt477AHt0bTnLlc+nmoUd+5drTYdtyHC9bgB/bErgxcHPUuI01DaptIEJB6r
X-Gm-Message-State: AOJu0YyUZi2GKTo5X66zMGvT0FkXnnKMv2cCS4WO4A09YBUhpEcfFJvh
	VyBU+irplg2ne7cSpPc6Px8xf+FRlPMAsf5xkkcyRqdbBemgKaF+
X-Google-Smtp-Source: AGHT+IE+G1PZp9Nba0CC2IzTSyz19ocZS3GKMbKpQ1Hsb4yRa+VqD5BZoiLCkQVvU0RFi5sRV8NXMA==
X-Received: by 2002:a17:903:2447:b0:1fd:9420:1073 with SMTP id d9443c01a7336-1ff573cc3e7mr198124255ad.43.1722927778894;
        Tue, 06 Aug 2024 00:02:58 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905f9b9sm79727175ad.130.2024.08.06.00.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 00:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Aug 2024 12:32:54 +0530
Message-Id: <D38MX909F2L8.1ABKXL7WOPRQT@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2024, #02; Mon, 5)
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqfrri1scr.fsf@gitster.g>
In-Reply-To: <xmqqfrri1scr.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> * gt/unit-test-hashmap (2024-07-30) 1 commit
> - t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
>
> An existing test of hashmap API has been rewritten with the
> unit-test framework.
>
> What's the doneness of this one?
> source: <20240730115101.188100-1-author@example.com>

I sent a new version of this at:
https://lore.kernel.org/git/20240803133517.73308-2-shyamthakkar001@gmail.co=
m/
which addresses Christian's comments on the previous version.

Thanks.
