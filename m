Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5C21F406
	for <e@80x24.org>; Thu, 10 May 2018 18:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757454AbeEJS3U (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:29:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33084 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757401AbeEJS3O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:29:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so1780191plp.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d4JZLub/V4+d3q1cWlTx+Pmc5Cu94ixg6uz5czUzrbM=;
        b=vJgVkUtIF4dBptTHqRvpCZ//jZ4AjwylYjEoFemC4TIxMmH0j2KyBvgCEiPOCDxQmT
         8PIDm2G0iBCB+Mccj1T03gdgiJgjisbVsecgrTGMzCr7ukTia6uOT69O0KBHGQKBid4P
         +16GpKHQnHE+DZDkcwvBJjKyu5PEZP9n4NMC7g2SEIFzhrM+4nuF1oOuaVfxrNoMiGog
         QbMWFjNzd2DeHL3GPidLAZg8HguoAPqPwpxFA4llgsDTVz3eJSUm0xA1eBfXi6EeEeuB
         jrDa75xWi91YkIMh+TgZKkWTDTUmwRBBA0wLuNLp/wou+vTZEziXxu2ZitNmx3fSLI1t
         AyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d4JZLub/V4+d3q1cWlTx+Pmc5Cu94ixg6uz5czUzrbM=;
        b=d7wz+atnBLBD6ISHEC9UiuAFk/sQ40VPDf3lCceMEnSnsZoRJ/k9EeIe44npWHQuKX
         nxwMBfOb7oBrCDAZ3qg3hUbHgoL9w+u1mc2ciBvQJRx05/sguCKNJO9ZIfZh3+Bl9qPD
         jd0HFDQL+D/xhZlyJaXyF5CrsJbRj9/N9OJlFpYp1pIcCI6gVUS81myhS5fKvEKkS/y/
         M9YYBYAgWeFubvBejkuDpa9A5vl4ND2s+GjO3Zla6L1vPBUT2kZwqGNNwyoSz9KPGPST
         QiSj1I7eUX5NRCvcwjgiVq6EHYzLsAZkd2tU0bpIo4OYtByJ+3fDILmk6Uiae0chBUhn
         bTvg==
X-Gm-Message-State: ALKqPwd+LG6hU/o98eVkc5VdtHWwTWwdXlx5jK4zjqkU3YsdkXo+Klh2
        wWRVITpjxzmvOIpQhOaVQOptlWoQWi4Q16mtYgM=
X-Google-Smtp-Source: AB8JxZqs8UNPljpZSLtQh7ZLVjvYj2AqAWxHWI0Ea88nOj21j+ag0V4/C7ed45o5LLveFxO82EbG5VAn3FPBv8u+mO8=
X-Received: by 2002:a17:902:b94a:: with SMTP id h10-v6mr2390346pls.321.1525976953938;
 Thu, 10 May 2018 11:29:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 10 May 2018 11:29:13 -0700 (PDT)
In-Reply-To: <20180510173345.40577-5-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com> <20180510173345.40577-5-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 May 2018 20:29:13 +0200
Message-ID: <CAN0heSoaTdkb5xcrEE4dY7aUpcTGCROyUbZ-HUUKFBHJ9zTGew@mail.gmail.com>
Subject: Re: [PATCH 04/12] commit-graph: verify fanout and lookup table
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 19:34, Derrick Stolee <dstolee@microsoft.com> wrote:
> While running 'git commit-graph verify', verify that the object IDs
> are listed in lexicographic order and that the fanout table correctly
> navigates into that list of object IDs.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index ce11af1d20..b4c146c423 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -839,6 +839,9 @@ static int verify_commit_graph_error;
>
>  int verify_commit_graph(struct commit_graph *g)
>  {
> +       uint32_t i, cur_fanout_pos = 0;
> +       struct object_id prev_oid, cur_oid;
> +
>         if (!g) {
>                 graph_report(_("no commit-graph file loaded"));
>                 return 1;
> @@ -853,5 +856,35 @@ int verify_commit_graph(struct commit_graph *g)
>         if (!g->chunk_commit_data)
>                 graph_report(_("commit-graph is missing the Commit Data chunk"));
>
> +       for (i = 0; i < g->num_commits; i++) {
> +               hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> +
> +               if (i > 0 && oidcmp(&prev_oid, &cur_oid) >= 0)
> +                       graph_report(_("commit-graph has incorrect oid order: %s then %s"),

Minor: I think our style would prefer s/i > 0/i/.

I suppose the second check should be s/>=/>/, but it's not like it
should matter. ;-)

I wonder if this is a message that would virtually never make sense to a
user, but more to a developer. Leave it untranslated to make sure any
bug reports to the list are readable to us?

> +
> +               oid_to_hex(&prev_oid),
> +               oid_to_hex(&cur_oid));

Hmm, these two lines do not actually achieve anything?

> +               oidcpy(&prev_oid, &cur_oid);
> +
> +               while (cur_oid.hash[0] > cur_fanout_pos) {
> +                       uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
> +                       if (i != fanout_value)
> +                               graph_report(_("commit-graph has incorrect fanout value: fanout[%d] = %u != %u"),
> +                                            cur_fanout_pos, fanout_value, i);

Same though re `_()`, even more so because of the more technical
notation.

> +
> +                       cur_fanout_pos++;
> +               }
> +       }
> +
> +       while (cur_fanout_pos < 256) {
> +               uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
> +
> +               if (g->num_commits != fanout_value)
> +                       graph_report(_("commit-graph has incorrect fanout value: fanout[%d] = %u != %u"),
> +                                    cur_fanout_pos, fanout_value, i);

Same here. Or maybe these should just give a translated user-readable
basic idea of what is wrong and skip the details?

Martin
