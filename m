Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC17DC07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7B3613E3
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351725AbhGSQ44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357359AbhGSQvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:51:37 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F2EC07456D
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:55:13 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h9so21520022oih.4
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EMaXXJEpmFhT1y9n8pc70cUpr9SHENwgt31r4z4iKoo=;
        b=BskPhh7pd5SlS0MJTQ9j3lXlo9YhIqhIjEdclZjSYUiDf1WWa0wvthLgxlySYRrwmG
         xp1OgUuu5gR1VYE9IfxUmzwjTcyu9Lf51FX63L3f5i4nf9lqIAovxcXq8dQGFJaZVQLb
         bqjDaPS3imKb40B/74u18jyZwIqkBpg0zp+hkm0ygjG5I4sCWRPyI7K2sPYRheEkNIZG
         9ugycUdL52Z/p6Gi3QDiYIOZ2DdVybCaC/tGnUq3c2Ckrov+qZfrRNurYBhlg7RWv5DM
         6pupxAjQ//aQrPe9bH0Vd3QJtjgge+AyczyqIKZfY4BIEFTRhSlSDq2mR/UkAQSPw9z6
         Qpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EMaXXJEpmFhT1y9n8pc70cUpr9SHENwgt31r4z4iKoo=;
        b=qMYk2aeWWFI4C286kBcOloGkPdr5XYtIrAY95oY2pvOYdHsTmTipHq+pnhyAMmsITE
         NWb+fQ1tpwEG+Qawxt5jvJnA6fkjRPIIuGD/2XIlj+nvFeasDnAsbmUZy22vZsch1a9m
         n5fpCAg5Y/JUSPvXlS4kz+PjFW2eSpKtm6mhw8/tO7+x/hntSi+0wPC3wcClPlWd0yvu
         TgYE95lL7tI2r4KXqLoE23Eo04iMEeX7yFqbuF9W8M6h5PiY5HzJwZ/yFgzDJwyF78jo
         Qr1vuUKP5VD1kxgoSNawjUusLwRonYjYZuueiOYWWvZU1vpMngnsCdY9rgryUpaouhTO
         97yA==
X-Gm-Message-State: AOAM533Qey3yT8smJkYfX1zmfPiV1I2IzF2v/4gifAaUqNgotKIoJcWO
        mDG0LvV+T8JkPjFMUpSQtRY=
X-Google-Smtp-Source: ABdhPJzv0P4Kf65oSLKVCkpx94e8CUGaltUW9iOus5CTNekpvrHF7HoDbaptz8Ov6eXZSpyNBLm+9g==
X-Received: by 2002:aca:d11:: with SMTP id 17mr22114869oin.19.1626714901929;
        Mon, 19 Jul 2021 10:15:01 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id s7sm1524852ool.14.2021.07.19.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:15:01 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:15:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Message-ID: <60f5b3143fd26_13f2e220892@natae.notmuch>
In-Reply-To: <948ef19f-5588-62e9-6fc7-aa6d82f21a1b@aixigo.com>
References: <60f1daa896f69_330208b1@natae.notmuch>
 <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com>
 <xmqqwnpooctj.fsf@gitster.g>
 <948ef19f-5588-62e9-6fc7-aa6d82f21a1b@aixigo.com>
Subject: Re: When are you going to stop ignoring pull.mode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten wrote:
> On 7/17/21 11:22 PM, Junio C Hamano wrote:

> > I concentrated on "if the configuration is set to do some kind of
> > rebase" case, as that was your question, but the above reasoning
> > applies equally to the case where pull.rebase is not specified or
> > set to false, i.e. the user tells us to merge.
> > 
> 
> Perfectly valid reasoning.
> 
> Initially I came from the situation where I (as maintainer of a 
> repository) proposed to do a `git pull --ff-only <remote-git-url> 
> <branch-name>` for the others to integrate the newest changes safely 
> (i.e. failing if they had errouneously worked on that branch, which it 
> is not intended for). I thought I could reach that safety with the 
> `--ff-only` part, but it seems one of the devs had pull.rebase set for 
> him locally and thus managed to bypass my "safety". Mr. Elijah Newren 
> called this a bug, see [1].

It's not a bug. It could be made a bug if the semantics of --ff-only
were changed to something that overrides pull.rebase, but that something
doesn't exist yet:

  pull.mode=fast-forward

Right now it can't be done.

-- 
Felipe Contreras
