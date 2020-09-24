Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB6C4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 07:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB95206C9
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 07:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcbib+BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgIXHN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 03:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 03:13:57 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58954C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 00:13:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y11so2174658qtn.9
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iv217tBBBtbybqc3Z9epb12S1dWfDpwBhQFLVIHwRlU=;
        b=Bcbib+BWHZQtYofZ+3337oJ3Jyh7ixghQ/WRlbRH1dx1sWTw3w3KELLTcBm2yU9Ag3
         3RS4T45SDHq3lWrgBmI4hmWtJMLBFPLs6GQmJ85/kL36g2WZl9Q8EaGvSbA5Lw65Ibxm
         XHO2j3nb/ebaH7EwRSv54wVMvV4UX0HPdC0d9CV9h5L9qFMK8AXOIpXMsUTmT0ZotAb/
         b7Ppyp+pn3PALOIQjzegc8tLP6K3Uytb2TBYRZaEXNx4GAkbpygXaCWKUlMyCP95FY3M
         9YKFPqQxEoDCwiZ5/snsUqB2B4z/utKhl559FNxlEi7BYTbpmxyFnKqivS4ftg89Kmui
         s+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Iv217tBBBtbybqc3Z9epb12S1dWfDpwBhQFLVIHwRlU=;
        b=R4EOmBSFL/brXfrD8hL5V32HLPAD+L2uSCYr1hiNo1sQXUky6FcOoMZuKxRfmDeAaa
         QWt3QMopMrQUCJMXtguDSXiv6njXIKTh7UWiwS643n998pBwI/cqc0q6mxjy63yctKhP
         2Fv0e3ulw91OMU06EhPkbEMuOR1D16w467OIdnq5Er7LtUoY5OuSYChk4giS2QVNmd6F
         GwijEwe7DgvFw74fe7IQpOB1SF06u8m01rpwhBIF8T3o8Cr+3YX/q5DkaYiAerTwSqUb
         7ZxFFnzGtD35dZoFWkarlNutW0desqc0TLY/bUsvzGd/VgJCiO7BwbHvzlohphcJOuFi
         IqiA==
X-Gm-Message-State: AOAM532z9VYzmgzyhb6agfGvFpzK1eENypn6LWmHy8/um4FB/QnJ9ouN
        aoRDXtKQ5tKcEuFj8kDPt+k=
X-Google-Smtp-Source: ABdhPJxIUTZzDUg6oPccq/6yH2HXE93wcKxpxqx68mzyGgpNqrdEMYjgrabc5jSH92Ot0EqN/hrQpQ==
X-Received: by 2002:aed:2907:: with SMTP id s7mr3783972qtd.321.1600931636370;
        Thu, 24 Sep 2020 00:13:56 -0700 (PDT)
Received: from [192.168.67.200] (dsl-66-36-136-92.mtl.aei.ca. [66.36.136.92])
        by smtp.gmail.com with ESMTPSA id 145sm1634767qkf.18.2020.09.24.00.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 00:13:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-2-tguyot@gmail.com>
 <20200918172747.GD183026@coredump.intra.peff.net>
 <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com>
 <xmqq363fm02a.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009231709340.5061@tvgsbejvaqbjf.bet>
 <xmqqk0wki9fh.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009232244000.5061@tvgsbejvaqbjf.bet>
 <1d0a60c3-d15e-bcbb-f042-2f8ae06f0de1@gmail.com>
 <xmqq4knnisn9.fsf@gitster.c.googlers.com>
From:   Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <34484667-1085-c60b-9438-591faed41ddc@gmail.com>
Date:   Thu, 24 Sep 2020 03:13:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqq4knnisn9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 2020-09-24 02:40, Junio C Hamano wrote:
> Thomas Guyot <tguyot@gmail.com> writes:
> 
> It is not "both ways", I think.  The idea is that when this variable
> is true, we know with certainty that these two are the same, but
> even when the variable is false, they still can be the same.  So
> true does mean there will not be diff.  False indeed is fuzzy.

I meant to say the old behavior "lied" in both directions.

> And as long as one side gives a 100% correct answer cheaply, we can
> use it as an optimization (and 'true' being that side in this case).
> 
> I have a mild suspicion that the name same_anything conveys a wrong
> impression, no matter what word you use for <anything>.  It does not
> capture that we are saying the "true" side has no false positive.
> 
> And that is why I alluded to "may_differ" earlier (with opposite
> polarity).  The flow would become:
> 
>     may_differ = !one->oid_valid || !two->oid_valid || !oideq(...);
> 
>     if (binary) {
>         if (!may_differ) {
>             added = deleted = 0;
>             ...
>         } else {
>             ... count added and deleted ...
>         }
>     } else if (rewrite) {
> 	...
>     } else if (may_differ) {
> 	... use xdl ...
>     }
> 
> and it would become quite straight-forward to follow.  When there is
> no chance that they may be different, we short-cut and otherwise we
> compute without cheating.  Only when they can be different, we do
> the expensive xdl thing.

I toyed a bit on the binary side... I never sent my 2nd reply as I still
needed to dig up; testing with diff_filespec_is_binary() { return 1; } I
would get (as expected) the same false-positive modified binary files I
used to get in range-diff test.

What I didn't get is applying the same logic
(free_diffstat_file(file);diffstat->nr--;) didn't have any effect. I'll
have to find what differs here to make binary files how up regardless.

Regards,

Thomas
