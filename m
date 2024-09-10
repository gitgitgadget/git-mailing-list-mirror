Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839137143
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995116; cv=none; b=rPhZoQkhSGfp2eQLAndYQ86vnuKNVPbOQU/xDqkQl15fsiJJb8ZT9AyJCsrtm4lr1lhjit1awpt7hyut5i2C/yuHN3BliKpXN/9T7whdzHb/7mBlzFgCTmToCHPHKH7mrFKCr2xAr1soySRF+5WpltYjmOEtsmmLW9TDu+O3tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995116; c=relaxed/simple;
	bh=4V/W7nWFtKy2gyDoJSNG4KcZ7nJbQEjI2Dlp2QPijkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4rcWPEG+b6xRoAuJ6apkpmeXDHCg3sCdAHqMqmkzzLHIuurd6UWmyEQAOO5bThKj4uxCHUrROGCTYaYI/pPPixQG+GKLcxXOA3WKQ6N+FmD3vDbWn50KP2Zj8QRVCoAnNJ7T2yJJRJhbG/kQhxbG0XhvhqNV5GNWdhv4PdxA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vgta099K; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vgta099K"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so16598a12.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725995113; x=1726599913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4V/W7nWFtKy2gyDoJSNG4KcZ7nJbQEjI2Dlp2QPijkg=;
        b=Vgta099KCPH951d3nfWKRNyMTeEAmk63MnsIOXIo+BFdrX/OCrGdozKw2PzNpswX2Q
         jr8rXTasJAjgQ93ucLnzOQCW1LWF9t6RVqIPpOLL0rwVTvpNhDdMKMWIH2ZCTWhI9GXh
         xqERr/W+0cvnk82sMd9fxvuMx3x0Anw1mJP02aT8pK8BAKqgjdp8ncnBgJaiez80YZP2
         dFxg/oPULGDnLLiJ70BR4TDf2woRDi7mYCy0Ykn0058ZUVUMn0Z5DXDTSjYjCcroXph3
         k2MHIy1nURR3hWxN2eFxOa76OVrKGMjVLOIt45onC1QWXJ4O9QxkhL/wbpI4WOvrvw00
         ghXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995113; x=1726599913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4V/W7nWFtKy2gyDoJSNG4KcZ7nJbQEjI2Dlp2QPijkg=;
        b=TDjHGQBHMbJeI8Xp1EKVQ3db6c7P2b/6XnUnD7FbAq/oVxDfJvfXHlE1o2M7d7UtGp
         QKUXFnc+ge050pALQfo0UYgRSgr9CBD79k89JkE18M2917S+mix3Pz3zuws3Dsm2PM9G
         n6A1OFp105+WyXQbQAYFbXzGyVdQ5KbDol+agk1FxK8pPE8VA89NyaEo27jfksyNnatw
         XXVpimYCWYAdEGrvxMn5QWHp/7gW1CiQ4gmjy4JdIFwNhh4tpODOIX3UiiQf4ZvthQk2
         r9pLKK8ZSjtP93tn74ieVaogInWP5ehIMJyW3v9dBqu9kvUNReXVTWMMCS4aLtKiWCTS
         kMSw==
X-Gm-Message-State: AOJu0YxdQcwMIeCYW6FXA1aU3cTnTvQg2e2vQfpsY/wZ6gLSLqR8nX3G
	0QJr4I0eK2uQ2dUJmLJht1zgAZMLQzhlacjseHorsbAoxiryFyRMpALEpNLesSvicS1TLO9ca3q
	YHEZHnCWiy6cldfFy49wmJ5oYRzC+nNvWJLHJ
X-Google-Smtp-Source: AGHT+IETKLb8zaS8QzYCDWe4nMCRFJCjaj7n8WaFOEsxiPd9qUGv0SYlmsFEwoqs44ARcWejxLSJis4lAtXLP1y5RV4=
X-Received: by 2002:a05:6402:3548:b0:5c0:a8b1:41da with SMTP id
 4fb4d7f45d1cf-5c40ca12fd7mr35410a12.7.1725995111982; Tue, 10 Sep 2024
 12:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com> <20240906222116.270196-2-calvinwan@google.com>
 <CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>
In-Reply-To: <CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 10 Sep 2024 12:04:41 -0700
Message-ID: <CAFySSZDFWinMHBjgLn-Vcc4U=_OHtTQc2UmWSyeo20C1TwLVoQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] libgit-sys: introduce Rust wrapper for libgit.a
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the catches -- will fix in the next reroll
