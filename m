Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324F1DF963
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743767571; cv=none; b=tNWyv0K/z86lCPxXqKuag0piLDbwhDIEKLJO/pA5BsRzyz+EPeG9KEUk8yIH0ivBueyG9B9wnaCU8qv/Gc8JPIxVcoRHXdzimrpeiQgDEU1OCpXc9HRVBBnMk5uH9NfKGNGogZjTBslStc6o9EcjJqstMmzaMvT1cEneg0g1n6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743767571; c=relaxed/simple;
	bh=4voVT/q2cuXTDvp+LCsjbBj7UAhNnLYu9RUTTVfYtvE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCzkN8d0/P4IxQPKvvw0ov4oSzALDXeE+IC9o1hWcSb9BAoNowcoVMCaJKT+PkV5AvZeA3IwjQJVQxkVv/6pNCk8SzmOvHLf4y4tAO3xIYR0mDvhAeghEJufQZGAsSPEqrIOHYJrbYsB3KUVbFKf2vhu/qcbilhc0Byk7+Wa4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsycDMOH; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsycDMOH"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5259327a93bso929261e0c.2
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743767569; x=1744372369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/Nh0XblBVPaMkXmLrf3dj6mlUsTSRzZPjNzjRMY3DE=;
        b=QsycDMOHvrnKLc7bFHs7DXeeA8qSW8svxYT34w1Xtb0N4lHcfGlyiUJBarqpmpYw60
         KG6DLF3nbT1OBTJUx8hyROygkBoI7sXw3bForQAO0wRMCqB19oOFikpOHqEip1BWgSjO
         Z4syVdP89BVsR0ZzES0ZCeyutj17GtlQ5xwX6aenwMEFWRtvMBPJO7XO+vWDZMMxbPOO
         YD6LJDYvBXiaCG6tc3tUrQdbIoYXSGARwZSbA1ll41FLhVNaHnDyezd1c1IA1Zd1Zo4M
         wLZUeb7T+nbEnQQ6CsFB4OLWa7Qmum0vnxQ/DsYewjnhQVnPy29lD8UbhVmAq9l2UNxK
         uDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743767569; x=1744372369;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/Nh0XblBVPaMkXmLrf3dj6mlUsTSRzZPjNzjRMY3DE=;
        b=OWtg8fgbqrKrGFj1vBs8oEF5CdZZpUDa6i3KJkCLJtWDYpaUQNU1tRnp2Kk//CVQ2N
         WSpG7AJLnrDiRe482N3Ex10ZQV7quw1g22jLeFRdU1oGOkvfoGqNBXKw0YxDY45VJYEW
         oABsYU9UQR/3rlOrN6dntdeIDmKIB39BIkCrJWm+QCGMLt01cPmTnQO1MPeaISTtE0S9
         90rUcUuE32997VC8CANS/4ef8LX+EqvsW6/eoL/oYtxRf1O0EfLU9mQ46VYbp5wIEiAB
         3LpDbTnc5mxjnW+FEGmO9a98JuQS28N0WTVzhhSSkm0m06NCJz0WUjDfuS99EO+fG1F8
         xBOw==
X-Forwarded-Encrypted: i=1; AJvYcCUhbF6y95pNev8VjA8idzIFLwfVH84edJWFvEECfvHKFulL6bJL1JOiipeYbGj1RXb45Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXMnwbeVLjck52vMCITsGrLg4BmwzuPSq2c54phYepmixk1to
	AYomhFJ1jt9L76eoyqOSObuQn8O0AU+Qrelac6m1vZ+p65kwV62Zhn1GD9MrYfnJF4WVuLDOwl0
	z1AEdGj2UTMycuY3wCxkMINwyZ+c=
X-Gm-Gg: ASbGncuVSd5Ds/0GqxRpE/lYIvAxfNcGUi38lwnSNv91U/yYciEr8m8DJXMOQfDdTZ6
	zW7L8DWJT2Mqn/CTLxRR755q2cj57UrfB6+hzSlk3V5oBTH9j45OdYgOMMrGBsUFhlLyB/mvUG0
	iVb1OFr1mGL/XQntNNEfbJIlS98G4pM/FI2s/9po+WbMJYybh7KPuOXXAPDM91
X-Google-Smtp-Source: AGHT+IGDb3ZY6sQvYazzfSjbVCOdOcqoyrwPyRk1eih/63Qkxytp3vchNorXleJqlKSXl8hGL49HJ+XlUKKMh9tnkbk=
X-Received: by 2002:a05:6122:169b:b0:520:51a4:b81c with SMTP id
 71dfb90a1353d-52765d287bemr1255807e0c.6.1743767569033; Fri, 04 Apr 2025
 04:52:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 04:52:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 04:52:48 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z-_HBe1lOu6_oRbr@pks.im>
References: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>
 <CAOLa=ZQ4nTP7Ls=JsnQSbvpvw+OhjXqqoQxpsTKA0x-HxaDH5A@mail.gmail.com> <Z-_HBe1lOu6_oRbr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Apr 2025 04:52:48 -0700
X-Gm-Features: ATxdqUG8HwQzTAWYnQ2kvPxdgDq_jQ4qpt5zUJYBU1Xhlc0iipWKH_2Adik1OjU
Message-ID: <CAOLa=ZTuyng6BSBsfr0Wcb9Fh9b+a-AJ3g5wdKMVeFaJYKMREQ@mail.gmail.com>
Subject: Re: [GSoC][Proposal RFC] Consolidate ref-related functionality into git-refs
To: Patrick Steinhardt <ps@pks.im>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org, christian.couder@gmail.com, 
	shejialuo@gmail.com, Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000860f0c0631f2869c"

--000000000000860f0c0631f2869c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 04, 2025 at 04:46:58AM -0700, Karthik Nayak wrote:
>> Meet Soni <meetsoni3017@gmail.com> writes:
>>
>> [snip]
>>
>> > Command mapping and naming:
>> > ---------------------------
>> >
>> > I have taken reference for potential names for these subcommands from =
Patrick=E2=80=99s
>> > suggestion (https://gitlab.com/gitlab-org/git/-/issues/330):
>> >
>> >   # Replaces git-show-ref(1) and git-for-each-ref(1).
>> >   $ git refs list
>> >
>> >   # Replaces `git show-ref --exists`.
>> >   $ git refs exist
>> >
>> >   # Replaces `git show-ref --verify <ref>`.
>> >   $ git refs show
>> >
>> >   # Replaces git-symbolic-ref(1) to show a ref.
>> >   $ git refs resolve
>> >
>> >   # Replaces git-pack-ref(1).
>> >   $ git refs pack
>> >
>> >   # Replaces git-update-ref(1).
>> >   $ git refs write
>> >
>> >   # Replaces git-check-ref-format(1).
>> >   $ git refs check-format
>> >
>>
>> One other command that I noticed, which we didn't talk about it 'git
>> reflog'. I would think, it would be nice to also fit this as 'git refs
>> logs', but it doesn't have to be part of GSoC.
>
> Wouldn't that become awkward though as you now basically have
> subsubcommands? `git refs log expire`, `git refs log exists` and
> related.

Good point! I was thinking from consolidating all reference logic under
one command, but perhaps treating 'reflog' as its own entity is more
sensible and best to leave 'git reflog' as is.

> Patrick

--000000000000860f0c0631f2869c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cce889ff993798b9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdnlBNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFZtQy85MFNyZUovaENTRzVmaTRsT2RjdGFTOEFaYgpNT3lQYmZrRE93
TkdSMFJpeXV2NWZFNngvdDl4ZkY1c3BYQXkyTlFJYTF3TzFhZ3p0cUkyOHdXY0c0bko0WVFNCkha
c0FMakF3WUg2WTl4Z2hCN3dhdi9Zd3JGWmxkTXBER1VDeUZMWm5yMnVuVExXeit6K1ZGRHlvTTlT
VG5EUHoKRFRHUDZ3VldlRzhmSFVUVHNPWHhrNzN3K1FyNHpFTW50aXdnL0lSNU1iT0Nnd1pwc3A2
a0hPaUhpZlB3ZzU5NQphZmVzVzd5YndtNjhIOWhMbjlNOUtNVnk2M0NabXJRR3FKUHgwVENLUVZr
b2IzdnREY0FraHJPY1U4MzVOZW9WCi95NG0vYTdqWExQOXVPVXk3ekxVdnpFcDRLb216b3BDcHlP
Y0tMbmRRZXZUbUxYcXB2d0VhRnJWMzBDdGR0SmsKdisydUNyRytieXBRMHFRN3JyQmZaMGVDL01K
NHd6WFZjV2p0aVg0b0o1M2hzcXJPbTdGM3dRWEFyeXkwQ25DbgpQQ245UWdwZ0oreEIvdDNMZmsz
MUxXZmpST0phYjJMaEpkVklHMml0Z2hOcjFTY2NCNE5nemRQZWwzY3h0U2d2CjlIeGdhdWdIeXpC
dVd0YzBGN2JJUHMybjlMc2VQNk51U2JBaHBGMD0KPWJpUksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000860f0c0631f2869c--
