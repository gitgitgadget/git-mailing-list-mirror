Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39902207A2A
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218826; cv=none; b=Qtw17Y5p0GGXj54HyI8V9V16Yj9Anl+fQDqdUDCjkrOedd8klrYHGTV2Zytq1HD+VfTi1mz1ktVfVrpvjvPq8pA7HWYSdYLAHuMMSRlAGEelQEhu1VvG2HWp7u0svTDv+5qxpwFnHHj4D8a2eULbcgszjlgpAnCcZSgKFYLTEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218826; c=relaxed/simple;
	bh=+/aV8KghDrY4yoOeQVB61g8OCfzAIbUXWg7iY5Xa8z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeL5ij1LVEEN6NNEgfxmXZPs3TlVodcq3Klt2sDsqk2c2+PZKO/E8utFouf3S8pKyoj+QYZBHDW3RrUmLql8ttigTPIWxKvmIhFufH+Jkhhi+Z3DABibIoWOnI1uvDnbC6IsJH+lYjiAUnTqxu1STpJEYpVeVD9Y0heQcL990es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcrdz5b4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcrdz5b4"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54963160818so93968e87.2
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 15:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741218823; x=1741823623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/aV8KghDrY4yoOeQVB61g8OCfzAIbUXWg7iY5Xa8z4=;
        b=Lcrdz5b42qMPcKZNaN+xswDhmILvTrNmcfYNB3u4r8AoA+y/ZYWy3o54ApJoTvhniB
         XeH1iHbP4SriQGLJd0Ds1GGs/rEXRexYsPuZUV/rhKiZVQbwQay9r2Igs9/QA4ctes6b
         Q0/UCPL5Rn83jHq1deX8jJdzhF3lOE0neVFnHGFwpyTdsP/HC3WY15ZDzjlEhHEBwqFC
         yQLdUcFUGArufaO0dcdEkI7RJr6JU4tUTQFr3B2HD+gNozE/pV/eSl4vo4rS8UKUzrkv
         yWhtR3WHHayDfznirsfDQcerIeXGkXka/gS0yQCapIcCWDoFf5T9mSgze6i7NONuXIaa
         fK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741218823; x=1741823623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/aV8KghDrY4yoOeQVB61g8OCfzAIbUXWg7iY5Xa8z4=;
        b=nMgprP/yvxiYXfl8kmzsXwqhSKKYwiWXs3LSDy67rLaW9v9eP+W26QFjUfCsUY5321
         SfwImyrRxZjZKlWnlsZBTp6iCbWxl7gshLpCdWSfQHUg0EMSLUmjQNZXpeHxtlHWSKhi
         n8S9lWerQpc2TuH0qxmy4TMzwl8dC9bPQJQGzmlCI2ollGiCXfZP7L1dnLkSwucT+9Qy
         ZpG8jGtRZGEYqc1UkXvgowEi/htexjLYo9xvxRaHpq3QUG60UVzpCG5BGgWvwcn0RiBw
         3JCPULuyAJ5mTky0Ki6/NTIBYCoghban/MlC4J9Jc1zEDquIlRX7C7MOLlofYmzDINjZ
         ckeg==
X-Forwarded-Encrypted: i=1; AJvYcCWMasiitPuvVH07VcD/wH0HSCQjk/yrSB3ZAftYaTdozmcq2rEGL52y9JJOvuJiJQDcir4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsld09lQWygsEWd3NVHgXRS7Ud149Nyufy5bZPrEAVt5FKQbwR
	RoUDRJAJi//bOOop0E0nzfMN+Sk/y9myH8RwniU7507T9x1rH37yXHzSxTBi2fc/cTwwAvjvRrj
	APTdocWJpjdH6hLVDR6yMohJVlvs=
X-Gm-Gg: ASbGnct41GnlG+PT2Y1F4eM4TEK8z15zca5G/+55YRtTnZQOnz25Ofbk6WafVKiJhdf
	ySSi5EyKrI0FOwf2vFGHj/gizbIfb61LygziMEF0YAucs25hoWjpBJEk5ykcEDRedh/ZM9g2uRP
	41zLo+9LEmAk0YSPfYOvCKnELZ
X-Google-Smtp-Source: AGHT+IE4Rfu4VeaGeenFQsZykTjwPSN8eWex2dDWG2OkuP8MS0P7qwzkIGceMqnbnv1Qp4vIiM1EmGWGR+n+NIdll4U=
X-Received: by 2002:a05:6512:6d2:b0:545:2eca:856 with SMTP id
 2adb3069b0e04-5497d330b21mr2127271e87.9.1741218822945; Wed, 05 Mar 2025
 15:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qMn1k_iuZCe353x0BBxdD5z4-17Abk_ZHoPr8nVDLOgLhGf8Nxb3-bsXPH2GiATUsuGLVqAaEESua5G9qBaW0qqxwz-7AbcNyRwSXJzbKMs=@protonmail.com>
 <Z8jTjt1CQ7hp8KSP@tapette.crustytoothpaste.net> <xmqq1pvbks3i.fsf@gitster.g>
In-Reply-To: <xmqq1pvbks3i.fsf@gitster.g>
From: Oleg Taranenko <olegtaranenko@gmail.com>
Date: Thu, 6 Mar 2025 00:53:30 +0100
X-Gm-Features: AQ5f1JrJ1XX6-HFTKfOI4NT0fPjAOrtMrBszhSIYfv1mBs0gU5GMSDHYeLiRoOA
Message-ID: <CABEd3j-36C_LUOetg0qLofrby9M1Hixkh4o7sQkkyyWuTqHQvQ@mail.gmail.com>
Subject: Re: Suggestion: Enhance git init with Language-Specific Templates
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Tech Kenya <techkenya@protonmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 23:53, Junio C Hamano <gitster@pobox.com> wrote:

> I wouldn't have thrown objects in the --template directory, and I
> wouldn't count on things outside what the mechanism was invented for
> (namely, .git/hooks and possibly .git/info/ files) would forever be
> copied in newer versions of Git, but certainly "git init --template"
> mechanism sounds like a good escape hatch than mucking with Git code
> base to teach it myriad of languages and their dialects.

It sounds like creating a copy of the .gitignore structure requires
the user to learn bash script syntax. :-D I'd like to suggest adding
one more option to the init --template <template/dir>
--only-gitignores. It will not deal with all the complicated mechanics
behind hooks/etc, and will only look at the template folder structure
and copy **/.gitignore into the newly created worktree. In case of
existing .gitignore files, just put warnings and do not override
those.


--Oleg
