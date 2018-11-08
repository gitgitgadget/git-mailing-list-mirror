Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55881F453
	for <e@80x24.org>; Thu,  8 Nov 2018 00:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKHKDJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 05:03:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37500 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbeKHKDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 05:03:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so17263136wmc.2
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 16:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P4p57+1jVR3opvisnkiOO/WRmfU9rBfVH3p11g0TvMM=;
        b=PHtbZQPr9Sw+AQZQpX1Qf/6tV6Hb18EbNvbsejCByid9tJ1HGIHahsuYCOq8oiBn3P
         7ML78f021YIfew77K9+I4TIFSoqO8bQA9xoqep5ipRP3w1RDrTy9yEi1Kxj02n7DfQ4A
         S8Spqz9d1erSJB5gmPW45Hh18JvDxHLPWPbk3bcKoJwnI1uHVp8kNOk8sx47+BB64M3x
         2VIUet9hmCl/bgiOCGIw3qdn+ffMAKFHjkZY2gqVEOqx4gwN96sCpJ3rDu7W110mVN45
         ncBsUWHIjGZ7D9UMWBsVI3jkMKPsjprLtvq5SAa6U2PGnmED7F4kJV5R+blsleXAbUmj
         jiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P4p57+1jVR3opvisnkiOO/WRmfU9rBfVH3p11g0TvMM=;
        b=X6NOqkVywmmksj47eNfxFmbwNaMSZuvZ3veXMec+8FP/5mlRNvL/cg1abMgatuMinC
         WsbPmueGIz7N7+7dauVF7hg9Nm/S95lmwyuot01eS3Ubl3j6pZ1Qn0pA03JtszCVykVt
         POJl7mSSps2R9Fhtc7cIzrhHei7oh7QSycnn+S6joDrFvoEyCCKCt4qcY1lsPxszAbAA
         8YAemUJtG9zOslu/7MVmDFMVfaTJRtJc6p3xabhseMmsvPEN3aT9h3xifYsAvxOyNaoz
         QHhkbv+CxfnBg7wdphLaD3IadbTFq/QSjbzBt9C2GuKkC3fMvEhNcDbxFaEM5Xa6utRt
         ppyg==
X-Gm-Message-State: AGRZ1gKx8aILpsHfTXqvy6k4O6QvMV3JLeJQ/lvIkuPBFoKMNisNME9L
        NWrsBimEKTkCOq1g/fVfNt8=
X-Google-Smtp-Source: AJdET5eMWzP5xEAzkd5aidYojLXhN8EQwoNuPTKHxVPIOk6YezvrFYJaUMbD20UpbgzPSqh30lrIhQ==
X-Received: by 2002:a1c:2283:: with SMTP id i125-v6mr1959511wmi.42.1541637017947;
        Wed, 07 Nov 2018 16:30:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r76-v6sm3641102wmb.21.2018.11.07.16.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 16:30:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
References: <pull.66.git.gitgitgadget@gmail.com>
        <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
        <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
        <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
        <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
        <20181107204142.GA30078@sigill.intra.peff.net>
        <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org>
        <20181107220320.GA8970@sigill.intra.peff.net>
Date:   Thu, 08 Nov 2018 09:30:15 +0900
In-Reply-To: <20181107220320.GA8970@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 7 Nov 2018 17:03:20 -0500")
Message-ID: <xmqqlg649zs8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 07, 2018 at 10:36:52PM +0100, Johannes Sixt wrote:
>
> All that said, if we're just interested in allowing this for config,
> then we already have such a wrapper function: git_config_pathname().
>
> So I don't think it's a big deal to implement it in any of these ways.
> It's much more important to get the syntax right, because that's
> user-facing and will be with us forever.

All of us are on the same page after seeing the clarification by
Dscho, it seems.  I came to pretty much the same conclusion this
morning before reading this subthread.  Outside config values, the
callers of expand_user_path() only feed "~/.git$constant", and they
are all about "personal customization" that do not want to be shared
with other users of the same installation, so "relative to runtime
prefix" feature would not be wanted.  But we do not know about new
caller's needs.  For now I am OK to have it in expand_user_path(),
possibly renaming the function if people feel it is needed (I don't).

Between ~<reserved name> and $VARIABLE_LOOKING_THINGS, I do not have
a strong preference either way, but I am getting an impression that
the latter is more generally favoured in the discussion?
