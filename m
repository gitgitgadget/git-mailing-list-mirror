Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5456C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 07:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbhLFH5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhLFH5L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 02:57:11 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4B3C0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 23:53:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u80so9407228pfc.9
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 23:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OuQI53HeLf1Hle6CcdlF4X5ckt7BvwGaQcgUJWpg0ro=;
        b=JgSufmVqRPhWZHNyqh557HEft9bnRn/77GY57GfQuN8OxgL/2huUavcX+6ah9jfFfu
         sVHsK/n9LG53m3GaY7WKZnv/X4Bu5W/RCTaHZ4/jG2D7Lng/RALSmdcKD5pGpNXV/KUe
         Ql5uoegw9EImrNKCiSKcSuXMdLdV/PsLDBDvnhMOSbUFUUA536AegJjTNov+ABoOoxGk
         iiUVJCCRdh8LVe17lfGNdHlZ9yJX1zgV8XPc3QV1M+mPHw0nnWR9UobW/oKLXKELwxeF
         pQT3WrGr7oFD/rDEx3MmkRlnE66P3Z83KJZzZ5NQhMgy3nce18r0K3ELy1u8RVzExbet
         3aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuQI53HeLf1Hle6CcdlF4X5ckt7BvwGaQcgUJWpg0ro=;
        b=V5AvKElOeHscIt7Y1dSO7yjO4aNv5OhS8wWFisxBUiPoBmwDA/7SEiL6KNsDkjFESp
         l71gxRG/RA098f0bST6Pi0z4jE/MNo/bMmPC1JkHODcSpCNTQFS0nmI4pi+GiEDWwZ4p
         R5mA2RrPkbO9xL4T4r2e1xKZZ1t9q77Jgai9953BP2e2owjVS1G21220kRnw3CJIkEnG
         uqP9MxFDVrLq+D/Z/a01MhM2DzIePJpXE3A1DHiferNKr3nrgrSHsYwtOajRWmquYk84
         MqGG0eNdZ97tDc4SkNt63ngmVNxG2pvVSI4Qc0vTCoY3zAxiJk0neigZJVHblBOJbtHh
         RMSA==
X-Gm-Message-State: AOAM533DUddZvbKgOF13nE2sqYPfQsV3yCLLBRv0AYtJxBu1oBK4N0eQ
        TdBrFr+UNrHiozNA2HqiwhU=
X-Google-Smtp-Source: ABdhPJzBSZw+l0Phi7fB46FDSlZFJP6lewRXbnPEdQRLpyDjloD5uM/XunybJKJM9C7Ni+79ghx+8A==
X-Received: by 2002:a63:fa52:: with SMTP id g18mr7577238pgk.446.1638777223098;
        Sun, 05 Dec 2021 23:53:43 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id f18sm10909913pfk.105.2021.12.05.23.53.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Dec 2021 23:53:42 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, dyroneteng@gmail.com,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 1/1] ls-tree.c: support `--oid-only` option for "git-ls-tree"
Date:   Mon,  6 Dec 2021 15:52:23 +0800
Message-Id: <20211206075223.56031-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <xmqqmtlu7bb0.fsf@gitster.g>
References: <xmqqmtlu7bb0.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 23 Nov 2021 14:32:35 -0800, Junio C Hamano wrote:

> I can guess what "intercept the origin" wants to say, but it does
>not roll off the tongue very well.
>
> cf. Documentation/SubmittingPatches[[imperative-mood]]

Will learn and borrow your sentences and be shown in next patch :)

> This does not work well with "--long", right?

I think so.

Peff pointed out this is arguably a bug before because
`git ls-tree --long --name-only` do not really make sense (column of
the object size is not shown in result).

> Usually we say A is "Consistent" with B when A and B are different
> but are moral equivalent in their respective contexts.  These are
> identical, there is no difference.

Clearly understood now.

> Lose all of the above change, except for "Cannot be combined with".
> The original is just fine.

Will.

> Or "--long"?  Does this work with it?

As I understand the disscussed context so far, the "--long", "--name-only"
and "--oid-only" they should be mutually exclusive with each other.

> I suspect that "--long" would be part of this, if we were to go this
> route.

Agree.

> OPT_CMDMODE() is a handy way to ensure "--name-only", "--oid-only",
> and "--long" are not given together, but it may be overkill to make
> only two or three options mutually exclusive.
>
> In any case, once we pass the parsing part, the code should
> translate the option into a bitmask that specifies which among
> <mode>, <type>, <object-name>, <size>, and <filename> fields are
> shown.  It will result in cleaner code in show_tree() if it uses
> that set of fields to decide what is shown and how without looking
> at the cmdmode enum.

Make sense.

Thanks.
