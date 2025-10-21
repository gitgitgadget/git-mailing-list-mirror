Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74191339A4
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082376; cv=none; b=UnTcNzFzVGHKnsWlAcTaaLJuvksu15SMmKg6yzu+Vq0Dq7k/kIo7zY+g9iafr23EXtd8XP40UYcfBK40qx4vojDH/DY7vb8/2IYTe1vN4JJFzf0zT0zzqsBw/sInhUt58kb5SOK0zHKSlGJr+RIV7kIoq/F007M9vh0I5aQTYrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082376; c=relaxed/simple;
	bh=iFNhUarQbhqsqHLRFa4diQ3oMRdqCd41sko/Aj0jbH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uda3MykXpK6wzfcTUTr9YQTDtcifK9RdmCGbrNzEkuPCyGcM5x1YMwkThmnug1l0vIGdRp/Uv9IbHkNezOEDoyw7E8rhZ2GwOwM4f0E1Yf1op6TQuQ7525/pKujR+RAX4ymjXOaE1r3wyADRvRcBHG5LctsTnOd22KWkSYd82sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpEowIvR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpEowIvR"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63e12a55270so1141460a12.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761082373; x=1761687173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFNhUarQbhqsqHLRFa4diQ3oMRdqCd41sko/Aj0jbH0=;
        b=KpEowIvRlBUPmjV85WEYuP/Wr3fF4hxcJr/IZavu2TTGKS2bdEpFCsnXDO2gRnql/r
         tVBUn2UZDwn78pr7Rr7WOSgBnWo0GUtfPpI++OLquSjEEI5UgA45tB9+gmdHbzEOWOM1
         lO9mxLDxwOLbSo5v5zlsO2O4MGIy6zmVprF4jLTyTYBEN54jBQs25v5di/vULJJXwQjt
         FEN6A37RMpUSj5AfrNpFe5kZ18CmEsc1TbJj0HQGTGx24aJmGc4l2ZnO0IizBfaJ67SS
         Od2MOBHlSaJYTrJim6MgLfFoMcsywZKpGo9QlU+mTQCQMjWbZBbUm9TR3QYH7qLUllfR
         ppew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761082373; x=1761687173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFNhUarQbhqsqHLRFa4diQ3oMRdqCd41sko/Aj0jbH0=;
        b=F072fparIkl2uMM9VxdKhOyinBwdSnek1ri5v2KsrTMAujzrraL82BKPgsRLh/ix8s
         2OMu+D+iP+nnt8buTAenHrQO3ir46VOeW8N/wLSDd9MrtZtoqJ4dv8/TZfdgFWttv27t
         5yvBP8JG9T3zJRqofRRBVmEGIwwExsh98JwPie6p1lg5/EWRmwVRRYGS6F9BebdTm911
         cDXY1LHLPPra4z+S439fi7w2+4FzQkuixR8s3xMPqxpSOdBk8VkWiP94ZyaIl+hSOfUa
         VZUfw1q89C4kCConWCPwclO6HBx1i9jpSqiLAWIgtGzo8nSu/zA0wtMQiwveiErB+iCz
         pXBw==
X-Gm-Message-State: AOJu0YxZDD4UmxOqVMhEGToUhe2uJGQ3rQ03W/OlDZLPJN9SkiIuTcOE
	SHJAidSR5+eIdTSJ3Bk8YmWKynrDYRQVjmq/dHy8Sp2xrwbtjFCLxkvLSENtRv3/a3/Ob8Fh2P9
	5+eaxP+AxIVNutclU+NbwDXTpDw/5fG1kHuv6
X-Gm-Gg: ASbGncsZZmwcvuRxmUtqFCkebRuN/9T7aSh9Wt/7l1Rsy6jr9nH99WYhYrMt/HtXSit
	5j65KlGTbYXE9Oorub6CIQq9kt2F8KHGSeq/GNP/s35RKZN+DchBb1OZEi58zpmCdzz1R7MQWjE
	gZnF7EKsJG+v5K7BuhSdCxRWqC1YdEZ8KpNfIzatD3Wsjd76VnXUqCh6bcvVNDF0db8/MKZVLww
	T2ZSHUDRtxNSqVLwkElWcGZK6bCoPsrzhBNIJfYIxchqt3YiAWf3KcYy6EjwrTpRQYidqqNBQ1J
	s3SN762vfJMWD5uKmLs=
X-Google-Smtp-Source: AGHT+IEfQo02o2RaI+3VGtujK6ZrTMdKPZfapIcMaVK32GjxxjpBtFokLFyIG/KoMg4gaZiIdHx/RDNFZyih8v1YxHY=
X-Received: by 2002:a05:6402:234a:b0:63b:ed9c:dd16 with SMTP id
 4fb4d7f45d1cf-63c1f631b11mr19693648a12.3.1761082372989; Tue, 21 Oct 2025
 14:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com>
In-Reply-To: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Oct 2025 17:32:42 -0400
X-Gm-Features: AS18NWD7f-o6Z9Hog8Hx3-2mDUV6s_lgPgC3rywEjarUQEfJiwTbyeEvb5n0zvU
Message-ID: <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com>
Subject: Re: [BUG] Strange git notes completion behaviour
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:07=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> Hi All,
>
> I tried the following in git 2.51.0 on NonStop (big endian x86):
>
> git notes add -m "Test Note" HEAD
> git notes show HEAD
>
> The git notes show reports a completion code of 037777777764 (-12). This
> gets
> hidden by bash, which truncates negative results so it shows as 0, not -1=
2.
> This
> only seems to happen in git notes show, not any other commands or
> sub-commands. I checked in gdb and this is in fact happening. Anywhere I =
can
> look to try to find where this is failing?
>
> --Randall

Exit code or shell (tab) completion? I'm a bit confused, so maybe
someone else is, too.

--=20
D. Ben Knoble
