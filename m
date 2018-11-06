Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1F31F453
	for <e@80x24.org>; Tue,  6 Nov 2018 04:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeKFOPM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 09:15:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33860 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeKFOPM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 09:15:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so11935255wre.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 20:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b0yyTcqdNKSLBmfcu4xuDRLKQDxFCAtPq1OnDbNAxCU=;
        b=hb9sPChXMR/tavFvRSqDX8/Mzoo0OXEh73H31NivFYOeodm/Lm9+hF0hZR/UGugyYM
         gimfj9HbVpAnduuKRovXQPRh4F9nx+jbUnxXKqkJOMB7EwM87J/LhBT0elQvt3r5hae9
         9JMGnXvyOhx8YgbW5mQVMHMjQxwqTyCP/NF2JV6OOiB5W23mxtShrr5EU7CBTZIblCWW
         lZk47T4VF+OQxOs3e2jbSAeibQSF/ObVCFKX4m1/mVahlf4ZNldxSmadrW/RrFl+VskR
         TU/x02G7OPllqs2+m47rBerAal2wg4DSbp3E7q23eTpR5J09PE3mSCxIu0eExY9SVZ3c
         AcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b0yyTcqdNKSLBmfcu4xuDRLKQDxFCAtPq1OnDbNAxCU=;
        b=BEs61Pl6TaTeLtNF1KeP/es0K0mk4XKFDIkfqJ9VSUlwlHN+m489t1UU8EZU9DwY4L
         2/rkKVlz8lLYVcyTHfCeGcAZ3dWayAKhe42bHD9XGjcFkkopkH0AfX3w5xYkjjZ7quta
         jvmwebSRWDpcWScV2BFUg9ezWkF1EYw06eEnHahCieFtKfVXYXyYv3+v+ETzwdjlZIhc
         BjEIgevAFukVAKstA8FNnZ/iSrl8J/ZyIOSKVWONfnxVuqbQW9MAOp5iqhL0+jGB6cYT
         uRfbbHaLnoQz0BPT56kumJ1vPesDoLBxfPnpjjs8hWZp88OofTRJ7b4hh8j1yNJKznwA
         0ToA==
X-Gm-Message-State: AGRZ1gKBhOOIP7iiAYZO1Kp3fZvMEOSz+jFFHpo2P0VUn0nnP6zjHVcQ
        OVXgbrPhb9eX/qxemEdtEtw=
X-Google-Smtp-Source: AJdET5cHtTo3x6dAmU3Uwey5GckCaSfqpLz2wKrE6zWtDJrHIb7GkeAIDqoHn2+X7svG5JuMjEd27g==
X-Received: by 2002:adf:df82:: with SMTP id z2-v6mr20776654wrl.118.1541479910556;
        Mon, 05 Nov 2018 20:51:50 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q2sm18005846wrx.77.2018.11.05.20.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 20:51:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 00/14] Reduce #ifdef NO_PTHREADS
References: <20181027173008.18852-1-pclouds@gmail.com>
        <20181103084850.9584-1-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 13:51:48 +0900
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 3 Nov 2018 09:48:36 +0100")
Message-ID: <xmqqmuqmerkr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Changes since v2
>
> - more cleanups in grep.c, read-cache.c and index-pack.c
> - the send-pack.c changes are back, but this time I just add
>   async_with_fork() to move NO_PTHREADS back in run-command.c

The patches all looked sensible; I'll wait for a few more days
to see if anybody else spots something.

Thanks.
