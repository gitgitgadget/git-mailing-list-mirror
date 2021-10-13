Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD563C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE4461168
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhJMTlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhJMTlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:41:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A38C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:39:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t11so2519440plq.11
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pi4v499CFpaQMPoPFTxzuLzWkMWoI4vdWpjBuZ/HUJs=;
        b=iAvef4mK/goTSlHfzEV0y9zN7fndlXgEzJgBqoeG36GUOf/nG72DTeWAa4W8J0hmu8
         Nbx/jLARy9wFj7i8ILNo3Qv6+4Z4CYiEPk11ge1+Tbpn3sJUl8xkB0TwezfHTbhq2saa
         wHJdPbs3FUt0WjRD4T+flotN0vHmi3JLFroCzQqojYBjUGeodyfJocB2MlQ8rylQqF/X
         LadUidgIn7e1pdX5yElZ1PC6BKJzVR84X3/FrjIFypaoFqIv523jhi0yW0wSeWsiODnn
         5aNqjZCek5ub9Me3HWbmmMZzUybStfLEl9XNiUfew3hmgA9D0qjxddI2iFy3UYt0UL8Y
         j/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pi4v499CFpaQMPoPFTxzuLzWkMWoI4vdWpjBuZ/HUJs=;
        b=oxnna6zORndxna0roQD6+Fc7mP6TGJTWtb30QnanWx3+bLFseJwfcWpIN9zAUHGOkq
         NO9ySpdDSjVEbFopHTve461mahRuj0Wz9SYRSxwtwjwa7CIjpm+M6tHKCaSV7IHQpe54
         EqylO8utLFUn8Xj+igrEBHJZEnzDzBQ5fzRh3C5v+9tiIGZy6xR3ZXGdG/oqC6RoAo8d
         QEghCT9qwQiRsf2CWI7tKZSv9xGaeH2MdFbBcANScdLN4Ljbs7agdDAx6qMnt/TlavW0
         FyImh8UU03MT2w9L/VcdkPmgZ6LfiegcgYWUdrIb4ymmyaP3oR7nQsepRDeiVTtdpsdd
         HaeQ==
X-Gm-Message-State: AOAM530doJYWPCyUGQA8SMSnyM0J4zovvpfdofn+gPt56zCLuSIJrdDm
        DdJ281XE5L3t/ijwga80rdEJTw==
X-Google-Smtp-Source: ABdhPJxTVBKyRePIEmJgpk8j/rfWJB/GHPdW/fzU0PnTYe62gDxoRUyIa2JSDMmUrrDowC6fkRhouA==
X-Received: by 2002:a17:90a:430e:: with SMTP id q14mr15422696pjg.55.1634153953418;
        Wed, 13 Oct 2021 12:39:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3db2:597e:d036:ff3f])
        by smtp.gmail.com with ESMTPSA id p9sm293760pfn.7.2021.10.13.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:39:13 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:39:08 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/4] introduce submodule.superprojectGitDir record
Message-ID: <YWc13By8SnIw1mEV@google.com>
References: <20210819200953.2105230-3-emilyshaffer@google.com>
 <20210904172051.2858-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904172051.2858-1-matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 02:20:51PM -0300, Matheus Tavares wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index d55f6262e9..d60fcd2c7d 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1910,6 +1910,10 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> >  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
> >  					   error_strategy);
> > 
> > +	git_config_set_in_file(p, "submodule.superprojectGitdir",
> > +			       relative_path(absolute_path(get_git_dir()),
> > +					     path, &sb));
> 
> This will be executed when cloning a submodule with
> `git submodule add <url/path> <path>`. Do we also want to set
> submodule.superprojectGitdir when adding a repository that already exists in
> the working tree as a submodule? I.e., something like:
> 
> git init super
> git init super/sub
> [ make commits in super/sub ]
> git -C super submodule add ./sub
> 
> I don't know if this workflow is so commonly used, though... It may not be
> worth the additional work.

Yeah, I think it is covered in the next patch with 'git submodule absorbgitdirs'.

> 
> Another option, which I believe was suggested by Jonathan Nieder on the Review
> Club, is to change the code to absorb the gitdir when adding the local
> submodule. Then, the configuration would already be set by the
> `absorb_git_dir...()` function itself.
> 
> >  	free(sm_alternate);
> >  	free(error_strategy);
> > 
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index 4bc6b6c886..e407329d81 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -108,14 +108,18 @@ test_expect_success 'setup - repository to add submodules to' '
> >  submodurl=$(pwd -P)
> > 
> >  inspect() {
> > -	dir=$1 &&
> > -
> > -	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> > -	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
> > -	git -C "$dir" rev-parse HEAD >head-sha1 &&
> > -	git -C "$dir" update-index --refresh &&
> > -	git -C "$dir" diff-files --exit-code &&
> > -	git -C "$dir" clean -n -d -x >untracked
> > +	sub_dir=$1 &&
> > +	super_dir=$2 &&
> > +
> > +	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> > +	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
> > +	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
> > +	git -C "$sub_dir" update-index --refresh &&
> > +	git -C "$sub_dir" diff-files --exit-code &&
> > +	cached_super_dir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
> > +	[ "$(git -C "$super_dir" rev-parse --absolute-git-dir)" \
> > +		-ef "$sub_dir/$cached_super_dir" ] &&
> 
> To avoid the non-POSIX `-ef`, we could perhaps do something like: 
> 
> 	super_gitdir="$(git -C "$super_dir" rev-parse --absolute-git-dir)" &&
> 	cached_gitdir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
> 	test "$cached_gitdir" = "$(test-tool path-utils relative_path "$super_gitdir" "$PWD/$sub_dir")" &&
> 
> (We need the "$PWD/" at the last command because `path.c:relative_path()`
> returns the first argument as-is when one of the two paths given to it is
> absolute and the other is not.)
> 
> One bonus of testing the cached path this way is that we also check that
> it is indeed being stored as a relative path :)

Yep, that is what I settled on. Thanks.

 - Emily
