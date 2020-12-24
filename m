Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B587C433E6
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1999F206ED
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgLXWdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 17:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgLXWdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 17:33:01 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E768C061573
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 14:32:21 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w124so3529035oia.6
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 14:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3OkhoWdnSXgFmBcv6eCtyaWxonInPUDp3o+rIH15Ddw=;
        b=BnaeuZYa0AGzS8/LbB8w33VNisVYld7u1ytf1PZrqKAZve7u/vr/eU/Ay0ChzAaKuK
         GfKw9p5UMsQgSa+9Naay1M5bJjIhd2fi48XQH8PDOWoAZC3DvNLGfxp2cuRW4LTDeoer
         paoosyjJugpstSDfG2XBE3dt9d0guI+fwC5406f/Oy3lywtlRFtLlEaH+4syAsb4iIwr
         7T/7VnPrEkv3bMDhqsLBwwc7DqiHgPFG6uPBvxmGWsjghbBJN+xOi68P3lmFSDV04sFi
         ohjjHlpPORN9hGgaLDBpzvhHA1PHetWdnn6gCWOjZsOViSF0/ZsUQG+SJUcoLs+StEWi
         Donw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3OkhoWdnSXgFmBcv6eCtyaWxonInPUDp3o+rIH15Ddw=;
        b=SsIm+xa2HwBv16V7wUOikJ+o78nODrFbioxdqdeysv4YQcubqgT2JNVURXyK3wMiVW
         EC4+3cdVyiVJvvLErqXkosSlVNyFnf2x+GENvWrDvKUfXSjItkUar5AE4ck34YVJ8U5P
         OD4gLiTfjNVkaJj8Id1DQp9xb0w2T08v+OmC64NTqxqSJmq3tx1LTXgjuBDpQmBSuIZZ
         Mdj76xoKn5sNzzNpt8jT5STNXfwLYJ/7Nwhdua3GRfP92NNWbaeidOuNoqL2VusUnEQH
         BqurI80tuRO65mpyfjcrPytnaHKZ3V7e9gPFiMBSHqzkIQND1ntFlFFCxwIBh7VDUkKr
         dK+g==
X-Gm-Message-State: AOAM5318DUG9cMdFHy6VbRBfQFCXi9MDg4ZY9RvYWJX5GlyjU+OMGTSC
        lGdxQVFBBb9w2Jai9A/pafM=
X-Google-Smtp-Source: ABdhPJzbQ8+BKysSZANb6wLz+zz681ntXS5G4XJ+rL7qyUZIahqsogvHJxQAsyIo4xnyyAxGbPwYlw==
X-Received: by 2002:aca:470e:: with SMTP id u14mr3932286oia.172.1608849140807;
        Thu, 24 Dec 2020 14:32:20 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a195sm6146861oib.52.2020.12.24.14.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 14:32:19 -0800 (PST)
Date:   Thu, 24 Dec 2020 16:32:18 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe516f29c37d_87ce208d2@natae.notmuch>
In-Reply-To: <CAJDDKr7bhnbr6NZfV28rJN5JrHkO+gZCLY_LkwiCxxBp=HWfbg@mail.gmail.com>
References: <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <CAJDDKr7bhnbr6NZfV28rJN5JrHkO+gZCLY_LkwiCxxBp=HWfbg@mail.gmail.com>
Subject: Re: Code of conduct violation?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> On Mon, Dec 21, 2020 at 3:51 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > David Aguilar wrote:
> > > Just a heads-up that Felipe has a history on this list of creating
> > > long, never-ending, pointless rant threads so sometimes the best
> > > course of action is to ignore him.
> >
> > I think this can be considered a personal attack, which goes against the
> > code of conduct.
> 
> Sorry Felipe -- there is no explanation that will satisfy you and this
> is not the place to try and "make a case" for what was said.

I'm not looking for an explanation from you. I'm just wondering if others
consider it a violation of the code of conduct.

> > The code of conduct suggests behavior like:
> >
> >  * Being respectful of differing viewpoints and experiences
> >  * Showing empathy towards other community members
> >
> > It seems to me the above comment is an example of the opposite.
> >
> > If you feel that my feedback is pointless, then don't engage with it.
> > There's no need to put aggravating labels, especially on a public
> > setting. Even if most people agree with you.
> >
> > I tolerate your opinion, but it's just that; an opinion.
> >
> > I think you should treat it as such (an opinion), and not blatantly
> > disregard the viewpoints of people you disagree with, and worse;
> > publicly suggest others do the same.
> 
> I could try and explain that being intolerant of my and others'
> viewpoints and dismissing them as being inadequately defended or
> non-existent is ironic, but arguing is a pointless endeavor.

I tolerate your viewpoint, at no point did I ever a attempt to silence
you, or urged others to ignore it.

In fact, I did the opposite; I engaged with you and replied to you more
than once [1] (you did not reply back).

I welcome your viewpoint. I just disagree with it.

> I gave you an honest, but inappropriate, response in public because
> being honest and candid is a form of empathy, but that doesn't make it
> okay.

Your response was not addressed to me.

I don't doubt your response was honest, I'm just think it was
innaproriate in a public forum. I'm glad you acknowledge that.

> I appreciate your talents and tenacity. I can't ask you to be less
> abrasive.

Thank you. Same goes from me.

> I can't ask you to not ignore the opinions of others.

Once again: I did not ignore your opinion, my response is sill waiting
your response [1].

You are free to keep defending your opinion. In fact, I would appreciate
so.

> All I can offer you is my respect and an apology.
> 
> Sorry for saying that.

Thank you. No hard feelings.

> Much respect to you Felipe.  In respect for you, I will politely
> refrain from responding to this thread.
> 
> Sometimes the best arguments are the ones that are not made.

I think arguments should be stated aloud.

I always welcome your arguments, and if you honestly think my point of
view doesn't make sense, you are completely free to state so candidly.
Just remember that I'm also entitled to have own opinion in disagreement
of yours.

Best wishes.

[1] https://lore.kernel.org/git/5fdffe7f7fbd_89f120860@natae.notmuch/

-- 
Felipe Contreras
