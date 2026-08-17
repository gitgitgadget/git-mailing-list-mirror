Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97141A931
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988325; cv=pass; b=TeU8AP2oGY3ElqKHMtfNmfVugVojmAdr+iTVcPL+3pG+mAd4t5QsfJ1aLy9iktyvkdAoSC1Yk2wJVqOUgC2tFg2dmHeHEfW1HXYOce/uOm5tNqpIsc03u9Z6y7XCtNZX71tbwZONGnxDHn00WdCeYcu9BBFT8JH62Jcm1Ikixoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988325; c=relaxed/simple;
	bh=xal0JbO4swuGZ+bNGtgiu2fbUA4ASeuMiy14oJK1Is4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xn9vYDm5riHgWfPBO6bH2GV0T9GOThuZea4vLcYAwYzmaiVLSZJ/cC7LVjbrsEp705UHxVYL480TmHhgUiIY1yoIMxlvgxQ5BmwUaVTKxuWOoOLMLWTfRNblc7KIu3wg0X2i7Tjbz+jhsmElfWPn3UUK3KHVLobtexiazYTEHR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSER70ft; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSER70ft"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so5192844a12.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2026 10:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786988321; cv=none;
        d=google.com; s=arc-20260327;
        b=rHypUE44aOBEvDifukJH0V4C67ANk5PLH76cdJtPLjHpvxy6T2LgH7b1N/nnIa/sX0
         g5W+Ly9IeX0LzBt7mw2Pf/mBMVh/vrjJf/LxdGEAHOXDBHb8iU6xi6yHLcOYGsYbTsQT
         x7t3NE89R6jRXV3M19gt6TKnugc6uwkeakY3W7iAOqJHzRbJQo5rDFQ3WRHdOX06KpPm
         Kz3D3tFmLsZIHsMkDknBH+g/5uE6l90MOylvCgrNN/x7bvxEziPhVWZ2Ksc438nGIRdp
         TD+G3CZCoqkvhHjEi6U3h56qFUpYokr825/AkUYliDrRcGkTqmNq3PcegKY9HZxV3TKs
         4O5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ixfyvSmAWvCMCMGkw+x/ZKDUGqg+1o9N7Y0wbvrCCQQ=;
        fh=28gejP4kX9uM1iU8tytMeFyepwfl4kgGd1Jnul80Swg=;
        b=FNgM9gtU8rUR8/3xVQ2uXDrLxAz+mfCobzfvW578o54oDUhPcECq+xGwhUNn+gYJ+X
         gae0bo6eqcVnxxAMmSZhp+W3EVJGOS3EJtz7y2C8LleTe3+gJ0jCGZCeLWs7bb5a14Wj
         qejN/KfAFMzcD6quJh0R3lwWJcE74WA27Nd43pcFLo0IC9LA8okw8AkOBgj9rLtx8igJ
         8b1m4u5ZGuQ5TiRGzGPYNi6zwzUGUEoFhZqRv9jdYtCErcWNmgAC6StWouJauNBnMn+W
         TRZ8pvAqP/8KJ5ffddgg0pjOnvl3fnReDbqvv3RWD+0w2t28Jm4SzNhXvudDMnbc/NQG
         IWrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786988321; x=1787593121; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixfyvSmAWvCMCMGkw+x/ZKDUGqg+1o9N7Y0wbvrCCQQ=;
        b=BSER70ft5rF50DwZkU2IBFyZv5WAmUDf9Pa7s9Mej5/CoKNAH6sxa/BFXSn43nHNEu
         dZ8cLVXfhXVswi1CRTh4FjPbGWahRFe+3n5PAeJ4oDhDPruKsi8ruk2g7t/jsT6upjUR
         Fs1AotGVF39NmBu+gBxYRx4oQPdZ3f+ZVcmyitWHatFeZ+3Qtxe5JdNXA2Pa3TEenYhs
         DhULid6h/4Ns5wYNuUXvGZfMlTDFcIF4eEMOP4oNkHikhxFrxsHe/7WbD1BWz0EBEELj
         TSZQezyLpONccMTGL9+jTyhMAAElZxIA6IytlnEHS1g5tTZ63vyYAPkysZMfJ6SKtMkk
         NI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988321; x=1787593121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ixfyvSmAWvCMCMGkw+x/ZKDUGqg+1o9N7Y0wbvrCCQQ=;
        b=ROcIxWAeptBvktl0Vg/UlBIjeXm6zPtuau67+kM2o3nd2UpDnBsQpLXoSlbBlNG5fg
         EfiC/Nuypu/N4SOxwZjJNT99WgL11aDKZkrwi8+HgWERWbWb6eU37dN2Xd6oIceALGkJ
         1FrPpWePAjwG0VO7DPGMyZ6O9/pvyZeLIkNT2v4w5vpfkxqDMOjzwg5B8zL3wI5sMPZJ
         RSfssvja8hsoMijOSLayJwg6yMkRcDC64grNp7/97kXrPv6iNP223fGZVwN6WbkAwoGq
         obWyE6iDH5Bdi1yrLlsjdQDRshEXAvG4reT+QtnWnDCxqoWuQJb9Wy6RiDEVs2AwEG5n
         oGJw==
X-Forwarded-Encrypted: i=1; AHgh+RoKrVlM8z6VdAssQjTlc4psL5xJDQ54zPsJTykrObBIeU/Z2J+cfmruRzJK97xdfXcuGlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqeyVDkA1j5LTnmBEiudULhqu+xn8zO3mx+CkWuZPgIEdymNH6
	+4YPtpPFN9bMcG4Vsm6myp8rAqWHmDW4YAWNrICl12/TYzvi/gxPtM/dKzFXpp45mFbeMHe8YxH
	RAMhK2KLa61GzNa9lkSdQbk3sr/U6sKY=
X-Gm-Gg: AR+sD12BK5sOypa5baUYczA/AjSxmKaOd9jLjTmxnK38AK4kktp8csAxj3xPYpKS4XZ
	Ka+iSpbXGx53c9O6jPHfcejPpp3Eh8i/XN8PKQgQeRBpPh7QT7zWuTpPO7K7i9guHZSqYN2i6hu
	T2VpeDM0cMbu9F/N96NtHt2Hm6HQMpbmQdeWUSOuq3vVxdkKNGWNPQOvIANVBFbiR3XkeeUCtFc
	QZTqwWmPANJwfGDrEplwIvWI/PbfT12M+xKo2rtIk61TErliMutWwNNzk1ls1lt9OkG/9jaNqWf
	aLdX/NsnsHAtiPgxE099NYUawJMjDwdb3T2Fq282I2DZcXnmxQ==
X-Received: by 2002:a05:6402:360f:b0:6a1:284f:7891 with SMTP id
 4fb4d7f45d1cf-6a3e11feb31mr1040467a12.7.1786988321438; Mon, 17 Aug 2026
 10:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com> <8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
 <xmqq4igyszeb.fsf@gitster.g> <f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com>
In-Reply-To: <f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 17 Aug 2026 19:38:05 +0200
X-Gm-Features: AcwNN1VYjnq7WSclPEseWddVey5S-mmix0XD_vBq3EUhr3SbNWivJBuqBKpNKh4
Message-ID: <CAHwyqnXVepLAsNZHZe_qqXbqYjBt6RpDXVQUP3s7vPwbEg2FXw@mail.gmail.com>
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>, Matt Hunter <m@lfurio.us>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"

>  >> Inspired-by: Sergey Chernov <serega.morph@gmail.com>
>  >> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>  >> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>
> Thanks for the Helped-by: trailer, but this and several of the other
> patches are missing my sign off from the fixup patches I sent. My sign
> off should come above yours to reflect the chain of custody.

Got it, should I use both headers?

    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>


Harald
