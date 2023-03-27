Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50964C76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 16:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjC0QIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjC0QI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 12:08:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7783C2D
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:08:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d13so8133007pjh.0
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679933308;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrzNH80eRdSMVm8oN0+EskunhjPaPSWjnT+UsRfjafs=;
        b=PiKRFNsulwNpgFXntse3TjSaOGOFfR8GbRF3ivVor9WZ14/YotLRQJQn32drE6RweX
         1eZQyOALS9s1uA3HM/p0FpWnZVx4WcX03ivTw2JtDl0jXSuGZV/xCrheu46z1bv70+bI
         Qxqa58R1ZmZVPhdeNSQ5muU5Oi58Ll2ByP6cPbUIfSs9/cjcaRdEDZh6NSksAGFz2+WA
         4wOBDQXl1Yc8CqMifEgw0yYA24P10xY+9IrXzVGGpwgM0+9jDGobMbqFQ+iBV/A4ZUDE
         IBIiQ8/xJ5xKGheFA+OURsXbRs/cdUuWKgVc6YASZ7bxtZqPMygLX1KdccOzbM+51reX
         kmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933308;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FrzNH80eRdSMVm8oN0+EskunhjPaPSWjnT+UsRfjafs=;
        b=14fDbJJpf3rUmCdYg4lt8IgZLVGUUa5VAkta7XxNqOZEFHiJfDrJ6xo6uViaFTCHcA
         KoC/Wg+phPlA1W70ziwwL5F++8/J0aQlEQs2MGOBxpkCe7MYbZUQLKfAyveMTycgOYF0
         /OvciME76J3yEwFTRKJdd/O5djlvVFRv6Qp06HyJAUA9BqaF1we/zJEjqG5RR8gRYwG8
         JYqdRUbIPULdy6BKlYw2kIibEp4hAvrdDK8Sh6atperW9u4QqC11WiTSf1LRrm7I8ETU
         GbBln6dycogvfGWeoiqIAlMBmRce6SKgwx2iEiG35QidGC/14YlDGKfAdyNNruz8FjBB
         LE2A==
X-Gm-Message-State: AAQBX9exWvEpmTYzvJ9W4U7qZ7QbrRyACiL+KNxLzztguXIISm/ikb8+
        aa+6awiHK/2L16DFgJ82D1k=
X-Google-Smtp-Source: AKy350akwlmi4i09BenYppocSewP4seOmesX096NDGmMV7zGdhcSjAAUKi4TOskuTqtkN14tGv3Q4w==
X-Received: by 2002:a17:90b:38c8:b0:23f:81ac:80b8 with SMTP id nn8-20020a17090b38c800b0023f81ac80b8mr13526376pjb.40.1679933307815;
        Mon, 27 Mar 2023 09:08:27 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a398400b002405d3bbe42sm4490953pjb.0.2023.03.27.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:08:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: handle differences between Windows named
 pipe functions
References: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
        <e48e768a-19f3-386a-9bda-8fa8681d1a6c@gmx.de>
        <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
Date:   Mon, 27 Mar 2023 09:08:27 -0700
In-Reply-To: <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 27 Mar 2023 11:02:16 -0400")
Message-ID: <xmqqtty6ch38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>> This is a rather large deviation from the other platforms, and it
>> has an
>> unwanted side effect: Git for Windows' installer currently enumerates the
> ...
> Agreed. Please use forward slashes.

Thanks, both.

I'll mark the topic to be expecting a reroll, then.


