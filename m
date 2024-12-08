Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6B54279
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690403; cv=none; b=ft8A7Fz2fkSb1ObTFYZvRX5Ia2b9SFylUC5yvUkqYx7H2r+HUaLnxBxv8hzAEoL8jKBgEwbPVMA5w9jTD0gMCrwO+FZtekqpoG+fpdmtcxp6474odHnBxekxPBBIehmngv6glbHK6jIbl0G8/s13vpYMHLQo4UxBd7KEfjron4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690403; c=relaxed/simple;
	bh=j9V65HZjucg5nQXUQB66I0PXgsDzSHmsG+vL5ZKDczg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=XqhXMm7lRUxMTZIy8iDga/QbeW1gEau1ZouogJuT7PMtLGnBhFOxjGb4weYnexLrY8NGUCWj3tgsmsL9/lzXabUqE7FFcb3gug/3wBlg4OpxV3423Gju/6OWgvHlB4ko3U5CsGDONcfUUkN9PnaI0whH4Lr6p9ok6zlJOqPqLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGBT0sJO; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGBT0sJO"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8e7df7199so23627496d6.1
        for <git@vger.kernel.org>; Sun, 08 Dec 2024 12:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690400; x=1734295200; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p5rI0f0Lvn5+i/bX1QrJPqW7FGzzVfazZJNDiHsmw6w=;
        b=YGBT0sJOjJg7D0rcKbTCvc4N8Xwb3Capni8ZSjqQGSRNjLUWrN1ptxkPhx1WSEQ29h
         mV2Ao3t10K7kAA1f0u1ZW1pPYTggG+OgjpvKCacRsaTvgQH1wwgTcZ5TXpZSqu2Ln7dO
         fbBrdnCaRuaKs53KBR+MgxrEf7brl3J8bEL6h/6SOfSPUyc9lsXofSXZDNQf5WFPhYh5
         b8UCdCWk2R/FJgksKGv7+bqICElCFF4G0kYelbqcrwGi2IhRWdxhrYKL2SOv1FrQz4Ia
         iOBaYVvibm+gZIJtaeyCQW9c3zemLXOmicrPUNDxbF55RaRJ9cMe5FlsqhAVo9ej1HDa
         yqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690400; x=1734295200;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5rI0f0Lvn5+i/bX1QrJPqW7FGzzVfazZJNDiHsmw6w=;
        b=o79NuNfSCHP6lf1iayXsWeeO+FqrcdGY1LGoLBiDCVsLo8uLwfcgSQTSWV3z+kv3bC
         Sx2rKFl+J06woSMzln1PijlbeKfWQtzADJnjPNJ6bQekjSCCvuJdM8IhNvgjYzmLFuLW
         xIStRLdWaCr0INwyCV9nCmH9YjgrB6IdTmy1FX2MVK3+moFRzU8VgC+R12MzSoszpN1P
         0YpH/GFE5eAE5A7aDsFCNGdvqUvqmAZjxQ/Oqs64X+TCUxS4DCmCYOEDQfdz9Ak88Mb+
         m2FN/RphO+aPYv4JSl/4pY6cZ04fYYHUD6xpbe/KzjhP7lYaQNBSV18y7tjSwo99s4C3
         /hTQ==
X-Gm-Message-State: AOJu0YzyCMy5OfcUL/4aVsG1xe90QgiMTnYAjSlRvkEeYVupM7JvnIUm
	JRapVyfYufUWd1b49rY6+iZRLCjWXfv4fe25FEtBcHPXKZ0r6FEiNrzO7g==
X-Gm-Gg: ASbGncuzxx95ElbFfLDeRbGhQgNImfo/Xn3v4HdkWS5qLzLFysE+COqjV+kO/cwfg9R
	EzGQRf4JuUHisHsnzDdJODuygmTXA0h9X1lZ6E/vaYIC0jMiuRFQxJEdwt5MzDtIu0GFZUUZBWN
	752Nfy6wvfq5a0Wi43JfRyGJkQlUC+OLRvxDBCHQUge5vrteXTM8cHdKfRcjcDlY/YLXjccSrn6
	K0L1sgGUZKWtcEL9OrSwHIS+Bz/rhawErv97LGo66qNgpTYx+qGe8ghXvDPFahe3tKHpZ7zFXUr
	Ls0Tudsw4+S1zH4r7125dNPe+VI4QWdANbs=
X-Google-Smtp-Source: AGHT+IG72gcRP8P5gisj8mYbEc8itG9CvlAOmQwgUl1a/HV8WX4al9iFj9CctFNUjhkh5FqpFnTsZA==
X-Received: by 2002:a05:6214:c68:b0:6d8:9cbf:d191 with SMTP id 6a1803df08f44-6d8e7118dffmr187905216d6.12.1733690400332;
        Sun, 08 Dec 2024 12:40:00 -0800 (PST)
Received: from guest40.skill.lafayette.edu (guest40.skill.lafayette.edu. [139.147.200.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dabfec80sm41579336d6.98.2024.12.08.12.39.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:39:59 -0800 (PST)
Message-ID: <1ee9f3ef2bffd148b6225138135462d2d4a5928d.camel@gmail.com>
Subject: BUG: git verify-pack --stat-only is nonfunctional as documented
From: calumlikesapplepie@gmail.com
To: git@vger.kernel.org
Date: Sun, 08 Dec 2024 15:39:58 -0500
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello maintainers,

There are two problems with `git verify-pack --stat-only`.  The first
one I noticed is that it does not work as specified when the --verbose
option is passed.  The second, and more serious, is that it simply
doesn't work in general; `verify-pack` runs at the same speed
regardlesds of if `--stat-only` is specified.

The manpage of `git verify-pack` specifies that when both the=C2=A0
`--verbose` and `--stat-only` options are passed, that the command
outputs both a complete list of objects and a histogram.

> -s, --stat-only
>       Do not verify the pack contents; only show the histogram=C2=A0
> 	of=C2=A0delta chain length. With --verbose, the list of objects
>	is also shown.

However, running `git verify-pack -sv` only outputs the histogram.
Examining the source code reveals that this is the expected behavior in
all cases; if --stat-only is specified, --verbose is ignored.

> static int verify_one_pack(... ) { ...
> 	strvec_push(argv, "index-pack");
>
> 	if (stat_only)
> 		strvec_push(argv, "--verify-stat-only");
> 	else if (verbose)
> 		strvec_push(argv, "--verify-stat");
> 	else
> 		strvec_push(argv, "--verify");

While trying to determine how to patch this function and `index-pack.c`
to support the manpage specified behavior, I realized that I couldn't
even locate where --verify-stat-only prevented the hashing of the full
pack file; the `stat_only` variable only serves to prevent printing of
individual object information.  Timing data confirms that `--stat-only`
does not prevent verifying the packfiles; the following test case shows
either command taking about a second to run on my machine.

> dd if=3D/dev/urandom of=3Dtest123.rand count=3D10 bs=3D10M
> git init; git add .; git commit -am "test"
> git gc
> time git verify-pack .git/objects/pack/PACKFILE.idx
> time git verify-pack --stat-only .git/objects/pack/PACKFILE.idx

Both issues were likley added when `verify-pack` was refactored to call
`index-pack`.  It may be simpler to edit the manpage to reflect the
current behavior, rather than conduct the needed refactoring of `index-
pack`.  A patch that does this is incoming..

Thank you,
Calum McConnell

P.S. Sorry if this message seemed rude or too short, it's the second
time I've written it, since Evolution decided to discard my message
text.
