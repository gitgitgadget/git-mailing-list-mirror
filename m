Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1466AC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376402AbhLBRmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376374AbhLBRms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:42:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A07C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 09:39:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l25so968524eda.11
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 09:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H2nIieF3kh4jhPIunOonckIsW+T4UqxE+tjUMN/MbOE=;
        b=aQujdx7LxB9s9feaHVYBJ39y5zrUqxn7oGg3YbKAq9U/O1jqF3noh8UWXxn56ue9hQ
         cBS5eaOXNeIQulcJPDMSS9pzSEk9QF9KwWNMqhR7uYeY9XeQ3Ahs53HIwhnPdBamE9Ep
         w9MwT9FKY+wnLVJkBZlB8aQJyqa30y4ULUD48F8hFIdMXFTDVUQJhhQZnGzBZFHcmFXT
         j/Ne3Up6+WP0HXOXBu6GXlZGjGXSh77Rb8pJhDRauEJgItCO/j50Kh9YQuDkQqWLwLtw
         7i0rXxj2UK9CtR5cscMe+aIlGMPfuYgcSY0zAL3xb4rkiBG1lTZ9WiPrkefuI26t0mYA
         oMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H2nIieF3kh4jhPIunOonckIsW+T4UqxE+tjUMN/MbOE=;
        b=2lwtEeLofI73dXn56Uz+PgvLmZE1Fnfi+vTRK1u8zMQi+ZvTPaI/l8V4S8f6zJmE6v
         A9stLtW0py8nDlHWSQSp9pBk1LfG7CH2HXQmiQ1BjCZEiWhVsCTNkIkNrKX3gArbdGDK
         G7h2heopio9LKkMX16pvWwCt1bycJrkGW9xst/YEyIbzmhhu5mjehsRtfyxc/ia2U425
         DwHDPV9QPZQRMqq+88VnmmkeEDzP4CTsviwvRi+5UCEL820qMIZnmGmc+IW++2MgukCs
         5hCGg5BZLaOq8Q9HSWlrSHFPEx3cuv3DbYuBZkUZW8jqPF8Y7MYl/Q8xu+s/vNohrea8
         CZ2A==
X-Gm-Message-State: AOAM530xmyBl+9k4JOZUDjef4Y3OFqaxpkyYeNg4opQjigRTWt16DqjZ
        h4DCKFyb/DJTuuNJldP2Cc0lrYAbuVM7frnQT48=
X-Google-Smtp-Source: ABdhPJyeWQT08nLmhQKMyTZSfqUL7owRYkdx8idK1clXONBes+fTz/UE+YGAdfWAhCmQ+crV7wORdYHCJm9P4GCbdpE=
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr19815615edx.279.1638466763848;
 Thu, 02 Dec 2021 09:39:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
 <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet> <xmqqtufs1a39.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112021549330.63@tvgsbejvaqbjf.bet> <xmqq1r2vvszo.fsf@gitster.g>
In-Reply-To: <xmqq1r2vvszo.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Dec 2021 09:39:12 -0800
Message-ID: <CABPp-BGaHHUuQqvvDLBSaRG7C=SzS-ykOLi4HCdDDXQHgHjmJA@mail.gmail.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 2, 2021 at 9:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > No, it was not intended. It was not even intended to integrate Scalar t=
his
> > tightly with Git's CI, but since you did not move along `js/scalar` int=
o
> > `next` for the past weeks, when no reviewer had anything to add to the
> > actual code in `contrib/scalar/` nor were there any objections to
> > integrate it, I made the mistake of assuming that you agreed with =C3=
=86var
> > that such a tight integration into Git's CI was desired.
>
> OK, sorry to hear that we had miscommunication.
>
> I took the lack of comments an indication that people are not either
> interested in it, or viewing it as not-quite-ready-yet and waiting
> for a "more or less done" version.

Sorry that my work project rendered me unable to respond for over a month.

> I think the CI updates from =C3=86var would be one of the things we'd
> have early in 'next' in this cycle, so if the topic does not play
> nice with it, the perception that it is not yet part of the regular
> CI testing would continue, I am afraid.

I think I missed the answer.  I believe Johannes was curious if he
reverted the recent CI testing of scalar he added in v7 (which would
as a side effect make it play nicely with =C3=86var's CI updates), if the
resulting version of js/scalar would be acceptable for next.


(If my opinion matters: I'd be in favor.  In more detail: Personally,
while I think CI testing would be nice once we have a functionally
useful scalar, the CI tests of this early version aren't really
netting us anything.  And they're blocking future scalar series
unnecessarily.  Johannes already said he had planned CI testing for a
future series, so I'd rather just take this version of js/scalar minus
the CI integration for next.)
