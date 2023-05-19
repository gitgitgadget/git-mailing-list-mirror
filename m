Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E3EC77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 17:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjESRwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 13:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjESRwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 13:52:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF1BD1
        for <git@vger.kernel.org>; Fri, 19 May 2023 10:52:08 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f38a2d9b3dso7626721cf.0
        for <git@vger.kernel.org>; Fri, 19 May 2023 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684518728; x=1687110728;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3zcaJs7+Jo1UAySQjnMNluhs3bImpQDHgrCyB8cjUU=;
        b=WgTRiTymeH2CgPGfBt9fq7x1aiZM5tjVbCh0g4wu+SkD4wQ8zL4CXoxTLmoTXph8uf
         URFx1ehGMF0GdCHhTqkrXxrrHkveCQwlII+TDVq025TSn6nSF9hO8in4GY98DxzcS4eo
         aFRfc+Pw3r92C4ni9fRRd1VF7kMpb8LAhwnIdecDsOu1ZKOLzG+bWgR925GNIud4ihx1
         4dD4D+4+LAdU0eyoiT4N3w+gjJuhiinJSjEoYaYJaH6GO6QO4xKNzvqFrErU7ZbnuV2H
         81d4IKzfqTeYEdKTSXVDvCc7BDUohODYNKX/3DU6TqMxaaQWnG7ojmFhkFCeaZm4ht+G
         oWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518728; x=1687110728;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3zcaJs7+Jo1UAySQjnMNluhs3bImpQDHgrCyB8cjUU=;
        b=dF4kIYtQpw/33onJNbW8cB4K6oIslh5Gcaxx2YNh6FnB9ZN0ckyHmmdJi/h5EuMegd
         VYGO2CTPMLHi6s6aPDmvVimUwQ1Ew3Te51simXGoLRvioj4p/uLC+sEVw/hFv27pjHgq
         omYfjlxI3JBg+OaN/1sROyZ3V5pM+37WyQLIHmFlSlXVsLb/aaxolniEeGvL8Wq8+2do
         IwrRjbDdiTltlQBhvs2kyT39KglgihssfbgrRxx8EVjao7SGsPRQCHmFzv4UmtGRSkgL
         iSQi0VY9qa1K9KnkVnU5gGRsoLSP5iktMudxnhLtMBqdXYlc7r/Rl3pHYiLr4bKvD9Zy
         n3nQ==
X-Gm-Message-State: AC+VfDyJHErmoCaSPresCLms0Cs9Qs4YZamoudx+Wqw3253wjOyJl/5S
        kmvl7ManNTdyG6K1ft7+WVI=
X-Google-Smtp-Source: ACHHUZ47JeJ5gThOJG3APWIdi4BiS1wfLmiHYj4lbr/w/kBbGTw8Uom/TvvxrYJ3TQBOQLFqvotcNg==
X-Received: by 2002:a05:622a:18a4:b0:3f5:315f:5c1d with SMTP id v36-20020a05622a18a400b003f5315f5c1dmr5287216qtc.4.1684518727749;
        Fri, 19 May 2023 10:52:07 -0700 (PDT)
Received: from [192.168.1.176] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id c22-20020a05620a135600b00758ae50d7ebsm1257103qkl.123.2023.05.19.10.52.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 May 2023 10:52:07 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 03/20] t3210-pack-refs: modernize test format
Date:   Fri, 19 May 2023 13:52:06 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <1FB4B833-C883-4AC8-999E-FF3F56D621FE@gmail.com>
In-Reply-To: <xmqqlehkqmg6.fsf@gitster.g>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
 <4fe5e5cf9e068d20bbec3580df3030cd74ca4122.1684440205.git.gitgitgadget@gmail.com>
 <xmqqlehkqmg6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19 May 2023, at 13:07, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +test_expect_success A'see if up-to-date packed refs are preserved' '
>
> Huh?

oops. not sure what happeend there.

>
>> +	git branch q &&
>> +	git pack-refs --all --prune &&
>> +	git update-ref refs/heads/q refs/heads/q &&
>> +	! test -f .git/refs/heads/q
>> +'
