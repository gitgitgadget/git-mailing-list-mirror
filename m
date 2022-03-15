Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA297C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 20:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348006AbiCOU5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiCOU5d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 16:57:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DB2483A5
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:56:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t5so894760pfg.4
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jf5z07wVWGrKW+1wB/9Q+CgQyakLpdz+W/g/flOhujQ=;
        b=cRuo0rzBO6Fi+ew8LSpA+I5rlakH6pDBmlMmhhJKLta3wlnAsN549JdqgEEOycQ7vm
         XyRvA8lKIcAFAy2BjqQM22UMvyBxBat9OoETHJprVBLbuQBcgbAz81lZJnPMVw+oI2/H
         O/qwDR5D0prFTiimhK+wav9bE/+9hiaOy72GJrsEAGNeACkkqEG+hA9NSiABpBwUO6Qs
         E42UY8EvEk4gK3oLh7bmOe6kNWPqdwb0zifkcS2r8knE/n8osa1RaZjJ0ox96MuY4EIK
         w+wHU4rqI3r/KShWZEVKyl64/EQ+yWog2QxnRDKJD0pvSkaaypdfglulv21aeU2ngaaS
         7V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jf5z07wVWGrKW+1wB/9Q+CgQyakLpdz+W/g/flOhujQ=;
        b=FvvtjZjCoNcdvmSBDYFn6bFJtheHbPr4JWsXW6lVKoaJnjyzlKQ8Z2+x8fwMY5LWdO
         As9SJ6sK7gFoGDAhvfuU/6VQZyJGe4tFd19B5hTlsAsq6Xfa90TmZ3AWm8TLGIiCJT5A
         zOiHhasusZ3cnxHym1VL3R12fOKtNe+YcKXABlgI4jATikraVdNim07s7y2wLmQigeTX
         H+5STZVQC4CG6OCr+4Aa9K0jAzwpB66O1k4Ia6dWzl6RBL8hjHCU8P4M+or55vqTzHBp
         bwJpcrx952WDHG9vRDOLEtO+VXlDQFGfVurOGn8sTy2gEiBlfgHdZxEjffkrLm7HLZmb
         bPWQ==
X-Gm-Message-State: AOAM533ahYVczUpr5/i1nCHb7UvYGVgDVClbQ/+4cOgTo5XJdIfSWOGo
        n4NP6NbiWvCK/P/8+Gs65yi/4AMWXvCIlw==
X-Google-Smtp-Source: ABdhPJwDPdfcQtsmdtK3NBC0u+RKRDSfdYKPXOIGSNrwobC4TE4/MPHgA8Uvg5bIlNF9qBqSyFwOnQ==
X-Received: by 2002:a65:6741:0:b0:380:5b69:cbc5 with SMTP id c1-20020a656741000000b003805b69cbc5mr25982954pgu.89.1647377780755;
        Tue, 15 Mar 2022 13:56:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:74b8:5024:28ce:c96e])
        by smtp.gmail.com with ESMTPSA id w21-20020a634755000000b00368f3ba336dsm105976pgk.88.2022.03.15.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:56:19 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:56:14 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
Message-ID: <YjD9bgmy9ArubMoG@google.com>
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com>
 <xmqqtuc6h83m.fsf@gitster.g>
 <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnh1bgr4.fsf@gitster.g>
 <kl6l4k45s7cb.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6l1qz9s6tu.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YjD7mWPEnm/0Evy1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjD7mWPEnm/0Evy1@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 15, 2022 at 01:48:25PM -0700, Emily Shaffer wrote:
> > +static void set_hassuperproject(const char *sm_path)
> > +{
> > +	struct repository subrepo;
> > +	char *cfg_file;
> > +
> > +	if (repo_submodule_init(&subrepo, the_repository, sm_path, null_oid()))
> > +		die(_("could not get a repository handle for submodule '%s'"), sm_path);
> 
> Isn't the repo_submodule_init() fairly expensive? I think this is doing
> a whole repo_init() call we would not otherwise be doing.... Is it good
> enough to generate the config from sm_path, by using
> strbuf_repo_worktree_path(), and simply be tolerant of the failure if
> <sm-gitdir>/config doesn't exist?

Ah, I was misreading the implementation of repo_submodule_init() and I
see now that won't work. I guess it is fine to just invoke
repo_submodule_init() then, unless someone has another idea.
