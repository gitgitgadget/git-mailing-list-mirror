Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F23FC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 08:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FFD20656
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 08:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goodman-wilson.com header.i=@goodman-wilson.com header.b="Gib2JFf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFKI6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgFKI6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 04:58:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119DCC03E96F
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 01:58:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dr13so5653696ejc.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodman-wilson.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SFHai455Du6WunIAL+dHh2opSBynHLrtyDlrpnzK+3A=;
        b=Gib2JFf20H9NRuPO10M0OOvRYYXiF3GO2MO2zTTAC+/tVmT65uGXn2JbT79u6ooWi/
         Gb9+W2vdCHyLqV2owaQjXB/SHNLdDVVZhL6yfpM9oCAnmBvMFcm4bXIH6BYOhpSOdI8u
         Cd+WxrmsGVD+taZPt+8X4NHGVYQG7clDcBV/UJfW/1LSy/4WYv1MgzayEYUQSzH8mFN1
         TLnMenJuVTxNXuxw4ZTgqBXTNJ2kgqdtZMBFr9le0MUbj2bQnRreHEv0PmhRFUjC0z24
         X1YeWGptA2LVXcESiFyVraws46QLxGz4LXCkwYEHYebWSkW1gB1yDA2IqPh+Y54kcdY4
         7SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SFHai455Du6WunIAL+dHh2opSBynHLrtyDlrpnzK+3A=;
        b=MxgInpjFISJUh9kEBrhrM87/E3SjiveNsKcIzu9WkiicrC30WsLbzgnTELE2QTH6+v
         W3bKdAzuYR11bUwh7alRQHkaJ+CCswmRTw7k8UQ/KVHxpNjpi8eh0P7AGnm8XRLK/SgY
         zvJzUrucqNZHJJtNWquWcX9tqCG5jMLIOodUqH7eCUibihExFjZ49VoIq+XfRM7CWP93
         /clDY/6AMjFCzqix8rhA5YwNexY9QNvSOOZxulW1HBwIXK/r8vjzs6khF7UDIWF85huu
         zOax/X3yG12LVATcj51n9UIVWmkJqokUCbJcaUmfal5UURoNSWxoiuC1HUa1CywJUlDB
         mwmA==
X-Gm-Message-State: AOAM532TxfM/uyfriK6dY48fqk5lmvBzfC1ztHp4tdOZD1WtatpOWNzc
        k9T1Tc9lYHQtiXvYK1VPcNXWfuaehB8xEwwfRuh76g==
X-Google-Smtp-Source: ABdhPJyOCZyf/xydIa5bw9/micB9U+n7ZjleDVPABVNj/kJwGAz4qqOI1CWyZ6BMZ0p46hY6dY+X7xIrRpN7/WygiX4=
X-Received: by 2002:a17:906:f6c2:: with SMTP id jo2mr7629216ejb.424.1591865910526;
 Thu, 11 Jun 2020 01:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200610222719.GE148632@google.com> <xmqqwo4eedwc.fsf@gitster.c.googlers.com>
 <20200611011040.GB21728@syl.local> <xmqq7dwecpsp.fsf@gitster.c.googlers.com> <20200611023503.GA24130@syl.local>
In-Reply-To: <20200611023503.GA24130@syl.local>
From:   Don Goodman-Wilson <don@goodman-wilson.com>
Date:   Thu, 11 Jun 2020 10:58:18 +0200
Message-ID: <CAGA3LAdz21nZFeztkHp5XUQ4h-kWnqTzb8pDXjne7PqeMFhLRQ@mail.gmail.com>
Subject: Re: Virtual Inclusion Summit
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

(First of all, it=E2=80=99s Don, rather than Dan; I think Johannes=E2=80=99=
s
auto-correct got the best of him at one point in his email :D )

I think this is a wonderful idea.

First, I am myself a white cis-het male; my participation in any such
summit would be predicated on ensuring that we have a diversity of
voices present, as I think it is foolish to have a conversation about
inclusivity and equity with only white voices like mine speaking. I
hope and expect that we are planning for that.

Given the concerns about being recorded, perhaps my experience running
Maintainerati events might be helpful. Maintainerati (if you hadn=E2=80=99t
heard of it) is a series of events that gather open source maintainers
into unconference-style conversations about the challenges they face,
and finding solutions to those problems. The events are operated under
Chattham House rules, ensuring the anonymity of participants who wish
to remain so. Even so, the goal of the events is to not only document
the conversations that happened, but to create a set of documents that
allow the conversation to continue long after the event is over, as
well as providing a blueprint for concrete action. It is not difficult
to set up the necessary conditions to make this work, although we will
need dedicated note-takers willing to undergo about 30 minutes of
training. I would be happy to put in the effort to make this kind of
thing happen, if this sounds helpful.

Don Goodman-Wilson

On Thu, Jun 11, 2020 at 4:35 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Jun 10, 2020 at 07:13:58PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > >> It is OK to have an optional meeting in the hope that a video
> > >> meeting may have a better chance to keep those who easily become too
> > >> aggressive and confrontational in text-only conversation in check
> > >> and instead have civilized conversation.
> > >>
> > >> But I am not sure if it is a good idea to call such a meeting a
> > >> "Summit", given that there are those who prefer not to be seen,
> > >> heard or recorded how they appear and how they sound in a video
> > >> conference.  They would not be able to join the conversation held in
> > >> such a "Summit" held only by those who are privileged enough to be
> > >> able to attend.
> > >
> > > I think that this is a very reasonable concern, stated in a very
> > > reasonable fashion. Let's call it something else, sure, and avoid
> > > recording/publishing the event (as we have done in the past at other
> > > in-person events--such as the last Git Merge--which seems like a
> > > lifetime ago ;-).)
> >
> > I am not opposed to recording and publishing for wider dissemination
> > of what was said and agreed on among participants, who join with the
> > full understanding of how the video meeting will later be consumed.
> >
> > What I am hesitant to see is that such an opt-in meeting becomes
> > "you got a chance to attend and have your voice heard---if you
> > didn't come, that was your choice, and whatever objection you give
> > after it does not count" summit.
>
> Ah, thanks for your clarification (and sorry for the misunderstanding).
> I figure that any synchronous discussion should augment the on-list
> discussion, not replace it.
>
> Thanks,
> Taylor
