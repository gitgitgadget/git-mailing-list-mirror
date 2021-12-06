Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB28C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 23:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377688AbhLFX53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 18:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhLFX52 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 18:57:28 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4367AC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 15:53:59 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id f7so8056204vkf.10
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epHWeSTlsw6EvHv7SUgh6VuCPJ7XZd9tmopFis6m6aU=;
        b=RIvPJ2piOTOU4CKAxwa9RPOBkqiFHetXvFxjeFsgIlo6OAiPMFBVTs4AtP6W2i3Ewz
         tcAP/4uRVboDdqPb+Q891nxAQ8Orq1uc6G4f7z3e2CC011ZDdeB2za5f+4tTUe2LQvXd
         F/vsiT4H70n2KoJfMfvFjbiXoFwE1aah3PcIyVfvys7NOT9Otr4jJ8V/PhcxLllLnUxU
         Fv+ugfivI5oTLODNmxnvRDgof6Ylqm9tSVqyRw8kDH6AHJFSWSeiRbA56wgSeoOscO9O
         V9P/xF9QwacLQzSjtwyBe9Uk5TulTTS7N31h/fub3O3FHmOu4ki1xLlG5qdLUeLDJ/7W
         LULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epHWeSTlsw6EvHv7SUgh6VuCPJ7XZd9tmopFis6m6aU=;
        b=E+oKZ0026fGv48zq19AS04prAcMY7SLvCS+FOU24TRFZ93A6HYsXrsECn6C0PGkWiN
         rxBSiL3fx/jnXOCOPuC2cJ+lesN9ETS70Ore+Vpj4vzuP1xvtdxbfMFFFL7Cnh9/C3Ab
         33Mry53DyfNTagZBvyoxXNnf4rncyanp6/1JEJoMDY1Sl1I7hwmXYwVePcA4scuaAxcx
         YMProqybLVZ/TQG0Moqd/kr/rIEYhiKPTIaDBpu98+5YlzZOII5vy/jqoypULFbGS98Z
         oWj/M6/td7dedS1gURrPrQ4uftCK9O9WkyFo1RNoZsWovdnq7pQPQE+GlV6xhfutaOxw
         aiBQ==
X-Gm-Message-State: AOAM530hTSrPwIelTCiQ2lCtyETKW4Hdg6raEen0GjKiLUxyA4q14LvA
        MsTsmTB0iWQ6xa3vO+XqWyhFdO4V0jmObAt1SoO/XdOwYx9vbG0F
X-Google-Smtp-Source: ABdhPJwIld8ZryaMNlz57njKtH3cYK2gXyMfBD5/9gQmaPX/k0YewJlWRJHmcQzqzVeAedwUmfBqoGrUK5NgcbSjwjY=
X-Received: by 2002:a05:6122:d9d:: with SMTP id bc29mr45710520vkb.14.1638834838321;
 Mon, 06 Dec 2021 15:53:58 -0800 (PST)
MIME-Version: 1.0
References: <001501d7eaf6$79d8e170$6d8aa450$@nexbridge.com>
In-Reply-To: <001501d7eaf6$79d8e170$6d8aa450$@nexbridge.com>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Mon, 6 Dec 2021 23:53:42 +0000
Message-ID: <CAFLLRp+yakYKxeGHjvg-8s-5QP8GqMeA5t+azfny=v6wtPPW2A@mail.gmail.com>
Subject: Re: [Question] Switching the URI from SSH to HTTPS for submodules
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Mon, 6 Dec 2021 at 23:10, <rsbecker@nexbridge.com> wrote:
>
> git@bitbucket.org:project/module.git
>
> When in SSH mode, clones are simple with --recurse-submodules doing what we
> want. However, we had to clone on a system where SSH was locked down and we
> could only use HTTPS. The form of the URIs changed rather radically:
>
> https://user@bitbucket.org/project/repo.git
>
> I'm looking for better practices than I used - I'm sure there is at least one.

AFAIK the existing `url.<base>.insteadOf` config option[1] deals with this...

[1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf

    $ git config --global url."https://user@bitbucket.org/".insteadOf
"git@bitbucket.org:"

If you don't want to set it globally (not a throwaway CI environment?)
then you can do it as a one-off:

    $ git -c url."https://user@bitbucket.org/".insteadOf="git@bitbucket.org:"
clone --recurse-submodules git@bitbucket.org:repo/project.git

But it isn't persisted into your repo config then, so subsequent
fetches won't work. You'd need to persist it using something like:

    $ git config url."https://user@bitbucket.org/".insteadOf
"git@bitbucket.org:"
    $ git submodule foreach --recursive 'git config
url."https://user@bitbucket.org/".insteadOf "git@bitbucket.org:" '

Maybe there's an opportunity to make that part easier?

Rob :)
