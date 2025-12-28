Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F9625
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766963399; cv=none; b=Kscyv8EVSuaUts+pB2JpcImJVIspNOyPWOxpmiCiPwTJ4sOZxNZuCRJfucANDjrsZTGhmcIqJKAcOSPqy2J+sK9PmYYTfk3Re7Np107q/qGb1Me2I0adGwc7ai0lz+8Cx0nNA/3qGv9K5rLfIdZxHVeOMP1VzhtVjKEVVaMoLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766963399; c=relaxed/simple;
	bh=RzH22U8EjKARQQU77w50mIySZY3P//NywdDz8nI4x+E=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DxTpyvsYrkvb8BesBj5NSMZWnFQQwAsYUv3ZuJRExuCeJQYQIKz0syZRNJDd9QIKbVSmARHgVIHpXo4szVZxXVMYWKCGaqKbfDtv/fxDc8eIZaf2DOtbyU6m/BlaAi1eglNaMSpfC0yWxlbA0UZwu8RcB+uqSVddXCLXa7l7fko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWFV0YKS; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWFV0YKS"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso3997536d50.1
        for <git@vger.kernel.org>; Sun, 28 Dec 2025 15:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766963396; x=1767568196; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzH22U8EjKARQQU77w50mIySZY3P//NywdDz8nI4x+E=;
        b=hWFV0YKSlCIOPvFzU7kmmM6a1KkPljzN09EUcI0u0sqVBdIXGzlT4NquqwaDDkdSg8
         KNyOnxd3IrVIhvTTy7T9F55G4IFsH3qx3HE/ZD4VvKjpIhKhS69vc2ihfoxZuQMqXrjV
         qzpov0K6/ORJWSZ8jHLVmNZuz3jvLKcu8h9zWiUqQO5yEvDkvSxKeULiG+sAjR2dGGYp
         OH73JPQb5Vt9/diTs87GWNVnT1TYHxzIflafxk4pT3FniBGEwKZokKyYD5dPtOLaYuow
         MvuCRwwrN47ECOSRGWu70F/NJKf/mJiXgY1ranvukxfbc5Z2bw7QeMk5aGsGT/t5q/cW
         pq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766963396; x=1767568196;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RzH22U8EjKARQQU77w50mIySZY3P//NywdDz8nI4x+E=;
        b=ruKNewYiKtM7blPVfyFtxji2B7euzvzHUsa0jqqWxs5QtAQiQ+jSFfAVy1gBkzV2wJ
         zeUjJlVyEqk4h60jgdXaHwduPJCKV/0EQrn4S/H9AgOdj/fAbWHMyloH7bHa45kBlY6+
         MrmDTeMNFmJEsb3NvuxZsmdbrk9U2g9mTcUNiV2MTGBmn2/ITxIYW+Z9ui++y60XwrcB
         n0jsQf9Y5JhjkPokmoWayaO/oPWwjtrXYlSgrryT5wU0D6tkHmrAzs01uzc+K0QoZRuq
         GiqgH1v0oeaqoK3ShiJk2qVwniRsD0bFDFa9D6JZEpr+7gNGFd2hDTRNU9ds+iJrp4Z2
         1F2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZFRiSuArDrlP/0ugVQgD2j92u0tOdM/4Z2hfhF9ZPKKuAUbvic7hN+Tb3Y0CiL8eiZ9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PPpQh95A/Jj12DdNDFXoTCmyS5/ruP7CYgoef/3moZLZWXV9
	sYlwlkSgrvVTudOk9ze0TITq5fvWBRgFzrgyyxKl8mTNA8DJvxApeYMBF0HC1A==
X-Gm-Gg: AY/fxX4swJc+qqawp9MuST/64MjhH9vZ2sfgp3xbzGgu+7CcNsybneqbygZoVi67g95
	nWZnqPqqlmi5Pu0+Ryac+g0PdssszqScEFCC5uLA2W+X4IqibuuicE7EyCseA3AYIiFicLfPoh4
	Rrh/jN5Jj4kr4AAcRK9/Hg254Zbz5u/OZKyQzRbTkjSpW07cREgTGtVtq/1IePOmH8r2rsLRkOv
	2EmtlrGg75FEsd4gOqAvoD35qTl5es/qgLm+85mVnTRJDgSqidzEmP9a8hNeQuWFD/nBx+MhfGF
	5TqchE0v4vceE7J8ncP3hGZ1vj0CYZGprX/3so5Q30qMW2Y0Q7HsTHJoonEdY88TnFUjSV7RNEk
	IgE988bLJjPs+SXeu5i+AvmOXwM0HBehFRDx+ep17QLtzrZZ+PVh/6Vk2b8XUHQX6KFg0y45lew
	kSje5XnI7Po+jhoXoZzi74AKhIhjrou4gXFXg74Df4K6rl8w2eggzlGDViX/cnGEdXCEJG10eqa
	L02VWxVBUjcZlhHCA==
X-Google-Smtp-Source: AGHT+IEVT8XZOLPNW8H1+dOGPRIajTPHAVX0rTcONjVP42fC5LShWcQzE4x+dd0ssiVq8yTOlLUjDw==
X-Received: by 2002:a05:690e:14c8:b0:646:7c80:d20 with SMTP id 956f58d0204a3-6467c80115fmr16502273d50.75.1766963396213;
        Sun, 28 Dec 2025 15:09:56 -0800 (PST)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a94072bsm14052184d50.23.2025.12.28.15.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 15:09:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Code review?
Date: Sun, 28 Dec 2025 18:09:45 -0500
Message-Id: <B70285B3-5197-404C-AA4D-AA3E6FEEE321@gmail.com>
References: <20251228201613.83476-1-haraldnordgren@gmail.com>
Cc: gitster@pobox.com, chris.torek@gmail.com, git@vger.kernel.org,
 gitgitgadget@gmail.com, sandals@crustytoothpaste.net, ychin.macvim@gmail.com
In-Reply-To: <20251228201613.83476-1-haraldnordgren@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (21F90)


>=20
> Le 28 d=C3=A9c. 2025 =C3=A0 15:16, Harald Nordgren <haraldnordgren@gmail.c=
om> a =C3=A9crit :
>=20
> =EF=BB=BFHi!
>=20
> The config variable solves to problem of finding which =E2=80=9Dgoal branc=
h=E2=80=9D to compare to, which I otherwise find unsolvable. I took it from t=
he previous discussion that trying to extract the default branch from the re=
mote is not a good idea.
>=20
> Is the solution through using the remote/pushRemote?
>=20
> If that=E2=80=99s the solution they are set per branch (as I understand it=
), so each time checking out a new branch this =E2=80=9Dgoal branch=E2=80=9D=
 comparison would be lost and has to be configured again. That ruins the fea=
ture.
>=20
> Looking at the git repositories I have on my machine, none of them have pu=
shRemote set up. And the remote setting is pointing to my fork, never to ups=
tream, I think most people have it like that.
>=20
> I appreciate all the help so far! Happy new year!
>=20
>=20
> Harald
>=20

When I get to it, I intend to send a short email describing how I configure G=
it for triangular workflows.=20=
