Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85542C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6905D60EE9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbhIXRMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbhIXRMx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:12:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB9C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:11:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dj4so38745878edb.5
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QqScbUOLI457tBntqnD3JJm6ZO2LhlzIVrl7T/mbsRM=;
        b=NMdMh4BNrfBPhwHcvWDzAWgRbdHsEX9H5Jlm40LPlmhvd/tFkw58QHMHGrbz7KWfFN
         K7nORVZEWUCngMAVyYV48ITXtqrV/rY+y8Zz/lLGPR/EprNr2plUgU5LwMllRuB1r5EY
         eZ/c7QAekAJ7wY9VS+GrZrZS1wQtV26IxK9CDsdKFdeocbW3all9qfO3LcQxya495lac
         J/ZDvFYxm6XFPfttuKPi3LKX6xHq7VUPQnbNhJmxiGj2P7tat3jRI/BT9K9jjflBzblN
         rqHo3DNb6A9Q4agG3HLiPvEDV9iROVjS2izNCvm8cGDkTWG+iIaEBRYqfWct27YTlI40
         2fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QqScbUOLI457tBntqnD3JJm6ZO2LhlzIVrl7T/mbsRM=;
        b=7MBhWdDG20YbsmDSwdNrvPGPM9fSTkzSHOdnflhSHtpyV0niuNt/rII0M0BNJMq9n5
         UedUNsdXDyuMaBDGPzk2ASheI5uIBZ0pbh2uzAGB2J5tngNKVZQvgX99u9DJRuv3EKWw
         TAnUFR2klMZ48KCKCklli4fjHTTfAhx+c17OWZ/6m6IZyF0rBePQPrriSg61q/5CuCZG
         mKNxpGEA2OI4cPMahaZnnSxRKS3Ov94Ec57/HBQH0wrxZqADMtSwk4idepV1PMAOvTRW
         9osndhwfmJdZ4wKWjY4o4cvHy56Q2tl7Ca515QLi8x6JwJ19cc5U0dvgwfg3DVV+LPjB
         dtIQ==
X-Gm-Message-State: AOAM532CkLk10X6H8afgB/dp9YA2WWtl3qURFqXdrwHe9wiqp0A0YNwq
        qYp1535LjV7p391TMRwDhWM=
X-Google-Smtp-Source: ABdhPJyu3vCDN9oNR335i7GJOVtVAVfX2bEhGQM5eZK/2i0yxo8koQ0wTSQ7+bCk9Wm1TdYgKsLwSA==
X-Received: by 2002:a17:906:dbf0:: with SMTP id yd16mr12293517ejb.445.1632503478777;
        Fri, 24 Sep 2021 10:11:18 -0700 (PDT)
Received: from szeder.dev (94-21-23-109.pool.digikabel.hu. [94.21.23.109])
        by smtp.gmail.com with ESMTPSA id la1sm5364818ejc.48.2021.09.24.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 10:11:18 -0700 (PDT)
Date:   Fri, 24 Sep 2021 19:11:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Subject: Re: [PATCH 2/3] ls-remote: remove documentation for custom -h option
Message-ID: <20210924171113.GA3311029@szeder.dev>
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
 <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
 <patch-2.3-32b8dbecfe0-20210924T164820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-32b8dbecfe0-20210924T164820Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 06:51:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
> The custom handling of the "-h" option was broken in
> ba5f28bf79e (ls-remote: use parse-options api, 2016-01-19), first
> released with Git v2.8.0. We've been promising that it's a synonym of
> --head, but it's not.
> 
> We could make this work again by supplying the
> PARSE_OPT_NO_INTERNAL_HELP flag to parse_options(), but if we were
> writing this command today we wouldn't make this an exception. Since
> it's been such a long time let's just remove this rather than
> restoring the exception to "-h" handling.

This breaks the case when '-h' is used in combination with a remote:

  $ git ls-remote -h origin
  225bc32a989d7a22fa6addafd4ce7dcd04675dbf	refs/heads/maint
  ddb1055343948e0d0bc81f8d20245f1ada6430a0	refs/heads/master
  4c38ced6901a8523cea197b31b2616240ec9fb6e	refs/heads/next
  ee03ddbf0ea6a78ad9a229bd029408bbff85232e	refs/heads/seen
  687d33056ee28fd03567f3725150e3fcd0582979	refs/heads/todo

> Reported-by: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 1 -
>  builtin/ls-remote.c             | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 492e573856f..6e241640bd9 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -21,7 +21,6 @@ commit IDs.
>  
>  OPTIONS
>  -------
> --h::

The description of this option contains the following:

  Note that git ls-remote -h used without anything else on the command
  line gives help, consistent with other git subcommands.

>  --heads::
>  -t::
>  --tags::
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index f4fd823af83..c5e68918b78 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -64,7 +64,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			   N_("path of git-upload-pack on the remote host"),
>  			   PARSE_OPT_HIDDEN },
>  		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
> -		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
> +		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
>  		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
>  		OPT_BOOL(0, "get-url", &get_url,
>  			 N_("take url.<base>.insteadOf into account")),
> -- 
> 2.33.0.1285.g7aff81f6560
> 
