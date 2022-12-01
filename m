Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE3C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 15:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLAPv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 10:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiLAPvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 10:51:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB2A6CD4
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 07:51:52 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id s14so1571126qvo.11
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80wpZBMpLUNk08rtp+0LFobKB3gEdHuqJzH5Ffaju/g=;
        b=SimAByW0PICpm10jBIEZBUTA0ePmlAyaV0/Sm7QilEqhqEgHglte4A9B3YeguCq9Cd
         srVfawjYlVJ77V8naEHrmn2AuZfu464q6IAnEFWtt2lH/q/fcFZbsr1ZhPx8WXXd8CRB
         aBBAPuXg662rglLeLOumPIjB+GChjQgjgunPJGNepJLwxqEyi1lJjyxwpcH6KiW45sY1
         /XVoPCr/lETKbWY6/sYjcogi3anx8jihfWfzpSr2bS83j+4EzytkZnXo0nOtvdEEcyiw
         W0SGWUtQtm++5yO49xfq32c35sfOskS5qy6kZH+mpbE6+4XcNUI+vneWGVrftybc528E
         X7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80wpZBMpLUNk08rtp+0LFobKB3gEdHuqJzH5Ffaju/g=;
        b=TFAmqWYhJRHXM/XqcfLC82slgokm0+eYq97E4Kg9tvMls/u6CqCrefuEQGqpuLZ8hn
         mO7yXxDQgEjlIXoRcnT+zs+oV8uyGkufDpIK4Z/mheKNDici2PYxXWURo6RoBpBQQi0q
         AYSnue36t+6EfuI32Wm2ANTkTiNRuwtWZcnPv04dYqnwTITw7eYaLRwVDMrL8jRGOaEu
         wqFECPs134aJwVs9Jv6IGofyuAx5rKqJP9nHaZkxQWqyGY5mlBi5DbEeKUfRJ2Hb+AXH
         OYu8xXDgf9OuoTE9LgQ8/aHomqko9W8w0/mc+G1HbeZUtkzMswmu7JBOM3gQKu/WGOc6
         LuXA==
X-Gm-Message-State: ANoB5pn3XtstqNNLpNmBJ2CKVmZ/YLcpUNBTFz2VEv5Zts9qxiCHawWR
        yUTLeSA7ytLD63WfRkvRlwytj3qmOcAE9lg79sM=
X-Google-Smtp-Source: AA0mqf67CF8S5E53yKXpjVL8hjeHOYp17/flBQq3QSiKp3vmFa6FOuR4rpLy1zi1sJT1Z+RixZNeAZuzc/NoWw8nV9M=
X-Received: by 2002:a0c:e386:0:b0:4c7:728:38e with SMTP id a6-20020a0ce386000000b004c70728038emr15538754qvl.33.1669909912093;
 Thu, 01 Dec 2022 07:51:52 -0800 (PST)
MIME-Version: 1.0
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
 <221129.867czejabi.gmgdl@evledraar.gmail.com> <xmqqlenu2dxx.fsf@gitster.g>
 <Y4ZOHwwgtztwhbhr@coredump.intra.peff.net> <Y4ZVXWNHO25IFYQL@coredump.intra.peff.net>
 <CACSwcnRDmiiJU8hL+ON6c+b4Q8UtLVbtku_rHSD+c+BwcNEX+Q@mail.gmail.com> <4dac768f-1104-a565-db4c-8a1b7eb2870d@dunelm.org.uk>
In-Reply-To: <4dac768f-1104-a565-db4c-8a1b7eb2870d@dunelm.org.uk>
From:   Ping Yin <pkufranky@gmail.com>
Date:   Thu, 1 Dec 2022 23:51:40 +0800
Message-ID: <CACSwcnTBKHO249HMhps_M629hJiAftQr0BbS50DczMThX9DDHw@mail.gmail.com>
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
To:     phillip.wood@dunelm.org.uk
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        mailinggit list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping Yin

On Thu, Dec 1, 2022 at 10:51 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Ping
>
> On 01/12/2022 07:33, Ping Yin wrote:
>
> git config --global diff.wordregex "[[:alnum:]_]+|[^[:space:]]|$(printf
> '[\xc0-\xff][\x80-\xbf]+')"
>
> should work. The downside is that you end up with a .gitconfig that is
> not valid utf-8. Perhaps someone else has a clever idea to get around that.

Wow, it works. Thanks very much.
