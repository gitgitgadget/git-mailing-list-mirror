Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500B5C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 12:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1999964DF2
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGMHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 07:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhBGMHi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 07:07:38 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC7C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 04:06:57 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id q4so2796560ood.8
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 04:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9H17jD1TXcN/GlD53Vi34r86bi5kpF/odTMDZLtZo6E=;
        b=l/u1Y7I0BmKbfcIaqMr9wnw7VrZ0cWYO/pCGqgFIHd7ZdBp0ZzrHq9N3Nk2MUx8E56
         JWnPVyVLPEVaD6QtzYb0lkUrx/X9cV4OJmeOFSFcpUDLM3r92TAKN7SyFoEIVZa86beZ
         4oZC3J6DcFyNKgmX6FhD1ZdRL2ccofOn5w+IqW//NMPEcr7xGxi+LRe2o6JnYcYNFkje
         rr8I6cz6nspTJL/XTvojeFdRftlnz1VvN7qpQJ1L71GPe6ZvJ2JvbTz/hZP0UOVqrZep
         kNni6sDCvaN3q1AjSRJ8K2GWPIuDFFIRntdTnc59cVIlci9o+7+vRAxmeYuuuTwyxObb
         dKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9H17jD1TXcN/GlD53Vi34r86bi5kpF/odTMDZLtZo6E=;
        b=pjHn21O7KNiOkL75sPmvqL1sjFv6er70Bp/qTFWy3WLMQFulXvywU0Lm3Ng76xn5f/
         RK3BrJBXrEgdoDT4GOoFzwD9Aw18+cWylN4RLAuBlKvRBbYpPiq9NLLpquySskDGe3Ki
         SoH6TM94fm2i4+SfDcdyCCTOvkKNW+K3v0dATbgSqia/klRai2tbc7sNqgGAqKOadLdv
         +uDVSdGvdQLBmxJHhNfR6qoz+O79iPICZBKdN6+gNQfcDud9ahkv/2XTpWmtjQQN3ip2
         IMw3L1GnjwyjeElqAH75Zo7ugkcjTxxm5230DF8lxZzvBasAZJgrjF1vyesDVCpYkEzQ
         O1tg==
X-Gm-Message-State: AOAM530TIc0TfbnUyCsV9e5BNY44nvjWrhVEuoARAnYqerovk3oAtN3v
        ngl2ckHvnbmcKvsxUYRe5YFZZI1w7GyD2CRIerg=
X-Google-Smtp-Source: ABdhPJyXHLrg67zmKrFrSaZ55+vFmXyEe+tCdqBDMakyVq040VwAwB+kOe3IH1+xJC9LViiCNzGwal6F6wHZIyt/+cs=
X-Received: by 2002:a4a:decb:: with SMTP id w11mr9359559oou.32.1612699616800;
 Sun, 07 Feb 2021 04:06:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
 <pull.726.v3.git.1612602945.gitgitgadget@gmail.com> <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
 <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 7 Feb 2021 17:36:45 +0530
Message-ID: <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Feb 7, 2021 at 11:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +test_trailer_option() {
> > +     title="$1"
> > +     option="$2"
> > +     expect="$3"
> > +     test_expect_success "$title" '
> > +             printf "$expect\n" >expect &&
> > +             git for-each-ref --format="%($option)" refs/heads/main >actual &&
> > +             test_cmp expect actual &&
> > +             git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
> > +             test_cmp expect actual
> > +     '
> > +}
> > +
> > +test_trailer_option '%(trailers:key=foo) shows that trailer' \
> > +     'trailers:key=Signed-off-by' 'Signed-off-by: A U Thor <author@example.com>\n'
>
> This is *not* an issue about the test script and its helper
> function, but I just noticed that --format="%(trailers:key=<key>)"
> is expected to write the matching trailers *AND* an empty line, and
> I wonder if that is a sensible thing to expect.
>
> The "--pretty" side does not give such an extra blank line after the
> output, though.
>
>  $ git show -s --pretty=format:"%(trailers:key=Signed-off-by:)" \
>    js/range-diff-wo-dotdot
>  Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>  Signed-off-by: Junio C Hamano <gitster@pobox.com>
>  $ git show -s --pretty=format:"%(trailers:key=None:)" \
>    js/range-diff-wo-dotdot
>  $ exit
>
> Unlike the above, when there is no matching trailer lines, the
> "for-each-ref" in this series shows zero lines, and when there is
> one matching trailer line, it gives that single line plus an empty
> line, two lines in total.  The inconsistency is a bit disturbing.
>
> Is the extra blank line given on purpose?  I don't see why we would
> want it.  Or is it a bug we did not catch during the previous two
> rounds of reviews?

I don't think that "extra blank line" is due to this patch series.
Wait. Let me see.

Since "for-each-ref"'s original code does not support
"trailers:key=<KEY>", Let's check original code for "trailers:only":
```
  $ git for-each-ref refs/heads/master --format="%(trailers:only)"
  Signed-off-by: Junio C Hamano <gitster@pobox.com>

  $ exit
```
I see. The original code also gives an extra blank line.

Now, let's check for this patch series:
```
  $ ./bin-wrappers/git for-each-ref refs/heads/master
--format="%(trailers:key=Signed-off-by)"
  Signed-off-by: Junio C Hamano <gitster@pobox.com>

  $ ./bin-wrappers/git for-each-ref refs/heads/master
--format="%(trailers:key=None)"

  $ exit
```
when there is no matching trailer lines, the "for-each-ref" in this
series shows one empty line, and when there is one matching trailer
line, it gives that single line plus an empty line, two lines in
total. Seems consistent to me.

So this isn't about the patch series. Question still remains the same.
Why extra blank line?
Let's dig a bit.
Ah. I guess I found the reason. It's due to `putchar('\n');` in
`show_ref_array_item() [1]`. It puts a new line after each ref item.

Do you want me to include a patch to get rid of this "extra blank
line" for trailers in "for-each-ref"?

Thanks,
Hariom.

[1]: https://github.com/git/git/blob/fb7fa4a1fd273f22efcafdd13c7f897814fd1eb9/ref-filter.c#L2435
