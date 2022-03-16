Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3D9C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiCPS6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiCPS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:58:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F866E4D2
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:57:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v130so6062450ybe.13
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIN2FkXxKIO7AUWjsoKu+e+r9Oc0c9BO9LlRCzXEfXc=;
        b=pK+GEsZaTFO6wExloSc2+B6m5cSDBxixqkBNGz6Yw2MGMvS8rRQSKb49LSRdF4AF6M
         1qBSGAio2moIQhNShVrCM6FjdqModfE+eLFDlefgezRRv8RoIaZrrTDwNIAlTz1AwXrm
         uRnPeFQ7M8wCxe/imWKYbNvjUukh2QnUb3bH+RcuWI5Yr+3Ey2DiD5woi+3HYJlRvxSZ
         RM800fvjM9QYkAd3Y3RSyAbt6D6WDguPoZcKdHUxaK/61zLpAXTC30GzQfwbmt2nkvTn
         uN/sPa2eoponXZzsZDNgr+i6Bm2xn8pYY8g2L42hwB3f/27WTQF098bGwx9N7XFkJkgW
         TAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIN2FkXxKIO7AUWjsoKu+e+r9Oc0c9BO9LlRCzXEfXc=;
        b=QCYUzsNWt0Vbo6GO97ARg/Hdf6CkqED8uC3v29j5xOjaWJBMqi+ZAVCZTwWPC83tJe
         BFSAOIAXlrtbFU0yGYwTuzA49l2ZxpUzxJwwy44P6xiu/mvYgCQzwlahjGW7yDKysaVn
         BmTe0DEVnr1oyPI64nWdNbvrZv1r9wZnLtuEb7zsx2ZDf9Q6iz8AFbJgsG9EcvDRcJ4w
         2CXygNkNePQ60ZD65dOh5OZQp5iqLw80bckIJLiLBTCfn8wMEjrN47mBxNUVA3t2WLwY
         Vr9zGdxqZY6yYer9ChPt3Rs40H/JMQelTYBbUYetrcK81TCoNtHpQPQeR4WgRG5wQo40
         kbMQ==
X-Gm-Message-State: AOAM5311YofU3UnBJFnGD8RJ7T7Q7RnA0LqsVzKgXQrSx4i1wuhYMrtO
        Hp1J86qIGpF8nyS3DqjEWjZ3BUs/+C2yWMXR5MRMydJA
X-Google-Smtp-Source: ABdhPJz1vWo+coD4gNGDZ7DwwAYaQNaH3mLEpf+VNSVdViUcZ1v7No+ev1+BXTe7t10r1ocQHQus989RdyFCVeaQkzw=
X-Received: by 2002:a05:6902:102d:b0:633:884a:d3bd with SMTP id
 x13-20020a056902102d00b00633884ad3bdmr1389256ybt.171.1647457041714; Wed, 16
 Mar 2022 11:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJcwCMMMm=ZnkV3Xxbf+CpJqhRGx1KrdUzh90W-9dEPJ+i40xg@mail.gmail.com>
 <xmqq8rt9opd1.fsf@gitster.g>
In-Reply-To: <xmqq8rt9opd1.fsf@gitster.g>
From:   Andy Zhang <zhgdrx@gmail.com>
Date:   Thu, 17 Mar 2022 02:57:12 +0800
Message-ID: <CAJcwCMOQnMqqMdR=ZJ-ZgLuZ0wwt9oNxAmXfn4_xpY73rwqFVQ@mail.gmail.com>
Subject: Re: understand Diff Formatting --cc flag?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 17, 2022 at 12:04 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Andy Zhang <zhgdrx@gmail.com> writes:
>
> > understand Diff Formatting --cc flag?
> >
> > hi,
> >
> >   It is really too hard to understand Diff Formatting --cc flag.
> >
> >   It is hard to understand"...hunks whose contents in the parents have
> > only two variants..".
> >
> >   My question is:
> >    1)what does "variant" mean here?
>
> You may be comparing a merge of 5 parents into 1 child.  There are 5
> pairwise comparison (parent#1 with the child, parent#2 with the
> child, ..., parent#5 with the child).
>
> Among 5 parents, perhaps parent#1 and parent#2 had the same contents,
> and parent#4 and parent#5 had the same contents, different from what
> parent#1 and parent#3 had.  You have 3 variants (parent#1's, #3's
> and #4's; parent#2 has the same contents as #1, parent#5 has the
> same contents as #4).
>

[Andy wrote:] as per your comments, The 3 variants are indeed into the
following 3 groups.
My question is: why can #1 appear inside multiple groups? A and B.
   <group-A> parent#1, #3, #4;
   <group-B> parent#2, #1;
   <group-C> parent#5, #4;



>
> >    2)what about all the other cases? 0 variants, 1 variants, and 3
> > variants and even more?
>
> By definition, you wouldn't be making any comparison if there are 0
> variants.  1 variant means all the parents are identical, so
> whichever parent you are interested in, the difference to the child
> is interesting---such a change can only come from the person who
> merged adding a change that no parent wanted to have.  If many
> parents are different then showing the comparison with the final
> resolution from them is useful.  The case that is not so interesting
> is when one set of parents had something (call it A), and the other
> set of parents had something else (B), and the result is A.  There is
> no interesting merge conflict in there.
>

[Andy wrote:] can I explain  "--cc" flag as:
"--cc lists only either hunks which were modified from all parents, or
hunks which were modified from at least two parents and they had
different variants"
