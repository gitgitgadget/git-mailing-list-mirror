Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC098158535
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274166; cv=none; b=VBO0B77fjExP1EdFYzWqRuojJJGdR5q0Okw1FtTevPvf0ci/DJuhKikZ6qHMF8JqcoV3+NeYgjefraBkug3w9B0fOOP/G5uib3ZLIUDQWzt7jdivrjOj1DdY7t0EelwWcjRI6BpP/z9InZePFi2XqEz/6OMuModHJWT6M6w7L88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274166; c=relaxed/simple;
	bh=b30wMKXPRB4yUscTDVszs6ftaMCgsoy41S9A2lNdtSA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=kSx0+LoFC/0rVcns4UQsOkbOK+lXaNE8Hc1O5jKcjY2NBcsHxI5yFEXPWFUjxhBNrglh1BdSpu5sygbhXDm687boH6uByEU0/oEH1f+77+QKcUcrTjazZK522Ca5Dmm0dgEQp0RQhVsBGjx+3PU1SKP/MVDvETJyFhpxu4Z1Hm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4Xn1t0g; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4Xn1t0g"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e98b7071cc9so3256716276.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274163; x=1757878963; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58Df8/B1EfzSVj1iY9+TiRYS81sDD8zrD3+JXVtq+4c=;
        b=f4Xn1t0gLeoJp0AcegEQQlPZiED/6MZ8d/muX1Sa/e6VgiShYZPGstx6LeWDTEbBdD
         g6M2H46k32JNeK3xsmFRTSyj6Q3TRm0H7gBU5PXu/yrhehFij+LcRHvI9lBQTW2sMxXf
         QcVuZbaomPZOR2H4oV3LhJ/9xK6EmQemfDI+AuLCJWNzpxHshzXzhCLQMP7UXwtqpvpB
         57ZgTm/OycqV5vCxDnYurcW/dW1gqNcysbtJrSWq6vxSZL0s0q691ejrJFdK4kiD+8YP
         MYQeFKUXM/JTWfVu3MDok5t5gHrOr1jU+YNOmvI8pyCOil6VK2B0zjuM6+joahfGfrJq
         WXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274163; x=1757878963;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58Df8/B1EfzSVj1iY9+TiRYS81sDD8zrD3+JXVtq+4c=;
        b=sWgljGOSgjEZg9uJ2o202eq8sPxr5dA1aWci0Psqz72VIm/Uo30FG7zjVKE0gjoKA6
         DBXTE2trEkfMErzCjfnD5ono3WsALDhffJ4jFpCaciO8pJeveUn8eznLhKYI+Yd1vXqy
         wS+/p7+Eqhum1rFyKtNL3Z5gUnL00nzF513ErCdzgm56vYhX/+ziDbn8ISAXbI36SYET
         vOMzA+tHrWTl/OSxG9QVFKO6cTL5nM7Kxz9c5Fkbdlz4vurgdIwZ4FtGY6IiUwhKCze1
         uYbe+5uJPw9q3YVnqk9KMoUudoTjgGLm+lCkQ1Hh6DIyRIXdsiAAuq0ZkR2ZlrxE7s0n
         loOA==
X-Gm-Message-State: AOJu0YxbeZE0E1znLJnB+2sbvQPV35K2YTv7JIaz4S5LlPIm9qP/pYtU
	CR/dV8ht4tVPumGSsn/YswkkqXcda3dUTeZCIF0X5hhTZJiyG90TirMwWc++WQ==
X-Gm-Gg: ASbGnctT4OB230zFpzZ6EjynSltj251Abcc78/0MuAtnQJUpKSq6HSPfYaOFtCYyuZw
	uVKTXlXHOqhk2hZHr4GnsVMeTqYqzf0zcU0e4zFs8nddcfVSQeL7U1iGfnUspfIdU0wE38bRodi
	QpgoP90uxBslcLRliVQsOgK90RStHSKXrl+y3ugj3by9C24cmsJzpsf4LrLb8OhSkehwfmgYs1y
	Nl1N+aSoqA0eA+KwAq9dBF6OcKZyeBSl5vOQx7xrQNSCN1x4Tz9hWbqczJjKlQAfs6p/iI9GEi1
	WL3As87SLi7eWM4bZwqS6IJFqS/pbv8vOzubdNQbWYJ9ru2mVt6zX7oiYyHqMXMYbKcObML+227
	4jptsmyIrRL16uazYHiEhNjZkI9/9AOe8qhnNula0aZ+ipk7W0zrOffs91wOHofXUt14X2OX3
X-Google-Smtp-Source: AGHT+IGtInHaqMZ9zcJTccFyXR0Jpg9ROosFqd1HH/fTKXE5KK0+QSubGXDbf71Na9yJiPsb2O40Ig==
X-Received: by 2002:a05:690e:258a:b0:615:14:8320 with SMTP id 956f58d0204a3-61500148498mr1203397d50.34.1757274163210;
        Sun, 07 Sep 2025 12:42:43 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:656a:2d24:478f:190b])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9d056d8ee6sm3634115276.27.2025.09.07.12.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 12:42:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Doing blobless clone by default; switching between blobless, treeless and full clones by a command
Date: Sun, 7 Sep 2025 15:42:32 -0400
Message-Id: <297E6C80-C998-4D6A-B06D-7B2D1B229269@gmail.com>
References: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
Cc: git <git@vger.kernel.org>
In-Reply-To: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
X-Mailer: iPhone Mail (21F90)


> Le 4 sept. 2025 =C3=A0 05:37, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=
=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 <dilyan.palauzov@aegee.org> a =C3=A9crit :=

>=20
> =EF=BB=BFHello,
>=20
> Rationale:
>=20
> The reason people execute  git clone  is hardly to issue immediately after=
wards  git log  or  git annotate.

Maybe for you, and maybe in many contexts, but I also frequently clone thing=
s to run various history spelunking searches on them.=20

>  The reason for git clone is to (try changing something and then) build th=
e software. (Provided that git manages source code.)  Doing by default a red=
uced data download with  git clone  will sped up the initialization, it will=
 save bytes in transit and reduce server load.  In fact I think that by defa=
ult (without extra configuration)  git clone  should do a reduced download (=
blobless) and
> git should download the other things, when asked to do so. =20

Absolutely not (in my opinion, :p). Not having the entire repository availab=
le except when connected to a network defeats the tremendous advantage of di=
stributed version control. Namely, privileged forks are given status by soci=
al agreement, not technical requirement. I want the whole repository availab=
le independently.=20

> This default download preference should be ideally managed by an option in=
 global gitconfig .  When looking at https://git-scm.com/docs/git-config for=
 =E2=80=9Cfilter=E2=80=9D I do not recognize anything relevant.

This seems more moderated and achievable. If you would prefer to clone less b=
y default (I would not), go for it. I mostly don=E2=80=99t work with repos w=
here this matters, though, or where git-maintenance doesn=E2=80=99t do most o=
f the job I need after a 1-time setup cost.

I do chastise folks for mis-managing large binary files in history that crea=
te large blobs and clone times, though :)=
