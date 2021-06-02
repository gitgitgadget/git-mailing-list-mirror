Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB0C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 00:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F0260D07
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 00:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhFBAww (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 20:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhFBAwv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 20:52:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A72DC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 17:51:08 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w127so1112605oig.12
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 17:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xlqeqCtFvsAXRnCPiP4kc4WL3znBDueuHeVV90w4BKg=;
        b=ZYJm49A9U1P6RLz2lWHSf6vi1eebUklVKjPNt0EbB+Fjrjei31GuBi2eOp0wTHe/8h
         mezTQui9PJfSKW56G5SyldmhPjqcibbfe/JDmcn6HbGPGJPQJv5+g9rVoNy0fBZlrnoj
         V4BvYNxcbGF+ogrvZ2AJjbgWpAwd1I3q3cydh9HtUd6XhWB9lVRRW8zfzmiI6jr2V14j
         UknxvOKR9nAuil+rL43lYgoHG52FtNBcxDxv2MeToZoWnTIZHmLyhnlm+BpoS5q7Fbym
         nFIYtL9AaJee7YIqTAh7U6//IIJ00vBdXtVYnSetiDKN3EABZTlufjCttawwRfrE4kzL
         YFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xlqeqCtFvsAXRnCPiP4kc4WL3znBDueuHeVV90w4BKg=;
        b=bb0+xgdS6U9FS3D14btZ2cT2aSHp0+g0S1Td7rwC8FcmnX6FWrCuNjH2kdAVSbG9mN
         drRaAzz/T6y6m2BHszt8TMndnDrAfMRQ0eHItXDWpfDwVQX1wtU5a9L+Qe6e7q/3NLiD
         hNoIDlfkr868sNj7PJ3p/qYY4YRr4KYE7KPlIUoQYw+c9n0GMR5pgs+49FFBVNYQ8eEx
         hq+C3//rxl8pjbZoG2GDq3r2we7mVPTPwuW5vDs5QgRlvrhjInYI1pjAjMMT1croYEtv
         qJL8SK4jifftkIXbMN2/D6NSatby3pChqxYskGiITfJaTA0hOJqxDGfnCCL51GErGCGO
         0d4Q==
X-Gm-Message-State: AOAM532iCnMDrSd9dzowC5/ALdD6rdUVnbBcAAcEMrvrmRbVqteZYfR+
        7I0XjRPeq5wJiqddjKxiY40=
X-Google-Smtp-Source: ABdhPJxthqE2OmkwA4eExkwskNCGEq+EsN9NPomUvrcmvTmqaCDN3YF1R1TlCfo5vfgzY4sP3L9FHg==
X-Received: by 2002:aca:bc8b:: with SMTP id m133mr1952136oif.10.1622595067273;
        Tue, 01 Jun 2021 17:51:07 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p1sm4228602otk.58.2021.06.01.17.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 17:51:06 -0700 (PDT)
Date:   Tue, 01 Jun 2021 19:51:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60b6d5f985c40_4abd2081a@natae.notmuch>
In-Reply-To: <patch-16.31-a16163d4fb5-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <patch-16.31-a16163d4fb5-20210528T110515Z-avarab@gmail.com>
Subject: RE: [PATCH 16/31] receive-pack: convert push-to-checkout hook to
 hook.h
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> =

> By using hook.h instead of run-command.h to invoke push-to-checkout,
> hooks can now be specified in the config as well as in the hookdir.
> push-to-checkout is not called anywhere but in builtin/receive-pack.c.
> =

> This is the last user of the run_hook_le() API, so let's remove it
> while we're at it, since run_hook_le() itself is the last user of
> run_hook_ve() we can remove that too. The last direct user of
> run_hook_le() was removed in the commit preceding this one.

I think this should be split in two patches.

Yes, fundamentally there's not much of a difference, but if you are
already at 31 patches one that removes the last user and nother that
removes the API will make the progression a little bit cleaner.

-- =

Felipe Contreras=
