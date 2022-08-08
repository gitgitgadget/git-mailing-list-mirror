Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F06C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 21:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiHHVBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiHHVBB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 17:01:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7DF49
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 14:00:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gk3so18759442ejb.8
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8OTd2hcH03/vh6xbt/qcLzRvFAFzK1XLAxjgvgqk10E=;
        b=ijoLgockbMT/OHbVkeOgEo7eHeoLiP5VQB55rZpUTxakWVaC/kyJm8Xk4Rwn1p3HwG
         tfneF/SCwizD25nnC1kktTsZU8OuxVEqYUBMt3OPtoJGSBk9HEx//piVF0KZpbt+7W8k
         0fRCXc+auyGMIAodXLCpA9MJqt4Iws/ya6D6OoIpR9mwOXNvTgbMHFvoUsomtyqqcMLw
         ZLUAqef0+tRnK5qCehw0ISVrY/488KFBPHmq3CsG02lesfksgGg2o5m5VB7GxbBe8Rzw
         h4P5jd6IJDeS0koPAt+ADhdvLJCHqJZdiNcMd6wZM7QKJjWKa2sW0yiKpZQ862rFaZmc
         vjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8OTd2hcH03/vh6xbt/qcLzRvFAFzK1XLAxjgvgqk10E=;
        b=DDHtEkOTvjZ1xbcXPqCwSbbtd4/fzmMlQUY46tzI9gYy3Kl/V5U8pra54/ML/TXBbA
         A0CS/8/Nyt/6Flp1SON5rSmhb/fE+4q1dBAYwudrfDCmU2frd5zxpVNm46Ssfhazs7lx
         TDKF888MOh7FFhI/6eeDvarL6FmHCB9DGf5ZUniRTAm5aO8GNR5jFgi5e1D8/jVLYl5I
         NMquokk5X+xf/NWHxmH2NrGG142zaQm51WJhZTYqxtMt1wQZwATh6ZXANqi77LJrxkMT
         wPb2y0y7yAjXyE8uJcGMh6nx6IH/4iEavpc+E4fuO8fOaCg1RxsqacNj/X1UIXnLAiYt
         jw+g==
X-Gm-Message-State: ACgBeo0FfJcvumA0hLl7xC//Lwjm5VCuCUoc2juAll3VVFJv9qEt1Yb4
        w5O23jZauicjlge/7OEwGIsIA0/AyfxIdAqwuYXbOuAsivI=
X-Google-Smtp-Source: AA6agR62VJhS3wP/mpRfXqy4tzeoRoKLm9jJbzOUEGTSjgxUQ3zb/xZnwVMOlqTD3y6Vd5122z84J5SqVuL76uvda+c=
X-Received: by 2002:a17:907:2c62:b0:730:d9b9:aabb with SMTP id
 ib2-20020a1709072c6200b00730d9b9aabbmr14093627ejc.84.1659992455787; Mon, 08
 Aug 2022 14:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220808053459.184367-1-greenfoo@u92.eu> <20220808053459.184367-3-greenfoo@u92.eu>
 <CAMP44s3v_4PdOfaviXCxik1LL5k_kkmZ2Yp=+Qfb8CqyNCdMUQ@mail.gmail.com> <YvFSgjK0P5kzoOfg@zacax395.localdomain>
In-Reply-To: <YvFSgjK0P5kzoOfg@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 8 Aug 2022 16:00:44 -0500
Message-ID: <CAMP44s1E6B4gG8nzNJwqAkYGQRns87i7iJFw=0yRadw2QL3-Ng@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mergetools: vimdiff: fix single tab mode, single
 window mode and colors
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 8, 2022 at 1:14 PM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> On 22/08/08 01:37AM, Felipe Contreras wrote:
> > On Mon, Aug 8, 2022 at 12:35 AM Fernando Ramos <greenfoo@u92.eu> wrote:
> > >
> > > vimdiff3 was introduced in 7c147b77d3 (mergetools: add vimdiff3 mode,
> > > 2014-04-20) and then partially broken in 0041797449 (vimdiff: new
> > > implementation with layout support, 2022-03-30) in two ways:
> > >
> > >     - It does not show colors unless the user has "set hidden" in his
> > >       .vimrc file
> > >
> > >     - It prompts the user to "Press ENTER" every time it runs.
> >
> > For the record, in my version these two issues are fixed in a much simpler way:
> >
>
> Yes, it was simpler but remember it had two small issues:
>
>   1. In "vimdiff3" mode, if you switch to buffers #2 or #3, highlighting
>      disappears.

No. That only happens in patch 9. In patch 5--which is where those two
bugs are resolved--that problem doesn't exist yet.

Also, I'm pretty sure that's a bug in vim (of which there are many).

>   2. It treats a single tab with a single window as a special case, when in
>      fact it is just a subcase of a layout with many tabs where one of them
>      contains just one window.
>      The new patch series makes no distinction between them by keeping track
>      of the number of windows opened on each tab which, as you noted, adds
>      some extra complexity (but needed complexity nevertheless if we want to
>      have highlighting enabled in all cases)

That's not necessarily true. You are assuming that is the only
solution possible.

Even supposing your solution was the only solution possible, nothing
prevents us from applying your patch on top of mine. In git (and in
many other endeavors) it behooves us to do one thing at a time for
many reasons.

There's no reason to try to do two things at the same time. We can fix
the specific case now (which is urgent and needed), and explore the
generic case later on (which few people would care about anyway).

For the generic case, I took a look at your solution and noticed most
of the complexity comes from trying to guess the number of windows per
tab. There is no need to do that.

I experimented with doing "bufdo diffthis" even in cases with multiple
windows *before* doing anything else, and it works. There's no need to
do "bufdo diffthis" afterwards, and there's no need for "windo
diffthis" either. There's also no need to store the current buffer in
a variable.

It *also* has the added benefit that now multi-window tabs now show
the diff colors for all the buffers, not just the visible ones (which
is what I would have expected anyway).

This solution is not only simpler than your solution, it's actually
simpler than the current code.

--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -68,7 +68,7 @@ gen_cmd_aux () {

        if test -z "$CMD"
        then
-               CMD="echo" # vim "nop" operator
+               CMD="silent execute 'bufdo diffthis'"
        fi

        start=0
@@ -221,7 +221,7 @@ gen_cmd_aux () {

        if ! test -z "$index_new_tab"
        then
-               before="-tabnew"
+               before="-tabnew | silent execute 'bufdo diffthis'"
                after="tabnext"
                index=$index_new_tab
                terminate="true"
@@ -336,17 +336,6 @@ gen_cmd () {
        CMD=$(gen_cmd_aux "$LAYOUT")


-       # Adjust the just obtained script depending on whether more than one
-       # windows are visible or not
-
-       if echo "$LAYOUT" | grep ",\|/" >/dev/null
-       then
-               CMD="$CMD | tabdo windo diffthis"
-       else
-               CMD="$CMD | bufdo diffthis"
-       fi
-
-
        # Add an extra "-c" option to move to the first tab (notice that we
        # can't simply append the command to the previous "-c" string as
        # explained here: https://github.com/vim/vim/issues/9076


> > >         # Add an extra "-c" option to move to the first tab (notice that we
> > >         # can't simply append the command to the previous "-c" string as
> > >         # explained here: https://github.com/vim/vim/issues/9076
> > >
> > > -       FINAL_CMD="-c \"$CMD\" -c \"tabfirst\""
> > > +       FINAL_CMD="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"$CMD\" -c \"tabfirst\""
> > >  }
> >
> > These diffopt settings look awfully familiar.
>
> I would go as far as saying they are the same :)

That's actually my point. You copied one of my fixes without
mentioning it. Not only is it not nice to copy code without
attribution, it's not a good practice to sneak in unrelated changes.
If later on it turns out the diffopt stuff introduce a regression,
people will have a harder time figuring out what in this patch
triggered the issue especially since it's not mentioned.

The diffopt fix is completely separate from what you are trying to do
in this patch. It's good practice to do those kinds of fixes in a
separate patch. My patch [1] does only one thing, and it explains why
in the commit message.

> As you explained, it is better to keep these options explicitly set so that
> buffer diff'ing works in all cases.
>
> Notice that in this new patch series, however, these options apply to all
> layouts (and not just to "vimdiff3"), as we want highlighting to also be
> enabled in multi-tab single window layouts.

Yes, but still: it should be done in a separate patch and explained why.

Cheers.

[1] https://lore.kernel.org/git/20220807024941.222018-7-felipe.contreras@gmail.com/

-- 
Felipe Contreras
