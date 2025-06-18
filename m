Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CC14A82
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228752; cv=none; b=ibE/DckvgVaQsR1+O/9zJuEQ6K9uZ8C6rjB3z4QQu1bWq9Rks3AUPAquwhxp5WQ6aIMHFe9aYN7B83cpBnQ7qYsdDKnYAbMzsQxXi30LgSkLa513LTv4cDVofWdQlR8ZW8IY2bAQjHZOzy7DSxpoQSpYNHqqNwzvyGyG/KixC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228752; c=relaxed/simple;
	bh=WYfEm35ZXiQLzjMpltHEVC5OeuW6MCK6ZhJkWlDGWic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MYuGV+w31dvsA1n9ZtN8JgJI8gbLD4Yra8ujm7eDX82mhTS16luyYc0fZxcBRNjbM7IOy+xC8neKcoR1AFCGxD4cmF+5uMvobv9XeDQkmOnfkHtZOQMa7cbWL0WnlASD9qT8UL3UyCyZKllRC6EeGyQKzptrRLtqa2lt5OvJRlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maM/hKp4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maM/hKp4"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso319751b3a.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 23:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750228750; x=1750833550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JDzuUXvRg8ta2yH7OXAG7KQZXdRXiYxit2zk82YLSk=;
        b=maM/hKp4I3YPeJvDqNzc1xvlH1XjXwotYfBfHpbxQP7lo1jaGwHetGQeLVCa9sCYN9
         /RM/PQgsolnPhuVLEWH0g1jKg6htx2daH3DCzfZX4AmbG8kbBXCBBShR+qjYKqfZaJ/A
         PPJsAUijyTaMdMTN/vnVrmityg2YAC6Or/B+QKtEFpeHB23ubjs9UT6STCSWN/4fmWt6
         1PYqLbSmhCuo8vO52BvNNgmY3AkkcV+k2WygfJBAFot6RqHQMYXe43mtzd6abNdb60tV
         wftkk3V/zA7+lA7Lils0Sqx+bTgR3FJx1VyB9y3BmDzv4ylQQJGsEwHBdWA2pEXkpHYg
         S6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750228750; x=1750833550;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2JDzuUXvRg8ta2yH7OXAG7KQZXdRXiYxit2zk82YLSk=;
        b=GxSsNVAFeM0v30a+5NhuTJot/5a5FIavEol+5fCtta4xnOhWnCTJ4iMNz0LOEsasJw
         e3xe2Jpz9h9DP6clyN5U0Dez6ngNnnpx5IpMcMDP4Yo7a0AAP18990IZmZFCwBOjUN4Y
         nQ3T2xvyXpxwWFRJ8UElRvR2As/YAwChgNIjH4jwypXN6mFbMXdaCmxYClkKnb9F20xB
         7SxeUtkb0m+nezYb0vAyIDcR6MT3aLLfe73SXgMOyFZMoxszjpHp+L0NnkCl0n31uxEe
         P9g0zLK5mP7jMWIGTCyt5Ud07jW/veSURV8ixvt9zc8QqQKx5GoUBs+PfBbiFuDYOXA1
         VW+g==
X-Gm-Message-State: AOJu0YzjvNc6D7RCmBZa6BnD9+CWiSrldsWXY54Dn1Db0NbzarnKUXph
	HbTMaeiDyROUxP0gHqRHRqXrC/qSOiFa6KIHt0IDMKsMRXGis86V1N2U
X-Gm-Gg: ASbGncu9BvyRks9hy8KNZ+PfwQtjDRU+f4/aJJ/CWuy3urYgbTI82kRJJUPXqO8Rfq2
	kDuBv6h/7pSOL7xMoHv3ZUq0gAzRG57kC6mNBxU8Rvuj/8SG1YisbQ5tl3AcZapjktBpZdjoGbN
	ymOQRrfu+j5SBr4wEs+aNF3sFeNcOELQv9+8pwccPPxW2N+LuT3bd+1lGJCS6OpSY44CmTirgMW
	Eujnwi55zhgZKCEEZmIIizADzSmnWmerrCg/GAjjNN/Lt8YUgW5g/mlKFVqsocpAGuKSwK9wUS3
	rp3u3e7+ep1ap5RLowEwQkW/O/u5rlMB/vUfS/oYa2tFZXkDc1PIsmVOxPyBECoMUvCoLqjYAnf
	nBnM6Mx4oKsLqbdM9oBaHQWOgSYuo4ps=
X-Google-Smtp-Source: AGHT+IEDa+DsYFi4SCHl3zcGa28RxaEKdcfdMXAB/e+03UlDY/x6+K3pIfJi4KB153zdSZeViHtIug==
X-Received: by 2002:a05:6a20:e687:b0:21d:98c:12c9 with SMTP id adf61e73a8af0-220037f1376mr2099649637.21.1750228749842;
        Tue, 17 Jun 2025 23:39:09 -0700 (PDT)
Received: from fedora (static-23-234-82-101.cust.tzulo.com. [23.234.82.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900062dasm10532190b3a.66.2025.06.17.23.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 23:39:09 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] portability: allow building in systems without d_type
In-Reply-To: <20250618062331.78059-1-carenas@gmail.com>
References: <20250618062331.78059-1-carenas@gmail.com>
Date: Tue, 17 Jun 2025 23:39:08 -0700
Message-ID: <87zfe5h7ub.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> Since 09fb155f11 (diff --no-index: support limiting by pathspec,
> 2025-05-21) will fail to build in platforms that don't have a
> d_type member on their struct dirent (ex: AIX, NonStop).
>
> Use the DTYPE() macro instead of a nake reference to d_type.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  diff-no-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 4aeeb98cfa..7c95222ba6 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -46,7 +46,7 @@ static int read_directory_contents(const char *path, st=
ruct string_list *list,
>=20=20
>  			if (!match_leading_pathspec(NULL, pathspec,
>  						    match.buf, match.len,
> -						    0, NULL, e->d_type =3D=3D DT_DIR ? 1 : 0))
> +						    0, NULL, DTYPE(e) =3D=3D DT_DIR ? 1 : 0))
>  				continue;
>  		}

I confirm that before this patch the build will fail with the following
on AIX 7.3:

        CC diff-no-index.o
    diff-no-index.c: In function 'read_directory_contents':
    diff-no-index.c:49:21: error: 'struct dirent' has no member named 'd_ty=
pe'
       49 |           0, NULL, e->d_type =3D=3D DT_DIR ? 1 : 0))
          |                     ^~
    gmake: *** [Makefile:2821: diff-no-index.o] Error 1

This patch fixes it. Thanks.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Collin
