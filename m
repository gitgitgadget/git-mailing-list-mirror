Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C74281504
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046035; cv=none; b=Fd0hKXcK0EVI1rYqLrmW7EPFSroTzrE37evwvkKir41HzGquwrbZDt2Zox2kjfKd70lni9o1b8LboYkldBVHW9ultTFeRjo315jplEV6sdYA6UgmcbXhctOdpF+8Yo75mrc/0O7HldOuWiQ+9TdDVwOdGTRnxWMvst4HWguw8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046035; c=relaxed/simple;
	bh=7GLH12f5e74hT5WEujAXjIFTs7AHNdaiEieupYHJJd0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=vFZiofD6FgC1lgQjZL1VoLy6cEZI6yXjbaBwEI9qAwbq+7FRJYqbxricaurhXDzYe/+OIcskAywi3lEYgMkLKuzYuc0gxDqdD+DpgCxOZ34irqQCxoZCcoqgmVji0/PCxT5jxhCWGhZTPEBlHwt4ItouKnbCKU29eQ2hujUcpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnzvE+Le; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnzvE+Le"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603a269cso14875517b3.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760046032; x=1760650832; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzxf7SxNW6WF2vMg46X2flUoV9I5g5L4cMWgnYSvsec=;
        b=PnzvE+LeGJimJHhJt8Rm9QPdBaCpGZUCp68q5ucL19/iNQJLgnCOvdABNjdZd7X3rC
         Awv7LOSVPUBvH4U4pvJuYNjvB8KGpDBQjWajwpumOMiqq8mIIBvrWeYFzNEv16MVQ72I
         DCDNCgQKke9ISR/k/B0GUrUD9IUbVDyHLDTO+rYskyCR27yK0IboG94lA0KfqVxx7tZ9
         CwL9SURjWCN65+DfbC5p+jmJrVD0bl1Fkztt0zNp4YQJDRNznEqsFcGiWeNf5f2g36Mt
         0Qq6nCdCkyxqr6I+ljjc9mxeFHhto+AMO6DC3iEMKeBYgsrAI99KpolHtO/pAHhEJLkc
         cVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046032; x=1760650832;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzxf7SxNW6WF2vMg46X2flUoV9I5g5L4cMWgnYSvsec=;
        b=utf0XhldchO5l9nlwaXCrnbhIlmZF8+pjqhXtiLSVOVEBM0noOKgNSc2gZo4QNn88Y
         v4FjpDsG82EPi1NCq+hPLYts03O/s/U6wVjphVwAXx9aJ5NvBpO6xvTRsIAZekUr8L+W
         IGra3BN9s117y22QwdsS+s1bdEgiWq8utF2HDEszNsUFgFArLAz4AOXJgHJ02rfwOzDI
         3huMi582QVPkwHCoqi8Yb95b34g47S5ojAXPU3GxH5rG5jCSpLBkcA/fIHmEVtFd4Z+3
         LrksGxJKSji55PJAz4Tp58jije/ds0l/uiwR7MkNq+b1fZoHqGQqqytUYENOE6cjivM9
         xIAA==
X-Gm-Message-State: AOJu0YyZs+EipegwMtjvB8IQ8XjgWH1sk7q9BrEXTENXhrEckEnnsn8T
	pfZDw/2/XZg2SM0yzXub+u2tvqvHbDbwPj5H8iD+79F5HxJE4IOlAZHa
X-Gm-Gg: ASbGncuQZRzbfQQ+/4WPLgi7M4GDvQDAz98qEA6h9BEEH0tFJLYAF5WQlkbOHZRLKU4
	jgCyu+FfaEt8eK7HaO0kcahnNxvdFl4f4HJPoVeZGMCoVJncSh3qJzsUQEexWYclAXAzfxd5fbH
	4xGHtNmUA+bl3DHFXIu7i0WRQZsLSk6yAjp98wswhLDAsTR+rEW/AI693FQkbdR8gJdJBp9iefn
	zvcvBA+0K/zRJ2oQxz18R3veR2m2hFF9aaTd37ngoOdEpFHdDlbPj9bP3I43rSeptWrAVD5DzKC
	r1GSIBKyIPEu713Rv0YmyW/vBh2FEI1NVM6hoAXBFkjkl1uSd+lhIfFQ8+SElCx2q23vdGByHet
	Dxroym4yr60PHnBQXec4IxDNLbNODJ1syPPkdqrbP2cskUyiVbK9zJz52HOF680e1T4PK3xFCIz
	E=
X-Google-Smtp-Source: AGHT+IHMLSoTHfKT0QdPcSV0XL/1U9lBtAfxLDE3wq7Bn1UWaSlDaVwgCBaLrfXou3aUEtCmfXecog==
X-Received: by 2002:a53:d649:0:b0:636:d3f9:6418 with SMTP id 956f58d0204a3-63ccb864da8mr7481791d50.22.1760046032296;
        Thu, 09 Oct 2025 14:40:32 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:b947:1acc:4105:ed94])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-781072c76f1sm1593747b3.59.2025.10.09.14.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 14:40:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: What's cooking in git.git (Oct 2025, #03; Wed, 8)
Date: Thu, 9 Oct 2025 17:40:21 -0400
Message-Id: <1D9EE7CD-800B-4B70-8D98-79B0C2FB8DBA@gmail.com>
References: <xmqqikgpdj1r.fsf@gitster.g>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqikgpdj1r.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 8 oct. 2025 =C3=A0 20:18, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> * jc/optional-path (2025-09-28) 4 commits
>  (merged to 'next' on 2025-10-08 at a1e8af9952)
> + parseopt: values of pathname type can be prefixed with :(optional)
> + config: values of pathname type can be prefixed with :(optional)
> + t7500: fix GIT_EDITOR shell snippet
> + t7500: make each piece more independent
>=20
> Configuration variables that take a pathname as a value
> (e.g. blame.ignorerevsfile) can be marked as optional by prefixing
> ":(optoinal)" before its value.
>=20
> Will merge to 'master'.
> source: <cover.1759094936.git.ben.knoble+github@gmail.com>

I think we wanted a few cleanups on this one, which I haven=E2=80=99t had ti=
me to make. If all is good, then great!

While I=E2=80=99m here: I sent a new patch on top of dk/stash-apply-index wi=
th some more documentation. Looks like it=E2=80=99s been overlooked :) is th=
ere a better way for me to have sent that patch?=
