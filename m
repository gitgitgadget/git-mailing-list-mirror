Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB825D1E2
	for <git@vger.kernel.org>; Fri,  2 May 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202477; cv=none; b=JcDIf9Dc4T32BulTK3/24qlEpMVlOeczy+wAb+oycUr+81w/XIg8d3TIUeFagl10JXXC229smxzEiWY8a9Cdj0Nyo6vvhnuL164YDE0q9YWh5mQbjC30O2qoYqMee80EAMC3gtSjjUkBl1tXuEPs3A779Uz26vMCYDndiyH7agk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202477; c=relaxed/simple;
	bh=XJkZ62dcXllnKgTx9Y+JUKlQu98WUDPlif7Dv/1cu60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miGMBF+4J/QHXHi2X9VJ0QbzLMjwbSLljEbIt4vODOL3vbz6YAFzXG4S1AfDELz2D02z+H5ZUqUrRP9sPD4viRxUpNEIY8tSe4pZtM/F25li8TSb2vxWV7z4LMPSIvgR2IUmNOZCPhee3Bthih2JubKxspdIW5gduzj4+ob1Dzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlSFNoLu; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlSFNoLu"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54d3ee30af1so2179456e87.0
        for <git@vger.kernel.org>; Fri, 02 May 2025 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746202473; x=1746807273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XJkZ62dcXllnKgTx9Y+JUKlQu98WUDPlif7Dv/1cu60=;
        b=FlSFNoLusYhDFK62mQ5SC4Y4qXbaGr/7sCpTXjK7lzpzRv+k1lnr8c6FX9+GTT7KEB
         NUh0877Y0XBswe0oxLNnn/pa+Cxo4FOsk/E7f7I4S6h3qBTO3L18g3cfe9Egz5qpJi9Y
         i3axTruLaLBSbDdb+LvlDrKjEbkdXcsnfDvw1ZUvQS9Fi49CJqCLvtzAYVqnOO+OjcL2
         rz/1eLS1IDZaHsydCMLvmekPIFaqsFrmZbcboKeWZv55Ic11XonA+D+2FS2J27Zfmz+T
         SsnMJUgoStc0ZJrPn3l0iwOWrR3hwlF3wuWI6AZIYxUaem4RIQN6AbLThUcoFC6YjRaK
         2F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202473; x=1746807273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJkZ62dcXllnKgTx9Y+JUKlQu98WUDPlif7Dv/1cu60=;
        b=hjpSTkg2TyYLjE8EiAurcTff9xcPSdQTsJUpGqkUBepaHI7SOdPNfN5gF3G6BiTc77
         Fip0QPJ0UV4BpC1Qeoo3Y/VCHnJfoRnJzhR8NzhHNvdPkkr2Uo1ncQbQW/yNn7d94htg
         PVEWvwWed6a7IvPXo9O3MhhbVFPWqgvziIluTRXs+PcwLCFrw2+H+5KnLipHO4+8ug2/
         oCor2zeO69rpVZxO/LvxumhWREhWAmeCyDnopp5MVxi2Tr0scTCyrtCE4JzzKCvRidbb
         qmgAmE9WsNOZbRJrKtAjMF3M5UWUQxHk4PB5nFOaInsXqhCBrzYB80sfd4EaxRUsN6+J
         1ftA==
X-Gm-Message-State: AOJu0YxpqSrqWxUH8+2tqqAj3RK7SLo99EEMIws1gSqiAPGfV7+oAB8r
	h2/NOj7B9qKXKI4Xzp7wlkY2EXRr23QnRs0JQi6//s3hIbgOz9if/CnVmFHrehuphlSEVlb4hG1
	7aCiUYcIXUQuCFsm8XNnNFkHIDe0vYi8XU8I=
X-Gm-Gg: ASbGncvqZPTjiCrwYw5dICAMCmHkJh6/IfqaQgf0m+FcUkTvqEXOK2ArL684OcAroWV
	EbVAZp//qFg7TJQODnIxFz6T5z9j1ry6PG4x/4C8UUWj/Sj2oAj8U6V7f/MxGZ2nB8ycwMogh91
	ZtJv8O8GjZZkwT8WsWzc5Wud/rnm2OWyzgd71p22xanz4u4MWRjbdZ6CfWcA9qQPE=
X-Google-Smtp-Source: AGHT+IEkClc7o/MBonkHsKqrAz1eoLLpfyxwehLANYuSHPa2L49Vg76pp17qDEzkFMHULNXe2hOJk/EUVqhhv+HnIeo=
X-Received: by 2002:a05:6512:3f1d:b0:54d:65b7:137c with SMTP id
 2adb3069b0e04-54eac2446d0mr995259e87.47.1746202473035; Fri, 02 May 2025
 09:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
 <bf7f6606-e719-4c3d-b7ab-ef7351f66f37@gmail.com>
In-Reply-To: <bf7f6606-e719-4c3d-b7ab-ef7351f66f37@gmail.com>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Fri, 2 May 2025 17:14:22 +0100
X-Gm-Features: ATxdqUGvVc6PmZV4WpNUWjN5T9xH1mX4-c4ws4aJHTKJp2rGXT8bCdpNuzUDvsQ
Message-ID: <CAP9jKjG+khoUmRpVJ8om-bs_qjB=VFCj3p3h0VSaBHVnqPLNVg@mail.gmail.com>
Subject: Re: Discussion for interactive --patch commands to get --unified support
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Inheriting the diff.context setting is what scratches my itch the most, although
also being able to set the context in the command list of `add -i`
sounds interesting too. Personally, I don't think I would use the
command line overrides too much myself as most of the time (like with
diff) I'd like to set the option and forget it but it does have a
certain consistency to it.

Slightly off-topic to the discussion, but does anyone have advice on
how to deal with providing a sentinel value for something like
context? I'd expect to pass `--unified` to the underlying diff command
*only* if the user specifically has overridden it via command line
option or a diff.context config, just like diff.algorithm has done,
however diff.algorithm is a `char *` so the value can be NULL which is
a good sentinel value. My thinking is then the underlying command can
just deal with the value as it sees it, such as giving a default if
not provided or making sure it's a minimum of 0 etc. Otherwise the
level above has to deal with it which then probably involves
`git_diff_ui_config` and other validations which I don't even think is
it's responsibility and would probably duplicate logic unncessarily?

I may be completely off in my assumptions here being new to the
codebase, so if anyone has any thoughts I'd greatly appreciate any
comments!

On Fri, 2 May 2025 at 15:39, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 29/04/2025 10:16, Leon Michalak wrote:
> >
> > (https://stackoverflow.com/questions/6711670/git-show-more-context-when-using-git-add-i-or-git-add-e)
> > which mentions you can do `GIT_DIFF_OPTS=-u<number> git add -p` which
> > does work however isn't very user friendly or convenient.
> This is a question for others on the list rather than Leon - is it
> intentional that the plumbing diff commands respect GIT_DIFF_OPTS? If a
> script that wants to create a diff with a certain number of context
> lines runs `git diff-index -U <context>` is it helpful for that to be
> overridden if GIT_DIFF_OPTS happens to be set in the environment?
> Looking at the history it seems that environment variable used to be the
> only way to override the default context setting but that's not the case
> now.
>
> Best Wishes
>
> Phillip
