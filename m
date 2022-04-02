Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A0BC433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 12:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiDBMQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 08:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242153AbiDBMQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 08:16:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B15CFD5
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 05:14:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u9so717124edd.11
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqkAuSSPQq3ktblgB4K3T93p5vDQ+2pbiKbiSB4zmR0=;
        b=q/9mSfcnHnO2lqa9dwMIvzrUHNacHMh0BT8f6mvKxK5GNx74ZHc+nZbVmSJEuHWrgD
         ZRKBbRUCOvXJgDn5vbOlI+EwnrryweItn1kNpHNNB5BN/IOku6BYcUsgo3hXixpaokrB
         aRmMpBHkv3+uIT8Ce2MjjjG/zXivbZageVNQzT1emwni52SyXjbEAhWzWEiay4AsHKzi
         1o855HpcJoFU8cNHH3vptLmcyzuTScPwqOUg2t/InpgjqGlWuA+mj5B0Y38u7xDGFF3F
         5BBIRwy8KcktEkfifZg8zNJfY88ZhyGCMc8/YSiA5JpZMxXemy2B3PWu4+HqPZHCsXfN
         c3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqkAuSSPQq3ktblgB4K3T93p5vDQ+2pbiKbiSB4zmR0=;
        b=Wo15YVvRw0qiDUVKbwfz6qj8gWQiVJ41JlAR68z53Au7pmIa2aH5HzwSI9Ep5Iw0e+
         eSLYsr88IrAPRV/0+WWMploAMRtBOSpr4JGrwUBu1O/xewOVoDc4z5p4FtwZcceA0DhW
         lKHaf9WX0QH9jAieJVTbURCjcv9iuRyP7WUZZ8V8HIb/HUVF1peJrgM69REGZQkq0DKi
         grX1HHvK+bLXA3Dx6TskVVDe0eoc5Jzp9Wq1YmlA6xqpReFsuKJrsTIe+YaDd7qOD9fJ
         rM7pPoDPrnXtrBvJBISdnZ3yYG54IaS81NZugqkpMaEDRZ/KAc18/0TwEh2TIhAVKKUd
         nnBA==
X-Gm-Message-State: AOAM531DVRj9NtwVfCmyeIHmNyK+Abb955vKPNoOLZgFn5P/EJXGwNao
        b38X/CtMthV0Cdz4++IL7/ipQSfHahOIWjRJAcd8Xw==
X-Google-Smtp-Source: ABdhPJzg0NdbvfXxws5lr7avfPNioTKisFJEI7IOaiRZgiP5+NcoPuIcR94izzrEH27QqXVtHtFoP/oSfns808/+oiY=
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id
 x1-20020aa7cd81000000b00410d64eaa31mr25201699edv.167.1648901675646; Sat, 02
 Apr 2022 05:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 2 Apr 2022 14:14:16 +0200
Message-ID: <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] git-p4: Various code tidy-ups
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 10, 2022 at 5:46 PM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> This patch set contains multiple patches to improve consistency and
> tidyness of the git-p4 script's code style.
>
> Many of these patches have been driven by the guidlines contained in the
> Python PEP8 "Style Guide for Python Code" and were applied using a
> mixture of human intervention, and tools including autopep8 and
> pycodestyle.
>
> This patch-set stops short of bringing git-p4 into full PEP8 compliance,
> most notably in regard to the following items:
>
>   - There is no patch to apply the recommended column limit of
>     79-characters,
>   - There is no patch to correct hanging indents of multi-line
>     declarations such as multi-line function delcarations, function
>     invocations, etc.
>

I love the direction of cleaning this up and making it compliant with
*something* :)

I've tried to run pylint on the previous state and state after this
patch, but unfortunately there's a *lot* of noise either way - from
all the "pylint: disable" entries in the script I have to assume that
at some point it was compliant with *some* pylint version, but at the
moment it's very far from any sort of compliance with checks I can run
(both before and after this patchset).

I have a few questions about the changes - I don't think they're
specific to any single commit so I'll list them here:
1) Is there a tool that can be used to check for PEP8 compliance, and
shows only the two remaining issues you highlighted above?
2) What is the relationship between "git-p4" and "git-p4.py"? Before
this patchset they are identical except for the shebang line, after
this patchset all these fixes are applied only to one of them. I
assume the changes should be made to both files in a coordinated
fashion?
3) Which of the "pylint: disable" entries remain meaningful after
these changes, if any? I imagine "disable=wrong-import-order" for
example makes no sense?

I personally have an interest in making sure this script keeps running
correctly under python2, so I plan to test this when I can. I imagine
this is already accounted for in the t98xx suite somewhere, but I
haven't found it.

Thanks,
Tao
