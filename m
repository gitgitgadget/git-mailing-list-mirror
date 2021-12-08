Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27F5C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbhLHT6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbhLHT6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:58:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D259C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:55:15 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id g14-20020a17090a578e00b001a79264411cso2191967pji.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=W5L8NQO4HqS3FRM8MReChCcEz+NpsFsME1nYOhHBb2Q=;
        b=aQlcXct4DkXMXE7PoyWTfE0AgRx00cD9doztLuoDK9MO9435hb1FY4QUtsxb9FvdJO
         6dFqqxAjlPn0LLvn2w741+IGNdblzDVQft1m5ITP5Qhig60t1+LUkqVAbgimkkpwOL+8
         u9tyApnHU/noPb3KbYyy25gTikZ405qsJCvevlD9fGWXw+wxk+xdEu0QAxJAt4rDWJsU
         CT0GrkvXhh7ZqEfwX8ccPNWH+boTfOWNCTAxAotZPAt6LuQrHLXyv5ndSy+Q+FtaEQ7z
         JCEEJ3uBxINO08jS0lboGUZQIBq4ZWf5BNH3zncszMXo7Nn934xTBbYm/kpLQH7wwISq
         8cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=W5L8NQO4HqS3FRM8MReChCcEz+NpsFsME1nYOhHBb2Q=;
        b=3OE0NUB9h631H60ZUSjeObs9UZ1PjZuyp3eBhhhh93tPdh4q7hMbqoWoSifBpgF9Hq
         cjAf5WGEIgpWwdyrmDj7nyNCR3xM/xwnF2nMUHf65kve9eZ/ITvpzaDW/5+FRsgAd+0Z
         pq93wQR6rrzjAIvTBOtwY3FPO8UFkjB8CANNXyfebyEiorhCPBw4ayvlT4rjq9fgnOmg
         m5ASxTFE0cY66H22ck4z0EQU7afaef94YWW7uLMys2e8COQRoGJCmbAH+q8YvmTAqL6s
         l/rBIOPtEsPyYCOHyWFGjk6IYp7nRnbPUhxXnytJpLbQeZ3dZzAf0alv/03vV2FZS8US
         RH6Q==
X-Gm-Message-State: AOAM5317BTpeyULHQhOASAQ7A1jytbg+Xi9sTjMNY8vWYxBidda7gd4r
        csceTT+Hd/TreWmftwFjIf4/2MYp0mGk4A==
X-Google-Smtp-Source: ABdhPJzIVzBk/bj46RhKEMtC8E7v8ex2z71Bu+GSTelixB0YfwvCHL/sk3SHxZstaDRzX/dwLnL3NLshVmBryQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4c4f:: with SMTP id
 np15mr9659895pjb.65.1638993314412; Wed, 08 Dec 2021 11:55:14 -0800 (PST)
Date:   Wed, 08 Dec 2021 11:55:12 -0800
In-Reply-To: <de2be06818781bbef29926c0e8e8981746242c60.1638919346.git.jonathantanmy@google.com>
Message-Id: <kl6lwnkean33.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1638919346.git.jonathantanmy@google.com> <de2be06818781bbef29926c0e8e8981746242c60.1638919346.git.jonathantanmy@google.com>
Subject: Re: [PATCH v6 2/2] config: include file if remote URL matches a glob
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0c0e6b859f..e0e5ca558e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -159,6 +159,22 @@ all branches that begin with `foo/`. This is useful =
if your branches are
>  organized hierarchically and you would like to apply a configuration to
>  all the branches in that hierarchy.
> =20
> +`hasconfig:remote.*.url:`::
> +	The data that follows this keyword is taken to
> +	be a pattern with standard globbing wildcards and two
> +	additional ones, `**/` and `/**`, that can match multiple
> +	components. The first time this keyword is seen, the rest of
> +	the config files will be scanned for remote URLs (without
> +	applying any values). If there exists at least one remote URL
> +	that matches this pattern, the include condition is met.
> ++
> +Files included by this option (directly or indirectly) are not allowed
> +to contain remote URLs.

Wondering out loud.. Reading this and =C3=86var's comment [1], I wonder if =
we
should make it clear to users *why* we choose to forbid remote URLs.

Since this series is setting a precedent for future "hasconfig:"
conditions (files included by "hasconfig:foo.*.bar" cannot contain any
"foo.*.bar" values), it would be useful to git developers to explain
*why* we chose to do this. And if we're documenting it for ourselves,
we might as well write it in the public docs. That way, users would know
that this is more of a guardrail (because it's simpler to understand
this way) than a hard limitation.

[1] https://lore.kernel.org/git/211207.86k0ggnvfo.gmgdl@evledraar.gmail.com
