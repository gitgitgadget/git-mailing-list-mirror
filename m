Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4718B0A
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765252282; cv=none; b=KKiOEaboZfT7x4gQvBUsjsyAJBayig1eriQNGZbwpXJOTyC7pWyykRHeEHNTnBvPVMWQFHq41CtAN6HsPjgrS4RbWkogT6vslSeMYI/bbpE+z2PbBas7/QGWxvSe1ec6t9QuJAw6j04c+yWdndpBN5uf747T0//AfPBOgoTxoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765252282; c=relaxed/simple;
	bh=0aXu2IzksIM9rV2wuKMHMbfv1Xvol7Vm+vqRSuk22gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btuV6+TMcoinpTZOsWHE9piEvkBU70WCSEwKnmacs3FuLgYMYuxIEX2B8Bse21NjZVVR6COSIM1d2iYRxWl+a9+7lHJX4XbI+6F6fCk8YUrF+3NKu7+sAzFOyn5i3O07nqyrfcNTSU6CMmsQ0RAKNyRXC+59wTOyYTcFwM56ZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frlqvJJt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frlqvJJt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e2e628f8aso2381799f8f.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 19:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765252279; x=1765857079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HI78RiLC9MBVJl+1f6sqknkRX1xCXTVbRy/q/IF4THw=;
        b=frlqvJJtoJrKH9FFfUCQaBV9jup8yCMZMkdbvM7+a1UYQCIIWG/ZXaxGx/a7nsiMeJ
         LJXO5h1Lea9pgPapkmj7kYvcB9XLLmFca9V9a0+I3MO4P2SqgB1v8LmLPjaUIw9V6mFB
         U2EspGoIXIJVJGepiABmXH6c/fbjmNiozEeEL2nuAOltnySojar+7HiEkAPYvSR2KFUd
         mdf3Ca8n0fX9MMCaV2yex3eq+mV9KpF+dr8n8d4wt07+G6uC31A0O3yIL/7OI7snnfvZ
         w+VFIaNM7YJFbkP0HvpCmYpuKXwbGTzHf1dyyb5YB9GznKtj2PZrshNTZ2333XozxgwP
         8LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765252279; x=1765857079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI78RiLC9MBVJl+1f6sqknkRX1xCXTVbRy/q/IF4THw=;
        b=n67iSDrssSLfr+6wcn9N5oh4Mm3RnUmUpkmJ8VfldzbWTntZvuI9C58q8mt6or1zEl
         yKQDkeAxKv5LpVuWqHV8tZHqI84SP8IGGZIcf/WBtXFqiPa+k48RHeqt8bYqzw0gRUkK
         lJm5m/jcv5Xi2vYGTcyWKblqEq8NjLyv8u0tg18a3+bjKdvnC0CfMy2+mGBdTtwYzOvT
         zMm0dsWqD/pqxjM3ngdszGcJsxrLITD5W/7Fp1gGx5B9r/IjNZC0L5KwM2DXv2TfrwjP
         CEVmb2wXQxiHXZ1hOARhiP6zKWxNN8t8qgxaX9Ne0+yvL0Eg4+hOWnRBeM2ZDNEgh4VH
         T2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXHwlUL5XrkuuGkzB1iBt424UTUAz5jfOx+I3V213T+6+qEXxzQLLIOtqHQJj0lJUcQgrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApmQvhN/7nymX95k6CJGsSj4xuqwy6SvPAAJ3lH5t0q0DNDNy
	yklamEgu81iAtdLams+rO7/GJeWMG7Gk39LstwXNe0/d4v2lJd8GZycRUBunRSVbZf0wNB1SxKj
	QLXHQB2szx9AMDHX6s1Rm+8trwam7RaY=
X-Gm-Gg: ASbGncvEgw1FHxPquuLQoez9BcDdvr7feYr9MmxRfOpM0aVIZMmqxqL056+wK7BrA90
	N2i2YjidRowaEP1J5se9tVAxPoUfojFP40nylf2edlhrYbbNK8WDVPAW5uReTkClKGVT01ts4Jj
	KRre8aCf2PQcRqJApIWXb4wPFRHdfFXJjpjaK+6TmkjEj0CyUq+UHvtUNYg2LHqGSuLvo2TxauJ
	OhP0HLJNnQ5T2y7zqr5NXL2OOiSfRvjH8BtdRsIeWVauG8Pv7SvQcb1wUFEB/b67KSPovuSjKxj
	7VW6DQ==
X-Google-Smtp-Source: AGHT+IFEE5Nb16n/xVX3rGsEeo5xGRQZHA2y/Fazi3swdr0xNZSXGeOkZ85iUAqE2O5m7WRAFNBWfFjoJBEPAYb+X8g=
X-Received: by 2002:a05:6000:2f86:b0:3ec:ea73:a91e with SMTP id
 ffacd0b85a97d-42f89f0fae6mr10986246f8f.12.1765252278916; Mon, 08 Dec 2025
 19:51:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de> <CAOTNsDzmGypKNOg-pFuW45qst+g8=LHQbdNAgtVYJvD8pxa6_Q@mail.gmail.com>
In-Reply-To: <CAOTNsDzmGypKNOg-pFuW45qst+g8=LHQbdNAgtVYJvD8pxa6_Q@mail.gmail.com>
From: Yee Cheng Chin <ychin.macvim@gmail.com>
Date: Mon, 8 Dec 2025 22:50:42 -0500
X-Gm-Features: AQt7F2o9XzJDMTK4LtFI_N_LRJUOayo_YDYC0KyED11azaiABqPh5d4Ir1Pv9LY
Message-ID: <CAHTeOx-By55enMxt7YkCd6e=TbE7v+1ipN3wSFQc2n+9F_L7_Q@mail.gmail.com>
Subject: Re: t3900 failure on macOS, iconv(3) broken?
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> * macOS 14.8.2
>   * These tests pass.
> It looks like the system iconv is broken on macOS 15 or later.

I'm a little surprised that these tests pass in macOS 14 with native
(aka not from Homebrew) iconv. Apple replaced GNU iconv with a custom
version in macOS 14, which also caused a fair bit of breakages among
other third-party software. I would have expected this CI test to
break on macOS 14 unless this is a new behavior change / bug
introduced in macOS 15.

But yes, one way to fix it is to just provide the Homebrew GNU iconv
via ICONVDIR.
