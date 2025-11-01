Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A3B652
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762040761; cv=none; b=sKuQMA70lURfILZRJ53K0/C2TparrFKDvNjVoiOdbVpBNlYvihapMq84/w6OFlWYdMBJX5nLkPtaJk3i75yTm/NhIlAUkKUv/fo79o7fMYW3MQTs2sVT1vU6NJHgnmzA+GdgyrSaRSXWs9daEJcyEzR0lDCPWb33XoT7H4+snAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762040761; c=relaxed/simple;
	bh=UjlbybqvzKXvPnGDWrzvFtN7oNZZW7ZSmypbOAlPJBA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=OHpTkJniAbX/FI/MG4rFFkoWWZz/l3Uw7EPhiwn7Upx5JFgqxKud4Nka71DdjPCKFEM2KkIDlSwmNsM/9i0aQQ8pMz1FMM7UnJQACsrRHOb9H4ZbB7bd8TppcDJ+F6kVlJ6iDvzbXxdpok8gNjWpfqSYqXPiGNNDF5eGlObwXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA4x+AJK; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA4x+AJK"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63f7c7185c5so3544764d50.3
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 16:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762040759; x=1762645559; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjlbybqvzKXvPnGDWrzvFtN7oNZZW7ZSmypbOAlPJBA=;
        b=KA4x+AJKoJv6Y9/b/AvKaEIgLnp8rZrh1t0dFFatiWsOSCHI+ihrTOWsbH3bwNn/7h
         +q2zwOuR4qKP3AHsB6UkqcJoQvFN0NKGvn+VobbXwJysUBqBA1pz4ifTgs4VR03CtTUz
         Ti6DvJC10tWXgkQxbDfZ1z6PD/Qckn/2cqd2bdIVxzcZPeSzqxcyEbVjR4DB5qkpcjbe
         EaqKbCO8YebofBb+HSXEWsfuofzQWrEhzawdaCBdRgEWP/kDz/vIxl5LVkLa1MrlUfUm
         eFC969u3p9uLAtaMWZSlg4/5d73jVE8AKonPYF40QsXL9o8R6uPZekcPor8do/nDa55V
         VsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762040759; x=1762645559;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjlbybqvzKXvPnGDWrzvFtN7oNZZW7ZSmypbOAlPJBA=;
        b=fC4BQxZgAp07WH/sl3ya4zROIYN4q0CGLSEdFk5luExfJguudmXket91oDTrJHRfR+
         TO33AdbWFeKGki/x2KVsEuSoPQtv097EpxuLONXUAQleRvNGgD9EEl79tvXddzJBvUTE
         LpROLu/i1fCjj0M/oiDNesVM28UUfNPTdQ9QZV7yyflTm+aVz2NBanUio1sZc8Mql6Mj
         GHr9R8DR5O+pKPzaqswZ1sSG3R/kWg7+CceGRxABBefiODYi+lxIdxcnzMiHIucNyHOs
         LaQfUw59VSI579eId2xVbJAJjIW2fZ3IYu+hv2hKNT7uSMcoNNoJhHpAVH86v0D8kBXP
         GZ6w==
X-Gm-Message-State: AOJu0YxaZZ2HnBNtNj4enxKiwQSesnRDhRukFQ/qE33059NB2M0OEC+v
	I54YCdXKu28MOd48eEMBgcpTNc9ElkrBqJsMACyBYDQDKRDPOMiphwl4
X-Gm-Gg: ASbGncsTL4TRB8fRmFCYI6aq4W4xcHb5PjH2LTmwOoF9tH5OGztpXwSxVyGcd9Gy5Yr
	if78OL7abzk18U18/e9RtyeYKjbqa4EoJwDPN/alAJM9vjikrDYBjIb3rUX6qCFXplG09Plwgbi
	lxFU6pKE1sKH4+nfR7cg8xpoWF24dfmw35bFUEXePgiVboufp0sNXJp9taB1h7RNgiRPpC228lW
	8iE4FEFJuQGpX+UVRIUWioMREm98L8oLKK1RH/rA4zV4byeJda8L0u7L95Mvgr7uN2GLecOJA5m
	4n1En0dTV+Jovewgxufs3GlWLLOPQR2Vr8Pmf1QWH5yqyfCv1mK7OJtXDKK0MJVH8ApP9EbvoNs
	4mrDsMqmvqjLUteJC2worIrj4EL+am2PG9giSkdYdL3k/n3HOgri8+FuhsaPIxlmqiUYbhixkaf
	m5o9C5Ssyu2vy6H8aDXZkRbCy9lneQjbIGzfaXL6E=
X-Google-Smtp-Source: AGHT+IEuhb7re0RFjscxl7bENJUm6BLFGoiTsm/HktSaobNh8Hil0/lX+7+QH14rlxVkB7+C8O0WlQ==
X-Received: by 2002:a05:690e:1544:20b0:63f:2b69:9a30 with SMTP id 956f58d0204a3-63f9224ecc2mr5748364d50.14.1762040758671;
        Sat, 01 Nov 2025 16:45:58 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:f8cb:3c01:7e17:11e0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f9675b5adsm1673244d50.1.2025.11.01.16.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 16:45:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git remote rename command help
Date: Sat, 1 Nov 2025 19:45:46 -0400
Message-Id: <54E0F3F7-7CB6-4963-BA95-AA60E76BCF44@gmail.com>
References: <CAJ6i6FDqj0yCymuGd+f89XQvTLGRj3nVC-36Z4tbJfwNRKSt+w@mail.gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <CAJ6i6FDqj0yCymuGd+f89XQvTLGRj3nVC-36Z4tbJfwNRKSt+w@mail.gmail.com>
To: Michael Woodard <mwoodard@metropolis.io>
X-Mailer: iPhone Mail (21F90)


> Le 31 oct. 2025 =C3=A0 21:51, Michael Woodard <mwoodard@metropolis.io> a =C3=
=A9crit :
>=20
> =EF=BB=BFHello,
>=20
> I entered the command "git remote rename Old_Name New_Name" but it
> appears to only have affected the Local Repo I am working with. Other
> requests or connections to remote repo still see the Old_Name. What am
> I missing?
>=20
> Michael Woodard | SP+ | A Metropolis Company | Manager, IT Operations
>=20
> Mobile: 251.463.2791

What, precisely, do you mean by =E2=80=9Cother connections=E2=80=9D? A remot=
e name is a local-only concept (effectively a pointer to a resource locator a=
nd other metadata, like a fetch refspec). If you expected this to, say, chan=
ge the name of a repository on a server, that=E2=80=99s not really what this=
 command does.=20

PS I=E2=80=99m surprised to see a phone number :) I expect you are inundated=
 with spam messages (voice or text).=20=
