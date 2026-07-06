Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B53BE659
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363014; cv=pass; b=sgLTXR/BeDiy4a7/ibzQTMPIPawQHk0sly/t6CMeN0NB5dHAYEOafu0hCT0b3NAdRw9Mi1/EN57E1bTIwqB2UJ+xFgdeJgBT+j91rSi/wGJQ5kAt9sWxf91xe0caw+VlSgWBd3Bvi3j9KX8/MuF/RKX2Oe4bivtPcu3GKkC7sqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363014; c=relaxed/simple;
	bh=LInLiU2iLlxdSC3avvg7RYrr/vxxCkXHhGn3Xnjc7hQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hWwYz2uMKYozk6+aMX7kODPRbrrzlxVCNEzlhtrKeCXA/167Ny4p8h5fwPuIZug5jWDz9YGWXOD2Uuhg1OPhmjCdHlt9T95BPNDCHcV/IG13sorqqSwuEP4n3QKUj660bqWrxtmhh0blCtk/+h6v3kVY0u5qUfIXNH5xtVoeCBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nT4Blkui; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT4Blkui"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cab97c86bdso2115ad.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 11:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783363013; cv=none;
        d=google.com; s=arc-20260327;
        b=gV9JHp82kC8htNaVLBV2T8uJVbsaMrprpILkYz0UGEPoIOyIQSEq0vLgaxNggWVe3w
         eauUe9aZfq7+z0w2J3wE0Q7BDOtF69LF/begckg6RBYboCu1HOF7bh9gjl+44R6j9boQ
         vN6LpYdFEGSxQNigA0jfLS7+TiBRFnMVy3rbw/YHHWr8Qak3TbcqZXO5uAwwjS5J2xol
         kbUWYSedkN2JRtuCiXFnxXYqPwrA7c6WmqUSB543YMp2vvlosBmGBFYcOJVIVxbcoBXq
         XdZAdFFEM+z+g98yRUZ9k0cUxgvgAojgJbhDyj/AiuN0odleLegu6CIH8yoHpsVb2uLD
         aC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LInLiU2iLlxdSC3avvg7RYrr/vxxCkXHhGn3Xnjc7hQ=;
        fh=VGsH0F9CzJbHjkMAgawjZU1WPVV6BbvBPkMnrmQUNo0=;
        b=BxvvWi55wvR6qrzvJ9lhHi4uoadbP6o09kdEQIN3Pb+FRDlZifJ4yLrGbKucHeY36u
         nerNlhneCJYRHSsa+80slqjDegSPftI1Zotr2rl0HerT+zlnSXB07HcPdvu453mhV690
         HXuE6CNBeWRSHjqRAb0l/PX0f3X6nY752yWf4CgRrg9TKJULkZB4N/1ZWm/mKpVOsai7
         DFXqcA+r4I+7BPgrQXUiNIHmTbR2TnViGX2iyNObwooTnBaWtgPpPDY2xeyCcUuyHW2n
         UQ9zdM31SirjhbVbGMvbi4EUfgQiKojdg7TtSOhWtyXYGNI5gEHFGScGC7dMwPLrTnPo
         VvCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783363013; x=1783967813; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LInLiU2iLlxdSC3avvg7RYrr/vxxCkXHhGn3Xnjc7hQ=;
        b=nT4BlkuifFy3D88ZUJKp1hn9iTO5uFCv8HtFmsksfS+VrnLaJcQ194C48ZWY8EqoLu
         CG22N1SZRPfKdgKyY5Rr+nKlFrdNn7bhJG8EtBUMCNU004wHMmqnSZ6ArVrmziFwNEw1
         LYyzzwcwSCkdOhk66GBqyutDlJjWWVdk3YtFgKdS1ltX0REV+koysZMcyVbq1C7wBgyB
         8QWbPMosQXFrFFnsKbWLRKexQKfrRwN3Xh0tTSgxlR3B45AEbYACWIZK8s5fMiiTv2G8
         4zxQVEMNGqExt09uskMrCr6Vpr7/g8wywbbDUMBfGtjZXnoMqDcOGeNYKw2g5DXzlKOF
         Xqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783363013; x=1783967813;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LInLiU2iLlxdSC3avvg7RYrr/vxxCkXHhGn3Xnjc7hQ=;
        b=TH8pt6vHy6/UbwreWkLV15wIWAKP++gO9LpWMge0CuAJP3P29ruBbWhho/AapH5HMW
         ipOUAOTmLosaPTwml5c/nN/tBHiRpW1Rk0PvEMDQuJWyacAQLYQgMQYyFwFEJwXU6BmE
         mbTV4XAS4rftRo+fo9uFcMfWNm0fnNJghQOpvOsQ3KH0qmFTyqNcaJr07MGEU+zDBH6T
         UtdYIwKO3odWjmWFMwg834tAwIJH/FBRKkaue2BJTj7X+3Xi5lqNnH7nLN0SC2sD/mb8
         ksOHpvSJQhk18bVqRViHRjmQ/DN0NOPf0+SFV2O/arW1mCxcIJDPcLnMmgY0nClt7SYp
         h35Q==
X-Gm-Message-State: AOJu0YySGxlQ+pkbiZnPcnVAeoICCrGrj7caNViZgt8X7w1/rkgTf76M
	RZtHcAvSRoI0UZtVMmPzB88hN2hdxkWaqla15BuA4KeXNKhBqHS9NTQJZRvKtWUqO8Nm1L0djpR
	Nqfu/qJz4nWY2uenwUTKHGq4iH/3KmenUhuRmTWz21kNW89nrRZhQD9WV
X-Gm-Gg: AfdE7cmjVU2E60pxoAQNt6G03a+YtnLTqogz+cCI2VMsPb3udvGA0mD3VEhI345kxsy
	MoljXVT1wcnJzb/4oktqDI+rUpdZnAF7IMWF7kTvSWkmA4GA2nA/K29QktawPsY2g0YP+VUwDBh
	0dsRQxllVMirbqCFoPxcwUiPFededUTjwUFxy60Etw7irJJEGox4yfVSW+t3tKFWD2TJQIBcdaX
	zzyvnkn20lKIOP4sRRULzwtvtBFPtjlAayONqg2SijdaVa6WixFx7WSSSD9uBsEbeygm2yw1Lnl
	5lrJnvn6eyDGkddBxSP9lPHKZiI=
X-Received: by 2002:a17:902:ecc7:b0:2ba:73c3:49b0 with SMTP id
 d9443c01a7336-2ccc3ac6512mr853695ad.14.1783363012244; Mon, 06 Jul 2026
 11:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shardul Natu <snatu@google.com>
Date: Mon, 6 Jul 2026 11:36:40 -0700
X-Gm-Features: AVVi8CclmK7Zp4exupyMd1pk65btPpFBcEvOcZ8s69hlwA6iY2q1dKBG7NDN91E
Message-ID: <CABaQWZfS0utG6jfLcHTgHGYo_BTVJr=ZO4NuBDRPKRh+UF4Cvw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Makefile: support universal macOS builds via RUST_TARGETS
To: ps@pks.im
Cc: git@vger.kernel.org, 
	Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>, Koji Nakamaru <koji.nakamaru@gree.net>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Shardul Natu <snatu@google.com>
Content-Type: text/plain; charset="UTF-8"

> I was wondering why no other target declares an explicit dependency on
> RUST_LIB. As it turns out, all the other targets that link "$(LIBS)" all
> already depend on "$(GITLIBS)", which includes both "$(LIB_FILE)" and
> "$(RUST_LIB)". So shouldn't we also depend depend on "$(GITLIBS)" here
> instead of on either of the other two variables?

Ah, a much cleaner cleanup! Done


> s/rust/Rust/
Done


> With this we now have both:
>
> - target/$ARCH/$BUILD_CONFIG/
>
> - target/$BUILD_CONFIG/
>
> Is there any reason why we have to have those two different layouts
> instead of swapping the order in the first item so that all artifacts
> are in "target/$BUILD_CONFIG/"? Essentially, what I'm proposing instead
> is:
>
> - "target/$BUILD_CONFIG/" for the final universal executable.
>
> - "target/$BUILD_CONFIG/$ARCH" for the per-arch artifacts.

When you invoke "cargo build --release --target x86_64-apple-darwin",
Cargo automatically places the resulting artifacts under
"target/x86_64-apple-darwin/release/".

If we tried to force Cargo to output under "target/release/$ARCH" by
passing a custom "--target-dir", Cargo would still append its required
"$ARCH/$BUILD_CONFIG/" structure inside that custom directory, resulting
in nested paths like "target/release/$ARCH/$ARCH/release/libgitcore.a",
or otherwise breaking Cargo's internal dependency caching and artifact
sharing across builds.

And so, we have to have "target/$ARCH/$BUILD_CONFIG/" for per-arch artifacts.
