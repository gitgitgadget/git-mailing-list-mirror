Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E73C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 10:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B3C20848
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 10:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgZbqh8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406503AbgJPKCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406062AbgJPKCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 06:02:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B180C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 03:02:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p13so1676473edi.7
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sA33C5wrDoNFS6OQSVQaevUuQZta+yLp3wpJCAKpPaU=;
        b=sgZbqh8d4PRh97xjeFLEMIgr+fW+5lp65yzRAcFCONirk6f3KA7ZUYd8SYvRqrKqHh
         HzEKlVo3xQHI20GkpKdohp22aRox2rC2GaFJan/zbJZUPjWtW0RMDVVidMifSSsC4m1I
         EdPWAEs95sIXwuFDbk7TM0PbiJzbnflsbMVsVglu5GNyhLBm4g+B7TV2tiJ2ahNtUSbg
         uRtNb3xS6ssfAHqQ2i1tZp1pvzORtINiSojTdQTZQjZu+No4huspIWSzxXzsBkchhFWN
         536xMzjoirwDoyrOMwM94PkJyvFsXQMPYKfmB3gPQWv9ep6we+xKs8wJDrEhVfh5Wn6d
         DV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sA33C5wrDoNFS6OQSVQaevUuQZta+yLp3wpJCAKpPaU=;
        b=aiuanO/FXEIXvFj1WF/SUPyVLiw7p5T7BlGXSGKv6S9lLmRuEGtIbAvUm9Vx3zPalK
         5uM4tmIBh6ghWQwoWz1RaZ8A34DIMf3MmJxb0RpzUPIbL4v1m+KzpgQSX6qM5O4k0HDB
         aTtyOrUHDz3NDo42Ezk70jxX6ox1f8Z31oAIrw30M5gT6UNo3v3R2zW3uN2vUkzseJ3j
         rcGcDlkPiaddKAj7s+f24xvWw5MFv/nTUkk50YaMjRmFgkzlRUT/bOI2UFxE/sCSPijB
         19AlC0ItoVvc0TEgx96yWl81lvqYCOODzbgwcW5scv+Ki0tOdBbPNXz7hcHrW1P4+ZGT
         zDYg==
X-Gm-Message-State: AOAM532DuChXhJi4dWsItAHpEjNZoRhB0SUXeyeLv+IedKLUKSQql6dm
        LZuEY9yYAVyXcLHjH2qI7H3bhi9W+4fDGDpyzbr6jk8d0EHNsw==
X-Google-Smtp-Source: ABdhPJxnAL3wMMEiyU03vicBAqbDsidvG3CQeStnHPsEbN2lRdeZNV1zvG+7iOh31T/ojK561KHskq5LkjPDgaBtT58=
X-Received: by 2002:a05:6402:384:: with SMTP id o4mr2911397edv.387.1602842573731;
 Fri, 16 Oct 2020 03:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdqGXp07VAUFGTsgvc83V6HgswhpqMnKGAbEaiWXpiEj_Q1rQ@mail.gmail.com>
 <CAP8UFD0pZ_x4ET5Pns0TQO82HzAfRiJPOMzs8d47gh8K8NL_OA@mail.gmail.com> <CAGdqGXrLN2W_CgqfmfkCSu_hmZ9Ze8A1N9n08bgPRPApSMraSQ@mail.gmail.com>
In-Reply-To: <CAGdqGXrLN2W_CgqfmfkCSu_hmZ9Ze8A1N9n08bgPRPApSMraSQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Oct 2020 12:02:42 +0200
Message-ID: <CAP8UFD2JV1uyR01_PXv09Aq6Jzyw4+ZMsbW9RqrhX+t1xoK8LA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     Zodwa Phakathi <phakathizc@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zodwa,

On Fri, Oct 16, 2020 at 10:58 AM Zodwa Phakathi <phakathizc@gmail.com> wrote:
>
> Hi Christian,
>
> Thank you for your email. Kindly share with me a link where the test scripts are situated.

First please try to reply using the same posting style
(https://en.wikipedia.org/wiki/Posting_style) as everyone on this
mailing list, which is replying inline instead of "top posting".

The tests are in the "t" directory of Git's source code. You can see
them for example here:

https://github.com/git/git/tree/master/t

You can also clone the whole repository as you will anyway need to
commit your changes in a repo before you can send them as email
patches to the mailing list.

Please see the following document for more explanations about contributing:

https://github.com/git/git/blob/master/Documentation/MyFirstContribution.txt

Best,
Christian.
