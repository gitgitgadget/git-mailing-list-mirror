Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DF8C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 04:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhLGEwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 23:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbhLGEwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 23:52:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103AC061359
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 20:48:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o20so51926658eds.10
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 20:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=mRrNFeA/SgyAEVXGs5fPUvEji1oQfs3aFFdD0Lt+q5k=;
        b=VGbed/x7kFsFdexmh2rnu6LzJJDocvJ9/Mi4a0tQ7Kjd8uWT2wjRuOA/ecmTGql65Y
         GP1twVznJCxyDhjoK82NLTOUZr+t1rhn0Y4N+1wyCQi6Ze4tR2AKEz5eSpRMOHLPQqMT
         c5ZAoKVdC6E4CWvhQO4ldBK18/2YnkT8X0mdg7PzqdDPLE58bGuFECv+pM/xY71l3mBa
         KNeLcU2RgeX1EMFZ8XhsJJMgQ0FDMVwtERTR7KN6WFeIoQpJshz1qJen6Si7rmv7gtgq
         uCBjpJ1Frudc5zFCW0X4FGvZHPRbjzqUdA/exTrDu52bl13XG9Bn2eildKqba3dHCERq
         zb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=mRrNFeA/SgyAEVXGs5fPUvEji1oQfs3aFFdD0Lt+q5k=;
        b=jYzKUNrJQnE3lnvPD30YdejzCrDQDApS1OdfaT2RZfDXZAvvTQAVZUMJC0nFumbw/1
         BP+U3DjdRrb2hcKfeJIfjuqthfXZ9Skn0fiNDjMLqtPq9VSShqsxx06IzXXdse6FN9a3
         hbm7BB/h5lkJhneQDoHeXSGQnJ02GTKM1PkLOdG4X4Dr72Eb6vVvzBOSyYIff8E0rnQK
         YBQInMqkLhkde/HYI/OH/qyr2d9WCzqArx3WiPExSEIua141UYeHt3hJ6qPnng4eRTYu
         GlpcyLIAK1QtWPDRslGxhxVl04BeLXIvKW7HgR7k7iF4By1TYZt/jxIsyoKBoFO/nKme
         JAnw==
X-Gm-Message-State: AOAM533yIpj0/s+NYgJ9KEEvBgWE/bHK4ZhXFzEfZF3wnAzUUr08vFMX
        vbWVE1/xvxk2G0pzmU4woCq8wgL/9r/PzQ==
X-Google-Smtp-Source: ABdhPJwHUINtRccWkh1nVJgCNqKYXWjNK7x5+e/F6bGKmgTvla3YdtP8qDfpsIpoBMGLn6U1J8zJcA==
X-Received: by 2002:a05:6402:4243:: with SMTP id g3mr5582605edb.284.1638852525211;
        Mon, 06 Dec 2021 20:48:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 29sm9273640edw.42.2021.12.06.20.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 20:48:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muSPE-0011Ge-8Y;
        Tue, 07 Dec 2021 05:48:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v5 4/7] repo-settings: prepare_repo_settings only in git
 repos
Date:   Tue, 07 Dec 2021 05:43:32 +0100
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
 <4d8d58c473b51cac6645a7d71336e995c1f3d28b.1638566165.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <4d8d58c473b51cac6645a7d71336e995c1f3d28b.1638566165.git.gitgitgadget@gmail.com>
Message-ID: <211207.86r1apow9f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Lessley Dennington via GitGitGadget wrote:

> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Check whether git directory exists before adding any repo settings. If it
> does not exist, BUG with the message that one cannot add settings for an
> uninitialized repository. If it does exist, proceed with adding repo
> settings.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  repo-settings.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/repo-settings.c b/repo-settings.c
> index b93e91a212e..00ca5571a1a 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
>  	char *strval;
>  	int manyfiles;
>  
> +	if (!r->gitdir)
> +		BUG("Cannot add settings for uninitialized repository");

nit: start BUG(), error() etc. messages with lower-case.

> +
>  	if (r->settings.initialized++)
>  		return;

Our config doesn't require us to have a repo, and most of what
prepare_repo_settings() is doing is reading global config.

I think that *currently* this won't break things, but e.g. if we ever
want to have "feature.experimental" or whatever change the behavior of a
a command that doesn't require a repository we'd need to untangle this
(currently everything it changes requires a repo AFAICT).

Perhaps this is fine, and if we ever need such a "global config" point
we should stick it closer to common-main.c...
