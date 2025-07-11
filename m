Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E54D2F0C67
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255809; cv=none; b=jywwahnH/h7VdDvxkaVDeOQx21VYyVyNHMCiFVvFDfL9uFwxSYKGmoMT3e6+BTf5zBPcu4j6j7ImyxceVmP8M3rAcZKCPyulC4lZKsKRBmDfFqG0T/Rr4m1/Y2g3LbXVJC9nCD+P1w9u5WLLb4n9IPXD9I5IkKrROCnOLNESf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255809; c=relaxed/simple;
	bh=7rIlSUR6v446ZaqCs6ThJ4jmGlK6S7Hd0PPBwSTXidk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgY9H1ktZSHsMTjspO+jCM5rCpGWIBgfPGlEkDRr487OSIj1kLUz3mWfJQD5OxGnY/MvwQfmF2v38Kabuwgb10rySmUxXS7xneOXifJ2j1eJqVsvNwtS0oRlckvbHWOATkjWn814IY1iEh1/G+UqRDb0w+1NSooM30PG1suy57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNQ+D6hl; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNQ+D6hl"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73ce2761272so1342460a34.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752255807; x=1752860607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULeoKFJi4iLJWrDSL9IeXWnRxnx5zhBM/s24sjI29zo=;
        b=WNQ+D6hlBKn0zYAuzWDlyndwjD1E+UdncZii75/P1xNjTl+VITOc02TJfVFvykz6sE
         pq3GlMBX9Q/t8+HcN4z5lCtRePhwJ9v1QzsCNAEdov1laXV7oRJjiVP4542xq1Jss8eu
         y0iADVS1MKCR2AG1qhFdH/LJe+HiuS2yVfBAI7e60ykBfnbfKuoM+HmC7DIAS90FE+b6
         vWiogXtVTWH5HMpiPuepe82BBJIC5BQe3S78wNdcwKT+5YOgn06wQ0eM4PrO5fpjcmAs
         ODGInSlxM5Yc5P0ZUizao4cAltcmyMvckj6HDwNaowyMqdqu7bwWoDZlyZ8wUddvHCB7
         CjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255807; x=1752860607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULeoKFJi4iLJWrDSL9IeXWnRxnx5zhBM/s24sjI29zo=;
        b=TUVAVRkfXlgrNYo/erOmGX990vc+w2Kau7UUzpNqXEz2Abk9QTImvNc66gO1LVFTRs
         08UT3hLWUhj0A1QxsRdlBMFynx5JUo8pK6joZhfhWLSM0UCwxUB/RHUvJKD68K5vVwv/
         vytyOU9Z4WG3jl1YVAK6Xi2DlQr73Z38axYwlZ87TQXaONACSFcipvgRA/1xchXioIDi
         shX8y70ABmx7sbvwiNmtvjY1U336LKRlo/VJXulNA0P5DXzS+CKZfPia32ZC1ZRFli0i
         5O2s6GdrRnLBmI+wAkFs7vuSmQA5GIMhNbivJwBcLQCCNy/imRlCS6a+9gfjXL/GPZm8
         0TaQ==
X-Gm-Message-State: AOJu0YwwKy47W+4TSJKRjNMwDsgqUI3dSKEaiEwOKK7p40lhZ+1qmEJv
	yJE+00a3N/H8RstAZa3e3iTszfJ+lGL69cQ3sFL4rlvEGLX0qSOh8+85ANxa7Vth
X-Gm-Gg: ASbGncuSX97DDspb4HXNvGWsVGZJ6cGUjxb/HqiL4Fk1ztxf7alEPla22F/TOBdF5AE
	/vMdVRtMuVlr4zg+d222rF1adh30w61xA0hnEBbHs8hUbmu0ka+Zyn0Y0stsrKzLX+6rR1JD4vB
	2YfZlEDJfnQ5BP6qcOGrJwtn+gNghpV8Uxv0OkIrXk9RIr3FoElpacDzNa8YWgsewRTegEQDTL0
	S7WNcD1yaM7VzwX9nR15O1b22Q0i+hOuUVWWdUg4Vf1udSQCY3GU7OgG1gNFgTF7q8Byh1fZ1s/
	/NJnB7HM6wH8QsrjhGcMA/6ErxsV96NLMYWgwLNEj3J0f6b4wruFgxzHVcsNZXub6lWXy2sx153
	5xyD4GLYRwJgfyok=
X-Google-Smtp-Source: AGHT+IGOikJ8VP/1KQNFBJj256fG9q1DWnHhDM1xpOTzoa7/xnr+sksZ8ApmwAZOSGysCfj6hTY3cQ==
X-Received: by 2002:a05:6830:730b:b0:73b:2ad0:6218 with SMTP id 46e09a7af769-73cfc3d4b6fmr2296213a34.11.1752255807104;
        Fri, 11 Jul 2025 10:43:27 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf2141e45sm579176a34.39.2025.07.11.10.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:43:26 -0700 (PDT)
Date: Fri, 11 Jul 2025 12:37:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v3 0/5] repo-info: add new command for
 retrieving repository info
Message-ID: <eze7lvd6wvvbpwa4qqst4c5ctpjdxyaluacxk2ljvzyejzol3s@tob3cyvthnp2>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
 <0FEC4502-867F-4B9C-B752-376EF9464983@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0FEC4502-867F-4B9C-B752-376EF9464983@gmail.com>

On 25/07/11 02:13PM, Lucas Seiki Oshiro wrote:
> 1. How would this integration be done? Making this `git repo` command only as a
>    house for two different subcommands, or making it a common interface for our
>    work. An argument for separated subcommands is that `repo-info` is a light
>    command, while `survey` is more computationally expensive. An argument for
>    having a common interface is having a standard format for requesting and
>    retrieving data from both sources.
> 
> 2. A solution for 1. would be keeping the idea of having `repo-info` and
>    `survey` as two subcommands (perhaps `git repo info` and `git repo stats`),
>    following the same output format. This would also make room for a third
>    command which would return data from both commands. Then `git repo` would be
>    a plumbing command (`git survey` is more porcelain-ish), and its machinery
>    could be used by a separate porcelain command for formatting its output in a
>    more human-readable way.

For some additional context, Stolee sent an RFC series[1] which proposed
the git-survey(1) command as a native tool to complement git-sizer(1) a
little while ago and I've been interested in pushing this topic forward.

As a first step, I think we could introduce as command, such as `git
repo stats`, which focuses on computing "interesting" stats about a
repository similar to git-sizer(1). The output format for this would be
simple key/value pairs for now similar to what Lucas has proposed in
git-repo-info(1).

As there are similarities in command scope with git-repo-info(1), I
think it would make sense to group these operations together under the
same top-level command.

-Justin

[1] 7d43a1634bbe2d2efa96a806e3de1f1fd480041b.1725935335.git.gitgitgadget@gmail.com
