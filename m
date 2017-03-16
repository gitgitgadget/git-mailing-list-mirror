Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082A320323
	for <e@80x24.org>; Thu, 16 Mar 2017 23:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbdCPXZc (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 19:25:32 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35080 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbdCPXZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 19:25:30 -0400
Received: by mail-pg0-f54.google.com with SMTP id b129so32060344pgc.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oMHE6nKjVEfyQL8HdJwx22qxqfER+EigaOokoDb5mLI=;
        b=b+IFHMXEN8kbTFHZM+NxKLUuXadSp7yPIWkuKBNYICe2V6X717wzsQu3a1bRWa9Cvj
         7Kjsdg/LF7xNBuLfo7HE0OffBukMq9pQWSX6aBUz1DF5A7S9YfDxWMAxZFXcrDRZgL9s
         C3DFgn6hIcm1kElmTtL9iAa8tgi7Rw2ePjVATQagTZDnbVXzpxCW5lqOuz3vLeOHIUgN
         gRzKwGQh69TSU1Yb2JZH7lkNkMCKUfeuu+ZN75uCKoQrL6UdJTj6l6Nwz2l4lxz/3F3S
         nQoWbJkKaZcZ7SNoo8klF3y55UW1sa6IX6szRfstsftYt/pU4DYQhhniRvurMQGzLcsI
         7Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oMHE6nKjVEfyQL8HdJwx22qxqfER+EigaOokoDb5mLI=;
        b=sA5PaZbFAgRChtCc1ck3LCTlyUPhFwY5nV0jiGKW+KNH1N5K3KGpYHu8kv895QA1W1
         1mHdJB4hz/HdFP83eupeuaaae9/ybSrdiNKt4JKuQZm22tp4YMrEL23ZE3VQiYv40G7E
         6JuDIb4f3RYX8QEtq7r5Mquuq+mq4Qqn1gTwfmwe1Ee92/K/SCZ/tuCocrmYMCMCIS4L
         wKbcdUpDMMAAiTtSA0pQpQl5NX+fF+yG0j2ABqF9NwNlfWx6hJuvbxT7Xh2j/3yBiaxV
         xAcuwGHNyz82W6UJnxCAUqWTZp+RduOc3uyVWkdw7uJQs1iLEaGtIxmhx95UyHEAqcHU
         8qSQ==
X-Gm-Message-State: AFeK/H2qbLffbt/TRfc7Q9RJTtT3zquEPClVg9q6wbOIvtntH/Ft3QzvTYcHeR39taHL5S3HhVS3CuvaG1TN1M+s
X-Received: by 10.84.239.8 with SMTP id w8mr15737541plk.73.1489706696028; Thu,
 16 Mar 2017 16:24:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Thu, 16 Mar 2017 16:24:55 -0700 (PDT)
In-Reply-To: <20170316222952.53801-4-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com> <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Mar 2017 16:24:55 -0700
Message-ID: <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] submodule sync: skip work for inactive submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> Sync does some work determining what URLs should be used for a submodule
> but then throws this work away if the submodule isn't active.  Instead
> perform the activity check earlier and skip inactive submodule in order
> to avoid doing unnecessary work.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

> +               # skip inactive submodules
> +               if ! git config "submodule.$name.url" >/dev/null 2>/dev/null

As a stand alone patch, this would look good to me.
But with the goal of this patch series in mind (which is to add
more options to enable a submodules "active" state), this
should rather be "submodule--helper is-active" here?


> +               then
> +                       continue
> +               fi
> +

The changes below here are just de-dented, no behavioral change?

>
> -               if git config "submodule.$name.url" >/dev/null 2>/dev/null
> +               displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> +               say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
> +               git config submodule."$name".url "$super_config_url"
> +
> +               if test -e "$sm_path"/.git
>                 then
> -                       displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> -                       say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
> -                       git config submodule."$name".url "$super_config_url"
> +               (
> +                       sanitize_submodule_env
> +                       cd "$sm_path"
> +                       remote=$(get_default_remote)
> +                       git config remote."$remote".url "$sub_origin_url"
>
> -                       if test -e "$sm_path"/.git
> +                       if test -n "$recursive"
>                         then
> -                       (
> -                               sanitize_submodule_env
> -                               cd "$sm_path"
> -                               remote=$(get_default_remote)
> -                               git config remote."$remote".url "$sub_origin_url"
> -
> -                               if test -n "$recursive"
> -                               then
> -                                       prefix="$prefix$sm_path/"
> -                                       eval cmd_sync
> -                               fi
> -                       )
> +                               prefix="$prefix$sm_path/"
> +                               eval cmd_sync
>                         fi
> +               )
