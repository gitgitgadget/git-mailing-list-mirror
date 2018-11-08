Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1B21F453
	for <e@80x24.org>; Thu,  8 Nov 2018 03:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeKHNAD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 08:00:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbeKHNAD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 08:00:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id v18-v6so293439wrt.8
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 19:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UjzvwWgxYuE9ib4VRCkpSYJSCEYOLZFRV5NI5S/MKCo=;
        b=PFMdJr65pBGf8IuXKymgMzV8AgTIgXISPM5MFd8gxL0h5cLLncd57nsOmY7ABUpt5Y
         VAZ+ZqAD5E8vCOHhXRJql0nMs6lI92zfzQ5hefALlcQY/l+X/a3KoCrPWPLmAYYpWRNa
         Q/51PWdPdMFYhnqorgTmaAl1gB1P5SjF4VwC4TM5Q2YrxYsbh6GCIiykULPa1vOxqtFq
         C4CVwwJeRV5UcpsSMQOvyQJ45FUueFNBUtzeMcklJcUXofl3l+hEw0urN/g0VUIm0HT1
         /gwTYNgzkt+CdCqK4gAmSrjeha9mj4K9YuWyLuVXQJVVjNXRxUA+ohU9pfeEyf7CM5V3
         RBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UjzvwWgxYuE9ib4VRCkpSYJSCEYOLZFRV5NI5S/MKCo=;
        b=XXLnVAsoyVGzsIr6Bm9C3b7NFcnCr3bURM8/XPFuFGNgOUXSZydA31gY7dj5rDHlV1
         dGuv8reoW5c4TQMpiJxtV9TnUdn/V4WgxfP8LR4CeaqbNIpoYw2a4N534njTEgcoiBI6
         1niM91vDM2bc92e5/ak5UwM8IuC31AUlSKqupm52T/UbDhU802Fww2571DqbyYYwljJW
         EHXLhNtWoBMv3iEuSBikwzryuhBCuajSrYtsRWA+j3UqghTNRnBpBjCpx3X5jkKwNlfO
         pUgitcC8KMh1LvHY3vobHPlt0WUHfjmmUaz1gmW/1wH6LDZiXEm1pTGtbydOzj53PgoN
         fAHA==
X-Gm-Message-State: AGRZ1gKuc+xdK2XjYmoA+/Pcdj2yzDp/JkL94fS1J5jVJ9JJzpq2AQTa
        xG2ueTPMGk+5wdI7ucJjoWyh/8wbvbs=
X-Google-Smtp-Source: AJdET5dGpTqm+3Zn4cc6C8g5gtuVnv3SMAF3qa4uazIycaluPAyLpBMsMleKSFhGK58UgBsURlfclg==
X-Received: by 2002:a5d:5745:: with SMTP id q5-v6mr2372737wrw.161.1541647599265;
        Wed, 07 Nov 2018 19:26:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2348487wma.6.2018.11.07.19.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 19:26:38 -0800 (PST)
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
        <xmqqlg649zs8.fsf@gitster-ct.c.googlers.com>
        <20181108011813.GA10148@sigill.intra.peff.net>
Date:   Thu, 08 Nov 2018 12:26:37 +0900
In-Reply-To: <20181108011813.GA10148@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 7 Nov 2018 20:18:14 -0500")
Message-ID: <xmqqlg648d1u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we would want to carefully think about the call in enter_repo().
> We do not want git-daemon to accidentally expose repositories in
> $RUNTIME_PREFIX.
>
> Looking over the code, I think this is OK. The expansion happens in
> enter_repo(), and then we take the path that was found and do our
> ok_paths checks on it (which makes sense -- even now you'd ask to export
> "/home/" and it would need to look at "~peff/repo.git" and expand that
> to "/home/peff/repo.git" before doing a simple string check.

Yup, that is another reason why I think this new "expansion feature"
belongs to the function, not to a wrapper that is aware of this new
feature in addition to ~tilde expansion.

>> Between ~<reserved name> and $VARIABLE_LOOKING_THINGS, I do not have
>> a strong preference either way, but I am getting an impression that
>> the latter is more generally favoured in the discussion?
>
> I certainly prefer the latter, but I thought I was the only one to have
> expressed support so far. ;)

The first mention of pseudo-variable I saw was in Duy's message,
wondering if $ROOT is more appropriate than "/", and I counted it as
supporting the $VARIABLE syntax.
