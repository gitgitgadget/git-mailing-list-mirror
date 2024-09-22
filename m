Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54690322E
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727016025; cv=none; b=FWyA/IuKPLcZrCRAEtIxUyZJkw+kA9y11p3H6/+yc7NRzmqxrFV8MAa7jzx6rVAZjmmUTfCznYpk1P/KBIDGrZckAyq4o06vzLXS24hqK2iKfXYPNViCpZ0vsmU57MM6yibcQrf7CHPlVFn1G95/GFH4IUcl1f+s8lh2AH1gOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727016025; c=relaxed/simple;
	bh=7cxL5rumA3rzHscdqev+Nrx58cXIPShnrxXsIGbZWx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnf+yBwGNUkTxs1r+CTTwWRwMizWgv4vaQintX0Fd5BN19zmaOy00ej+VzSL9dDNYQ8EylG0tmsSNUtKcaO/Z/SoYsnvMbrkheYhIj02G8ZnuzD+udcXJpqak4m4H2lSOL27Kh/cTiTV9PehTJ4MkJnxO3Zg/YAx1UwoxS2+gRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmSxMIvx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmSxMIvx"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71798661a52so2647224b3a.0
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727016024; x=1727620824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHlwdCDEqsrbgCB+76IbS300kyB5CM5B6+rmMMERn6M=;
        b=dmSxMIvxLDb0tfWKwUzArZM6Mn5bGwPMT3qwb1ois3KkW2rRDSokMlRQblLPrvVHAu
         WVbubinFBXRlsIS48rtHRwi6tjYrybKI00apJ+rphj5Mgzo4Iez4RJXQMgiOnS+uXxnU
         SwF9uvy1qyKFI2h/QI0MjDZiEieBuo9vZVWhK5ZCJXCaMK+3r6dFib9vjqyndBPeW67a
         QpUvDraFQ/yHtVTehw6LJQdbt9+qRIgFBOqkT8b1mRk47neK4EgtIVDXSu1Z1twRO7ko
         H2Cx/UDHbEoG2Otf+KtxcWEdW/TXEATPq5xboS5tUCksnzUP4Xa6IS8au64l6HDIBkzE
         ADVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727016024; x=1727620824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHlwdCDEqsrbgCB+76IbS300kyB5CM5B6+rmMMERn6M=;
        b=Ka6CVuiwYMn42T/LaVE7yHfKKsoaqkvXXbLOnRp1Vq3Ajsrkpck5zrq6PRMrPjVHCY
         8qyXUKWSnPemos+t+XodMV+H9CEv8ln+Gzqk/WnXfUTw+sfrvTk+PMCGO0owo/yf0Xjg
         HMz2HrQYYSqMblJOk/Cg+uZiZZz/eFLmYLqhkH8CUM/7rrZl1Hx/kdNybXNq/EjIVSzL
         fIAlabpkiQnmOjNY+hKAmdZ5x8Mm2ptK5TveP4/XCbX+u+ZzCIFIu7FnM7XwnSHjjBTW
         KaRWtb1hadJ/FdUL9qlLPzmSeaTtQeKsBFEdmk7Z1I2UG7OIPOjgtEPDs+qd6U9xhG7D
         MeTA==
X-Forwarded-Encrypted: i=1; AJvYcCVcYuz+4ozVl2q8T2mwOewE/7ibLaxn2Q30xWD54I6cCndV/cjoYe33J92QU+QyBrkOtoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNdXll+iT028SexkALzaE5vp9/aG3jBh6qx7vgCwPSCrGRpza
	pYs1lhKFOhcS6GxDt2Wz4Lu+9E3SoiqKsHj3hF/dTbrG3i/QJKgC0zuTCQ==
X-Google-Smtp-Source: AGHT+IEVrQ1uSmTpdt1x5xcDedOmVWRxOlIq0fLhVWZuHwXWCVO2e/nHpr8pdNjjsq7mJVOi7ktwtA==
X-Received: by 2002:aa7:88c4:0:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-7199b0c3d7amr13870907b3a.7.1727016023586;
        Sun, 22 Sep 2024 07:40:23 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4999cddasm14042478a12.76.2024.09.22.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:40:23 -0700 (PDT)
Date: Sun, 22 Sep 2024 22:41:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: BUG: refs.c:1933: reference backend is unknown
Message-ID: <ZvAsnyZrVTO-j6XB@ArchLinux>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
 <Zu7vpPs8fcqlMlNK@ArchLinux>
 <9fdb9561bb0ad85e55ca3253cc4db9b098641e30@rjp.ie>
 <9bf5c254-4d87-4f6f-b278-d9df4d7897b5@web.de>
 <Zu--coU4qv6Z1SmD@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu--coU4qv6Z1SmD@ArchLinux>

On Sun, Sep 22, 2024 at 02:51:34PM +0800, shejialuo wrote:

[snip]

> However, the repo does not exist, so we cannot find any ref backend. The
> main problem is that we never check whether "the_repository->gitdir" is
> a git directory in "config.c::include_by_branch". So, we do not need to
> check the value of the option "--git-dir".
> 

I have just scanned the recent code here, because Patrick has already
replaced the "the_repository", there is no problem here when set up the
configuration in the TOT.

The code will first check whether the "data->repo" is NULL.

However, there is still a problem after setup:

#5  0x0000555555780442 in ref_store_init (repo=0x555555948b00 <the_repo>,
    format=<optimized out>, gitdir=<optimized out>, flags=15) at refs.c:1938
#6  ref_store_init (repo=0x555555948b00 <the_repo>, format=<optimized out>,
    gitdir=<optimized out>, flags=15) at refs.c:1928
#7  get_main_ref_store (r=0x555555948b00 <the_repo>) at refs.c:1958
#8  0x00005555556a332d in include_by_branch (data=0x7fffffffd400,
    cond=0x555555953d13 "main.path", cond_len=4) at config.c:308
#9  include_condition_is_true (kvi=0x7fffffffd320, inc=0x7fffffffd400,
    cond=0x555555953d13 "main.path", cond_len=4) at config.c:408
#10 git_config_include (var=var@entry=0x555555953d00 "includeif.onbranch:main.path",
    value=value@entry=0x55555595382f "notexist", ctx=ctx@entry=0x7fffffffd280,
    data=data@entry=0x7fffffffd400) at config.c:438
#11 0x000055555569d3a3 in config_parse_pair (key=<optimized out>,
    value=0x55555595382f "notexist", kvi=kvi@entry=0x7fffffffd320,
    fn=fn@entry=0x5555556a3060 <git_config_include>, data=data@entry=0x7fffffffd400)
    at config.c:616
#12 0x000055555569dafd in parse_config_env_list (
    env=0x555555953810 "includeIf.onbranch:main.path", kvi=0x7fffffffd320,
    fn=0x5555556a3060 <git_config_include>, data=0x7fffffffd400) at config.c:699
#13 git_config_from_parameters (fn=fn@entry=0x5555556a3060 <git_config_include>,
    data=data@entry=0x7fffffffd400) at config.c:772
#14 0x000055555569e383 in do_git_config_sequence (opts=0x7fffffffd550,
    repo=repo@entry=0x555555948b00 <the_repo>,
    fn=fn@entry=0x5555556a3060 <git_config_include>, data=data@entry=0x7fffffffd400)
    at config.c:2131
#15 0x000055555569ed49 in config_with_options (fn=0x5555556a3060 <git_config_include>,
    data=0x7fffffffd400, config_source=<optimized out>, repo=0x555555948b00 <the_repo>,
    opts=<optimized out>) at config.c:2174
#16 0x000055555569eec7 in repo_read_config (repo=0x555555948b00 <the_repo>) at config.c:2544
#17 git_config_check_init (repo=repo@entry=0x555555948b00 <the_repo>) at config.c:2564
#18 0x00005555556a0272 in repo_config (repo=0x555555948b00 <the_repo>,
    fn=fn@entry=0x5555558218a0 <git_tar_config>, data=data@entry=0x0) at config.c:2576
#19 0x0000555555822651 in git_config (fn=0x5555558218a0 <git_tar_config>, data=0x0)
    at /home/shejialuo/Projects/git/config.h:704
#20 init_tar_archiver () at archive-tar.c:544
#21 0x00005555556700c9 in init_archivers () at archive.c:46
#22 0x000055555557f8b8 in cmd_archive (argc=2, argv=0x7fffffffdcc8, prefix=0x0)
    at builtin/archive.c:98
#23 0x00005555555753c9 in run_builtin (p=0x555555916760 <commands+96>, argc=2,
    argv=0x7fffffffdcc8) at git.c:483
#24 handle_builtin (argc=2, argv=0x7fffffffdcc8) at git.c:739
#25 0x0000555555576335 in run_argv (argcp=argcp@entry=0x7ffff

It still uses the old "git_config", so we still have a problem when we
explicitly specify the "--git-dir". However, once Patrick replaces all
the "the_repository", this bug should never exist. So, I won't dive into
this.

Thanks,
Jialuo
