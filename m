Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255211BF33F
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136227; cv=none; b=UH10qkWrGRwpdhT3J4D+D/Y7MdrFAnGZUVThBjrJVgEhab9eVB9ONK5SGqck1HHJuxWQ+7Y3tpOUlmjjwmHh7bshjqKfoImMK6zL4X4ketk5XuelXjyNff9F8gaaG/HNveqQjYr/aC0S0Ijf80XDrnZtkO6pDlFeag6L0sFufPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136227; c=relaxed/simple;
	bh=y37ueq77wdqRynCHTP8q0kLv17yCYhfN5LSJJarU2iw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QNZzYboffOfYb9Gp7YuLW7S+6v9lCnOIMdnly/GkO6m/DOsIY5xpj8dQ8V9uG17Ll1iCqZtxdrm1pHLXBzJK3ddrH50lgHs4U7ymWaCd9CpVQY7aSGBsfy1gycYNywgNLFEVdqsGofYgbBsvBDf/r18ALaKbXIMlvZ72+zbrO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm8vF7Mn; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm8vF7Mn"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81749142b3so1053324276.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749136225; x=1749741025; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAnDSXfqWG0iLpjTq7OW8jymGN4Kh7L0lTd5dOhJRTc=;
        b=mm8vF7MnR/1cq1k4+XDS6jVaEK34hga0fdZmYIBgUAQGaQvFvSecta2xJEeuSvKQxW
         XP5skm+09qysiWg9HxlEB1iQAY/+7Mh//idEyAeM4D7kS/wC/GADlieGMB8oeSpKRdjW
         EAXxYrgegjgGfgIyMB96qt1okgk2EPx6aMQJWUBaTKLQhrb3QnjUAm8rrmUrNhb1njlx
         ngp5JoFg2RLQlTJkcWxviMDSg1I7bPSCfKJ0mM3CjVZ6/tdjMspN4e1ffdAk2fWCq/Xk
         4JWChiYhCM2Q6ZIkV9ihuO5YI1I1FcR6bC5VXqqgZQIpjv+r8p7WAiJZyPiIcyY+EkNj
         y8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749136225; x=1749741025;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAnDSXfqWG0iLpjTq7OW8jymGN4Kh7L0lTd5dOhJRTc=;
        b=Ycegj/3rSfsgDQfZ6w5rC4X5XMZz97RC9pUIApgg4Uf8ubCcSACIdSuPTG2h0BJxFU
         66vnK2KJaYGFS9eLFPqW3ezLMHeDMiomhIh/USTrgQfAcgRJbnxxDp9OyCF3kaBBp4La
         p8S8c9+ZUwwGheJZVN4gybxoOeulwrU3sSl7T3EJh+tXWQqRwEX8yGS0wejBorZUcKxT
         IrDSRMiQgC2wV2sT+nkISZSsOjoKK9BffmC5Hqt8H6VHiDPBmOSilvN9Ex558Z3FrK3X
         c9/7bMkZ3axk2Z7LpLkEL2IEMbAhjY501YtWFMTD8UeS2d1BgBqJmcbqyVpz4XVWraHO
         NYYw==
X-Gm-Message-State: AOJu0Yx8tHnVtaCi08Kmuq58FE3NW2Q9pkJlXg0uGwhZvER7tvj+cwaZ
	PxeAolA/AJRpAq3yEo7HJzJ7v7LLOS5OPnkoGzTFpPnc0FHtOelsorMBE4T7lA==
X-Gm-Gg: ASbGncu2qeOWQHkBgO8fXtw8olm0XkxnE6uWfPGXSC+JjxsvWK5Kiu4hOMaFhKy/YWh
	ECQiXbz75skWZyT9Q/Np0pZp4rQ1nj9EjpoUGx/5ksRFbxDmG0XRSypFv9iQpZ/tCnwpWXqt65z
	UVe4UYcsIDsZYe3iXo2/OHA/Rsgd7SrVWHw8mBp1hg06R1CC7eqDVqZ/kfZcp0CrIdtF8Xe9W2F
	Df+Qn+bHV+jApp9i4X0W51XPpAaC37DYrKHTEd963VVeS9D2kGjuKDmbxmZ5LlN+tHm0mzcs/gH
	/qArZZrVmAMenxt8AKEKjNR/bkX3PNa0Ei/GGGWLvsoUFEYRcm89mpZwaeTAeJXl4GLWaCUjwMD
	5roS3CEvKkwvaeee/yMc=
X-Google-Smtp-Source: AGHT+IFM/hFwlvSwRVWr6a8mq4unSgxH9PTMo/5R9tGAe9hA3IrVXXql06iITlWkfMJ5dW8SNAV2LQ==
X-Received: by 2002:a05:622a:428c:b0:48e:1f6c:227b with SMTP id d75a77b69052e-4a5b9a47e1amr1490781cf.26.1749136214186;
        Thu, 05 Jun 2025 08:10:14 -0700 (PDT)
Received: from smtpclient.apple ([2606:6d00:11:21a7:2dde:84b0:4ba7:9a33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358cef79sm110962451cf.35.2025.06.05.08.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 08:10:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
Date: Thu, 5 Jun 2025 11:10:02 -0400
Message-Id: <642C61F8-FF74-4012-912F-51D364D1B2F6@gmail.com>
References: <xmqqzfem9ws6.fsf@gitster.g>
Cc: git@vger.kernel.org
In-Reply-To: <xmqqzfem9ws6.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (22C152)

Hi Junio,

Yes, I got pretty busy (I=E2=80=99m on parental leave!)

Feel free to drop it and I=E2=80=99ll resubmit a new version in the coming m=
onths.=20

Philippe.=20

> Le 5 juin 2025 =C3=A0 08:51, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFPhilippe Blain <levraiphilippeblain@gmail.com> writes:
>=20
>>> * pb/status-rebase-fixes (2025-03-28) 4 commits
>> ...
>> Yes, I will address the reviewer feedback and send a new version.
>=20
> Perhaps you got busy after sending this, and I do not mean to rush
> anybody (as we are now in pre-release freeze anyway).  I'm in the
> process of decluttering my tree, and I'll drop the topic soonish.
>=20
> These topic lost for decluttering can come back by sending updated
> iteration, of course ;-).
>=20
> Thanks.
