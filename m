Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE522A4F4
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354570; cv=none; b=cpIvl1MJTeb7eW/D8PwyfBDGyvQZmksArBUwujjzawarjsthFCPZ6M/W6KawDEqG2sjGSlTE6Sly7cbp8wE7uH+10EPC0DMYIk9fF+kOxS7wRv0PkLdFqqztYCB/8etz34Mi5WJS1QRLxCFBuLDcQIUj1KSPdcBhPrKHott5Ib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354570; c=relaxed/simple;
	bh=/27dmCocH7RndIDnFXMM/5TdEl7qsSLDqQ4DiLuDuqw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nwefGnouvjR7UJagg3fm9SUhDM37W+3gIAqRe0DNo1nHmttR82GIvP2bbJLOK3KvLUL2o+aLMVjnZehSRYvYcT+BBxjdzlDlKVXywWK1Y6vNeeGaqk07t8EDfZVqfQyQPwCECelSkZmdaJtnqNlu7dSqZfZD4AW/fuyOKIkQrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLRBV7RR; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLRBV7RR"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8a479c772cfso453456885a.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762354567; x=1762959367; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/27dmCocH7RndIDnFXMM/5TdEl7qsSLDqQ4DiLuDuqw=;
        b=dLRBV7RRWCXVp5P35nmSZRcJtXuhEWmFhm9GBWllTr6anlkNnz9nOaCuse9XJ6Z9Mv
         f4BK6Uimzszuo0NSlF0gsCQPxknUG6vlU5/7o+HGAPRE+Dg/Iz3i8GqrIgEnzi/M2VVx
         0mbgWCKItLQRiSjMwE3CSXi71ulBqMtCXU1xRL1BL1RY69yFMniZP5giY4wQU2SrhquG
         Su6gIohDu1PWIya+HXnAzcFFepZmaz7s6SmjdiRx8nSP4yuSoMDZfpTYQa4SAkjt8dIT
         lpTHCXDM6BoLXc3IZxRO4+sAbR49ige3Gtcc3VblcBp7cn4RlbxKSGgMhM4MD1JM91nz
         z7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354567; x=1762959367;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/27dmCocH7RndIDnFXMM/5TdEl7qsSLDqQ4DiLuDuqw=;
        b=V+ATNAI+kiDpzobbw0GVJb9hwRFQNe1MnxeB4rkw51Q23byQZcYvXaCLOSKxPmNAzq
         g60zSSizhN1JV61wp4JU8lhu6IKoqUObK+HuyeDq55YmLSlGxtLrm1JJ8lGIADu8gqe+
         zERe05U33yB/t0Cx0CPP6sZKTzA1MS5hJBaG63z+xUkevQirfMqqzPr3XXzVRaaXthB9
         wBUKEj20EcG/gnSit+tQO76dTPiQpVr/BEE3r4ZzLHWubQ9HH2VSlNMnw/2+6LnPENg+
         bIs9poowR1aPGqSOcUos3kbm+vu6v2TKiCAZ7LDst1jAxgu+bOXVOneUXt6vO9VgrtER
         3S6g==
X-Gm-Message-State: AOJu0YwociqsfEOigZ5Sc9OrorRcRjt8lqqk7xnWRUwyZYs77Oui55WG
	hAAzv1OjVp0ROFIxLQp2SnXEgLouwrC7sbU7GziX1OlM6v5+gfi91tp4
X-Gm-Gg: ASbGnctkL8C90UtYqTu0awpPcWj21teuCfxQ75G74T+9qsMkt30Ao55xmkRdqC8N0Es
	j8Q9pmn/n/uEPP+j+cD25UrPhdvi8o8or1eP3Kds+E4mlPGKt7LeFCQVuH8wpSUS1vYPUNhzTsq
	l2zRMJcg2Un5mqCMZON8mVbYc1yq1nncK2gJoEnaXTXMhr1XSeGCQhh+OWMaaXQi+Vfakz2I+6I
	iT7h391VPUtf5xyEXmVgFPWGyFliMDCLjAY2aNwRu3X8meJkc4RAWqbPQ4Tr+9RAmbX0vrTd+UT
	koM1V/IXPqG74/ApwrDLzxppVrEt0cje3G0Xv4z2rLvlIcGVVvaMD/xLPEUr7aIbBH8Rkvpzwwq
	DHWsuoZTMsUibGc47QqG+Rkb2pjg7Bbywej51ydSSNvCLYKx++fXGwqSQcbWdPlUK0S8DdkGWpn
	C9iIh8DWIuxTItX2OUydkCRgaOBg88ITlHFf2x8Fs=
X-Google-Smtp-Source: AGHT+IHGXwfT9HbGnbfWpXOnNLw0/W/j57o+oVP/mCDoRma6s6bfhv0ZbDvaFJPwx1SQJW1gSJHlLg==
X-Received: by 2002:a05:620a:294e:b0:890:2e24:a543 with SMTP id af79cd13be357-8b220950ccamr461117185a.34.1762354567337;
        Wed, 05 Nov 2025 06:56:07 -0800 (PST)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691fe0835sm19438767b3.33.2025.11.05.06.56.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Nov 2025 06:56:06 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: 
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <ed8a6d59-9b85-4ca6-a23a-1e43efaa7efa@app.fastmail.com>
Date: Wed, 5 Nov 2025 11:55:54 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8EAD922-315A-42F8-8E77-5C562B5041ED@gmail.com>
References: <0be81c5272a5e42c8471239a1369ee6c32401bb1@mroach.com>
 <ed8a6d59-9b85-4ca6-a23a-1e43efaa7efa@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Michael Roach <mroach@mroach.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


> I have seen something similar when using the Delta pager. I=E2=80=99m =
pretty
> sure that it replaced a hyphen with a colon.

It's a known bug in Delta:

https://github.com/dandavison/delta/issues/1259

> I don=E2=80=99t think I=E2=80=99ve seen this behavior with `git =
--no-pager`.

I think it is a good idea to also see what happens when using another
pager, for example, less (`git -c core.pager=3Dless ...`) or cat
(`git -c core.pager=3Dcat ...`).

Michael, can you run with those three mentioned options and see what
happens? Last year I spent some hours trying to find the cause of the
same bug in Git but then I found out that it was actually a bug in
Delta.=
