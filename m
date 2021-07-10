Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78DCC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 10:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894E6613D2
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 10:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhGJK07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 06:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhGJK06 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 06:26:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF614C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 03:24:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q4so12619720ljp.13
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=w12F9oPY8qpQ89e9g0N8p6Hr8DuUgBhWkdAazuNn5HM=;
        b=YkO6LySK6yFlOt7yzOFF4c+LYkgMlV6HPF6TBZEv9xEqlxX2jnzFNRTAupLHMDA1VD
         aSwLBcBMfEC5lWA8lw6csiwk0XYGzbU7yJ0sndmm0YBdS+M7WwAo3RBnJhhaJAom07UI
         QVhzaP/Q2/T6LCYmZWV9vj1YPwx55mm9njytK5EiKcaNErfirxgDXIBPCR0NvFTUvHLh
         KRTfERfQGQJ4ZY97Vr9bU5WOeHMdavIshBhIh6tFGQ9UU7gE/317IhbVf/iFLTJkP+ZF
         Iy6x6cOUpFIPbtMOmuVS9952cUliJ9QeIKiUp8mNk5ekAnRIYg3xSgYBOmTIwWJAckMQ
         pYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=w12F9oPY8qpQ89e9g0N8p6Hr8DuUgBhWkdAazuNn5HM=;
        b=m3oZveXERy2HytkERAq9ztKlousMesE2AejnR4LlO8KB24RQr/OIEmHDV1aObgyrt2
         0x27M/KhUPVATk3fyMqJO+qEpKeRm0oNHw3EryzHHWMsFHJgUr+JhXuo9VOyx5+d1Txy
         zjxonESK10WkSFbtvDCf+m2ICS0rzXmgIjkRtuKSn5tChTIrpmEirvJwawZGy1BUav52
         TYts6w9N+eG7hHvfKFVmpSM4jdoWH0HvpJXhogGVds8NHI30p4usi5lJeNSy+pOj9YSO
         KP/iCZPvwAwu5gr6ncIOnjwzYyHGrfPIaRlqAKJ3A5ZVzSyjL0RAA3XB9X0i9tIfLdT8
         4Ykg==
X-Gm-Message-State: AOAM5302c1kLTeBY57hWa39OTelg44zmYik14xSDpCbc277HvEt6ldtf
        p9hmhwEYBKIwCMIe6XQDca+58puc7Co=
X-Google-Smtp-Source: ABdhPJzweBSbZYoYXbfKF0N+KCmHeq8SPrJ4gd7zq7lYyuYRwaB5DmqPwaGN0eTGjFx3MXdR5+eEBQ==
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr17216952lja.178.1625912650900;
        Sat, 10 Jul 2021 03:24:10 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d14sm680412lfq.31.2021.07.10.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 03:24:10 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqpmw4uwh2.fsf@gitster.g>
        <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
        <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
Date:   Sat, 10 Jul 2021 13:24:09 +0300
In-Reply-To: <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de> (Martin's
        message of "Fri, 9 Jul 2021 18:51:12 +0200")
Message-ID: <87im1ieaba.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 09/07/2021 18:10, Felipe Contreras wrote:
>> Martin wrote:
>>> As for "git switch -C"
>>> This should IMHO change to (the 2nd arg, actually depends on the point
>>> "1" above)
>>>      git switch (-c|-C) <branch-name> [<base-commit>]
>>>
>>> I suggest to not call it "new-branch-name" because, it might be an
>>> existing name.
>> I think the name is all wrong. As Ævar pointed out --new (-n) is much
>> better. Also it doesn't make much sense to use "create" or "new" for
>> something that already exists.
>
> The n versus c issue is IMHO separate. Maybe tiny overlaps.
>
> I see it mostly in the light of -c should be for "copy".
>
> On "git checkout" it is "-b" for branch. That works, if you perceive
> "branch" as a verb. "The action of branching creates a new branch".
>
> If needs must, that would work as "git switch -b" to.
>
> Actually, "new" or "create" would make sense in "git branch". But in
> git switch, they actually raise the question "create what?" / "new
> what?".

I believe that's because "git switch" tries to do too much. "git switch"
should rather switch between existing branches, and do nothing else. As
I said once in this discussion already: trouble writing good
documentation is often indication of some flaws in the design.

Creating (a branch) is fundamentally different operation than switching
to (a branch), and that's why the former doesn't fit into "git switch".

Thanks,
-- 
Sergey Organov
