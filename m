Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06298C4332F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1A3611F0
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbhKOXWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241558AbhKOXUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:20:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A9C048C8C
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:22:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k4so15618293plx.8
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7+TjG08MWZ8MI06WvNCyUQfLhRfI1YXTeBt5aCJmkfc=;
        b=dXLwo6jbeetgHmzJh+nYbM4020mm9ofKFiVuKGKu5cZUuTE28F0r+ZYR8tHarTP78j
         HVMXbbAHSCI03HaJ5ubimWIxeKR+P2bmOr/Jd5SXF8/QvnbjHaPcRCmcfDTYdpnnqJj+
         eiolf8lkXzgSiaoN8Oc10eGmS/PQMYgG/e+y98jTr+CkRRzkAMVvlTHeTngQPWa1o0D6
         ghdvdS9x0RTbC04WkLkZtfMH3FWmHc3Az6qzOl2KIJYTEADLmcbNzYRRS6bfjw1SN975
         WMEdqi2np2jN2aaPuqIi4uQwbv3+C4tw3pjg8hgTUxAi/69NriLgahYGmkU8xUq2DQwG
         kTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=7+TjG08MWZ8MI06WvNCyUQfLhRfI1YXTeBt5aCJmkfc=;
        b=bStiF8x39vgJuyoa3doSsG3Dwi+gUXMr7ecxLEOFhqjchuEYjioz8kajjdB0lTLCBj
         9L4Rw4/wwCs7UoKPyA09R+DE6kbIcUHOrJUQYHJJvBx6o+83Hp0wxTaa1JoMh/ySbHnF
         5HmoHGxExKLiMOszBqqI2voIEbAIh3OmwXT9CMHssEzMz6+ShAzWicmlANHSIyDPkvoD
         YtGNMisiMmjJKk0eiWye+mDMWWj2A3wTBiTpbuKRg32d7ZaKY4F/MMW0RAZEFvUOZaeM
         nY1oMAXYrmLK/K48GZ9X+6UZr7/hQfb0/SMg3C5OuDWXs5s269ioHWT1eeNT7NCM8euR
         9OBQ==
X-Gm-Message-State: AOAM532D8cHfxM12hZ0y7sdH4zvZd/6BLDmENj+Ah1DmeheOoZf5K6Ks
        sgSzMgeYMFIE1dmHZdbogYza48ZsMVhu3g==
X-Google-Smtp-Source: ABdhPJyO+LmS+ZjQ7Qb+lV0LLBZAX6n7eCTxkkEAHrbrcKqZR/eKD5c31K54SFoEjlmvfz+daR8jKA==
X-Received: by 2002:a17:90a:5d8e:: with SMTP id t14mr67785795pji.95.1637014974095;
        Mon, 15 Nov 2021 14:22:54 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:9bb:b2ac:3919:1528])
        by smtp.gmail.com with ESMTPSA id i10sm295463pjd.3.2021.11.15.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:22:53 -0800 (PST)
Date:   Mon, 15 Nov 2021 14:22:48 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
Subject: Re: [PATCH v3] branch: add flags and config to inherit tracking
Message-ID: <YZLduLeRlXKfPjtw@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <b9356d9837479914bcf9a265f52afe170be7e2e2.1634445482.git.steadmon@google.com>
 <87a6j6tbsv.fsf@gmgdl.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6j6tbsv.fsf@gmgdl.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.10.18 20:31, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Oct 16 2021, Josh Steadmon wrote:
> 
> > It can be helpful when creating a new branch to use the existing
> > tracking configuration from the branch point. However, there is
> > currently not a method to automatically do so.
> 
> There's no method to get *only* that config, but this use-case is why
> the "-c" option (copy branch) was added.
> 
> I haven't looked at this in any detail, but the seeming lack of mention
> of it in the commit message & docs makes me wonder if you missed that
> that option could do what you wanted (but granted, it does a lot more,
> which maybe you don't want).

Indeed, I did miss that option. Thank you for the pointer. I am
conflicted about whether or not we want to copy all the branch
configuration. Most of the options do seem useful to copy, but the
existing config values available for `branch.autoSetupMerge` are
strictly about setting up `branch.<name>.remote`, `branch.<name>.merge`,
and `branch.<name>.rebase`. Adding a new value here that additionally
pulls in all the rest of the config may be confusing. Alternatively we
could add an entirely new option, but then its interaction with
`branch.autoSetupMerge` would be confusing as well.

> But in terms of implementation can't this share more code with the copy
> mode? I.e. I'd think that this would just be a limited mode of that,
> where we pass some whitelist of specific config to copy over, instead
> the current "all the config" with "copy".

I will look into the copy machinery and see what can be reused in V4.

> And should these options be made to work together somehow? I.e. if you
> want to copy branch A to B, but copy tracking info from C?

I am skeptical of the benefit here, but I'm certainly willing to hear
arguments in favor.

The motivation for this series is for Git users (who are not necessarily
Git experts) to have a simple config they can tune to make reduce
friction for the use case of having large repositories with many
submodules (see Emily's discussion [1]). The idea is that we have many
people with a workflow where they'd have `submodule.recurse=true` and
`branch.autoSetupMerge=inherit`. When they checkout a new branch in the
superproject, branches would also be checked out in the submodules, and
appropriate tracking information would also be inherited so that they
can later `git push` without having to manually configure tracking for
every submodule.

This would be a very common operation for these users, and should
therefore require as little friction as possible. While I can see use
cases for your "copy A to B but copy tracking from C", it seems to me
that this would be a much less common situation, and is probably going
to be needed by Git experts who are capable of setting this manually
without relying on configs to make it the default behavior.


[1]: https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

> > [...]
> >  -t::
> > ---track::
> > +--track [inherit|direct]::
> >  	When creating a new branch, set up `branch.<name>.remote` and
> > -	`branch.<name>.merge` configuration entries to mark the
> > -	start-point branch as "upstream" from the new branch. This
> > +	`branch.<name>.merge` configuration entries to set "upstream" tracking
> > +	configuration for the new branch. This
> 
> Setting up ".remote" is what --tracke does, but doesn't it make sense
> for such an option to copy over any other config related to that area,
> e.g. also .pushRemote, as a user may have edited it since the creation
> of the copied-from branch?

Yes, .pushRemote and .mergeOptions both seem like they'd be useful to
copy here.

> Maybe, maybe not. But this & the above comparison with copy makes me
> wonder if we'd be better off with some mode similar to the matching
> regexes "git config", i.e. you could do a "copy" but only on a list of
> matching variables.
> 
> Then the --track mode could just be implemented in terms of that, no?

Using config matching to only copy portions of the branch config seems
overkill to me. IMO it would be better to get agreement for which of the
branch.<name>.* variables to copy, and then use that consistently for
all possible settings of `branch.autoSetupMerge` and
`branch.autoSetupRebase`. If that allows us to reuse the existing copy
machinery, then so much the better.
