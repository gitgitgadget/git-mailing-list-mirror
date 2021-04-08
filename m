Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D40C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A7A610C8
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhDHRi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHRi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 13:38:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0DC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 10:38:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d13so5384968lfg.7
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MSI2+pUTYAzDalsfOSYMkLJZH1umjsdeM046z4qcdo8=;
        b=j3sMllERcvxjfu3depM6g8Jcnk/whlf5LSnvraQ/RCObqiEnYmXhjIP+Js2MWmh484
         E3ZZibiMcSJWiRYXkCMA6ogaFbEFTwOR39RCzDiMJQM7pXHNamthaG8NCp/gfqs3NUf5
         SwXHUnu8ciipQdzvuE2gZ6hOnOxnsdtyEBD3pxx8RdEHWMxikH/IURKumQbq9oaP+0X+
         K23JNHoVlVe6/ttA2rHwr21Vdc2e31J4fwfE94GB6fgPrEfcNgvr0P2P1yP8hHScpjmB
         KRYk49OFAn3/OwMSAxZnI8bh/V4mbpV4pqpjKekB8qlAZTY05DMK2Lva90PLPhy00sSN
         omIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=MSI2+pUTYAzDalsfOSYMkLJZH1umjsdeM046z4qcdo8=;
        b=GIXGgrUyAVlew7B9HWngRxP5Kzc2XI2Sh+0Gg7yOoTbsh4S9I2e3nTmDPJejPVlIwF
         vlV5aa4Y/Cmx3Ok6YAsw6c8T33REnENwmy2oS0wCZ5AcHcunIs1hh1CAgy3EGXECvYWm
         oOdweTQokcMfhPIWrcI5Ke2+yJloRnz18TQLNUE0vSUTvEbUt+ExSwXnsFxRoLaX0eiP
         f3ui+xAzOZqRIq/t/YSYDTnbOAWve/as9vOXkAAaUdVDa/m2EUNAbGzrIukv/f4QNPRc
         hgSdEgOOPBhDTriQDlUEkbMXLQHBZhSci8EGt2ohVXnz37Z1hf6eHX0r+XrQzhSCtpHz
         1Lpw==
X-Gm-Message-State: AOAM530SO0PnDhn0/OGZthwysyG90WNyU4UMe/GT2XOMQQXraiVozI//
        Y6PE7c2YdmBdE98x39YZbgNiVv2eXaw=
X-Google-Smtp-Source: ABdhPJwOYzpDZNjV0Hb4epKrX17aLKkQNVGrLqS3W4AjLaVlKe+t1p8Nu/D0jA79dS5Ws8U/jVmQ/A==
X-Received: by 2002:ac2:54a1:: with SMTP id w1mr2883610lfk.48.1617903495280;
        Thu, 08 Apr 2021 10:38:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m24sm6580lfq.184.2021.04.08.10.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:38:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/9] diff-merges: introduce --diff-merges=def
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-2-sorganov@gmail.com>
        <f6b25ea6-88b1-c167-7fd4-440be8782fcb@iee.email>
        <87eefkdfho.fsf@osv.gnss.ru> <xmqq8s5svg8b.fsf@gitster.g>
Date:   Thu, 08 Apr 2021 20:38:14 +0300
In-Reply-To: <xmqq8s5svg8b.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        08 Apr 2021 10:27:48 -0700")
Message-ID: <87o8eo7k3d.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Hi,
>>
>> Philip Oakley <philipoakley@iee.email> writes:
>>> Hi,
>>>
>>> On 07/04/2021 23:56, Sergey Organov wrote:
>>>> Introduce the notion of default diff format for merges, and the option
>>>> "def" to select it. The default is "separate" and can't yet be
>>> "def" feels a bit too short and sounds similar to "define" - why not
>>> spell out in full?
>>
>> Dunno, it just happened. No sound reason. Will change to "default" for
>> the next re-roll.
>
> I do not immediately see the point of writing --diff-merges=default
> on the command line in the first place.  If what it calls for is the
> default, wouldn't it be easier to just leave it out?

It does enable output of diffs for merge commits, so it's not the same
as leaving it out. The "default" is the exact format it will use for the
output.

Or do you mean using bare "--diff-merges", without "=value"? It is
considered bad practice, right?

>
> But if we have to have it as one of the choice, please do not invent
> such an abbreviation, especially without taking the fully-spelled
> form.

I think we have to, see above, and yes, I'll turn it to the full form.

Thanks,

-- Sergey Organov
