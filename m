Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B352F9B
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730064210; cv=none; b=TQ08gon8iYo3j8miLyMsXLJ/++TTA1UqJm6YDRfeXOREClZAb3Mxr/RTtbJb3GbRzWpi5hZSKVCVpnQfD5wMDXF9VD2dw7CeQx6K1JATyMfQkvhUK5rIFnUAmXEyM+9O04tXVQAj60vlmd//ifLXPAGA5O1f95/SgXrpwb2ycR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730064210; c=relaxed/simple;
	bh=Ad8klYuT0eALYPUFz5WZoaXEgEsWfG/y/ivJ+r3YanI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uql2un06cc84TDVuSePCrs6OK/WT0e3sXqEvMiwvIAG+J+Ua7JYvPQoU/9CxATL8bk4i9OFbH0B8I8VQfeO7ZCGl6y7EbCOKpW63bx5hGvSshM1/Bo1yrIUOC2uhKV6yQhZEr6Kqs4DmCTooCVOwelPjMn2KMoHKHeLgbgFw+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMIVSAtm; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMIVSAtm"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fd50f2117so1140109241.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730064205; x=1730669005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajZiuIWurscapi6w7u+Q2k9zrd/wqSE+Sg4vUPwu2jw=;
        b=eMIVSAtm5bhyRvYrIfEZoX0OVfyiNIBnqtzHAtA+zfqJapIToafMASFcNASG2YSurV
         kJ4C0sdAzb65tuByc3cKkxzKtTRqBFfi2P66vVuMFggeJJ/DEIwDD7tXwkyEMNf7+fhw
         7QJtB1rvjAkhYoUuBWcAZ+O7AB/ymLuOvCSLCtKVEYFwrwcAItUe7oGLQ4UkQ7Rudhw/
         CyUc5eI6/6bKD99JBMpi5RzgjgF5WTZlEDJd0G2kzpgUgIk90gBPKl46DHJM+jV/4vES
         mWNCNsZYMJNEpYZFa2FMtWoJCzOKtT1hxsQJp7F8WNkIUSVYhbCHXpPeNZ4Mw9OFQdow
         xUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730064205; x=1730669005;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajZiuIWurscapi6w7u+Q2k9zrd/wqSE+Sg4vUPwu2jw=;
        b=RDLZlIJCJr7hcTHeEmgTtoMxaHEzgthcIz88LO4Wzt0gO3O5MPp+aB07EMNhJnpLYB
         oEV64B6uedeRtzVMKm7Bk1F0fHMgxQS+HvVXtamMRklL8jCvT0tOE2fYgD4jjLK8CAiM
         ZINEK62O4ipH0srtvuXua54OCk0eUL1HZpSsTlYiqVGIExqY8iijOEL5M1G7mdyR3igO
         Ski0W4/1QOZhKM5zRw7jpOxy3+m8oi1zY03sk6nao9uvPWQw7ZeUEfRA8elr4cEUACla
         9CBMHe7yFzkS5FO++6cwXpZd1k7ELwHDm+b8vAumYXDmoHupk3ApSX1hXgvnFMu5XdVH
         Eh+g==
X-Gm-Message-State: AOJu0YygI3IOOSD+Owo81IECb9U3uBMOetSgKyAAmmE2vuFWtaGpXIZ9
	u1Aa/PTFTusrxYPodgc5Zrt6SqnI7KOEKKF8q1/nSqzBLR8jp1qNQHjtwesw6QVfAsKjaScVMvk
	7CBUfvpcqqNeop33PrZJyX0UvD8jHe+7J
X-Google-Smtp-Source: AGHT+IELU4VGTrJZXqotmHisexu3zBdsP6EpYY7tGNjGJ83RUWDcDHivqUykLZIGadQIkKaNz+VRqj5ZO+RoKc/8kWA=
X-Received: by 2002:a05:6122:459c:b0:50d:60fa:183e with SMTP id
 71dfb90a1353d-5101535c8bcmr2884173e0c.11.1730064205232; Sun, 27 Oct 2024
 14:23:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 17:23:24 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxbBuyhfq1sFKBIU@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com> <ZxbBuyhfq1sFKBIU@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Oct 2024 17:23:24 -0400
Message-ID: <CAOLa=ZS3XjxdeYxbZCTCdaUzW4jko8ZLaKMvQsvzUnsan2Ho9Q@mail.gmail.com>
Subject: Re: [PATCH 00/20] packfile: avoid using the 'the_repository' global variable
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000006463c106257bf623"

--0000000000006463c106257bf623
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 21, 2024 at 11:57:43AM +0200, Karthik Nayak wrote:
>> The `packfile.c` file uses the global variable 'the_repository' extensively
>> throughout the code. Let's remove all usecases of this, by modifying the
>> required functions to accept a 'struct repository' instead. This is to clean up
>> usage of global state.
>>
>> The first 18 patches are mostly passing a `struct repository` to each of the
>> functions within `packfile.c` from other files. The last two patches move some
>> global config variables and make them local. I'm not too well versed with this
>> section of the code, so would be nice to get some eyes here.
>
> I agree with the goal of this series, but I worry that as written it
> will be quite disruptive to other topics on the list.
>

I agree, that as it currently sits, this is very disruptive.

> The standard way to avoid this disruption is to, for e.g. the first
> change, do the following:
>
>   - Introduce a new function repo_odb_pack_name() that takes in a
>     'struct repository *', and rewrite odb_pack_name() in terms of it
>     (passing 'the_repository' in as the argument).
>
>   - Write a Coccinelle rule to replace all calls to odb_pack_name()
>     with calls to repo_odb_pack_name().
>
>   - Submit those patches without adjusting any non-obvious callers or
>     ones that are not contained to a single compilation unit that you
>     are already touching.
>
>   - Wait until a new development cycle has begun, run spatch on the new
>     rule to replace all other calls. Then optionally rename
>     repo_odb_pack_name() to odb_pack_name().
>
> I think Patrick (CC'd) has done one of these transitions recently, so
> I'll defer to him in case I got any of the details wrong.
>
> In the meantime, I'm going to hold this one out of seen as it may be
> disruptive in the current state.
>
> Thanks,
> Taylor

While thinking about this over the last few days and also getting some
advice from Patrick, I realized that we don't need to be this disruptive
by simply adding the 'repository' variable to the already existing
'packed_git' struct. This allows us to leverage this information more
easily, since most of the functions already have access to the
'packed_git' struct.

This, plus the series by Jeff 'jk/dumb-http-finalize' which also removes
some existing functions. We reduce the impact to only 3 functions being
modified.

I think with such low impact, it might make more sense to not go with
the Coccinelle approach, since it is a lot simpler without it.

I'll post a new version tomorrow showcasing this approach, but I'll
leave the final decision to you whether it is still disruptive, and if
the approach you mentioned would be better.

Thanks

--0000000000006463c106257bf623
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: eefc0eed9bbaebea_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jZXIwZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2ZUQy80eTZtMjBsNllOakU0WU9GNU1aUGRScHF1MgphY2oxellTelkv
cVQzQmwxV2d2Skp5VmF4NWRJbndUVjNDOW1jRU5RMjhlamxSU0hnajduZzl6dkYrQ1NjZ3I3Cmdq
bUJFSHVCc2lsditEMTJldzIwQVhBNmY1aUdCWU54WC9XeGtaN2Y1bHZHeWhuSXM1TXNsZjRKakYv
L1RGck4KbWJSYWxtVkdWdkV5ellRVi9YNklvOTFwMEM1SG9GRUxoQ1pSU2dhak44c2FibzRpUERp
c2JmL2ZxYkY0UDN5Qwo5dWpoS2QwQ21Fb0ZteGZUMFdoTDMxN1dQaHdQSDhDaDRBdmRaSjVObmE2
a0wydzhUV1lrSENEWE5jZVVVU3JvCjJmOUpZcFFtVjRNdjZQUUtoR1E5Y01VQ2VYSHU5N0NlVXZG
NEZkT0Q4Z1F6WDJiMUdxdUlna0paK0p4c2lSdVoKRGJoMDZDTmt3TXJXQTZoazBzR0ZxMlEzNU5n
T2R6dW8wUDFrdXRTZmg5NzlYL1phNFM0WE9tU05JRXZaTW1UWgpFWDVMZitPOVdxYTBCZCtQaHQz
VWdhVWFwblhlWGM3YTVndU9yRlVSZ01nNXdpcjBqZTkzN1E0MWNrL1FRQVhVCnpwdzhnazZFV1BW
TFRVOENFRXM2M2tDa0d4UXhNYjlRTFY4TVN3QT0KPU5UTG8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006463c106257bf623--
