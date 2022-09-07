Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4ECC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 16:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIGQRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGQRl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 12:17:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3F921E0E
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 09:17:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so9606267pjm.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=lEtccMYqBRV2JDvqdHuKsspj8Fg1p5/+HQT+A0PogJY=;
        b=PYsg4BGZsO0zRfkL79/rcoPA4fP1D/V6xeRVz5ULSfWIybe5ZQjHhi5TEBvO9acmv5
         1DLXWxZVktYkGklC7r0/FDsg6ZKd2z+e0U+gGmF6V4mWy7H7saEZmdVhYr2GGne/DKCX
         4oNxY1JZ/AfDrQ8hilYooos5At3tlqPc1Wfr8x3Zqoho6+gZK00ZV36PdWah3k7blx6d
         Mbc3eYCM0GGC9oVdG/Og/r17K8l1q3fdToHqQ2kEuTgU4gV1rYwSpQyPhUFpGoKYOQkY
         j7E4cNUCOLBDP+L0EMulpzq+n130e3j3LulFpJGzMPoaOsQPfJluKWS9VlfohGkuXVwD
         dYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=lEtccMYqBRV2JDvqdHuKsspj8Fg1p5/+HQT+A0PogJY=;
        b=W5ldmhVODlBSXJF1BCTg7JBiXvaG4h6TYxdYdXX/1OOmsBJ5z9KKCAFnDiOe4DWnn5
         nBcgFEJ+dAy/fVATaDUC2hpl51EVM1PrqPN2Yeq9aEtAmGC1uAEZz19eHWCfjP/h3YV8
         KouYwjIpSXCZUSgrTMpfYwaEdRbLS8UMSRzAM72rlZeUogNL+PRVDr18d6ZH3eQx1C1a
         EuUf+6fzygDvCCmRaYygTWFmccuPfy8X36g8sALk0CMGHd+4CDpZviog+bNnWA7WAylw
         Bh++r7p+DYGFskFsDRnvXT+ZEe8Ufxacsnf4vvhjvZHsAptX9zG03pVkDgynnfSM732W
         PdtA==
X-Gm-Message-State: ACgBeo1rFOWRTUpMOPA5LDKDzBsWg9Lw/fVEeTNF8XFHVi0OCzbDEX/o
        5IDaaC1Tw+7fWI64PhW6nzo=
X-Google-Smtp-Source: AA6agR5IRoOoRdCWu0CK8KlKx2PxUdua2SndAtAzuQloBrrOZPI/o0zgEdXuA909/8V/P+2781ksCg==
X-Received: by 2002:a17:90b:38c1:b0:200:8f03:63d8 with SMTP id nn1-20020a17090b38c100b002008f0363d8mr11992889pjb.148.1662567460222;
        Wed, 07 Sep 2022 09:17:40 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l8-20020a654c48000000b0042988a04bfdsm10929396pgr.9.2022.09.07.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:17:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: en/remerge-diff-fixes
References: <xmqqilm1yp3m.fsf@gitster.g>
        <CABPp-BEX0ScdAvQ1YaPUPNQ197mhcRMEFnHBoJ_0MBTK3nv_DA@mail.gmail.com>
Date:   Wed, 07 Sep 2022 09:17:39 -0700
In-Reply-To: <CABPp-BEX0ScdAvQ1YaPUPNQ197mhcRMEFnHBoJ_0MBTK3nv_DA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 6 Sep 2022 07:17:31 -0700")
Message-ID: <xmqqedwnyx98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> So, which of the following would you prefer?
>   * A separate series for maint and main?
>   * Just ignore maint?
>   * Me to rebase on maint to tweak the commit message, and then you
> carefully reinstate the line removal as part of the merge back to
> main?

None of them X-<.

As this cycle gets close to end, mergeability to 'maint' starts to
matter less and less, so let's stop worrying about this single
instance.
