Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D061C2439
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978721; cv=none; b=TKjmEFf8FtJhA4jrrCUdabiOEfODXqI+BkK26jAFLbu2yrsOOGL6p65EPvTBravskWu9GUOT2xgJRET+7wc8OaQEc3Ok1HK2DueCQ7D235sK8eEcOxomC/ywDWRHfYcmHLLwMYkEWmljTTkZHOvhRUFKwVCRBvwcYsB0ZpaSvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978721; c=relaxed/simple;
	bh=21GDJ680rPO+nVEU4h2ivdcyFM62ZSKtaIWW3/zegf0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDvyW53qvllPqjRCazd9WOLAZNGu5GIjo4xtsec6mn9NDQURSqjXBEbHeJnNGBes9OV3yXtsSuCWN+Rq+Xrs8qq588sUrZk6ylHsT970GxIjQ9c0zZ4s8+7DqVJgE8j307ir+ZRWoLFnvTmIoWalS3fi3HPcBQxMmiEtkDFt+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN4haoPO; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN4haoPO"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so3010259a91.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728978719; x=1729583519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mE5aL0jqgKz2zaPuNxEYdNH/XgtWC7qs+0c+/uULzo=;
        b=dN4haoPOd0keodtDXdWDwcPV/c7Vt3pxuH82x+18xO+/MEDXRWBhMQ2Nbid2hQ7k7z
         j+42wObXrKBHiDeOjlaNTk+dWJGNAj3XYy8X9bf6u1ixt3XYl3IjPpSMI3VYfBBHkCTd
         2keGloBjRCbPdE/TEunoj4YnvgM0BksPXAU5EdUCd+VF7L8tj527KUsTY3f2MiIzG2W7
         Hhnb4zYvhNMvoHz3trcvhV5LjjMAZ7vIMxTx6AypA1udyLt5ypU6BQ9DygiC4V0Xl5Ku
         /lmC7tDLfyRKpCjQB9PTPOAL4Cop2vtiNsF7vgm+GXdeUg9XI0bOVjtrxngePY/iEySQ
         cksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978719; x=1729583519;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mE5aL0jqgKz2zaPuNxEYdNH/XgtWC7qs+0c+/uULzo=;
        b=GDVOnN4DjyOD/ZuvxVQ5d5YIs9SCNKCRD2AHisfEQYEarYw8Zf7hjowW97QwYD95Tu
         N770cdg35JMFLsuxE6l5snqNCIjhpb2gQvzAXTw4f4aF+S3z/Vwl3xg/rdz56d/WzdGO
         ioUrznSnZfsFBY/H4ba5K8RaEtOj7DtdYDLJMiM3CAxNYk3a05n+fY1Sbl4nkLFkXVQw
         rax2fnPxtz7N3iIJW/ljsf6zr/vUs1mbBVimnPH5aOwey9QMrdYH83JVTEWHYsIeCaDH
         jMuW0A7uvZaDhSRWKmherV+kasmuaGY841XS4Ui9ICkUZ9dvqwsfYiFDN5TbXjvY/t2a
         MjdA==
X-Forwarded-Encrypted: i=1; AJvYcCUkdNI294moIEMPcgL91FewrE8PIvoHnyt/daQbpXcNlZ8npAROX1H9HWBPS0eMtPF3PJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvQ5s89E1Vqu4UM7gRDKIzGfVlVuOFN+wKxNXukaGtwSEuMBX
	5GYNp96tagOGr2gp+PF8fZArIQ3/iKCU2wOBry9TtY+HYKCB1GVEh+fJ/btHW2TdBvsIzC0xBcd
	sMCxIVSSusVKa+H2ZUwJyenjhnK7ZWknb
X-Google-Smtp-Source: AGHT+IERQFiT1sf+uy7hz9sRlxem0nn8C4KrV2Vr6TEkk2iGoaOqha2s4r0NqQD6GnKAamoY59lZxHq7QIP6ilKlzWU=
X-Received: by 2002:a17:90a:fa93:b0:2e2:bfba:18d4 with SMTP id
 98e67ed59e1d1-2e3152d4719mr13827487a91.17.1728978719296; Tue, 15 Oct 2024
 00:51:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 03:51:57 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <D4U6L3C2GHZG.2SN8P0C7ZH33M@ferdinandy.com>
References: <xmqqzfndndfm.fsf@gitster.g> <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241010133022.1733542-3-bence@ferdinandy.com> <CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
 <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com> <CAOLa=ZQY_a_dEZQ2EcLVfE_5Kjy7b2R3OFbQHQbkzH0o9-q1JA@mail.gmail.com>
 <D4U6L3C2GHZG.2SN8P0C7ZH33M@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 03:51:57 -0400
Message-ID: <CAOLa=ZRfku-J2HO8MOqu-dZspmCZDV1S56TD1X-zUy5=9+XSUQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] set-head: better output for --auto
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000637af606247f3ab5"

--000000000000637af606247f3ab5
Content-Type: text/plain; charset="UTF-8"

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> On Fri Oct 11, 2024 at 22:43, karthik nayak <karthik.188@gmail.com> wrote:
>> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>>
>> [snip]
>>
>>>>
>>>> > +		git remote set-head --auto origin >output &&
>>>> > +		echo "'\''origin/HEAD'\'' is now created and points to '\''main'\''" >expect &&
>>>>
>>>> Nit: might be cleaner to use `${SQ}` here and below
>>> You mean something like this?
>>>
>>> 	git remote set-head --auto origin >output &&
>>> 	HEAD="'\''origin/HEAD'\''" &&
>>> 	echo "${HEAD} is now created and points to '\''main'\''" >expect &&
>>>
>>> I tried a few variations and this is what I could get working, but I may be
>>> simply missing something with the backtick.
>>
>> I mean simply this
>>
>>     git remote set-head --auto origin >output &&
>>     echo "${SQ}origin/HEAD${SQ} is now created and points to
>> ${SQ}main${SQ}" >expect &&
>
> Ah, I see in other tests this is used, but not in this particular test file.
> It's a bit hard to decide which is more cryptic, but ${SQ} is nicer on the
> eyes. On the other hand I would either switch the entire file in a separate
> patch or leave in the '\'' here as well. Or I guess one could go through the
> entire test base and switch everything to either one or the other for
> consistency.

I'm not sure I entirely agree with this sentiment. Consistency is a
great goal to target, but it shouldn't hinder changes that are
beneficial. In our case, if you make the first change, there is now
reason for upcoming changes to the same file to also use '${SQ}' and
eventually we can reach consistency of using '${SQ}' throughout the file.

- Karthik

--000000000000637af606247f3ab5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d96ab64310d301b7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jT0h4b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzlmQy85UEFTajJxRDNZeFBwQnBsTVpORm1JNmdZcQo4Q1NZaThoSGc0
UEJkMUxYZE12aHVBSXN6VXg5ZTlnTXhRUThSZWZ2NWtxUitMeG5zc1hpL2xuWmlQWHp0dHllCi83
UjJ5d05SbDFDbDkwYkkzTzZZbjdTeUVjWHZKR0RDMWxTSFVkUVBqc3pnbjFTMVZJdnM2UGZCYVZQ
bFFnY3UKeGxMeEdiMlJnZEZwenI1RlZ2bTNpTDJWajVzRkxhS01PaVk3bjFiamh0VTg5VFI2K212
UWhPck5xK2xMSm14Nwp3NmpBQlVuMENNc2VFZDUyTUhiWURRVXRNbjBQeW4rTzNDOGxiUGo1cHJU
RHBHSVVYNjlVUWwyOGRYT2p4SnZnClpVTUk1N3J1QTRGMkw2VUZ4OWNCUnVLNVlKL3RHMjBJSTRO
WDFibWMxZlVXY0lJNkhYYVlmeUpTRW5ZNzczUFYKeFRFK1lWb1hxL01rUU42NWIvdjdSdThXRUJU
RndvSEY1RjB5N3c5VUNDOVV2dzgxbXd0MlZZRkJ5cmdZUk8vbgoyMTYwcWdlaWErY0VuNi8wY3VQ
VVZ5eUIvNWlTMGhpTHVrOE1hRXZlT0dzRVgxWmpBb3h2VnIrNmRoWXhqWDhICnFaSzJDUXNUanNP
M3gyWS9EQXdyY1cydXVETkxaRXZJU0g1anQvST0KPXc3bFYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000637af606247f3ab5--
