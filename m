Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081621F42D
	for <e@80x24.org>; Sun, 20 May 2018 06:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbeETGeb (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 02:34:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39609 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeETGea (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 02:34:30 -0400
Received: by mail-lf0-f67.google.com with SMTP id j193-v6so19511460lfg.6
        for <git@vger.kernel.org>; Sat, 19 May 2018 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLy4XtkRHTnyHNZEnBM/lZ2PKxMtpEBwgwm8fgVLjpE=;
        b=p517T0KotOSfFIrWI5Pr9KS9gSGJGNZH3ethl48OtdU5ImVPOWyZfjyaNNjmPkBo0F
         CTAIK06UhjHoVGtjrX1kgbjcryY6vLEwylrQUZBAqXraUHRfcawDnI3MThpaQVRwr46D
         5HYg2zduG029TLdU17RYks0eb8knsQXM3Mt/OI/m6cWdgHnWJvte14vPjPY8IUO1zjPe
         wFPvPZU0cDmL9CyBTtC04GQqdgPwo4G12+cUYYYGmhyGFchT5nWgXzD48FAeOuK8XUmT
         xbJjNN7+xFxOSaSRtGy6Hpc7L5t8JGBs3/6kClxAi6Io8pO66ct9fVfswX8BE4lH1XbM
         S5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLy4XtkRHTnyHNZEnBM/lZ2PKxMtpEBwgwm8fgVLjpE=;
        b=XH2fLPJJB7qLCYcOa0Y/8rs2dDa6qn24uiXb5T8KxArm6Fp3RLB1ejo9vPkYDuAeDb
         yin9u9CMSGi/Su4bCtomL70KLZGm6DmhqpRpBmaCmnygaNHn9bsoNJ4A1YLApnu1jYFB
         w5K2ws7myD3w1i/r6L82ftGHEplFONdJCZSgjRsdGIYN8yRV/qw1RmvdUa+JAtoyiYxr
         MZqZtKDGYtu1lHVO3rPTcUcUgtt9PfTnmaP1LlG3yM0sbV9u+hdDr/23XnAFz0sxewED
         UM0A76UeSJoYmMvPDIDJxhrGucS53vMLoD9cUs21WpNAqPkO8CuV+VnIFQrN7WfImBsL
         xOIg==
X-Gm-Message-State: ALKqPwfvIxv67GEOy3mxYvn329jtD4k6JIXubRX0FfSycJaH1MObO5EM
        tUJEOlm8HuNgoloToUvS3nA=
X-Google-Smtp-Source: AB8JxZrOAf776dJjy3D4SsLv2h53rYto6uZrqSafEecRoVh4DAo5UezyU8J8+12PS11X5tVnjGehKg==
X-Received: by 2002:a2e:330c:: with SMTP id d12-v6mr9748794ljc.8.1526798069354;
        Sat, 19 May 2018 23:34:29 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r137-v6sm2776714lfr.17.2018.05.19.23.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 May 2018 23:34:28 -0700 (PDT)
Date:   Sun, 20 May 2018 08:34:24 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] apply: add --intent-to-add
Message-ID: <20180520063424.GA3062@duynguyen.home>
References: <20180513175438.32152-1-pclouds@gmail.com>
 <20180513175438.32152-2-pclouds@gmail.com>
 <xmqqo9hjc6er.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9hjc6er.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 11:33:48AM +0900, Junio C Hamano wrote:
> > diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> > index 4ebc3d3271..2374f64b51 100644
> > --- a/Documentation/git-apply.txt
> > +++ b/Documentation/git-apply.txt
> > @@ -9,7 +9,7 @@ git-apply - Apply a patch to files and/or to the index
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
> > +'git apply' [--stat] [--numstat] [--summary] [--check] [--index | --intent-to-add] [--3way]
> >  	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
> >  	  [--allow-binary-replacement | --binary] [--reject] [-z]
> >  	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
> > @@ -74,6 +74,13 @@ OPTIONS
> >  	cached data, apply the patch, and store the result in the index
> >  	without using the working tree. This implies `--index`.
> >  
> > +--intent-to-add::
> > +	When applying the patch only to the working tree, mark new
> > +	files to be added to the index later (see `--intent-to-add`
> > +	option in linkgit:git-add[1]). This option is ignored if
> > +	`--index` is present or the command is not run in a Git
> > +	repository.
> 
> It may make sense to make it incompatible with "--index" like you
> did, but how does this interact with "--cached" or "--3way"?  It is
> unclear from the above documentation.

I did check --cached and it mentioned about implying --index so I
thought that was enough. Will elaborate a bit more.

> > diff --git a/apply.c b/apply.c
> > index 7e5792c996..31d3e50401 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -136,6 +136,8 @@ int check_apply_state(struct apply_state *state, int force_apply)
> >  		state->apply = 0;
> >  	if (state->check_index && is_not_gitdir)
> >  		return error(_("--index outside a repository"));
> > +	if (state->set_ita && is_not_gitdir)
> > +		state->set_ita = 0;
> 
> I think this should error out, just like one line above does.
> "I-t-a" is impossible without having the index, just like "--index"
> is impossible without having the index.

I was hoping to put this in an alias that works both with or without a
repository. Do you feel strongly about this? I may need to find
another way to achieve that instead.
--
Duy
