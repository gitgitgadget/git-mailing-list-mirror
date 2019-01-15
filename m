Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98121F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 06:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfAOGIX (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 01:08:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38868 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfAOGIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 01:08:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so1532852wrw.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 22:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HBB82HVzxIcFrzunxQ3uU5NdNFT8RsGQXRRrJEiRXc0=;
        b=kx2TBBq+rpFYSXoY8alJLwqUB8nsfkMWZSnZo7KuRM7Cope850QXGXmpwvHJOs0DCn
         WGdT4GparyNl9MTXecajJSvdJrwWr0OxtRnZjlQ3mwN9ZgCwqOlsrKcPqExo5bNpQR73
         Cx6RYi8/tAmTHW8INbkvUFioCILrCr/LcMnrz+V/CSJFlfCy9WhAlWxpEkjGDIv5v6cm
         vOnqctgM8rVihhKeZ5iNdvVwCvsUDU25vECIPoT1NpDkMr4StDoTMLLj0skP0baYRx8l
         +szLzYPlrZZwbedKG6eXMCNL/5tqx1DaDmeTEVzj2vPz+DK7Rre90NjlgssLzxq8rZGN
         0yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HBB82HVzxIcFrzunxQ3uU5NdNFT8RsGQXRRrJEiRXc0=;
        b=KfXlHK5xGosquOIDTA7DNR6vTjxm33wMyWABLAWhy6yI1zMCqaiSHTBwGQpxy1+B7O
         t0o0a+l2vmd2hddeFEBPeNH3gy/MNWjER8T9lv1Ts3pCmeeDI8+aTYvQsdY1JsX8Q2L3
         HZd0Dj6qO03hbS253ZHrF6Gr5gkLzoUE35+Hh+wFYNoIJT7vTl7xavhX70gxt+i+1Urz
         /5viSN3DNfuVyk7dxcNiCq7O5WRMueYKfkEwJs+gCMj/pqUYhZjt30LpjwwBsCVdjbDg
         fEiggP+rKAQIbyYNNcZDPCVlM727wWlECmro62k7xtsF7Sx2tJl+l4e4E75QAjzI3dhR
         KPUQ==
X-Gm-Message-State: AJcUukcKlx0JHhQY4rAPe+SCNA1GdURPMLX1t3ReQn28qetMbSQ2lJl0
        xb9ezg0l4EkuLFgwUQZYGpqEXLyw
X-Google-Smtp-Source: ALg8bN6KTglFD0//mvxdiTp0NzXitiBzk9R4jjV8Gysgnoo6cWp4H2f1VvcWpkZITCD2wDR3+3F37w==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr1606450wrv.188.1547532500239;
        Mon, 14 Jan 2019 22:08:20 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y13sm26745463wme.2.2019.01.14.22.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 22:08:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Barret Rhoden'" <brho@google.com>, <git@vger.kernel.org>,
        "'Stefan Beller'" <stefanbeller@gmail.com>,
        "'Jeff Smith'" <whydoubt@gmail.com>, "'Jeff King'" <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
References: <20190107213013.231514-1-brho@google.com>
        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
        <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>
        <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
        <20190109154828.1b19dbb4@gnomeregan.cam.corp.google.com>
        <xmqq1s5k16zj.fsf@gitster-ct.c.googlers.com>
        <20190114101956.2b899d0e@brho.roam.corp.google.com>
        <xmqqfttvw2sv.fsf@gitster-ct.c.googlers.com>
        <003c01d4ac36$bdf29470$39d7bd50$@nexbridge.com>
Date:   Mon, 14 Jan 2019 22:08:17 -0800
In-Reply-To: <003c01d4ac36$bdf29470$39d7bd50$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 14 Jan 2019 13:26:56 -0500")
Message-ID: <xmqqd0oytpv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On January 14, 2019 12:46, Junio C Hamano wrote:
>> Barret Rhoden <brho@google.com> writes:
>> 
>> > On 2019-01-10 at 14:29 Junio C Hamano <gitster@pobox.com> wrote:
>> >> > For instance, commit X does this:
>> >> >
>> >> > -foo(x,y);
>> >> > +foo(x,y,z);
>> >> >
>> >> > Then commit Y comes along to reformat it:
>> >> >
>> >> > -foo(x,y,z);
>> >> > +foo(x, y, z);
>> >> >
>> >> > And the history / rev-list for the file looks like:
>> >> >
>> >> > ---O---A---X---B---C---D---Y---E---F
>> >> >
>> >> > I want to ignore/skip Y and see X in the blame output.
>> >>
>> >> If you skip Y, the altered history would have "foo(x, y, z)" in E,
>> >> "foo(x,y,z)" in X, and "foo(x,y)" in A.  If you start blaming from F,
>> >> you'd get E as the commit that explains the latest state.  If you do
>> >> not skip Y, you'd get Y.  I am not sure how you'd get X in either
>> >> case.
>> >
>> ...
>
> From my own community, this came up also. The intent was to show everyone
> who touched a particular line, throughout history, not just the current one.
> Perhaps that is what Barret is going for.

I think I now understand what is going on.  In short, what Barret
wanted is way more ambitious than "blame in a hypothetical history
that lacks certain commits".  There is no similiarity with existing
"-S <revs>" option that I asked about in my initial review.  This is
quite a different beast (and I kind-a like it ;-).

Instead of "skipping" Y, Barret wants to pretend that the effect of
commit Y, in addition to the commit Y itself, never existed in the
history.  Even when blaming back from F (where it has "foo(x, y,
z)", which is the same as E and down to Y), the algorithm wants to
pretend as if E and F had that line in "foo(x,y,z)" form, i.e.
before Y touched it, and also pretend that the user started blaming
a line in that shape.

As there is no general solution [*1*] to "how did this line looked
like before this commit", such a blame may not have a meaningful
answer.  When Y added a block of text without removing anything
(i.e. "git show Y" has no line that begins with '-'), and when the
user asked to blame that block of text in F, there is no sensible
answer to the question: "what got replaced by Y in this text?", so a
blame that "ignores" Y would not be able to answer "where did these
lines come from?" question.  But in some cases (e.g. when "git show
Y" has only one '-' line, immediately followed by '+' line, both
with quite a similar contents and no other change in the patch---it
is highly plausible that in such a change, the former became the
latter, like the example in Barret's message I was responding to),
we can say "this was how the line that was modified in Y looked like
before Y" and blaming while ignoring Y can have a reasonable answer.


[Footnote]

*1* Here, I use the word "solution" in the same sense as "solution
to a math equation", not in the sense to describe the steps to
derive that "solution".
