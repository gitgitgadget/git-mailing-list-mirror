Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D25C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 17:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1D9207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 17:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgJZF3AY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2RBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2RBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 13:01:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6AEC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 10:01:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l4so25026983ejd.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTvAFAVsfMXo3HHEH6ZkkgAheWxxRzrL6HGmgASxHhc=;
        b=BgJZF3AYYQe3x5hC0QgGza31mpH//XJwkUbqolDNQFVMIeZ6jgUEzFzORBxBP/QoHL
         qZUH/iTAuCq0AVZHj0cbiTFxGFAVg9Mg02Oaik6Aqo+/9bwVN6uJ23LMRSxwLjPWd/Hg
         WvDC6Hn/R/u6iNtNS6vzY4Qs9q4IjrJtBP5QI6XRkUtrenLhUKOl6cZsi9CEopQbcjYM
         Pna3oOKlZgDZYTguzb3kszsDP5a37iKaFFwRUzkNUnMzKoExo2Su4dGpGUAinAlGpoj2
         lvjq0Xy+814EAffb8B2eu+eL0tRXBMvIiZScNMMHApT7n9+0ExztoJGKJKMAXRFq5mPq
         +WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTvAFAVsfMXo3HHEH6ZkkgAheWxxRzrL6HGmgASxHhc=;
        b=RrcX0x8V6wsgfukfJNEZz7C/hb/a4djsJLTaAgF5e7g3IGgM96+0VPGv4y3549XPGd
         6T1y5kPhqZDwCVW09yHnBRXrHpY8P0kt0PGV5PnWkX4MvVOjTz+4LHcrc7Cn1GKGgnT0
         KGsaF+7t0lb0BnR7YKUCz/UOCmmqIkGu/GcMeIPxfRwleAOIGZVghNrkoedAKKm/keVc
         hc7DjaQJ52IX37Lj7dPqjeR/CjQwqAJJCz9YA4jICZ9efkCYjd18lhvpyGBNvmDvxIlU
         +9p4POLLbSg6OZJbZ17eaNGd6g1EfjOHguz0Gir7+ESxwXLjaLgGwpH/kS7Yy73i7GNj
         AlKg==
X-Gm-Message-State: AOAM532ElKy73wTJwNQn94JkAa3eCuXxkoOtCVw/5oNLnPm9jE8MneBA
        0QcJEm8ofLC36D7MgX6+12Z/U0rmDccW5AnOc8lFyQ==
X-Google-Smtp-Source: ABdhPJxqHHj94t1e4zoyiknaKeT5+n3U//gB4S3zeT/VS1sELNcWp/jDJCJ6kFYUBsml36dE4N5CZe6Xb09EZSYaBtc=
X-Received: by 2002:a17:906:3b91:: with SMTP id u17mr26594531ejf.305.1596042091112;
 Wed, 29 Jul 2020 10:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
 <20200726040226.GA19030@dcvr> <20200727151023.GB62919@syl.lan>
 <20200728100726.GA24408@dcvr> <20200728162528.GH87373@syl.lan> <6b4b3f77-a479-4d7b-d7c2-e3e35e658ac7@gmail.com>
In-Reply-To: <6b4b3f77-a479-4d7b-d7c2-e3e35e658ac7@gmail.com>
From:   Carmen Andoh <candoh@google.com>
Date:   Wed, 29 Jul 2020 13:00:00 -0400
Message-ID: <CA+TwhoJqm-EB6OkLOr6+B4RZfaQ7aVde+hSrSeWV-jYkfBLGNg@mail.gmail.com>
Subject: 24 hours to respond with date/duration preferences for inclusion summit
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 1:15 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 28-07-2020 21:55, Taylor Blau wrote:
> > On Tue, Jul 28, 2020 at 10:07:26AM +0000, Eric Wong wrote:
> >>
> >> Jitsi w/ audio-only certainly seems to be a step in the right
> >> direction and would be more inclusive.
> >>
> >> Is there any speech-to-text transcription done for the hearing
> >> (or extremely bandwidth) impaired?
> >
> > It looks like such a thing exists:
> > https://jitsi.org/blog/a-speech-to-text-prototype/.
> >
>
> Yeah. A link with current information appears to be:
>
> https://github.com/jitsi/jigasi#using-jigasi-to-transcribe-a-jitsi-meet-conference
>
> >> It'd ideally go to #git on IRC (or something that doesn't
> >> require a browser to trigger swap storms on old systems).
> >>
> >> Even for people with good hearing, acceptable audio quality for
> >> speech seems tricky to get right, being dependent on mics,
> >> bandwidth, codecs, background noise, speaker/earphone quality,
> >> etc.
> >
> > I haven't look hard enough to see if it supports redirecting its output
> > to an IRC channel, but my guess is that it probably doesn't.
>
> I believe you're right. From the link above:
>
> > Currently Jigasi can send speech-to-text results to the chat of a
> > Jitsi Meet room as either plain text or JSON. If it's send in JSON,
> > Jitsi Meet will provide subtitles in the left corner of the video,
> > while plain text will just be posted in the chat.
>
> > In either
> > case, hopefully disabling audio and video is possible within Jitsi's web
> > UI, and you should be able to read or write in the chat as well as read
> > the transcription.
> >
>
> I think there's just one catch. The transcription as of now appears to
> use Google Cloud speech-to-text API. Well, its Google. I'll let you make
> your own inferences. In any case, it hopefully wouldn't be a concern for
> people who _read_ the transcription.
>
> --
> Sivaraam

Hello All,

Just a reminder that you have another day to respond to whenisgood
[1].  Note that times are listed as 6AM-9PM (21:00) Pacific.  Please
specify duration preferences ( half days, full days, etc)  in
comments.  Hopefully we'll respond soon after that with date/s that
works for most.

[1] http://whenisgood.net/9z2diyy

-Carmen
