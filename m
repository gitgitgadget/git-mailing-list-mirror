Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C3220248
	for <e@80x24.org>; Mon,  1 Apr 2019 15:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDAPxC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 11:53:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42612 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfDAPxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 11:53:01 -0400
Received: by mail-vs1-f65.google.com with SMTP id f15so5789363vsk.9
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMMOCG5QbT3R+u31ktNYp37TA8MWocqB8uWuYgXA2Mw=;
        b=tZb71Re+8t8z9/JO7m24pDZTk8+msbv302RVb/HGlQHgdTQnaHWZEuUX3oILbSvnzB
         rLcYXrBtQICCBLRG0ke3++iAApLKE/IP1vqP65D0YyD9v2fDUN34f7YUJDgbi/xvR6ow
         6Fv/OVJgHRodpyIssuwmzN0K8Gek6h0R2PZRMa/MB8VZsSwFmLFP+ge8wrsgssw6NxNe
         PYfLTo18HaKutEOyUR6Mjl76cD9Trmb9DHRmDzQ5QHuQJcdPlTx2TnRrhKz9r5raZGj1
         5eNVG81rM6arDl+SIWPxa9/ioN/WE2eU8pJeSXK5QAn9elrUT1wqqcRKdGI7npH31Z4E
         qtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMMOCG5QbT3R+u31ktNYp37TA8MWocqB8uWuYgXA2Mw=;
        b=T1jEJMBsTsc0YCoyEICAVy1m6W6yOU3eTJzBvWg6tA2o2bfeYij3E3wM35IwvF5HUA
         YUkRJtrMryw1t6vfUpKYQJXGtuVrki+2ViXK8tv0LkPYuJpgz9EIqtQV3T5g4OBrdkZK
         6gigbWzWDAJus/2D7uN39mgtgMXyqDIbm22vqU21xnLWWCMFGXuKaLsIIxeAOVxdomrV
         9yvAVe93x/bDE34bQvGPpdzoK6bbv/Q9j7pLP8Yp4gmFx5C2JxANpK8U4cLE4zh7R6qV
         GkMc9eFpw0QnPdXxAa+joJ0zoab7frvuvzEyfdRbi4pvJippEot2JbGQCNoqtKQIjthR
         ZpIA==
X-Gm-Message-State: APjAAAWD5SaEjqq+D0fmhMLKMQKwAvUxTVJq0Srp7JT5JBa1YoPN/ovu
        b1XBqcmYUdQDkZv0MHEYgHrbRtcdB8Hxd0UjtGQ=
X-Google-Smtp-Source: APXvYqxBBk2gNEFx/s2X/wDqEYKzKGGP2t7it7SqJlIT11Vt0sDZR9TLDH25r3xCOPtIQoUj47s0Xr4Z6GVfbl1v2uo=
X-Received: by 2002:a67:74cd:: with SMTP id p196mr38368467vsc.215.1554133980841;
 Mon, 01 Apr 2019 08:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190220225846.10658-1-newren@gmail.com> <CABPp-BHp83H1qhrd-j1yvdWz56AwDJogFjf_3iaEDVjFvGansg@mail.gmail.com>
 <xmqqwokevwbb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwokevwbb.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Apr 2019 08:52:48 -0700
Message-ID: <CABPp-BEHiYddGzVfuQoiN403na2dOSXBbnJDffp3pPsEqQ2Pgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Fix some fast-import parsing issues
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, David Barr <david.barr@cordelta.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 1, 2019 at 3:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Feb 20, 2019 at 2:58 PM Elijah Newren <newren@gmail.com> wrote:
> >>
> >> I found a few issues with parsing in fast-import (dating back to
> > ....
> >> I've cc'ed the relevant folks, and have a few patches that fix the
> >> issue and I think make the parser more robust against future issues in
> >> a way that I think is safe enough for backward compatibility, but
> >> "backward compatible enough" might concern some folks; if so, please
> >> take a look at patches 4 and 5.
> >
> > Just thought I'd ping to see if folks have any concerns with this
> > slight tweak to backward compatibility; if not, I'll just repost the
> > patches removing the RFC label.
>
> It's been more than a month and we haven't hard from anybody,
> perhaps?

Indeed; I was going to resend sooner but got wrapped up in
directory-rename-conflict-by-default, switch and restore series
discussions, etc.  I'll rip off the RFC label and resend.
