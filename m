Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8904DC77B73
	for <git@archiver.kernel.org>; Sat,  6 May 2023 11:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjEFLyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEFLyp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 07:54:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443C54C19
        for <git@vger.kernel.org>; Sat,  6 May 2023 04:54:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115eef620so24951573b3a.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683374084; x=1685966084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAG5JDSLOwb4IMR1Xoz4qSftJphUOMYae5235jMOncM=;
        b=NG/n0TJ9PPB7vXDgNJlJcwVE2lptmp1m2ML+t1t+VsCmEXqLFJF9Isgupnz05SEvY/
         ASA+12HsbSrPqvAor7n4Cm4jYLS+jIn1zsAIYBfcMxDyxO6d5/FFimX0d7YGtnube0qx
         OTbdDQpGVMtqUYrMpX4qQTG9uGUQIcoU6nYRXRM6s8O/ScTX+NNZUYzIa85+BlLF7cmb
         a1ePqTGAAfl2Nyq7isW6Zy7x05raSxS3hG8D/wVd8coAUuvKU/Sw6cPTUG3s2xM+ppF4
         YyoBxZV3oaAVTYnWZ27Kn+onKB+Szo6pkHRt07Yzhud9UqMPIHLlFXssGmXKkM+fF0aY
         Mo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683374084; x=1685966084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAG5JDSLOwb4IMR1Xoz4qSftJphUOMYae5235jMOncM=;
        b=U+5Vodp/Gla6XKjSI5mQlgQg959npn22/3zA10cWGmLD/7u/hXLqvH9o8yUq2ISmcx
         c+/CSqVeq3gk2XLABrePnozYjYNkEdZ/gs1VXDJclyoJQwQHQLfWzYYSLlPSkQG/qSJk
         1MjjA3M46THmzZ/vWpcQwqd/LoCJIFoDnmP7K9x+pxRyvEginFV0tW1PHJSbwcxoyMB0
         /zNEIoifq6X81QcZeqrLpuuOydqUelXGOnHe8jdTiRALPCqyBeAz6NcQmvcymiKzEqcT
         Cd4nNBEhvWjZGLDducgyOlEc7giafWxGh1D2AXC4j9Zdx8At3IfkLxo6/Ze8ZNfsEVQD
         EwRw==
X-Gm-Message-State: AC+VfDyrzGURsVPSxu/DzkbRFz+HAOc+S0AHXY577V3GerptmGVzOvHR
        fumBsJhtfZtvTze+kemSnZRoy2maFtavLJwwzfw=
X-Google-Smtp-Source: ACHHUZ6MDNvI8amAOuXa9mSgu0MX8Alq/B7MtS1BjuUbbtJCq7X/DOijTJrORG9E28jP7ePpalpbUA==
X-Received: by 2002:a17:902:f80a:b0:1a2:749:5f1a with SMTP id ix10-20020a170902f80a00b001a207495f1amr9763888plb.26.1683374083579;
        Sat, 06 May 2023 04:54:43 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902bc4100b001aadd0d7364sm3458563plz.83.2023.05.06.04.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 04:54:43 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     erik@cervined.in
Cc:     git@vger.kernel.org, shafiq.jetha@benevity.com
Subject: Re: Suggestion to provide a way for screenshots to be added to commit messages
Date:   Sat,  6 May 2023 19:54:37 +0800
Message-ID: <20230506115437.61969-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.446.gf331623a.dirty
In-Reply-To: <CA+JQ7M-MHvtLf=p5+JWEG6ec4r-X0JzFxV0eVhrKNWv8jNLX1g@mail.gmail.com>
References: <CA+JQ7M-MHvtLf=p5+JWEG6ec4r-X0JzFxV0eVhrKNWv8jNLX1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

>Maybe something similar to what git notes does 🤔
>Then again, maybe it's easier to just do this differently.
>Like keeping track of this using a markdown wiki in the repository and
>just storing the images as a part of the project instead

git notes subcommand can save binary file in note message.
We can find some clues in git-notes.txt and t3304-notes-man.sh.
By default, the file specified by `-F` will do stripspace for
the whole file content, for example, if the binary file contains
consecutive newlines it will be compressed into only one, in
another word, the binary file which recover from this like note
message will become corrupt, so I made patch[1] to support an option
`--[no-]stripspace` will solve this.

I'm not sure the scenario of using git note to save the binary is
suitable, but the above context may give some ideas, maybe.

Thanks.

[1] https://public-inbox.org/git/20063beab1893535f03e13b75058d501ed9f2faa.1682671758.git.dyroneteng@gmail.com/
