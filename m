Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B125C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF5E23976
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgLGWXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 17:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgLGWXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 17:23:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2324C061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 14:22:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r7so3068373wrc.5
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHmGrVwkJD9qSf0UxNpdz0cJERYvRd8OMuHIrYRQrnQ=;
        b=GCRnZvMbs+S3CSMBpR9PvkIJvQx/cwZ8JJp4dHN/A8DebYm6RBlf8pSpHe+Z4IS5zK
         /8lzASpHRfa516WLh0r9H5CAzDwoNejxmx7snABsN7+ipD38Ca+igpizmQCAAOg9ypUL
         gwDMScNl2xH8cFPeOjJ8p7M2Do8q0YuIurXx8xJmIOxQoztsGYaVWExzWlnrEFotpXSI
         6r1tzdn8VzHa0QBV3W3KmWTvyoLCOoGkmT5CX+TjToELwaCkeOljvEx1WVZ2+YQ0ljNf
         ZA9T1cyai81Jau4gvKgITpoISt9Xha23OVlM4coc/ZkLQuB3Nb9RsJySLZiK4taMkuCv
         SbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHmGrVwkJD9qSf0UxNpdz0cJERYvRd8OMuHIrYRQrnQ=;
        b=ngeVs8CFYgvpQ4vKsnvmZkLusUu+EquwBJpEHl0ynB5m98oLP9lXCjXHZXJO6Lg46z
         8Bl4xv3D8bvG25lOwVmWE8qvsGeAAM5EC4/m4oScah87G7MY8bhgcZAAfvqXaSGRsUp4
         9k+vOkO3aH5A/WBbIho+bcUVqtL7OVdCTCK4nu/D6rm6DeCYoiXwlAQBRdUeAwJl2KEM
         iQugl6wdMpDIr11mOrX70mLITL/wHViTorAg8bOZW6rDlULkXeDoyBGMivRAgx+Oq8wq
         OuMX8vvlaPmx3DECsR+kh89KRrK73ksdjf0OpKxtI4nxU9ingzUxVG5LuVoKWK0zQl0D
         Bjyw==
X-Gm-Message-State: AOAM533IOeAjoZLeCj00GyFXqOGnZdywa2BSwGVNTajkw9NhnvxZ+Ml/
        Y+dsuYsMMjl3BeJJ1akHWg4i4SVi7rFFCq4tJAI=
X-Google-Smtp-Source: ABdhPJxAtQAz9I3vpdyaOWgj35MGyAsNaGGMtI2/BVtjOhh0w6656seAViYVIvWAfdOrh1ocKtUEPdMFOUz343PwpYM=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr22122883wrv.255.1607379771529;
 Mon, 07 Dec 2020 14:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
 <20201205195313.1557473-2-felipe.contreras@gmail.com> <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 16:22:40 -0600
Message-ID: <CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 2:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > We want users to know what is a fast-forward in order to understand the
> > default warning.
>
> The intention is very good, but ...
>
> > +------------
> > +       A---B---C master on origin
> > +      /
> > +    D---E master
> > +------------
> > +
> > +Then `git pull` will merge in a fast-foward way up to the new master.
>
> ... I find the phrase "in a fast-forward way" a bit awkward.
> Perhaps use the 'fast-forward' as a verb, i.e.
>
>         Then `git pull` notices that what is being merged is a
>         descendant of our current branch, and fast-forwards our
>         'master' branch to the commit.
>
> or something like that?  It should be in line with the spirit in
> which glossary defines fast-forward, I would think.

The glossary defines a fast-forward as:

  A fast-forward is a special type of `merge`

So, if you consider "merge" a noun, then a fast-forward is an
adjective. If you consider it a verb, then it's an adverb. But it's
not a verb.

If it was a verb, then we should have `git fast-forward`, which may
not be a terrible idea, but right now a fast-forward is a modifier.

At least that's what I have in my mind, and the glossary seems to agree.

> > +
> > +------------
> > +    D---E---A---B---C master, origin/master
> > +------------
> > +
> > +However, a non-fast-foward case looks very different.
>
> s/foward/forward/ (the same typo exists above);

All right.

-- 
Felipe Contreras
