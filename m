Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12529C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349622AbiCOUtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 16:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbiCOUtp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 16:49:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F01C135
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:48:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id t5so868060pfg.4
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mTjONuY59Vcp27led4q7qjadIECwovm17kyUVW3/xRQ=;
        b=iVRLR5dF7IeIkqdbnVF/44DCabvigYDu28RiTuse0N/2vl518+ZnuXR5PNXLE9LtX4
         8oPEhcqg/z7UyrMPAvMiERMt4lTFm6lNnHNn7kVWNsqinvOfAKl1tplY2FHCZ6nnU6f/
         V6O65mAzydjsMZyKSZTDle0Szllucm4ENybph/0jlxnU57J3+w8MGp48tUu8pW5Y+Bdn
         JR8iSP+c2elpxlx555lSOKComhDNTQebMHdvyOc0tYWQHPm4HDHjPoyPXq3a6dJgB9vS
         sSRzcZpVcE+rxpwEf7mi359Sd7bAKQO7U7cLISP1P4r2Po+HXDTSi3EJ2Ez45K2iRQnt
         oM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTjONuY59Vcp27led4q7qjadIECwovm17kyUVW3/xRQ=;
        b=IUV07ZOM1wBKwuCREUluScR9Qo3nk1iV8IlYixB3QrsujuRN06ELNJe4n0RZI3ZP4b
         StvgTjSy3ODqo797fOBHpVw2dy9dvbi0vn4M5lROS1XdTriSGMCaFLDsLevOwCfpAuzq
         g1WuevXZSooNoLIew4bY8aZnIhf4F77nBv5DQIFvQZbm7hooLz2+Sx77zlblrtV8zPm2
         DEefUebau4MmaXY8VnrHWfcSpHomb0hkgiv88/rehe3omIYzy1/EOUo1xpavLcn3PPot
         hi9vlUqT+qTUK5ROKe04OgV/P7/TNGDjJ0mmTkOS8q5Nv0qsE98KHw3JVweQ9zjepHGU
         XTnA==
X-Gm-Message-State: AOAM531DkUJLC0FZQx8dv6E3I5Ne0t4DCahFonopjiO/3brq4vqimEWg
        DgOVPpmRZ/ekkfmgmbwiZYUBXQ==
X-Google-Smtp-Source: ABdhPJw3FhDJ9+wBo66ubTWO202m7PGmltvkqlj9uGXjUia1p11MAxD3F4I1QuIthn3H5i+8cg3QCQ==
X-Received: by 2002:aa7:8256:0:b0:4e0:78ad:eb81 with SMTP id e22-20020aa78256000000b004e078adeb81mr30634560pfn.30.1647377310792;
        Tue, 15 Mar 2022 13:48:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:74b8:5024:28ce:c96e])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a660b00b001bf576cd2fasm82877pjj.37.2022.03.15.13.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:48:29 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:48:25 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
Message-ID: <YjD7mWPEnm/0Evy1@google.com>
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com>
 <xmqqtuc6h83m.fsf@gitster.g>
 <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnh1bgr4.fsf@gitster.g>
 <kl6l4k45s7cb.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6l1qz9s6tu.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6l1qz9s6tu.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 03:53:17PM -0800, Glen Choo wrote:
> 
> Glen Choo <chooglen@google.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> >>> index bef9ab22d4..f53808d995 100644
> >>> --- a/builtin/submodule--helper.c
> >>> +++ b/builtin/submodule--helper.c
> >>> @@ -2672,6 +2677,11 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
> >>>                                             &update_data.update_strategy);
> >>>
> >>>         free(prefixed_path);
> >>> +       /*
> >>> +        * This entry point is always called from a submodule, so this is a
> >>> +        * good place to set a hint that this repo is a submodule.
> >>> +        */
> >>> +       git_config_set("submodule.hasSuperproject", "true");
> >>>         return update_submodule2(&update_data);
> >>>  }
> >>
> >> That matched my tentative resolution I made last night, but what do
> >> you think about this part of the test added by the patch?
> >>
> >> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> >> index 11cccbb333..ec2397fc69 100755
> >> --- a/t/t7406-submodule-update.sh
> >> +++ b/t/t7406-submodule-update.sh
> >> @@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
> >>  	)
> >>  '
> >>  
> >> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
> >> +	(cd super &&
> >> +	 test_unconfig submodule.hasSuperproject &&
> >> +	 git submodule update &&
> >> +	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject
> >> +	)
> >> +'
> >> +
> >>  test_done
> >>
> >> We go to "super", make sure that superproject does not have
> >> submodule.hasSuperproject set, run "git submodule update", and see
> >> if the configuration file in "submodule" subdirectory has the
> >> variable set.  It does not clear the variable from the submodule
> >> before starting, so the variable given to the submodule when it was
> >> cloned would be there, even if "git submodule update" failed to set
> >> it.
> >>
> >> I am wondering if it should do something like the attached instead.
> >>
> >> We
> >>
> >>  * clear the variable from "super" and "super/submodule"
> >>    repositories;
> >>
> >>  * run "git submodule update";
> >>
> >>  * ensure that "git submodule update" did not touch "super/.git/config";
> >>
> >>  * ensure that "git submodule update" added the variable to
> >>    "super/submodule/.git/config".
> >>
> >> Clearing the variable from "super" is technically wrong because the
> >> repository is set up as a submodule of "recursivesuper" and if we
> >> had further tests, we should restore it in "super", but the point is
> >> that we are makng sure "git submodule update" sets the variable in
> >> the configuration file of the submodule, and not in the superproject's. 
> >
> > Yes, the test you've described is closer to what I thought the original
> > test was trying to do. Seeing this test pass gave me a false sense of
> > confidence hm..
> 
> Correction, seeing the _original_ test pass gave me false sense of
> confidence.
> 
> >> With the conflict resolution above, this "corrected" test fails and
> >> shows that superproject's configuration file is updated after "git
> >> submodule update".
> >>
> >> This series alone, without your topic, this "corrected" test fails,
> >> and that is where my "are we sure we are mucking with the
> >> configuration file in the submodule"? comes from.
> > - Set the config in the submodule even though we are running from the
> >   superproject (this is possible, ensure_core_worktree() does this).
> 
> If it helps, I was able to do this up by copying
> ensure_core_worktree(), and this passes the amended test.
> 
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4d02dd05ca..3bb7a65762 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1838,11 +1838,6 @@ static int clone_submodule(struct module_clone_data *clone_data)
>     git_config_set_in_file(p, "submodule.alternateErrorStrategy",
>               error_strategy);
> 
> -	/*
> -	 * Teach the submodule that it's a submodule.
> -	 */
> -	git_config_set_in_file(p, "submodule.hasSuperproject", "true");
> -
>   free(sm_alternate);
>   free(error_strategy);
> 
> @@ -2560,6 +2555,20 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>   return update_submodules(&suc);
> }
> 
> +static void set_hassuperproject(const char *sm_path)
> +{
> +	struct repository subrepo;
> +	char *cfg_file;
> +
> +	if (repo_submodule_init(&subrepo, the_repository, sm_path, null_oid()))
> +		die(_("could not get a repository handle for submodule '%s'"), sm_path);

Isn't the repo_submodule_init() fairly expensive? I think this is doing
a whole repo_init() call we would not otherwise be doing.... Is it good
enough to generate the config from sm_path, by using
strbuf_repo_worktree_path(), and simply be tolerant of the failure if
<sm-gitdir>/config doesn't exist?

Otherwise, this is a good workaround I think. Thanks.

 - Emily
