Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C766BC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B972217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpaiJjqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBEWFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:05:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43715 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEWFp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:05:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so3724219edb.10
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/7gcbJfcL2eOeSOYK8X+FIJFX+FbFCQIf8O73je4MI=;
        b=WpaiJjqOgEnQ/U/NFqzD65HvXmQ0J0TJ/68l+P3RxH81TgbHx2mHzy19iMbeVkK6hX
         u6jqa3RlMa6g4LTQyGrSVN3U8wV29Cbht5zM4Kh0MmxEY2jqse/DJjtWmrkX05HipDUf
         I3U4+R5xznCju9PueKVcux8OVHpGFjOpBV56kiqICRTUc3EbVEWmk6mQAh4Wj+sL89B6
         POyzS7ilaFMVZY2WxyTMKcWU37AD+Bf/vNT8pOUru03U4/MkH1uwAL8EXpN0l6m6YI9N
         PLMi1nw9e5bKaTk1gait7tguKc3YJ+1iOX+0iuABXmZHMcKpcB0zYtu6mm6oXWAMEG1x
         hqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/7gcbJfcL2eOeSOYK8X+FIJFX+FbFCQIf8O73je4MI=;
        b=icFDzTvLBHTiEl4A3etg3v+aAjo3ALnC4lC+QbB4QLvBrpiVJuLjH0fqrVWYdWLJGd
         H5PwWrFWGPpM0Va73wlV+FoIRjSqUseVa43fV/wNRG5P9LdNxYZ5wuMm5QanG8ZfF6g4
         qa9efWx0LczZNfYzcyl7Et+ckr+KtZcA8Q4tBQ2XneLwYLMrkY2vxl8mm7R12ZWPOSSt
         oXxa/JRA+OJYkzWfk4SmWCvnircnpsbkuq/XPl1wnQBRJ8D6LrYL8x3thU/tuq7r9qyY
         bs2SSmGigrtrVGUJzRtGjEVcOIrN9Msv+eJVwn59dHZj09G6WzwZSoPUdx9+/i1WEgKr
         FbQg==
X-Gm-Message-State: APjAAAWTaXf0W6pbQVDMQ2ir3/b+uMSLb1hlxkGh/d1RlpZL3hDBtNA/
        u/FoREu8/zHlTL0DTgPHRFWl3j62RbNS1toSmgQ=
X-Google-Smtp-Source: APXvYqxMYA5nOHE1G3T/rpNcCcUzDV+PLlNkt37xzi73gzVZRzjzlIrNXZtIgy/XcEEKi0BFP1x+kHID58V3ELkMr/Q=
X-Received: by 2002:aa7:df09:: with SMTP id c9mr265191edy.133.1580940343736;
 Wed, 05 Feb 2020 14:05:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
 <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com> <xmqqimksbo73.fsf@gitster-ct.c.googlers.com>
 <CACg5j27pTKuhZpZtgNUDNEkhG0+tGx5O=LJCr5E8+2q8v6Zu1w@mail.gmail.com> <xmqq7e10hgwn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e10hgwn.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 6 Feb 2020 11:05:33 +1300
Message-ID: <CACg5j252=wKyh7Ar9vxTwxdYXgkjNvbMA=bJCKOc6UZRJfJmUg@mail.gmail.com>
Subject: Re: [PATCH v3] add: use advice API to display hints
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No, I agreed with my mentors to wait on this update until that branch
is merged in master.
So no need to worry about it.

Thanks,
Heba

On Thu, Feb 6, 2020 at 10:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Heba Waly <heba.waly@gmail.com> writes:
>
> > On Fri, Jan 31, 2020 at 10:59 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> > From: Heba Waly <heba.waly@gmail.com>
> >> >
> >> > In the "add" command, use the advice API to display hints to users,
> >> > as it provides a neat and a standard format for hint messages, and
> >> > the message visibility will be configurable.
> >> >
> >> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> >> > ---
> >> >     [Outreachy] add: use advise API to display hints
> >> >
> >> >     In the "add" command, use the advice API to display hints to users, as
> >> >     it provides a neat and a standard format for hint messages, and the
> >> >     message visibility will be configurable.
> >>
> >> The topic has been in 'next' for the past week or so already.  If we
> >> need to make further changes, please do so incrementally.
> >
> > Will do, thanks.
>
> I was reviewing the draft of the "What's cooking" report and noticed
> that this update is not there---did I miss one?
>
> Thanks.
