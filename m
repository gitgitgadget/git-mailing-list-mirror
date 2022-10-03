Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3BC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 18:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJCSHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 14:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJCSHo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 14:07:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1CAB59
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 11:07:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g130so10283324pfb.8
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0UySFtTcPnPBNYJOTSzeedmy9AVAp2k06lzj1DDfdg=;
        b=FogFruuoHXc6jl5nQoHqWSBOpEBgXywhkFZsMNpKizAlL3IF0TTLXgcIo0Vs0gM1jt
         VwAH35dwxyvrudU5VdADmHjXM3BGu+VzuC/tum1CO/pGuHEqQ3am3K10wu9oqu+gs6nC
         lcLzzWk+dRMukfT+nIp5bVa29vrNzIssWFWwpR6/HrVoaKhD2IEgnWRhbHYiqj2Bvy5p
         dVcQR6aklc34MAT3ttaPrlyl1YEOBA30srqVqYzVOU75biKtb+jEbXoN4tcXoH10XKv9
         zgfz/8T4fBpPL5rxjMKhtbRUr6Yf3vWhsIDkZxnadZivEZIjEiFWLVB9KTgsAmZLTNNA
         +vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0UySFtTcPnPBNYJOTSzeedmy9AVAp2k06lzj1DDfdg=;
        b=S42AO8+jfNGRHWffe4ruWQ0aE3Agwv58HoCdafYzANqoBSghvxsd+W4VERYxxebpEV
         fqrFTswCQjkAoM3l0ac4TK8F06sCiroF2v4xpmO9+GzB1UAV1yY1Kfb9o3XaTHxdLjdw
         frCpnOirc4e51kpHe4yv/TsAzFTglfYe/9xAntCmnO/9HdZ5yH9iZVA8FmKpVKln/YiW
         fZ4G9uqIKMmmBnqSUpF2C/eQikt0Iad91AIMb6gI4BEQTgH6yNGJuFSA+dZp4tvxI1kq
         b1isU1SZQ0kvem9pMvIrZ0U4MTCG1Y9moCkQqRTfJtYyafkC8W20BNKzIj/h3KYyH+2N
         a7ng==
X-Gm-Message-State: ACrzQf292/tTahqKzhZbm6wtmm95fe47F+ZCvScmHDPm7k4Twn8PLjgD
        tvrootEXzUlIPS+xM+wfTvI=
X-Google-Smtp-Source: AMsMyM4QH4Cyfl+093i6uUpnth/VMC9RdVD28Uq4e0Nf6M9PQWzc5tJLWJxXWNjORwl0JB2Cv3F1Iw==
X-Received: by 2002:a63:1e47:0:b0:43c:261f:f773 with SMTP id p7-20020a631e47000000b0043c261ff773mr20111340pgm.1.1664820461729;
        Mon, 03 Oct 2022 11:07:41 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a28-20020aa7971c000000b00560cdb3784bsm3698086pfg.60.2022.10.03.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:07:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Michael V. Scovetta" <michael.scovetta@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH] sequencer: detect author name errors in
 read_author_script()
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
        <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
        <YzsdRuD2CdJFdNVG@coredump.intra.peff.net>
Date:   Mon, 03 Oct 2022 11:07:38 -0700
In-Reply-To: <YzsdRuD2CdJFdNVG@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 3 Oct 2022 13:35:02 -0400")
Message-ID: <xmqq35c4u6fp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

Jeff King <peff@peff.net> writes:

> On Mon, Oct 03, 2022 at 04:45:06AM -0400, Jeff King wrote:
>
>> > I haven't been able to actually trigger the bug, but strongly suspect
>> > I'm just not familiar enough with how rebasing works under the covers.
>> 
>> It's a little tricky, because we avoid writing and reading the
>> author-script file unless necessary. An easy way to need it is to break
>> with a conflict (which writes it), and then resume with "git rebase
>> --continue" (which reads it back while committing).
>> 
>> Here's a patch to fix it. Thanks for your report!
>
> And here's a v2 based on the feedback received. The one-liner fix is the
> same, but it tries to be a little less clever when constructing the
> tests and has 200% more typo fixes in the commit message. Thanks Phillip
> and Ævar for review.

The create-conflict & try-resolve pair does make it easier to see
what goes on in these tests.

Will queue.

Thanks.  
