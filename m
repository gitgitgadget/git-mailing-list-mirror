Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B8423ED70
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852552; cv=none; b=qbQoFeLZcV0DtfZgmGST2/VVrK1aBq/lDm4TbuxqyoR/3FiGdoOFpRnF2zvPH+5cGTKp5JT4OAMOiKTatoGHxwQtAVSs/XC6e065pCLOcbDnd0xWd3vuoYRWtpamjTge0OKlqArOnwqZYB1NUmkmbJT/QqhOFAJtDwLvoRRpvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852552; c=relaxed/simple;
	bh=b+ZVGgl4ez6qd0U/OVrOz7Q7L3xrisLPbYFrortjrJI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBlVBetk7bp7PyPzbPrWKlU/yZYF5aRcHhWrbuk2hJEBwMzwUHRGDlstJKBAyjsG/1FbBF55i+du94qD31eN507nfvgNSrN7SEB1ELNQ77kBbQGkXKpgkwUrMJ6bVL1ros5VVNVrX/Idvv1N1ZtzZh0bAzjNBppGhNDy2Zw+uAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj5chlvy; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj5chlvy"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4aff1c57377so1343890137.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 09:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733852550; x=1734457350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTb4qcB8vyMZBJ+264LzsVMyNw7sxVGjlQASitqLOns=;
        b=jj5chlvyp3ONk/6gB60pwFjhR94/AvGE/yhnb6ZJgF92ijgan83gDVMDhiRUCmLmqZ
         YE8bwO7t5Qx9Ir7uDY18TdKQ/ExWkRVjNi1Vr1oR+9yI14B7feRcBejHvuBUTK4E0lGV
         i1YeANSVZGcTLSsmHRPZKTCbOlIvvmtfdfxM5Zmc5O1Ab1ih2tEzv2mbgVVe5NIEkJ1r
         TvApmetEw0cSzbI0cBT3IjRvrm9uODMIE3iC+r2aJy2kwgMNtcxked7aFrRt/abBwxpa
         B2d7d07ryaW8Mxt+qmYJMiieJkSubR2p9MQaUx4pIzT4zQ92/u9+4DGBB6XMBz+Rn2d9
         1TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733852550; x=1734457350;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTb4qcB8vyMZBJ+264LzsVMyNw7sxVGjlQASitqLOns=;
        b=J1eJYdK6hOuqXXLHuretNZOCPvr+29MVjEl9/vkdtcaDvtgjPXX/GUoCvimrdUHdQC
         cJrrRoDP8tM47kt2DhrxWwVRySN6DHCRxdFk+grQpPMzAZTU7YJqxXdl/0XNFcMntk5F
         PfwzVpju+tAHOvtLzD6udlLqmjc8QBH2KyGC1ZRf6Q648ApD3rwNu3J7FccAwx2eqKW/
         AiKJa7izh1rIHbgvsS147C33gWyB2r8nT4gBtzATSeYNtJwbrge/8dN8AGWC4YzHwpkW
         Uw07lcc1wqD6cZBUQ/Nzl3144geXO6nPEUhq9ChpP/NUHQN7SgqIOSAT8RdA43QDMZom
         BhLA==
X-Gm-Message-State: AOJu0YxbhF3dOBfxKO7SZisUzoZ+HU8yNtBw5+Sfr2VvgITuc7WLD9/X
	V6w/zyd5j5vSJJqDvGngNNKXdYeDqnS+4sZBKnIsBK15dGPtQWvXJYAdstZf/IMPAdBwoQ74eHS
	i3/7pDSyct2ARlr4FdmVtsF4ybTw=
X-Gm-Gg: ASbGnctspEAdgeA5D5dVIDeqfUyDMLuFrEqeuN3ts+qf4FfNridhRem0jtf5PE7KHGv
	15vYAazBNMbphbvbG//jzDuzya4J+dFft965rI2Tbq3Zr0jdjJE4fuZS7Xl5ul57auN6dLQ==
X-Google-Smtp-Source: AGHT+IGxfqNcqzACjoaUSyEigbtTXujfXW57ZLkOcARqG5PUUSjF0GYEp5rXna+pdBYF8mYvjyZsVJ1OCtbKoNHWkYI=
X-Received: by 2002:a05:6102:2007:b0:4af:fa96:1ff with SMTP id
 ada2fe7eead31-4b1196cd519mr3315971137.6.1733852550088; Tue, 10 Dec 2024
 09:42:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Dec 2024 09:42:29 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq34ivlora.fsf@gitster.g>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <xmqq34ivlora.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Dec 2024 09:42:29 -0800
Message-ID: <CAOLa=ZRsAwM8oUnyYCaRKkkudN+QW+hRSKZEvPJLThSr14M7rA@mail.gmail.com>
Subject: Re: [PATCH 0/7] refs: add reflog support to `git refs migrate`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000576a480628ee01f0"

--000000000000576a480628ee01f0
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `git refs migrate` command was introduced in
>> 25a0023f28 (builtin/refs: new command to migrate ref storage formats,
>> 2024-06-06) to support migrating from one reference backend to another.
>
> This topic pass the tests standalone for me locally, but seems to
> fail 1460.17 and 1460.31 when merged to 'seen'.  I'll push out the
> integration result tonight; it would be very much appreciated if you
> can help find if there are semantic (or otherwise) mismerges that
> are causing this breakage.
>

I see. I can reproduce it on 'seen' as you mentioned. Will debug and get
back to you on this. Thanks for letting me know.

--000000000000576a480628ee01f0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ce8dd8958fb8a448_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kWWZZTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNksxQy85QmtRaXROaDh6ZEFPUW5Qb2xIdzR4Z0VFSgp4cHVzR29wYTJa
SFpnb1djanBxV1FlWXJJaDZrRE1ac1gzakZZK0pnUXVJNStZOThHMTZ5NEZVR0lLR294aDdvCnJO
RklMVVg3Q3Q4SnJKYVVUVlFIbkhrSGlsQlBSMlFWbkFLRXhmc3Y3MVQ2M2FvbnAwT1dONGNFUmhv
MG85cVcKL2FFc1Y0V2hDWDR4bFVLdTBDYUFSQittMENqekFtdXZteTMwZHhnNWV0Q08xNTVFckVh
K0g3UVdoZlJWbmlFVwphbE9XKzI4Z25aSm5HV293V3dCeFBqbmw5SHR0anNhUzlaYzNBS2FnRGJK
SVE5Uys0ZmQybmJnaGU3ekpMdGV6Ckl4TzltbGh3bkxwY0t2Mm9oWHhiRms4U0VwY0RKcTFyRGl5
ZEpUdmNmK2huVEFGVTljMDdRbWNLbzZsVU1RRXgKQWpWS1BsM2VMdmdvSnJEN096TUdIWEhjaUo5
bzFiSFNuQW56NWplZkRWOVZtUWpoQkdzOWEvRzgvSTJiVVM0WQpzeWVlYU9JSjJqS2F6U254Y2ha
MkJrb2pmWE1yRmdTQmpVVjRzSFpxSzRSQTIvYXZmK0xtQTBXWUVHSGFkMUtXCjlBSFUzV3laRU9z
bExVZW1kQzBrcldnOWZMM3NvYnRJWW5XMXdjUT0KPTlCa1IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000576a480628ee01f0--
