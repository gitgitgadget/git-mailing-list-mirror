Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2795C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6BF60EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhHCXdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhHCXdO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 19:33:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5D4C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 16:33:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u10so781689oiw.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdmQ2eZfy2tpVJPa6N2D2xtwTHtVH3xsYXcCUoqp5eo=;
        b=OHqtV1AaFkEsNvnvuVtG3r2FQ0etiN7Np6+XMXrhW9gHkB04KQA925F04kDLhVLLTQ
         egm8rNLhLy6w4jxYBY9YlQswooE6mcz3ARfJhsD9WQHSYB7KN0/LcgbsRESKZxLI1OQj
         13g6WHvQ8jZcZPmbKzOT6u43nYTbcR5dv4pzktXUsvZm3woCHezGMOpbYamnTbifQGzA
         pTfL5B5hS25W6bf+gNf7uA6cnsZkZPG+1de63T1VZDLoxZQFGlKVcuSg1R45blTqN4s4
         IKvz0CSkfBgDe2Yd3aT+8tmNmuJDdoGnL9GgeFvvQYhzpPOsBAW3aa5Q8h6cF+jWRsjp
         wPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdmQ2eZfy2tpVJPa6N2D2xtwTHtVH3xsYXcCUoqp5eo=;
        b=NKVnc8vkrPAFLTwQmuOctcbAkGjfgMDHTDPU1it/6yo6gfXljUeTF+kMGpHMrE2moY
         GwGXqa8Gx5poqjQ3Y86p8aj+268IDHxzZRMBJoXhjH4vkTwI3XLJHb9WtBxDEFDThSMD
         9h8BEMLdyP2bQifd+gzXgsTHOT0VqicpWwu3xc/WaNpL0MKOQpQJaqcoEMuOwq/b1DJx
         yyQIuyvCf9Q6IPAQtcuVc8vHD6/SY+vdA1JjuzczCWvdHXuG4ky5gvKTBE+B4XsFn+ZT
         +IqjbQNvfPf4iQYZhjpbtYP0LVe0sJBtkddqvHHYlDNV1IrXtNjGQfy9EegdPewzE4+W
         JMuA==
X-Gm-Message-State: AOAM533DmTFrhUHzVtrgUnIIqP70Wvw1lubbaOHWxdUiZ5mDVLMItbcx
        VrZtiYpmzr58JMdQbLK/1K9mftK+xTwnaxLws4E=
X-Google-Smtp-Source: ABdhPJx4psM9P+6Ss7K9IDY81spaUYe768FkIc+yjeUzbmyUJoZ/0d5dGcKFmp1eona1T5N1Lo4J/Zes4Zq4FYQnfb8=
X-Received: by 2002:aca:c0c3:: with SMTP id q186mr4873005oif.39.1628033581990;
 Tue, 03 Aug 2021 16:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <010702d08417f86da033ae8a6093ec4b9ce6e19a.1628004920.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108040058520.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108040058520.55@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 17:32:51 -0600
Message-ID: <CABPp-BFuHiBGC-JnneJYCUWbX4VAT22wTFh=W2msca9A7Yovjw@mail.gmail.com>
Subject: Re: [PATCH 08/10] merge-strategies.txt: fix simple capitalization error
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 5:01 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-rebase.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 7044afba362..b4429954480 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -530,7 +530,7 @@ The `--rebase-merges` mode is similar in spirit to the deprecated
> >  where commits can be reordered, inserted and dropped at will.
> >  +
> >  It is currently only possible to recreate the merge commits using the
> > -`recursive` merge strategy; Different merge strategies can be used only via
> > +`recursive` merge strategy; different merge strategies can be used only via
>
> I am not a native speaker, so I'm eager to learn what is the correct thing
> to do here. In particular since I continued in lower-case after a
> semicolon for _years_, right up until some native speaker mentioned that
> that's only correct if I continue with an incomplete sentence. If a
> complete sentence follows the semicolon, so the advice went, I should
> start the sentence with an upper-case letter.
>
> Could you help me understand the correct rules here?

First I've ever heard of it; I just presumed it was a typo.  I don't
pretend to be an expert on such topics (and although native speakers
may have an edge in knowing what "sounds natural", I tend to presume
we are less likely to know the rules).  However, some quick internet
searches suggest that different style guides differ on whether to
follow a *colon* with a capital letter[1][2][3], but everything I can
find suggests that *semicolons* should always be followed by a
lowercase letter (with exceptions for proper nouns)[2][4][5][and
others...].

[1] http://www.sussex.ac.uk/informatics/punctuation/colonandsemi/colon
[2] https://www.quora.com/Why-is-capitalization-necessary-after-a-semi-colon
[3] https://writingcenter.unc.edu/tips-and-tools/semi-colons-colons-and-dashes/
[4] https://writeanswers.royalroads.ca/faq/199268
[5] https://wordcounter.net/blog/2016/06/24/101812_capitalize-words-colon-semi-colon.html

So, after reading through the above links, I'm fairly convinced that
'different' should be lowercase here.
