Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485411A5BAE
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864458; cv=none; b=Wvsv0Rl4Un/k1O4O1n1nRzyRicK8Qgkp+VeYzMjQS6usGUnx4uefwTNm9AUJv0hcSTvrVUigAXMEttRtvpDch5Xy/6GJ3UZHX9NiSnBNnYK7uE9dx94e24AmtBMTXBHVHkJAeISVzZ4+8f91LhDt8yNRiseSC0J3opvj09Lpm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864458; c=relaxed/simple;
	bh=04tqE1UCHI+sk2gARE3Y/YLCAHkf0m1J9H6YOG2vRoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xgd0zJwjgzrrgI0OheU3d84df1Ib89WMg9nGHY7/K5ocKAK8zbKz/1ne2C/vgDRqLCCz0y38PGCCitaZ/FEzQeYcGBf45BW+YezBMbh0D0nMCssmqNYemUinsOf/w8AB7QiPPny2Lvy3pXxmjBrsWrbAvlbxRdMjxaTMm+HPUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwgKYLd+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwgKYLd+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so1832171a91.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750864456; x=1751469256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=04tqE1UCHI+sk2gARE3Y/YLCAHkf0m1J9H6YOG2vRoM=;
        b=XwgKYLd+tHDmceRnki9eZul+bOFQuPWX88NF4itX9MO7BN8V1EZHVZhjtYv6PWCS42
         8TszhG7oL+ACepkCEixk/WsIz+LZc7Lsj2SKed4rAsHLhqTVrt+1gOCjLha2rtaPGTac
         Mysy0cmXQFpkBnqGViEjP5QTnVeLf5JR9PTQGq3OgIzSWa8833q4j18isHBX4VgBUe/r
         EB+5/Rz/JzlugPt491Xqpn3JCVjuKTs1TT8LYvHNkE/0iP5EDhfhSJyhpxOMNGqJ7SlG
         bLcxmukANPfeiJC8vXValUCpDJfG8ic0erxK04hRWGaHBAhExsiL5bKHm6wohyujGZSD
         GwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864456; x=1751469256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04tqE1UCHI+sk2gARE3Y/YLCAHkf0m1J9H6YOG2vRoM=;
        b=HXZSEFgbuxj5HZT/FB6ZVfoMFihlMSZS1bciLCgDQiWFhsDC8aH989L2m0nTwbctgc
         VyiRoOJuuHW5cs1Qr3RfFEC8I8MNZD9i/nMcUuUgmwBY0hURXu9hkGkGTetnjLwlpOCa
         kakCkYOXfu/oGUu4/Z3bOiGbM+rmK7jrY3UHnFMIRpFB4UJR7Mk57Do28weicNdGMh9e
         J2amfJ/OO3S84lksY3ExhkJldaW5WAvG1gBvRltfDeDMRQaBuZ4heKREHe2+pQlRNZL5
         rEVHCuM41qhJC5TfJKEwnhFkYFVK4tmecdSoPrix5xwJMqa2yGKYwzfp+sjBFnTD4li1
         hGvw==
X-Gm-Message-State: AOJu0YyoP9igDhalHhUcHI40o6XgnGIXFkgXdFRV3i2yXdlHbrbYbxpA
	HEoBaOlxBDxJmdWc8BWes1Ft0/6VnnnUdUyCGtsY9I52IC593BXX8qxaiD5YcUKX1HpyCSN+kYB
	FLNY1vSt7Vhl5S5DZwYhVjluGyOSQ1SdvxSWi
X-Gm-Gg: ASbGncsX1tYrh6khaiVDxqNwTqrGSaMFjiPmnt67Wq8d7Mi1xQGYof/FluZ47hEye8X
	Mvih6gEtGAjEKWZK985I4rEWDLEv17SjPTHOq6pAXC9aIATujuLIxCqxAISf39ufX5dPp0i+URs
	mS0uiiUGndC9Sp6U+X/2mZIMpHi4J/iWW6tAVzfEDARmoklLwzEVayzjdXsLUBTPCFRtCU7xGc/
	ZvEwA==
X-Google-Smtp-Source: AGHT+IGe7ASMmCTeXMbK+xvOHwKCLfWztLceTcCx+mKt2f0KowavD9IS85N2j2vRpn0ZZRSN0N96W5CiYzIA/Pw15ME=
X-Received: by 2002:a17:90b:39c4:b0:311:afd1:745b with SMTP id
 98e67ed59e1d1-315f2625fd4mr5627844a91.11.1750864456352; Wed, 25 Jun 2025
 08:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE7as+agjJm=taLgeracuApiGR1YgP5ZQhoHroTk6=Z0E9ww9g@mail.gmail.com>
 <3079AF5C-CB54-4674-AF5C-24CDEF3854B9@gmail.com>
In-Reply-To: <3079AF5C-CB54-4674-AF5C-24CDEF3854B9@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 25 Jun 2025 20:44:04 +0530
X-Gm-Features: AX0GCFu0L9hmZwMldllciLhDsrSfjq4z_p_BwZHs-rBk7T_hJCyJD_fXWX47kVE
Message-ID: <CAE7as+bTKE5opov-Xn0P8R+cy+=-XRkX9Wpie_W0717XMF1b_w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D_Blog=3A_Refactoring_in_order_to_reduce_Git?=
	=?UTF-8?Q?=E2=80=99s_global_state?=
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

>
> I see that you want to get rid of some usages of 'the_repository'. I don't know
> if it is in the scope of your project, but something that would help me in my
> GSoC project is making the function is_bare_repository (environment.c) not
> dependent of 'the_repository'.
>
> More info here: https://lore.kernel.org/git/xmqq7c1genyp.fsf@gitster.g/
>
> Thanks!
>

Yes, this is related to the scope of my project.
I've had a look at the `is_bare_repository_cfg` variable, along with
the related functions and flow. At the moment, I'm occupied with a few
patches that I need to finish first. Once I've cleared those, I can
revisit this and try to get a better sense of how practical it is.

Thanks:)
