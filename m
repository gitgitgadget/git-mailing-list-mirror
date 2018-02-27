Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0941F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeB0XmM (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:42:12 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44720 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeB0XmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:42:11 -0500
Received: by mail-wr0-f196.google.com with SMTP id v65so514402wrc.11
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JIaGekvKr2BkWG5HlwkXTtVYR/dV6SPPih8E9REkTic=;
        b=pgyaYvA0j8pju4cY7wAMTSx1QEGEwpBe/4GGuJTI+t1MC/B4GnHkVRtQRbdb6sQh61
         E2asGJYfrpzJeUpn/6osFOJSISHj/el5GuvYVSllOlMWq/9a8mdPLR3+szD0bapKNTqo
         BnLSaCoHefIspLA8fgG55Aki6nAHkv6ob1FGEQXJGuXrNeubBPE8w317/zgLDCaGbXlQ
         kZ+3qeTdmvIj+mW9Pe/wsnTHIMCI03iNywaxG8p8u2qfSQj62kSaijF6NELMKJGOeoWk
         RJhlON4ewKPwH/LSfAoLA+dWxLM05hw3bb7Uxzve1il5Bg58GXErpWwJsqpj5nSGatY8
         4O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JIaGekvKr2BkWG5HlwkXTtVYR/dV6SPPih8E9REkTic=;
        b=h12flZKu06T3qUSueoVLW3rHuYAuDvMeJmjVr4mzpX6kLKBUUISUAVygePzHrs9iRe
         7b54+mtNz/HfyjrO1ALrfsg0rHfUKLgduOAKH1KWmsLLeTtXREoCtgF2mIyLYTMwDxTP
         Cfc8bYOWXthquVHZk8Kflq0RtysFSxLsd+EKqH5hpm71XOIjgbioxAi0FuXDu01suOb8
         GBseel1rNNqXWaHIRZdQR5Fav24XBGzmlZlvMUcpzFie9J3GQ2YzrqGsB6w6Wbd2ptpE
         Ub3ZeCt+3rGf9fXWPPGz41wqklrHhZWcVqVNdWeneRBypJKQn3QgQZxULqtN/EL/ebgx
         dTGQ==
X-Gm-Message-State: APf1xPBHgg4uSQt3JSbhLmFauwi3Tdaz8wYNksi4UUFC+pDBkm9cGaw/
        Fl0NoqZKcjtFObaDRrlncf4=
X-Google-Smtp-Source: AH8x226fJbPqg9TOdzdTm1o94liPlPmcKLPI7c4XSHUHBckwd4ZMhrsNu1auOnec48Bguk+tr0MHxg==
X-Received: by 10.223.154.7 with SMTP id z7mr13854638wrb.98.1519774929634;
        Tue, 27 Feb 2018 15:42:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e18sm1166874wmc.21.2018.02.27.15.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 15:42:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] roll back locks in various code paths
References: <cover.1519763396.git.martin.agren@gmail.com>
Date:   Tue, 27 Feb 2018 15:42:08 -0800
In-Reply-To: <cover.1519763396.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Tue, 27 Feb 2018 22:30:08 +0100")
Message-ID: <xmqq1sh6ngof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> Patches 2-4 are the actual fixes where I teach some functions to always
> roll back the lock they're holding. Notably, these are all in "libgit".
>
> Patch 1 is a "while at it" to use locks on the stack instead of having
> them be static. Patch 5 removes code to roll back locks which are
> already rolled back.
>
> I've based this on maint. There's a conflict on pu, with c7d4394111
> (sequencer: avoid using errno clobbered by rollback_lock_file(),
> 2018-02-11). The conflict resolution would be to take my version for the
> "could not lock HEAD"-hunk.

Thanks for running a trial merge before sending your patches out.  I
wish there were more contributors like you ;-)

The changes looked reasonable.
