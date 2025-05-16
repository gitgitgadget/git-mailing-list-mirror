Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A46FC1D
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404436; cv=none; b=K+VmKQNkZ8VNLQHWbVhCHpkyo82gSlyKYF2cCTdt6efKM4aw5/g7EaEayHNCF8g8KdOl5ApwGA023MV+xrqm68l1PR2kw/rbD4yS0R3Ct2RmpC/N9byiYnG+ETAHb+gXfxLm8YhlIqiez4hfFOzLW9npfxHg3Jg/Bypl4u6fVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404436; c=relaxed/simple;
	bh=99Ad/YZB6lLOKFEhYvDgP8SXgJqUWLN14fLbYN2HQik=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GxGZQG54cQucP+FYh/Li0UCH5Y0bWU30bvs/k36JCOiyrpQqtM2K2WG+fUzm+Zp4kYYAiWqLB1nWOcBHSqgx9lYGqbGyfnzELBbSBn/ryBrp26vjdvJLBQ+xtYvbzj46Gl8DIhwis671N+bWxawhVxokhPkX1gOK3zkvATzTGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3ZnaDyj; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3ZnaDyj"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d80bbf3aefso5312565ab.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747404433; x=1748009233; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bVOjCp7scOHIEYgmuwtJSItMuy+4V8SIspfW98k9VI=;
        b=B3ZnaDyj9WD3YAuhqiG6Q7xh+YJ+ipwAL2lCqXkrGaZjcFFqe82+PeaEDlT9uwtBR7
         8IGDKZOIJLf5TQCQSTDHZnXzcmLrFDYuQo0oBwFZyVu9YxRb/k2Kf747SLZ3kDg8sySh
         YoVgsB+Ug75UFKCpna9wBK8leRIaj4Iuqnl1fz0L5bakU4bH8vlvplO81s35s5lmcXi7
         cosMn29ZKHnhClFcd87OUlGAyWZ0AnlIoe7XDw0NoNhIdy914WBG6EADq3WMUE/gS5uF
         gPVzG/kPDwpaKobstqNTEFO7KON2x+LPM6IFG0KFenPHt9W6krCCGaf7aF9gZNYepWp7
         nImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747404433; x=1748009233;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bVOjCp7scOHIEYgmuwtJSItMuy+4V8SIspfW98k9VI=;
        b=OLdxWQ4M+2CGYh/1jmePEmfzfPM7TxCjP6PLDVf7lbDtiztqfBIODQnVc5MtroqzST
         x4YJ3ZUmt8BxrJXHxUN9BOTJqFHQF3oXxE1NjLX6ByrDHB+ZjoGPgpfY5a/p/uBkdOvA
         2okqGGC1BmSBqJ/Fwn4oImSW1OYp13lnWHVPL6xQjFxtbLGpSgDCGY9s+6SZav54tk7v
         y4UfdcWfKxrjVSDUREBZJxytMiHYC4tNFQIbkKeslauVa+2osGVtXJTrbkivw8Li3lQF
         ON+sCRNqGo+t6c07DMqYStpV8WSyEsTxmMnM+c63BhGfsVfUryQuDXWGETzYfT/nJcd6
         8Mug==
X-Forwarded-Encrypted: i=1; AJvYcCUlOGvGRalaQMff67GP0JhKXDWVkBDZNoiNE7vU68J2LS11pw+XHLLRG2ZpRdSEJduWN7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9uRmVPPyHgyTYsE1mI8pXduuZQjpsZb1rtPKVk+uEQDDli3R
	ciMRnRmV7dy9he8qEliQAvre07BAidX7RJhayyVuLz+ij4ZdTssAhCASC+MTQByS
X-Gm-Gg: ASbGncsnulWSxq8J0XciKt3bvPa0PCHtuZW8hdPwCgVAmPRvMKxF2eeuVle2kchvb+a
	24RlUlniWQiK9waC05GrM0COCynxoku4Eq2QPaHp+CxN2Pqfj0vL6oBKyOqxKuPqeXEOEEFRCU9
	gFp/gmSgoe/rT4PKh6O5/GZiY/cmI83vkj1PhwgQ+T/JmAkzT2KG1s8h6WH1xVqaZKk49Wk3r76
	geEq3yPdL6GKG8as8v3vWF1YR1/pbOr1tPQ6ZmoE3pblnHdzPh+dlA7YMvUVvYW1Ag8K3CXPOxo
	oPtw+VFXN0ooi9tSESqIjjNc414ACdWjvj2SaGzbtdpnDQlyIZ6riWAqr3TjuSHfhLO/1biLusQ
	XmT2C
X-Google-Smtp-Source: AGHT+IHM35UoVjp1NjVmAG+Yewa1D9Ey3r7XWZy9Gc+JFqyqauyJgrHCeuO6P4ACQmGtmcDogqABxA==
X-Received: by 2002:a05:6e02:a:b0:3db:6cc1:36f9 with SMTP id e9e14a558f8ab-3db842ec6b8mr50465925ab.8.1747404433263;
        Fri, 16 May 2025 07:07:13 -0700 (PDT)
Received: from smtpclient.apple ([2600:100a:b123:13be:45c1:3f32:a927:b976])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4eaa3csm397002173.143.2025.05.16.07.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 07:07:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are just comments
Date: Fri, 16 May 2025 08:04:25 -0400
Message-Id: <ABFDED43-3AC7-455E-9736-A8D9AC0F3A40@gmail.com>
References: <xmqqv7q13m15.fsf@gitster.g>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
In-Reply-To: <xmqqv7q13m15.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)



> Le 15 mai 2025 =C3=A0 11:56, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
>>> -        grep -v -e \# -e ^$ work >patches &&
>>> +        sed -e s/#.*// work | grep -v ^$ >patches &&
>>=20
>> I think we could just use 'sed -n "!/^#/p work >patches &&" here
>=20
> Or even "sed -e '/^#/d' -e '/^$/d'" ?

I=E2=80=99m probably missing something obvious, but why step away from "grep=
 -v -e ^\# -e ^$"? A one character change from the original ;) If we must go=
 with Sed, I=E2=80=99d prefer Junio=E2=80=99s construct (combining, with obv=
ious semantics via "d") over the sed|grep pipeline.=20=
