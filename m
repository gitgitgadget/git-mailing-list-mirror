Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E845C709
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706979; cv=none; b=p7bltilZKNVe8AT5jpSoygCUpcWsrLczl19eThSG9WKfyQCREwzx3+ajEvnbEBASzGZgsqqMNvNh+VIrB+WkpWxrYKyk7fel41yA0azzuaer48jkB9RQ/RI7paTovxFh3wzO1Q6NBfdxCWTKJadZKdwu5BIa/XvvXh/fFD95dSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706979; c=relaxed/simple;
	bh=b59cE/tvc9VDQ9GpHlebL6e/hVyKd4VX7P2JiYKww4A=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GNGWW5FldKjG5W3IgsrZqbM2ZyYlRYEzyyOiZKFyb/I8F6OeSGgFOImowNUqHR4SHefOcbS0nSIF0onis+mtAkvRy9MlrUs743Qj+ZGamm6uxjJeH/9draz3H58AmqOSGGBTKkfs+jiOqBK+P3VU2bJxxPJ7rNbR/MVXvAAgG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGXVv5Lk; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGXVv5Lk"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836eac5682bso13164327b3.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 04:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786706974; x=1787311774; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b59cE/tvc9VDQ9GpHlebL6e/hVyKd4VX7P2JiYKww4A=;
        b=LGXVv5Lk4ViSZwnUPHuLqIZmFdNRcRdql6G29rSKf8wvNOkseiQYlZYf/mrs18Q2ve
         ac2j0opHO0qh+thR291DwL1VMf+UehPZXstGIKCetqtveEQg6CqdP6/ZPzE+My0WCc0M
         tXbO/Bfr8geG7+IzPHTR/CEmVE3EWyy8GOR/hMONmFlq2H2EfSFWKhcUWITazYOw6RBt
         9BJJcZ5SDX/NDIvRNBrNDGPyW77O1rM4P6nqTflruiV5K8jUt/17xn6wt58qmW8212w/
         5gBLA/ZgIiJ96dYV5bjQajDhhD9Jt9O5MhT2Yti+QH06MiJEENhHX5HJeRIph5LCh00c
         7IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786706974; x=1787311774;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b59cE/tvc9VDQ9GpHlebL6e/hVyKd4VX7P2JiYKww4A=;
        b=aOvTFtqmG9YxXoOjqIv5uvzPqeFvn1d1277m0538OgStCYoubQFIcd2ZhhTtaXRrDe
         d5tS6gDBb6z3GSx+TlIvINBEvj+9Sw4PFhJVUy0vjGZjM7xL/mdwj53MrXxahz5MwGTI
         ts46KV0FSlWSQ3WO0C6Re7jVN4SpWY5CaCLYp9Jegvd6JRUoMWiNy1A+c60QTjde6rAi
         rYnVdy13QMpNMJvQqmskatorSp82IjGmtpyPk+oButBidTDVmqg55Y8Md4McvQF2TyPD
         WsrUD4zz5PmCD3/k51tMOuw3DX9NFMoM1ybHOmioDsGV7nwkyp2B/JHR0quFGRPCK5T0
         DTkw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+7Dl7/vVwZ2ummrnvU56UgX2BqJdOc0qmWGAqdLAUcylwI6jOcEzvmfmnYmZc9x570gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbl/W1unDHWxdfxQcgLfWmM1dWgm0W5HiWvU2xNbyWanOdtcmx
	GfP1H5zrJxGtO9WZerx5sF8k75gOP/9uRuj7WYjG4A3nOjgrLpZhadI/
X-Gm-Gg: AR+sD11ck0rnH0zPwpAu6YGQKG5f7pXyqEkaekDs4E7P3bqGAwph+7PvGLN+KpBca27
	0ABJvlNJ0O4iP2N8r5GaDgpSGOicJNeMF1KAqoi7P07q4u0N6Y75pFlzBvksxUv0o50egBdkMGk
	YQRU8vKZtV0MyxW9978VuWEkrYKOMuAslk+agb2pp2WDLsQ7SGUjKL4i5H38ZuJYjI8gPFzHs6T
	HH684jnciEyCOdMziLk5o9IGAl1DQrSO0qiIv2vhjZX5Vz0ZNPO95DeFqk41MT/WKh/O35Fra3g
	nW2CGC2QYxAaV0MF7lMVZB+R49bO6WwyuVkX3j4teiv3ihpq/wUgC+E+YGowtnswG0UQJIb1g7q
	GppqNK2aht7noVFOXhcD9xw0pOQP07NS/drdf7Ij6Jb047NqgR2K/M+ZOSbbdEJJkVz0ddezLFb
	YxNTI4VZoe3wS2N7lHjA4hEiGKYfi1Cu5oMiZrPY88Sit0TGooAguqQLGa+5oBmUT4YGmHPS3rg
	okJkET4z8fhq3E+a61UoeNeiwPXJu5znpWteWu3M7pBd8jIUw8M+gQg5v8ExHrX7jeju1muOfZj
	uxhP8XUNYuh3v4v0l/qVgWe+eIgb73byYhPWcw==
X-Received: by 2002:a05:690c:c6cf:b0:82d:8dc0:9cf with SMTP id 00721157ae682-834880a9cccmr48312077b3.13.1786706973906;
        Fri, 14 Aug 2026 04:29:33 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:7539:648:8ee9:1ad2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c1777930sm11850867b3.31.2026.08.14.04.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:29:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Fri, 14 Aug 2026 07:29:22 -0400
Message-Id: <6767F13B-622A-4988-AE61-373C25599F45@gmail.com>
References: <an720tZnot07HYiK@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Yuchen Tian <cat@malon.dev>, Todd Zullinger <tmz@pobox.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
In-Reply-To: <an720tZnot07HYiK@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 14 ao=C3=BBt 2026 =C3=A0 07:07, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Thu, Aug 13, 2026 at 05:40:31PM -0400, D. Ben Knoble wrote:
>>=20
>>=20
>> Ok, CI run: https://github.com/benknoble/git/actions/runs/31701945211.
>> This demonstrates that nothing our test suite does across the many CI
>> configurations ends up where with a non-the_repository-repository
>> (ahem).
>>=20
>> I have been working on control-flow analysis by hand in my Git time
>> this week. It's of the form "Z calls Y calls X =E2=80=A6" until we can se=
e
>> what the repository that's (eventually) fed to repo_config_values()
>> here in is_racy_stat() is. My notes are one node per line, which
>> indentation showing callee relationships. Some lines are pointers to
>> other nodes to avoid duplicating work.
>>=20
>> With that in mind, filtering out the pointer nodes, I've analyzed 214
>> nodes in the graph. If I'm lucky, I'm approaching the halfway mark,
>> but I somewhat doubt it.
>>=20
>> But since CI shows things work=E2=80=A6 I'd rather not continue the analy=
sis
>> if we're satisfied for now. (Esp. since that will give me more Git
>> time back for reviewing ;) It being outside-of-work time, I only have
>> so much of it.)
>>=20
>> A few other related things:
>> - Some of the edges of the graph appear to be public libgit.a
>> interfaces. That means we can't guarantee that only the_repository is
>> used.
>> - On a related note, I don't know how large the current "must only use
>> the_repository" (e.g., via repo_config_values()) surface area is right
>> now. Based on the partial analysis I mentioned above, this feels like
>> it's introducing (or at least contributing to) a rather large surface
>> area. So, this change might make it more critical to resolve the
>> limitation mentioned in the other thread. OTOH, I don't think this
>> change is likely to represent the only pervasive the_repository-only
>> limitation, and I'm afraid it will never land if it must be
>> the_repository clean (unless repo_settings is the_repository clean and
>> we decide that's an acceptable place for this member).
>>=20
>> So, idk. If we're happy with the CI run + use of repo_config_values()
>> overall, I can send a v2 shortly (in next 24h), I think.
>>=20
>> Thoughts? Strong opinions?
>=20
> No strong opinions from my side, other than that we should stop
> converting everything to `repo_config_values()` until we have a plan for
> how to make it work with repositories other than `the_repository`.
>=20
> I don't feel like holding this series in hostage though, so if your
> analysis and the test suite both say that this is probably fine then we
> may want to pursue it. Or we just use a global variable for it for the
> time being and then wait until the `repo_config_values()` dust has
> settled.
>=20
> Patrick

Makes sense. I should have also mentioned that, of the nodes I=E2=80=99ve an=
alyzed so far, they all terminate in a path that uses the_repository (some i=
ntermediate nodes are also exposed, though, as written previously).=
