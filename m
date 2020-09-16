Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DAC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 09:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D8A2076C
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 09:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAdI+X59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIPJMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIPJM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 05:12:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77167C06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 02:12:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i26so9231997ejb.12
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erXogUnJR1G6PznwBoBVYgk0SxCEY/N/HYYp1wPZaXE=;
        b=EAdI+X59CBwN6uTrPPohTPuLUE+/8NqMzapfuOikyMb5B/JO157s5SbaNvGxUuQtqS
         DnzpVUqjFR+Z0fSyTBVDJniy/Nv0rD5QStd4MQfp2GA1dHUYHLdse53ekD/ewZ9udLub
         bZSq/4XybqhnnYD3PPQqE6WON8U7gyS7iIl0koeo29ae8QFVuX7B03QHQjG85aMCo9ti
         OaLRoBzbbvFH3AN+4UPcJkjoRP8ytcI8Qx6lEpgUywpj25TGL2tSk8DB6cfF7K7tfT2J
         GS/ocqkdYtZBi8t7TAyKRNU9B9fe+A4oxywqfucXmZ+hu7BnSXS/bB4vF0fFNrsg+fsA
         0iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erXogUnJR1G6PznwBoBVYgk0SxCEY/N/HYYp1wPZaXE=;
        b=hjDS0d5PPUs2o/9Qgs2vGyII4IhtkwqPjVW5nEHz68P01w4oe+MFH7EKvoIz7akYEB
         RsjKqOEb0yJu0O7PbR2naRaK/id2+QOQGAXr3PEcRoaLVzAUdhYdC7/Q9T4kk/WxmTe2
         1y761eT3wpoCiFCVvJUhoLw9bN5zckxcqxXNGd5471GT/FBgi7dj9V5B+dh0niwFR9SY
         BcUFhtLPuHND7y1htQUu4UJDufhIXfoLeuoR6gHNgRBwbicCLJ6oiBJFynPnavvyedu6
         8kBMFm+IYo3xudhQF+WvlxBUwdAi2i66bDgX5vWRCFD++ZVUyjv6UAVaDD8aV/MyLAEd
         96vA==
X-Gm-Message-State: AOAM532YPmwyYtr2kXm/1TlLNM4OG2T6HN2VxkvpIPQjsALK2R92fXeu
        auheGgxqeClmZBQnGcHEQgVy5ZrcOOhot4+mosvlemLqMZg=
X-Google-Smtp-Source: ABdhPJwgK3Dgqpgj+vRfYPllvPMGeeJ8HpYobCjCn3UOYyspQAInrzv3gio5LP4WduJJm4M0nkv1Kk5e7CZP+R0ZRPw=
X-Received: by 2002:a17:906:8258:: with SMTP id f24mr23621169ejx.551.1600247544634;
 Wed, 16 Sep 2020 02:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com> <20200903060041.GH4035286@google.com>
In-Reply-To: <20200903060041.GH4035286@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Sep 2020 11:12:13 +0200
Message-ID: <CAP8UFD22MJ4YygF_XgYykHAPjp66jbndgyT3g2F9AL0PiiWdSQ@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Sep 3, 2020 at 8:00 AM Jonathan Nieder <jrnieder@gmail.com> wrote:

> Christian Couder wrote:
>
> > I would appreciate help to find project ideas though. Are there still
> > scripts that are worth converting to C (excluding git-bisect.sh and
> > git-submodule.sh that are still worked on)? Are there worthy
> > refactorings or improvements that we could propose as projects?
>
> I think setting up something like snowpatch[*] to run CI on patches
> that have hit the mailing list but not yet hit "seen" might be a good
> project for an interested applicant (and I'd be interested in
> co-mentoring if we find a taker).

I'd prefer not co-mentoring this one. If this is the only one you'd be
ok to co-mentor I could reconsider though.

> Some other topics that could be interesting:
> - better support for handling people's name changing

Following discussions about mailmap, name changes, deadnames, etc
during the Inclusion Summit yesterday and the day before, I am
interested in co-mentoring such a project along what has been
discussed.

> - making signing features such as signed push easier to use (for
>   example by allowing signing with SSH keys to simplify PKI) and more
>   useful (for example by standardizing a way to publish signed push
>   logs in Git)
> - protocol: sharing notes and branch descriptions
> - formats: on-disk reverse idx
> - obliterate
> - cache server to take advantage of multiple promisors+packfile URIs

Would you be ok to elaborate about the above projects? I am not very
much excited about any of them, but I would be ok to co-mentor as long
as my co-mentor would come up with a proper project description.

Thanks,
Christian.
