Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F2AC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjARV7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 16:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjARV7B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 16:59:01 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B03222C0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:59:01 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id q9-20020a17090a304900b00226e84c4880so156701pjl.4
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eO5+9UhFeVwJuBgxx0WBQwsgEzKYmqAs1PwM4xWATdg=;
        b=llhZujOF/XCjHamJRsfVl9yqNNqlx3ZjTcNkmDGXMEsgzMZTNXkVNTdGk/nbT1LgEX
         +aoVRuogyECoxul+3GLaM8JGPo55Opss2VcAdkzv4IXvuYbdYHOSEqzQu7sbGlrB9N4Z
         HoYr6TuIe3zYtLllIB4ZN+rrLkpO5a4IgoFMJx7IO3ESKiVf82OoIel4/r3KEiLveMBE
         yh2iuR7nIYphvpdCvPkYgDoPBEM501p5jMRgTotPcyTE+LMwtx0OaEF2X16t1BFgZDyC
         AWZmLGB/DEGsP9EnQxs2AwMUGrJx940e8f6yhS8ErZnUdPX3D2NDHuPF43r2AW1n5bzH
         uYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eO5+9UhFeVwJuBgxx0WBQwsgEzKYmqAs1PwM4xWATdg=;
        b=tVHf7aML6M9XV+KSCJc1azr52+SWKWWKEWwnpxNS84Y4c/dFb8Ka3+IylnW0B57gex
         ZwJLL90SVu9mnS/xfowWIKN2n12S2A3pftAX64RNA6jXEexm0keptrSczdf5zlpTZ2t7
         GzpVoKlgXs8LJQrSW0w0qtqVt2a1UuzZ8oxUhWWIbcCrq8bOZgCIYTmNnxlrRnHzHjos
         /PyclxbbfzbvT9QlrR5yY/IUK2mjIbtP9LoQVm2pba20wT0OVvgagSz/Y46ZN55p8QDN
         q53c0M/KvZfslG2KD1G85LWs3+aavxP6KK2bMU+9KsHtCXejUPLEMXiIc06AM6un48lK
         zVJw==
X-Gm-Message-State: AFqh2kpI7ygLjtKDm5Zr3K4mdAjGd6N4KnEqxyAK5LetvVDI0ReUjAew
        mvBqLix3oilPhZAXUdKD6qKWQIW2DDOufw==
X-Google-Smtp-Source: AMrXdXu7YiXIsybzzzOq1AmMGDsyVsbVGMDgPY7shF4xPpHvIHr/5Ac8KrS0Cpv6W3TOWMFP/dGnifWqXbFdhA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:1a48:0:b0:588:99cb:ac19 with SMTP id
 a69-20020a621a48000000b0058899cbac19mr755279pfa.61.1674079140271; Wed, 18 Jan
 2023 13:59:00 -0800 (PST)
Date:   Wed, 18 Jan 2023 13:58:42 -0800
In-Reply-To: <pull.1464.git.1673890908453.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1464.git.1673890908453.gitgitgadget@gmail.com>
Message-ID: <kl6lo7qvo67h.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] branch: improve advice when --recurse-submodules fails
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> 'git branch --recurse-submodules start from-here' fails if any submodule
> present in 'from-here' is not yet cloned (under
> submodule.propagateBranches=true). We then give this advice:
>
>    "You may try updating the submodules using 'git checkout from-here && git submodule update --init'"
>
> If 'submodule.recurse' is set, 'git checkout from-here' will also fail since
> it will try to recursively checkout the submodules.

Ah, yes that is true.

> diff --git a/branch.c b/branch.c
> index d182756827f..e5614b53b36 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -756,7 +756,7 @@ void create_branches_recursively(struct repository *r, const char *name,
>  				_("submodule '%s': unable to find submodule"),
>  				submodule_entry_list.entries[i].submodule->name);
>  			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
> -				advise(_("You may try updating the submodules using 'git checkout %s && git submodule update --init'"),
> +				advise(_("You may try updating the submodules using 'git checkout --no-recurse-submodules %s && git submodule update --init'"),
>  				       start_commitish);
>  			exit(code);
>  		}
>

Makes sense. Thanks!

Reviewed-by: Glen Choo <chooglen@google.com>
