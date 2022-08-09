Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8119CC25B0C
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiHIA7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243964AbiHIA7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:59:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BB21CFF6
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:59:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m4so19661826ejr.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Jx+zq5RrkJsSk/5ExlTT1XDUlRiJDu6AS4gFuqPxqv0=;
        b=GVB2EYdLrJ/xS0jcKDVzWmVAO/L43j8JbXurIC77s1CJR22wPidKeLsCoEVBnvwKVZ
         4pnfJl1FVBLHohUrWSHr7lHXd3OSbrGCV1q33UwKr4Kc4g4sQHmNpUmoOaMJSIUnHSeI
         0AiBzUzNBdZCPIVvjvpL7yCe4aK69UoEohVYRt0pG2NcXMpjLa2HBQ4E23BkLNB81wnv
         H+klu64aB6RiJrzfTGseT7TlAiahJihEm/lEqxlOmOHg1/8k79YlDQwO94AaRC7vxWtH
         Yfxc7/eTd7G6KSyP2Lyr8q9kGrrkyVLeRof+sdLRgDZnaQJVCBHq4B0AWpEkUHWR62Tu
         PdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Jx+zq5RrkJsSk/5ExlTT1XDUlRiJDu6AS4gFuqPxqv0=;
        b=1/Lhd6cu8ipchK9QtIntnDFxkOyPdBzP31XWONLGHLklWd3MlrzYV4EfS0HQv3u7tl
         8UiX9528MhBZuTCUJYkgOIo6g7r+eG3j1PxxAkFW2OWooj/CMfj+Rx+LDUH+exCqgNdG
         LpueSgbfa1+kmJodpNgGISpVxIhGcXGKt6mRskvyYbLhp4xHPA0r4YABINua7XPu2f4n
         1oQUIMlFfJeAjxoANI+DgMCrH0S/1QkAUJY4zszdNON3LpUMBVo8kgJs6pBcUcgR5mQR
         2lMuXvLetoyxHqz+0XdeDCe9UWUN1TgN0d/UBFniheOMMkyo/A3Dc/UevPFmx0qi7F2d
         IQnA==
X-Gm-Message-State: ACgBeo2cfd6A799aVmiltifeO92M7v40YVIPNEdbEFYxQdUjT/zqozEE
        D7KPScuffY3iXrEaMLGPBJbwLjJHGyngUl10a+VrHS39qlk=
X-Google-Smtp-Source: AA6agR4tUaIt48fZVMYorL7A+4dKtEnkzLS0xpKB70qaWm5xn37Gtvj3FlXQ7nxs64MOsgPu26qmGL3S4t3bLpR+AzY=
X-Received: by 2002:a17:906:7304:b0:730:c3a8:cd7a with SMTP id
 di4-20020a170906730400b00730c3a8cd7amr14628429ejc.575.1660006759872; Mon, 08
 Aug 2022 17:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220808053459.184367-1-greenfoo@u92.eu> <20220808053459.184367-3-greenfoo@u92.eu>
 <CAMP44s3v_4PdOfaviXCxik1LL5k_kkmZ2Yp=+Qfb8CqyNCdMUQ@mail.gmail.com>
 <YvFSgjK0P5kzoOfg@zacax395.localdomain> <CAMP44s1E6B4gG8nzNJwqAkYGQRns87i7iJFw=0yRadw2QL3-Ng@mail.gmail.com>
 <YvGFbCZIhxoLlIzo@zacax395.localdomain>
In-Reply-To: <YvGFbCZIhxoLlIzo@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 8 Aug 2022 19:59:08 -0500
Message-ID: <CAMP44s0-aSFPnzHM2VHV6O+Eqm+_Sc1OPbugzG5dF7Pth6xC2A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mergetools: vimdiff: fix single tab mode, single
 window mode and colors
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 8, 2022 at 4:51 PM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> On 22/08/08 04:00PM, Felipe Contreras wrote:
> >
> > No. That only happens in patch 9. In patch 5--which is where those two
> > bugs are resolved--that problem doesn't exist yet.
> >
>
> Sure. I was referring to your whole patch series (which is what I was testing)
> not to a particular commit.

And I was referring to these changes:

--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
        if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
        then
                buf=$(get_buf "$LAYOUT")
-               FINAL_CMD="-c \"echo | ${buf}b | bufdo diffthis\" -c
\"tabfirst\""
+               FINAL_CMD="-c \"echo | set hidden | ${buf}b | silent
bufdo diffthis\" -c \"tabfirst\""
                return
        fi

Which do fix the two issues in a much simpler way. As I said.

> If I only apply some of your patches it is true that (1) is no longer an issue,
> but we still have to deal with (2).

Do we? Fixing regressions should take precedence over adding new
features, especially if nobody asked for them.

> > Also, I'm pretty sure that's a bug in vim (of which there are many).
>
> In any case it doesn't happen with v3 :)

Neither does it happen in my v2 patch series minus the last patch.

> > >   2. It treats a single tab with a single window as a special case, when in
> > >      fact it is just a subcase of a layout with many tabs where one of them
> > >      contains just one window.
> > >      The new patch series makes no distinction between them by keeping track
> > >      of the number of windows opened on each tab which, as you noted, adds
> > >      some extra complexity (but needed complexity nevertheless if we want to
> > >      have highlighting enabled in all cases)
> >
> > That's not necessarily true. You are assuming that is the only
> > solution possible.
>
> Only solution possible? Of course not! (I'm sorry if you got that impression)
>
> I'm just presenting one solution that works, but I'm sure there are many others
> (we could use "vim -d" in all cases or even implement a completely different
> parsing logic).
>
> Do you think we should try a different approach from the currently proposed one?

Yes. The proposed solution is too complex, and it seems to be trying
to workaround the current logic rather than fixing it.

It should be pretty clear at this point that we want to do something
either before, or after a tab is populated. So it would make perfect
sense to have a function that receives all the string that defines a
tab (text between "+"s).

Instead, the logic treats "+" as other separators, which is not the
case, for example, this clearly doesn't make sense:

  MERGED/(LOCAL+BASE+REMOTE)

Yet the code acts as if it does.

I wrote a patch that splits the tab parsing logic outside of
gen_cmd_aux() and the result is much simpler:

https://lore.kernel.org/git/20220809004549.123020-7-felipe.contreras@gmail.com/

> > Even supposing your solution was the only solution possible, nothing
> > prevents us from applying your patch on top of mine. In git (and in
> > many other endeavors) it behooves us to do one thing at a time for
> > many reasons.
> >
> > There's no reason to try to do two things at the same time. We can fix
> > the specific case now (which is urgent and needed), and explore the
> > generic case later on (which few people would care about anyway).
>
> You mean to apply your patch series and then apply mine? Sure, why not? But what
> do get get from that? (I'm just curious)

We get a simple regression fix decoupled from complex new feature
code. Additionally we get a little more readable code thanks to
get_buf(), which still does make sense even in your patch.

> I mean... v3 already works in all cases, right? Or am I missing something?

"Work" is not the only metric.

> > For the generic case, I took a look at your solution and noticed most
> > of the complexity comes from trying to guess the number of windows per
> > tab. There is no need to do that.
> >
> > I experimented with doing "bufdo diffthis" even in cases with multiple
> > windows *before* doing anything else, and it works. There's no need to
> > do "bufdo diffthis" afterwards, and there's no need for "windo
> > diffthis" either. There's also no need to store the current buffer in
> > a variable.
> >
> > It *also* has the added benefit that now multi-window tabs now show
> > the diff colors for all the buffers, not just the visible ones (which
> > is what I would have expected anyway).
>
> Oh! Ok, now I see where the confusion comes from: showing the diff colors only
> for the visible buffers is *a desired property* from the original design and not
> something we want to avoid (except for the case where there is just one window,
> which is what we are fixing now).

Who is "we"? I certainly don't want to avoid that, that's precisely
what prevents me from using this layout feature.

> This is actually why all of this work started: we want to see, in one tab, only
> differences between BASE and LOCAL and, in another tab, only differences between
> BASE and REMOTE

You still will be able to see that.

> *without extra diff noise*.

I don't consider color hints due to a very real difference in the code
"noise". This seems like a preference rather than something
fundamental to the tool.

> If we enable ":bufdo diffthis" in those tabs we get a mess (at least for complex
> merges).
>
> Imagine this:
>
>   - Tab #1: classical four windows layout (LOCAL, BASE, REMOTE on top and MERGED
>     on the bottom).
>
>   - Tab #2: two windows: left BASE, right REMOTE
>
>   - Tab #3: two windows: left BASE, right LOCAL
>
> We already see all highgliting and colors in the 4-way diff in tab #1, but we
> are only interested in the sepecific BASE vs REMOTE and BASE vs LOCAL in tabs #2
> and #3.

If "we" is you (plural), then sure, but *I* (and presumably other
users) am not interested only in that.

If we want to support both preferences the current code would not be
amenable to that. If we move the tab parsing logic outside of
gen_cmd_aux() as I proposed in my v3 patch, the logic is much simpler.

> > > I would go as far as saying they are the same :)
> >
> > That's actually my point. You copied one of my fixes without
> > mentioning it. Not only is it not nice to copy code without
> > attribution,
>
> You must excuse me here... I still find it extremely confusing to figure out
> which field to use for attribution each time.
>
> I added you to the "CC:" footer of the commit. Is this not the right procedure?
> Should I have done something different?

CC is just carbon copy, doesn't mean anything. You would have to ask
the maintainer for what would be the "right procedure" but some people
add "Helped-by".

> > ...it's not a good practice to sneak in unrelated changes.
>
> Should we split the patch series in more commits, then?
> Something like this?
>
>   1. Comment fix
>   2. Keep track of windows opened per tab
>   3. Update generated string
>   4. Add "set" options
>   5. Update unit tests
>
> I mean... I'm right with that sure :) Note, however that 2, 3 and 4 are closely
> related (ie. "vimdiff3" won't work until the 3 of them are merged)

Something like that, yeah. I've sent a new version of my patch series
with a proposal. Tests generally should be updated along with the
changes, it's tedious, but it forces you to rethink the changes you
are making. It also helps other reviewers see what would be the actual
result of your changes.

Cheers.

--
Felipe Contreras
