Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FABC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhLPVyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhLPVyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:54:17 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D44C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 13:54:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i7-20020a63a847000000b0033f17aba23aso178119pgp.9
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lheWgYqMjmvFnx3yrrUy7Q5HdWKSxPs0ULWWZmj5YAo=;
        b=m5ojzXl1u9tM3CVhekn/iJaMlzMP9VHSgLioqoOtPCHpF2Qyj/14cWJqHLudpHF0rm
         k/gaVH80m9E66cppE4RICfbkG5In2neEIHG4lQcvFouKX0hqvs1gxWrsv7X6w1PBnjma
         hvXHzdpXkzPVJ+rT5Zdt1YcKFnwQTauQsqXxXUV751S6sY0lgnHyiGTpM4lM5aGEUim9
         351L8IZa1RRyz+/eAmtjxXxrpYR140J/rfjuizRE8EyPVbCb+S2xEXiCoCXyoXmT5F5F
         XsMew/WRJ9ZyAumwKYY8A9zAXXD1AL76ruWl/K0alNxmNzmWdwY/N0zHcItCVPziOFAi
         RNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lheWgYqMjmvFnx3yrrUy7Q5HdWKSxPs0ULWWZmj5YAo=;
        b=aE53Pn08WYWaxIzkG4yeYRP4W1j0e1CFvlyn7ZmfSC1guvjC9syeDcW/gZt/J56J4V
         qDcRRmwNw8qLb340Y/jpB/EQNHK47vHmfKdX7U5986qTZXl0bauJ5kOicjVrrhgBfuni
         FPNsX7pLEGHnIBODQWqrIaJpKELco1sKfxxqihXKCZu5AcQTkupV+i4ylJM/O9g7zJqm
         6DnC4WKL9LmDDLKLlZ7AqSLEQ22FPtPCURoEpttN8rO8gjNkOSfcGQc1XFR957hPuKUW
         gmsh5hZMzyGicVH9f53vX9FldHlHbaVMr8iTS0Y08kBA5iO4qOOFela3Mw/8AlAbx95u
         U1EQ==
X-Gm-Message-State: AOAM5323/0g+wcyO8OJn/EsXim6CCJNbEYh9xe9IHWulGzpDBNW8Hi42
        0mjTCM9vnrEW+5MHxi+IAfhuBpayUlVRvA==
X-Google-Smtp-Source: ABdhPJx+Bn9oyU91y4aGmv6jRDv/ctYo7tUnhK6hFr2CxoI9s2Ood8JDSwIBkkwlaCw5BpqUbbOQNRR2UkzBZA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2ab:b0:49f:997e:23e2 with SMTP
 id q11-20020a056a0002ab00b0049f997e23e2mr16038576pfs.22.1639691656868; Thu,
 16 Dec 2021 13:54:16 -0800 (PST)
Date:   Thu, 16 Dec 2021 13:54:15 -0800
In-Reply-To: <7c700890741116b1b20936784d22d5a9f3c081e8.1639509048.git.jonathantanmy@google.com>
Message-Id: <kl6lilvo8bco.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1639509048.git.jonathantanmy@google.com> <7c700890741116b1b20936784d22d5a9f3c081e8.1639509048.git.jonathantanmy@google.com>
Subject: Re: [PATCH v7 2/2] config: include file if remote URL matches a glob
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0c0e6b859f..9b3480779e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -159,6 +159,33 @@ all branches that begin with `foo/`. This is useful if your branches are
>  organized hierarchically and you would like to apply a configuration to
>  all the branches in that hierarchy.
>  
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
> ++
> +Note that unlike other includeIf conditions, resolving this condition
> +relies on information that is not yet known at the point of reading the
> +condition. A typical use case is this option being present as a
> +system-level or global-level config, and the remote URL being in a
> +local-level config; hence the need to scan ahead when resolving this
> +condition. In order to avoid the chicken-and-egg problem in which
> +potentially-included files can affect whether such files are potentially
> +included, Git breaks the cycle by prohibiting these files from affecting
> +the resolution of these conditions (thus, prohibiting them from
> +declaring remote URLs).

Putting myself in the shoes of someone who is unfamiliar with the
implementation, I think that this becomes clear if you read it enough
times (but also, I'm not a good reader), so this is ok.

It would be nice for this to be reviewed by someone who is _actually_
unfamiliar, though.
