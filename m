Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7409CC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 11:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2705E229C6
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 11:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407260AbgLNLQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 06:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgLNLDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 06:03:50 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B67FC0613D6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 03:03:01 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id h18so15330032otq.12
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 03:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2uLQ3/fI1RiGYD+4VBCU/ZPpabFX1lRr53sjjiR6DkY=;
        b=c85WibJ1qotfE/ogAgKTD+t0Nox5ZR8KTSL3vsPd4kUTGqPmh29cDIReF6vFwsrnVr
         Rn8uV8nEerVacNeSXvLadOAwRKO8O1KDwEck1t8654fq+8g60hZRaPfq588UDlL4SuXf
         oEJiklMb+yW8IkjQXaIoKV4nmTCOZrimBbwhu5CtEWCEGVHk0KfeM/L34MczJuNA7CdQ
         d5/d/BIGV7pKf/AUB359D2MqC+yP4fGJ2PKi7G9twar8Hb3iIlEZwl9GDYhvnd1KePwi
         SrWcZji1O2/HyEG0vZJTiwCEmUF7tdK8FXV9kKwIpMNKge22Q3xqRddalLyMzABROEBU
         D93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2uLQ3/fI1RiGYD+4VBCU/ZPpabFX1lRr53sjjiR6DkY=;
        b=pU9FIHhMqXROQfWqaMmfV3OUrp/BmhCoPwRI0DJa2UdFsjuP0iwDS/kqtt7f4YSOPC
         y9Qsi2AjVbXCUsudBQTMGGH4nRqBwMPokl5Kz9INuMxR8plDXKOi8Q3z42vyfyjQgKyk
         7XMvEtPIyaHbF7VeikxafcFJClOf/m6FGfSReA1LOAcsVruE9dPinYPibCB0VRw+DEKB
         fLUpP7MG0jUuqcoG9u50Jykt8ooX8sVBQ7CZx8j/qwfyfqEiLlWYIs4yHdp8fUNoT0qM
         msLgBLreBjzT2doN9pUUR3LRGLuVF9LNTLiLLIp+MID76mnmGDGCdZB/uZHT+wRnbh9w
         7hNQ==
X-Gm-Message-State: AOAM533Ji0eYOKltQLduwbxWTbkUGGLafZ3NC0MBcRUD8oTwsQBIJ9Rs
        6A2gGshIcTIL8OiiO0bZddo=
X-Google-Smtp-Source: ABdhPJy+g6d+fgJsraHuXmXjwQ54n/T0+G6ZopQnd1X3eoCA0rOYvxz2DJylbZ7cIWB6qu/RA6Pbsw==
X-Received: by 2002:a9d:4b81:: with SMTP id k1mr19391760otf.371.1607943780641;
        Mon, 14 Dec 2020 03:03:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id x130sm2475099oif.3.2020.12.14.03.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 03:02:59 -0800 (PST)
Date:   Mon, 14 Dec 2020 05:02:58 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Message-ID: <5fd7466250a4f_d17f5208fc@natae.notmuch>
In-Reply-To: <xmqqpn3cep51.fsf@gitster.c.googlers.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-3-felipe.contreras@gmail.com>
 <xmqqy2i4ltnv.fsf@gitster.c.googlers.com>
 <CAMP44s170qZuZqmh_gVLGgJJ5005HzDM0fdQKQamjHkZCOu7_Q@mail.gmail.com>
 <xmqq360bj3kt.fsf@gitster.c.googlers.com>
 <CAMP44s1v+ESk9y8WC8rKPb61KD_kUoM9F1gO-TZhEEgOzUAPTw@mail.gmail.com>
 <xmqqpn3cep51.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 2/3] pull: move default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > On Fri, Dec 11, 2020 at 6:00 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> > Should actually be something like:
> >> >
> >> >         if (rebase_unspecified && !can_ff)
> >> >                 die("Not a fast-forward; must either merge or rebase");
> >>
> >> The illustration I gave in the message you are responding to was
> >> made in the context of patch 2/3; with patch 3/3 where can_ff
> >> exists, it would not become like what you gave above.  It should
> >> instead become
> >>
> >>         if (rebase_unspecified && !opt_ff && !can_ff) {
> >>                 if (opt_verbosity >= 0 && advice_pull_non_ff)
> >>                         show_advice_pull_non_ff();
> >>                 die("not a fast-forward; must merge or rebase");
> >>         }
> >>
> >> i.e. when we can fast-forward, we do not trigger the "you must
> >> specify rebase/merge" message, and we do not trigger the "not a
> >> fast-forward" error.
> >
> > It's not the !can_ff part I'm trying to highlight, it's the lack of
> > advice *after* we have decided to flip the switch.
> >
> > As I said in another thread: I don't think we have any long
> > condescending error in any other command.
> 
> Only the "not a fast-forward and you must choose between merge and
> rebase" part (i.e. what I listed as the first part of three-part
> message) is the error.
> 
> The rest, the message that teaches how to choose between merge and
> rebase from command line and configuration (or how to choose
> permanently not to make the choice between the two), is not an
> error---it's called advice.

Right. After re-reading the 2013 discussion, and the GitHub trainers'
input that Jeff King shared with us [1], it might make sense to
eventually keep this advice (permanently), since many users might not
know what a rebase is, and would not want to know at this point of their
learning curve.

That being said, the advice still needs to be improved, and I have
already yet another version taking this into consideration ready to be
sent. Just waiting for feedback on the previous can_ff series.

> Even if we were to introduce the third choice (i.e. permanently not
> to choose between rebase or merge and instead just error out without
> getting advice), the advice must stay for those who didn't make any
> choice among the three (i.e. merge, rebase or ff-only).

With the introduction of such mode, and the permanent advice, we would
have:

  if (!can_ff) {
	  if (!mode && opt_verbosity >= 0 && advice_pull_non_ff)
		  show_advice_pull_non_ff();

	  if (mode == PULL_MODE_FF_ONLY)
		  die(_("Not a fast-forward, either merge or rebase.\n"));
  }

If in the future we decide to make it the default, we would have:

  if (!can_ff) {
	  if (!mode && opt_verbosity >= 0 && advice_pull_non_ff)
		  show_advice_pull_non_ff();

	  if (!mode || mode == PULL_MODE_FF_ONLY)
		  die(_("Not a fast-forward, either merge or rebase.\n"));
  }

The transition is very straightforward.

> We have many of them.  An easy example to spot is a similar sized
> onefor "git checkout HEAD^0".  Neither that one or the one under
> discussion is particularly condescending.

I am not familiar with these "advices", since I basically ignore them,
and they are not presented to me in any different color, or special
presentation. I generally ignore textwalls in my command line.

But fine, if these walls of text already exist, perhaps it makes sense
to have yet another permanent one (just with better text, and better
options).

With an improved advice--which includes an option that is good enough we
*can* make the default (pull.mode=ff-only)--perhaps that would be
enough, and in a couple of years we can make the assessment if it's
enough or not.

But clearly *today* we don't have such mode, which people have found
missing for more than a decadte.

Cheers.

[1] https://lore.kernel.org/git/20130909201751.GA14437@sigill.intra.peff.net/

-- 
Felipe Contreras
