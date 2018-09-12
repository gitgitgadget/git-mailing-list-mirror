Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E679B1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIMAMm (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:12:42 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:38019 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeIMAMm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:12:42 -0400
Received: by mail-yb1-f178.google.com with SMTP id e18-v6so2218230ybq.5
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rX8+Fy5UyskZOeag/KJOY2GS5SHH7V5SvAnjn97hH2g=;
        b=QTAMiH9Zhws68p9gpF/OFgMlzku3wXx85ZFtDR4gC0EbTWLga2d7ZACvajyJ/7UEPA
         6x7C+KokAysB0OyJpxYyJHgCKc+pRzBl8tNiGgXGYYsf1GTJlq1LLD2h7Xq67SOZyEPL
         aE6+RRfugUCI1XHiCjWXdz30jZ/r1JNngpIs9IAsec79FiCk6C2CFzfR4dpY3tARLaVX
         rSeoIE3nPuTfAGAljyIOm+4k2EuPT91G+16J/v6DfLOxaQ84Ga3+oq0NeVy3PFwM8Sng
         b6mz8TILGAvqq21l1dSd+/YMH+QXLKxBUVKM7pN1A1AeudAr4PLJupsPFXIHG05UKoG9
         LcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rX8+Fy5UyskZOeag/KJOY2GS5SHH7V5SvAnjn97hH2g=;
        b=hpeXULLLxmtf/EC1DZcw8T5BzLeKAhS0XjfvhDuPiwCgBk9i+e45wmT3/haPNPvaY6
         yCy4oQR35KSyhaMRWq/UapvTAvwUoF85eBYn1ZTi7zugYmbKhJA8Bh2QBYzwd3cc0U6U
         BmI3hoI3LVp6wxtNEySgx3ZeIds2G+je4LSWN/OHDXg1NGuaPa0JhYOcesmhdRkfptxV
         vze25Mc+wFoNwY5L+jCbM16uUMqNWU3plKSHh5WbRjOe04UId2SWpc7gBGfkwjP5/MBd
         shM0JcFITuna0eqY+cwfASQs1O5su1YDKVFSmCkXignNniHGJoSCZU2BPFWfmRpEGEni
         BUxQ==
X-Gm-Message-State: APzg51ANyz3kF8Z3lVj5+6ljHY6v50aTv5kZRW50etrv7POM9/kWYlBw
        FxkGmD52HIoky1O3s+SZYGfMOLHms7a8sXDNtUhPRg==
X-Google-Smtp-Source: ANB0Vda1e//TitZVeqpvjoRERtoGSfwbg23KjiRHX5VQpSNR7uZ++M9+v6+6PXxC3Pu24VbmDFxyJKclRhGW83dJVUg=
X-Received: by 2002:a25:8205:: with SMTP id q5-v6mr1698212ybk.191.1536779208100;
 Wed, 12 Sep 2018 12:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180911234951.14129-5-sbeller@google.com>
 <xmqqr2hylgv9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2hylgv9.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Sep 2018 12:06:36 -0700
Message-ID: <CAGZ79kbavjVbTqXsmtjW6=jhkq47_p3mc6=92xOp4_mfhqDtvw@mail.gmail.com>
Subject: Re: [PATCH 4/9] submodule.c: sort changed_submodule_names before
 searching it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 11:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > We can string_list_insert() to maintain sorted-ness of the
> > list as we find new items, or we can string_list_append() to
> > build an unsorted list and sort it at the end just once.
> >
> > To pick which one is more appropriate, we notice the fact
> > that we discover new items more or less in the already
> > sorted order.  That makes "append then sort" more
> > appropriate.
>
> Sorry, but I still do not get the math you are implying in the
> second paragraph.  Are you saying that append-then-sort is efficient
> when items being appended is already sorted?  That depends on the
> sorting algorithm used, so the logic is incomplete unless you say
> "given that we use X for sorting,...", I think.
>
> Do we really discover new items in sorted order, by the way?  In a
> single diff invocation made inside collect_changed_submodules() for
> one commit in the superproject's history, we will grab changed paths
> in the pathname order (i.e. sorted); if the superproject's tip commit
> touches the submodules at paths A and Z, we will discover these two
> paths in sorted order.
>
> But because we are walking the superproject's history to collect all
> paths that have been affected in that function, and repeatedly
> calling diff as we discover commit in the superproject's history, I
> am not sure how well the resulting set of paths would be sorted.
>
> The tip commit in superproject's history may have modified the
> submodule at path X, the parent of that commit may have touched the
> submodule at path M, and its parent may have touched the submodule
> at path A.  Don't we end up grabbing these paths in that discoverd
> order, i.e. X, M and A?

That is true.

>
> I still think changing it from "insert as we find an item, keeping
> the list sorted" to "append all and then sort before we start
> looking things up from the result" makes sense, but I do not think
> the "we find things in sorted order" is either true, or it would
> affect the choice between the two.  A justification to choose the
> latter I can think of that makes sense is that we don't have to pay
> cost to keep the list sorted while building it because we do not do
> any look-up while building the list.

ok.

Thanks,
Stefan
