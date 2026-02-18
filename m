Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAFE2FD1B1
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433398; cv=none; b=bYl3q3UYYPmcxy5xVEsHZvxBEtmInsBsMBbKrEvV9o5S11z/i1xh7HIp3lI166I8Ih7RixRugxC3Naen3Kg61hM6zav8O29U+iDuF/M8zWQ2ToH2wq0gUXGUouxKUZ/gvXoDwYU0PmMbuHeqzU22EPfeIEHwIHBf2217xcHKgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433398; c=relaxed/simple;
	bh=FuVzWllg8gZ/iQTL9zgtZxzCYNwU7inKwBu0DY5nLyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAgo0XJeDZ3LrlA7tIV6H9qiSZJtqZbjqD0Y1Os9o6LxR3J9NWpdm8CCLXvf/sLNmZeUQkXhDj1IO76hv6IMNKqY3DIlwBZxdhYZsvcTjJEpjjS60NYNiAxukWe9eyC0TY2Q6TH50pC0iCNt32G8Ul76PyWI+yMrGW67xErfa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Slw+8Zvi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slw+8Zvi"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8249fc726e9so3024495b3a.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 08:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771433397; x=1772038197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atC1ZllKaS3MjszAyYCQw0ARRS6r2NPup7bu1T5xgbY=;
        b=Slw+8Zvit4gjZsqOkjwwNgzr+niJrcKudSEViRr2tNIcwBvjMW0JzMrCAknr18EE0w
         1PPt15aYNPMgpCcxU13o90w4pIkScOI/5wqNeZFaEJCsFlL7GEHbg+RALxbYh4mrQs3/
         GbBCW6h8HNIkGl4AYX2SlvEFtI+3macZ/KiGSAFtRDT4kGa7tG0u1Ixqj3MLKa8JjCmw
         O79Ab4uU86AfIo5naNz/jagX6fzbVhOsRwsLrQutvWli0aUuktu2gxDlpXTInKiPf78W
         yLq2ydoBqiNTjRuNrxS5yLnfQIh/AoQ/hVVX6KiO7nonWXO9wh1Lc6QHXYFjgN8FZdjG
         ya5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771433397; x=1772038197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=atC1ZllKaS3MjszAyYCQw0ARRS6r2NPup7bu1T5xgbY=;
        b=SK4yyEGw+l4K7moirmidSErOLSox5fckKi4dAq586qwRc8w7wmnHU1aXunH94/io81
         BTvqjBpELn+ZmT5Ata6/NuvJgeihveA6fDZ5tmzZaZxygWqlg9NE0uTDUFJQTUskEzuU
         K4W6L2xxPdCXQZS27HWwn0p6HzvO2zomGOu6nR8Uux7bl4wwi9aXAoV0aSX0xgfc6RHO
         DhHwzUn7eCFA57KI7UOMAU46dMa4iQQkeMo5UmwXNj2XVjzBDjZzML6bsAHcYmQLN7qe
         ZneJDBeC9IrhlAKAO0mQoEmZ6tBo3P7jubBNN9jw0cE0u9e9WZGocHZznTo4pg7fNlnw
         b9zw==
X-Gm-Message-State: AOJu0Yx/HasME22AE3H0o988vZ92B2TPeJIaGZ1dcY00fr4CnAOUBEb5
	inb3hVzLU2bKgnoDKHiBkWO1LpGs0jN/Yhfu6caDToKQzIcIB8STBfppL0Pykg==
X-Gm-Gg: AZuq6aLLzgV+8fkTChW/J30VMpkH70avG4OCYylQJhoH8LRx5u89F3rorjhzXCVthfA
	l8iR0zsv1alK8RFFo/1086tKPAb4Xc2sAqLofC+ZzeQ9fC/eIcXpL8tVpny9WnT5eOmz2DO27/A
	ZR3CGtn3er10CeECJvs6X3Q6d6gotukEz0ZdMtg3y/HVyedZPmyaBocjRCEs8Fr5y7TPt0IRUES
	tv/OfVdx2Mti2fu1HCpt7XKCTxL5TaYnrUZrpFoXnuZ0Wz97lHMJOfQgzmmeCFW/7LdyeEkB3wM
	7UF+25TkJUSG26tkuc4aCUxbHuiEFOtzIiVoKiCjS1eWfnWKC7IQAoTDbXMJiKrNYr+n1BMGcO2
	Kg/22IxenduOrYTM5e37fx6HHSYgugRHWGi4mh/dC54T5uMjbfAurJLDM/goinf7fgySxuBLc1L
	tOnoPMyDblCCsrIPgTiIE/JFtAA3Jk/TEyTvs5qKwwcfozL7AP3ndf/KngEWqcoiCy9O0K
X-Received: by 2002:a05:6a00:248c:b0:824:3670:66b1 with SMTP id d2e1a72fcca58-824d952ab85mr10320621b3a.28.1771433396733;
        Wed, 18 Feb 2026 08:49:56 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:181:cb2d:52e8:2ca0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2afeesm19726242b3a.2.2026.02.18.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:49:56 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH v4 0/3] wt-status: reduce reliance on global state
Date: Wed, 18 Feb 2026 22:18:14 +0530
Message-ID: <20260218164930.47613-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <df357921-dd2c-4bc8-aaaf-1ea5259b22b1@gmail.com>
References: <df357921-dd2c-4bc8-aaaf-1ea5259b22b1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> On 17/02/2026 17:29, Shreyansh Paliwal wrote:
> > In wt-status.c code still relies on some global variables, including
> > the_repository and the_hash_algo, even in cases where a repository
> > instance is already available via struct wt_status or struct repository.
> >
> > In patch 1/3, update function parameters and callers to pass struct
> > repository where no local repository access was available.
>
> This breaks the build when running "make DEVELOPER=1"
>
> wt-status.c: In function ‘count_stash_entries’:
> wt-status.c:1011:51: error: unused parameter ‘r’ [-Werror=unused-parameter]
>   1011 | static int count_stash_entries(struct repository *r)
>        |                                ~~~~~~~~~~~~~~~~~~~^
> wt-status.c: In function ‘read_line_from_git_path’:
> wt-status.c:1314:57: error: unused parameter ‘r’ [-Werror=unused-parameter]
>   1314 | static char *read_line_from_git_path(struct repository *r,
> const char *filename)
>        |                                      ~~~~~~~~~~~~~~~~~~~^
> wt-status.c: In function ‘abbrev_oid_in_line’:
> wt-status.c:1377:51: error: unused parameter ‘r’ [-Werror=unused-parameter]
>   1377 | static void abbrev_oid_in_line(struct repository *r, struct
> strbuf *line)
>        |                                ~~~~~~~~~~~~~~~~~~~^
>
> It would be better to use the new argument to replace "the_repository"
> in this patch. There aren't that many so the patch is still a manageable
> size.

Thanks for catching that. I ran the build and test suite after all the commits
at once so it got overlooked.

> > In patch 2/3, replace direct uses of the_repository with repository
> > instances already available in local structs.
> >
> > In patch 3/3, replace remaining uses of the global the_hash_algo with the
> > hash algorithm stored in the respective repository instance.
>
> These both look good, though I think the commit message for the second
> patch could be reflowed to give a more consistent line length.

I will send a revised version. Thanks.

Best,
Shreyansh
