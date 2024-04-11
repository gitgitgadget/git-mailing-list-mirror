Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863015E8C
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869125; cv=none; b=eoudFP2+ngba2j8dGH7a20hO+hrVjg/7GKVWPtY99HL5qUnYYhV7JefGAy5rFOpaQIvkqgWrVQVsKswNcTgYzG2BYaOExWCtpXy6KVmfzZbuEIxTFwUiWLGtIc5VzPoipcQ5Zh3Ujj3vC60p2NT+JxinT3cuXFMB6SIMU3qfxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869125; c=relaxed/simple;
	bh=xvOy5YFd+3QH1SuNTbp5GFs0HLMliLErHMJRvHk8jrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cntzu7rbUm1xyhM3gOoZ743dc1A7BasIEePpFSCMu2gr53KcEFVMJ0S/j0kZ3sXMiEeTecg6c7/slM+1Us6G/6ukgJmz7Nd+ZXsEnZ3rMxWClBMmhHMy+oxnjPjkgGu5C/XYcbdywN8ElZ1fC2fs6UO+tQqs0z2GzPYe06Kse64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ul+wVjiN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul+wVjiN"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44ad785a44so22894366b.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712869122; x=1713473922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvOy5YFd+3QH1SuNTbp5GFs0HLMliLErHMJRvHk8jrw=;
        b=ul+wVjiNgpEXFQUglapdKmUDzLhppB6mWsC7YKEXKlfYa6uesPuvWKwwuCw2GTk/XD
         Gwlh3JPdff7ESVosKnJNBjLFSCdfeLNqEa615sHpRFFMwApL4ime1+diqzqVImemFWVS
         2jUM0GzdU7e2ETIBgPyGL7BQiPQVkVLJ5CWN4z8DE01QKnkjseyPuwa/TTD6s6sBODUs
         P8r4wM0H57a2TqI2ySisi/t2Qls8Ephpy/tWdEOmxRbe/4g3K+MZhVPA5XdYJGeLL7VD
         LvRfAbilFVjedDg/mHOC5jiyMZqlPI1lWsFSOyA45e0RYFOLcYCXHMXHYzKfAhlF8+Hf
         gl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869122; x=1713473922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvOy5YFd+3QH1SuNTbp5GFs0HLMliLErHMJRvHk8jrw=;
        b=JhgNVCJQ9LQ6FQJicJIbX8K9AOmbEJ0jwRBBByPmMIvYqoLKZMJd3vuYu8FLs95ar7
         gDkHZIFOiKgcyO1+X3X5zfAlhbn0l3iQlHPIeJSmHOjakzD8Qja6a3CPmP0xh92uNd/3
         RMbOzzYKx1ihhNqFVmmAHBETP7FPq2oMlFpM1yDK1l1r/xx4oqjQ46PdXv27+Mm6IdkM
         oy6bm16TiJnnvA1oIGSiTGfqV2xDllFi+S5Gv/qovX/MlpZkExLlEyswOm/uZHczblO3
         845qKZZhSZDq1GOnikURYpoju6CXvL/SSQXCjcK6XFysxl42wORrT+7si8j1Z4LssCov
         uifQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNtj4LBfD7vnwcQp8FzD5UYSzkDevnjZH8skNbrEMAblgSSqfJTJTQmJ3yGGTxfbVGNXERrieL62zRNmfxOEimSIQb
X-Gm-Message-State: AOJu0YwGea0tTfDPzyM/+bCWpi4YMF4W/2BebrX8vKgDavY0IqtGdx7H
	i8GIUQrc6MQB3D5Js7qki8m6V95/HsTV3K/xlTbHGpw9CfGaAZ+czAfNdFf58EoHEudasnTIDoT
	kRPOjNRrorAtAFIGG8Jwn1e6N9TjiY771XNR7+uNhZ01EE2htww==
X-Google-Smtp-Source: AGHT+IGiqDVBn5ea/u8Ou6m+xxMpGZ4wU63FeF5ICdBHsZsSxbfk5tC1ORp+MaPG3Xhj1j4VDPSVxe+eM/x4pHafwr0=
X-Received: by 2002:a17:906:c105:b0:a4e:cd5c:da72 with SMTP id
 do5-20020a170906c10500b00a4ecd5cda72mr543837ejc.63.1712869121577; Thu, 11 Apr
 2024 13:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01e101da8c45$66d33240$347996c0$@nexbridge.com> <20240411203225.82557-2-kipras@kipras.org>
In-Reply-To: <20240411203225.82557-2-kipras@kipras.org>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 11 Apr 2024 13:58:25 -0700
Message-ID: <CAO_smVhB0QUomdSxGqwvFKrb53NGMZE+y=3zbRnQX+ciLRZyOw@mail.gmail.com>
Subject: Re: Short form of --force-with-lease
To: Kipras Melnikovas <kipras@kipras.org>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org, wyattscarpenter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:34=E2=80=AFPM Kipras Melnikovas <kipras@kipras.or=
g> wrote:
>
> > If this is mostly about saving typing, you could get a similar effect a=
dding
> > an alias. Something like
> >
> > git config --global alias.pushfl 'push --force-with-lease'
>
> Correct, and I already have an alias:
> 'pf =3D push --force-with-lease --force-if-includes'.
>
> However, I see the config option more valuable - it would protect against
> accidental `push -f`, which, out of habit, is very probable to run on acc=
ident.
> With the config option, would feel safe and wouldn't need the alias eithe=
r.

It would normalize the use of `push -f` in people's muscle memory,
which would be a potential disaster if someone lost their
configuration, but not this muscle memory. It also would break
automation/scripts - `git push` is likely used by both humans and
automation (custom one-off automation like a personal script, or
automation shared by many people) - if they're expecting `git push -f`
to do the legacy behavior, then it'll break things if the meaning of
`-f` changes. A separate flag (or just using an alias if it's for
saving typing) would be safer.

>
> Thanks.
>
>
