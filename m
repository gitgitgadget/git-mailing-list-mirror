Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A4C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjCXOrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXOrN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:47:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31E1633F
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679669223; i=johannes.schindelin@gmx.de;
        bh=5IWKgdmVe4Tv85fPbSAp9aMy7G/ZMiQp6J9ja0FEA0Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FKn4C5or2YYX92SmSe11xvqDN2FCfLF8WP0YNd9h120Z8py1NnAP5vZZL9DdIZDvx
         GATulkrTPblbAr5GjYTtMzF9REpfgcxFDGmOXlZylORgWxLPNXcZocnNQFaRX4yMVz
         /jzjvEkSMxoWqWn1w1rSPqCorg5warAL70GGqhhmW9kRdohbi31z+n7zrdPzKp7k5w
         8mmJAp6dVRngXMk405gJuDJer2Bh+q3tZ66eGMFz6Y94LaL3Trf4oIBQzNRp4aR0Pm
         yXuWo4NMYU1N/w7gnv2SMvLahxuAN/xrZTk5qseaaPutiDEJ/cOEGVJYQho8LBp8WX
         GQ4/O1D+yqAGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1qKnSz2dfq-00m6SN; Fri, 24
 Mar 2023 15:47:03 +0100
Date:   Fri, 24 Mar 2023 15:47:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Alex Henrie <alexhenrie24@gmail.com>
cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org, tao@klerks.biz,
        gitster@pobox.com, newren@gmail.com, phillip.wood123@gmail.com,
        sorganov@gmail.com, Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
Subject: About replaying "evil" merges... Re: [PATCH v5 3/3] rebase: add a
 config option for --rebase-merges
In-Reply-To: <CAMMLpeTUbG+b89acan-GXGS4H=J7aQupbK8zdxwNg__U_We2dw@mail.gmail.com>
Message-ID: <ef9be5fb-ba3a-b971-f742-344a25fd5f26@gmx.de>
References: <20230223053410.644503-1-alexhenrie24@gmail.com> <20230225180325.796624-1-alexhenrie24@gmail.com> <20230225180325.796624-4-alexhenrie24@gmail.com> <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk> <CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com>
 <5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm.org.uk> <CAMMLpeTUbG+b89acan-GXGS4H=J7aQupbK8zdxwNg__U_We2dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tMjkndmjOBI7VlL94QCm7NBSVrnPGjro9y1+XajwXk5k/5mt867
 Lf84a55zaA4ogNUqW+9h+V8KbxSQ04fJE6Av5Tc0qtmuOLJcwnyYIYR2dw1R4GY03HEF5PG
 1FEJtEGujfEhrvcl4gFTFaYByKJ3MFchDCI1jfjlwjPrWsihIIIx05L7kY4NR9MKgSS/i/9
 TLoDbwmTbQZBV6tRjltYQ==
UI-OutboundReport: notjunk:1;M01:P0:VuOE/elO/rU=;5f8E4haynYAI/VI6bxmeSf5lbAQ
 9OlRckgGEBzQ1U6I7Sz+MIZ0V8D2FwccFSn4Kdl95jqgYZawPYs6wchgbU1ETSA9rdhbfu/cE
 eWHO72PyCejql27e/U+ugcREo4M2u+yniLGqAV0pQuaTed/5ubAoWlrEYl32uMsptEQ4EjkWx
 NN5JMS0pjgs6asAcdYDojV6kY4qmX/+TMJIAd7fJvDJfsoCJKs928+DCxGLMQOMfrzYGv7YV6
 TBi9IqqUvyoxJkEF5ZGk+MX0qM6L7gTfPYTaoTzCR2s0znFWjPz9OKUgYR69ZGjzRUvjwu1ML
 idDftZUpKwzLQqIFNsBJrxEYdVgFjDHU8E5UgLqUd8lzDXaF86DqClSyeIDQZGzijwwNOn+TC
 A0DkSHooasdBKN0MNlGWBSPepq7UPjYeLRNxxQQoKes7fVGc/0e4MRZ2bCgxAsG3ozbr8ZUcj
 7HjvNL2fCeguL9TYwxsIrwpENIn3YF5hPF7o4Du80MOVMdXmr6AdjOb48msy8DjDW7MBzsKC7
 eYDlrFH2Z1xSdFfXW9Rwt+EuRwPTpYeY8KGRgnicrYctNBq6hLhnWSeJ/C4qHl7nadwqGD8w3
 aCnFb2yj5rANYr2C4s6lyO+oQWeBOmBd0kSQ9tnN9Mq7U/HFdc6RFxOMHGsn66FGSeop50qKC
 VNax8xYsj/soNfb000a+rK014Y+vJU8v2ETrsmxsuA/NSrBYo1xjMz8xfogROjhy1j32qTpGf
 1TDNS7uxG+k8yBprwnzXrLP3x/RstamcwQamRvkxE8HiIpksOkDneEbBl2UFsFA4B8hR+ZSVm
 H3Kd00jrL+V9kU3PDLyJHj00pfiq5iZe4C2RmhgCiYYOma6jq782+5JjuALfmR8EFbt+Do+Dt
 uJDqT1LdhCP6jJY2j2ddhB5NqFVIOswoJYmM0PfXNa0RIFcs3L8h9b2F5Vep6gQ7Rt/MsD9vU
 m5/V6w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

Heads up: This mail is totally a tangent and is _not_ intended to distract
from the patch series.

On Sun, 12 Mar 2023, Alex Henrie wrote:

> [...] Glen thinks that in the future we might have some kind of
> rebase-evil-merges mode as well, and that that might become the default.

While it probably won't be the default, like, ever, I can well imagine
that there would be a good opportunity to add a config setting to make it
the default _for that user_.

About implementing that mode... I recently picked up a repair item from my
ever-growing TODO list to brush up that "replay merge conflict resolutions
and amendments" idea of Phillip's that I had implemented already four
years ago (only to find out that it unfortunately caused a lot of nested
merge conflicts when using it on Git for Windows' branch thicket; I tried
my best to add a test case demonstrating the problematic behavior).

While I had to stop working on it again, I at least left a rebased version
at https://github.com/gitgitgadget/git/pull/1491 (in case anybody is
interested where I wanted to take this PR, I left comments describing the
changes I had planned on looking into).

I mention this PR here in this thread not so much to derail the review, or
even to distract from this patch series (I really detest when that happens
in reviews of my own patches, so please accept my apology in advance
should that happen here, it is _really_ not my intention), but as a point
in favor of Glen's suspicion that we might get such a mode in the future
to replay evil merges or merges with resolved conflicts.

Ciao,
Johannes
