Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E7C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 08:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBIIoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 03:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIIoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 03:44:16 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F702C67D
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 00:44:14 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id l3so1243752ljo.5
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 00:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynD9gn03QTywF5Oe67mybFtruPY0z3BPPkJvQSujflA=;
        b=iNZZtGVbxCZLTuePBSyQMz3kMQMIGcpx4HGFvC1CO9WTLYa9/VF28PMwQRXxbS9CLP
         gE1Du9ezTt/aFUOozFc1OZmPNPKL+fP5msLwZbfN1UZS+vuU21Sjk8rXnslA6R8Is9DH
         Cq/aoTpKZSjWWtJO+PlXo7+1+akhG/EHwrIwTDMbdtcvgkdyvanmpyzipcunTO/qpbJ8
         4CB48joPpqoZWG7zZR8UslNNHwty4Mb6f1XvYpOkcenrwZz95s6HZnHoSA6StT2MYAe9
         2rzyca0+FTZeP36l4cIDYMOxZDScxZ76wMBuETxFc/83rIITOZiXSe1lNfephYanklgK
         IxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynD9gn03QTywF5Oe67mybFtruPY0z3BPPkJvQSujflA=;
        b=UoBVAMUIvCXbfr5g40s/DD3+mQTtSVZpW3KDCR3s5CivI7soIlyK/GIvUaDiNPb/O9
         ss/tl5+x0LMfi2edQr7ZEGCR4NmUet7WuDb93p0vF3Lb6oQTaRE9vy9ghMvs/PL1FPjo
         p84CvoBeFJPn+Mc6cYvXRQ2DtZ23AStI70S7OERUzysKoggXc5t52pRkP815hjA8s/3D
         Z45jnnrhfw4PE5nuXFX9gvsEPse25/Ss/Z/36BVr5870OEijvoCDLvYab3Krys9JMjFf
         0U1UBVEsGIpXlJF29KBqmQcv3FRcb+xUb97ScpFV0DdhVB1nZh/HCliLb8OtL10bX3OP
         aKQg==
X-Gm-Message-State: AO0yUKV/8B5swvNIvYWIjg7ra4Mi73CH6d0hPMCui5p0Y3Bq8KWHgBvD
        MfJaIG6TQfCI+iFgi073fHajTr4ZlDDhOnCRZXQ=
X-Google-Smtp-Source: AK7set/wLzGmM7ZQYC5CLqDP5XAZiId+22/fOnfrr74xfQQijN/wJ0jT/h3tJ83xYUSY0og0MgrXt0UsityZI0LgUQs=
X-Received: by 2002:a2e:380a:0:b0:282:9ddb:546e with SMTP id
 f10-20020a2e380a000000b002829ddb546emr1707176lja.6.1675932253086; Thu, 09 Feb
 2023 00:44:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com> <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
In-Reply-To: <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Feb 2023 00:44:00 -0800
Message-ID: <CABPp-BFKQXe-EJOd9z1TrisL64NuV9A132rf9MwV_7w79QQ9YQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     John Cai <johncai86@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

On Mon, Feb 6, 2023 at 12:47 PM John Cai <johncai86@gmail.com> wrote:
>
[...]
> That being said, here's a separate issue. I benchmarked the usage of
> .gitattributes as introduced in this patch series, and indeed it does loo=
k like
> there is additional latency:
>
> $ echo "* diff-algorithm=3Dpatience >> .gitattributes
> $ hyperfine -r 5 'git-bin-wrapper diff --diff-algorithm=3Dpatience v2.0.0=
 v2.28.0'                      =E2=9C=AD
> Benchmark 1: git-bin-wrapper diff --diff-algorithm=3Dpatience v2.0.0 v2.2=
8.0
>   Time (mean =C2=B1 =CF=83):     889.4 ms =C2=B1 113.8 ms    [User: 715.7=
 ms, System: 65.3 ms]
>   Range (min =E2=80=A6 max):   764.1 ms =E2=80=A6 1029.3 ms    5 runs
>
> $ hyperfine -r 5 'git-bin-wrapper diff v2.0.0 v2.28.0'                   =
                             =E2=9C=AD
> Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0
>   Time (mean =C2=B1 =CF=83):      2.146 s =C2=B1  0.368 s    [User: 0.827=
 s, System: 0.243 s]
>   Range (min =E2=80=A6 max):    1.883 s =E2=80=A6  2.795 s    5 runs
>
> and I imagine the latency scales with the size of .gitattributes. Althoug=
h I'm
> not familiar with other parts of the codebase and how it deals with the l=
atency
> introduced by reading attributes files.

Yeah, that seems like a large relative performance penalty.  I had the
feeling that histogram wasn't made the default over myers mostly due
to inertia and due to a potential 2% loss in performance (since
potentially corrected by Phillip's 663c5ad035 ("diff histogram: intern
strings", 2021-11-17)).  If we had changed the default diff algorithm
to histogram, I suspect folks wouldn't have been asking for per-file
knobs to use a better diff algorithm.  And the performance penalty for
this alternative is clearly much larger than 2%, which makes me think
we might want to just revisit the default instead of allowing per-file
tweaks.

And on a separate note...

There's another set of considerations we might need to include here as
well that I haven't seen anyone else in this thread talk about:

* When trying to diff files, do we read the .gitattributes file from
the current checkout to determine the diff algorithm(s)?  Or the
index?  Or the commit we are diffing against?
* If we use the current checkout or index, what about bare clones or
diffing between two different commits?
* If diffing between two different commits, and the .gitattributes has
changed between those commits, which .gitattributes file wins?
* If diffing between two different commits, and the .gitattributes has
NOT changed, BUT a file has been renamed and the old and new names
have different rules, which rule wins?

* If per-file diff algorithms are adopted widely enough, will we be
forced to change the merge algorithm to also pay attention to them?
If it does, more complicated rename cases occur and we need rules for
how to handle those.
* If the merge algorithm has to pay attention to .gitattributes for
this too, we'll have even more corner cases around what happens if
there are merge conflicts in .gitattributes itself (which is already
kind of ugly and kludged)


Anyway, I know I'm a bit animated and biased in this area, and I
apologize if I'm a bit too much so.  Even if I am, hopefully my
comments at least provide some useful context.
