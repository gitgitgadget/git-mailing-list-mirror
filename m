Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E4C47087
	for <git@archiver.kernel.org>; Wed, 26 May 2021 01:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A88613CD
	for <git@archiver.kernel.org>; Wed, 26 May 2021 01:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhEZBYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 21:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhEZBYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 21:24:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD03C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 18:22:42 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j75so32101422oih.10
        for <git@vger.kernel.org>; Tue, 25 May 2021 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vjjIVms9PbdsCLTw1lfpU47eqGGJ0zEPjHFfxWGKznI=;
        b=WWrEVlJJgmkjgxxC6obEyio1N87RP30lxPOhpmM9/EDHUD9RZtDsI5IFS3acA4qH3o
         Vn49GfPddSeYkS5tEaRrAT0PjQbET7mU3wg2zje4dXMDHkIdaQausD9pmFuEqEWWbWrW
         33u3PD3gRH6/ue/u+Dm3eh3ZEeArRlP2N1M/plTaDs8LzbG3cQwCMckF6CZHw0O+DUwS
         7OEffoxiJx5BzG3t6iV+ttgCYWCH/LJLKukEy6ELfVaDL6eEJrbXIdTtiE1dOLygHzFF
         i846mqYtTLLw6TLdFkdGkKDn8BeY3KaeYoAbSRLAYjntGaml1VCWDgzCgd7o7naoNP6I
         IJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vjjIVms9PbdsCLTw1lfpU47eqGGJ0zEPjHFfxWGKznI=;
        b=OniKYq2EfD6dkO9KCavKcjlGDQerk7JHqPVxbETtqqyjaujuym0SNY8OpWenyyI68a
         qiTELfzrGLvM5C0Sb/2l0TtDVMYKA5Ia2w/fgywGFRUxF5wB0HfdcAOtivVKqeE+/lDC
         HqN88RxdOHDhbV+m4I8dvwcbmKKPwGk4GXm4023pqvGnxO7fefeurpME1Nj0kpts/tzK
         DmoVT+TeqtT373tnigcEbbxUUoAhwmbpFrmxzqU5FdI8hFcxvQKDUGqZ71DItxNAo+9d
         kZdTPE1OWEz5m/yy5yqjftAszs4AkyRAPjYPEvxzTKM+u96i8SQEloN1ESDU1lpmWNgN
         v/dQ==
X-Gm-Message-State: AOAM533d9nKR0RqFv/Ot1HlFcmijOLu1v2or0Z3D8KN1yeqYuD2N3pMi
        yMdmqppmIiRl7C1m8oZg+kc=
X-Google-Smtp-Source: ABdhPJwjAm+OT5WQJmjqb9ij7wrGBP8RpslDyqg8bwKd0k+Bz0siE0RRRTnWQsjxjGb1wdH+v+S7vg==
X-Received: by 2002:aca:3197:: with SMTP id x145mr286245oix.23.1621992161725;
        Tue, 25 May 2021 18:22:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y34sm4128322ota.16.2021.05.25.18.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 18:22:41 -0700 (PDT)
Date:   Tue, 25 May 2021 20:22:34 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Message-ID: <60ada2dac06de_2c7f620854@natae.notmuch>
In-Reply-To: <874kerny0e.fsf@evledraar.gmail.com>
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
 <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
 <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
 <xmqqh7iripzg.fsf@gitster.g>
 <874kerny0e.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the
 core.hooksPath
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, May 25 2021, Junio C Hamano wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> >
> >> In c8243933c74 (git-send-email: Respect core.hooksPath setting,
> >> 2021-03-23) we started supporting core.hooksPath in "send-email". It=
's
> >> been reported that on Windows[1] doing this by calling abs_path()
> >> results in different canonicalizations of the absolute path.
> >
> > I see the author of that patch CC'ed; the change in question
> > explains why we switched from "the hooks directory immediately under
> > $repo->repo_path()" to "ask 'rev-parse --git-path hooks'", but it
> > does not say why we call abs_path() on the result.  I guess that is
> > because $repo->repo_path() has always been a result of applying the
> > abs_path() function to something, so it was to safeguard the callers
> > that expect an absolute path coming back from hooks_path?
> >
> > And that makes this change dubious, especially as a band-aid for a
> > breakage immediately before the final release, doesn't it?  Are we
> > convinced that the callers are OK with seeing sometimes relative
> > paths?  Certainly the cases the tests J6t fixed are not negatively
> > affected, but is that sufficient?  To what directory is the
> > configuration variable supposed to be relative to, and are we sure
> > that the user will always invoke "git send-email" from that
> > directory?
> =

> The one caller is git-send-email.perl is fine with it, at least on *nix=
,
> this fix still needs testing on Windows.

While I understand the reluctance to test things on Windows, sometimes we=

waste more time discussing about what couldn't potentially break there
than the time it takes to setup a VM and just make sure.

Am I the only one that has setup a Windows VM just for tests?

Also, there's ways to trigger CI runs to test this stuff aren't there?

Seems like a much less painful way to leapfrog this roadblock.

Cheers.

-- =

Felipe Contreras=
