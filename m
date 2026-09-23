Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C803EFFA8
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184368; cv=pass; b=H1MWIIW2+qAWFbyUbAUuQ8sibRHzSmKL84hX2U8A4DbCSnvMTPFAV7YguTZCBo0EvsmRzFuLfsAZgRVy/MhjS3726pAR0ytwT3kmU/CqbmnpDhEVgWTMuWWNQKSmAGhXQxd+vEu8UwR3gx1g+gKrGOUPjbgmidsd+AaHEq4W12M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184368; c=relaxed/simple;
	bh=MTafOqbcEJ9N895Z1QPSZaEO0V5+DGWNtUm6ItHKneg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edtjMoBgSLzbX0d+iqOxufkfwFjPl47I5kaAPVn1Wucgogfhm6jN0fjmHuUHgwli4Uq1j3EwBHB/Qjb5uQ6nAeG1p5PIye561rQ4gCvM8z8zfcYaevaKmvbl8S1+uR6Nwbnqni9QvfFfVEAgIfJ0QbiyCrVxQJpxschy554hV/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYVYPvis; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYVYPvis"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-805c194bc92so1598201a34.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790184365; cv=none;
        d=google.com; s=arc-20260327;
        b=AAr0ADX78Gtglf6j5I6wnwng1751ZNc8PYYanOZZBWdPxFZDjbD51VJdalRjv+oTbr
         DJSf53GYyj9bEu+CO6kueD8VUmO9wLKLabIB0Q4zRLtZj/sPA9/GQcfjRaOG5CNrfpdb
         KMTJTK401a7Xw8Hy5q9DgCoVlwNJYvJD+AC0yZb3jEsvtwyumR6OcD0SFyrN0Qq6cMUc
         r9Qf+2GlrmRjjYvIiz7jiQaK2eFC2XOKxjAzNsLFovenKRf2/USak0RaS2oXkVyDxjng
         2Jdi1ecOBlv46IwWum+MocgnDu/6WcIjZaqlXmA6GQUd7T4gdyCGXCP39sRtIZ/M/L2G
         bdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6hNLAIk1NIxqvGdcex37x9s25L7USVuUTfZz0FDdREk=;
        fh=rfLjIwn2a57wX7vvUPf5sv7xoXYLkb1by0ZOpcDOxJM=;
        b=QypimajgSRkkwtNR+67Yed/zy/TUGUVv1Pl+p2JeCzWKiqNWgMAEcoFTPtkDFCChS2
         6r2LL8ZlyDX6JZMSrTEeEe2D85tPUbYDngvkNGs6OqDlJf9PwPtvSgsdE1VjE/w224uS
         kXLj1MTjluY6NC6Ep7h5tP33x9A2GYHrFrS9nKTxnqLOi15y7VZfUOWF1Ic/dueTMCr3
         st4ap5qxtCatWwIrcBpSaMs8T1xNSt2BJ6DrKiO/HCB2U6lFMRZ7pqSjqbbGFEZGwYM7
         LvqyW7otNf5nw5iZV7Y0Pc2ysY+JmoY4XB3XotH/8LBGwx0CJT35bbiOpbVHjcbETx41
         jjRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790184365; x=1790789165; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6hNLAIk1NIxqvGdcex37x9s25L7USVuUTfZz0FDdREk=;
        b=XYVYPvisGYr1XWRw7NjUdhPYNtz+L1weLQ2XJArGb1mA9pHU+AhTBkhgHWqUlNjbxb
         2lg9wGeu2cQpqNAT18W7C7eSZnmL6ez4W5ZmW94zQX4tFIN0bRW33HH8ckghDSNe0w6E
         GJFzBhWfW1aQ3Ssy+TqjiduBXyyv8T3r5M3vlA+o8Kwczro3UVcwnVfUZ0lobGEZKbHx
         ExvNefkSiKnOA0mWSbZbJfebzizm+RmwMahU1qyER6JlrNPhZlaMNcUBII/hsDJ4QGce
         ROUos6D7HnSTfSWQafocKJm1wCnaQqGOKHK3wSjtw8goQXZ55zXE9lwqLLo0X+igzSMZ
         PdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184365; x=1790789165;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6hNLAIk1NIxqvGdcex37x9s25L7USVuUTfZz0FDdREk=;
        b=ohPt+4u/jUvAN150gd+7WURWvROdp7VqNfbbWLQ+YIWRMiOkhk5jGwMXSwepA5dCO0
         h7ksPn/KHwpvHQp2l40h4RP0LDgweV9D5qtzPUzr0uCk0LH2zjVGKqB09BehuAfEAEva
         zDne6sFdlcMjrtbmYdPagtfRolKDeKN5yUYU0876uXGXRW/n8i804aHE0R0RCeqDn3tb
         sBJXrjH29B1dRNJxT+zcQaI/IFpAX9A3eKeehPc1LewM4ypjpxBIfLwNfGozu4CDq7aa
         P2FwGANuA71bWWlby9ZODWYuwr3BASSZqpR5pYUATB34Fs7hK3hbcibQ5+sfgK62tCsQ
         AfyQ==
X-Gm-Message-State: AFuF++mZWZQUXIUXKCoEr6ZNJCiTTp9AhcLVWOweb5busgTe46ZfpCUV
	sqQu3D4OIT/pDbvUZadZZE3kkWbR7MW/3vdhebdOPRUFZJbceEWCxrIsqYnzrq+8hXWzWb5TFet
	HKOHrANpZl9i712H/wnJI5DdCV1Nm5HYKS+hE19s=
X-Gm-Gg: AYBFou0EthcaOYwziJDsOzVvUftWTHCUFnX0IlUtdRwD4f9m2Yoa+n7eFF4hAJsFcQ+
	ICaTVUiOu5au7bzoe8xszPKJPCTCBLUoL9+3kUwHPvWYFgBRxoD3j5JKF9MRa8Fs7j17gRMujOu
	STFXYkUv9e8mYmq37TXYi0rYinrfaTKi0w+1F3THdcvCJvm48uzicWTdUmAfp0fCwyTw4+fPs9E
	5lvdxJBCBCYpcRp9Q2Xkb+I4YKPgP2rQTsxxE3DLprm1X4/XTjOp3+ImlMgJyjV+LEpRTQqJFHg
	4XPPgsObl7woPOBF4IcP1RwBVtQPObubnipQh+zxKNF9pzIjG4wzHkyoyo6FYN/Jne9Q7U9a+jo
	P5Sl4hAGPlNv6j49uZuEgZVcV8IifLlNFxb63S8MTfixwsAx5EViE0FNtAbHLWS2WpueDtFfKBR
	1YbUBDrmOa
X-Received: by 2002:a05:6820:200f:b0:6c9:80d8:a205 with SMTP id
 006d021491bc7-6d2d2622c4dmr2979910eaf.66.1790184365517; Wed, 23 Sep 2026
 10:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-5-jayatheerthkulkarni2005@gmail.com> <xmqqse3fbudk.fsf@gitster.g>
In-Reply-To: <xmqqse3fbudk.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 23 Sep 2026 22:55:54 +0530
X-Gm-Features: AclHuK8lWafCseDQXWPdtSRq6MuKCKzIkA6p9CT6MZGR8N7NURl3uZ0DtfM8vi0
Message-ID: <CA+rGoLchSyDz9fcBuaS=M9t1q_Xp3KPsX5m_qKEfAHonQD6uTQ@mail.gmail.com>
Subject: Re: [GSoC Patch v6 4/7] repo: add path.index with absolute and
 relative suffixes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > +     if (!index_file)
> > +             return error(_("unable to get index file"));
>
> This is a dead code, as repo_get_index_file() calls BUG("") when it
> finds that the repo instance is not ready to return this information.
>
> Hence I am debating myself if this is a better alternative:
>
>         const char *index_file = repo->index_file;
>
>         if (!index_file)
>                 return error(...);
>
> I dunno.
>

I think I am just gonna remove the if condition from
get_path_index_relative() and let repo_get_index_file handle the bug
instead of rewriting the logic.

> > +static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
> > +{
> > +     const char *index_file = repo_get_index_file(repo);
> > +
> > +     if (!index_file)
> > +             return error(_("unable to get index file"));
> > +
> > +     format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
> > +     return 0;
> > +}
>
> Ditto.

Same for this.
