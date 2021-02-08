Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A71C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 04:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3B864E61
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 04:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBHEbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 23:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBHEbl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 23:31:41 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B0C061786
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 20:31:00 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u66so12421163oig.9
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 20:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVUqhtriIgagpgyKb5YNWJ8uOnoAzeLbUVNsTtkH5eM=;
        b=pq1MWkmMn1XmrFnx6u0iIGl7zG0YcAK0lYzU3yAIng1e1vLX9F7CH39zkSZVgNpzHm
         EolBpYq9fCVXfyHXaoBAou/us6p14pOaF22CmU2pTjfVz4AricBF99L1TFAXWYVkd8cp
         If5uExJpBEn/iFf1hbsMdoLi3iiktE3+51i4BqAlO6sFYlQqo7lGQjAXL1PbcuxGGZFJ
         PLws3fAtVvRF97f8He+9H0i9UfdTllTSRs87vXrA8Cg+p/3JSzeCozWUtCd5+UGXlaAh
         WBVfFo6DaPF8u6aiOEHk6Q7gZRa4RkBIcbMrl86Qi4aQuUEmlmWT8p27Rhww5Sn7mN/o
         KByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVUqhtriIgagpgyKb5YNWJ8uOnoAzeLbUVNsTtkH5eM=;
        b=VcbqV45KVZt0gd112RT2TGIkeriaTNOdaZhicabqQYNczOorAHiHO6cbL+Wv648Qvl
         YjpaZTeFSd1lieO1pqKMRqgoL40FPCQwSyt9ATzp7umGkCNtvu8zhvMXFVaY4E9FP9U3
         5MGE1bmngmPGzxMeN1fLP0KU3HPu0K3xpv0ur4FtbTdmIuywpEx6esauOGzgJzEm+olo
         PQDb4UpC6R+nqvgDf2AmzXSBWiTjCBhOh7MVrMMXXrEysSQuTZ70BTX4pf4ypuX0mtKK
         LQmnS9pjKb4s93Cf5YHL5LdW7Mp9s3UFCzExdVfLrepIg+ktG4FRrYoDoD8xtcLteaW3
         AewQ==
X-Gm-Message-State: AOAM533pLq+sBxSY1a8+lyeRE0itrUNXiw50tXwMWhL+FALMJyKdDwtn
        rdcRanyQ94oJaYl+E6Pf1ftyLpJeW91e/6RjY9dYd2PI8Ww=
X-Google-Smtp-Source: ABdhPJxcytZ68cZ5PMuNzWsN8AxIsIatt+y3NiraUIFo/YqsjGnVwKkqKmDjxgY5p5HkfVnLBQaESI9WsZj8yblpmac=
X-Received: by 2002:a05:6808:c:: with SMTP id u12mr9701193oic.163.1612758659874;
 Sun, 07 Feb 2021 20:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210207181439.1178-6-charvi077@gmail.com>
 <CAPig+cQ+_neX_FLCQawG44US6Rtu_4wgVe+HMNseh7AvjTu=Qg@mail.gmail.com>
In-Reply-To: <CAPig+cQ+_neX_FLCQawG44US6Rtu_4wgVe+HMNseh7AvjTu=Qg@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 8 Feb 2021 10:00:48 +0530
Message-ID: <CAPSFM5f67naGx7kywKJF0DxesWhatDqTVHfA7hCF76NSO9p94g@mail.gmail.com>
Subject: Re: [PATCH 5/7] t3437: fix indendation of the here-doc
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 8 Feb 2021 at 00:24, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Feb 7, 2021 at 1:19 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > In the test scripts, the here-doc body and EOF are indented the same
> > amount as the command which opened the here-doc. Let's remove
> > one level of indendation.
>
> s/indendation/indentation/
>

My spelling mistake, I will fix it.

> I found "In the test scripts" ambiguous. It isn't clear if you are
> talking about all test scripts or the script(s) this patch is fixing
> up. Sp, if you happen to re-roll for some reason, perhaps clarify by
> saying something like:
>
>     The most common way to format here-docs in Git test scripts is for
>     the body and EOF to be indented the same amount as the command
>     which opened the here-doc. Fix a few here-docs in this script to
>     conform to that standard.
>

Okay, will change in the above way.

> > Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I don't think this new patch is based upon Phillip's, so you can
> probably drop this attribution.
>

Okay, thanks.
