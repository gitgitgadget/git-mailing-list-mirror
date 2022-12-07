Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556F8C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLGAyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGAyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:54:12 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D41EC46
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:54:12 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a14so12088668pfa.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWLvUxITaT0PeO+0tlQ9AA1oBUujhKA/ZrcR5bXjq18=;
        b=ReXVAdfBBiUqufyfuM+FEHfy0lANLiv6iAbuZZApEXqkeuDhxvqka2yrZ4juTGIo9c
         pVP3ZtpNEjHMxz3SsSxXzPYknjaVPkS7IToebpJAoElASJei5fjd36jMjomvrrRNFpy3
         kmh4zF5wEI9MYDcFlx7zPkIj/C1ry9NkkszSCbwFEKOOGnX2OGXTDBssQIs2FaPhIptv
         QOrlQG8un8Qg1rc0UjBH/Cd0TTR6flBc6r+NP6Dg6N7GazVDJ6PJaoBotCJIkhXyH1nu
         UVDIhQU66vgvgnbX36cyJE8dEB6hwkeREmC80LXily4xNYfeLcl6LHdkLkbDuYi19sXs
         u6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fWLvUxITaT0PeO+0tlQ9AA1oBUujhKA/ZrcR5bXjq18=;
        b=c2puwCIHC8XPm3oY/gH1d07r7k80VfkaeRGRsGq/ZGNHnjXhHQAJrD88Ank59/NYkR
         YRqpEHW6MPpPYONFTOZrE2deC7B9N8cac4C4d3UDp8uTMso0cJc3yQUlFV0gjvrirrYA
         Mx3cQqqrWJCYwDC+dxd7Iuf8D43qW0Fpjv1GNUVKC4UIfrcgrHcohGMIR9HpyEaZXvJb
         ENlchgFXelP6gqH0qIa+TX+oB1/anjkih0Sv3dZbK7bXEl5m+cG1WGfd9qczsn29n1Y0
         XoX9jNF7kSx77H58h0OLPSD4rNGC/JGkPmAuMmgllOj+mVZ6XeXx+0n3fIvrq18746Ts
         SqOA==
X-Gm-Message-State: ANoB5plGeGx0ZsVu78C8fz1gZyCm0Bwk2eT2wiXhywqLrlclVGNznhOW
        FGaSFW1tvWgEhQ+PE9YRX6Q=
X-Google-Smtp-Source: AA0mqf7W1ZnKnF+cXg8fYwvLXyYwr9hgkyGh74nuajZzpKPbTcI8NdwfmZv4ignMvaVuFR4rYTBOfA==
X-Received: by 2002:a63:f850:0:b0:477:f9fa:80cb with SMTP id v16-20020a63f850000000b00477f9fa80cbmr46186829pgj.118.1670374451615;
        Tue, 06 Dec 2022 16:54:11 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b00189240585a7sm617055pld.173.2022.12.06.16.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:54:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without
 ellipsis, options
References: <20221102120853.2013-1-philipoakley@iee.email>
        <20221112143616.1429-1-philipoakley@iee.email>
        <xmqqfsedywli.fsf@gitster.g>
        <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email>
        <xmqqedtvu7py.fsf@gitster.g>
        <7a6c3d32-4494-e209-9877-e8784f0c3502@iee.email>
        <xmqq7czjecfr.fsf@gitster.g>
        <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email>
        <xmqq35a5cnhq.fsf@gitster.g>
        <093e1dca-b9d4-f1f2-0845-ad6711622cf5@iee.email>
Date:   Wed, 07 Dec 2022 09:54:10 +0900
In-Reply-To: <093e1dca-b9d4-f1f2-0845-ad6711622cf5@iee.email> (Philip Oakley's
        message of "Wed, 7 Dec 2022 00:24:34 +0000")
Message-ID: <xmqq359s824t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> and "..[3][4]", respectively.  It also is clear that Trunk
>> and Ltrunk can do "[1][2][3]" and "[2][3][4]", respectively.  We
>> truncate the given string so that we fill the alloted display
>> columns fully.
>
> While this example is clear, it's not clear what should be done if we
> have mixed width strings, e.g. with emojis, as the boundaries in random
> text will also be randomly placed.

As long as wider letters have widths that is integral of the
narrowest letters (ASCII?), "use N columns, padding with '.' if
needed" has a reasonable solution, no?  "[1]A[2]" occupies 2+1+2
columns, so trunc that is given only 3 (or 4) columns can drop the
last "[2]" and fit "[1]A" in the given columns with padding.

> I'll at least work on the doc clarification regarding the column width,
> column position and wide char (2-col) issue, and hopefully a few failing
> tests for the combing code point and the wide char fitment issue.

Thanks, that would give us a very good starting point.
