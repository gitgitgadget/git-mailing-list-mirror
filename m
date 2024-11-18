Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115F2907
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915163; cv=none; b=rQ7UuFvpQUdtUBk3eoMpPUY2acatrAjkXJ90NQ1960deD/uE7bqCuG4GNL0r2KRnC3fuvHGwklUtpiwntzQVO59bDiDoYV1hQU9L7SrrwZs2XCGjmAeg7wSDc5G6S+P78NfX18ul7cE+5ML/iVB3lg9tPZZfvkmvotBs68JWbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915163; c=relaxed/simple;
	bh=OwH6rdwF4jMkBb0uwyYK2P5ayoKtub5PvPubvgcf/J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sua060J5uVVCDfY6kogFWE504AHjkEf/fHqxAV0taCrR8goXeYMl4KerQHFlf82mayYC/rEBoT7at2/I4cJesn+cHLW/EXFrrUqIpHWNadtxsl8f6clCle3CtRBbPQD9lVLIFYBXj7WzVFhuz8GkTPaltHcwbdDBhBPm6pVcLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBkyIUes; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBkyIUes"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so4136934a12.0
        for <git@vger.kernel.org>; Sun, 17 Nov 2024 23:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731915160; x=1732519960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naWoNB/XHMB6jc21XTCF20GStU+4QJgKHyEnFT4Lsmc=;
        b=KBkyIUest8ahUn2H0ikQcrBc/fIn1ITds/UYBOYEdZVdYD2uYb6KDkuKcrG2Wbc7qw
         idFuR2WSliZi6LzKtdRVAsFtDcv89kymeRrLENwEJ7MuN1ZjKBLS8OUO8AuXtIMvPswo
         e5rGO5cBamem1y+cS6ESn/HNKcUOCA7enKGkIKpBJILCxgISdUoah45WlPO1S4akCRcB
         MGmd9B+x9fSXoFS9LD6540Ca2JnitSmD/mvFiOFVnun3FYo9I5LqGBL071BltVqs/Il0
         H1MTVF6CD1doDRMx64MP9169yuP/mIRG+wbXHv2UB4e4MGarNHEM4hxGe1UhQtYtbNYb
         YZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731915160; x=1732519960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naWoNB/XHMB6jc21XTCF20GStU+4QJgKHyEnFT4Lsmc=;
        b=TshUWaGlCQrrRrRbVw5xTy3sXTzk2MkZrbz1rY6Y7fHQRm+oLHSnqTtwmtfo+cDXa9
         pUuqY/E1jbdJinbLpXc6rbFdLDpbzSSpTIVvolgn8bARRm1kGRRhWpWkopiDvRozCPBI
         W7nAfmtMHX9Whyn+o/pcBOpS2HPHyKMttw6HDsToghuTzh+oO+PIG4F8xf3OHQcY0yZT
         pLaNbyaCpBTOZrqRzmwUpOhuMwBaPNR7GZ9HxAiUn1rmxHqKieOAZ4GDWRYMGss3yC6j
         S01+IsQUkNxotbCGQSyTjSTlGaripQzIf3uG2eF8YjQ5Q1N2s26CDJhJOtX2HNi8MFdJ
         aALQ==
X-Gm-Message-State: AOJu0YzE2jfFDzDwjvaWfN/ZqfGAAYB+FLGWlC2toR0SkSrliw0yxRK7
	yaGLlmYVMqAg5spvP8vYjqxOIS2pG4nEUNTDfyOesThpZ+Ip0bzF0esC0wuPOpgRKmbMFCFGy+U
	IPWannnDvsYipJi+ap4TSeWEiGWM=
X-Google-Smtp-Source: AGHT+IGTNVi4AZWtVpjU/fcYK2DzNKK3R+VjikocAu1VAoO4totduA3+yfSolTz59Z0B+utHT+MEqk6dnQH8xpa8WGc=
X-Received: by 2002:a05:6402:35d3:b0:5cf:50cb:17d3 with SMTP id
 4fb4d7f45d1cf-5cf8fc384bdmr8064899a12.10.1731915159789; Sun, 17 Nov 2024
 23:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa5e2ahqf.fsf@gitster.g> <ba35ba3ec212860a3151cfad582a384a50c55e6a.1731871683.git.code@khaugsbakk.name>
In-Reply-To: <ba35ba3ec212860a3151cfad582a384a50c55e6a.1731871683.git.code@khaugsbakk.name>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 18 Nov 2024 08:32:27 +0100
Message-ID: <CAP8UFD3p3ts_7kvk_Zm2efhcPUcEFnLcLFPAqzb40d46BTVzyA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/glossary: describe "trailer"
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, gitster@pobox.com, 
	ffjlabo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 8:34=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
>     =E2=80=A2 Tags: What the Linux Kernel uses
>     =E2=80=A2 Footers: Lots of people around the Internet apparently. Lik=
e on
>       Stackoverflow. Or Chromium: https://commondatastorage.googleapis.co=
m/chrome-infra-docs/flat/depot_tools/docs/html/git-footers.html
>
>  Documentation/glossary-content.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-=
content.txt
> index 42afe048691..575c18f776e 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -696,6 +696,11 @@ the `refs/tags/` hierarchy is used to represent loca=
l tags..
>         that each contain very well defined concepts or small incremental=
 yet
>         related changes.
>
> +[[def_trailer]]trailer::
> +       Key-value metadata.  Trailers are optionally found at the end of
> +       a commit message.  Might be called "footers" or "tags" in other
> +       communities.  See linkgit:git-interpret-trailers[1].
> +

Ack, thanks!
