Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FDA2066CE
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211089; cv=none; b=qQbq6OTfzJnYlwBaBb80jzQaDndOGMSf4NpOsVM9/GqyWHGZR73wLeNnH04QRQ/x/Frv0MVY8hRTn4pmsqA5rvJJKEBillofu7WO6ZWSHNg8+xWGwd9DtERzUrxpSlYQkh01e+HsmLnO6HNaET4s6OjQ4/jeuFaO3eOdjUU52TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211089; c=relaxed/simple;
	bh=+4bxCMAiXzaYw+DXDeJHVYJVlHZqqWx8iTLwbuZ7cJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HkPVfMwnRjDRgt+0lCY9ADrMgVJUv1PsqCvbkMnc/aAn3gj29RugSErhc8JjLqr0g4tDb60+Q+Ax7CNEg+Lf5KzpjdhyjIfZTifwYBJRGJtoU1xL67lscKS/kl4g/Cv5aMyXyvJcSQo0CBmnAjjilDEzD+fp/G3TD16cR2zV2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkMfySCt; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkMfySCt"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86cfe449f06so50090439f.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 04:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749211087; x=1749815887; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSggIdNP7NiOpH6EAMkijc1fQWCtMpgL/i7mrsaPnR4=;
        b=RkMfySCtSZdOTYgDVoxx+R1bg6OVYfbdeFbxvS3XTytvv2/W6piGtDvOUr4ArihMJB
         oNhI5Zs769oOil+zpMuqhCmEYciNaMX5XDdFTftA7OpK4b2NMEPdpQutyZH06a/nW9PG
         +KaYOGLN6WIGpL6fTj+A9fAbJ6SmBV8unop9j9DYvXqTlqSFQfp/eUJwzAS3SHiSFPP/
         +3nvFoQQx3whpOkD33/G7xjU8mQcRwkG/cXzrVjHKreZDOD4l14fj81FyZY0o3eXFuBk
         SR6zQC5FvSOcc9RcsEyvLMdhnbDQ+bqVVgqNgnojacaFtfhIDP7SZ8ZtcLRmUmpySXok
         qNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749211087; x=1749815887;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSggIdNP7NiOpH6EAMkijc1fQWCtMpgL/i7mrsaPnR4=;
        b=D8gPCH1R+dd/AsPjfp0hkRWQA/arXpU5qgrWW+E0EghcKcosfRgoEeHVXGp7+bUD4O
         ZHJN6UaaMVYXgHpDL3cT1GchFnNmWKxAodCksOyPw20nm/8jgGZZf1/P55K8eGh6d70R
         2ntuU6gaMAsZohhKZ8mlVofK24J+nmF26f0YX6h2eiucVauK2cD643CDEuxgEGA+KVWS
         8s2YUGrhMslC/PoryJZRPBYsVLVUDs1/HqwzlvLHo1GByUQCru690dUgGlgDVbspC7Cg
         bZSodmf82bsNipv8F/DP2hC4st4G9j+AtA4MKJagcJOWTdS/Kh6L7OvKWHmkxTpWDenv
         Xusg==
X-Gm-Message-State: AOJu0Yz562VBiDNfkjgTO2QABlzsfada9QKaXmMri8y+2TKgVMnaXZsr
	i2GqRZxReujh8Mr+ewnEvsqsThtwcsNR4ywZV1s6or/4ADldHP8NUJ7W74nCfwmAcl3TIoxD4HS
	5rHV/vttMLn25ZgXuw4qbw9XBPbsuFo1wgxt1
X-Gm-Gg: ASbGnctvtZS1Xu4Pg1K+ORuB8qZALZdafmW8xcAOgIkiPsrd6M90qKWgsJnbHRDyV8e
	TTfxHkrpkjBjtZDwDgDGtheJ47qVO7Q38j5sGGf/ut5Y81vTAbs3DcJ8+NwqVLvnwjm1379SL3D
	c/L1v07tWpzpBWiElyswY7fIGajbPg4+dn9/0cU7lnmd7Uf8Dkcp0N
X-Google-Smtp-Source: AGHT+IEyAgJIkg/MVdKmPOe7uzhrKZ/B5OP6jYHc7xTdBcBClKNFxkZnCr1vpxibNkEFDwRQStgTg2RVUAgLsajXc0c=
X-Received: by 2002:a92:c24b:0:b0:3dd:c40d:7a74 with SMTP id
 e9e14a558f8ab-3ddce3ce152mr34194575ab.4.1749211087000; Fri, 06 Jun 2025
 04:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJsoDaFKRz8om1d4YPtaqdyuBuPAiC-xHDuvmYW=VQWEzzXAtg@mail.gmail.com>
 <ad141d46-3170-47d0-860d-46e7b92f878d@app.fastmail.com> <CAJsoDaGjF=2ZGwGdnx+M-1MdtfDWS2uE8+EAZMuu73cXjhWb7Q@mail.gmail.com>
In-Reply-To: <CAJsoDaGjF=2ZGwGdnx+M-1MdtfDWS2uE8+EAZMuu73cXjhWb7Q@mail.gmail.com>
From: Ondra Medek <xmedeko@gmail.com>
Date: Fri, 6 Jun 2025 13:57:55 +0200
X-Gm-Features: AX0GCFvBMg-OyTBGgbYTbrOlePOTdmMwTVzj1LjhneKsT_UzMW04HRZEylqW994
Message-ID: <CAJsoDaHQnwJTnWDT3eeTsH-nC9Tbt019T4W0pocqBSH80_FYqg@mail.gmail.com>
Subject: Re: Git push tries to delete branch twice and fails
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ah, got it, I have in .git/config the same path twice (I did it
unintentionally by manual edit):

[remote "origin"]
    url = file:///c:/...
    url = file:///c:/...
    fetch = +refs/heads/*:refs/remotes/origin/*

Sorry for bothering you
Andy

On Fri, 6 Jun 2025 at 13:50, Ondra Medek <xmedeko@gmail.com> wrote:
>
> Yes, I have witten it's just in one local working tree. When I do `git
> clone` of the same repository then it's OK. So I do not know how to
> simulate it.
>
> Therefore, the workaround is simple - I may just delete the local dir
> and clone the repo again. But I would like just to know what happened
> and if it's possible to fix it without cloning if the same issue hit
> some of our customers.
> ---
> Andy
>
> On Fri, 6 Jun 2025 at 13:43, Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
> >
> > On Fri, Jun 6, 2025, at 13:20, Ondra Medek wrote:
> > > I have a git 2.49.0 (Windows) and one local working tree is kind of
> > > broken, when I try:
> > >
> > > $ git push origin branch1
> > > Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
> > > To file:///c:/...
> > >  * [new branch]            branch1 -> branch1
> > > Everything up-to-date
> > >
> > > $ git push origin :branch1
> > > To file:///c:/...
> > >  - [deleted]               branch1
> > > error: unable to delete 'branch1': remote ref does not exist
> > > error: failed to push some refs to 'file:///c:/...'
> >
> > I was note able to reproduce on Git 2.49.0 on Linux.  Both through a
> > HTTPS remote as well as a local (filesystem) remote.
> >
> > ```
> > $ ./git diagnose
> > Collecting diagnostic info
> >
> > git version 2.49.0
> > cpu: x86_64
> > built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > libcurl: 7.81.0
> > OpenSSL: OpenSSL 3.0.2 15 Mar 2022
> > zlib: 1.2.11
> > Repository root: <path>
> > Available space on '<path>': 202.28 GiB (mount flags 0x1000)
> > ```
> >
> > > So, the same `git push` command first deletes the branch and then
> > > fails because it does not exist. It worked well until something
> > > happened and since that time it's broken. I've tried `git gc
> > > --aggressive --prune`, but it didn't help.
> > >
> > > When I do `git clone` of the same repository to another local working
> > > tree, then it's OK - the branch is deleted without the error.
> > >
> > > Is this a Git bug? Is it possible to fix the local working tree except
> > > for a new git clone?
> > >
> > > Note: I am developing an app which uses (creates and deletes) custom
> > > refs often. So, I've hit this bug when trying to delete a custom ref.
> > > I have cleared all custom refs and tried that with Git branches.
> > >
> > > Cheers
> > > Andy
