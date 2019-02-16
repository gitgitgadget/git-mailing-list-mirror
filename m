Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8C41F453
	for <e@80x24.org>; Sat, 16 Feb 2019 06:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfBPGXw (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 01:23:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40013 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfBPGXv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 01:23:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so9631944eds.7
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 22:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3k+s9b/n6kCznEml1HBDRIqxllE0vKC9DK5kiAUgTs=;
        b=sha3HcYWvK+2CgdqY0BVvBozpbB4vH6tM+yuVGTE87e8i7rWnCxZ6tx1k/7YwLwhuk
         jLt8bIxsiMX8RJuttCI2xiQd7dgPaAOIGZx/vKNJPWwP4OrVHOKzPS3yxZaqB/L+Zgjo
         7N7P2GhcDyiFpGlCRBKzv9rJrYcxUDZilSMQXCg+Bxb2/zV8w709/3Gadko68ejWRayf
         cQ6ECYIN7eIRVlFZRAU4chcLgEIsZCutzDgKNI4lPCqI6NEQxgULeeg+7gfBhaEc8Qzk
         9w2OrKMsA8AFLs51rYF59EYbk4qk0viobKLUyC2pj/kSpZo/T6ghmYj/LdUeWeOlsOXE
         rx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3k+s9b/n6kCznEml1HBDRIqxllE0vKC9DK5kiAUgTs=;
        b=NbYvqjXVgy9NAAwvBA8pzwBJC/GcbXnybh7qaU4Aga7p1yioxnw28f5sQ+llrlKbH3
         ztl2HQy3N6NPj1Pj10Cf3Acil3PxvaIylzJWftNWHy/2zjGUaA6LPTLnC9L6gBmZATsb
         zDZOqR4obMVo+4LW5ldB+mRiIb7voYVfyFS15niXNX52Enu+MRrIYQiEEPpDw8UmtHCv
         PvCsFxauujbwYHSqSno+VQM+HVXDZ+arYmmFh6H5In557ZADjn+/a4zWGL5zmQADO0aF
         dauwSgpWQWkis+wwq2rrGqeFYIv86keVyi0UKIBSRQNKm0lGv9uSpqZ0oqA0V0RmPixe
         /BEw==
X-Gm-Message-State: AHQUAuYAj1h/Ck4l2ObvogsHs/J+DUmvReIrHM/8zNYSVDhhP40eULI7
        83MzyDGQFVkYiQF2ae1dayH/SS1c/m4sCn6iy4Y=
X-Google-Smtp-Source: AHgI3IZNr3Nco9dpHOOI4JbvjSkxPRoL1/Oe4f/P3py+5SscuzxHa3tWlN3EPxuW/IZmn6ORdJsBMW66ds1FrPTwohA=
X-Received: by 2002:aa7:dacd:: with SMTP id x13mr10581951eds.24.1550298229780;
 Fri, 15 Feb 2019 22:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20190215154913.18800-1-matheus.bernardino@usp.br> <20190215154913.18800-2-matheus.bernardino@usp.br>
In-Reply-To: <20190215154913.18800-2-matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 16 Feb 2019 07:23:37 +0100
Message-ID: <CAP8UFD1pFeV6wUPpqNHkYB_3m=HQYFssJzTSrhfsyg0p+svDgw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/2] clone: extract function from copy_or_link_directory
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 5:39 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Extract dir creation code snippet from copy_or_link_directory to its own
> function named mkdir_if_missing. This change will help removing
> copy_or_link_directory's explicit recursion, which will be done in patch
> "clone: use dir-iterator to avoid explicit dir traversal".

"which will be done in a following patch" is enough and perhaps even
better as the following patch can then be changed independently of
this one.

> Also makes
> code more readable.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

[...]

> +static void mkdir_if_missing(const char *pathname, mode_t mode)
> +{
> +       /*
> +        * Create a dir at pathname unless there's already one.
> +        */
> +       struct stat buf;

I know that the variable was already called "buf" in
copy_or_link_directory() and that there are a few other places in the
code where a 'struct stat' is called "buf", but in most places the
'struct stat' variables are called "st":

$ git grep 'struct stat ' '*.c' | perl -ne 'print "$1\n" if (m/struct
stat ([\w_]+)/);' | sort | uniq -c | sort -nr
    129 st
      6 sb
      3 buf
      2 statbuf
      1 st_stdin
      1 st_git
      1 statbuffer
      1 st2
      1 st1
      1 nst
      1 loginfo
      1 cwd_stat
      1 argstat

So I wonder if we should use "st" here instead of "buf". We also often
use "buf" for 'struct strbuf' variables which can be confusing.

Otherwise the patch looks good to me.
