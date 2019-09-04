Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7DCB1F4B7
	for <e@80x24.org>; Wed,  4 Sep 2019 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfIDUc7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:32:59 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39062 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfIDUc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:32:59 -0400
Received: by mail-vs1-f65.google.com with SMTP id y62so14726886vsb.6
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YcYhES0nnHLXmiEvhVtGyFkFUPCGrKkgA4ecJupgmA=;
        b=NbN0bhl5SFdB7k72BxdDL27CoOGDd0JCZQvYYKlfIs6kP8pEbaiqtrkcOscYyAOWJi
         Ct+Qk72kvJ3CRiLQBwXE3DrW6xrh3zwjMT4FFI+L6Qww7H4Te3MKY5TJE91LjxEXkiux
         VakkCBDKghM+sY/gLN90E7wxL5wrq3vZBZlqRfdQBFroMi0iCjrQkMMk/xdyfGyLgqUB
         OFbkfB1d9aCGesB+GIzv5E6wyfiACLJe17B60K3Jv7KauLKZmZ94u2ZetKRZUyEqdJGR
         w3ysrdxmhWSBosOIrePJN01HmbUE/v8nq5yoUm5146Ak51qQ1iZ87+Dt3eVtDgw3VRM8
         3rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YcYhES0nnHLXmiEvhVtGyFkFUPCGrKkgA4ecJupgmA=;
        b=KigvtmH6SGNHYmUC2EW4yqIlmgF/6NgGX2RfIFP+JDeI4AoU90bWvenpjID9fpuDGf
         q7iP0p6Sh78tv17Sg5fXrvHj41ato/dY6ikewxnnTiMch93OV0q1t194hLNNg18epAJ0
         AnmLGBiKLGJSJexaFF1qA8wJwkoB4B1vRe2a+Oz97N1vXewLCHF/+BFs3UZepR6rIvaT
         FUVFO4dheZ3bYiPrqJfcLeA0M5i6CvMjE3/x60uwFEiaiy3JldwhRTlUKL6SIkVuKdvH
         igGStwy0ja/oRh5IYpmVMTKkrltdyRhVHD+7S+FBff87J7n1Yh1RXHqMoQkoXiRvJGnV
         ++mg==
X-Gm-Message-State: APjAAAXA3cxB+XijAVzIUccLAEtRtrKPexU3ByeMx5KGvMnutyQgo3kb
        kCXiReO1eRXCbjyfyPqfGopi6R+xYKcDN9w8s4Y=
X-Google-Smtp-Source: APXvYqxxruRYMycQWpiyRDCerNZGX2b8qwHrLVWJmBW3LLIH8i0fkHFyx+qgQ8LuWhH6asIDzZYHfzKw/KnA5Renucw=
X-Received: by 2002:a67:fd13:: with SMTP id f19mr23115554vsr.53.1567629178508;
 Wed, 04 Sep 2019 13:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190828002210.8862-1-newren@gmail.com> <20190903185524.13467-1-newren@gmail.com>
 <20190903185524.13467-3-newren@gmail.com> <xmqqsgpdrs01.fsf@gitster-ct.c.googlers.com>
 <xmqqftldroae.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftldroae.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Sep 2019 13:32:47 -0700
Message-ID: <CABPp-BFi9puCJ8H08ZD_VSM2pygt3GoL52QNuaVLkN_130=n0w@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] t3427: accelerate this test by using fast-export
 and fast-import
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 3:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> +extract_files_subtree () {
> >> +    git fast-export --no-data HEAD -- files_subtree/ |
> >> +            sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
> >> +            git fast-import --force --quiet
> >> +}
>
> This change has obvious interactions with Dscho's d51b771d ("t3427:
> move the `filter-branch` invocation into the `setup` case",
> 2019-07-31) that is still in flight, but in a good way.  There only
> needs a single callsite for the above helper function after that
> step.
>
> I think I'll discard this step from the "move us closer to deprecate
> filter-branch" topic, and ask you and Dscho to work together to have
> it or its moral equivalent included as part of js/rebase-r-strategy
> topic.

Sounds good.  I'll resubmit it separately as a patch on top of his topic.
