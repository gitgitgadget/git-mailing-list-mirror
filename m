Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F65C04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiHXVOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiHXVN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:13:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A77B2BD
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:13:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r22so16109074pgm.5
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc;
        bh=qY7Zk6FBgnWWL8wW+746HAt4xhP37vyR83D2cGbkxKY=;
        b=Dnxe5T7bpWPD/Yr/Qr6gPcWZsZc2n/s5WLASnn9Fiyw9IAAG9EklmajdkfBblHh33R
         tU/Q66Q/YP7wkegjHVGainkL7bhQ0Sg9aGD8OD3jwoLtL0OqYmEylUxzdFW2ciOW5LpW
         9Z6D1g9lh8FjP/pjIe+j7AUzTfkh3nKbbF0HwveIxnPa+AZyyAkfZ3bkj4QjsqDRyYz/
         nYh1OCzO91xOYCuV1JO00p4umnUvn4SXIefCWLTYYhK3bYXA3kPIjaLZuSDPxYzt1PZV
         Hiqm/fTV2yfHr8DdBpusqu4hHrAeH58so95URqr3A1wff+ZdP+o4+484Pn5GAGj8G48u
         VdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc;
        bh=qY7Zk6FBgnWWL8wW+746HAt4xhP37vyR83D2cGbkxKY=;
        b=eXxVueZwsx5kYkuTiTJVrwcv8QLGc8LKwBVfPOhVPMx9MLQtJPOhx7ny9nm0yHUS/f
         i2375nyD+FhOyybuQqlv8fG+S8xFMrBXCN/b5OjFgAmeGwrtVz+xx6q/k09t7HbEyOoF
         V4DOj9BC8g8IfI2rCuJrlaJyYW+ua75LnVjFOjmiZMlUeLA/jsDWBeuOzg5bMEtlIPwN
         AC6iWRzlstcHMAeDG++OSsJ5ZAVgKrQksvrMzQ/N4mNGcyT5fy4uUuTma6ix7xRfHs3A
         OKbsuD55vs13c4IvcFD0RCzC85wJ26byjCLBCrSCNQsflH1RKdjvBW5bU6LqzcERxnQo
         52Kw==
X-Gm-Message-State: ACgBeo0FmlUwlMStdeM0Uy3U51MehdF3k54IB65F0lir416EYqhXitFk
        nEB9GE7zvkQcA0XFWexeX3/qYyfO30E=
X-Google-Smtp-Source: AA6agR6ERiwD/ZG4IUDyVM6me+uKTr+1sL4w7n4g4PTKYW5RJu8bxnhOvvWI9FJHOY2ZjRChM2hgDA==
X-Received: by 2002:a63:210f:0:b0:41c:650c:aea4 with SMTP id h15-20020a63210f000000b0041c650caea4mr583543pgh.267.1661375637848;
        Wed, 24 Aug 2022 14:13:57 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79f98000000b0053627e0e860sm10782978pfr.27.2022.08.24.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:13:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] promisor-remote: fix xcalloc() argument order
References: <20220822213408.662482-1-szeder.dev@gmail.com>
        <20220823095733.58685-1-szeder.dev@gmail.com>
        <xmqqwnax8wgy.fsf@gitster.g> <20220824173307.GF1735@szeder.dev>
Date:   Wed, 24 Aug 2022 14:13:57 -0700
In-Reply-To: <20220824173307.GF1735@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 24 Aug 2022 19:33:07 +0200")
Message-ID: <xmqqbks95oq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Wed, Aug 24, 2022 at 08:58:21AM -0700, Junio C Hamano wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>> 
>> > Patch generated with:
>> >
>> >   make SPATCH_FLAGS=--recursive-includes contrib/coccinelle/xcalloc.cocci.patch
>> >
>> > Our default SPATCH_FLAGS ('--all-includes') doesn't catch this
>> > transformation by default, unless used in combination with a large-ish
>> > SPATCH_BATCH_SIZE which happens to put 'promisor-remote.c' with a file
>> > that includes 'repository.h' directly in the same batch.
>> 
>> Our default SPATCH_FLAGS is actually
>> 
>>     SPATCH_FLAGS = --all-includes --patch .
>> 
>> and I am wondering how "--patch ." part (or droppage thereof due to
>> overriding it from the command line) affects the outcome.
>
> '--patch .' is not part of SPATCH_FLAGS anymore, and for a good
> reason, see the recent 7b63ea5750 (Makefile: remove mandatory "spatch"
> arguments from SPATCH_FLAGS, 2022-07-05).

Ahh, that makes my life a bit more cumbersome, as I was looking at
how we did things on the 'maint' branch.

Thanks, mystery solved.
