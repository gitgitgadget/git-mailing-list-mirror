Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3389313E3F
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001219; cv=none; b=DZcRehLk7SKryQf/21yrTBG73JgEOozAAOEWCFkzWYaw8gLgZqLRtwp4MRbuFAc6wTr89BBg2ubm3UfWFz5Pg4xBg6QjKgh1lTELzEpghGrgkRIq/HWnUAMJTLkBqMXQJaB5KVjtNLmDjsUPPz+UnEAtnXasRnMn78fmDPECCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001219; c=relaxed/simple;
	bh=Qgfcjkv9C1FtKYw4Sgo8LmU5+COpaGmpNKJdjKZuDYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ54if5mTAibTjREz1xxVEcR/a6tr1s2dtuRt8MSUI41kKALPQtx4dFx5waPpwrVkECWz8U1sw9yLbHuenjinAIzsCghoRX1dYpIbVuY3f79XJaFFFcqm/wreuadrNqDvZe5CQaDRay0EAzlq8ZbRUHmJOwM4Ec6zxO/KR9YO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/x6weIt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/x6weIt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2981f9ce15cso54036485ad.1
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764001217; x=1764606017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IqT/H8mQ4jdJDCWDjA2dCENUwvbu8edbQfds/NP0mU=;
        b=U/x6weItM3GnWsDu6TSXSATGEVln8VdXQK6v8EAUnI003UDaTQl2WIqjJ3F48yqexh
         PJ1c/RswEJhbTvVbbUUrUjI+ntaNfGC3r38lN92IUZ+okTCvXFHzkG7oxfs1v7PyjLvJ
         ocEcImJdOsBqSav0GDy4hAAE2QY9TWZ8AIbY+B1AUTJ7hYmjoo4S5x9vRZnvz0pg++bR
         W2J7FHFPXyDQYu2TVbUhJDXp5gGZuIsPkC7bgBIxDfJqpGuLnze74tCytvqWeZi+liTH
         kdHj08En1DrI7ePeP69Ab3us/fX1pZuXzhPEy543HpLlP2RahjFhSSH8miouzgolX60E
         BpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001217; x=1764606017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/IqT/H8mQ4jdJDCWDjA2dCENUwvbu8edbQfds/NP0mU=;
        b=wriKmaqwjKmRZJpgRe8MhzwSwP+7yKob7fmISYSnDQTRrJoNf4+E8UZo7NYAGFhv+S
         Xr22zLu3RTmS5FEfWsoGwo2PAlGyJAg2GTwucQQB+x1kY+P63U+dXpj8a/fblnpXy/7r
         ZLuWTKtpHKT+cxaOQSYl4IbnNDSbymYDOrqCO8zIJ6RNhNtyNo8HaKwh7pS+pB9uMRr1
         hOuMZRtweG8O+eLd524swxlynbEQG+mEnIqJMyEFjTglyNsOj1Q3hfoYyqX31yMADjHA
         +CEq+cGadGaUTkSPZiBbVphygaWl1UGUxEzYmE9ZD1i2wEp9FgZl2HQ4Xq4qJKjLONmF
         NmWg==
X-Gm-Message-State: AOJu0YxLeviBdZNAslIPBcctLFQRbml2u10wjojP4aydCR/gfhi6A7rw
	le8Q5SCIGMIBzFy1iojAmW8raovqSJPBZabT7K9EzqKYJ4CKI6loGxf2AsfiiB0Hy8OMtHiyJHi
	TKNBlaqziWsCQVE7LNGyI5DBLvhZcvaI=
X-Gm-Gg: ASbGncvXwdYs5mrxaAPxSbr6Wr/Az6YRiZCNAtuj9HZc//I3MWGlt68akT6KSbv2EZP
	doAELobRAZMiBkqBA1K8HjsNF+sDqL6d2002nFyazFHSnh/WWRteJAjd99EIqZe/OxFmSrvfccu
	uHx5n25wAS7NgJmV29lH1Q3rcnE3o71GmoHc+UoA78ghuRwrkYffMBzdbYI9ELU8GmYoyxBM4aH
	o/EosJbW6+S/D76+larLepplFmUI1MRjMiW8MuvKF8JsBkX3RHAE1jeVg7BHgHEchjLZgfE28L5
	lBDdtmE=
X-Google-Smtp-Source: AGHT+IHdCfURBeSo+SPE/yRVOB16yCiKvR/IdCkimd2DHdxt4Yc6lgIFoHOFaK99+8M2STNEhD9y3KSu7dk53H2WtCg=
X-Received: by 2002:a17:90b:35cc:b0:33b:cfac:d5c6 with SMTP id
 98e67ed59e1d1-34733f487f1mr11026225a91.29.1764001216651; Mon, 24 Nov 2025
 08:20:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
In-Reply-To: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 24 Nov 2025 11:20:05 -0500
X-Gm-Features: AWmQ_bkGuGhIs_km_QxnkP4_Ge--JjpK-Wz3Hm5euKx6pNuxLsAPxvcTUjm97Is
Message-ID: <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
To: Ran Ari-Gur <ran.arigur+git@samsara.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	"raa.lkml@gmail.com" <raa.lkml@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 12:23=E2=80=AFAM Ran Ari-Gur <ran.arigur+git@samsar=
a.com> wrote:
>
> Hi,
>
> There's a small regression in Git v2.52.0; it used to be that a command o=
f the
> form
>
>     git clone '-c KEY=3DVALUE' ...
>
> or
>
>     git clone '--config=3D KEY=3DVALUE' ...
>
> would trim whitespace around KEY, making the command equivalent to this:
>
>     git clone --config=3DKEY=3DVALUE ...
>
> The relevant code was here:
> https://github.com/git/git/blob/v2.51.2/config.c#L649
>
> That functionality was removed in this refactoring commit:
> https://github.com/git/git/commit/dcecac2580ef871186fdc4e9efc87815a4ce4c6=
6
>
> As a result, a command like the above will now fail, with an error such a=
s this:
>
>     error: invalid key:  advice.detachedHead=3Dfalse
>     fatal: unable to write parameters to config file
>
> because config keys are not allowed to contain whitespace.
>
> I believe this change was unintentional; it was not mentioned in the comm=
it
> message or the release notes.
>
> This probably isn't a common case, and the project where I ran into this =
issue
> has already fixed it on their end (they now pass -c and KEY=3DVALUE as se=
parate
> arguments); but since Git aims to ensure backward-compatibility where pos=
sible,
> I figured I should report it.
>
> Thanks in advance!
> -Ran

Thanks! As far as backward compatibility, I think this behavior has
been around since 2010's 8b1fa77867 (Allow passing of configuration
parameters in the command line, 2010-03-26) which morphed via
572e4f6a0c (Use strbufs instead of open-coded string manipulation,
2010-03-26) into the strbuf_trim(pair[0]) that you pointed to as
disappearing.

Interestingly, I note that we dropped the trim around pair[1] in
06eb708f33 (config: always parse GIT_CONFIG_PARAMETERS during
git_config, 2011-05-24), but I don't see that discussed in the commit
message either. I tried a handful of mailing list searches around
20110524224955.GC24527@sigill.intra.peff.net, but didn't find any
relevant discussion (though my lore-search skills are mediocre).

Anyway, authors of these now-15-year-old patchess CC'd =F0=9F=98=85


--=20
D. Ben Knoble
