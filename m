Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59152620D5
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487628; cv=none; b=ro/dWBiew4MrRRNJdBRKTGHHMpXtuCYf6mmfLW8TF0F4nav+/JlKyrA97WDT/E6+Ueb9OBd6oK3+PCiI73oq4Fd+vHKrefX1l8Z/dvn/wzYcpQsOKMIDCDNrUupwbWQk81ky2NhsKSas2k5y0hOkggSnxAjY6TGtkR3vV81tSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487628; c=relaxed/simple;
	bh=CM0g4T38bSxyUJNjhFKNApLepANCuFKYVp8GXh+/mPk=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=qPj4YojZ3J0OugaMVHTvD4ZDvxpdf8kEWxqsbzDuKvGr7u8ip0JJCl/QYnl0oCRrpp+O9OOFuMQCkZe3vLr2GRTbyDLHM1ZXgX1bv6P4J8QXxX5XuktH9AlBW0E1ASit9j0+4cn3wyMJL3jTe1tufVtoQtQ7PM6NzGLS2kf7HuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4XZQBSE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4XZQBSE"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-713fba639f3so23321267b3.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753487625; x=1754092425; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CM0g4T38bSxyUJNjhFKNApLepANCuFKYVp8GXh+/mPk=;
        b=V4XZQBSEMP02kfQ5OpkwCtSKBHeOZnLCYIirB5GtEm2rkxFo44vAe7ufJiJxIRGunu
         Abutx4JxE2MfhOCPW8heWvOWAQXkzcfVvfUN663erpVIr1DY6UibQx4NBRuVo8D7k3Jj
         48UxuqF8qZP/IlT4RLJ4mRjE6hs+ZNjUgM9vwva3KzEEe+OPGMUZ267TMlaVc1F5vOtz
         A5isRQGD2V8M7GwLl/nE6DQsIE6TP3WhCSF5lTmaq4XZmrT/1zhxsrVa88Mad5ieLM4D
         AWhC5MWXv7pDrPKqKUbzOfuKweSI50H6/MQas2ctbiBIwLqMNYxVqNPlrLXXwdWqfYiZ
         mHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753487625; x=1754092425;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CM0g4T38bSxyUJNjhFKNApLepANCuFKYVp8GXh+/mPk=;
        b=wbpj+vyGmzLVbI7WUgCJJM1vLvuDb75hJbwa887CqKiBQZlyedvf6sJsM4VarDg1+W
         kyE8+aWsUS8UWxCcep1PIzNqN6t6gjnQGwOFZNiFzcFayz3b0kk9Uvntc1zfQ4522c0C
         mn6vUa0kx8nDuVsbfRG27H2Yn0+jECgkXgHAtoWiW3pqEb8JPnrLt1pwYdD7oZcmZu2L
         TgBMbkD+oMuuxLWtCzmi48CeZMJf1eLnMOkePVUF/6aBzPCUtf/aBNY/TW/ZfYfuqOjS
         CsmuXmiKVUMdn6bMn68CBMc4aZwqdOOD4habj84QuY7Joj4LKb25QHpCgrJfJ84USvUH
         tvEw==
X-Forwarded-Encrypted: i=1; AJvYcCUMx3+76OvzWtIRGZBOr6xxTXgIWHRk/QLnzENOKcV7rURtXpCE2gg6nPxQTGS/Jjyi7uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1sTMvAKGLFxh/NiK+pD5LFfNNH+wh3OQPbo051BeWPeq2SgQn
	PWoXeMSua7sW7u/nvpEIaFMBeY6QKQQ1lMYtqepPFSqz0AdE226Kx62NIMZqQrHF
X-Gm-Gg: ASbGncvWTIGGGtSt3+Dmo3OmU9uWdCx9ThE5WLDUyyJN/+iUkuze/yujIGkUsDPlGWF
	euYTR6dbSnNDz5ErwHom2W77WX/lGqhWtztGJ2+Mvyhmm8yaBnklB3fA6GRxKDyu034evy5Inqq
	wrUSQ76iCvCsiHBvyQN2GQ5ER9nwdE08EDMRXWeCTJmIo3J6d2c4FuD9esyGcnQvOxkIYGz2b7C
	h8z1Vaiy2HW2AS1SEzhKOiPDJysNeBBt0cFTD9ugQbttLqRY5rctDxUqipdVBkAtxxTqNzr6iZB
	dT3JJmli5mmiVhQxGCnTdNXqdHT5BOY7wyuUICzur4ykgmjo/poXpFxwy5DYcwjOmcd5kgNRVR3
	XLtYhoNnmlR/0qlfHABdHtukKZG25HVQH05du7dqJPWFiA9SUPr/SF8zekZOm1JckuSFDJBYG3a
	Qve/r5Hqx0F8p21DM=
X-Google-Smtp-Source: AGHT+IHiYKxtAUqQv5sAGS424tmwJRyxF7SME1Kql7ZK6oY4AUYNA4EtOdK8xOgAtNmiuyvH9GE/3w==
X-Received: by 2002:a05:690c:7204:b0:719:ba32:51af with SMTP id 00721157ae682-719e3409d11mr47193357b3.22.1753487625413;
        Fri, 25 Jul 2025 16:53:45 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f219579esm2119677b3.22.2025.07.25.16.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 16:53:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-Id: <B3683B69-425A-42D2-AA9B-AEAA34475902@gmail.com>
Date: Fri, 25 Jul 2025 19:53:34 -0400
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
To: Christian Brabandt <cb@256bit.org>
X-Mailer: iPhone Mail (21F90)

=EF=BB=BF
> Le 18 juil. 2025 =C3=A0 06:15, Christian Brabandt <cb@256bit.org> a =C3=A9=
crit :
>=20
> =EF=BB=BF
>> On Do, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:
>> This series accelerates xdiff by 5-19%.
>> It also introduces Rust as a hard dependency.
>> =E2=80=A6and it doesn=E2=80=99t yet pass a couple of the github workflows=
; hints from
>> Windows experts, and opinions on ambiguous primitives would be appreciate=
d
>> (see below).
>> This is just the beginning of many patches that I have to convert portion=
s
>> of, maybe eventually all of, xdiff to Rust. While working on that
>> conversion, I found several ways to clarify the code, along with some
>> optimizations.
>=20
> Just a quick heads-up: We (as in Vim/Neovim) have been using gits xdiff
> library for use in Vim and Neovim.
>=20
> Is the plan to get rid of xdiffs C source completely and replace it by a
> Rust implementation?

Just a quick FYI about the other branch of this thread that might be relevan=
t: there should remain at least one place to get a quality pure-C xdiff, but=
 I think Vim getting a Rusty xdiff (or the possibility to =E2=80=9Cbring you=
r own xdiff=E2=80=9D) would be nice.

>=20
> Thanks,
> Chris
> --
> Eine gute Stellung ist besser als jede Arbeit.
