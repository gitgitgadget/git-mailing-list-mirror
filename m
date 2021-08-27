Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919EBC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797B960F92
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbhH0H4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbhH0H4W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 03:56:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D967CC061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:55:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y195so427591wmc.2
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VxxPHSgoZ65fRXpFCmwmlBX2cV9zKTppL1kLBl08k94=;
        b=E5BNbSTfJbIDIIQhTo/W5jWLtLcc5B3k8vSXBjFhNsDppmR1gdvk5GVwSza4nCATsw
         UU5iMSJM7CkO9j+cv+TyztSHBo56CEU+1k9+Dwe2jpAHrmXlHpiiyaUT52k0bhu6/qwp
         hB5PhGlXwURPYBzMItn9ra/4JTWxVKMCuB3cfZdPzk1DwIefD40eBTwCI75mb9Wfpu2z
         KmoFbVMSPKCDdNbtmfJPMGNiuNQ3JXOnV5yZUMGVTLQTd0BO/cASBJoawcvmgPs56bdK
         YtCazNWmIDZc/ioRiurfXs2psQ3ssPr353/0gBF9ydsGGcAWcjVOwRhPAXH9D35dJLq+
         lJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VxxPHSgoZ65fRXpFCmwmlBX2cV9zKTppL1kLBl08k94=;
        b=WqhB6ExRcfBNK1cWA8Qs2X9zPMMT0lkSZP3nsIz+CJR9/h94+ZM3voMQluHRcqHDnA
         /ehoAt/smfBmSIYcrIgG8MsQilnCzpxtNWjQoQ1yGXEgq7iZWCQhJkrj61PX8XHPywE9
         omZPfAdM0f64BgD5SiZ0P82GvHwKhud4VBzgxlpkwlL00XHwU5xmK3/fU49FqVk6p9mW
         yykEBqLuud2q6rZMHp088sG6UK8njinnKcu6rx4jwQkHukKhciINn54ILgJi3NY2f0zC
         ykXV+1rlMtsS+G37QC2AQAS+3j/66/PMVZ+RPGWunnfrhCPk96nhMhMZEvsvUwF0fp52
         WdRw==
X-Gm-Message-State: AOAM533htnHlg9ZtqPeYY6yKytcRqgpQd9Wbms5X9NF9V+ty6pPEkFCk
        dw5WT2h/TX/A2PmtivAXRKmHhQ6C/95OOw==
X-Google-Smtp-Source: ABdhPJzSFfSoMBkX3CwSYd8SFjrtS4nMepllPjL09HJcHNe8Dn6OTQCBvAAgtdzSB/DaI/dsQ5gX3g==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr17965680wma.125.1630050932404;
        Fri, 27 Aug 2021 00:55:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b62sm93332wmb.17.2021.08.27.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 00:55:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: Antw: [EXT] Re: [PATCH RESEND] branch: allow deleting dangling
 branches with =?utf-8?B?4oCR4oCRZm9yY2U=?=
Date:   Fri, 27 Aug 2021 09:53:09 +0200
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <xmqqr1ehgq8t.fsf@gitster.g>
 <CAFQ2z_Mwj0+uWO-Ly8MTHmidjf=1P-9K1n2f0DSNzN=Or2t=bw@mail.gmail.com>
 <xmqq5yvsf8p5.fsf@gitster.g> <xmqq1r6gf6ne.fsf@gitster.g>
 <61289339020000A100043878@gwsmtp.uni-regensburg.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <61289339020000A100043878@gwsmtp.uni-regensburg.de>
Message-ID: <875yvrz5ho.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 27 2021, Ulrich Windl wrote:

>>>> Junio C Hamano <gitster@pobox.com> schrieb am 26.08.2021 um 19:38 in Nachricht
> <xmqq1r6gf6ne.fsf@gitster.g>:
>
> ...
>>  * It is hopefully becoming harder and harder to check for behaviour
>>    in broken repositories in a "portable" way, simply because we are
>>    making it harder to corrupt repository.  We hopefully won't point
>>    a ref to point at a missing object, we hopefully won't prune an
>>    object away that is still pointed at by a ref, etc.
> ...
>
> Maybe git needs a "--disarm-safety-belt" option that disables all those nice checks for testing purposes ;-)

I haven't tested, but I think in both of those cases a way to accomplish
this corruption in a way that bypasses the safety of our tooling is also
to setup an alternate object directory with the relevant object(s), and
then simply drop that alternate to simulate the case of an object
disappearing or other such corruption.
