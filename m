Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBD3C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBHVyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjBHVys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:54:48 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A747ED6
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:54:47 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 7so293298pga.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS5IwoV6cWNY7/qytXsPWLmp8MqrkoptIF/Y3iCYAsk=;
        b=KzIon1ZxZr7LjQIQMxsffKIVD2vhvaFK26pdPm+zGlwZS25KB6hzJpTEojOfa2Umaf
         p4LJqrBVKYMEivvaCAjURJexg9ypkdsfpmIvpHzhcOTAaVkhHhHj1hHKppa1teKK2APR
         FdSg5XEG+wND4FazCaJJGTNND2mxcEUtVfsg/uDJ8L7QnC5CGPGwD98aEQom5I7kRkeT
         jMxYErnw4hIX8CAZa8zM3lSFEzVbOU8Bu38r02iwJOQudrn2BaQ+CWoTbZ+EcpGj8Gr5
         7OGNRgGnZOkL+YhjdHBOxKvU/T3QhJe44e28ANQZcf8zXS5Mi908YAEWtKsuvJKMwjho
         Y1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lS5IwoV6cWNY7/qytXsPWLmp8MqrkoptIF/Y3iCYAsk=;
        b=Z4CdYGXeiBy/x1nnwyMC5U301DrVBtqIt+pZRGu8xog19sZViOO8A5Yc9MJqwcdCSw
         sPzbBFnbUGEzRKS3eeGihEzQpqqNj8m1Gc6XYeIv/zsoaf6jPCWqRLzJzBryZrPDQVhJ
         jZSo1CQhDgz1+t4NT2p7kCXzB6Yne+xLUN0wxFu3RlQMJnZeIqc90kuwQLUb7dyXs6Ye
         VIPst/yqGbMMgW/1DTG1FmS4Zw3g8Su4IsX//grWnWaJcxAZRD4bhdEy/wArNW6o+RJk
         7z8jWwWEHv7CwUzkudI//Yy3xYzr9P3J9R9s9Clp6kFrmbeRsrg0GQXWemj2eWoeoKCA
         Ir9g==
X-Gm-Message-State: AO0yUKVSf6v0ucdho60kmQw5dtrBufqCQKTL20dT5supyIQaPx/PmmNR
        gECB68reZFVDSmL2iMm0dSI=
X-Google-Smtp-Source: AK7set+83HbI9vuZYdYeVWp2thD86E7uMUNcYAQrmLJaxe5+ZTM3dJrQeVCp4K0AWOvQPlzLFrR8Zg==
X-Received: by 2002:a62:cf41:0:b0:5a8:4e65:80af with SMTP id b62-20020a62cf41000000b005a84e6580afmr1006744pfg.14.1675893286946;
        Wed, 08 Feb 2023 13:54:46 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d4-20020a056a0010c400b0059072daa002sm11730545pfu.192.2023.02.08.13.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:54:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 0/3] Enhance credential helper protocol to include
 auth headers
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
        <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
Date:   Wed, 08 Feb 2023 13:54:45 -0800
In-Reply-To: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com> (Matthew
        John Cheetham via GitGitGadget's message of "Mon, 06 Feb 2023 19:29:46
        +0000")
Message-ID: <xmqqh6vvq0uy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In this patch series I update the existing credential helper design in order
> to allow for some new scenarios, and future evolution of auth methods that
> Git hosts may wish to provide. I outline the background, summary of changes
> and some challenges below.
>
> Testing these new additions, I use a small CGI shell script that acts as a
> frontend to git-http-backend; simple authentication is configurable by
> files.

Thanks for an update, and thanks Victoria and Ævar for your prompt
reviews.

Queued on 'seen', anticipating a small finishing touches before
merging to 'next'.

