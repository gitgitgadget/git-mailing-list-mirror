Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E723A9
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721780681; cv=none; b=ee3qAvwE6Fh5Y5TUuCq/Doi4kXOePUx615iwnngHbgo595jlDEK6nh3iBDiLLmJ++G9QoVCQhj+7WiZGqX2KSqvxHP++gLaQpqK9Y/NCK/Ok3uHG4OFHOcuftVHi1cdk8eSE3P6S7I+y9DOQ/6d4qO6CBxa4YgGnMJMByLWfhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721780681; c=relaxed/simple;
	bh=kB/Q4YlKhexTkountwdCnhhb6Q1NvHRflIGGD5ZAVGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KbkGKOu5MLPgTzBEId5FDk7fm8KtoF8Pxx51U4o+Bqt1xi7LPNGlDKjRlFjKhgq2fseRV+fHOWwhzQMOt+WQEa451HHiyJY2IyWshH7+ORXGScOdgvypBJ5iUs0jpJgioMC4a6JYBVMgiluObhGeJbWuVdIQxRM5uqFPvAh/U1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9Y2PYBg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9Y2PYBg"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-71871d5e087so905925a12.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721780679; x=1722385479; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHHNqNXC1NVjkAHLZOlqR5IWsVHT32l+Ow1UR1eKvDA=;
        b=l9Y2PYBga79vJJwBmJHDqDyMGxJzFIrNOxRD3Up5lQyl1sjMpsPvwVf2TmZd+wQf0o
         ZXkPJIQjQIOQ5gLLcYVhouhb5dmL309DtGhaMZj20J0FyaDD15EOURB6CzApkKomBKBA
         Ik+BUA3/x0PanRMrkKAICHbNDDrhfg6s5IwOVBRiKAqMm0bnlJATk+ZApqOwdGuO5X+T
         jsJMZ/9hoKyki1mjd9AVE+EvGaNcgDEkDDaA6Y/i/kfgjq/XdYAWjpG0YGaHcr9CgO4o
         ZFaQ014rUhYpSZ8tFBpO600tq7R0tPLS3OVya9FlF5/7zLK+KJh5a7AtCmTmFydB5LQt
         VLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721780679; x=1722385479;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eHHNqNXC1NVjkAHLZOlqR5IWsVHT32l+Ow1UR1eKvDA=;
        b=QnL0co23hJDejVYono/skxAvYbTFVjjgsvOwIDEqxr0OWWu4KwJKM5Riwq2VW/3tf2
         pWMygEeWrXF1wNCVk+smbHyTm2p/JubEbhxFhIdw8j3jg4bajcibZUG48sFgmg+XWEw4
         Uu9rONixDZibIV6Fj/d6dIbE+RlDf/dhCfLFFHx6WmgY6yKA26OVdIZ6oIiqF4eNrTfY
         EL3JQ/ROvrY2zN5XAkWhQflPKoJdN1I+MNDLjcuEhppCcbxOe57H+YSNTiFWa0U+OB9A
         Owz6l9N08gpt5Y0M7L/CjRXkVZ6D3xDG69UaUETUquLHWmqOhOiqcJC6XKyZvOYKws18
         UX8w==
X-Gm-Message-State: AOJu0YwTDozpe3SqHKp/Bw0bB2xSmWP4FWd46wSxkQk2GyAIpc2dEBCl
	Df7+zS1OKQI08Q+zxepRCOoRD5upqIz4hYimagmxVlCHG5zrBMud
X-Google-Smtp-Source: AGHT+IEtYV+eI5pSO7X+1zoNFKj3X+7/yTTb6pKavFBy6Xg7UE42UurIBXuDJhp3hTvSQ3WRvzu1iw==
X-Received: by 2002:a05:6a20:7f87:b0:1c0:e728:a99e with SMTP id adf61e73a8af0-1c461964102mr998093637.26.1721780679208;
        Tue, 23 Jul 2024 17:24:39 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d24655886sm4506922b3a.142.2024.07.23.17.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 17:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jul 2024 05:54:33 +0530
Message-Id: <D2XCB5UYIB5B.1L3U95DQSWJ2@gmail.com>
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: <git@vger.kernel.org>, "Christian Couder" <christian.couder@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Christian Couder"
 <chriscool@tuxfamily.org>, "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-urlmatch-normalization to
 unit tests
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <Zp-3e6VV5bl8dWvR@tanuki>
In-Reply-To: <Zp-3e6VV5bl8dWvR@tanuki>

Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Jun 28, 2024 at 06:26:24PM +0530, Ghanshyam Thakkar wrote:
> > +static void compare_normalized_urls(const char *url1, const char *url2=
,
> > +				    size_t equal)
> > +{
> > +	char *url1_norm =3D url_normalize(url1, NULL);
> > +	char *url2_norm =3D url_normalize(url2, NULL);
> > +
> > +	if (equal) {
> > +		if (!check_str(url1_norm, url2_norm))
> > +			test_msg("input url1: %s\n  input url2: %s", url1,
> > +				 url2);
> > +	} else if (!check_int(strcmp(url1_norm, url2_norm), !=3D, 0))
> > +		test_msg(" url1_norm: %s\n   url2_norm: %s\n"
> > +			 "  input url1: %s\n  input url2: %s",
> > +			 url1_norm, url2_norm, url1, url2);
>
> Nit: this is missing braces around the `else if` branch. If one of the
> conditional bodies has braces, then all should have according to our
> style guide.

Will update.

>
> > +	free(url1_norm);
> > +	free(url2_norm);
> > +}
> > +
> > +static void check_normalized_url_from_file(const char *file, const cha=
r *expect)
> > +{
> > +	struct strbuf content =3D STRBUF_INIT, path =3D STRBUF_INIT;
> > +
> > +	strbuf_getcwd(&path);
> > +	strbuf_strip_suffix(&path, "/unit-tests/bin"); /* because 'unit-tests=
-test-tool' is run from 'bin' directory */
>
> Curious: is this a new requirement or do other tests have the same
> requirement? I was under the impression that I could execude the
> resulting unit test binaries from whatever directory I wanted to, but
> didn't verify.

I am not aware of any requirements, but if we want to interact with
other files like in this case (and where we potentially have to
interact with a test repository), we'd need to have some requirement
to construct the path to these data files (and the test repository),
similar to end-to-end tests where they can be run in only t/
directory. Do you think calling `setup_git_directory()` and then using
`the_repository->worktree` to get the root of the worktree of Git source
and then construct the path relative to that, would be useful? That way
we can atleast call the binaries from anywhere within the tree.

(P.S. I know we want to avoid using `the_repository`, but I don't know
any other way yet.)

>
> In any case, the line should probably be wrapped as it is overly long.

Will update.

Thank you.

>
> Other than that this looks good to me. I've gave a cursory read to the
> testcases themselves and they do look like a faithful conversion to me.
>
> Thanks!
>
> Patrick

