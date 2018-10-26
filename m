Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89FE61F453
	for <e@80x24.org>; Fri, 26 Oct 2018 22:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeJ0Gj5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 02:39:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35795 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeJ0Gj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 02:39:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id e2-v6so2548582edn.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZMK4Z/Ae/tUc1B6auUkDZiLWPw/BG8oYhHasnTTZEg=;
        b=lJM8IkE9Hvndy/xPPao7c+w7Kl9HbzSmhBePzBH+XyP9MJNCiBImZHuRPsT6uZNqEd
         oQcJFvRTvgACwUVVx2unhhvxT6wKLorZGZwYS3TqAeyiJOLA/6OGKg8FkcQZOI7sG+PM
         IUO00jDGRPCFFdsjqxeQcHbbD/RzZghHGdGdlkwUwhUVDzcDDnI41UqOTG5Cb2Cx8r+U
         TyUOt4CZmeDEQjPZKhVnkAlNcI1jy8/MiqIHtKrfhDkcir1eXVM5h4sLAYlLEmHSzl78
         C3Rto7IzU3uapQNY6zPsWxGkiGscTHSgQdNssp3+FBb/Y11sXfU/NZ1KTcTBii/OaQVi
         yDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZMK4Z/Ae/tUc1B6auUkDZiLWPw/BG8oYhHasnTTZEg=;
        b=AqVxU4slzCC/msP36vZKp3i+iwXX24Vo4abPcb3/5nqaLTnvuF2ibXyuptutr9e1ES
         6DCmvSQhKyjd0cdBhokyd0j9xF69aYyinw4nutjLVQOW8Ejz/zEy73mTRGN6r8jt2DuL
         uFn3x2UrVFWLDIX0jIiWznX5S4bmii/sjFD6qDodwRVG0sFh4EzihA7uEpRmVFsw1tHv
         RUT+K8Ba4gihHmWES0tKz8SZSS9jTuOqGPdn/zjalszsZXKRHhtoKBXRB3r90IgKiXQy
         aCelpFh/ICxTHmhSIWkrTnmlBjb9Er5Vkvgql897JoGcLp+bxyymkBIxRgLEeve3jTqv
         yxYA==
X-Gm-Message-State: AGRZ1gLy5E1nhieeDg6/jwgzHSNCrqcI3PhM6NUkwXk9zz+tIpDCRlRg
        O5jQK7ne6kdbwxQ4UyYZlLxqEWiFRDJqrzhOph1D4g==
X-Google-Smtp-Source: AJdET5djgoldN/NClfXr8SKPxOE6w5nrFMQ381PLiRkzP8aj5so9gAyk/Uin/1SLaHUgTTqb4y035gUSwkdbordPelA=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr180811eds.25.1540591272487;
 Fri, 26 Oct 2018 15:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181025233231.102245-7-sbeller@google.com> <20181026191553.108916-1-jonathantanmy@google.com>
In-Reply-To: <20181026191553.108916-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Oct 2018 15:01:01 -0700
Message-ID: <CAGZ79kYK57rtmYuKUfWsX0_AAMZJqu7UeL2_P=iKN-9LPRWnfg@mail.gmail.com>
Subject: Re: [PATCH 06/10] repository: repo_submodule_init to take a submodule struct
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 12:15 PM Jonathan Tan <jonathantanmy@google.com> wrote:

 [snip]

> The expected pattern.
>
> This patch looks good to me.

I'll take this as a "Reviewed-by"?

Thanks,
Stefan
