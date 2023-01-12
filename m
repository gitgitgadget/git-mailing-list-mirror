Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55B9C5479D
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 02:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjALCwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjALCwB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 21:52:01 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890113F86
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:52:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c9so12842892pfj.5
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu5LTMnZaQlpWbHek6y3SYKjWRpmweJGob3kwjeF0tg=;
        b=G3BlVLsOMsZIkEwNWtuaNZ+tTxVc/XeiahQSNe/2nk5ap34B3yYFkaebysgM+2f8N2
         s+812opjBJxzfm/ZsV6gwU4xr/CdiIxZvIWGdgzovSAiQZhEBZ+b9OYwphu6DNPEsdoK
         W4u6dnGVSHNFCkWTAAZ/leUMWuF/b4PLxg7sMmaQpCoUbfyF0HBi5q1CgZfCucwRAKaV
         rTBT47fjampezx0g3yAC/v2pxPUv2zc6vXLuYvosZg4k8Y4Yw9LspbIM7pP17YZnFTch
         AEoNUlvt7UQGlX0M0pjpDqORgbiPMDsGSfQcqcrDS2l7yuqhPypC+z4sVFADwpbhSqBy
         JH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu5LTMnZaQlpWbHek6y3SYKjWRpmweJGob3kwjeF0tg=;
        b=vKupXa4IoK/YFN3Gq0+ufzYyyCJfzMm88NG/he7urC2AZB5NsoU93nEGSXDTlxF2os
         MvRtjn6qkDI8XkrZtqV43KLhmP0J8Avff6qQqZ9graw9xq6swlo9bg4tOi06vFfl3xzs
         31dbGdVkfaQmei3q3QggrrObIT7fIahX1fLrKadxWhNq5r6r+dS7D9wMJdkyBb9Ppu+P
         Y1aD1f5JLjHygTni/FLB9LAV8/xjeLMPMrvlWvcJEbfsIlxSX5JnX9M4LPzvHRfHEHR1
         3hrdDTVRJo67xJ7RDxWPqvlj85g92tidjrgmJe+G1wJQ+PBdqLPKaNqZJdpI9THXsMd8
         EYNw==
X-Gm-Message-State: AFqh2kq54/YA2PQhxnO5ZAPMoZok1el7FidMEpo7CYtruGsNUg6RuVAH
        LlM4ZMFG9EKbfQuAEVQ5UiKEHEBLGL6IEw==
X-Google-Smtp-Source: AMrXdXtet8rTsx33salhmU0EOoPrHIT6M6wJMvrGcjNVBcIdXLeDBadN33ODcXJscgUSBZUzraYGwA==
X-Received: by 2002:a62:4dc7:0:b0:586:210b:2b67 with SMTP id a190-20020a624dc7000000b00586210b2b67mr16829657pfb.6.1673491920668;
        Wed, 11 Jan 2023 18:52:00 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id m2-20020a62a202000000b005869a33dd3bsm8929308pff.164.2023.01.11.18.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 18:52:00 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: What's cooking in git.git (Jan 2023, #03; Mon, 9)
Date:   Thu, 12 Jan 2023 10:51:37 +0800
Message-Id: <20230112025137.4286-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.386.g6952793f2d9.dirty
In-Reply-To: <xmqqlembu551.fsf@gitster.g>
References: <xmqqlembu551.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * tl/notes--blankline (2022-11-09) 5 commits
>  - notes.c: introduce "--no-blank-line" option
>  - notes.c: provide tips when target and append note are both empty
>  - notes.c: drop unreachable code in 'append_edit()'
>  - notes.c: cleanup for "designated init" and "char ptr init"
>  - notes.c: cleanup 'strbuf_grow' call in 'append_edit'
> 
>  'git notes append' was taught '--[no-]blank-line' to conditionally
>  add a LF between a new and existing note.
> 
>  Expecting a reroll.
>  cf. <CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com>
>  source: <cover.1667980450.git.dyroneteng@gmail.com>

Sorry for late reply, I just post a new patch on this topic.

Thanks.
