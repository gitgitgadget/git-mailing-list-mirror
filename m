Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38764C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiKVRaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKVR37 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:29:59 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8226F76158
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:29:58 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c15so18118116ybf.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q29f3VzoEXvnS5H8EYT6SbhzEWQ9DO7xTj3UbIAZNWs=;
        b=mN0LX2Q5uce+F/oaCQcKW+0czjH64j7bBhAaehu1bxt79Q3CE/PrktrN6Kxkpx8SLQ
         VGietg2++bz6Rum4JNjiZkEZ4ndgmaHobue9rOUsX9Q3hOloqAsk7khGpeNbB1S1ys1z
         jVLaUGNJB4XPZYKfSn9RU+oE0kOSesfA8cYB+I5bNBfvUgR+EL278tLlRtctYgAwOSRY
         4eXVLHR3I/i2VoiYy8U+44W5CvLa7oQ315qZDR7meYWujPY+CeqEHBjIbvf7h1TQiqt1
         VNQbK/SGSFf14HHll+5eCtxH81R0H5x/L5TJzPdS0PC1Z03drCjoxUqZRcXEu6x9hmzy
         LCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q29f3VzoEXvnS5H8EYT6SbhzEWQ9DO7xTj3UbIAZNWs=;
        b=Xa/1hfh5NQ6AttPOjKo43aXA1oonlyth5nMZMJ+Hxb7Yy3qdyxSLVOQm5MrkGnLo7M
         RtcNCnJ02IxDfYChF1Ai/1rnDA1uKgNjArwTQSIxl31EB3OQW5T0nZRUI4239rjs+s54
         w+qpiOZfUsaZZ8ZsqsmZqNpbFyBZ4XSpanpaUZAFvg6NwW6bNg3CV91VkMp8xGZ7ZCsV
         fjH0ZxM/c9J98xaJqmovlYb8kviGj+o2t7LnVM/wxyt9WajpjIouk9UeYNN61Oqj9nWR
         Mnr4Bu0mIqVqrNbpFTgWOmfwQhraE8XXFDUZlbE9S9C8oIDE3hzzeKs/2zb8uxVXT84h
         DMeQ==
X-Gm-Message-State: ANoB5pkK7ujbzdr1V/63VXyvKMZVPGeXqoFG6ZNqD0b5fowk0E9XRTTp
        APe+/i9bvHBfi0zo4H6oItR94L7ub8rGlmAMMJw=
X-Google-Smtp-Source: AA0mqf5SfoO26+PfJLIaAaCHlDv+y4Oetkt+TZ9gVrKNoqoC/JpFI5/+a7u2wMQl4qQTghLLeKE0Db0HxgO4WeB1uDE=
X-Received: by 2002:a25:d0d3:0:b0:6e6:fc12:8553 with SMTP id
 h202-20020a25d0d3000000b006e6fc128553mr5037150ybg.443.1669138197438; Tue, 22
 Nov 2022 09:29:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
 <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
 <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com>
 <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com> <CAPig+cR=kkWVuBDh2FS+869a_P_xaLj5NaCgW7q3M_utLrgSsg@mail.gmail.com>
In-Reply-To: <CAPig+cR=kkWVuBDh2FS+869a_P_xaLj5NaCgW7q3M_utLrgSsg@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Tue, 22 Nov 2022 11:29:45 -0600
Message-ID: <CANaDLWLLVqJ6_razCc1-On5dWBv5xC3QRn_Vw1M-yodCs-0XrA@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops, here is the only Gist URL I had meant to share, sorry about the
confusion, the other one was a copy-paste mistake:
https://gist.github.com/rudyrigot/b31fcb6384e829ca7586818758e48d0b

But the suggestions you just gave me are wonderfully helpful! Thanks a
lot for that, let me give those a try now...
