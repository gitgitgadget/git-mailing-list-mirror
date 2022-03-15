Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44884C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351924AbiCOVU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244702AbiCOVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:20:58 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937C55B3FE
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:19:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b4-20020a170902a9c400b001532ec9005aso110713plr.10
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6gymHlqqjMIMAUuG0wns+XDCD4p4gczoXtRICMNhq0w=;
        b=d46Yjyin2EhGUtWsmvhBDLM2naA0ruhuoSo8fvW6ibbqy9vCN6uK7W/cAX/bVGr95V
         2sIr2GxPG3Xl/mCNKAA0dQiBWz7NnxuxicqRZmQlf/HDIrGuoGsNiftNDg0/vP8MpH6j
         y8JgpjsOSKeyuKz+ObQBWca6CeXQzROCdjzKE2fdGDb2YirWRuV/EJQ1l495STNRWugi
         7LX1yY1q15Z7Ix7rNYN6GEcR73YEbewBMOvyyq5+hKoj7gCtyNjXFZN/5GAqTQoeKtBs
         X31Ex+cHvYOscQFP9AN6hP8RK6dDCi1nXQtnZbIXxQ0kZ3fCbxTOfNt7NM2w2uvE2kiu
         rnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6gymHlqqjMIMAUuG0wns+XDCD4p4gczoXtRICMNhq0w=;
        b=zX+CU88F5YWJ7adSanV1HngCRUVY6fF6tBtdH15P6JK6maWdiCiynKp9nztHOgIq4p
         +MIOIwwwUbCCQZpSzd2qDFBP0vHYzK4ZSWodBYVK+F7er3GtH7t1tGz3+dweKdfxOrpK
         9WUFX0fzm8w1RygPi2IHUl2sZBxnOU797bG8bPyZoMcT/wlbk/3MR00zrUIkJgAXh+Rn
         P1L6FsZHfxNle5+G5wmxlm9iP3L+MggOsgG3vnsgq+9i/fk81lOF5gCUX0UWYd+i4z4A
         3wlffBKovI/hY40ov24z4+3H1AZ35bqPa+juTaFSFchlkKVraRvudCyjDlrBVj74LGYm
         SKNA==
X-Gm-Message-State: AOAM532XvMx2mH2sqtePCGN+vY1hXFrGsiAWKYpy1NVAZkVzHH1lIUyo
        oW9y/mw9rWH5LS97H+oqDSYACi0okrP5Yw==
X-Google-Smtp-Source: ABdhPJzalSZD+0NUAzw7geDerFPPIBRLxQd7axIClr+iB+Tv1wkDrUl7ODcTrZrqgbf1eErKzIyHS4gozdW/2w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8385:0:b0:4f6:ef47:e943 with SMTP id
 u5-20020aa78385000000b004f6ef47e943mr31185023pfm.38.1647379185082; Tue, 15
 Mar 2022 14:19:45 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:19:43 -0700
In-Reply-To: <YjD9bgmy9ArubMoG@google.com>
Message-Id: <kl6lbky6ykuo.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com> <xmqqtuc6h83m.fsf@gitster.g>
 <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnh1bgr4.fsf@gitster.g> <kl6l4k45s7cb.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6l1qz9s6tu.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YjD7mWPEnm/0Evy1@google.com> <YjD9bgmy9ArubMoG@google.com>
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
From:   Glen Choo <chooglen@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Tue, Mar 15, 2022 at 01:48:25PM -0700, Emily Shaffer wrote:
>> > +static void set_hassuperproject(const char *sm_path)
>> > +{
>> > +	struct repository subrepo;
>> > +	char *cfg_file;
>> > +
>> > +	if (repo_submodule_init(&subrepo, the_repository, sm_path, null_oid()))
>> > +		die(_("could not get a repository handle for submodule '%s'"), sm_path);
>> 
>> Isn't the repo_submodule_init() fairly expensive? I think this is doing
>> a whole repo_init() call we would not otherwise be doing.... Is it good
>> enough to generate the config from sm_path, by using
>> strbuf_repo_worktree_path(), and simply be tolerant of the failure if
>> <sm-gitdir>/config doesn't exist?
>
> Ah, I was misreading the implementation of repo_submodule_init() and I
> see now that won't work. I guess it is fine to just invoke
> repo_submodule_init() then, unless someone has another idea.

Yes, it's difficult to avoid calling repo_submodule_init() because it's
hard to get the gitdir using just the path to the submodule in the
working tree (sm_path).

Are we particular about avoiding calls to repo_submodule_init()? I don't
recall hearing this as an objection before. If so, I'll keep this in
mind as I work on more submodule things.

As an aside, ensure_core_worktree() already calls repo_submodule_init(),
so this wouldn't be the first time "submodule update" calls
repo_submodule_init(), and a potential optimization might be to cache
the result in between invocations of repo_submodule_init().
