Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8995C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 00:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiKWAUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiKWAUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 19:20:16 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27717D5A0F
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:20:14 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 130so15858902pfu.8
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpjJq6Zpj0Wh6NsoSv38rAqmij9mCIBNV9iuF4VHjtQ=;
        b=VbWNgloAKE+ntciEoiXakI/QptBWhni2InOqwL/FqV1ogeCgI3KIq5qCgquo0KW4uo
         +Kn+v0XUZggxdN8rXG7c+wVH13peadHYj5qDLqkCOd1WketmKlC6cYjBZdoPObJwrjQ4
         owiEMK1cHVpT61P8xI61nNexLhvEU00/DtxibaVjEljkL4kG2J8kR4atK788fI+dr0/h
         dOORzRoUMiofH/iT8Lyrex/IycPCqmCMEcmPS+fgkIeitTQUdmqtaaKbUsYGxZJgXLUL
         IhReozM3iTidk9joqWohTlruxWSoEXiuUt++Z2ISmL3PV0Z1cnNJevXC0xmSVQsCEyzW
         7Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpjJq6Zpj0Wh6NsoSv38rAqmij9mCIBNV9iuF4VHjtQ=;
        b=G9GhkpcPUgC1VtCXd0PkNfLBfh7mcgc9rqUpsGiu7qv69q1/fOMtzz16+HNi086hqR
         8/ZoXYMRujVKSfr15Y7mkeaElMIrtGmcRJ62T1SyjzHMuYGGrIpXkGCTtRVS+ewDuRKA
         WlZ0TjgCjLsisiEJ2HUGcG/VQTeJhYCU+OsRR0lFNOUupfn28FgddKnI/gv+BohIBobf
         sX1wbLdPYHCrYUQDX/lav0gbSgT46YsktbpW5Xm2pudIJazCyqclPCrAQAQWCoR4GgK8
         SWGg1ySblXyN2dnRS4HHnCuXJa8wIgLKWsio1TffljJ2mMxlg1+/5rTIuhPAozE3qbb4
         XTOw==
X-Gm-Message-State: ANoB5pnjEjeiJxFwAOC+M3hp/ngepx7GmXEmB2rtS4SHvqSFKyi1pbaH
        pZvq6afE+j6P0yQki7W0dmmoQpK3bWw4YQ==
X-Google-Smtp-Source: AA0mqf7PpKEltLBZWnw/s6jVPIgyfaMOpgcOrTVhe7rwvh0DyiGhaX0zJ3b1EFfixIILJtb42OAFag==
X-Received: by 2002:a65:67c3:0:b0:477:96e2:beb8 with SMTP id b3-20020a6567c3000000b0047796e2beb8mr6285684pgs.151.1669162813505;
        Tue, 22 Nov 2022 16:20:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090a3fc700b0020087d7e778sm131077pjm.37.2022.11.22.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:20:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jan-Otto =?utf-8?Q?Kr=C3=B6pke?= <mail@jkroepke.de>,
        git@vger.kernel.org
Subject: Re: git tag -l --format results into a malloc fatal error, if tag
 is signed.
References: <CAAsn9Yxbb3-4iTfD8gf_EhVbE+yKJdT=Vb5ojeFZOHvMutUn2Q@mail.gmail.com>
        <7386132c-995a-5bfc-ed67-ec6dc2c3e7f9@web.de>
Date:   Wed, 23 Nov 2022 09:20:12 +0900
In-Reply-To: <7386132c-995a-5bfc-ed67-ec6dc2c3e7f9@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 22 Nov 2022 18:48:44 +0100")
Message-ID: <xmqqedtuplmr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Fixed by b01e1c7ef0 (ref-filter: fix parsing of signatures without blank
> lines, 2022-11-02).  It hasn't made it into a release, yet, but I would
> expect it to be included in an upcoming version 2.38.2.

I am fairly certain it would be in 2.39 but probably not 2.38
maintenance track, as b01e1c7ef0 seems to have been applied without
considering that it is a maint-worthy material.


