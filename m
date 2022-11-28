Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B264CC43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 23:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiK1XfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 18:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiK1XfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 18:35:16 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63D2D1D2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 15:35:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k7so11722479pll.6
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jx2uxYCRnDzzyiaT220Yf0FgYPMJCPsiOCCMJQ2LZvk=;
        b=icKjk+RuNzVYcHNl9PUxiLkOpZ6HIwQyX70k7sBmTMCtbIExxLE3CyNwuqrwyTZrBy
         K3Wpy+ouz+AM2/ZUSYXTD80VtdtMZctuM4pKYNaF9kY0dKGOMLXaayq+bPOK10ORi5t2
         rbHuFxmxpd0UTVbMbW9YzRlVLBdr06IenZFnojqHBDc1leo+UGhYSvq5JZa9SNxbsF1D
         1QLb2iWyDuYH0Gvjw49TuywyZ/GrTNhnFmvPBFTSAUlJojMzSj38VZH4TlygVadD4eEa
         6LY0BKkSvPnBpzGTbTNyDYTz4HJmjNOTOK66KKrZq1r4/8W6iTzCSVonfsoyhkzQRKam
         fuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jx2uxYCRnDzzyiaT220Yf0FgYPMJCPsiOCCMJQ2LZvk=;
        b=0CPsOSOOSxJXLuscDDtF3qJulG6pTB4wOqFmOwu4NRzDyWtBaw3ZFNMtd0IBk26aXe
         XI8uKXzY/4gYOeiwrDx9KZqM0TWtPVf0PgpZV4OKGj5bX6jdiovG4B5uoN+2dYzcUChQ
         2OaVIZSe4sbJMmklQSoXMfwa1pLWx4f6v2FZNRPiJxjd6iaxPzijOSITLNXRFi7xcuCu
         CTMvE5VAWn1ycyPdDFFzrOwpT/YtmacdQcEIuBubS77ssx96HvrGfP+bkaJ4Ag6qbaaP
         ULp5hCjZU2MKl0mpEQMGT/t/YoVnhZZjimrXosC+vBV8ZspB/eCWg5YPjlWB4is+OAsZ
         wNUQ==
X-Gm-Message-State: ANoB5plmCW1tLKTa6xjDP79uBjAGCuZ45TPXBF7fkgVSuoODMke/p9ME
        q55fHkSaJxG0w55GgHF3lio=
X-Google-Smtp-Source: AA0mqf4oZnOiR2JXZmM2x2Qhv0dCCP9+B5gh3RlYAEAolNpL/wAkAS7siajamkY6Yoa4N0nN8XCElA==
X-Received: by 2002:a17:902:f646:b0:189:3eb7:1c86 with SMTP id m6-20020a170902f64600b001893eb71c86mr30631899plg.53.1669678515491;
        Mon, 28 Nov 2022 15:35:15 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b00188f7ad561asm9389386plx.249.2022.11.28.15.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:35:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v8 0/3] git-jump: support Emacs
References: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
        <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
        <b79a4852-1e20-2c9a-a91c-f1ea629af402@dunelm.org.uk>
Date:   Tue, 29 Nov 2022 08:35:14 +0900
In-Reply-To: <b79a4852-1e20-2c9a-a91c-f1ea629af402@dunelm.org.uk> (Phillip
        Wood's message of "Mon, 28 Nov 2022 10:13:46 +0000")
Message-ID: <xmqqiliy64b1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Yoichi
>
> On 27/11/2022 01:18, Yoichi NAKAYAMA via GitGitGadget wrote:
>> Add an optional argument 'stdout' to print the quickfix lines to standard
>> output. It can be used with M-x grep on Emacs.
>> Detect emacsclient by GIT_EDITOR and invoke the function. Tested
>> with
>> EDITOR="emacsclient" and EDITOR="emacsclient -t".
>
> I've tested this version and it addresses all of my previous concerns,
> thanks for working on it.

Thanks.
