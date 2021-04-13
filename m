Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCFAC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663EE613B1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbhDMSF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244907AbhDMSF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 14:05:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA45C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 11:05:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso9437669pje.0
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1yflgOZO0lkIcyTf5Ci0FnLRDANn2xi2BbM/yPaTIig=;
        b=CqOII00Q9RolSwI0VBY9Prezk/Qxfko3JZZ3pJBKWKLRw/sT7DD/f6NLpTUwxG0arF
         nwYFGsXFpA7yGpY1R6HnuXyUiMJmqTn2yDUa7y2Gt5XeOSXElpLZgRqjVRdfFsQZJ4eK
         +ZDJBxx2hqfW/U4JLBm4OcyIQ/Yp2dqSdhA++Ezq/39l5V+Y018TFa2cMDgDYufnCu0+
         GCuMVMfbGXGIozXT043XiJSFsVr7a768bAy5u7SloNlg5kLAoneIJ2yFeuoUegktW9Sa
         nXGrXKyNq7tuxKAT0pq+AVAGPV6rfbSqEcHbrwuAe4WvzxjaOaO5DYsjYdg/FVxME8Aq
         nRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1yflgOZO0lkIcyTf5Ci0FnLRDANn2xi2BbM/yPaTIig=;
        b=Lc0Tt0VrwWtNm5odP1jDUJS4Q0lBPN5Gb9+7gHP0C8i1XUyjj2TPe63vmg7ss4ibGP
         TM0YTFfD86O2yRD93+IbfbwG4iD0pWJh39hPcaP/KdUXcIXe7IVY1RdiT5qtTPQe3Pm9
         coSVOEtCL3tuYfEXhBXrdnG4FfxN1FqFBLblrnm4CNq8PBzJ+2gasANmngNasexH5jZz
         KzhP3xsjaNG1N17X6ktDEokAbREjPZ0Df4455w+SV5B+QpfpYR3NMHthD824PTcvzFPi
         Tf67muuF6//+1Am1wqLLdf2FPJnD/iobX1QfQQCZ4sr5jm4kBMymgtvDNaNP6ecWStGB
         Owrw==
X-Gm-Message-State: AOAM533GUaPI3TpHelpbcKeqzMMYZZt6Ik451VBkkQJj4+WvYM27PgPz
        WYTugiHl31bpxnyWaiyii47uIaM3pbbWvg==
X-Google-Smtp-Source: ABdhPJwdxGWAjdevHhs+Bszi/NcFwr9LIx0AHJHf6p+P6FVBGYK3cDJhpE5CXMu4tBvnJI0bypA14w==
X-Received: by 2002:a17:90a:db4b:: with SMTP id u11mr1307785pjx.154.1618337107478;
        Tue, 13 Apr 2021 11:05:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f854:cc1c:b809:7daf])
        by smtp.gmail.com with ESMTPSA id v1sm2796540pjt.1.2021.04.13.11.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:05:06 -0700 (PDT)
Date:   Tue, 13 Apr 2021 11:05:02 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] config: add 'config.superproject' file
Message-ID: <YHXdTg8cm5yUWt5J@google.com>
References: <20210408233936.533342-1-emilyshaffer@google.com>
 <20210408233936.533342-3-emilyshaffer@google.com>
 <e19a250a-c4ca-fc32-83f9-a03aa03cd88a@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19a250a-c4ca-fc32-83f9-a03aa03cd88a@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 12:10:27PM +0100, Philip Oakley wrote:
> 
> On 09/04/2021 00:39, Emily Shaffer wrote:
> > Some configs, such as wrapper directives like gerrit.createChangeId, or
> > forthcoming hook configs, should apply to a superproject as well as all
> > its submodules. It may not be appropriate to apply them globally - for
> > example, if the user also contributes to many projects which do not use
> > the configs necessary for one project-with-submodules - and it may be
> > burdensome to apply them locally to the superproject and each of its
> > submodules. Even if the user runs 'git submodule foreach "git config
> > --local foo.bar', if a new submodule is added later on, that config is
> > not applied to the new submodule.
> >
> > It is also inappropriate to share the entire superproject config, since
> > some items - like remote URLs or partial-clone filters - would not apply
> > to a submodule.
> >
> > To make life easier for projects with many submodules, then, create a
> > new "config.superproject" config scope, which is included in the config
> > parse for the superproject as well as for all the submodules of that
> > superproject.
> >
> > For the superproject, this new config file is equally local to the local
> > config; for the submodule, the new config file is less local than the
> > local config. So let's include it directly before the local config
> > during the config parse.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> 
> Does this need an update to the `git config --show-origin --show-scope`
> capability?

It's included:

> > --- a/config.c
> > +++ b/config.c
> > @@ -3515,6 +3539,8 @@ const char *config_scope_name(enum config_scope scope)
> >  		return "command";
> >  	case CONFIG_SCOPE_GITMODULES:
> >  		return "gitmodules";
> > +	case CONFIG_SCOPE_SUPERPROJECT:
> > +		return "superproject";
> >  	default:
> >  		return "unknown";
> >  	}
> > diff --git a/config.h b/config.h
> > index 535f5517b8..b42e1d13eb 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -43,6 +43,7 @@ enum config_scope {
> >  	CONFIG_SCOPE_WORKTREE,
> >  	CONFIG_SCOPE_COMMAND,
> >  	CONFIG_SCOPE_GITMODULES,
> > +	CONFIG_SCOPE_SUPERPROJECT,
> >  };

> > diff --git a/t/t1311-superproject-config.sh b/t/t1311-superproject-config.sh
> > new file mode 100755
> > index 0000000000..650c4d24c7
> > --- /dev/null
> > +++ b/t/t1311-superproject-config.sh
> > +test_expect_success 'can --show-origin the superproject config' '
> > +	git config --superproject --add foo.bar baz &&
> > +
> > +	git config --list --show-origin >actual &&
> > +	grep -F "config.superproject" actual &&
> > +
> > +	rm .git/config.superproject
> > +'
> > +
> > +test_expect_success 'can --show-scope the superproject config' '
> > +	git config --superproject --add foo.bar baz &&
> > +
> > +	git config --list --show-scope >actual &&
> > +	grep "superproject" actual &&
> > +
> > +	rm .git/config.superproject
> > +'

 - Emily
