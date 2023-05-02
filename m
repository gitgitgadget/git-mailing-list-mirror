Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F1C77B75
	for <git@archiver.kernel.org>; Tue,  2 May 2023 22:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEBWg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 18:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBWg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 18:36:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C9F19A4
        for <git@vger.kernel.org>; Tue,  2 May 2023 15:36:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f0a2f8216fso288801cf.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683066984; x=1685658984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JswsP9BTkBbTNK0O0A5PMSlgttKxtXCplJGiWEpQJY0=;
        b=z/T5H53d9eZCVwArUG5Tex2DE5+n8Uku/pmz/Xss39hyunELEA98tY5J+xTppuuSRh
         RF2QZoZIX7f36SBN4rbJMr6gns8uD3658UWZgBbuf6XKOPzC6uKowt40zyHXzjQflkeZ
         sB5lUP15PolURUVlj00otcG4McRWsMcyjBOJGGYEWJm41Tk1MCJRrIGYB8SqH0FIKkPc
         rRMzt4VC0Ok+XMHqAblagTpjoxa7sUxgRs24S796EJ81OQimDx6xcBD6RBUZRMKmOChx
         NDBu4k0WNNNfEplNGyP6cPo7Gj8FcydTe5QUcoBI63w8awW8rqH+HHeDF+edAlxVfOBZ
         brDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683066984; x=1685658984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JswsP9BTkBbTNK0O0A5PMSlgttKxtXCplJGiWEpQJY0=;
        b=fgaMVyCJDYFjzBWCl3rJqbBS8Xh5YXYdZxzHryBd++Gv2UiEnaZgHnefbWHWCZg8r6
         7Wsg0Epx/3/IodR9itXODzde4I4LdLvvTDta861A5Ji+3gKmRwRx95nC6+YX/iWqWgNi
         VmEJASprGrhxWUutxRyZbBPimqdWfHaMo4kAhCseZiaUhVb7tZznYuQ0aDZTI9VTz8dy
         92rS2R9gK8mXO8PmnZgYzPlnknk+C5G8wwi5IguLenff2AYvX5jqJ/o/DcM0FJEXMyFU
         NIhzboUK8jO1FvnjnrkPUrORxbmLLiR4qMdT8z8d/LvbJ82Oj2jbhkIqko6EfWxz8+2L
         Krxg==
X-Gm-Message-State: AC+VfDwTeaR/aZSbSRsj+RH5vlfVo8NyKAhBPMIQYKcvIfOn2s3/Tmld
        lgqWrgJEoVnZMqsQE8aNmXNd/4E1zohuzPyhfa4Vjg==
X-Google-Smtp-Source: ACHHUZ6b2Qkq4sAAlq/INRSJktAU/6NgqWYIFP0xnM4mrLPkhlnSlH+FyTgnJMK+BdYE+5xECzOeVqHnPgiZuYtnx60=
X-Received: by 2002:ac8:5744:0:b0:3e3:8c75:461 with SMTP id
 4-20020ac85744000000b003e38c750461mr138605qtx.6.1683066984475; Tue, 02 May
 2023 15:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com> <xmqqttwuxtnz.fsf@gitster.g>
In-Reply-To: <xmqqttwuxtnz.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 2 May 2023 15:36:13 -0700
Message-ID: <CAFySSZCz=ydmOZ+580Xhpp93NJbqyL21pPU=wfme_-zj6m8agw@mail.gmail.com>
Subject: Re: [PATCH 0/6] strbuf cleanups
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2023 at 3:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Strbuf is a basic structure that should function as a low-level library
> > due to how generic it is. Over time certain functions inside of
> > strbuf.[ch] have been added with dependencies to higher level objects
> > and functions. This series cleans up some of those higher level
> > dependencies by moving the offending functions to the files they
> > interact with. With the goal of eventually being able to stand up strbu=
f
> > as a libary, this series also removes the use of environment variables
> > from strbuf.
>
> I touched a bit of the same in my review for 1/6, but the main
> thrust of the series is that you want to make strbuf.[ch] mostly
> about "string processing primitives".

Thanks for clarifying the boundary I was attempting to explain in my
cover letter, but unsuccessfully did so.

>
> Any meaningful features relate to more than one conceptual things,
> e.g. pathname functions work on "paths" (that is one) and it may
> store computed result in a "strbuf" (that is another).  We have
> historically called them strbuf_do_something() and gave the pointer
> to a strbuf that receives the result.  And this series wants to
> reverse the course and want to see strbuf that is more pure.
>
> That's fine.  The strbuf has become so successful a data structure,
> its use has become as ubiquitous as a plain string or an integer in
> our codebase.
>
> But if we were moving in that direction, I have to wonder if some of
> these functions also need to be renamed to lose their strbuf_
> prefix.  A function that takes a pathname and creates a directory
> there is not called string_mkdir() just because it takes a pathname
> as a string.  A function that takes a string buffer and a path, and
> reads the symbolic link content is not called string_readlink() just
> because it learns the symlink target in a string buffer.  What their
> parameters mean matters a lot more than what type these parameters
> are represented as.

I agree that with the functions that are moved out from strbuf, they
should be refactored in the future to the form, taking absolute path
as an example, strbuf_addstr(sb, get_absolute_path(path)) or something
similar.

>
> With some other topics in flight, merging this to 'seen' and merging
> this to 'next' may require different merge fixes, but I'll manage.
>
> Thanks.
>
