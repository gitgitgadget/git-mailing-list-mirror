Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC9C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 08:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbiHNI0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiHNI0g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 04:26:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAD719C1A
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 01:26:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f20so6809786lfc.10
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Etlglj0oO95hU7PotQihEFEGmLO/OBmqIbd1xVD6NKA=;
        b=ixw1HmCUhxFVn+amn0jzqQNd77ljCZaI8OU4X23j7Gi4AnPbOCRh4r0Z6YCEOXhj7D
         vZ3ySh8sY+mnyYUpuoPJM/qVTLzfDbj0sdfICI4e+jJn2n76YjEaqkBvaQK38cARZlHi
         pZzR71fXYf+Ff+V3l5Sh3AprIpimKAK7dsZ0/IsMcTHde1Ad/G/1mrIS2Ds/qmOUMQra
         xoSLsU4MaJtzDxwZbCHWCbIwapiUhPZWRLOfj7jimH2Ci9QClxqgT4B+tAyrnsRcbgFG
         Y8oiUED/vmICyWTtwyistZLdmk6y4/+mkAc13C40nohc8aOSYAJApHWgQOIiwt64mpDo
         VnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Etlglj0oO95hU7PotQihEFEGmLO/OBmqIbd1xVD6NKA=;
        b=q8lYxfHQi7zLaL0es+Wx3Kn5pv4mP7XJ/Wy9H7BcmNu/GFWa2H0tyhhzmz7jZmfFH2
         ohnwliC9A8G8NK2n+LmPkAUwFZZ2pxbTSjBuduUhYVfoZRIi91nLy+GVUdvOzIQRhU9d
         xMHYTxdamZZrr3867bh4O9YZ6VQKLX/L4PmvNp7S1V3DiauOUtSoEdlBvikeEKzYLurq
         3/XDu8F5xKor16iWI3f+Vk4HL8EKVi+1uDYh1ayfRMDsUqnHJHWBMxeRUGqdRdQ1rvin
         X1IiMwb56VjUlYbSDkzxF2Mrh5spr884dPYhouiU+zxQhunTGw6R7a73YiUYbfr7sIUn
         bl7w==
X-Gm-Message-State: ACgBeo3p3YS1wYg6vmM8D2c/vM6buV34Cqrbn7QADGLGw0k6FlFhvLgW
        6dwzXnTDakbFposzy591QH/bYXTuboLe6NN7JkEiiqlpwic=
X-Google-Smtp-Source: AA6agR4wDdfPZ7JwPVqqofs9E3JLyDe8Ci2hciQWCBw/hpchlCcHeikKccl99e9Vn1d1yZnqVFjiEKkBX5uUFSS0Glc=
X-Received: by 2002:a05:6512:2349:b0:48c:ee14:7fc with SMTP id
 p9-20020a056512234900b0048cee1407fcmr3780536lfu.71.1660465593100; Sun, 14 Aug
 2022 01:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <6896FBE4-9160-4969-8969-D92F9FE19F14@gmx.com> <CAMP44s2A7nJDVRPbixPPPtTedg_Q53CEdw+sBpGZwOfQG4EZSg@mail.gmail.com>
 <0dddb367-ebf9-930f-1b9c-000a532774d3@iee.email> <CAMP44s1XOyMgX+4hHzNXpUmJ0DURn93=B9dH0pBm5Fk5YRfdvg@mail.gmail.com>
In-Reply-To: <CAMP44s1XOyMgX+4hHzNXpUmJ0DURn93=B9dH0pBm5Fk5YRfdvg@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Sun, 14 Aug 2022 10:26:21 +0200
Message-ID: <CANgJU+U_xgghdX58XsAY7dNUj1dE8STviTAL0ygycnAesZ+VxQ@mail.gmail.com>
Subject: Re: "master" term - no one cares
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, Ryan <rmrmail@gmx.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 14 Aug 2022, 04:35 Felipe Contreras, <felipe.contreras@gmail.com> wrote:
>
> On Sat, Aug 13, 2022 at 11:55 AM Philip Oakley <philipoakley@iee.email> wrote:
> > There is a confusion between the use of the term that refers to the
> > *personal* mastery of a _craft_ or _artisan_ technique and, at least one
> > of, the historical choices for the usage of the term 'master', which was
> > a direct reference to slave servitude. That was for the use of
> > electrical circuits which would detect the 'tick' of a primary timing
> > pendulum and then have all the actual clock faces that indicated the
> > time be _driven_ from that 'master'.
>
> This may be the reason why some people used that name in the past, but
> it's not the reason I use it.
>
> For me if I was cloned there wouldn't be two equally valid versions of
> me, *I* am the original one, I am the "master" copy. This doesn't
> change if my clone is cloned in turn.
>
> This is exactly how master branches in git are used. I have a master
> branch of git.git, but it's not *the* master branch. *The* master
> branch is the branch from which all the other branches came from,
> including "maint" and "next", and all the dozens of branches in
> thousands of other repositories. If the word "master" makes it sound
> more important than all the other branches in all the other
> repositories, it's because it is.
>
> Regardless of what name people use and for what reason, the reality is
> that "master" is still very widely used, despite of the campaign
> against it which was clearly driven by ideological reasons.

FWIW, I was a part of ensuring two large codebases did not use the
term "master" when they migrated to git long before it became a
subject of controversy.  Not because I had concerns over the
master/slave word association (it really wasnt on my mind) but simply
because the word "master" is too overloaded, and its use as a name
leads to all sorts of weird sentences involving the phrase "master
master", which for newbies especially can be really confusing.  I
found that introducing newbies to the concepts of distributed version
control goes much more smoothly when the "primary" branch is not
called "master", as it avoids the need to understand that there are
various different copies of the "master" branch where either only one
or none of them are actually master branches. Just writing this
paragraph makes me itch from having to distinguish the different uses
of the word master.

So while it is indisputable that what you call "ideological reasons"
really pushed this initiative into the public consciousness I think
there were and are a lot of us who are quite happy to support the
movement simply because we think using a word which (in English) has
multiple Noun, Adjective and Verb definitions is a poor choice for the
*name* (Proper Noun) of an arbitrary artifact, especially when those
definitions will likely be applied to thing being named. That the
phrase "master master" is in our vocabulary is a horrorshow. To me it
is not unlike naming someone's two children "Run" and "Slowly". Who is
going to understand what the heck "Run, Slowly, run slowly!" means?

The fact you need to distinguish <"the" master> from other uses of the
word "master" when talking above is to me a clear indication how bad a
name choice it was.  I get it, from certain perspectives, it is an
attractive name, but if you zoom out a bit, it just seems to regularly
lead to unfortunate sentences, at least in English. Try explaining how
the "master" branch is used to someone who knows nothing about tech,
like your Grandmother, or Uncle or something, I bet they are totally
lost within the first sentences. At least if they are English
speakers, other languages may overload the word differently. Dont
forget to explain the difference between "canonical master" like
Linus'es master master, and distinguish it from the various other
"master" branches that would be out there, and how most of them aren't
the master at all.

Anyway, just my $0.02. Thanks for listening.

cheers,
Yves
