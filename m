Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4072EC64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE84F2075A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgLBC2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 21:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgLBC2M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 21:28:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF4C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 18:27:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u12so511910wrt.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 18:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcERtcHIAANz1oduPBdXgq4UHqUusuQGSWl8Q/RWhSc=;
        b=TSG5PDQSWjsny6X6v9K4FnWnTT5CzyLxNrZMRqxQCU4MlGoN+6BNCzy/W8WHRxGbfI
         SnEuz27Y1Vc/KAE9S/U0C4F61EXuuhmVwjcodgqul0QjSaMiXLKWTD9ct3N6m3Gsuu0Y
         ZABgJ8+ewqimFAnMIq2rcCPTZhuFUemyE9XVChoImmS5gN7L8mHFBH/Sx2n2dNDh4sEt
         ChnqlDhaGUIVazX00uke7oyUk3MH8Ew8KJ3FMEQyTVcOYL0Qf/9JTHi40qE2CQUn/q2s
         N7/sisBkhkc+8QFuNXT6AE805+tCWq/KKnfVnkRSjZmbxlFdXMEa+OzRN784qlO+6w6m
         jdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcERtcHIAANz1oduPBdXgq4UHqUusuQGSWl8Q/RWhSc=;
        b=ULMhMif/NZAvhtNY4IXKj0EwjNsH6rtfgO/oAGyHxULwqyjle1j1OJniDMBwEJqvw5
         cnP0mQgjTCPrVZjbP6gYRFmN05RwxWnsEtmIzGSyi89I7Mt2UL+lpPdm2vQQZmlxIB3Y
         CNdOttIJ1xMd6vAYj59p3ozmAh3LeQAvHpDRV4AmaC/Amh0oOFrAP+AJ8vVX7XxtGxU+
         KSkNM1LIokRjt9x4D0Xfl+xClOkgMquLH/cS6KWtKunenNSIAqCJigh3tb+tHswFafKw
         lT4Etjz/PXFuAphR/EE5HDxsO/XNhB8EX9FyO60jLH2KvzzoZKNfZyWfNmCjFHeKqW14
         QaMw==
X-Gm-Message-State: AOAM532OHa6E8/twN5cJOFtGZgqfKxlES5LH5WM6kj2md5KYDhl/SRG4
        5UfdOht9mCYmUYuE3F2CdC3eqxGrou0xB4bQebU=
X-Google-Smtp-Source: ABdhPJyy2eNtgUUT6r/zvjHHOjUDcxQYPJNgqeA3RkPZr8y4pLbol0RjuMFNhf+BtbflPDSAUuUwa0+Z+bUCAKpmySk=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr221313wrv.255.1606876050274;
 Tue, 01 Dec 2020 18:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-2-felipe.contreras@gmail.com> <X8YsXjN7MQrLnytw@coredump.intra.peff.net>
 <CAMP44s3usd5EW4sA6_qapnDBVRAWg4nk5ZSxAPPQN1UygD=ctA@mail.gmail.com> <X8b1au+GDihNvhIQ@coredump.intra.peff.net>
In-Reply-To: <X8b1au+GDihNvhIQ@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 20:27:19 -0600
Message-ID: <CAMP44s2KHv_XvQi7YiGKLZ3Tz3nvOj3ZMg+uZtZLnLjyW-wgNQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] refspec: trivial cleanup
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 8:01 PM Jeff King <peff@peff.net> wrote:
> On Tue, Dec 01, 2020 at 05:25:53PM -0600, Felipe Contreras wrote:

> > In this particular case there's no particular reason to just continue
> > if there's no prefix.
>
> Right, which I already agreed with.
>
> I hesitated on responding at all, because you and I have not had a good
> history of agreeing on commit messages.

We don't have to agree. Having a different opinion is fine. In fact,
that's precisely what keeps a project healthy: diversity of opinion.

Do not hesitate. If you feel it must be said, say it. Or at least;
don't hesitate on my behalf. I don't take disagreements personally.

> But my comment was primarily for
> other readers on the list. I do not want people blindly applying a rule
> like "less indentation is good" without thinking about the code overall
> (I don't know whether you thought about it or not, but it was not
> apparent from your commit message).

I see. I did think about it, but I couldn't find an instance in which
such similar change could be contestable.

"Why not do so?" was my succinct way of saying that: I cannot find any
of the typical reasons why we might want to keep an indented
condition. Sure, there's possibly better ways to state that, but I
couldn't think of any in the limited time I devoted to the commit
message.

Maybe: "There's no reason to keep the main conditional branch
indented; we can invert the condition and not continue".

Cheers.

-- 
Felipe Contreras
