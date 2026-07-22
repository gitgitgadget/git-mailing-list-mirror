Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7240F725
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716198; cv=none; b=rE0DWogPyhg7zZRdnRSo/hAfH30VTS3D08SHxXtkCi9rukHJDrK8eQxBfLfIpMjmjhDSDot6fPPPlW/Qf4EBfpuP95zDeMULDclgj00wPrFcVVvXzUW/7wrLI3p18e5OXSnjOve0QdTishQsWj73SBu3ZGyUnZMz3vRrDY/UtpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716198; c=relaxed/simple;
	bh=epV4m39BZguOzNSUstZvTbACncACL1yVYMsjGRmgOsY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=ISp6rW+uFqnZ3IKKDxJ+hunwy00Ws22ev3eZ33nOK2l/jpB1Y1WVqaYCoSKnZuJs9DuPApmyUpsxJITPaRLLvxZMAalMQOCTZykwGAC79EGyt8ZJQZDe7xGssUDRYz4sNITRkCkifqoRw2Sm0ZCHgS1crzUNfA7P7WclVhkkFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2KkhYYI; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2KkhYYI"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfe810293so69029991cf.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784716196; x=1785320996; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2cVXAnz0JdlskThqIixsSCj4Clo7UNnHRq5jMfLzp7E=;
        b=e2KkhYYI9U56J1OVEGPx2CR+CpBQ7hMj32MVkrZRHpxy8Kl8tSCwWXzlV9itv4U9P9
         8bWAwzLtqUstAJ54zYDdKfdMqCVWwtk8CoEHGk8puUNvD307U6U4xZc8fXryit5Kpaoa
         trPw16ZF3BKzFyf5JeiHEzkL17zppdkZ2TEFNcuaNJH6ICm4rL6Wvc92+kaXOc9J4hap
         U3XffvW78MXzqXW2hMEX3ABz/pjQvGqJIF21Z975VHNhzorCwPfTMJDppzozE1D8stDM
         UQbrsG90h/LATOEjxr0yn7WzDCWyvoJEmuMoOQepPQVfv/1p2mgyRaLhC+Ll1zxc6qrQ
         fmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784716196; x=1785320996;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cVXAnz0JdlskThqIixsSCj4Clo7UNnHRq5jMfLzp7E=;
        b=R7T23VtyFLaw+8zn6hPtTjaug+Mbt9QAsS7tuWYUoeFt2yGWqKVkYgj5sRE4uePrAL
         4jHrnGVL7Fd/ZX9pqtc5o7bFK38T1aUNqms6FPNO153uO2QT9VABhwZQAf3d2RmOAYAS
         yED7olM7LEC3DvaS39sELSJzgU4ej1mYYcYrt7KPw126JqXoj34hh2JjyrDJAA4aIQer
         bPDV/dk+0GsTiL6h+oF+Ze1UppmZ+tiWbCy6m3gU7AFWeH1fPLwPymf32jsfZDBY0uXF
         rrRCq5YjtE3zZzb8amrkH6DMrzGpbPL6mIouWa8PN/sbUCdmzWjo1rXEVnl9jffy7RH3
         BDjw==
X-Forwarded-Encrypted: i=1; AHgh+RpGWpTUJbmr5W0RSLslJuCSS/J9GVlVnGSdLtuemlo2rOyYLabovfhQ+GKL34BdBowM53E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0s9jxgxR/j2BfvsAg3h6ZexImZmAKekAZYekhu72Jo/LX/qkj
	68oK/OEAunWh0proPwihgTJPlpoEUDjCcdsU4q1SDEqCM6xBcI/wJh/j
X-Gm-Gg: AR+sD11GVbOtppStZjUiHPBbLNBWpyM8rbT28NaU5hzltX9o94TaLSNktwIjTvyRHQJ
	NA6NDhQnYYtnadOzV1BB0bvayumwT5rM5zGXlklFRmjK/8HYLvmXvVK7y3dU81TdP8uxR6wkKJ/
	g60fFg6QuZ1jSvVJqSlSgB/ceNCksWu799llBSeqj/U4eRfqZW3GUnXoiQKl4Q8Razowm1eaquJ
	yMmKdoGYYygjw7s6CiecnaNqDjomHzUvY1rf5BZow0dLLzc0Ga5ThW+E1CVWvD3b/IKLjOOF/mF
	NcunnlJkcp/c8YF3nf6HgUuDDsQabPCSxRLjevj5obxvj1Q2dDnA6j0p5V18sZmMuKKQJTuMGlr
	IV92Mr2WWLykMxJ4vAkTW5KBte7irceaXIUQwJBv4CsakB/nh8Rz1qJAoE4Klp8IW96fqXCBLwv
	gay3xWjT1Dbl0pl+mYE1IoOKDhcN8gU2oa8/5VVoBcjWI69Pj+iEFGNvFbtCXx5LFOtKiHAxh1j
	GMSwIJl+DW7/SVvMSE5ZtfGq/Uv4gOM2cwDYCim5uz0/qm6WBvj1/w=
X-Received: by 2002:a05:622a:1453:b0:51c:2022:cef5 with SMTP id d75a77b69052e-5213b147021mr219035321cf.26.1784716195897;
        Wed, 22 Jul 2026 03:29:55 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b089:8e47:e4dd:73f0:fa4:cadd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3555e7bsm12410841cf.23.2026.07.22.03.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:29:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] completion: complete paths for git send-email
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <xmqqqzkww3ky.fsf@gitster.g>
Cc: Yury Norov <ynorov@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 git@vger.kernel.org, Thiago Perrotta <tbperrotta@gmail.com>,
 Philippe Blain <levraiphilippeblain@gmail.com>,
 =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 linux-kernel@vger.kernel.org, Codex <codex@openai.com>
Date: Wed, 22 Jul 2026 06:29:43 -0400
Message-Id: <C9564DC6-6B68-46CA-A339-1A1774AFA7C0@gmail.com>
References: <xmqqqzkww3ky.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 21 juil. 2026 =C3=A0 15:22, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFYury Norov <ynorov@nvidia.com> writes:
>=20
>>> In any case, when both a '0001-my-changes.patch' file and a
>>> '0-tolerance-policy' branch exist in your repository and current
>>> working directory, running:
>>>   $ git send-email 0<TAB>
>>> should offer both as candidates, I thihk.  Since I only ever pass
>>> filenames to the command, I personally do not think it is a huge
>>> loss if the completion script stops looking at refs and sticks to
>>> filenames only, but others may have a use for that feature.
>> Agree. The test should create a file 0001.patch, then a tag
>> 0-tag, then a branch 0-branch, maybe something else that is
>> relevant; and then make sure every option is correctly offered
>> by autocompletion.
>> Guys please let me know if everything else is needed before I send v2.
>=20
> So in short, we want the problem description updated to something
> like:
>=20
>  When branches and tags whose names share the same prefix as a
>  file (or a directory???) that stores a patch exist, the attempt
>  to complete that shared prefix
>=20
>      $ git send-email that-shared-prefix<TAB>
>=20
>  should offer both branches, tags, and files (and directories???).
>  But the completion only offers branches and tags and fails to
>  offer files.
>=20
> And the description of the solution would follow after that in the
> proposed log message.
>=20
> As to the tests, using 40-hex is misleading, and 0-branch as you
> said would be sufficient to reproduce and demonstrate the issue, and
> that your code change fixes it.
>=20
> Ben, anything I missed?
>=20
> Thanks.

Not from my end, though SZEDER=E2=80=99s review merits some thinking.

Traveling the next week+; replies may be slower (than usual, hah).=
