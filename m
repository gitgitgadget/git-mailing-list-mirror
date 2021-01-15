Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5AAC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6014D22C7D
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbhAOIiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbhAOIiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 03:38:08 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823DFC0613C1
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:37:28 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id q25so7834611otn.10
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0p5Snoaa9aXyrE2oGGfhj05C0vyM3oMD7Yn8KsRomE=;
        b=ftdsXe6NZyGR5XHZwtSizd32knzk81bBG/i6Se5sRqL9GM5Gw+Vodk9qqGWVqiMcIh
         mnZEb68tfRAJjQcSpmGVuQ1Ejmhj8ui2cpxnmXSCWsxzE5QE0EiEkUNMpJZJmca7b2cs
         OzSg0K+QDi6YHN2C1C/9yd/hGXeruXFUtJSaP6vSp7TQXhT9KFYg/jJqaKC8+usmqlqI
         hTLf5auR7dJeFIQxmVuwmp7XdXaprJHNmWtxhoqy+8ce27AmG/CMfWOVFvRSPKLGo/se
         rT8Lz24PjECP39Wo6vLgRUFbBnPqJ7GNt2Fo+Km1oFTiZv9iarx8sjVIB5/s+oVcYcNx
         AR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0p5Snoaa9aXyrE2oGGfhj05C0vyM3oMD7Yn8KsRomE=;
        b=LyEpxYDBvGW7EE3GNZB0giHCj+t5A/WoV2fAfn10FDZfxemEoGwj9kJwrLddz2dZrP
         rFeVEk9MXQrGe66xhNkGonpC6HEH6IqafFP4km0GRfVQWlC1ZL08rXBhLmbf2v4EWjP5
         /BOAcEeiQQjLlR0O2DXJ8BiwQYPprbo5rqFa3UnuzgKpCdZd3dzBxQrEZanI7Ou2Ypt0
         r1ZtVEDw9QRqmQZ28k65SDPyWIFjIHvwne+e+v3sTFkaShKlti72mAnIugYvUe80MTcd
         9/Gs/Gu1QfwHm/mJdMLWneKhjmpQy0pnGv9np2Gn3Tq1EOWxhZhP7kVAVxX/b5ZjeZ1C
         o1yw==
X-Gm-Message-State: AOAM531j/0Zagw8JZ0JCpVm6BCWKUYzsbEjsrtiD4T74dgWs0EbcRw1T
        V5A3f1VofDOHgAlAVA4mLcKsjaYO/0M3K72dLtk=
X-Google-Smtp-Source: ABdhPJyiT3NguJFKRP7EpCn5ktIV10+AbQKf/jbqPzxz0ZPOVNKlFzHAgHyK/ZOCNF+MAkJSlxAf0lm90k8HvAVV/B8=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr277134otk.210.1610699847963;
 Fri, 15 Jan 2021 00:37:27 -0800 (PST)
MIME-Version: 1.0
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com> <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
In-Reply-To: <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 15 Jan 2021 14:07:16 +0530
Message-ID: <CAPSFM5f2g2KwSSDQj-6fm67X=gYGSMKarkfrPsNoJJr-UyKyDw@mail.gmail.com>
Subject: Re: How to implement the "amend!" commit ?
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Jan 2021 at 16:09, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> I've taken the liberty of adding some comments about the backwards
> compatibility of each option
>
> On 13/01/2021 01:15, Charvi Mendiratta wrote:
> > Hi Everyone,
> >
> > Implementing "amend!" commit would be an alternative to the
> > fixup!/squash! commit that addresses the issue as opened here[1]. Also
> > the related patches[2], adds the options to `fixup` command in
> > interactive rebase and supports the "amend!" commit upon
> > `--autosquash`. Next, after discussing with Phillip and Christian,
> > there could be 3 possibilities to implement the "amend!" commit (UI):
> >
> > Firstly, the `--fixup=<commit>` to have option like,
> > `--fixup=reword/amend:<commit>`
> >
> > So, `git commit --fixup` can have 3 options:
> >
> > a) `--fixup=<commit>`, work as of now, make fixup! commit.
> > b) `--fixup=amend:<commit>`, make "amend!" commit, takes changes and
> > also opens the editor for a new message (Here it adds a new message to
> > amend! commit's message body and upon autosquash it will fixup up the
> > content and reword the original commit message i.e replaces the
> > original commit message with the "amend!" commit's message).
> > c) `--fixup=reword:<commit>`, makes (empty) "amend!" commit, do not
> > take changes and open the editor for a new message(Here, upon
> > autosquash it will just reword the original commit message).
>
> This is the only option that is backwards compatible. `--fixup=:/<text>
> ` still works and can be used with the new syntax as
> `--fixup=amend::/<text>`. Note that we intend to allow accept any prefix
> of "amend" and "reword" so --fixup=a:<commit> would work.
>
> > Secondly,
> > As an alternative to above, we can use `--fixup=<commit> --amend` and
> > `--fixup=<commit> --reword`.
>
> This is not backwards compatible. At the moment If you create a fixup
> with `git commit --fixup=aaa` and then realize it should refer to commit
> bbb instead you can fix it with `git commit --amend --fixup=bbb`. That
> would no longer be possible. (You could still do `git commit --amend
> -m'fixup! bbb'` which works with `git rebase --autosquash` but is not
> very helpful when running `git log` or `git commit --amend -m"$(git log
> -1 --format=%s bbb)" which is a pain to type.)

I found above, "git commit --amend --fixup=bbb" as one of the hidden
features I had never used before. I also agree to go with first one and
working on the patch to apply it.

Thanks and Regards,
Charvi

>
> > Next,
> > To use only, `--fixup=<commit> --edit` to make the "amend!" commit.
>
> This is not backwards compatible. At the moment this combination of
> options allows the user to add some comments to the fixup commit
> message. To do that in the future they'd have to change the subject line
> when editing the message.
>
> Best Wishes
>
> Phillip
>
> > Also as discussed earlier[3] we are avoiding the use of additional
> > options like `git commit --amend=<commit>` inorder to avoid confusion
> > of doing similar things in different ways. So, I wonder which could be
> > the best way to proceed with or if any other way to implement "amend!"
> > commit ?
> >
> > Thanks and Regards,
> > Charvi
> >
> > [1] https://github.com/gitgitgadget/git/issues/259
> > [2] https://lore.kernel.org/git/20210108092345.2178-1-charvi077@gmail.com/
> > [3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
> >
>
