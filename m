Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62F4C84
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804800; cv=none; b=iKKQyYGrnEQ35ix2M/uvxQyyXrvoXSpHvTIbZuOOTkCQqmn8X6DamdaFUSTCL1alUgjSqSV82YmMHvMBo1ILDfhapCA7OPc2O+CJ5Z1M74+korCdU7ybKekoO63yh6lCbq+ah8fCShk1Xwh8SswC+sDurRlluGIMRn7NDzDavwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804800; c=relaxed/simple;
	bh=lwPX2IOI/nvqDiSMh7l4BtfAh1DyQRt5DfmltgUM3gw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AgeM4ewNW0dfGf/5MY1t6fbmfgvWrS/twShHo1YcSxPauCYaZhiJrc+DAVcWY0YXCQLxzcJekl62ko2gC8futvagKMsTHA7qkLT7EBsNlKsx/yAA4Jc+8o1Bn0axV7BnlFpWD40si06mw3BSbxLqeo6tv9GViNuqRZRvRiW0huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPIjmZ6h; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPIjmZ6h"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d162eef54so2306850b3a.3
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721804798; x=1722409598; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejAzTD96TBC7Xz4gREwx4tJHHmzV/BqoMB0Mp78lsYI=;
        b=TPIjmZ6hkqVhOOPAf4LHmKnOp7E5HH5rxncWtgAkSyJQoQhnTLz9VWlRZeQJ8C73Zs
         TGf4P/hb8mJs7WV/bCo4hKE9xYhbW2lYdPZSnFpTts+PyrnGhjS1A/Q2FO+cpdHL/uLU
         B5p18QHwuqgapvICnvYfv3T/He7D8Cnogax+/HGykHlNj+LDtvI5rGw+74+zZp4ielRG
         uCrXSMdusaPFoSVCiPzRXPegKcX4JUQWOKzofCHDyEY5lQnNr1Mxee5y24+3wvYSIc9t
         dpKoFWdd91l4wrPckDGvi7yoIYb0ys/CpyouFmDYRGdQetpVIEatfjkw64PODouoIqdn
         +qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721804798; x=1722409598;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ejAzTD96TBC7Xz4gREwx4tJHHmzV/BqoMB0Mp78lsYI=;
        b=jKd8r7TrRyAqPl7UPpa4iVbMwq2vK8U6nxYTLZhgVdu7xCdZ/ZYwhdiHWr8E3LbIl4
         bUgLpL8MlClXp5Tb/i/BTVDTZ8zjgl+NMPS79xpbC6KrPvneFBcPQi0am8e9LZzjtXr/
         UH54M5W/gd5AN4M/LJ1V2bOMJA9CD2iDIy2yaxOYh1LsqfWdoC/P/4mLlibqh/QPXDKJ
         bH1MZoCHlyT6Ga84AX4zwPylHKXjKpsKQfuDNcVdpGc+fZNNlwNeSrEqDl8MsFLUS16F
         /qh5zA7eQIRMuKoWDBymouGuKH8m0vLQXsSJ0nw25aJglssWgFb6G3KhlhMtuuG3EXZz
         +pFg==
X-Gm-Message-State: AOJu0YxzIc9OeAZPCmZPSSZutRS8Vy2mCELJjK4ApfSSli9HlZ4L42DU
	lxF3/kt4uLiR3YUD4fZtIo+mVpejpqMQGqcknvUZvg+OqpyQZud2
X-Google-Smtp-Source: AGHT+IGgnlmndpiU6trDd14bDWdu7Pm9GrM3ps6IAt32/v56PCf1gb7YP2wckEryqo8lDWbA7RkFrQ==
X-Received: by 2002:a05:6a00:2d2a:b0:70d:2cf6:5e6 with SMTP id d2e1a72fcca58-70e9da9fd63mr1609667b3a.15.1721804797972;
        Wed, 24 Jul 2024 00:06:37 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2d316c84sm3929219b3a.81.2024.07.24.00.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jul 2024 12:36:32 +0530
Message-Id: <D2XKUY6MQJOR.2B3YHEXQPOQQL@gmail.com>
Cc: <git@vger.kernel.org>, "Christian Couder" <christian.couder@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Christian Couder"
 <chriscool@tuxfamily.org>, "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-urlmatch-normalization to
 unit tests
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <Zp-3e6VV5bl8dWvR@tanuki> <D2XCB5UYIB5B.1L3U95DQSWJ2@gmail.com>
 <ZqCO6JTQqdxD73Wq@tanuki>
In-Reply-To: <ZqCO6JTQqdxD73Wq@tanuki>

Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Jul 24, 2024 at 05:54:33AM +0530, Ghanshyam Thakkar wrote:
> > Patrick Steinhardt <ps@pks.im> wrote:
> > > On Fri, Jun 28, 2024 at 06:26:24PM +0530, Ghanshyam Thakkar wrote:
> > > > +	free(url1_norm);
> > > > +	free(url2_norm);
> > > > +}
> > > > +
> > > > +static void check_normalized_url_from_file(const char *file, const=
 char *expect)
> > > > +{
> > > > +	struct strbuf content =3D STRBUF_INIT, path =3D STRBUF_INIT;
> > > > +
> > > > +	strbuf_getcwd(&path);
> > > > +	strbuf_strip_suffix(&path, "/unit-tests/bin"); /* because 'unit-t=
ests-test-tool' is run from 'bin' directory */
> > >
> > > Curious: is this a new requirement or do other tests have the same
> > > requirement? I was under the impression that I could execude the
> > > resulting unit test binaries from whatever directory I wanted to, but
> > > didn't verify.
> >=20
> > I am not aware of any requirements, but if we want to interact with
> > other files like in this case (and where we potentially have to
> > interact with a test repository), we'd need to have some requirement
> > to construct the path to these data files (and the test repository),
> > similar to end-to-end tests where they can be run in only t/
> > directory. Do you think calling `setup_git_directory()` and then using
> > `the_repository->worktree` to get the root of the worktree of Git sourc=
e
> > and then construct the path relative to that, would be useful? That way
> > we can atleast call the binaries from anywhere within the tree.
>
> Instead of using the working directory, you can also use the `__FILE__`
> preprocessor macro to access the files relative to the directory of the
> original source file. That at least makes it possible to execute the
> result from all directories, but still obviously ties us to the location
> of the source directory.

But doesn't '__FILE__' give relative path instead of absolute? A quick
test_msg() tells me that '__FILE__' gives the path
't/unit-tests/t-urlmatch-normalization.c' for me. So, I don't know
how we would be able to execute from _all_ directories. Although, I
think the restriction of running from only 't/' would be fine as
end-to-end tests have similar restrictions.

> Whether that's ultimately much better.. dunno. But I guess this should
> at least be discussed in the commit message.

Will update.

>
> > (P.S. I know we want to avoid using `the_repository`, but I don't know
> > any other way yet.)
>
> You can use e.g. "t/helper/test-repository.c" as an example, where we
> use `repo_init()` to initialize a local repository variable.

But it requires us to know the path to the repo and worktree in
advance, which kinda defeats the purpose of using 'repository->worktree'.
setup_git_directory() sets up 'the_repository' from any subdirectory
of the worktree, so we can get the root without us having to know
which sub-directory (of the worktree) we are in.

Thanks.
