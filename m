Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33162C7EE2A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjERUuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjERUuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:50:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA510D0
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:49:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae4baa77b2so18559705ad.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684442966; x=1687034966;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUsA8HhL45eSuswBNmJrUUzI9JB5y8+VV9gMPLoilo8=;
        b=pNPR/Aq1Hhy5CS/oAF6sy31a0dfCn5ENwinY1RN6moA4JEjNqsVlvvGksJd5gB0PWW
         OCs34sQ/aQ6IqmApBAHHW8YlYWC0ya9V3KQ5Okn+yR7e/vbdZWTu3XnaZy0Y26L7ziYT
         BarX+9VOJVOTEDk3KjapsetEgcaPgO+cawQPCJ/rCTubhRgNVWFGn3ZqQif2CYmbkE7z
         awZ/lOX3z731hc81mAdzjBPg7fXW0YPlgpdSgFmmW9v14ig7sTZOQOBajZgFHr3y7avY
         Cmpl087Lkg0tJuN2YMh/DWdgzAtJBDok7YeQW4I02FKkw9oZ/kHnwCvBlcKJPmdT5/jJ
         bIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684442966; x=1687034966;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iUsA8HhL45eSuswBNmJrUUzI9JB5y8+VV9gMPLoilo8=;
        b=Wsew6inazL728QuS8swk3h+0WLMsrihUmEJ8U0o91CmBtfWewiMdKDzTCt4YHld6gh
         TD3a6cqOcuq7YdbBzs78X8vk6lNuE67eWZsNDM8Kc02ba42dE+jCqWrddoBwFPKYBkKP
         MOOeJ9FWfaVlRCXKYaMJobW07Yt62j8SNvmXmjFlfDeQLz87bgiFz7Tges9AFS5kNnBj
         1KEGH0K3DRSdWayeu+3Rhl5Nspjb4AXzhu/Lkg4j8SWpXRw58B4QmiKas1+oxkwBEml+
         d5F+Y4Oukojplb8qRFAUIY+uSkNVa4UClVSf+9jt3Jr/TepbmZOEtPf/GDlI5GMjP2Qd
         py6A==
X-Gm-Message-State: AC+VfDzo2GRUhn9Y6EtQsZij3VACoLWMzNGMpmYa+eq6I/E/Vid+XntS
        PJdSwTbW/vJxEPwSJOAW1IkOXq49gUQ=
X-Google-Smtp-Source: ACHHUZ6nlxN901uFNgkrsHx27p+xPIPBNp7rE2vWqTgAVXnf4KylAUua7Bs7WQt0j98kWVm/ipX4Zw==
X-Received: by 2002:a17:903:1111:b0:1a2:8c7e:f310 with SMTP id n17-20020a170903111100b001a28c7ef310mr404864plh.35.1684442966068;
        Thu, 18 May 2023 13:49:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jg1-20020a17090326c100b001aae625e422sm1909909plb.37.2023.05.18.13.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:49:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Christian Hesse <list@eworm.de>,
        git@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>
        <ZGT/eK6+IKlCM6Sg@nand.local> <xmqqcz2yrjbe.fsf@gitster.g>
        <xmqq8rdmrixc.fsf@gitster.g> <ZGUVvjG+xou3w8YW@nand.local>
        <xmqqy1lmq183.fsf@gitster.g> <ZGVFnzyStiscDKh3@nand.local>
        <xmqq7ct5vdbk.fsf@gitster.g>
        <20230518182504.GA557383@coredump.intra.peff.net>
Date:   Thu, 18 May 2023 13:49:24 -0700
In-Reply-To: <20230518182504.GA557383@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 18 May 2023 14:25:04 -0400")
Message-ID: <xmqq353ttlez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 18, 2023 at 09:01:19AM -0700, Junio C Hamano wrote:
>
>> Yeah, I am actuall hoping that somebody clever, with time, comes up
>> with a systematic way to give us better coverage, but until then, I
>> think it is better to honestly record where we are to future
>> developers.
>
> I faced a similar issue with the -Wunused-parameter patches. Just when I
> thought I had everything annotated, I'd find some obscure Makefile knob
> that compiled new code (or even in one case disabled some code that used
> a variable!).
> ...
> But at least in this case, the old "if it is important, somebody will
> build it and report the problem" line of thinking worked out. So maybe
> that is enough.

Ah, I guess the debugging situation is quite similar with that
topic.  Thanks for your insight.

