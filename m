Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05461400E
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657265; cv=none; b=AoScaw24OeVa7lc2Eg7YRUDhBRQ/wHOjccts/IloYXBnWSBkdG+a7D6jVOtXt6MJECDR7iLo0nh7vO7XBs6smBAz2eCfU7QCHXzc73VH8Vq949iK9yLZwDl7MndAqKgAexCP1fQvs5Evu3WqdxpfqjvzAVg/AeuMGd9CMoKtxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657265; c=relaxed/simple;
	bh=/GFyQQRZy2cABI6RSvglhiPsIqg4fAhUnLRd26e4dDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SXKsm0HKAJnCIsFBWeMUlC7+Ksaug3zEjBWFnxNZ433WgVUyuAUZBHTxQ6TJY98PxR7XWXmit164hOxjj66GgIVUJi/8K39FRWbPeQ0tfQMkevyAk876TfUG7uoyOS7J5xekLkI3olwm30ButjeapaSv8IQ0OMHSK1fwbi6BIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoR3dr75; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoR3dr75"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so7758620a12.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657261; x=1759262061; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GFyQQRZy2cABI6RSvglhiPsIqg4fAhUnLRd26e4dDg=;
        b=JoR3dr75a/Ph84A1XMCxZUilO6fD3vZIdP4Lc9XFHqt9cJQPt9NN6Y1DgG14SKy9TK
         SMEeuVLnHpx5SWryPQtC6Ubu2E0S/+qY05wbSYf/J2iieFF9VX7bF7PYgVtRoc+DrjZ0
         bzHZt4DZrNPBpRc31lZ0HZXuLVtvnCbLYyuaaz0UqlHA+t5FUom2YLgga5hbd2Jbm6ix
         SyPae8y2fjIN61mraQalm3aaM4uvlgyi+Tf8nbZ7Bjbf9t0FnlXTQ/+GQpKYKdnpCt14
         SDF0MQMYft1bZeYQrpBKR/WiGtJzPs+BDSEiBSPKVM3m+1sv5S97XFSDTvih3EM5mF8T
         XZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657261; x=1759262061;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GFyQQRZy2cABI6RSvglhiPsIqg4fAhUnLRd26e4dDg=;
        b=CyKMe67JEwDHyKbCZVRjMi4tTFw1PE4WULy2L0PcTGNu9Sm10Z5EpQ41/kX4U3/Pcy
         Zu1eZyFpkcZkZum4rKHsxWkBL3fNC206LzlIC+AlwvF6esHXb3tKP710EEuiDjAOeJ0c
         0T+QtTimEZFfAOLX4w6KHPXzPWdL+5NiWQ7Sp6fCsZmRtDBn9ZltlZmTsF8j3zADPC5u
         /o/Dnbs0KEtMfS1tRRN4Xr+sBcsoTUEsyqLcTpD6fUSJNjhS13rXXdT4/tvm1VkDfcUn
         8RJLsBnmAIU5YoMVY0MdQAeFLtEzYNSUYkkp0ac7ZNLWwp/0Xz6nD71c2AVb1HvNeUX8
         LYBg==
X-Gm-Message-State: AOJu0YzB6YB0cfay8XEXvWpD9dJfy9Aa+dzMv6LPbNZWrkJ5D9/mjL3O
	E37/LPMpvbLmx01YR48xKvqwDbdVJ/Pu/vJY4HEYdllz012DsJVtsREQ9al4m2OOeyj5vJFJtvF
	GjobpN3+zhqQSN4Zhspf6sk0udTf+wp/Wxznb
X-Gm-Gg: ASbGncs4I32mR+Hjp5nzKlHOHpbAtFOPSrErmx2BpCESiQpAUB2Q5nHtfxxVDIAFj7O
	Af4+xwR5QX+OE6jpwLzyFeBoQXFjplvCK0WV+1uSZuupc4FSqppR2GgvA+etkz6kxWhNToZpVUW
	DfXVa71KGpMJK2oNQzgKUXwyJM3s4HqgCXpogEQEjdM6/9GidrwSxvq5RExA7G1HSCHawbc9EA1
	Crr8laikjWjxiaxai/bXi3DJHJX9RX9da7HcsDi
X-Google-Smtp-Source: AGHT+IGBeKTTkltlUHrmybrbg2al27Eq4TG6WRky75nIbgG7LtYu026V8oape1AwlmwUy0YX2QjEMCrby4GffxUDZ1Q=
X-Received: by 2002:a17:906:fd84:b0:b07:dbf9:a2a2 with SMTP id
 a640c23a62f3a-b30274588a4mr391834766b.20.1758657261429; Tue, 23 Sep 2025
 12:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC9GOO8KCuLCZguZm_dg2MKS=cO=YUb9Uc+VLNTZSXMiO9wcig@mail.gmail.com>
In-Reply-To: <CAC9GOO8KCuLCZguZm_dg2MKS=cO=YUb9Uc+VLNTZSXMiO9wcig@mail.gmail.com>
From: Marcin Wisnicki <mwisnicki@gmail.com>
Date: Tue, 23 Sep 2025 15:54:09 -0400
X-Gm-Features: AS18NWCttjFinh6t5td5DgHn2gb1NyQa84KBDOhQmVjQmz4R1B7g0rV1QCfwiqk
Message-ID: <CAC9GOO8MLaBEfmyJhq3SHPmOCv+6KVLT_pW9xMm5Qxu4065pCg@mail.gmail.com>
Subject: Re: [BUG] No context menu in gitk on macos
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Nevermind, brew upgrade 2.51.0_1 -> 2.51.0_2 fixed it

On Tue, 23 Sept 2025 at 15:35, Marcin Wisnicki <mwisnicki@gmail.com> wrote:
>
> # What did you do before the bug happened? (Steps to reproduce your issue)
>
> 1. create repo with one commit
> 2. gitk
> 3. right click on commit
>
> # What did you expect to happen? (Expected behavior)
>
> See context menu like on Windows
>
> # What happened instead? (Actual behavior)
>
> Nothing
>
> # What's different between what you expected and what actually happened?
>
>
> # Anything else you want to add:
>
> [System Info]
> git version:
> git version 2.51.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.7.1
> zlib: 1.2.12
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Mon Jul 14 11:28:30
> PDT 2025; root:xnu-11417.140.69~1/RELEASE_ARM64_T6030 arm64
> compiler info: clang: 17.0.0 (clang-1700.0.13.3)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
