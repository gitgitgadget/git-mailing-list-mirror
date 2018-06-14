Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F50B1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754966AbeFNT4c (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:56:32 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:35464 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754849AbeFNT4b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:56:31 -0400
Received: by mail-yb0-f171.google.com with SMTP id f79-v6so2689320ybg.2
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9CdAcUVQ5SYtLhYWtVYBwN0mukh8lDLSPwVxpSceao=;
        b=W0ymus7Dpt77imSYrBIOUi1CHeCCo0WjtNUhsH0aJlmUQATstcB023JEWBitV80w97
         68wTYsTeFhFgW4EaNVj/c4apr+/TRCgpMWTVJEaLXUjajlqdzfvWpOwxqgw+PGRqUNqM
         zudYlUXqsVetq/grTC7nKNXUP3AwzpIjK3elfc/Q4u4MbrONMfPECN1koC0RF/g0+arO
         +sSA1A5IYPua+wONKC8aK0d0hWxskIrbuf8Jye54SsNSwUI9sDYKxDHQ5U9y7jRtWnfo
         Seo11VoILsWs0eq43TsGRgpnmXmeZp6NvqSigcqxUuNaEfiy9vLe2XfmIu5kayOQAucl
         lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9CdAcUVQ5SYtLhYWtVYBwN0mukh8lDLSPwVxpSceao=;
        b=iwTxewUiUmBU4AD/av/gawqF463YyFVswWvoAnk1rNBfZM07D1nfQNZLRuC07tFGRu
         je8JzhPDkDidX//2J8FFW0BL49AhemYNAmfJ6JFkVRxGxD6T/KElLZsOTD/nuhglw5fF
         A7D3bhsoKUWKrG9vvUvpuiYkrl99Y6B/xWdIosUeF/L13/wUlA1MDC6prmru8bLXl6ZV
         JSoPdin6unfhNohnkUd7ICtyWEfIaVEN7m4Q4irSe78RRr+DC7+g0/TzsqL0nqkZC84f
         DlSsOrnCgPjvdXyMTWNbE/lMq/OtHrO7SFjgqSLTzEsrDmlMhm10CDGYRUiypHbgo7w7
         QD6g==
X-Gm-Message-State: APt69E2SJ9DVe7Mt9KC78aotXaXGBzXUtdw3uRw760XlCTQ1q4Mw21zu
        /3H0F++g1Idy9em9xXxKJVE7Aa1FGWpcq+naoS5haeaSnW4=
X-Google-Smtp-Source: ADUXVKKOfRlBDdwjbJz7NzWMS+ReXljt1/KoYFyFKuhbMv7Mpr11Tfw2UMwtPHNmBQF9/WhROw2GHRx8dgtO3nqJ47Q=
X-Received: by 2002:a25:e802:: with SMTP id k2-v6mr2283078ybd.292.1529006190622;
 Thu, 14 Jun 2018 12:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-9-bmwill@google.com>
In-Reply-To: <20180613213925.10560-9-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Jun 2018 12:56:19 -0700
Message-ID: <CAGZ79kZGV7NeYGpt=BJTASZYva3pyY-2CxMmDMXXxuZeg4sfjQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] fetch-pack: implement ref-in-want
To:     bmwill@google.com
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:

> +static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
> +{
...
> +
> +               for (r = refs; r; r = r->next) {
> +                       if (!strcmp(end, r->name)) {
> +                               oidcpy(&r->old_oid, &oid);
> +                               break;
> +                       }
> +               }

The server is documented as MUST NOT send additional refs,
which is fine here, as we'd have no way of storing them anyway.
Do we want to issue a warning, though?

    if (!r) /* never break'd */
        warning ("server send unexpected line '%s'", reader.line);



> diff --git a/remote.c b/remote.c
> index abe80c139..c9d452ac0 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1735,6 +1735,7 @@ int get_fetch_map(const struct ref *remote_refs,
>                 if (refspec->exact_sha1) {
>                         ref_map = alloc_ref(name);
>                         get_oid_hex(name, &ref_map->old_oid);
> +                       ref_map->exact_sha1 = 1;
>                 } else {
>                         ref_map = get_remote_ref(remote_refs, name);
>                 }
> diff --git a/remote.h b/remote.h
> index 45ecc6cef..e5338e368 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -73,6 +73,7 @@ struct ref {
>                 force:1,
>                 forced_update:1,
>                 expect_old_sha1:1,
> +               exact_sha1:1,

Can we rename that to exact_oid ?
(bonus points for also converting expect_old_sha1)

Thanks,
Stefan
