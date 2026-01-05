Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42B330660
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610551; cv=none; b=tcHXpnU73fJpz+7I4Bnv9iApOSuSfdfrKy1rr4y30YxdCHEA2XIDGUffVnVVy+ox+zUD5AfSei9ypTNsl+wWhTjoQFc/9GKrjDa/QQNvPPo3kU/lNKCW9p0OA4M3HTgZ1LCxb67aXOOBsG/b+/6aIZKev6eNSHicXunm1iMft3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610551; c=relaxed/simple;
	bh=ArOtCqNIsI21AUSyIQHPJ4dTju+rbtSPoiT3opo5E8k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=X75HerlmStH3G+pYSAWzGSRlCVqOdB3vHvAQ/Vr9IisEA8aIuDeLrdAjReFrMb3NzLay6tep7pjeYRH2TXHb5OJUBNSUrfQ+f7MaQbqwZk+8AX2NsLrUx/tgLeeGj930jIELjW2C3QGHKR36akZiCgXiKJ0Zkb7PKE64qfQsvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5kBwf5x; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5kBwf5x"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-55b265f5122so2525837e0c.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 02:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767610548; x=1768215348; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArOtCqNIsI21AUSyIQHPJ4dTju+rbtSPoiT3opo5E8k=;
        b=l5kBwf5x50AOOFNLVe9n222SWYmNA8h5wmAiU6YxUOUeR9hrQw/n2VEcEjkExso2xv
         f/Wrl490kvMhRXgfl16Ha0t7GfIzjmrER0YohPM/DX5IP5ExyG8uou2AuiDxdTrBxKKN
         a1Rj7s7AHJtuv1b3CbFSgSTI5+N3qiSunDXf+kuUJd23uik5larNLq+PA1rCbKfGwL62
         5ngGzO+QHlPH85obm53hXJhRsjKSdqtw0ggtUPJaR35GsgV2ac1B8Tmq1HBHN+U1V8FC
         YeFA6U4SAtOlY2Sjf12ZXKh2L7VMUNRAsNgdfDBISGfD0LagenD1dd6SvSuZ6ngNbdFv
         KxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767610548; x=1768215348;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArOtCqNIsI21AUSyIQHPJ4dTju+rbtSPoiT3opo5E8k=;
        b=GhlW58mU8iBfPtm1nm2ChjrRPGu8mPTS1kWSWvMDVWm/ODdNReoBPRF9IXLMPYv4qo
         DMRWqKk7hesQ4VhZaeI9fkV04wf5pz9Y5E1K6KbfVuRMN0qOPVGNjN0yuVya3ORE/uiq
         bk9tHeS177WmdDVHXzcpxtr4cIJoJbqRNCeXsi0fs2Bzut4piWbguwTLqZmxln9UDIZo
         xgXFeU0mxyGJkwa1fgVc+JEvZGOOvFT2FceKkmv9Sno+Q7dVzndJ6c0JCMqRBZMFbZAB
         8vWiVp/0rNURPNjcUUzbqYTkh8jgV1HI8HzPajFFP3N9MiMGOIFLyNTlAep6Ff6WtF4M
         K2ow==
X-Forwarded-Encrypted: i=1; AJvYcCVewhrbaEXaiM6ogozQcuWCcUf1l6qONf1gYgIDs5+mcCg2T8Cbq0dFZmOeC7RzpyEOd9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgISHbhoFbIb8l6tgaF7vmyRLZ/KiBKWUgA543h2r9SSqW66Qf
	9K9kqjHcBGN9RK1VQ1N1XWVSS3tDCwzxVo5jOAOXEJ862HNhIZuUE/elj5eIfJasRELUNeaEpiI
	G5samGfiR2HTxtRqCJI6G5TuD78vl/4A=
X-Gm-Gg: AY/fxX41PJXmzmd8VT+Jbc2lL7ziuwuoZvAJfOiWN11T3QK9F2yO19A3fTy0AhhdlgY
	H0nzTOdiO2HskSmJamKKDI0AO0qpO0cb4XYDE3g8n335L1496AKq8idE5m0blLBGHvWUT476xMB
	IGR68awuVUYizkzzapGxoeB2+K26f5tNLWe8yVB/sLfa/xOvi4gLYR+LNUyFJsKRl06ozKblXou
	EHkuJINh/dixT7fgExONp5RLEgczB5uwZl21axmpVxwZKD9inX/ys1ev903MGx7/4NdHr5XQ1RT
	RelyIhLw6gxH75IsV22lTRvBhkouXg==
X-Google-Smtp-Source: AGHT+IGzuKLjzRlxGn5YlNg9POt2+TdAdn7C7DsBK1PfETGkmwxbCfd9iukW7+I7G6J6NqnGoS0cwB/svJEfDNOdz6o=
X-Received: by 2002:a05:6122:1ac1:b0:55b:7494:1736 with SMTP id
 71dfb90a1353d-5615be82105mr11511555e0c.14.1767610548546; Mon, 05 Jan 2026
 02:55:48 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 02:55:47 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Jan 2026 02:55:47 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260104194812.15134-1-pushkarkumarsingh1970@gmail.com>
References: <20260104124255.15609-1-pushkarkumarsingh1970@gmail.com> <20260104194812.15134-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Jan 2026 02:55:47 -0800
X-Gm-Features: AQt7F2qBtEO_eMO78jHkqBwiyAUKp_VUN5vISOPVz8HhunQOGt2lnCFjVhIxVq4
Message-ID: <CAOLa=ZR-LrLcL7F+dS_gBO-jVoiiGEXMKd4pbg6wS+EPbdZy6w@mail.gmail.com>
Subject: Re: [PATCH v4] t1300: use test helpers instead of test builtins
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d908220647a1e6a0"

--000000000000d908220647a1e6a0
Content-Type: text/plain; charset="UTF-8"

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> Replace test -f and test -h checks with test_path_is_file and
> test_path_is_symlink. Using the test framework helpers provides clearer
> diagnostics and keeps tests consistent across the suite.
>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>

This version looks good to me. Thanks.

[snip]

--000000000000d908220647a1e6a0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 376470468ccf2bd2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sYm1MSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGFzQy93TjZFMnpOVWUwcTJWdHdhRjN0b2RIQ0ZJaQpCZ2ZkdlVVWnlm
SzNHeXJVVlowVnJJaExsbWRSMXRUNUVPcitNZWtxZ1EvdHJWQ0grQnlnb01HUjY1Wkc5a0pzCmpq
Z2JnZ0dHbElDVEVXM0JpUjNqQWlZZ3RnRmxrbnZlYW5xelhjUFRieUxOSEFSOVFGRU9DQ3QwTFdS
NHdGS24KaERXaTh1YllsWFdKYkxJangyaU05SW1vS1V2Rmxxb05iS0hXclBrOWwrREJSS0gxM2Z2
UEdYTjV1cmtHSHFYTgpuVDBLanFKeGs3SUtQSWhVY2xCSVY4SmpTdHMxVVdFckZvSUxWQzZEL3Rn
bHVRenpvaExHSGQ1YzV4cmhLNXdvCldQUUdab214TVhHL1hLa0k2Y2VjRE9oRmdGbnNoY0xtRlFV
cyszVWJPS05XRUgxNktvOXUwM1Z0NGE0eFZYMHoKS0V0ZkpUaHJJTVV3SGF3aXpxUmtad0VoSlpF
VlhEdktUejlxaDA0VExqRWxNVXptc2ljd09DcndUalJlRmY5SApZMnhDZmFKUi9MMnB1NE1YQXdN
SFBtZ2dEK2IvSzhIUkxtcHIyczBxQ1RwN1p6VWM4dTJ1R1d2T2VoZmMyUWIzCldydFltS3BMdmcx
b0NHbG1KMDNTYzZEcVpjNGpreFgzQldqYktKbz0KPXBWRGYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d908220647a1e6a0--
