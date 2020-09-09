Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05653C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 16:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B7520768
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 16:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aILhSP2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgIIQIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbgIIQH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45E6C0613ED
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 09:07:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y13so3753634iow.4
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfvjKbDNscdTQjd3PbIPUiDwH0/RjleZYeHp7uHyFSo=;
        b=aILhSP2I6edVfZ9vPEwxreqW327ZaL5JvY5rR2kPsDOvs/HuXwXhdk+rKUq5dkV6Ds
         1+rY1J6YT7C8Tc+GLz8TWih/iyaCeD1dQ68+fNnHTiS3frFxae6x0Q9fmC2YPnVV0nRc
         hL+R+Lli87ZgubpZDSK70nelAIv14pZQbLwe4Bl9tNU3c2Qr3p9E9g7ChZN33S/sE7RN
         s4h7w43+QngKMShoiLLEBd7+hNk/uwLYZUx2Nwvadz2OJlVT79bIELq27bQDmvZCyUjT
         S7ZzeFWz1eZRrr/ypazIAlandhsR4pV7tKo5b5RXrdiN7NyMmJ8tMFF5NN2UqID8KIsL
         nZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfvjKbDNscdTQjd3PbIPUiDwH0/RjleZYeHp7uHyFSo=;
        b=gz2ivmrJueymJzWbGBr+udZdjhP+7WtjhYYcqRLG966xN/uzKZsdfAxqYgngVoq74d
         C88e+MQg3l8CsIaNoM1pj1tMsciIWsf2vgpDBfjXaBQ0yFOyCn62/96R+zHDrH7GwLmb
         zQfc4sOToBsrtkV2vjPfQ2GTGETCJfevGe6DI21HM3R0qzqiu2BPkP5jSzNWi7xmcJVX
         lbgOF0zaGbGTPAv5dhAYui5HRZFRKhMdKf9IDXWFwG9Oq8mXKom7zfGb+GQry0tPfW0N
         WXzc3cypjL78VSvViJL8kLtDrA+e+8LTnBlwEbiQbFN7FyHRaSVss34dp7HmKVoFp5sB
         IuSQ==
X-Gm-Message-State: AOAM532DZKdBF4wBtVOwDoDshmNeBbj3kmNbzZH0s8hl13qRCnzpS0ur
        P8+hesnZgLNyjanibP7ipvrhY4BwDGJLFRASx3RiUfcpXEw=
X-Google-Smtp-Source: ABdhPJyIJZli1tLQHBa4H+lMkIuM2ithcV+KVef6XjxKJ1WN0WIa9eP9LB679hqKH8yS0BsoedEcFdl3sh7MHQvYqjI=
X-Received: by 2002:a5d:870c:: with SMTP id u12mr4082505iom.129.1599667668679;
 Wed, 09 Sep 2020 09:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com>
 <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com> <dc9b58c4-96f1-2270-406b-781f8d0a4f22@gmail.com>
In-Reply-To: <dc9b58c4-96f1-2270-406b-781f8d0a4f22@gmail.com>
From:   Tom Rutherford <tmrutherford@gmail.com>
Date:   Wed, 9 Sep 2020 09:07:37 -0700
Message-ID: <CAHr-Uu_XhLXDhGOcHGG6wiLSg=nUjAU55gtB08DfKbi5bebL4g@mail.gmail.com>
Subject: Re: post-checkout hook aborts rebase
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Phillip,

Yes, I've now noticed that's the case. :)

I also didn't intend to suggest that post-checkout *should* run during
rebases, just that it would be convenient for this particular use case
if it did.
I think I'll need to use multiple hooks to accomplish what I want to do.


Tom

On Wed, Sep 9, 2020 at 2:44 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Tom
>
> On 27/08/2020 01:44, Tom Rutherford wrote:
> > Thank you for the response Junio.
> >
> > For what it's worth, my hook does not make changes to the repo. It's
> > running a command to check that the installed version of our
> > dependencies match the version specified in the commit being checked
> > out, and merely warns if the two don't match (then exits with a
> > nonzero return code).
> >
> > For this reason it's been convenient that the hook runs during
> > rebases, but I find it surprising that the nonzero return code would
> > impact the rebase.
>
> If the checkout succeeds that rebase does not print any of checkout's
> output so unfortunately you wouldn't see the message from your hook.
>
> I tend to agree with Junio that we shouldn't be running the
> post-checkout hook when rebasing.
>
> Best Wishes
>
> Phillip
>
> >
> > Tom
> >
> > On Wed, Aug 26, 2020 at 5:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >>> ...  If "git rebase" or whatever
> >>> command wanted to place files and the index into some state by using
> >>> "git checkout" command, and if the post-checkout hook mucked with
> >>> the state in such a way that contradicts with what the "git rebase"
> >>> command wanted them to be in, it is not surprising the hook's behavior
> >>> broke "git rebase"'s operation.
> >>
> >> Having said all that, I actually think that "rebase" shouldn't be
> >> invoking "git checkout" (and its equivalent) internally when
> >> switching to a specific version, in such a way that it would trigger
> >> any end-user specified hooks and allow them to muck with the working
> >> tree and the index state.
> >>
> >> I haven't checked the actual implementation of "git rebase" for
> >> quite some time to be sure, but we have lower-level plumbing
> >> commands that are not affected by the end-user hooks for exactly
> >> that kind of "build higher-level commands by synthesis of
> >> lower-level machinery", and it is very possible that what we are
> >> looking at is actually a bug that needs to be fixed.  I dunno.
> >>
> >> Thanks.
>
