Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1211F405
	for <e@80x24.org>; Thu,  9 Aug 2018 07:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeHIKNk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 06:13:40 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:32980 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeHIKNj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 06:13:39 -0400
Received: by mail-pg1-f178.google.com with SMTP id r5-v6so2370797pgv.0
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JPsSbL6md/Ubg6XhzsCHYuObZ0Xx869EHh6vzKxbMhM=;
        b=gIw+ldr3xk2dkPSrquzbx+zByS/szXomDZ2Sfz1b4mUDR3p9eol9xZyDPFeo0UbaD/
         3qNgaeZBfS2Ex2NZKJD2TosOMzbbaJcm7LJN1V0MNCXXM0cc0ytRuRj/zE70OlopY9QG
         NDuEAiOrOMKwlu1yAaOcgwX3qFSdEzPkx1O3UOPhgiT/ltGPhtADtHdYc6ALh4TjCUfW
         8LtlXM9/VT92bTNgGwRD4JpvsqsW4XNJq3YJqHNCqWLZ2t0zMBpAv8Tle72SflkVNoJV
         XAlStAeiWhVuFuPSq01ArIpYAV/8uqPNOSWk+e13xD8Buwj7wxszG3kGmzo4hElCbK06
         S7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JPsSbL6md/Ubg6XhzsCHYuObZ0Xx869EHh6vzKxbMhM=;
        b=QwlmzxGToDB7OJznJIO/UgIfr+5/iP7z0pBUbBNPwrSytWkyp4PLUbowUDq0Twa2Vc
         FgKwMXSdSa8sK9LElWYrt2Qwn7Lnf1qCddlrn4vYd5ue5Y7xzrWjvgo7eWiK/yM78ic4
         IXY5sNknwx5rRL2DoWVkIA00VvDncg619kCGD441vPVyIfrcH/YJzsgnuLMpuvdIzVdi
         kECu/rCcVbTX62ylDJ+euzqttR4la7JBdVVDuUX7l9ryfVZdajIeHKhr7DfDpGegXR9s
         PevDBhj4cjlygzxfGbGgYS9wg7Rc02u5kGVPCU3LnKRMXBzzXhxZIWFQP9YrBKwor+PN
         k32Q==
X-Gm-Message-State: AOUpUlHz/Wv6IITWICYXHzlge9PERY040BVo66MwPzCSlWP8PBybIqJp
        AriBgYbci18bX24bE8yqSzfwapovA07X7ep/8/Q=
X-Google-Smtp-Source: AA+uWPz4miZzJzZg/mUtQtqp1fQkuJi0oN9wba/0p/humAYqVnIsVRBKy3EcPfqxKzwfkKW1pUaTao36QhCDB0gB12w=
X-Received: by 2002:a63:121a:: with SMTP id h26-v6mr1101608pgl.316.1533801003041;
 Thu, 09 Aug 2018 00:50:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:3541:0:0:0:0 with HTTP; Thu, 9 Aug 2018 00:50:02
 -0700 (PDT)
In-Reply-To: <20180808221752.195419-11-sbeller@google.com>
References: <20180808221752.195419-1-sbeller@google.com> <20180808221752.195419-11-sbeller@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 9 Aug 2018 09:50:02 +0200
Message-ID: <CAN0heSpsbYWzujzyteWuhto9DTXzvAkP+vt++d7ar3ob6Zx=Gg@mail.gmail.com>
Subject: Re: [PATCH 10/10] fetch: retry fetching submodules if sha1 were not fetched
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, hvoigt@hvoigt.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 August 2018 at 00:17, Stefan Beller <sbeller@google.com> wrote:
> Currently when git-fetch is asked to recurse into submodules, it dispatches
> a plain "git-fetch -C <submodule-dir>" (and some submodule related options
> such as prefix and recusing strategy, but) without any information of the
> remote or the tip that should be fetched.
>
> This works surprisingly well in some workflows (such as using submodules
> as a third party library), while not so well in other scenarios, such
> as in a Gerrit topic-based workflow, that can tie together changes
> (potentially across repositories) on the server side. One of the parts
> of such a Gerrit workflow is to download a change when wanting to examine
> it, and you'd want to have its submodule changes that are in the same
> topic downloaded as well. However these submodule changes reside in their
> own repository in their on ref (refs/changes/<int>).

s/on/own/

> Retry fetching a submodule if the object id that the superproject points
> to, cannot be found.
>
> Note: This is an RFC and doesn't support fetching to FETCH_HEAD yet, but
> only into a local branch. To make fetching into FETCH_HEAD work, we need
> some refactoring in builtin/fetch.c to adjust the calls to
> 'check_for_new_submodule_commits'.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

> diff --git a/submodule.c b/submodule.c
> index ec7ea6f8c2d..6cbd0b1a470 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1127,6 +1127,7 @@ struct submodule_parallel_fetch {
>         int result;
>
>         struct string_list changed_submodule_names;
> +       struct string_list retry;
>  };
>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }

`retry` will effectively be `STRING_LIST_INIT_NODUP`, but making that
explicit would be better and the next addition to the struct would be
easier to get right.

> +retry_next:
> +       retry_it = string_list_pop(&spf->retry);
> +       if (retry_it) {
> +               struct strbuf submodule_prefix = STRBUF_INIT;
> +               const struct submodule *sub =
> +                               submodule_from_name(spf->r,
> +                                                   &null_oid,
> +                                                   retry_it->string);
> +
> +               child_process_init(cp);
> +               cp->dir = get_submodule_git_dir(spf->r, sub->path);
> +               if (!cp->dir)
> +                       goto retry_next;

So here you just drop the string list item. Since it's NODUP, and since
the `util` pointers are owned elsewhere(?), this seems fine. Other uses
of `string_list_pop()` might not be so straightforward.

Just a thought, but rather than pop+if+goto, maybe

while ((retry_it = )) {
        ...
        if (!cp->dir) continue;
        ...
        return 1;
}

I haven't commented on any of the submodule stuff, which is probably
where you'd be most interested in comments. I don't use submodules, nor
do I know the code that runs them.. I guess my comments are more "if
those who know something about submodules find this series worthwhile,
you might want to consider my comments as well".

Martin
