Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ECEC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1667B20716
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcTA3ZQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbgHQR0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389828AbgHQRWk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:22:40 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0012C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:22:39 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z11so3566396oon.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Blz/gnMY8W7Ruq2qvReUdul8p5XMGS0EKqQk5ee02x4=;
        b=DcTA3ZQSm/dETIQzI6UFxDWgCjJztBXNqkR8IjG/+koevVZ8viQGvZiAHb+RDjfQfl
         oLad7LQv8aX3EfcBcN2J13DXTH+/f4ydx8RCcnusq9hAZJn72sh95WtJuR8zCOXbKIxy
         NCyWMpmyEm5VPlDWXP8V/aRlbtkYIzLsy67GSvRvs8HA5/OhbuJndma0/lu+jxSKdWZp
         tvrvpbBrrNT7Ys6a4NcRPapu5R0XCj1iWn7tjiCyZXycQHg/VppEILDpPbwXAv9JrFTN
         azL4+DsuvI1QSBW5yd7ZU5BAS571G+WxoVpDlhjpALAjsCGE0+63owNXbXQuY8K0QP0/
         yZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Blz/gnMY8W7Ruq2qvReUdul8p5XMGS0EKqQk5ee02x4=;
        b=XzTvu5u4I1C5NsnvLKEZy8YAkQET0QaOQ3/5PzgoT5KvNBWaldE5n7RLr1z2Bq/Dzj
         gsdkgqQj07TuCNPjkVXK3OaNqNfmaIumfa4054+S2zlAfQxZqNZqIkcPjW+8BnraEdNA
         z8xyFI7Zi0WuprrnuGF2l6VtVUldcz/TFZujgM91GabL4O8MqcqBZADDxF+EPFDtxRcv
         iY4AXZ4FMEH26PgESQKCdFgGPscmO8Ba1Tb10RDL5g6nBxiB5pMSs5anTNuBb7K/sS68
         UpGns5qHMAYNx24fD4BT+TNQozN8/8fpNIGlALRvtSI9EHS3lZZ/U9gEpPGBGjtGALWc
         6XVw==
X-Gm-Message-State: AOAM530KuBxOqnrikzdPmHs23IU0X6a5s22nVnBXarPRYJXFjDJztYO0
        cu58F45PA1KGlWDjUJIAV4j43TSXWiFtUWqz7h4xzxbgQbw=
X-Google-Smtp-Source: ABdhPJzLIYELY6/WN+ktiE+01GOuYtJMe25r4dpqNLHagZa6N7S+hUeqUzg/YKaSdqGagumv461lKIMxBASkId0DPtc=
X-Received: by 2002:a4a:98ed:: with SMTP id b42mr11834950ooj.32.1597684959029;
 Mon, 17 Aug 2020 10:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200814111049.GA4101811@coredump.intra.peff.net> <CABPp-BGrxaY-ObzuJ60TDMfQD+crq+TTnYE03T=KVmG5mEf-5A@mail.gmail.com>
In-Reply-To: <CABPp-BGrxaY-ObzuJ60TDMfQD+crq+TTnYE03T=KVmG5mEf-5A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Aug 2020 10:22:27 -0700
Message-ID: <CABPp-BGUBPJCW3-GrVvom5CwfauY-m5ZCLJmKP=P=fXWm=Kepg@mail.gmail.com>
Subject: Re: [PATCH] clear_pattern_list(): clear embedded hashmaps
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 9:55 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi,
>
> On Fri, Aug 14, 2020 at 5:23 AM Jeff King <peff@peff.net> wrote:
> >
> > Commit 96cc8ab531 (sparse-checkout: use hashmaps for cone patterns,
> > 2019-11-21) added some auxiliary hashmaps to the pattern_list struct,
> > but they're leaked when clear_pattern_list() is called.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I have no idea how often this leak triggers in practice. I just noticed
> > it while poking at LSan output (which we remain depressingly far
> > from getting a clean run on).
> >
> >  dir.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/dir.c b/dir.c
> > index fe64be30ed..9411b94e9b 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -916,6 +916,8 @@ void clear_pattern_list(struct pattern_list *pl)
> >                 free(pl->patterns[i]);
> >         free(pl->patterns);
> >         free(pl->filebuf);
> > +       hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
> > +       hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);
>
> This clears up the hash entries, but continues to leak the hash table.
> Since you submitted first, can you fix this to use hashmap_free_()
> instead, as per
> https://lore.kernel.org/git/932741d7598ca2934dbca40f715ba2d3819fcc51.1597561152.git.gitgitgadget@gmail.com/?
>  Then I'll rebase my series on yours and drop my first patch (since
> it'll then be identical).

Nevermind, I got confused once again by the name.
hashmap_free_entries() doesn't mean just free the entries, it means
free what hashmap_free() would plus all the entries, i.e. do what
hashmap_free() *should* *have* *been* defined to do.  Such a confusing
API.  And hashmap_free() really perplexes me -- it seems like a
function that can't possibly be useful; it's sole purpose seems to be
a trap for the unwary.
