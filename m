Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9362022A
	for <e@80x24.org>; Tue, 25 Oct 2016 10:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758149AbcJYKQg (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 06:16:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33031 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754819AbcJYKQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 06:16:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id i127so6231131oia.0
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0uFPOLRajGvz27v5GX5FTxFZt9Z7Y4z8VVwl3yxISlo=;
        b=rD51BaL4rD3qJ1jxq/CSNKzM1jZawjo0XI7Y1PIEOzFS0Elg7LyH3IOW84ned4puFW
         o9EnVKt3Q78wiSZiynpm7Lydk47EYFh3f5EW2i5h+mr4vjvZkioLHnjHoIBEMtdYLURB
         gBb1p53XdHB9nlXdyZMuslDI1gFmb3dwW6toNxmwZg15Qt5hoImPkJB2GBVE0WI+dUEL
         nV2Wr9o21QAXKCSGmaFOdHEsZnxYQ03H4oscoykke6K84oavNOjJxCAPFkQLd+x0GbrS
         rDI3OynRXLJFD7yfxcDQJm7NNSMC2LN+BnE5nwHx4426ERVSJKpqfjqZV7iGylEGjY9P
         iaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0uFPOLRajGvz27v5GX5FTxFZt9Z7Y4z8VVwl3yxISlo=;
        b=RNLNO09GTtu7i3Y4wJfLLTB+EXPfNQuL/tc/fSp1+OkS+WC+xsVZeay+4dvIf893jc
         tbZ5j0wsb5paF/3uFP/sYut+u0ecQH4BS2h3VcVurRku9qEpuswnbvlmOOOHH2nwycxm
         lb9vDSGcrtHXm1NjvzuJuG0px4rAXx7pCw1RUR5UkWjxdG6YnTCR8N6EQBkE+jLSpeJB
         HUTHg91YSusTz9RI9ViTQPgujc4QPKGpVGrtsmk2zO02puZHia1DHFTn0YYLOXuW4ro7
         R+wPiKWeXCDMYBEw6710BOPSXYb+OcfWp+sqs0Fx1Olvf0LZuTFKDMXxV81bxldfhvv0
         fx/A==
X-Gm-Message-State: ABUngve0suO6LiTiC3n+FUUUTF7DnIHqqu4kihWDsvEWrcRTn63MYfKWAQKTkaqYf2uDt4JY8RPLPlgUeC1SRg==
X-Received: by 10.107.59.6 with SMTP id i6mr16906361ioa.176.1477390595417;
 Tue, 25 Oct 2016 03:16:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 03:16:04 -0700 (PDT)
In-Reply-To: <20161023092648.12086-11-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org> <20161023092648.12086-11-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 17:16:04 +0700
Message-ID: <CACsJy8CfQ6d3Q74W4rm=rJD69EAzuUe7PdrW-5NDo0vHuDSNpw@mail.gmail.com>
Subject: Re: [PATCH v1 10/19] read-cache: regenerate shared index if necessary
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> @@ -2233,7 +2263,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>                 if ((v & 15) < 6)
>                         istate->cache_changed |= SPLIT_INDEX_ORDERED;
>         }
> -       if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
> +       if (istate->cache_changed & SPLIT_INDEX_ORDERED ||
> +           too_many_not_shared_entries(istate)) {

It's probably safer to keep this piece unchanged and add this
somewhere before it

if (too_many_not_shared_entries(istate))
    istate->cache_changed |= SPLIT_INDEX_ORDERED;

We could keep cache_changed consistent until the end this way.

>                 int ret = write_shared_index(istate, lock, flags);
>                 if (ret)
>                         return ret;
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index db8c39f..507a1dd 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -8,6 +8,7 @@ test_description='split index mode tests'
>  sane_unset GIT_TEST_SPLIT_INDEX
>
>  test_expect_success 'enable split index' '
> +       git config splitIndex.maxPercentChange 100 &&

An alternative name might be splitThreshold. I don't know, maybe
maxPercentChange is better.

>         git update-index --split-index &&
>         test-dump-split-index .git/index >actual &&
>         indexversion=$(test-index-version <.git/index) &&
> --
> 2.10.1.462.g7e1e03a
>



-- 
Duy
