Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2E0C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 07:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbjD1HlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbjD1Hkr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 03:40:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE259D4
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 00:40:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso10599018b3a.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682667619; x=1685259619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dNGfqoE8B78kocTO2A15QZs27mJkRpvC18DyZdhRzk=;
        b=V2crwBF+j1iYTaPMLhzXajy2gwxPugzYoTEuIx/K4sbrE++fuOBpLKAzyvGHmxUB6t
         XN5GqbdGR9v7Q+9Fb9ZTpcsjB7wm0t4GyaVItSiOKG23m/M8Qhxa1VicMwW3SRAadql2
         /GAyhaFJTamcq7ZKuiqlOxGt3NoS3m0pFb1lv6b+L9no1SuZY7K6QDPQLemdtjIiGgjK
         6wtGDy8cv/empsYpIxbszG2a9Owdjt+F7SlKyVRPc77EloHzHdaP8uvLiQUKUZXcrboI
         kQ473xfQZOrsY+JB7N9+355J5vyssaewJ9WI/CU+asL2pkvvJqJialn1LIqzl9yuuJo5
         j+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667619; x=1685259619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dNGfqoE8B78kocTO2A15QZs27mJkRpvC18DyZdhRzk=;
        b=caifx8ejjiEz7+F3VX1Av8Dt+77inn87GO/D0zRcXdEPdY/LxhFDzfIAfIEXvk+uNK
         CPOy17+NMOvUCVzGtvc/lTiCsuzB+UycxanPa6uO6r5jPAXpKE9QOKtRtUhRc/sVLJv4
         mubnTUBAoiyK7ERZolKspE9szSdV/R86fPUb/N2liLKO5S/CDX9TcCwKEuOzqco+8RZ9
         CdGTfqYtB0Icg4J7pGSDXKHZiGXn3mnmvR6B34P2W6KRn+M/6VGUPCS/v03EimZ5he0A
         8smhlQ0FTMXjr5v65jo3SxjU1gd39rxK94W9NCmrId/adkepB9nCRmy1BJoZM8A4Gwfj
         Pm9A==
X-Gm-Message-State: AC+VfDwYDGNkYRgvBF4QpkBL4c88RtRka0PaX32y63S4BB1sJ5wwzEx0
        VAlDqWsREuNaCGwioP1BfbU=
X-Google-Smtp-Source: ACHHUZ5uQU9Aw4vKUlsR7E7dy0GCN8qQFP6+pXpb0wNZ4W+AMuVne5f+O9zjJA9yUO4//xXzr3olMA==
X-Received: by 2002:a17:902:ec84:b0:1a9:9dd3:6e with SMTP id x4-20020a170902ec8400b001a99dd3006emr12370500plg.16.1682667619368;
        Fri, 28 Apr 2023 00:40:19 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902849800b001a50ae08284sm12659960plo.301.2023.04.28.00.40.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2023 00:40:18 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 6/6] notes.c: introduce "--[no-]stripspace" option
Date:   Fri, 28 Apr 2023 15:40:13 +0800
Message-ID: <20230428074013.22998-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.356.gd56c4076.dirty
In-Reply-To: <xmqq4jp326oj.fsf@gitster.g>
References: <xmqq4jp326oj.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>Teng Long <dyroneteng@gmail.com> writes:
>
>> From: Teng Long <dyroneteng@gmail.com>
>>
>> This commit introduces a new option "--[no-]stripspace" to git notes
>> append, git notes edit, and git notes add. This option allows users to
>> control whether the note message need to stripped out.
>
>Makes sense.
>
>>     ... One more thing need to note is "the order of
>>     the options matter", that is, if you specify "-C" before "-m" or
>>     "-F", the reused message by "-C" will be stripped out together,
>>     because everytime concat "-m" or "-F" message, the concated message
>>     will be stripped together. Oppositely, if you specify "-m" or "-F"
>>     before "-C", the reused message by "-C" will not be stripped out.
>
>This sounds more like a design/implementation mistake that we may
>want to fix.

I doubted this either, but for compatibility, implementations of
this patchset have been made, such as "note_msg" recording the
"stripspace" field, to implement these two new options without
breaking the old behavior.

Thanks.
