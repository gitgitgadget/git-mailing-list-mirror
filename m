Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D6C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40363613AF
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhEBFhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 01:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBFhB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 01:37:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FE0C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 22:36:09 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p8so1600152iol.11
        for <git@vger.kernel.org>; Sat, 01 May 2021 22:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mOKSu2R7lI7E42RGcYeAX4xulfcmI4ICuzyNbWEmCUI=;
        b=uSFEWmn3vzNxbYl0q1ZT7yOKaVvS7cuDqehl7bA665vM72GJcotB9KOxnl0+C9/EAr
         drJ6LfN00cm1i4TO70gnt8UGq6XzczY2K5F4MD7+KB5kOIuH+ihcWQV58Mr8q+Rw8pHl
         WKojZH6E70vmJGqKrieXtzLFNO9BqN4j6khff13c5UxRRkaSeEc88R9Isq/FvQBbssKp
         40vPdAQfEQJhfCzjvdRYTnwlWbeSVwAvG5BSNx268vy4Nm4AmclBnMi2mPPr1u0kILYy
         /FDJ80Q0e5CYBfhZ07atBwImNTdElDTrEK7t3vFZPP8GPrzPHrEH3iuhI2gzFMuUvCWb
         mOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mOKSu2R7lI7E42RGcYeAX4xulfcmI4ICuzyNbWEmCUI=;
        b=uSTh8DLwlq9J7gAJKPDF2jRp3Qhwo6U6LIwB8Wc1chtf2NPbNfXgQ+7+j0zxceY9/d
         qqYP1EIq+yTyageNXHYG1DWKwLeiPowEf960dc3PKuG/wft5N4r451NJbeUx8LNhS/9F
         5kjLm4DYRGEVzerG5sPyp1AcQ1GSapEhVqvtJP08BNjcvfPwlhrs9SWgQEuJWCxyFZKm
         lwWeXiFNnWz/d/UAo+7tzIJsjwENaQkYL9YWJ1Z1mjlIMkdh9cozzreD1Xj4tmYgjMZ/
         5R6jRJM0MV0f8/hUv8Ue7Ip1CNLz6IUCJWgMTV1LWP7knAT3iognlvP3zg8NhdB3UAdE
         JH8w==
X-Gm-Message-State: AOAM532ujCVU2mePKI6oGCXqnSCjnpFfjqAjfygSU5B1lYN4TSJpvdK8
        xZW/Ik2jbOcRPfPiIlXrbtW4wA8PZqelaxLwo4zV5MpPO2V+C3Jy9Eyy5Q==
X-Google-Smtp-Source: ABdhPJyomHK2uulqu0PU9AI4AIEhyshPYuLpRxcsjJHUdljZHGwMqvROceRLxMcV3rUV8fjRlQzLp/UHRXrRiSYG5N4=
X-Received: by 2002:a05:6638:1242:: with SMTP id o2mr12564173jas.10.1619933768683;
 Sat, 01 May 2021 22:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <YHaIBvl6Mf7ztJB3@google.com> <xmqqfszqko0k.fsf@gitster.g>
In-Reply-To: <xmqqfszqko0k.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 2 May 2021 13:35:56 +0800
Message-ID: <CAOLTT8Sr8hMe7jOaBNb10szbw219HP+FB439jgZu-xua7K9Xug@mail.gmail.com>
Subject: Re: Pain points in Git's patch flow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Haaaa, everyone, I am this example :)
Sorry I haven't checked these mails cc to me for a long time.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8817=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=883:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> >  3. Do you think patchwork goes in a direction that is likely to help
> >     with these?
>
> So here is a real-life example.
>
> Let's say somebody is looking at a "gentle ping" [*1*]
>
> znh> The patch seems to have fallen into the crack.
> zhn> Jeff and Junio, willing to help?
>
> How would we figure out what happened to the patch today without
> visiting patchwork would be:
>
>  1. Visit the message at lore.kernel.org/git/ [*1*]
>
>  2. Notice that it is a response to a message, and click the link to
>     be taken to [*2*]
>
>  3. Notice that nobody commented on the patch.
>
>  4. Type "f:zhening ref-filter" to the search box and search, with
>     suspicion that this was an updated version of something.
>
>  5. Click one of them in the result [*3*]
>
>  6. This time, we can tell that this seemed to have had two earlier
>     iterations, and after reading the discussion through, the last
>     one changed the course in a major way.  Not just a new helper
>     introduced in the earlier rounds has gone away, but an existing
>     helper got removed.
>
>  7. All comments in the discussion for the earlier two rounds can be
>     read as supporting the new direction the latest round takes.
>
>  8. The fact remains that even if the direction has been endorsed
>     (see 7. above) nobody took a look at the implementation for the
>     latest round.
>
>  9. Make the final verdict.
>
> I use my newsreader to do pretty much the equivalent of the above
> without hitting https://lore.kernel.org/git/ but the above is
> written to use the web interface, in order to make it reproducible
> more easily by anybody on the list.
>
> Now, how can patchwork improve the above reviewer experience, out
> of the box and possibly with new helpe rools around it?
>
> I can see #3 would immediately become obvious, and I hope #4-#5
> would become unnecessary.
>

Here are my thoughts:

For the reviewers like Junio, after missing a new patch iteration, need to
review the past history to find the correct patch and related comments
from other reviewers. Just like I once read a github blog saying that
"patch" is also a special object in git. I would like to have a "new" tool
 which can link multiple related patches and comments.

1. Coder need Reviewers' help.
2. This new tool will obtained multiple different patches contents automati=
cally
or coder provided those pathes versions links.
3. This tool will analyze the differences between multiple patches
versions, get all
the reviewers comments and coder comments related to the "patch stream",
organize it into "patch graph".
4. The tool will notify the reviewer(by email or something else) and
show the links
and patch graph or patch range-diff. It can visualize the entire patch proc=
ess,
 It=E2=80=99s best that comments from different people can be displayed on =
one page.

In order to be more accurate, I made a picture [*1*].

Using this new tool, reviewers can choose to see or not see the range-diff
and diff in multiple different patch versions, Instead of the range-diff
automatically sent by GGG. When my second patch processing was greatly
changed from the previous one, I have to rebuild a new branch and create a =
new
PR, this is my pain point.

Thanks!
--
ZheNing Hu

> Anything else?
>
> At steps #6 and #7, there is human judgment involved that may not be
> automatable, but would there be some mechanism to make it easy to
> help these steps if the user visits patchwork (instead of staying
> in my newsreader or web interface to the lore archive)?
>
> I am of course not expecting to automate step #9 ;-)  It would be
> nice though.
>
> Thanks.
>
>
> [References]
>
> *1* https://lore.kernel.org/git/CAOLTT8Tis5Yjg8UR0c-i0BnqiFQvLXvDgxUQJ-Wc=
P6jjQPu9cQ@mail.gmail.com/
>
> *2* https://lore.kernel.org/git/pull.928.git.1617975348494.gitgitgadget@g=
mail.com/
>
> *3* https://lore.kernel.org/git/pull.927.v2.git.1617809209164.gitgitgadge=
t@gmail.com/

*1* https://github.com/adlternative/git/blob/pic/git-patch-pain-point-solve=
-idea.png
