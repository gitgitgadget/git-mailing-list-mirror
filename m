Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E071F405
	for <e@80x24.org>; Thu,  9 Aug 2018 00:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbeHIDH6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 23:07:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36381 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIDH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 23:07:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so1968048pfo.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 17:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQS86ZAhuhMT3HnJdgi8S3VXMpEEv8sblI+XeicxmqE=;
        b=hUiSFgg0nekiZFY+7GZ9I5QqFAVYgUFxAVR+d6h4FPSt41GvO+2TXNh2VV5XbN6fF4
         oLRE6wMtMJWbjoOQwmme8ZxKYo10fLvjtDsSdEXj6L+sVJRnFjeuUwNaYXf63cl/84GL
         6GQlNvezbhSPEjA1WonPaioVXcA8uv4NcH4Sp89679dqtxLt8sKx1lNg+IraZ1HHFv58
         AZo8IjVndBaM0Kl8wUMZZ3ha+DWA+GBYzK/BEJVMpjVCRve16HzVAfbzY9wctwM0PiHe
         kj4OZWC4iCYQul1SJw+NpOzcdIvbeW9bVTKVk+jVFu6GHeU8gN4U6bgpOV7MJg9hEJVa
         dPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQS86ZAhuhMT3HnJdgi8S3VXMpEEv8sblI+XeicxmqE=;
        b=SlXeQVhSMRSVZp9+W/NTQMbGrng/k2iS8p88+T14LuJ0qPldkHCcGDFDiFaaMBEvcQ
         B8MqbN5jqEKJPFHCJ/bJLUbG3PqigRD8u8nijTHdgwqDVX4Y8lUAf8M+cMBA0KsipYMf
         GqtsaDFR+Ir8jAgHFqGyyMXZEt1DxSfFO1YBpIq15XImxFqcNPPA7GBScz9GYwEprq0S
         Gb+tiXPym3QbeXbS4LCzM7iwvJHDtFwzQ77WIZurnllbg7E1Pj0f/zJPL/nWdIL2s1cb
         WefW950aH9UKACxXS9r0MeICEIjCmTLAt3mg1r6A52TGcU8hXVEKfS+QIX5zycK9dCvW
         Y+5Q==
X-Gm-Message-State: AOUpUlG/mCozXi1K8fHBYqZJrxOZKB3mKSMaNMAip5nc4njG6hBaadxM
        15gk/6Ti06LaDt0htps2VmGPNWgXqrE=
X-Google-Smtp-Source: AA+uWPwB0G2xrOs3z277l8M1bm1/8geXVl11HsSJWNUGdcpatFb+FV9AAwUW8Q2ETmwTU5ZV+K0MYw==
X-Received: by 2002:a65:6104:: with SMTP id z4-v6mr4491374pgu.361.1533775550439;
        Wed, 08 Aug 2018 17:45:50 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 64-v6sm12469793pfi.89.2018.08.08.17.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 17:45:49 -0700 (PDT)
Date:   Wed, 8 Aug 2018 17:45:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] submodule: create helper to build paths to submodule
 gitdirs
Message-ID: <20180809004548.GA219777@google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-2-bmwill@google.com>
 <CAGZ79kYvM5hxbe9ZCuFt=Cgv9W0mmdwdFGJz6+DdhPv4UbEXjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYvM5hxbe9ZCuFt=Cgv9W0mmdwdFGJz6+DdhPv4UbEXjQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Stefan Beller wrote:
> On Wed, Aug 8, 2018 at 3:33 PM Brandon Williams <bmwill@google.com> wrote:
> >
> > Introduce a helper function "submodule_name_to_gitdir()" (and the
> > submodule--helper subcommand "gitdir") which constructs a path to a
> > submodule's gitdir, located in the provided repository's "modules"
> > directory.
> 
> Makes sense.
> 
> >
> > This consolidates the logic needed to build up a path into a
> > repository's "modules" directory, abstracting away the fact that
> > submodule git directories are stored in a repository's common gitdir.
> > This makes it easier to adjust how submodules gitdir are stored in the
> > "modules" directory in a future patch.
> 
> and yet, all places that we touch were and still are broken for old-style
> submodules that have their git directory inside the working tree?
> Do we need to pay attention to those, too?

This series only tries to address the issues with submodules stored in
$GITDIR/modules/ and places in our codebase that explicitly reference
submodules stored there.

For those old-old-style submodules, wouldn't the absorb submodule
functions handle that migration?

> 
> 
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 8b5ad59bde..053747d290 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> 
> > @@ -577,7 +578,7 @@ cmd_update()
> >                         die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
> >                 fi
> >
> > -               if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
> > +               if ! $(git config -f "$(git submodule--helper gitdir "$name")/config" core.worktree) 2>/dev/null
> 
> This will collide with origin/sb/submodule-update-in-c specifically
> 1c866b9831d (submodule--helper: replace connect-gitdir-workingtree
> by ensure-core-worktree, 2018-08-03), but as that removes these lines,
> it should be easy to resolve the conflict.

-- 
Brandon Williams
