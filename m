Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1E26F28D
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646639; cv=none; b=u7m054Ez3v7a8ZzXQc8QQt3NYmGb2qWQo+rWINMN9JhyQPDMJIdSpT9Z1UDh6MC90zIKQP9y4wpZgHFZn9Gv5bH18kDdRRE8b33ZkHnbPxzgMn+eFY0Tdm80ZZzn/UUKmUfp7A610+CVo9dw4kgbTKpRF59CLgm3mfQYUAUiTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646639; c=relaxed/simple;
	bh=fb+8+y4CFKQkSo3mFi9t+Zs2SCn3hptbL52YG78W+ac=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Ur1MipvrHoPt71P4DDIitPWbbRpy83fedn2ykj3t5iilTySQnEWr9wvDc/HeAVHsTE6JZ0kL9bmJpgqpnfrCYJr7Dq+dAOqzPmMIaBNE3z1AsGim84AtlchlVIvCmhpZF5hUY9FzOEZJ9pmZaUkZUsHQtaXgxLCYdMHVtT4Cm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRTeuoL5; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRTeuoL5"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-74ea5d32022so20116497b3.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758646636; x=1759251436; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKKkoBF8cCI94rPCrieUM9HY16G55LNticWejcaovOc=;
        b=KRTeuoL5I9ycTHQmTguGcLpwddieqjo51MLGJnEE6ANjRSA8jX9G+lsijnm411hwQP
         InUsDoqRZggDHcYrpzBW27y+QZ0XmGzvQJeo6zydfVdvLN3vso51V7ZhMfCTyWwla4xp
         gFd2gAhWchZU362pbiJBQMRNv9O/4G65GFLvwlbGuxMpS3ajx4HK4+vVYEjnXxQdb5Ta
         HpgABD0dpK/ZOkHa/n0rjGNlLaKf91xagjx20LWnU76mJ9NnJqLC/wSB02+xj/3+inlK
         XZNgMs8pFi8fttUS+H1kRq+4ufQ8KIVPbp3Z0hPpDl5ClBge3JOtiXUV9Vyp0a2ekNf1
         cwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758646636; x=1759251436;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKKkoBF8cCI94rPCrieUM9HY16G55LNticWejcaovOc=;
        b=kK/ATi/xSfy0H2hlJZhACSryYfpLS0/uFaPSSUO190FSeLXrJKePv0OYmalPEg/l3L
         DXU7mtd+CJmaCbdgc0W0KeLdHtbUaK9nZbkNsi6f7l3zNbqGcRrXkDHM6urdChdwulrw
         pxCbIxV5aFYw2RsOVF/kfPYJbylXQkx64DU4cFO9pxxVPDqGkYc7fhh0z/DU9ZeyRmxf
         buAKGsb2YuTf2hJwma61xtFkFBH1owbaxRa6LXs2mlJcIP7oROLh4zVGIuSsdXQzW/gW
         WIaSUkl+sMQCUdqHfJb2dLG+JFXzQsLzNzFltvCPC5eCPVKwZ9ZtDZWkIoMzTDf6HDF5
         5OYQ==
X-Gm-Message-State: AOJu0YxiUl6sVmdb9fqTcQIO9Vp6JYYVKkN4h+/AMgBWPSGdl8FbMPtp
	erRWd96OlD84EBQsUSVnkloroN6mjDN/jgMGeKiw6b2wgRkIWSqe7H13N4GayA==
X-Gm-Gg: ASbGncspaQRq1qpN6AWI25i+w8JITwT4VUjdPHuwFX/ofbFx+r3IRE3xC5MRkSpeiTN
	rQhEmVm2AHWuKwBJSijog/eO9VtAfBTmsd6bVp/ry+8snZ5HuXBh8m7igUVZlW92d441mMvUqAa
	Qxw+1F9W9G889JopgItoC0/BBbZfOw9fgmyn8VJi10o7P7kU+bnw7Q9nAthLl5Sz0CFlU2OhHrZ
	SOJ5yIYMTs0ErDEK+IqwhQTVvcbzLonD5id89wbfXOvOf3WCi0AjYJ91z6E2jRWzRKouVQHuSYl
	/IQlf2QWsRCl4IM2vSLjaZYw6Kr5NIu/5dwa4/aA1Ho/zbKAN9D+8ZEq/h3fpFaAq78QwkcMQN1
	IJw/5KDfZZosO4lXnaZl6paTx7yzsP69CFLqEUGRjf4Ca3DXhq2g3f99US0wRiw==
X-Google-Smtp-Source: AGHT+IGICIqOqII6OMoJVxkreDp8DGylCdYTd6bAVAu0ttKVoyMfxvoB7Fvzk3dg2czINxCN6gV9iA==
X-Received: by 2002:a05:690c:e06:b0:726:76f0:4b89 with SMTP id 00721157ae682-75897c6e144mr26801947b3.22.1758646635957;
        Tue, 23 Sep 2025 09:57:15 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3535:152d:7414:b233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397171df9asm42362687b3.31.2025.09.23.09.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:57:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
Date: Tue, 23 Sep 2025 12:57:04 -0400
Message-Id: <ABB734D1-EAB4-429C-9A36-C00E114E4207@gmail.com>
References: <20250923104533.21165-1-meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
In-Reply-To: <20250923104533.21165-1-meetsoni3017@gmail.com>
To: Meet Soni <meetsoni3017@gmail.com>
X-Mailer: iPhone Mail (21F90)

With apologies if I cover well-trodden ground, as I haven=E2=80=99t been clo=
sely following this effort.

> Le 23 sept. 2025 =C3=A0 06:47, Meet Soni <meetsoni3017@gmail.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFWhile `git-rev-parse(1)` and `git-show-ref(1)` can be used to rea=
d
> reference values, they have drawbacks for scripting and discoverability.
> `rev-parse` performs DWIM expansion which is unpredictable for scripts,

[snip]

> To address this, introduce a new plumbing command, `git refs get <ref>`.
> This new command provides three key advantages:
>=20
>  - It requires an exact refname and does not perform expansion, making
>    it safer and more predictable for scripting.

What are the disadvantages of rev-parse=E2=80=99s DWIMmery in scripts? I wou=
ld think it makes handling user input easier (e.g., my custom script can tak=
e a local branch name without writing =C2=AB refs/heads/ =C2=BB on the comma=
nd-line). OTOH, a script that wants to precisely identify a ref can do so al=
ready, no?

Since rev-parse presumably won=E2=80=99t go away, it might be ok to have 2 w=
ays of parsing (one with magic and one without), but that might be back to t=
he same boat of not having a unified interface =F0=9F=98=85

Perhaps later we can add a =C2=AB --dwim =C2=BB flag for looser parsing, giv=
ing scripteds flexibility but strictness by default?=
