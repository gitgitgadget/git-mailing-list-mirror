Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED5BC43611
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 06:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD0961056
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 06:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhDAGAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhDAGAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 02:00:12 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC8C0613E6
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 23:00:10 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so1123137otq.8
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 23:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvAzkdDQADKl1jKgNYepCP4WMUGfKgvSG0yz2LRC180=;
        b=pFHtPzPDK74k+6c+PF0bbYHEhjnOlikpAP9K1qrY7JjuFooo2gojr/7+Q87briUuEY
         /3DTeXTGqsHwff2TsvBpejtu3GXJSFBgi29jUUBduwzCzKcQBmzQuSYr+JnCP6KsCN+a
         9HY/CRc5kT7HZtpEJbog0HUdOtXnWlqJQ8LuZuLdQxRpB9yBAyBo+p+/4VMFxu6WsMZV
         ywM1OyWz9gpSEFIYOphG0JzmqIj7NfthPAzH7L8kDK6TpBvQb3u09RQ0eDAMvt6WHlEe
         BrgmIT3CKmrMlgNyHVXiqYnfLwbYheVFFwdhu0BvDkT+OL4Wj3ElBtGyxIVlcX93fdnr
         FbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvAzkdDQADKl1jKgNYepCP4WMUGfKgvSG0yz2LRC180=;
        b=ko8djN1yyaVXUc3cIdrlaffqZwemBemGnC2df1VCgM72+dyfP81d0LkK6zdIMWsEvS
         2dfVJvuCZZ3HwCoXWxyPZbaic400MlDlWQziMcGT4gvTpNkbDI+8bc/juCEENrR/pUAe
         6MNet1CneQ/jIopjuD21i8Upn0IG7/qG/7MU8VoYHRCw65u1/ENYsCHY1g6dsAY8fbtT
         FUTzCvH56EWGwCPhSKomQGmmstX98NrZwAKPXwckQUvaYblL9Ui/oSRUFtBMGegF+b+E
         Knij5i9V3/1rXy/sc+shmoBOJe172WbKVA8FtXbdhCHmytyvma0NiTbNhxJsWgNvo9vT
         KGzg==
X-Gm-Message-State: AOAM531gx8jPxCiZwpkA/4wQPvAJW6oKB5EVmtMXMzJycHISOR9o63vk
        APsNj9+hX3P+RjGszZjmSRJ7ugcW+tv+qXNB9hA=
X-Google-Smtp-Source: ABdhPJwZ6SYxzRxtA0IjuJW8VEJAtALaghonBNI7T2/LrwFUAbIwXxuK8IaZqcmKPLHgAJJbR3l4IRPevYzNha+IqYg=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr5493682otf.316.1617256809687;
 Wed, 31 Mar 2021 23:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <pull.883.v5.git.1617109864.gitgitgadget@gmail.com> <xmqqsg4ccsgd.fsf@gitster.g>
 <0a2e3028-8ebe-86be-d55d-b96aefb1ee53@gmail.com>
In-Reply-To: <0a2e3028-8ebe-86be-d55d-b96aefb1ee53@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Mar 2021 22:59:57 -0700
Message-ID: <CABPp-BH5vxowVo3DP==EtpN+oTpW4jeD0CdWjbhpoxXFNhjfsw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Sparse Index: Design, Format, Tests
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 2:31 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/30/2021 4:11 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >>      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
> >>       +       * Initialize this as off.
> >>       +       */
> >>       +      r->settings.sparse_index = 0;
> >>      -+      if (!repo_config_get_bool(r, "extensions.sparseindex", &value) && value)
> >>      ++      if (!repo_config_get_bool(r, "index.sparse", &value) && value)
> >>       +              r->settings.sparse_index = 1;
> >>        }
> >
> > It would be helpful to have a way for the repository owner to say
> > "Even if the version of Git may be capable of handling 'sdir'
> > extension, and my checkout uses sparse-cone settings, I do not want
> > to use it", and the other way around, i.e. "Even if my checkout
> > currently does not use sparse-cone settings, do use 'sdir'
> > extension".  But for that, .sparse_index member may need to be
> > tristate (i.e. forbidden, enable-if-needed, use-even-unneeded)?
>
> I believe as presented, index.sparse=false will prevent the sdir
> extension from being used. If index.sparse=true, then it will only
> be used if sparse-checkout is enabled in cone mode.
>
> I don't see the value in using the 'sdir' extension when not using
> sparse-checkout in cone mode (and hence there are no sparse directory
> entries in the index). What am I missing?
>
> > We have a similar setting in index.version; I believe we always
> > auto-demote 3 down to 2 when extended flags are not used, and
> > I think "always auto-demote" would be sufficient (iow,
> > "use-even-unneeded" may not be necessary, even though that might
> > help debugging).
>
> Yes, the same is happening here: we auto-demote to not use 'sdir'
> if it the other settings are not configured as well.
>
> There is the rare scenario where these things all occur:
>
> 1. index.sparse = true
> 2. core.sparseCheckout = true
> 3. core.sparseCheckoutCone = true
> 4. Every path in the index matches the cone-mode patterns.
>
> In this case, convert_to_sparse() is called and the istate->sparse
> bit is set, telling do_write_index() to add the 'sdir' extension.
>
> This seems like a rare occurrence. Is it still worth adding logic
> to avoid 'sdir' when these are all true?

I'd agree that this would be very rare; probably indicative of someone
either having a bug in their sparsity patterns or making a simplistic
testcase to see how things operate.
