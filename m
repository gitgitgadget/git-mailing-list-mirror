Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A49C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 14:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhL1OhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 09:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhL1OhU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 09:37:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E97C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:37:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z9so4724941edm.10
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3ncYnKs1UspkXaQ1v8HaGzt1fyflbiRgEzNlzlbQfNI=;
        b=gRgQmHIJfRnKgB3z2klgsTD3kNSdXopzmONiRg4MhgD8N84XrPRzWg+6LZUf8Jrrjy
         d5wN9QbtUIvdFECzICADttsWB6VYy6kxDqzOKLFu8FM8v5QWc8bEVE1gHLl/wrmLYUgj
         0LVZtH8JuC1cOh1h8WCIEX8cJhe1he5KbM8Cm+NY4oIfIh0k1hKCnUyiy7ewUi9D1Ec6
         yY0jKxCp6cvG6DtDLtrwE5pUHTGwjXwcpWsVhJY1CpGMsvcFvLh1X4EmrgcFTA8McO2S
         qpLqZvKe46Y+88x2eawivmmIqeeESYDV/ix//lRehSQBlUT1oDV5jGVetHO4KNS5CarC
         kLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3ncYnKs1UspkXaQ1v8HaGzt1fyflbiRgEzNlzlbQfNI=;
        b=RoYkGICAxsm1NAi+gsu35XpSsoj9TxadBK2yiSD5ykZ4Bvk+90TC5l2rLMrZY4O6N9
         QRsBHIR08q8HRG4ogjdPFyk9i+6YOTUnhuMSQUthMHQx51elKNwoGq0Pi3x82cx5YO14
         wSs74IWIkGrMGMxw6ay1pSdoq+gahQOwPvDfSQJNmFmhG+Q1fcYO6ig3opdXCpRMdDcb
         FWbXownqkWXB6BD69gMNvukgtb4UHRD43PtqxtqLYZX56HVPeX/6jzS81vWCMtt+/UaE
         SXx1gBPy2Gi/6LCJGxKByARygGsUtTbvBQ0HJPi9UJA2FInbUUdf2EDDNzQZ4os5yKFl
         dQFA==
X-Gm-Message-State: AOAM530MDUpmEuelcoN4yPG4q5FpYiGPSgQscaYKSr7ThSOAwlaLFitp
        PFWywcouyHvRKvPfiHWWavo=
X-Google-Smtp-Source: ABdhPJwY27oaIoPFNhOwbxvxwcIO54IokT/1FBucD7RvMzTUpNEGLWEXcnB/Ob4/8ujErT2Z0TAo5w==
X-Received: by 2002:a17:907:11c3:: with SMTP id va3mr9204565ejb.599.1640702238413;
        Tue, 28 Dec 2021 06:37:18 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id gb10sm6078813ejc.49.2021.12.28.06.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:37:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2DbJ-000Dfd-AS;
        Tue, 28 Dec 2021 15:37:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: ab/ambiguous-object-name (was: What's cooking in git.git (Dec 2021,
 #06; Mon, 27))
Date:   Tue, 28 Dec 2021 15:35:58 +0100
References: <xmqq7dbpvb0q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq7dbpvb0q.fsf@gitster.g>
Message-ID: <211228.86h7asiyn6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 27 2021, Junio C Hamano wrote:

> * ab/ambiguous-object-name (2021-11-26) 6 commits
>  - object-name: re-use "struct strbuf" in show_ambiguous_object()
>  - object-name: iterate ambiguous objects before showing header
>  - object-name: show date for ambiguous tag objects
>  - object-name: make ambiguous object output translatable
>  - object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
>  - object-name tests: add tests for ambiguous object blind spots
>
>  Error output given in response to an ambiguous object name has been
>  improved.
>
>  An earlier iteration that was much smaller had seen some reviews,
>  but the latest round enlarged its scope and needs to be reviewed
>  afresh.
>  source: <patch-v5-6.6-78bb0995f08-20211125T215529Z-avarab@gmail.com>

That v5 got a review from Josh Steadmon. I submitted a v6 just now with
some small fixes he suggested & to address other feedback on the
v5. That'll hopefully make it ready for 'next':

https://lore.kernel.org/git/cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com/
