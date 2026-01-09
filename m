Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789D500966
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975766; cv=none; b=QFuBjBlcB0PZXhCGuy5zM2uUE/A4S4gp3GZWPvLyI5I1sgQP/SCRJ+ujvaFvnGKJmIPR7jT0tCPn56D2TF2wmGi57iY5flbL9MobzU9szEPZ1+we+l1qOo1dgiZFvMNtaltKJtBxoLgfkhqIGGLHWNPI4bm+g+w1SJHLbrQbCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975766; c=relaxed/simple;
	bh=wrVbjpglEJSIjcNd9XqhEDFLQr9MyBwjp82BsKXQWfs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=OCEs42zOLWMzIYkbK1P5xB1V6INm8NFuH9QDyD2ESHyE3tuQz7fk+ZczOeL67tGzi4kXML3VP8FhyH4O6v16G7qdgHA5/7BF9SSVoU8W5SmeDOQNabkwcEh0MjP0REMK0fv0lJl6ONgmTNZ19MTzdWVYpToIkbgumLD2fLzS0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+M81uJm; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+M81uJm"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790884840baso48298647b3.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767975764; x=1768580564; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrVbjpglEJSIjcNd9XqhEDFLQr9MyBwjp82BsKXQWfs=;
        b=F+M81uJmgs4UwKmDTCkmjr/57/DWP+WLc5mB8V6X3F5z2tSL0IALqYZMwEnf30sr+F
         U4ZAPZ9zVEZCdVvgGvYNyniVK4XCutr+NfocyNzSw2h0TuYxr2wIHOjS0FneBCA/LlgE
         OcE3n7PgN3lsFNk9AzHSqJdmq/tfNGLmHGdwIg+0mJyr4IZhAncD2UAUTF7RqtzDs9r6
         /ZNfvsUwA5xcJOZo/dbaUo7s3OjvCekVfXEM/8uXx6Cqwi6zsyA08+P1VrUXkHOQgIV/
         l8Pdeqe1kJUvB6cEKoBOXKI4QtDaCOY3D6tskTlBHn6dDbryPCr0lLfsg/2CEwAC291L
         79+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975764; x=1768580564;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wrVbjpglEJSIjcNd9XqhEDFLQr9MyBwjp82BsKXQWfs=;
        b=UT8rKxgVKMV0k68QpZLCHtSFRp/h96C8vKa5LggpvXT54211UMie+4JMv10JIWtY56
         9FVi2PfKQUn2f26+1O82W90qbh7+IZMXx3QbNrybtb+9ilRiNLXsOG8F85hupZiDU6gT
         074zKAOITl5/pqy8rISBi1B0WTc2gWpygLsB5HgujeoaPcVAZXDUBx0OMsUQCvHwVNVD
         D/HHkWIKAIYeLUuO8xeSdFrYM5F+Ew1StubTGwlLjDiaMaRzjJ8CE7BfBhO78n6laiFG
         GEoHzRBue0CunTKzpPdiwq+SzVB351aP6C7ldvdS/c/tiZG3t/ENgr55c5/XPdT6ZNww
         hzXw==
X-Forwarded-Encrypted: i=1; AJvYcCXpf//DwHGOQ2eLIYeqVEHM1IKQr8N54R2f/BTPyUMdLVDHN78Ntq24pz+MmLjuTQDiAsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdLOwd9ybqV/pJWZDJxxP7rN0BiUHQ4rBmuzp92yMI+wHgvyi
	t8e0JgMStEhd3OOLO9qyRx0U9CYsVP6/R+F9myUALAVvviQSQrcK2xb8
X-Gm-Gg: AY/fxX6nfeZrkJn1dbDHGaXK8VJYePv9fg9CizrC1BClpmnsk17TebwjEmx1UReo36w
	pXQegYW8YlmppRMrlnLtoVi5hB9uku331X4ocHmga7CjPcypnncojiTlPgiZIdjORJmz6hRbOsR
	O81U5VO5l9+XKLygSX3DTWlqWOwyAQ9+HDtlRVo/n9VAC81zw3yLz7ygARZgvAyNuKCgrDK3Yj5
	5dktsfl+LaCMCVeCRqRqh+Ah9f6d1F82AFlUICb3Z2ut+f3OwpuyTuQBLnB8CYbmagTmCxELKkX
	3+bw5MvK2N+5oZ92iuPrLn8IcV4S/zXOu7UJ0aU+fMB5481xvFal6T8NiGxNuhQ+m/emHql3HMg
	3Hpx39rmGjUuVGESm9LG4vjhmSkI0fBBQHs666uHqjEEnOgiRdy75RM97OaUELW2mzglsomqUeN
	XYvZjBPOg+VCNLT5buqenJa1coxjtDm0RlevgpvnE5KnU1QHQG/lJCQxsU4+yj8dIw0L9m0PXBR
	yFtOnCqGPreMRD0hpRt6huMZyOp
X-Google-Smtp-Source: AGHT+IEi1FE6XE7YuHLtbV1nLPgH2AJYqxH+FXJdJfyOFpnptmodsUiIYwGujY5HJ57syoE5Vjhf2w==
X-Received: by 2002:a05:690e:1514:b0:645:61fc:43c2 with SMTP id 956f58d0204a3-64716b39c1bmr7879257d50.8.1767975763769;
        Fri, 09 Jan 2026 08:22:43 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:b1a4:3976:e3a8:a9de])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b2573sm4653020d50.21.2026.01.09.08.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 08:22:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Fri, 9 Jan 2026 11:22:33 -0500
Message-Id: <848006C9-FD1B-4E73-935F-D4A338AF2EC9@gmail.com>
References: <20260109160037.2067-1-haraldnordgren@gmail.com>
Cc: phillip.wood123@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 phillip.wood@dunelm.org.uk
In-Reply-To: <20260109160037.2067-1-haraldnordgren@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 9 janv. 2026 =C3=A0 11:07, Harald Nordgren <haraldnordgren@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>> Using an enum for a set of flags is a bit confusing.
>=20
> The point of the flag and the bitmasking is to selectively turn off the pu=
sh
> and pull advice advice from the relevant branch when the push branch
> comparison is active.
>=20
> In an earlier implementation the advice logic was moved to the caller
> instead 'format_branch_comparison', but it's more faithful to the original=

> to have the advice logic inside 'format_branch_comparison'. Maybe I
> misunderstood your comments around this?
>=20
> Would happily take a suggestion on a nicer way to handle it.

I think other uses in Git declare a bunch of integer constants for the bitfi=
elds, not an enum. Why? Because or-ing flags together creates a value not in=
 the enum=E2=80=A6

>> Here we set an enum to a value that is not a member of the enum.
>=20
> I use bitmasking to enable both modes by default. But see my comments abov=
e
> maybe there is a nicer way to handle all of this.

=E2=80=A6which explains this comment.

IOW: set of flags makes sense, but there=E2=80=99s a more usual way to set t=
hat up?=
