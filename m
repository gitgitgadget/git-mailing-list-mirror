Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8039FC433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 02:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579B720757
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 02:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt1HZYB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFCChA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCChA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 22:37:00 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5050C08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 19:36:59 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id d67so444266oig.6
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 19:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WV+7L6Y2CKqAr7Kc/EZWjo6FkdeSIUhrRJEyXoY08yQ=;
        b=Yt1HZYB6SbMnbQsNRCfhBKvCOSthsDX4kSWCXTSQYLvpdWISrLRGU1N146h8qIqDZh
         RFOpWoBhCU/rnZ1Jx6vmkS9KBkg2wmrh1C2YmoTLNI0ES8GoEkzyE4OXDBxLMlD3srEy
         tYJKkat/k3LEDg0aoJfJSLBzZehfxV8iwpYMKsaCNA82Cn1V8WtkZSQvJjyJvyXatuJx
         w+g3HMpjLLHe7eVk3lqlha7luQlvvxL4qvJENlQhbqiav2zvCmd128XOTs79VdobcbrP
         a4esIk8Yc3vqwGK74jUVQvbNOd/Y2A8San8aKISK95ou77wwdlGl8ZCOkl51pOFZxkeG
         vwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WV+7L6Y2CKqAr7Kc/EZWjo6FkdeSIUhrRJEyXoY08yQ=;
        b=XNHYIXQhlfjq71eSboCqXd69c7o8IpGnC3rp3AVv8yYPPLvcEoZghWFu3PvbpxHWEP
         DoOdHKJ7e4Msb6LyaoM9cOijH+WQ9JZ7q5ax4MvEGyR3NUqkwkHkLMdEVPCvsiRSTkMU
         mXYqm8UInFMeHu6MfmjWvw42gae44k3zJLYkIZJrzhtUUsDkVSkIPoaddJAm+nC+9IBp
         3f+3uErGudcFrygvNzFJfAlsJmLZCaPSWLaf0+UaC7P4rcuYTQJUunQPtx54v4uJozqr
         hLy6nhaB6/A+Ll8Ef+rLv7B0IEThuszJvEvoDj74ulQS4zT/kGAIXJUIGUcQjTs6iuFR
         1Uww==
X-Gm-Message-State: AOAM532AXTCjB1k9EgUUKsa4WLoufk8KxI5M4ufLX6VIH1iHkpYqJl3N
        jSevMLcncIzBDEQ3sRcRey4e4+OcvMJVVJCEbp8=
X-Google-Smtp-Source: ABdhPJwOjkRXJWwgaLGwo/fsgN+A7iNCoFR59piM8nS26m5XsmIdJH5T0xBVYMB9AW+zi/CiFnlzHjFQFJIfEDhuc5o=
X-Received: by 2002:aca:3f44:: with SMTP id m65mr5072846oia.167.1591151818742;
 Tue, 02 Jun 2020 19:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEswHLhymQ1_07g3qqu=7kFR3eQyAHR0qMgSvi6THy=zQ@mail.gmail.com>
 <20200603015314.GA253041@google.com>
In-Reply-To: <20200603015314.GA253041@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Jun 2020 19:36:46 -0700
Message-ID: <CABPp-BH9M-Rkq1YkNkJGqzu_z5poT4uS6Pk1f==ey+NLckiHTg@mail.gmail.com>
Subject: Re: Huge push upload despite only having a tiny change
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Minh Thai <mthai@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jun 2, 2020 at 6:53 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> (cc: Jonathan Tan for "git push" discussion; Minh Thai for negotiate
>  hook discussion)
> Hi,
>
> Elijah Newren wrote:
>
> > I had a user report that two nearly identical pushes (the second being
> > an amended commit of the first) took dramatically differing amounts of
> > time and amount of data uploaded (from 4.5 seconds and about 21k
> > uploaded, to 223 seconds and over 100 MB uploaded).
>
> Yes, this is why I want push negotiation.  (It's been something we've
> been discussing for protocol v2 for push.)
>
> If they fetch before they push, does that help?

In my attempts to reproduce which I assume are similar, yes it helps immensely.

> [...]
> > * The server was running Gerrit 3.1.4 (i.e. jgit).
>
> Gerrit servers have the interesting property that many people are
> pushing to the same Git repo.  (This is common in some other hosting
> scenarios such as Gitlab, but the most common case among Git users
> still seems to be pushing to a repo you own.)
>
> When you push, because there's no negotiation phase, the only
> information we have about what is present on the server is what is in
> the ref advertisement.  (We have remote-tracking branches which seem
> potentially useful, but we don't have a way to ask the server "are
> these objects you still have?")  The ref advertisement describes the
> *current* state of all refs.  If I am pushing a new topic branch (in
> Gerrit jargon, a new change for review) based on the *old* state of a
> branch that has moved on, then we can only hope that some other ref
> (for example a tag) points to a recent enough state to give us a base
> for what to upload.
>
> There is one trick a server can use to mitigate this: advertise some
> refs that don't exist!  If you advertise a ref ".have", then Git
> will understand that the server has that object but it is not an
> actual ref.  Gerrit uses this trick in its HackPushNegotiateHook[1]
> to advertise a few recent commits.
>
> At $DAYJOB we ran into some clients where "a few recent commits" was
> not sufficient to get to history that the client is aware of.  We
> tried changing it to do some exponential deepening, and that helped.
> We should probably upstream that change for other Gerrit users.
>
> Gerrit also advertises some other ".have"s, for example for recent
> changes by the same author in case you're uploading an amended
> version.  That's less relevant here.
>
> But fundamentally, this is something that cannot be addressed properly
> without improving the "git push" protocol (adding a negotiation
> phase).
>
> Summary: (1) try fetching first (2) let's improve
> HackPushNegotiateHook#advertiseRefs (3) let's improve "git push"
> protocol to make this a problem of the past.
>
> Thanks and hope that helps,
> Jonathan
>
> [1] https://gerrit.googlesource.com/gerrit/+/e1f4fee1f3ce674f44cb9788e6798ff8522bb876/java/com/google/gerrit/server/git/receive/HackPushNegotiateHook.java#111

Yes, this helps a lot.  Thanks for the pointers and explanations!
