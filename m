Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAEBC433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7852B2065D
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 14:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vK3e8ENe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGNOuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgGNOuR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 10:50:17 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12907C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 07:50:17 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id v26so3731175vkn.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EJVgB96ult5qy/EyLNK51Lj4u/1uLMNYCkXGfmdmrKw=;
        b=vK3e8ENetqTfIFGklmEGRlz0O1rsYeefHSFJlzeZVTNjEKkld5Nt0AGoDR9qdwLZBY
         kapztnAaYZ4oQg/f3hJCPO4khC7shAtX+9a8Zz8hGGvTj/AwffDz7ZssM4ifyCvjMt8X
         2s9iHnGRuUfvivMAJXf2pSaWB9cXa1/Swz0+ja/OHKC8Z1bTU9UKTP2bU2zu+n3X0vPZ
         z46m8mpPh/xqJAz/kHoXPzNC3kkr7biwgUrxBRE1bymbzY7Y7FbxPpaf1vTd9vhk8qNe
         xliyge9IWUUs0eMmIpckR70h/JV77NaI3yiDBEyyuAd38cKaZDvcbf68T0w+0ixOkhqk
         5pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EJVgB96ult5qy/EyLNK51Lj4u/1uLMNYCkXGfmdmrKw=;
        b=Ex67g1jX/A7rAXClY5IH98Y16qJssEzdUtfJsFwtRpDCS3meofLObRv65XBi9KR7Sg
         YZ4IjAC36dQVzyW2aaqo+DL0pZ4OIkxKr3524r7j/ny2pOvdbHSF1Mj5ZIFaxCanEoEA
         kQMUEn4xsJ9gnQKwjlEuYiur8dz98z0rmUY8YFMQ+R/OpWdXrkN6UsFfkdVB6nw7YmcZ
         he+XR1iOw9hxrHSv9rY2pudPFQnMLp4Bq6Pw6Y1RskVWIW2cSbhEp2kakRHpVZAiKw1q
         0S6zMkCvo4qHlDjA/tbf1D+b/iiAwGheeoRPZVg0q1LPF8EsyJiKPVmoovoR83xs/j0R
         FLTg==
X-Gm-Message-State: AOAM531ug9qkRCf/C5NplbFbIS9u7LQHHDMJscwM5uAg2d9ATp5QeBF9
        uClpwrof3At55EG6c84yKCWRkZGjk5AFCfNCZhjpfliV
X-Google-Smtp-Source: ABdhPJz8Bf2lN62Pse7aPfXJq3RH6im89rBMLQ+xEZyRiozQOd/cQPVUeEf1W0UTj3zJUIU3uKZnZbrjXvjUKLL766w=
X-Received: by 2002:a1f:30d8:: with SMTP id w207mr4068741vkw.62.1594738216218;
 Tue, 14 Jul 2020 07:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594666410.git.martin.agren@gmail.com> <280943ef56a2a777ab0162b8ec4ba0166cc2095c.1594666410.git.martin.agren@gmail.com>
 <CAPx1Gve7Sy5BUdRztVoVNVZgdqm14dvD=36eYzLPed5YMQeMEQ@mail.gmail.com>
In-Reply-To: <CAPx1Gve7Sy5BUdRztVoVNVZgdqm14dvD=36eYzLPed5YMQeMEQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 14 Jul 2020 16:49:58 +0200
Message-ID: <CAN0heSoNFdLzxV2GV=KDafypLkQmxc28RdKzJtHcVFHx3P97Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-diff.txt: reorder possible usages
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Jul 2020 at 00:04, Chris Torek <chris.torek@gmail.com> wrote:
>
> On Mon, Jul 13, 2020 at 12:10 PM Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
> > It then goes on to say that "all of the <commit> in the above
> > description, except in the last two forms that use '..' notations, can
> > be any <tree>". The "last two" actually refers to 6 and 8. This got out
> > of sync in commit b7e10b2ca2 ("Documentation: usage for diff combined
> > commits", 2020-06-12) which added item 7 to the mix.
>
> Moving this down (as you do in this patch) is the right thing to do,
> but I'll note that formally, the word "that" in "forms that use ..." is
> part of a restrictive clause, so it means "find the last two examples
> that use dots".  (In American English at least, the unrestrictive version
> would be set off with commas, and use "which" instead of "that".)

Thanks, I hadn't read it like that, that makes sense. I'll learn to pay
more attention to the difference between "that" and "which", which(!)
I'm not sure I've fully appreciated before. So if one qualifies the "..
notations" a bit, one might actually achieve something that passes,
language-lawyer-wise, even in light of the two completely different uses
of "..":

 ..., except in the last two forms that use ".." range notations, ...

or, if "the last two forms" doesn't actually add anything,

 ..., except in the forms that use ".." range notations, ...

But I'm not sure that would help users at all, even if we might be able
to say, "well, technically, it's all correct..". ;-) "The last two"
seems more helpful to the reader, although it does carry the risk of
getting outdated.

I'm glad you agree with the move.

> > An added bonus of this commit is that we're trying to steer users away
> > from `git diff <commit>..<commit>` and moving it further down probably
> > doesn't hurt.
>
> Q: Just how hard should we try?  In particular, would it be good to mark
> the two-dot form as deprecated in the documentation?

In [1], Junio seems to be of the opinion that we can't rid ourselves of
it. But yeah, I suppose we could still add something to gently get the
reader to skip that particular paragraph and learn some other diff
syntax or some completely different part of Git instead. The word
"deprecated" seems to mean "old-school" to some and "slated for removal"
to others. Maybe something along the lines of "kept for backwards
compatibility to old habits".

> I anticipate
> objections because it's not possible to omit `HEAD` without using
> the two-dot form.

I always just type "HEAD". With tab-completion, I find it just as easy
to go "<tab>H<tab>" as <tab><bksp>..".

Martin

[1] https://github.blog/2020-04-07-celebrating-15-years-of-git-an-interview=
-with-git-maintainer-junio-hamano/#if-you-had-a-magic-wand-what-part-of-git=
-would-you-fix-or-change
