Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130B31F404
	for <e@80x24.org>; Fri,  2 Feb 2018 23:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeBBXsq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 18:48:46 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41444 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBBXso (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 18:48:44 -0500
Received: by mail-yw0-f194.google.com with SMTP id b129so14462602ywa.8
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5EZ78cC8C1bbVZV4Zx9LJDdsBIL5Qk+/TKj28PshF58=;
        b=PsapLcpIoBxBRIqbPn4U8XUePa32PDrBFCCj4ETGC1V23IgeFJEenpvOqFOCor692c
         K9XpkhX8RAhn/qxMOOMXOc5xU66Ev0E1JjF464g+/Fc2vybxRJtuBf8kYvySB5RvyjLG
         a/OZx7Ho4Lt+7y4zMS18XNsvdJOT1QttoeXxzC/5ZglJaTNxoSP8e9AVB6Zwu8GXwgRU
         LGuNzbvceo8XXZ/Ttks/FbYAra4Lc28T7rGY0/CQGpTlKVt5/k0bz9jXS7SIYHM5yYTA
         H+ssKiU8WXItN7omAE2f04aKbSMms7BspbQ2m9WkMZGbwT9eh+PT3o75XfjcBz+orNB/
         bvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5EZ78cC8C1bbVZV4Zx9LJDdsBIL5Qk+/TKj28PshF58=;
        b=OhBBqal1XHRlNDcfXgLb+qibjSGz+7e/F14sAVKc3xD2E/n87Rh8zo5S5VeGJTLi6A
         6r42Hups8uHUgOHp20yvorubtvNoxEad5PPdiQ0i3U3sdNvz5AZLo2N1LZ7RU5v1ium4
         8PQP+nZFZZO5iHQxOYyqxVBe28rzbzVAgh4U2kgYEt5FaQslHz+VE8ZTWVAl1DostKtn
         I0v8YpLhTOzsxxufba/iitQrezZ1wULHnU4rfsx7STGsEpMMrADUDFbs4jp6K8fhExj3
         5SMCLg3opPuhtt81HBSp3ekUHE4KhVD28f8nInd2sMMtOx3gGAoDvhj6t4e7jTeRGW4m
         8jVg==
X-Gm-Message-State: APf1xPCl8fI39HHxxclrHpUHNDvYt4zZliQTaC90fXAfZtRnM8ZENz2/
        KbLUfXbBWbRZQzqf/V9tIc3jz92e4nBJr73TC+RLExqYMuU=
X-Google-Smtp-Source: AH8x2270kPAV9Vp+A7Mv5we+s8fn+BwoSK6J4zhX2kLNzTMg12R9s1dLLMh4F6CwBEZcW2ubM9Sb7B91FL/NAlPKrUU=
X-Received: by 10.37.59.204 with SMTP id i195mr1956604yba.420.1517615323650;
 Fri, 02 Feb 2018 15:48:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 15:48:43 -0800 (PST)
In-Reply-To: <20180130232533.25846-16-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-16-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 15:48:43 -0800
Message-ID: <CAGZ79kYynYT9NWEDYx46MQXP0sufsUPH045nk+7jJ+ND7QPiog@mail.gmail.com>
Subject: Re: [PATCH v7 15/31] merge-recursive: make !o->detect_rename codepath
 more obvious
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> Previously, if !o->detect_rename then get_renames() would return an
> empty string_list, and then process_renames() would have nothing to
> iterate over.  It seems more straightforward to simply avoid calling
> either function in that case.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1986af79a9..4e6d0c248e 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1338,8 +1338,6 @@ static struct string_list *get_renames(struct merge_options *o,
>         struct diff_options opts;
>
>         renames = xcalloc(1, sizeof(struct string_list));
> -       if (!o->detect_rename)
> -               return renames;
>
>         diff_setup(&opts);
>         opts.flags.recursive = 1;
> @@ -1657,6 +1655,12 @@ static int handle_renames(struct merge_options *o,
>                           struct string_list *entries,
>                           struct rename_info *ri)
>  {
> +       ri->head_renames = NULL;
> +       ri->merge_renames = NULL;
> +
> +       if (!o->detect_rename)
> +               return 1;
> +
>         ri->head_renames  = get_renames(o, head, common, head, merge, entries);
>         ri->merge_renames = get_renames(o, merge, common, head, merge, entries);

So this pulls the condition out and we just do not call get_renames.
Makes sense as then we also do not allocate memory for the stringlists
in get_renames

Reviewed-by: Stefan Beller <sbeller@google.com>
