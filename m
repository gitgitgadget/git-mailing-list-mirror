Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07AC48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D5B613CB
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFJOi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:38:56 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39548 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhFJOi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:38:56 -0400
Received: by mail-ot1-f52.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so26618103otu.6
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+h9pWvzQT83EUZoFnKyISJyKzG9du5HvlS9mdevyo8M=;
        b=ZnOZFoz6vU19D9JLiligq359oXrr7IVuLtrwXXOtyZbFKIW6ETogC7Q83jnyrytpYy
         GWh+2IfOzfyOhtXoi0/zMNHzjdWPTNC+6SHHeuJchQJk6NvuwIrqBdt2bk7ieVFzmuS/
         umDN6Y0GbvzJhbekJHXoz8Fo2dQ2EOincpipO2x/73yv66FVJruX6RMv//4moYKFhsaN
         /DYD5DD7ROIi6Y69HJQLQ6dVOxNFvewPzPnFHpTb9lw6qK4tgLeL/wummTcIRyvIcpgU
         HthrzZndCrPz0cvT/Q5dSOHZy3v/9ocozBZ/2n9enZjnmlm/oq7So4ZiXWvw2J3SXEN9
         dxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+h9pWvzQT83EUZoFnKyISJyKzG9du5HvlS9mdevyo8M=;
        b=daCHr6hg6vAZU8xmQOQDX00sym+9p01FBNDNduMERRYJrSvNk78WWE8yf5LA8shW3x
         h94VZqzmURW9AkRAHn14QEziNpRA6MpiQSIKRFsY7PRn+GaXnqLD5KJwHZuVJirwJ8Ut
         EFV/cnXXPKheroXfamEbTxxQQyop+NgGa9YCsnqYYlY1Jl0T1vuHyDPt55Ep6ZLBu2xm
         Fo8KJAR7DXF4PwGSYvRcZYNYR5gr+DeHjX9sDAbViKSkQ0mz5kaE9DrvFTuYojNRFk+o
         QDu01v+C/Tm0mlGtGsijOOtbrRy8U0foxO3mc+aWFZ52//uPj0AAAK3dtOLu5Jix8DOs
         1u0w==
X-Gm-Message-State: AOAM530nWbTieaiMDb2tjK9jFUB4NTJ7FAcA0URq3ZFG+B31i2ghfMEF
        GNAEdJr6HR+U8OmpPrtNcb8=
X-Google-Smtp-Source: ABdhPJysXLVjRlPNFkFaIQo6Bg5kxsm7ctXhmF6Q2JTEEvyRtrT+hTZptj+gzwn1bsMci4UQNofQMg==
X-Received: by 2002:a9d:6c89:: with SMTP id c9mr2664386otr.163.1623335745173;
        Thu, 10 Jun 2021 07:35:45 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u42sm338353oiw.50.2021.06.10.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:35:44 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:35:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c2233f2b1b9_b25b1208bf@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2106100940380.57@tvgsbejvaqbjf.bet>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <87eedd4n20.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2106100940380.57@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> And it is desirable to edit them, too. If we truly want to be welcoming
> and inviting (especially to potential contributors who currently feel
> underrepresented), we need to model the language in our documentation
> accordingly.

Whether or not this particular approach is how we want to model the
language in our documentation is a matter for debate.

-- 
Felipe Contreras
