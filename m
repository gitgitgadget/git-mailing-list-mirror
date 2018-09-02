Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 203151F404
	for <e@80x24.org>; Sun,  2 Sep 2018 07:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeIBLtY (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 07:49:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46960 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeIBLtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 07:49:24 -0400
Received: by mail-io0-f195.google.com with SMTP id y12-v6so13613431ioj.13
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bbhIRsdtYWNp9jo9pKCUdmwzKc22dHLBIw4blwshFQ=;
        b=We6PGPs7W7j8GDadOg4FNQdzYS3OR469KeF1+JF/BhIgrfvaJSI5pRpgRK6xzkDQyN
         BuvJNq1s4JWFRW9XYRMUBGGHsXzSIFg0jUPaIra21g9ASNS2zDzmRph2sgafey8hE6zc
         xZNXoZrbJqsocDbgWsDnl6dMBRXOC/j73ghuiqL2eFrt0ufaYaOaRmT8P64U87x9bVxT
         EJ9xS63oWy+609y5A28pd80DYkxUiW9VFhTx8RRBH6jiisMABZPNl/V+6UfaKjSMpXia
         3g6cOWvJ0hHRQqKBsMmcxopVvg1yAqjPXUukVsJekFyAwZA1lnFXyK29YJuulHantqQf
         ZhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bbhIRsdtYWNp9jo9pKCUdmwzKc22dHLBIw4blwshFQ=;
        b=c7lQjzFMkrobXA4psKJ/3C9PLOPZx9cHlJwIG9xpbDKxW7NjvOgq5mW5Jv2eobqVgS
         e0ubiPFavhP53dq72+KS7el70rPQrj8tiR84b9cbtPEqRZwk/EBEpDOF5+vkM5jG98q5
         i5ig4ct5J4NwNLTfb5rBYuptrtzb0NnisaXDkECEhMi7dPKslko2YVjLcGfgPepyDNuL
         arG5PIGSWMbaBAqA43S2iybGgfESCdtVIPVOD+KlD7Tda/WYr/U6thGJb86ljbS7vVUp
         lrhLmFripTDvE1oeLVwHQeBIgVw6eAEzYO+iN9EtyL3BClsfeLzl6ZayTV9mwwieh5TE
         dnNg==
X-Gm-Message-State: APzg51BCy39EA/9ZeshGBDX+qayR2eW/94jPH6j5tDqtVCyvM5Vf1Trn
        cnftgWcgS0iVqHFhJBUW+7+ThdjRo2CFj0ivzZE=
X-Google-Smtp-Source: ANB0VdZPhxfFXnjsidQkL9Kw3sZ1iTXosoI9iD/nujy3FHbJffFZe8GUZjqiItQZVV6IIxNArqWFTuvzeh70+4Hr778=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr15176952iok.236.1535873674501;
 Sun, 02 Sep 2018 00:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180828123234.44582-1-tiagonbotelho@hotmail.com> <xmqqlg8qh22q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg8qh22q.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 2 Sep 2018 09:34:08 +0200
Message-ID: <CACsJy8AFo+mb8R-O-JKRPZk__csq6mbVXbnZhSd-nZ08zWfSeg@mail.gmail.com>
Subject: Re: [PATCH v6] Implement --first-parent for git rev-list --bisect
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tiagonbotelho@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        haraldnordgren@gmail.com, tiagonbotelho@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 6:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> > @@ -146,10 +147,14 @@ static void show_list(const char *debug, int counted, int nr,
>
> An unrelated tangent, but I think I just spotted a bug in the
> existing code on the line immediately before this hunk, which reads
>
>                 if (commit->util)
>                         fprintf(stderr, "%3d", weight(p));
>
> I think this was a bug introduced at bb408ac9 ("bisect.c: use
> commit-slab for commit weight instead of commit->util", 2018-05-19)
> where the internal implementation of weight() was changed not to
> touch commit->util but instead to use a separate commit-slab storage
>
> Looking at the code before that conversion, it seems that we were
> using ->util to store a pointer to an integer, so we had the ability
> to differenciate non-negative weight (i.e. weight already computed
> for the commit), negative weight (i.e. not computed yet, but will
> be), and commits to which the concept of weight is not applicable.
> When we went to the commit-slab with the change, we lost the ability
> to represent the third case.  I am offhand not sure what the best
> remedy would be.  Perhaps stuff a so-far unused value like -3 to the
> weight() and use weight(p) == -3 instead of the old !commit->util or
> something like that?

Hmm.. no? the commit-slab stores the pointer to the weight, not the
weight itself, so we still have the ability to check the third case, I
think.

> (Duy CC'ed to help checking my sanity on this point).
>
> In any case, this is an existing bug in a debug helper, and the
> focus of this patch is not about fixing that bug, so you can and
> should leave it as-is, until this patch successfully adds the
> "bisection following only the first parent" feature.

Yes. I'll post a patch soon to fix this "commit->util" leftover.
-- 
Duy
