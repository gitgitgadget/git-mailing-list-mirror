Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF2C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 18:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64D021707
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 18:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTz8gTEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417703AbgJYSBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 14:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437136AbgJYSBk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 14:01:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6EC061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 11:01:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so10165004ejb.12
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ezfNMM8BJly7qwbGxLFT914aJsv79sPY8GglR6tOe1s=;
        b=TTz8gTEMcd25/QrkW7C/zC/jxJPLsWJqc8ImeWuxB1z0CKwfwyqeWaW0gxwJmiyb5j
         OQkJXPXN+1uLCMOe+KIWpSytiSFRnf+laUG9omcux+aBEDQN/OD2NTUAO3oUBwU1yD2G
         0lTCRCne0cysTKBi5I+evXK0OY4bzVTdkaQX67fxTspckRhWOX4z18d4ML75ZQJeR6AU
         x3l2GT1hbUABn+yCK+zJITcRjr7CwhCM86hVkILU+stM00sfOYo/BRXaNV2ZKr0/Sr1x
         effOgwDcn+o9JLBFqBfhkdDiNltz1Kl7jO65o9Q8KDqKHNr2TIr8ru0NgXFoG1u5eKf2
         jj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ezfNMM8BJly7qwbGxLFT914aJsv79sPY8GglR6tOe1s=;
        b=rp7xjts1fzYRRpa3ZEPpLu7pHXQz9HKENdWUESfW9s/lKQoX2scdeLmb8Ey0aa7xto
         8Ut4mS2VK87cCFIpUet68+vJvwsCN9NJC8gWUFvqG2n1PFN6srzQ4Epe1ppON8F7HaO5
         wkSp6qK5i5IWk7PEkVIU2oHF/TcRkLr2evjLt6XbNrnNt2k5o5Eo8lgbjBAwN02pXSOH
         /612C/PeON+k70VJ23d9+rLsRn38cTINzrdgca1snb7C94L2d0XtbI1meZ/T0OdYAt+g
         iMKV5/+9J6OOrvYh+V4U4rgF0uKrQ06MpHZFEfIMzUaNFIHEQ69CdCKml94lwui7I4Kk
         BmzQ==
X-Gm-Message-State: AOAM532YeZDuOtCbxfR6mLX3tdKcLaO8sKf0+a2TnzAo+6XQ+6W3VXWT
        CY4d2GM6qxsuUm5cSXoqAk0=
X-Google-Smtp-Source: ABdhPJzCbyv7ZrTq2x9v98+3IrUoNWnU8j1iMENyXgZSpEFeNQDPfMnWATGDooq+2sYcNuGQqS5fTA==
X-Received: by 2002:a17:907:a9c:: with SMTP id by28mr11572365ejc.62.1603648898999;
        Sun, 25 Oct 2020 11:01:38 -0700 (PDT)
Received: from szeder.dev (92-249-246-148.pool.digikabel.hu. [92.249.246.148])
        by smtp.gmail.com with ESMTPSA id q19sm1139285ejx.118.2020.10.25.11.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2020 11:01:38 -0700 (PDT)
Date:   Sun, 25 Oct 2020 19:01:36 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] bisect: loosen halfway() check for a large number of
 commits
Message-ID: <20201025180136.GF24813@szeder.dev>
References: <20201022103806.26680-1-szeder.dev@gmail.com>
 <xmqqv9f2mb61.fsf@gitster.c.googlers.com>
 <CAP8UFD30NZREjE+_WHKyAhkHAi1TjHQo7iXd9xkvHj9stjT=9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD30NZREjE+_WHKyAhkHAi1TjHQo7iXd9xkvHj9stjT=9A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 24, 2020 at 09:41:27AM +0200, Christian Couder wrote:
> On Thu, Oct 22, 2020 at 8:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > SZEDER Gábor <szeder.dev@gmail.com> writes:
> >
> > > However, when we have thousands of commits it's not all that important
> > > to find the _exact_ halfway point, a few commits more or less doesn't
> > > make any real difference for the bisection.
> >
> > Cute idea.
> 
> I like the idea too.
> 
> > > So I ran some tests to see how often that happens: picked random good
> > > and bad starting revisions at least 50k commits apart and a random
> > > first bad commit in between in git.git, and used 'git bisect run git
> > > merge-base --is-ancestor HEAD $first_bad_commit' to check the number
> > > of necessary bisection steps.  After repeating all this 1000 times
> > > both with and without this patch I found that:
> > >
> > >   - 146 cases needed one more bisection step than before, 149 cases
> > >     needed one less step, while in the remaining 705 cases the number
> > >     of steps didn't change.  So the number of bisection steps does
> > >     indeed change in a non-negligible number of cases, but it seems
> > >     that the average number of steps doesn't change in the long run.
> >
> > It somehow is a bit surprising that there are cases that need fewer
> > steps, but I guess that is how rounding-error cuts both ways?
> 
> When there are 50k commits span between the initial good and bad, I
> don't expect to see any statistically significant result by trying it
> 1k times only. My guess is that you might start seeing something
> significant only when the number of tries is a multiple of the span
> between the initial good and bad.

Well, perhaps...  but statistically relevant or not, running those
1000 tests I reported about took over 6.5 hours, so that's all you'll
get from me :)

Btw, just for curiosity, running just _one_ similar test in linux.git
with the good-bad range containing ~830k commits took ~65 minutes, and
the runtime of 'git bisect start' went from ~38mins to ~12.

