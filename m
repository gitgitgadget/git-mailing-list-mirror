Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DA7C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 10:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BB42074D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 10:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvofSNuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgCWKhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:37:17 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36988 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgCWKhR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 06:37:17 -0400
Received: by mail-lj1-f177.google.com with SMTP id r24so13979733ljd.4
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 03:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFYZbREU/1uV6zIg5h7SLwNbXzsBHqdtQUPnizdw5BQ=;
        b=kvofSNuq4UFJCrjFz2zqEqWCe5UQ7n8iEx1FpbY6aZ2XGhvvQNqZmOzwbqIc/Eu6lt
         g1h+8DI5e8d5Go5Z5wCxTUBE5d9pdZfSUeaue7yhVjr1Ss1+F77kLeGMZoFvGFvnZWoG
         CrskEmry3BVlXzr3z1TRb1EL1UO9pBWiSt4tu80Sud6CpOpQa1epax62QOS7maDxpq16
         wkEpp7xoLxq9isqiglxeAvseB/n/zbOREtuOubT/D8Z1LVQG4aFYuwEJbbRy+/gN3D08
         RpH6dSiRtr2ALh/BVnPjgA5GalzgGCHnqK7XqezYaGt5FjuEAclojpglojnzbkIoBeyc
         981Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFYZbREU/1uV6zIg5h7SLwNbXzsBHqdtQUPnizdw5BQ=;
        b=eR48sce3i4+WU2JP9373ch+k08/WZgQ85efQUIdjeFrZ24IZlNY8kE0LRFwW2R2SVo
         lpPAMgsylt5SiMp7xKDX5WRFq7aEmNj8ILTpvLklxHsAS0irlN9YdrcodSrioydNUh6l
         OtxTMgoF+GmIQlKvFb9XGEkHx9POHLLQdffRefeiXEnqHbfKX+9vxzKZGaKh5EqIKWOW
         QqHY7ligU6PtTv57pNqqz/dy5CnXJSNlfVKSf8a40HVx9h7bve7jVrzLQBq8l1oQWBSS
         cZym9Uw9zjsDdzQusG+hyxFbbY5ZpqAb39zvHNX5x1o5YEFvvro4nZmGGr6AIZ4EzoqF
         OnCA==
X-Gm-Message-State: ANhLgQ2CMQSRiSQXTcuQQ0qa9y8e38Vj5Qil66kFxQHkzwdzg6o8DVIw
        Hctcj36vfB8bOKlZTq8vwIX3pYVb1j/5ulW2Rr4=
X-Google-Smtp-Source: ADFU+vsekWoV/AAPbkVRzCBvtqX6BScdY6/gDmPnOztOI43TKVmXfZvsa+24gHZHUL9Nlodk4AYt/Kp4DhQJN917Umg=
X-Received: by 2002:a2e:98da:: with SMTP id s26mr13915894ljj.155.1584959834191;
 Mon, 23 Mar 2020 03:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACuU+s80UPZnwQfd1rXBVyMaE0FmpYNgf+wPLjOo0M7kYNWx1g@mail.gmail.com>
 <CA+CkUQ_85jb-QBVXioa7c0dufzgKtOmaym9K8KK5eRBvjcLK5Q@mail.gmail.com>
In-Reply-To: <CA+CkUQ_85jb-QBVXioa7c0dufzgKtOmaym9K8KK5eRBvjcLK5Q@mail.gmail.com>
From:   Harshit Jain <harshitjain1371999@gmail.com>
Date:   Mon, 23 Mar 2020 16:07:03 +0530
Message-ID: <CACuU+s834u=sdJ187n2HaK6CBJBBNfYU3dao5=G2X_pXREaSSQ@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal v1] Unify ref-filter formats with other
 --pretty formats
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hariom,

On Mon, Mar 23, 2020 at 3:12 PM Hariom verma <hariom18599@gmail.com> wrote:
>
> Hi Harshit,
>
> Apart from your name initial(i.e 'H') and project title, the proposal
> itself gives the mild feeling of mine. Wait did I just said 'mild'?
>
> Well, I'm --pretty amazed to know how closely we think. Taking a look
> at someones work is always a good point to start.

It is very disappointing to know that you feel this way. Please help
me understand,
about why you feel so. Apart from this example of yours
"For instance, note that "%(objectname:short) %(contents:subject)" is
similar to '--pretty=oneline'.
Now one can try to find how 'oneline' is implemented in 'pretty.c',
and could modify that to use
the 'ref-filter' API."

which I later myself researched and verified as well, I haven't tried
to copy or use any part of your proposal.

I feel that the spirit in open source communities should be to keep
learning from each other and build up the
whole thing together. And in the same sprit, I looked at this example
of yours, found it really insightful,
researched and verified it on my own and hence, included in my
proposal. (not knowing that you would feel otherwise)
Just to inform you, now I have also removed this example from my proposal.

In addition, I would like to tell you that any two proposals that are
for the same project are bound to
have some generic details looking similar. For eg. description
mentioned on the git page,
mailing list link, code links, etc.

Further, if you still think that there are some parts in my proposal
that are copied from yours, just email me,
and I would definitely remove them from mine.

> Don't just stop
> here, you still got plenty of time to research more on pretty.* and
> ref-filter.*
> And you may find something more crucial that I wasn't able to find.
>
Thank you so much for your advice. I will definitely keep researching
on the project and hopefully we
both find something that makes our proposal stronger. Good luck.

Kind regards,
Harshit Jain
