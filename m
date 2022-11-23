Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92046C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 00:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiKWAzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKWAzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 19:55:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9919C68BA
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:55:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j12so15250903plj.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSXy9NSCahXiwt7l7WjQHik9lLIye+R92mYQq6AmE08=;
        b=hEBP7WdzhxDaZnyZ1TokHNwzVGjpy74warrNAJhsL5A1gR8Q2XkbK2+25ovoe+P46+
         XdAikRgxdRZIcVsop4djrk0WH0Igu2197LVpFcLo64NURZMLAj1BQxaXz7mbw24e/e+g
         hQ4FR57L+pqLGJadL+xE5bY7NsKxorsiC/dwhH3JiPdQTweoMZmaIUe/yMY99Yi9sKIr
         cv14mYRdoNmyli3E9pm4h2ZAT0hREEaAlk5xsTv/k1hsrLNaw3WnwTXYCknLewvPNLZH
         NnP/CJBJawBtnfV095dXRy53h8uYXX8myduzdPFHu40haaMOveQdAXMWKYEDLTtJHdyu
         g/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSXy9NSCahXiwt7l7WjQHik9lLIye+R92mYQq6AmE08=;
        b=FKMvL1Q+Ey87Ah00/SdQRBQTpk10Y8tm7wVAt455iCTdtNQpEf7Jdnc0TVg+QVE8kb
         2F2Y572qS3eB7+SQwm0kvOJPLWQMgVo+3FomT5lQU+FVxnHqUv/kcvFVQ8Ubc8kUZgUQ
         lkFkwAhA81HjJGPp1M95gaF5Nn5CZfEo7qVsTKCTQLxW1+hJNxx2TFMHGPY28LXplj7s
         d1wLwLizq8A0jB8KVP+LGh/ohEMS86ihNHUy6utsO5f2UZ3LOierBx+ixKTKsygkaF/+
         OGim5aoRqw3MHS/jkHvqqiAGz2AoxOGKA6rDFDlm1bu5VUu3L4ohpTRhwO2qdTKTCq/T
         e/Nw==
X-Gm-Message-State: ANoB5pl126+ohmYpsY6VmYfWmEQ3sjkE9BT6pulw2w9sTHjgvo7RN2yy
        9SAt+yR24t6b9KHp+c4dXok=
X-Google-Smtp-Source: AA0mqf6RPFCat9IrIe0Hu1i62iJ02fayXf+XqU64LudCoQXw6H7dMEYNY7AQWTW1Q4sECqNPrN6ibA==
X-Received: by 2002:a17:90a:fe13:b0:218:78e0:41d8 with SMTP id ck19-20020a17090afe1300b0021878e041d8mr27149522pjb.212.1669164908193;
        Tue, 22 Nov 2022 16:55:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090a130f00b00212daa68b7csm153048pja.44.2022.11.22.16.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:55:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t3920: don't ignore errors of more than one command
 with `|| true`
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
        <221122.86mt8iaamz.gmgdl@evledraar.gmail.com>
        <271dd9e6-3575-a46f-4c92-fa202aaf95d7@kdbg.org>
        <221123.86ilj6a8ux.gmgdl@evledraar.gmail.com>
Date:   Wed, 23 Nov 2022 09:55:07 +0900
In-Reply-To: <221123.86ilj6a8ux.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 22 Nov 2022 23:57:20 +0100")
Message-ID: <xmqq1qpupk0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> We have that "sed -n -e" in somewhat wide use:
>
> 	$ git grep 'sed (-n -e|-ne).*/p.*&&' | wc -l
> 	54
>
> The only existing occurance of this "grep but ignore the exit code" I
> could find was:
>
> 	t/t9001-send-email.sh:  { grep '^X-Mailer:' out || :; } >mailer &&
>
> For which we can also:
>
> 	-       { grep '^X-Mailer:' out || :; } >mailer &&
> 	+       sed -ne '/^X-Mailer:/p' <out >mailer &&
>
> And which I'd think would be great to have in a re-roll, i.e. "here's
> these two cases where a grep-but-dont-care-about-the-exit-code could be
> replaced by sed -ne".
>
> But if re-testing this is tedious etc. I don't mind if it goes in as-is,
> but then I'd think we could safely emulate the t9001-send-email.sh
> pattern of using ":" instead of "true"; we don't need to invoke another
> process just to ignore the exit code.

Let's leave all of the above (mostly good ideas) for "after the dust
settles" clean-up.

If sed is much slower than grep (for such a small string use case,
start-up cost of a process would dwarf everybody else), "grep || :"
might be justifiable, but other than that I do not think of a good
reason why we might favor "grep || :" offhand over "sed -ne //p".



