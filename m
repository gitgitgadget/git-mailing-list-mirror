Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02250C4708E
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 23:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLPXKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiLPXJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 18:09:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2FA6F0D9
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:09:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3823251pjm.2
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xlfO6BUOPc44C1gsBb+hgdMuerv5IhnTTTNAh0U7/Y=;
        b=EcY43zYcv8VbYs2X/bCFkxrXckJb2LUwOxWpxMtn2Ly4i38HOKQc9v9VQUGrpy8Vew
         SP84TzqWbrpev9hZblLuDnja7LHpXPfetJy2JjJYn2bj4ploLGunA29JIZUd7AkYdvX+
         2iH51nxwQZN/R7CyFJ6LlLCQA7AYaTQZ4YyE8e/Lm6eVQvOGbzpxBFrxXaLfaziTtgKR
         fS/kpmeGFv9nN+ed+eOYV3c39sHQlCmfPhD0yxGhPYFLV+JWiC43MF/hs8jTxFyIKoTB
         lATQwz+Gd+GzjhivAbMbmEBr8HIJSzd6336SBA5x58ZXFpCo2xgZlbiol11TPIH3tkkr
         Csiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/xlfO6BUOPc44C1gsBb+hgdMuerv5IhnTTTNAh0U7/Y=;
        b=mwDkHaChjmvVU4PdGbrXBuj9h16A9KKZMC+MUFiqaXTMJxh05oLyBJPd7eB+sak/I9
         gsdNF7i1HkWszuXidJ7DV9AayjmW1MN6skg+Ls/k8UfpoY2YINPNF4AhapK1UteatYBU
         bjJdYb9+/Lgu3ydSJ0XwBtPyQABnvTkAl8VNJaHy49B51CaelQBHf0H1HPxnbASKLQbG
         sBBjD0AfuVopKvztktYdJu/9iyJqhANY11IM3I/igGkibYghd1rotdJJJjAUlYDYEa+M
         NRpq249HZwgIRFe8UQDLo8buphwgBxNFzC2sEac40qz+fuiwMexmZ8ngOd/5PDGvUyrg
         dhYA==
X-Gm-Message-State: ANoB5pkcaT1pSP95NOdCirKrhq///1Aljmh6MSrlAvy0gAE5r/6h+RTz
        iuUgtTYsbsv3mqxhpVwgj9c+QRWjcoqHdQ==
X-Google-Smtp-Source: AA0mqf4/fQKY7ssIeO6EIuaf32iSJrD2HgZq1q/ZoPtdDqn4+hCzQ6W/k1+zxr37t0zx0TaFEXcGgA==
X-Received: by 2002:a17:902:6bcc:b0:186:6ae1:5ee with SMTP id m12-20020a1709026bcc00b001866ae105eemr31374183plt.26.1671232181531;
        Fri, 16 Dec 2022 15:09:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b00189393ab02csm2147260plk.99.2022.12.16.15.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:09:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
        <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
Date:   Sat, 17 Dec 2022 08:09:40 +0900
In-Reply-To: <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net> (Mathias
        Krause's message of "Fri, 16 Dec 2022 20:26:26 +0100")
Message-ID: <xmqqlen7kksr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> ... However, from a user's point of view a fall back to
> interpreter mode might still be desired in this case, as a failing
> 'git grep' is simply not acceptable, IMHO.

"git grep" that silently produces a wrong result (by falling back
after a problem is detected) would not be acceptable, either.
Receiving BADOPTION could be a sign that there is something wrong in
the input, not from the end-user but from the code, in which case
stopping with BUG() may be a more appropriate?

>> I put a BUG() there, we could keep the die(), but
>> PCRE2_ERROR_JIT_BADOPTION is really more appropriate as a BUG(), and if
>> it starts returning any other codes our use of the API is also in some
>> unknown state, so we should also BUG() out.
>
> Valid points. I'll give others some more time to churn in and if there
> are no strong objections, I'll change it like you suggest.

Yup, sounds quite sensible.
