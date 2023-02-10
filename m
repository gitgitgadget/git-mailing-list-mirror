Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE6C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 17:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjBJRbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBJRbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 12:31:09 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C217359C
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:31:06 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n3so4171809pgr.9
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=em1/LMK/xwyQS+AwqjrHRoaM5iI/rLs2FzrjULRDAc0=;
        b=J9cqu5pfef53xFhhc/WWtGha/VvYiUKyw3vOFHGcjcwh8jc0OdxIrZxl4+GmHAs+GO
         VurjyC5Z0WMTVcFvvh5CBnSknlsOyV+sWYpVzrKRmLoydnhqMZmQCZDy9/F1VUwl4Kh0
         8hsdgOwkWXrTsWNL9Qv6B5igp09lsfqgxdanOiQFpVrZ4KPQGR9JRUdWzRhd2ip2BPxg
         PfOiu7ICuUGK5uETFImOBsOBFwyL4aWNoT30K5MRkY+HLJ3qTF+7LDBUzpTymbrStXWI
         VofYKnaT+hEU66YrS1Nk9ywI2QunKX0OkEqRA/SfbKQznRFU3oJPbVx59m8A94um843l
         BSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=em1/LMK/xwyQS+AwqjrHRoaM5iI/rLs2FzrjULRDAc0=;
        b=WloELyKGhTKGQ2sy+v3p3r9/tVacJ8QtiWAMz7z7WDKinEg+wwrX+FSAZgX/cL00Is
         MVhok7qDNMfStVHSxEyPwR6+ZgDWJKNWIhTpPNZ25vgEV3jzpxHoUFytD+qpZFDhcxGy
         BTeQfEwIBY2M+FUM5jaZJxgmxoxXyKHuubSBQToBlDbY6vN3MQx1dqlKAZ2EFVm8vF+B
         2H3BnjdcJghIdAXvo2tC8w6jN/hvySbdiAs71y3O3NqyO9gRgVDTC9Nj/++PIAldBxOo
         g5gkOF+upUV1IWpXCTekmEsAGWEdVgpbgVnDon4Myc6BTYQuCwNmPSADuFSEscWu5WgR
         lELQ==
X-Gm-Message-State: AO0yUKV+/LIHkbxMvIIrOAPxZPHJZ2k7bdLwmpZAMlT1qtpzLT5yEgir
        +hGcjkluWp2Kg6TVT4kVa2wuK5kcQSI=
X-Google-Smtp-Source: AK7set+coBrxuYal1Hop63jRqkwb3gZUu45+v7PIYpmsjBTR/kUFfCY/Qt86frenrr9lcCvTEyWyEw==
X-Received: by 2002:a62:164b:0:b0:5a8:5247:2593 with SMTP id 72-20020a62164b000000b005a852472593mr6023462pfw.28.1676050266114;
        Fri, 10 Feb 2023 09:31:06 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id m6-20020aa78a06000000b005772d55df03sm3553801pfa.35.2023.02.10.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:31:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] test: make SYMLINKS prerequisite more robust
References: <xmqqwn4sq73f.fsf@gitster.g>
        <230209.86k00rzqsz.gmgdl@evledraar.gmail.com>
        <xmqqbkm3ppn8.fsf@gitster.g>
Date:   Fri, 10 Feb 2023 09:31:05 -0800
In-Reply-To: <xmqqbkm3ppn8.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        08 Feb 2023 17:56:59 -0800")
Message-ID: <xmqqk00pjuli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> I wonder if something like this is in order?
>>
>> I don't have much to contribute on that front, but this is really
>> missing some "why", this worked before, why is it failing now? Do we
>> have any idea.
>
> Your guess is as good as mine.  I do not do Windows.

This morning, I notice that those CI jobs I ran last night that
failed with "whoa, windows tests are somehow reporting that symlinks
are available but not really" issue the patch in this thread were
attempting to address has passed even for branches like 'master' and
'next' that do not yet have it, and it seems to be because you
re-run these failed jobs.

Whatever magic you used to fix these failing tests, thanks.

Do you have an insight on why and how these were failing?  The patch
in this thread was a band-aid without knowing why all of a sudden
"ln -s x y && test -h y" started passing (while compat/mingw.c still
says readlink() is not supported).  If we know that such a breakage
is not expected, we can drop this workaroun, which would be great.

Thanks.

