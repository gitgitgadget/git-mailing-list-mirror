Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB74C48BDF
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 00:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7A16124C
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 00:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhFSA6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 20:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhFSA6r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 20:58:47 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F88C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 17:56:36 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s17so3820744oij.11
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZG+mbrXqJkwi6xXRRjKedmFbSpdnsuxiG2lY/gx3RJs=;
        b=YPEdoxZu5alKM5oFlaSR85iCqh3RjFjo2lVNC8Kws5pX6FochW4CoNR+5jWwqoog75
         x6u+7WyR/4qBbWSx81YQDgNbIOAdKr45hRVoLEYB328wiB5sJgoPNhF2R1N9b1Ubekaj
         8P8aAkVHFDmuI3W/MzKxZmWCncvjptN98gP/Rxw60FHdcodrIR4991Nb99qJB5rGAZ8D
         745AcmVkX05u5Y4TYS3tB6W4/Rju4uyo6C+xVgAxdTssDFECZtVKCB6hZfwHJAuew4m9
         IbBZIBbIedROqdSC/cmHvV/zuTMxijQdpjMiw3FaK6k+326GoNYa7AUCVvpqjjsGWyok
         3dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZG+mbrXqJkwi6xXRRjKedmFbSpdnsuxiG2lY/gx3RJs=;
        b=rIZ/lYTzWLBt/oIjvKdlSd4sHa+eyX75FCXHX8p4PuMC3g8Rood6gmHMdmcLE0z2yx
         xLWPHtFzHoqkzAxOUe3o54nbLHaZKvItlJuuAVHasHr0vd+EDS94bKsIuoNUM/skaVLh
         epXxapLl85a4b46qyr5Uv8kxNJsVadnKuRjWLJDzH389iwy9+C63hodcib3h4sz1rmXT
         tRI0mVgDOMzfgEZUpXfZsGei7zP0lTZb3rd5/AFNtaHk6QYIzXoaw65ihiOK58YUA2v6
         /UbjbZS1lWxKQw1Queo4HAgOa4ugXwfbSZE0HekRunXF8Ax/vOiIgXwDxWe7Z5pznUYS
         mKfg==
X-Gm-Message-State: AOAM531YeGg5WP9AM5k6okk2Vh3p19Dani0HEG1ifHiMpOSJ+c8rqY8V
        oB7yZdA1aKubxWPqGCVlLjo=
X-Google-Smtp-Source: ABdhPJwNm3lchSlKOnVtOIFE6C+nZy5z5miM+i0hr2BehsvHrUc9C3LuplKWyhaAAKev2H9+lgfTBA==
X-Received: by 2002:aca:d983:: with SMTP id q125mr9425763oig.87.1624064195462;
        Fri, 18 Jun 2021 17:56:35 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id y17sm2139049oih.54.2021.06.18.17.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 17:56:34 -0700 (PDT)
Date:   Fri, 18 Jun 2021 19:56:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Rostislav Krasny via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rostislav Krasny <rosti.bsd@gmail.com>
Message-ID: <60cd40c1990a6_ca73a208b@natae.notmuch>
In-Reply-To: <87h7hxyjkv.fsf@evledraar.gmail.com>
References: <pull.979.git.1623687519832.gitgitgadget@gmail.com>
 <xmqqwnqutx6o.fsf@gitster.g>
 <87h7hxyjkv.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] Add a basic support of SHA256 repositories into Gitk
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Wed, Jun 16 2021, Junio C Hamano wrote:
> =

> > "Rostislav Krasny via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> From: Rostislav Krasny <rosti.bsd@gmail.com>
> >>
> >> Signed-off-by: Rostislav Krasny <rosti.bsd@gmail.com>
> >> ---
> >>     gitk: Add a basic support of SHA256 repositories into Gitk
> >
> > Looping-in the gitk maintainer.
> >
> >>     This PR makes Gitk working on both SHA256 and SHA1 repositories =
without
> >>     errors/crashes. I made it by changing and testing the gitk scrip=
t of Git
> >>     for Windows [https://gitforwindows.org/] version 2.32.0.windows.=
1 that
> >>     is a little bit different than the mainstream 2.32.0 version.
> >>     =

> >>     Still not fixed functionality: [1] There is the "Auto-select SHA=
1
> >>     (length)" configuration preference that affects "Copy commit ref=
erence"
> >>     on both SHA1 and SHA256 repositories.
> >>     =

> >>     A new "Auto-select SHA256 (length)" configuration preference sho=
uld be
> >>     added and used on SHA256 repositories instead of the old one. Si=
nce I'm
> >>     not familiar with Tcl/Tk and this issue isn't critical I didn't
> >>     implement it.
> >
> > Thanks, Rostislav; please follow Documentation/SubmittingPatches
> > next time you touch gitk (or git-gui), as they have their own
> > repositories and maintainers.
> =

> A comment on the patch at large: I realize that the author isn't
> familiar with Tcl, and this is a minimal & immediate fix, so maybe we
> should just take it.

Plus it takes a huge while for any patch to be merged. There's 0 commits
in 2021 on the gitk repository, and in 2020 there were only 6.

My last simple patch from May [1] is still waiting for any kind of
feedback.

[1] https://lore.kernel.org/git/20210505211846.1842824-1-felipe.contreras=
@gmail.com/

-- =

Felipe Contreras=
