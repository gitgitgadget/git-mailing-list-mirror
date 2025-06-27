Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77D2D5417
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048023; cv=none; b=jPPxdrXUNX8uC8LY9H7IEhoE6GScZ2dTXRk+Llhtw433h3z5+MG9FD+TOXpMk9mjnE5Cu4kJtpq079rV93zo+wUPAqxB/CTs8hLNjyiyNWtHWVe2JZue3T6zc8vzvy3pOkkhiLntHajW0dMZHBZ95hKKLthfFkFsk6Y9ctARLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048023; c=relaxed/simple;
	bh=SB4eQqNBPrbFv9Hkrr+ZSIAGS0flJgX3zaUly8u7ups=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9sSOCoioWb9/keDDLyPhkPp1gLWP+YYfUMJMrTuBYFDU/Q3nh/PmPs4VyOeeuo0TPaCfxKLPqzlYun1I4mB0vSS8Lo+3Assce48DgvJTHLW+bleez7LE7ACwvZcXq9PZiUjrQWZpJefnatkwBj316Oq8ug94Ki9t9FVjio8ot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpCqrVtR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpCqrVtR"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74924255af4so194269b3a.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751048021; x=1751652821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O65w5mnuWiN/BAsW1n+gFPKhWbd/Rmf8z1XDgsLgQ3I=;
        b=mpCqrVtR+waCbpZbTpba736okeBgztaUGFTbzee+MPwh1Atj78qjkUoFRzCq9uFkPL
         UGk1xnUs00PjE27TYBWlHVplBSNNQx0wnfCNrLnDaa7uKSEUiEfEc1XDUyOH4qPBZchW
         hGxEbjPae+RGHGXZYBNbh1YHOkhNrNDY5hN0t/p9fDqzwZIYZEdFjIRbqHRVdfol+TUU
         Y/557hASqXrjuA7Ik31sMnsneJvdF0VVeAl7Wxv4b5PHZkZ9PF+O39P9xWwW4ii7lAlL
         LbOHcAeHt5nT2+V0Ufd409joiZp1G3x1hM/b0grLe2+2so6jvk75WTMBLWk8YxmBIQJr
         iaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751048021; x=1751652821;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O65w5mnuWiN/BAsW1n+gFPKhWbd/Rmf8z1XDgsLgQ3I=;
        b=QqZla43Fas1b09rQ5f+NeGpR6e9tvyqjfh2LUK7QikZDOusnAhR2gGcBXJvRk2VpUJ
         Qo23Xl9wAY0VlwXaiBgk2V0gkAytHErR0ykWFgkSO2G3n/zlosf9QFNoHBFDIvx7ljVf
         IQM1/LQF5VWe+D53nUOdCT2bMCAewUDllF6bnI9Uqr773Z3J0i2GVkU0S7KkENZ4Y6vi
         EuqatIi7lsCW64Qhii+xQCHK3Rw4Hjy+OKdSLdiRJTHc53WO3AVviQBI+eGESmX8QVWo
         IUfZ0wEP+NPzVYWIZ1Vd+F8A1tTWwOEVnvYnCoy70/9+syKeqb2I+IsUFwC39SI2hO8X
         Cstw==
X-Forwarded-Encrypted: i=1; AJvYcCUuhAlUFmy6qCe5yuRR+TIbUHmoQ7KH8dQBbNhcamkjhGtoSrWQgHdK6Z56iYNNvUddHC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFdUL3JKxfNE+HcUDAJ+Uhj77SbVN8JQN+6/ULvKckaWnKNn7
	PqPv034C/ZeHDDF5jbheWuqx5cbqCd0sgXLnn13Fr5pmfGsQbOa3zVmEh2FBfQ==
X-Gm-Gg: ASbGncs/WG8uS/jmSRNrCuPEFZYbfN98i4SbDU1+ngj71U2no6reCfxgk1uWthWRUHD
	DLIslsZoW3Zq8jBGWgyQyN4w4KTgFDJ4qtAjqFeT6df0Q3N4p/+iKnna1LDpEuP97qVkmGrK4/N
	2fSt6G8WxELjtY4Ei/p+0yKHSOXmLtot/F9kRtuIl716UngqbrDQ3O4uDk3vy07sF4gzngvRsxG
	SKWAzBBiBUGnd53udbuoMgrydJzZX4i+e46/5ZaxF0t6GIwrik+5gQsmHV7T/dJo/EFZE4kcAyi
	wdqIMcV73z6Ol/1gnxGLr8Zr7PET0fpds0aV1xenbdDWWWWZ/zNjiiFD71cYyA64oj1dM9f0oxc
	B7SxbLwPyT3Ksc0maNxbDTZbNeAM=
X-Google-Smtp-Source: AGHT+IEzEDY1+XJc320gFC9YeCX3eMtFZ75Cd+d8t3yFvks6NCUcY9G9JClPikTSQRbcyqS/wA8fmg==
X-Received: by 2002:a17:903:f8c:b0:234:b123:b4ff with SMTP id d9443c01a7336-23ac45c1c84mr57443795ad.21.1751048021103;
        Fri, 27 Jun 2025 11:13:41 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3ba060sm21917655ad.197.2025.06.27.11.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:13:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  shejialuo@gmail.com,  karthik.188@gmail.com,  John Cai
 <johncai86@gmail.com>
Subject: Re: [GSoC][RFC PATCH 1/2] builtin/refs: add list subcommand
In-Reply-To: <0d3fe70e-2064-4206-9673-c0589a4445f1@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Fri, 27 Jun 2025 18:27:04 +0200")
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
	<20250627074934.1761897-2-meetsoni3017@gmail.com>
	<0d3fe70e-2064-4206-9673-c0589a4445f1@free.fr>
Date: Fri, 27 Jun 2025 11:13:40 -0700
Message-ID: <xmqq7c0x833f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

> Hello,
>
> I'm only focusing on the documentation part.
>
> Le 27/06/2025 à 09:49, Meet Soni a écrit :
>>
>> ---
>>  Documentation/git-refs.adoc |  95 +++++++++++++++++++++++++++++++
>>  builtin/refs.c              | 110 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 205 insertions(+)
>> 
>> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
>> index 4d6dc994f9..d8f81eaabd 100644
>> --- a/Documentation/git-refs.adoc
>> +++ b/Documentation/git-refs.adoc
>> @@ -11,6 +11,13 @@ SYNOPSIS
>>  [synopsis]
>>  git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
>>  git refs verify [--strict] [--verbose]
>> +git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
>
> please use spaces around '|' in alternative options:
> [--shell | --perl | --python | --tcl]

As this seems to be copied and pasted with minimum modification,
perhaps we are better off if you sent a "here is how you should do
it" patch against Documentation/git-for-each-ref.adoc file where
this was copied from.
