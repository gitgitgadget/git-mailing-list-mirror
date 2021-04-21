Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780BC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 04:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DD2613B0
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 04:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhDUEIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 00:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhDUEIw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 00:08:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C1EC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 21:08:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id z16so28499083pga.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 21:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PtPk0hPq1YjaZ9jD1/2cWm1r4Rq+zSyOI5uoGLUE6ak=;
        b=jVEk3t81jqgahQg0KBu0790ZV73MuV58p+igfFtOmWypdUB2hfil2V16rBbjRC2RCH
         oxVITmmHUobyRAlzn/064FbkN8ARb3i1Evk9J92HiXUi9GlGO+jy88jr6ZA+ve68coHj
         IbQI/AnbSpB/anyiHfKg8PQzB9pJScH+F8IRYUOO1bTMAiA0xV+xfh4sMUN9Z1C5XM7t
         KIwZierTQmYV0grCGi1ySUBm3+su6mhtv9s/2UKYDkNJ/xFmFKwZhv2xeQEv7NpSe7JC
         1JbgOuQ8MF7rv6focJyLYbg+plGb778wlLfcUzrTFVWbxf+Vgshy4x1pvQRSK4a9Jh1L
         kpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PtPk0hPq1YjaZ9jD1/2cWm1r4Rq+zSyOI5uoGLUE6ak=;
        b=uUcRMq+5jKeBjoakE0AmtVA9q1umV/eNSMqnI9Yk1YSUpDXhLfgUAGZCfArCbxAYfK
         Vx80sx/0I+nE3EAecRwDDeCrezS0fqQWmJh9+B1NBPePkoPRteFglZrPrFs56kATVK7j
         u/tNvdajhPQb0B1abjNeQld8tpR7pXvNZetdoiBk/W1CRVmyiUTaWFPpMvDdqRsptypR
         6vLid7Q+Ermc0E4O0f682z0A6xSi1rSj/6qbbU5CiF96suESQJd29FPlal23YhkjA9q/
         GSsTIaAXowyGog6mB5OoZBm9iAPIPxeOx7nYAfqDXm0sMSEbQ7TntKVLCFNizLLePlaA
         0msA==
X-Gm-Message-State: AOAM532/p8pDX6fBUlDZD64yrW8vRkZoJ7LBsii6YN3l873GWmiGC8dy
        LYLcskYfknhTU00jwaXpNWk=
X-Google-Smtp-Source: ABdhPJxyv64UfqFNS5qZ93u2SX75+vMWPsdH4Yc9rFFB2E/C05PChGqpd5B/lS7c1CL877ooSv8jIw==
X-Received: by 2002:a17:90a:f992:: with SMTP id cq18mr8712202pjb.7.1618978099958;
        Tue, 20 Apr 2021 21:08:19 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id j11sm410492pfj.182.2021.04.20.21.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 21:08:19 -0700 (PDT)
Date:   Tue, 20 Apr 2021 21:08:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 5/5] git-completion.bash: consolidate no-subcommand case
 for _git_stash()
Message-ID: <YH+lMZCg5cqniPaU@generichostname>
References: <cover.1618910364.git.liu.denton@gmail.com>
 <b4a9b0afa7ab28b701499982f5a8fc66eb7e19e8.1618910364.git.liu.denton@gmail.com>
 <xmqqk0ow4q7k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0ow4q7k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Apr 20, 2021 at 02:10:39PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > We have a separate if case for when no subcommand is given. It is
> > simpler to just consolidate this logic into the case statement below.
> 
> Hmph, I am not quite sure if the removal of the first case is making
> the code easier to follow.  Is this supposed to be a no-op clean-up,
> or is it fixing some bugs?

This is simply a no-op clean-up. I am on the fence about doing this
change as well so I can drop it on the next reroll unless someone has
objections.

> > It would be nice to complete remove the magic that deals with indices
> > and replace it with what was originally there,
> >
> > 	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
> > 	        subcommand="push"
> > 	fi
> >
> > but this gives a slightly incorrect completion. In the case where we're
> > attempting to complete `git stash -a <TAB>` we will get the subcommands
> > back as a respose instead of the completions for `git stash push`, which
> > is what we'd expect. We could potentially hardcode all of the short
> > options but that would be too much work to maintain so we stick with the
> > index solution.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 30 +++++++++++++-------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 7bce9a0112..060adc0ed7 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -3016,22 +3016,22 @@ _git_stash ()
> >  	local subcommands='push list show apply clear drop pop create branch'
> >  	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
> >  
> > -	if [ -z "$subcommand" ]; then
> > -		case "$((cword - __git_cmd_idx)),$cur" in
> > -		*,--*)
> > -			__gitcomp_builtin stash_push
> > -			;;
> > -		1,sa*)
> > -			__gitcomp "save"
> > -			;;
> > -		1,*)
> > -			__gitcomp "$subcommands"
> > -			;;
> > -		esac
> > -		return
> > -	fi
> > -
> >  	case "$subcommand,$cur" in
> > +	,--*)
> > +		__gitcomp_builtin stash_save
> > +		;;
> > +	,sa*)
> > +		__git_init_builtin_opts stash_save

Also, I just noticed upon re-reading this patch that this is some
leftover cruft. But moot point since I'll be dropping this patch.

> > +		if ((cword - __git_cmd_idx == 1)); then
> > +			__gitcomp "save"
> > +		fi
> > +		;;
> > +	,*)
> > +		__git_init_builtin_opts stash_save
> > +		if ((cword - __git_cmd_idx == 1)); then
> > +			__gitcomp "$subcommands"
> > +		fi
> > +		;;
> >  	list,--*)
> >  		# NEEDSWORK: can we somehow unify this with the options in _git_log() and _git_show()
> >  		__gitcomp_builtin stash_list "$__git_log_common_options $__git_diff_common_options"
