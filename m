Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC78C433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 16:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbiE1QnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiE1Qm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 12:42:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4B15727
        for <git@vger.kernel.org>; Sat, 28 May 2022 09:42:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b200so7898681qkc.7
        for <git@vger.kernel.org>; Sat, 28 May 2022 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5laYPyyxo3PJEAyAnVu5nOKc/bB5lK+jvAvTWU6zis=;
        b=i47yrvPQL4X++qE9vpOdpGEJSN7lvXU2thHEQSXvgFraEeCjn9cBj0kOoU/9U1G1ed
         qhu3ChMmJuhIHlCzwFgx3V6mAijdzssqdobOLm4dYaaOHymAltgre9SbHwdYoGUH4Zxs
         09W7M5VJ/u0bk5YZBiOfaD/zsNv4FO9KoMKExXKMz88ZY4w84mmuz2wco6+pGUJd82M6
         fEZ+rgjRvhCwNXNgwITPbLUYBWxMCJxA274IUO4c5iXTh3isbtvHmSHwzQHEdP0EtQvZ
         1GA4zjhlRH1gfvXi9RbN/UErxCgFb8NAX5Zb7Xv/QPl3q5JN2QIsxEfidZu9CLKHnPMB
         eq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5laYPyyxo3PJEAyAnVu5nOKc/bB5lK+jvAvTWU6zis=;
        b=BDhW17dcawfUNYlr9ex7w2IMsay3sHL6mQpfa+Lpt3WhOCZd03btjuH4cevvrj9vJp
         CUl+HTXNg73m0iyuUNRWm8gnHsTjAHfhG/jdCcfGg457xu+td//Twqe377O3ImPmFKKF
         L9qlbTCuK/UOnGP0zdEhX2tM0pcEitNs3vVmr51sCV/1eDCFGEuhePRG0tOTfM5h8xjQ
         WTYZMTrz/7bj92ou6LPYeWsNNwBElk+svS737yuoFS7Ga97D3rH2LHI9OALvea2WXrga
         9pRjuAZP5vt1obCer4mp2BnO4YlVEIxiqSk7rh8wBsMIBuQW+0gH/aHr+kihMDHjOYqu
         ql1g==
X-Gm-Message-State: AOAM532OHIBHslJcd4vsemp9WsIiNLCI8zeFwEMHjSkQzJDZusoF7dwm
        tKr/5o+9GaElfOTmSGMh35Dz/XKbt7pNgg==
X-Google-Smtp-Source: ABdhPJxXdZk/WIPrkfEROfq3YaTphkvZIMvEajOWwumiXgChlDROaNqFKSerK3slHsZP/FRI1dxwYw==
X-Received: by 2002:a37:2d44:0:b0:6a3:2bf1:a6b3 with SMTP id t65-20020a372d44000000b006a32bf1a6b3mr31012918qkh.293.1653756176661;
        Sat, 28 May 2022 09:42:56 -0700 (PDT)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id v11-20020a05622a014b00b002f918680d80sm4648646qtw.78.2022.05.28.09.42.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2022 09:42:56 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] hook: provide GIT_HOOK for all hooks
Date:   Sat, 28 May 2022 12:42:55 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <4B161C12-4D12-4403-9C92-1A969A859E8F@gmail.com>
In-Reply-To: <220528.86bkvh3b3q.gmgdl@evledraar.gmail.com>
References: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com>
 <220528.86bkvh3b3q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 28 May 2022, at 11:53, Ævar Arnfjörð Bjarmason wrote:

> On Fri, May 27 2022, John Cai via GitGitGadget wrote:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> In order to allow users to use one executable for multiple hooks,
>> provide a GIT_HOOK variable that is set to the hook event that triggered
>> it.
>
> You can use one executable for multiple hooks already, I've written such
> dispatchers that just look at the argv of the process.
>
> What we will need something like this for is for the config-based hooks,
> and I think it makes sense to have a facility that's portable across
> both methods of hook invocations.

Ah yes, thanks for pointing this out. I will re-roll the commit message as we
as clarity the documentation.

>
> I really don't mind this change, and I think it's a good one to
> make.
>
> But the commit message & documentation here really should be updated to
> reflect that this is currently superfluous to inspecting argv in the
> hook process, and that we're providing this anyway for XYZ reason.
