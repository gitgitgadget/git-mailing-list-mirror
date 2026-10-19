Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2AC4F68BA
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419720; cv=none; b=uP/2am7S0cDAQOW6r7CGmBoBAW3clJmOVeKzLE8kh1ICM76Qb8I3uhCr1g23XrChcd5VHD405UA3ID83uW9FqkNzMD9CyBuM2hxB7edmwjK2b0hZPJTYjqPB0x9T455hxHT/lYSJeq/HXoy6rbRiq9w/GxLaefzTEAzYwGplVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419720; c=relaxed/simple;
	bh=zVs/piYhzekSNKPszVfDULn9OhQ5ea6cFOzk8kP6p60=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dbbTFMDOuiFnceeP/eZ58rGCUIIY+i9jZbmbnBjzXHHtobOoTviGrjuxZlo/19RhhYxZYusXcvMj+vRnSp0bK9IqYXBvUOuSRvvtkkcTXuIAMfnGpdR8iKlVC/lBdi71bP9JffxXKqE71GhjZecEdjwMp0TBS5Cp/fYosVaca0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWwh9Wl6; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWwh9Wl6"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ab43af5e97so21248487b3.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792419718; x=1793024518; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7iVT86a9JmLPljJE6O8wsTa6BIqvf23rF+bc0qwFN3U=;
        b=AWwh9Wl6BBlHqz5lSWcUF86zfKhfTvHi8qCoc5vkONvSNyq2gL16LHqYT93aisCqbM
         kmKSLTOw9EF8vKHADKu/NNJo4QEK8xJU4EVdqbXWLxK5JsNq4d0GAz0v6uSgt8+aMy9/
         p1PIk6VuBuH6Q3/ophTevhCDEp3FXHxiZ3pSghLs4nQmKcLRbyl78Tjmah/BvNQzCeVf
         lLyF06J4bCroz48Uaa1mLWKIK36zTezl4RfXjhn8yv2SxA32xhcVrWThmxVgowsNqvB+
         CzU02x9vLBoPaP9DiGa2XJJ/meJFc1LWGe26CheY8PpXxkdhHo3S+0Qo7LI3mogzecwy
         6tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419718; x=1793024518;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iVT86a9JmLPljJE6O8wsTa6BIqvf23rF+bc0qwFN3U=;
        b=R14j/Ba20pywRPh64eyhVqTwzUM/wt8NwiECnoX7O6H18kYxCbQ/hwwnNCDi6bT+81
         XfLW31w9b7rZwg2nZB2hymQ0cdpcJVm+nRzJZjzu1tIBex03/ap1wcAitUwC5bXExpZV
         kx5RfPMv+Ulri9SuSmESQUriFIFREPudX/7tDqCqgEJOVvQstaZHilk09u/VsrTqJj3S
         C6AYzxxuYcdul9exEJlIb+SRgGJY50gZQjVaSVAuYBLBRDLNnAVWnrevweBjQRE9ak8n
         SpXu/BMR/uxnW8cET7SRdx9jdhQ8WeaYUX2mqCGqlgZF+Ix5HNuxEc0NRVnzB6RrhND+
         lTwQ==
X-Gm-Message-State: AFq9FYIyLNDW48qdXzO8NmNrQUYjFkT02/7/vRpEQu/OWy7gw6TF3Z02
	QcU1zx2yq4K2aaLRib/w1WdXfy4vhyhX5Pa7iScCnL1JHfj8RnQFRJ/lOJfQPw==
X-Gm-Gg: AYBFou3DFhclFVDTNIYli8Bk87gU47tw6qYpHkBPf96iTPwwIdobxtNZZugzD7YHCTN
	XmIiXXU437paFK478ESp5F4EgnuKfXzBnU8a8+lCQSVChAyUYF/EhFFGW9OiYWBK1InNOFu5XgY
	C+3F58dAfyztPpX3RkAAcl3ukmCcFXfxUmavRqRBI4jEwAREWjVNz56JTq1TKszpwGroBSk6CgB
	1/Fqq0FZ92wXv9EjU7T7C2PtD2+Qi6HM7+Qz8BWIGJJmosjNGLwQzVZbrAHDe/hwJKv1bezDX5Y
	4hezXsWwrIHrFdjLZVz7yJdmh6emMsNHCEkwKfDXShi3miMikSTQobbO/e+Of6r64OoDf1qHj4E
	eiER0tf2RP5FDitpyQKdX2QiLTnHE/3NpwJOUDJy91IypfzXTitRio21G4Os/XlXNo2pnEPZSmS
	HkdN17gj8Jj9JV6U0mEQBMBgQtepGXWCrXqMXJYTXVLRZqnmWwbA8G9WsGktc2cK+oeZbOsGoaD
	i3x/oxv7tVGJTu9Fo2CWcMtOxsbNuBIXtK7/NLz9pJRt6ar6hlqxXEy5+lhs3YKBwtkzU/+cbWP
	xe2oIr3u1lyBpjDUawJZwG0y5Rt1xbfboPrsX6Aep5yIuy2MJkjwK92e2g==
X-Received: by 2002:a05:690c:6d84:b0:8b0:a30a:7f31 with SMTP id 00721157ae682-8b0f21842b3mr24254377b3.29.1792419718285;
        Mon, 19 Oct 2026 07:21:58 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1909:b48c:a809:b114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b7d9ec4sm1047627b3.10.2026.10.19.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:21:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [Git Enhancement Proposal] Clarify the Role of 'origin' in 'git remote add' Help
Date: Mon, 19 Oct 2026 10:21:44 -0400
Message-Id: <7C0EC565-CC0D-4CA0-8073-3C3885D86A74@gmail.com>
References: <CAGnq-NQcWHWdDsipyYa5-dvKME71z6e+REratMQf=jUuPxw5uQ@mail.gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <CAGnq-NQcWHWdDsipyYa5-dvKME71z6e+REratMQf=jUuPxw5uQ@mail.gmail.com>
To: ceo <xiote78indo@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 17 oct. 2026 =C3=A0 22:42, ceo <xiote78indo@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFHello Git developers,
>=20
> I would like to suggest a small improvement to the help message for
> the git remote add command.
>=20
> Current Behavior
>=20
> When running "git remote add --help" in my environment, the following
> usage information is displayed:
>=20
>    usage: git remote add [<options>] <name> <url>
>=20
> However, this brief help message does not explain the meaning of
> <name> or the significance of "origin".

Short help is typically terse and focuses on a simple reminder of usage.=20

> Reason for the Suggestion
>=20
> Git uses "origin" as the default remote name when running git clone.
> However, git remote add requires users to explicitly specify a remote
> name.
>=20
> This distinction may confuse new Git users, who might not understand
> whether "origin" is a Git-defined default, a required name, or simply
> a user-defined name.
>=20
> Proposed Improvement
>=20
> I suggest adding a brief explanation to the help message for git
> remote add, such as:
>=20
>    <name>  Name assigned to the remote repository.
>            "origin" is the default name used by git clone,
>            but any valid name can be specified.
>=20
> This clarification would help users understand the meaning of "origin"
> and the purpose of the <name> argument without changing the command's
> existing behavior.

This kind of thing could be expanded on in the manual for git-remote(1).=
