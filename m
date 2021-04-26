Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60EBC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E261107
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhDZIlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhDZIl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 04:41:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC3C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:40:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ja3so7306401ejc.9
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:references:user-agent
         :in-reply-to:mime-version;
        bh=I719w0L6jzgsPWqBGbv7lwq+e8me5mS7WNqFpH1iagw=;
        b=qb490r/Rwu0mwE+u8cMqHv1xN++ZH340Ye4X/Qw2M/YxNeHQwmH/rAUdUO9NYBXwxA
         jOoOKOk1TJzy5vqtE2rgI7N7EXK+1QTc0T8hS7/bZFKhIuMGa88rk9tKFQrd3jVJMwpQ
         Rodpm71+K4MkvneW1s/0kvqIJ019MFJxE7JcustgYEk5nqSpl2JRce3EIXi6F9bMMfYT
         IWbtX4/USV5M/ivGhckfcHnuWfE5Ax6ddp0vlpFnuirTf5s88SHVXRq+XxBy4LmWNGWz
         5HXyMzqlO2XVPWvxMwRY629WHnQ4qX6AkGdRQ9uyEqs9FheyuK9k4OIEySAIV8cwauq6
         +l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :user-agent:in-reply-to:mime-version;
        bh=I719w0L6jzgsPWqBGbv7lwq+e8me5mS7WNqFpH1iagw=;
        b=HkygerY3uG0vyT2x1Ge4JO2HNm8HDGiO+9fe+uaL9DpHpedcruM6FWF8dQFG0m844a
         kbP7Yl9nj7K41zgSmOaVjmtaOLC0SpubA0nXvgY/IqpesCnoU/iJjpb/Dc82Q7CB42qm
         TWjZ72bciKVnfJIDRO9mpTdamAvCnFMXdylUURrmYL+pwqxMMW/YjWjOeo9ackkH/m0C
         /cReEZKdq26yF58Q5f1I7kE1e3QLvo3uVD+vQNVZHdD2HFFi371VRWTBZuMHM6Becrsz
         Oo4VHTHVPBd4q7aIOFBPXceshjUvvQHyHh5M7aN5THgiXCyySA2m9wxhhEWAFTn2Re62
         9bVg==
X-Gm-Message-State: AOAM533rm+VBwlD3bWQRICrEgM/Ru0WiKNaqgk23408MfVrrMaE8i+9j
        XocgpIrc0ZjtW3LvLxQ/4bw=
X-Google-Smtp-Source: ABdhPJwZPKjXusJAgpLpIsO2dkVsnOVwar+M9PpqU276eM71LDtUIHGoPcv5ucrNQKZWQ5ALVep8xg==
X-Received: by 2002:a17:906:154f:: with SMTP id c15mr17432989ejd.142.1619426442755;
        Mon, 26 Apr 2021 01:40:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j9sm13568071eds.71.2021.04.26.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:40:42 -0700 (PDT)
From:   =?us-ascii?Q?=3D=3Futf-8=3FB=3Fw4Z2YXIgQXJuZmrDtnLDsA=3D=3D=3F=3D?=
         Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?us-ascii?Q?=3D=3Futf-8=3FB=3FTmd1eeG7hW4gVGjDoWkgT?=
         =?us-ascii?Q?mfhu41j=3F=3D?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 00/30] subtree: clean up, improve UX
Date:   Mon, 26 Apr 2021 09:55:48 +0200
Message-ID: <875z091nuj.fsf@evledraar.gmail.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <87wnss2219.wl-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <87wnss2219.wl-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 23 2021, Luke Shumaker wrote:

> On Fri, 23 Apr 2021 13:42:00 -0600,
> Luke Shumaker wrote:
>>                                                  I promise that
>> there's more work coming on top of it (we've discovered lots of ways
>> to break the "subtree split" algorithm, and come up with fixes for
>> most of them).
>
> Follow-up question: If in that work I changed the shebang from
> "#!/bin/sh" to "#!/usr/bin/env bash" and started using Bash arrays,
> would that be so bad?  Would that be land-able?

It's in contrib, so personally I don't care much. But e.g. on OSX that
means targeting some ancient (and going away?) version of bash + having
*BSDs needing to install bash for this etc.

Bash or not it seems to me like that argument parsing code could be much
simplified by simply declaring strings of arguments accepted for each
sub-command, and then parsing those arguments + dying on unknown ones.
