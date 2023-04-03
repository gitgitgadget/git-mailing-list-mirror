Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D59C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 17:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjDCRHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjDCRH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 13:07:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE961BC2
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 10:07:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c18so28679256ple.11
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680541647;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCOCA2tOiQtE5tA8Q0tr9tywT7Oj7GgvSboE2K9Tw5Y=;
        b=bklJVdOEBgx3fb5+TmrIMv9iUJmrzhifA5ItAx1eYpNksBCwDISU8W1qrMELVrvUUX
         sKVyjMrPmxqArkFLaud3gTG+VyXI6WroInYBs9i3KCJdLbxgUUoReiGalpZc7c83m0jL
         TIuZqtUvViWjBwQaEZa2e4aQFnwDFmPV4Xp7Qb8LfiGmqUTJUEMRkro5TISTMUPyef6M
         tk+//n9uISkKUangwgOR0r7LRe21fN36GVtkLnYpTR5pUYS0AcwsqD3ovNFDuuix6Btb
         J/VsZMnI2QFnuOz7pWCs+puDf29o9dLR97s8gKccTXVRN1M6D3aq7obV9zovwYJN8V1C
         eiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541648;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCOCA2tOiQtE5tA8Q0tr9tywT7Oj7GgvSboE2K9Tw5Y=;
        b=vux9KrvZQUp7k+5OHR5MjZ56FmOc3GKbxCoENRXCjC/ItJWHeyWQNe1Or6/T2Ehzal
         vlyx5l05BwAJSRdmDHvA2Q9O9yPujC8+zqSWDz8hlazq9F77Sg3/MDbK1JW3frKtKc5/
         3U+B4oPtbDpNhbA5Y3eXytI3dFlIk8b1BBpQEP7zJ5tQKh4OPLSBW9D7+boRpOteC5FM
         uYJ8ZKOLQgfU5rGLPCwYQN8iIgZpz9EjAY+H6dBrjHrGKCWKyIFRX+gp/+R11pje9o/K
         CdUesYbl/7MgtBvhnANf2YZlud6b7CXjxrLoKGi0L+rf0l2qLidhno/F8LPXmAM3hWKV
         6mOA==
X-Gm-Message-State: AAQBX9eHeH0CfTwFABM+dzSAT6lH36rneR3t3t/4xcaortGGWmEHcVUq
        Hn/UAN7B/TCr4Zy+Ga/j0FQ=
X-Google-Smtp-Source: AKy350bDcdE/LU1U7Sa26BXwi2UP39kJrqP3oNx6OEa+X4swNJyUKBf7XVUzFrLbzv7DJjLQQxcYSg==
X-Received: by 2002:a17:90b:4c52:b0:23b:4376:f8cb with SMTP id np18-20020a17090b4c5200b0023b4376f8cbmr39964088pjb.26.1680541647504;
        Mon, 03 Apr 2023 10:07:27 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090a0e0200b00240aff612f0sm6574687pje.5.2023.04.03.10.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:07:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Hongyi Zhao <hongyi.zhao@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
        <20230402141613.yeseo5fj3lafuf7w@tb-raspi4>
Date:   Mon, 03 Apr 2023 10:07:26 -0700
Message-ID: <xmqqa5zo7v3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Find the last commit that had those 2 files, in other word the commit
> before f18fbd1e16a1ca4215621, say it is xyz.
>
> git checkout xyz -- Public/CTAN/IDE/phonon/compile-install-phonon
> should get the first file back into your working tree and staged.
>
> (Of course, this is out of my head. And you should be able to "restore"
> both files in one go.)

If the (old) version of these files existed in one (old) commit,
yes, you should be able to do that.

Thanks.
