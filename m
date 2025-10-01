Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E41D799D
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320999; cv=none; b=K0oRdditammqB7UX1I3o7Zi9IIgJqkaZ541DFcrGHFzmWyYUdRkKqKL6ECGINOMZfbb34LuAsYbXLe3XfgCwMOo5JJpYEMuaIPINUDtU6JnzIiCC+U8t7b0D3QKIg1z8Owo/MAjU+xqFFFBXskjIk1ejdnzUMTL7O3OlHJZkhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320999; c=relaxed/simple;
	bh=P/mnfZaZfCRuOdDFkkw6Lijo/6/NZki0gvsT/lwzPcc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=VNB/svYmbK3ztl4aSKlZxyDepbOKOwpj3uuHWw2/s57jbLUKczeabgq76OT1gFgh4H5FSmQguCgX2antZhn4ngIRKKG6XJCUbqOWS7q7mKSTCne250fceNTpjhYt0ua6VZa3clTnkWNa9cCnThRz3SueaboG6eY2IYn+Kc7WJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iw4e1RtL; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw4e1RtL"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d605c6501so73141017b3.3
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759320997; x=1759925797; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/mnfZaZfCRuOdDFkkw6Lijo/6/NZki0gvsT/lwzPcc=;
        b=iw4e1RtLNidnVVgE7YJcoeyv1pck23t40MbfUBM7jYrcptsahijCeuRITekoxwP52k
         276g8ocFZjNMNBd0HOcpC9bpNbI7tRSnIDEYD6igbH8HcSFCHv4NOgJtzHhOIUU+MOKL
         yNetqepHkNY5rJQnaJ6FY17+lvga7td7N0K4FwwGsqbwIL1w01EI01y1Pokdxy4OQcUq
         0Jz+VsLiwF6lFBJRpwthSxWXd9TQU8hXTK78/yu67SJdjQU0CY7N2b+zPa8HzhJCizpd
         n/KD+Z7z6SUqL+dwteI2vgtG/xsphzLN1mr5kmXngzGTPWxAgAlHkcwAxQVv4dk4O/Ii
         TV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320997; x=1759925797;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/mnfZaZfCRuOdDFkkw6Lijo/6/NZki0gvsT/lwzPcc=;
        b=vMfb2H1aT1bBFJoXVLSlRyQRR9QLk2RMvAYhAg+rwkAWxUa/La0gxbCNfYoK/dnQ7Q
         OdU9t+yFnOBQnHiUvpIoeWeEWX1wSPSurivgUWd0YHsiEr/OdzeMeJYHseCjZ6QDnkdp
         SuhZ2ZXCBXFVoWASUz/Z3Cwp8vTAExMDgD179FCny1uOrCyzbEKtNhfyXwQ8kGRMN7rJ
         zMK7BEsmZYaoLziHJznd4WqfkT7+44Rq9IJteaIOsA2BbhQ7Xew/7tWSGt4uOz3zt7U8
         +bhMIQQq/5QWaOLchbGINBI7fCOvWfdoen5CnvvqowQgeftdLTU5YoeoqJym5lAMIYQI
         pqmA==
X-Forwarded-Encrypted: i=1; AJvYcCWhEyGrd0cL7LRyPxY4VnHeu8a/MI6wVOrDmAbJBKlNIWDJeGRuyyP6gS9T7qfjopnlJW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4UB236J40djxUGVsd/D7NBNFiBpZvcSHsQ13pN6elxbasNwL
	t3FAqR58lc/Cpmd4s4wBYW6SDoCglGC7QNTqaIdvks2Zp6iYwUA4PN/E
X-Gm-Gg: ASbGncuP8lIkKkBMWO1iDjOy+0UfBnbI3A5lK/XZd8OAGM+Mw9dHLsDIEwtbOXyTq2J
	cS35f0yO+WheyL/MC9mVWp79SYdZirJEUQIXkY8OxyTZNyqNjb2jhTOnt8/N0MSVRQrbcfDexHY
	LctKd7ZCR39ZMmT6vUm5kqCGMVV5151w0Hv2bUTmpXsbLp0yfD1a+KimYoWTDE0WZsQEv+PVLlZ
	IZtV5V6fABLaDDJh7NjwyIoPxoANEK3gYxEkeUiGCKmiwulKeRSyb5Vr481CSXWpWli96rKdHKS
	R2iR+RNexfmluf6QIpvvNbY6Xvo3B7s8/g40S5YLhHFS1hPl1zZu5fJwIuTyzGF1xyw8yIjXots
	OPlcioiNw53Fv0Fy24yogRyF5rtQntT/JfYEYHG9NG3AZeHwGXfYXKsHnecVsOnNU63r1a6stpE
	s=
X-Google-Smtp-Source: AGHT+IHfL0c/bs6FQN6kpvfqAOU0FCi24SeIU+arFvJotlSMB/74TnKRLqyc+wINDYYj6aM2uhgmDQ==
X-Received: by 2002:a05:690c:c93:b0:731:1bc7:7836 with SMTP id 00721157ae682-77f6f2e607emr49303037b3.41.1759320997044;
        Wed, 01 Oct 2025 05:16:37 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:8587:3407:bc03:d307])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7704ec2104fsm35065267b3.32.2025.10.01.05.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 05:16:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: What is the reason behind not hiding git worktrees from git?
Date: Wed, 1 Oct 2025 08:16:25 -0400
Message-Id: <E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
Cc: Jason Cho <jason11choca@proton.me>, Junio C Hamano <gitster@pobox.com>,
 "Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
In-Reply-To: <aNuy1aab954D3rJ1@kitsune.suse.cz>
To: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailer: iPhone Mail (21F90)


> Le 30 sept. 2025 =C3=A0 06:41, Michal Such=C3=A1nek <msuchanek@suse.de> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Sat, Sep 27, 2025 at 09:08:44PM +0000, Jason Cho wrote:
>>> It does not not show its own .git directory as untracked files
>>>=20
>>> That can be seen as inconsistent.
>>=20
>> Well, I see your point. Since the .git directory is from a git repo, the d=
irectory is ignored by git. Therefore, you want git to also ignore other ite=
ms derived from the repo, including work trees.
>>=20
>> However, this is a minor improvement and I suspect your proposed feature m=
ay have an unknown impact.
>=20
> The impact is that the list of worktrees would have to be read to get
> status. As status is not particularly cheap operation in any case I
> would expect the problem to be minor.

I believe status information is used for the shell prompt info, so performan=
ce hits there have a cost.=
