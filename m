Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAC28C849
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357715; cv=none; b=ZjTiPt1r2STU1fj81HPzhiUYZWIL/G63Er1oY3BLnlTQzSIwJKWIMb6Th2tOdbahlPlRHJGPuBTxj3fyhYs14hUEGU2z6DW38sSSsLf6tNk2Os+bUOAvixDpJLQvocg41F4rZKu/wX0tTpLr+G9cgE82YJt+hGx0B8MMJCR/afE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357715; c=relaxed/simple;
	bh=Gz/gFPfw6ysODqR/5CaDUOI6JA7LS2HF9zMqV90IeNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAl7XLtn32xpY/U0erd5HX2cnOXUY/16yheJ1akx5sQe63/UazXvdUZe8dHFHKp3E/D1tJ9My01+KRLRjGB1YpHIebkGTn+JM1kM7OHtXbZqouaQlBUkySJ1Uthpw3PsY78eFmgbLZbWc6eERDr2XEvZttVbEo0Yk5qq5KOCbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/GiJqJD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/GiJqJD"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0418f6fc27so64495866b.3
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759357711; x=1759962511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hzgaQkpDRe31oJP39ZUL986vP+hU0VlQTeUTHvU9JE=;
        b=d/GiJqJDzu77CO8ryfyqksyQh5aUlmJff83zAfcj6L1QFPuHyQbIusuPRxzC2UneK5
         37P4+qrp2avG4gJNSFtu9AVuartZyK3NXunSb+fzhAmfBJDjg3tax6qVgNPXeW1kc8ui
         /9FZaSponv0E1tT4qwge3nt14uCohpmeyU7AmYQ0ekaRd4R8Sakxj7RsrrwW3fUFQbUs
         ST1TPQoRnc0va4PStcGNANPss068cfDPYcq0OipIaPbncZhl/8B34pg9sefJXBfhmu8R
         /jPG0Zh5xnSX0U4F5B2GBxEiZ9tAbvAd2z/uqUJRseXn3ki/cb0LIvyM2li2zVHMgcnN
         cxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759357711; x=1759962511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hzgaQkpDRe31oJP39ZUL986vP+hU0VlQTeUTHvU9JE=;
        b=Dmf7czUqnTifDPEKifBoAg+WX9KF7/Mh2JNuoMkg/WeeFIg+C199NQzd+IAxfLeG4j
         BrDSCMuvYon4aLz0D4AAoIqR4pTXtagbA/b0DWrKhk3E+8AOKCrQRQBodDZO8KsVSGOE
         pJdm4m87JuuT7lBZFBVdn4znDP39SgDEoK0Tk7Fb0XhNdsHyiOD/qMbrUakEdEUh5KQQ
         lSEQjBEj8EtsVqlbthRG+JqszvspjA1Vwz7voLsF8sm5plarF4QZEDNe01IQeITWdOxz
         JF1Irh5LC1gtgwsUon3SU3/BbV3MbukbDoguNCIhh0CVwYodxFLyl9FRGhPHh6L1jJpP
         3eCA==
X-Gm-Message-State: AOJu0YyjatGSDjtk35Xrd/us5YZEJ/Eje9kfuh4c0sH6Cf3FRrpyKsft
	IbuGdrhR4ghtAUGDfgLyTC6HhaUkTKAto/XZOueELvpjMKMRQfffjwe7i546Xczd6C+9yjL+y4C
	FWxk+Up9WiqpT4N1iXfVAzvpYaua4HxA=
X-Gm-Gg: ASbGncvpB45H2lXmPEDefhnUlth+yGmJIbxOXDX7ADKO9lVyD1elqmVRupUaWSxCIYl
	gqZNATkOuVDpwsG6kZqN47O1tcwDoBtaGANeYMkAEzTv3W/vBq76wZ2GotJPgf/S15uHad90aCE
	U/qAbBRODB7alEf7ORGuIjFj7dLmA/ugvGaC4Svd8k8dsE/rx9YeDy4iGmeAn10APYMyMkRcwun
	abHBmAS9RJRqCJY+WQ3sRG9tV7qBFfPm5nliN3tA0FarDauYtJFO/QP0v+3QWNrdfE7s68CeaF6
X-Google-Smtp-Source: AGHT+IEfMbZipFqTSKHs/xoaq5flXAyxUTN009MK4Q2Smqb58wauGDWWZNuIJhLcIZmtbOav6tfnJv9ydnyff5MiTh4=
X-Received: by 2002:a17:906:f5a9:b0:b2b:63a9:223b with SMTP id
 a640c23a62f3a-b46e47910a3mr671721166b.31.1759357711039; Wed, 01 Oct 2025
 15:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com> <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 1 Oct 2025 18:28:18 -0400
X-Gm-Features: AS18NWBJZQNnsbQ39s2Yl842c97bmeX01gMzaPEUyhM_0oODfx5cCFUzE28v4Hg
Message-ID: <CALnO6CAmkzH=iHOU30Ud7jbP_91ovYuZBTx4nC_84ZPM53BoiA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] doc: git-push: clarify DESCRIPTION section
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:58=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> changes in v4:
>
>  * Add "the simplest way to push is git push <remote> <branch>" at the
>    beginning since (as discussed) this is the form of git push that's
>    easiest to explain.
>  * Remove "as a safety measure" since (as discussed with Junio) the reaso=
n
>    that git push sometimes requires you to set an upstream is very
>    confusing, and "as a safety measure..." makes it sound more principled
>    than it is. Also update the commit message to say that the previous
>    explanation was not describing push.default=3Dsimple's behaviour
>    accurately.
>  * Reword "To decide which repository to push to..." because I felt like =
it
>    was still phrased in a clunky way.
>  * Make UPSTREAM BRANCHES and CONFIGURATION into actual links in the HTML
>    docs
>  * Fix formatting in UPSTREAM BRANCHES section, from Junio's review
>  * Fix some commit message mistakes, from Junio's review

Great work.

>  4:  be6453d010 ! 4:  c1d4ea8d27 doc: git-push: clarify "what to push"
>      @@ Commit message
>           * not understanding what the term "upstream" means in Git
>             ("are branches tracked by some system besides their names?"")
>
>      -    Address all of these by using a numbered "in order of precedenc=
e" list
>      -    (similar to the previous commit), by giving a little bit of con=
text
>      -    around "upstream branch": it's something that you may have to s=
et
>      -    explicitly, and referring to the new UPSTREAM BRANCHES section.
>      +    Also, the current explanation of `push.default=3Dsimple` ("the
>      +    current branch is pushed to the corresponding upstream branch, =
but
>      +    as a safety measure, the push is aborted if the upstream branch
>      +    does not have the same  name as the local one.") is not accurat=
e:
>      +    `push.default=3Dsimple` does not always require you to set a co=
rresponding
>      +    upstream branch.
>      +
>      +    Address all of these by
>      +
>      +    * using a numbered "in order of precedence" list
>      +    * giving a more accurate explanation of how `push.default=3Dsim=
ple` works
>      +    * giving a little bit of context around "upstream branch": it's
>      +      something that you may have to set explicitly
>      +    * referring to the new UPSTREAM BRANCHES section
>
>           The default behaviour is still discussed pretty late but it sho=
uld be
>           easier to skim now to get to the relevant information.
>
>      +    In "`git push` may fail if...",  I'm intentionally being vague =
about
>      +    what exactly `git push` does, because (as discussed on the mail=
ing list)
>      +    the behaviour of `push.default=3Dsimple` is very confusing, per=
haps broken,
>      +    and certainly not worth trying to explain in an introductory co=
ntext.
>      +    `push.default.simple` sometimes requires you to set an upstream=
 and

Rather, push.default=3Dsimple?

--=20
D. Ben Knoble
