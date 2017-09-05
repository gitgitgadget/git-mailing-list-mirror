Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B869C208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 21:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbdIEVzK (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:55:10 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:37622 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbdIEVzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:55:09 -0400
Received: by mail-io0-f178.google.com with SMTP id j141so16225917ioj.4
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pSHCPSPY0bbiMoOQsswbI+LkT/f6RJkUcH5DOdj7yps=;
        b=MmwKLfMmett1PXAoFHU7ysVPeO4AVnl4bt4QV8u3AH/fp/XfE5yPEAs7eCMb74uxsG
         1tBY2xl5R1NM4RNfexMUHRjKx6KaFdLsW3ynU1/I8z6hATu2zwThf+qTNFiBozjCBQeE
         G/wHaywbb8X7DFQ7VCJLExhOM/9sScAjS2+OdyimIce09XsMBKICxYjGdVCx38EDLrhk
         jKiaGyfB+274/KkZYJ38hVOtTtLJVAq9yW/xfjq/2sLKv2YHURTnwAlZaroMMUnUE78W
         /Ik6j/ALigStzPcuWiZEgTVW2C4pNvhh95vOKiozpob7iV5TAITsHpUTi1/Qn7xz36Y5
         4xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pSHCPSPY0bbiMoOQsswbI+LkT/f6RJkUcH5DOdj7yps=;
        b=CsAMD/KVrzrJX7tEPkWiJ5CUxoJaGyI2CbfdwucGLYUGj0+OYKwOKhjaAk863a0Xjk
         zJEVg5SyvHD924V2LPeawQ6TuItDqdpca01zIZouGqiSGh5WrIw3VC1LgmLfLPn4RP12
         CR/qYkLb0SReDjUjV/Yi8fXahsgEOatUiVhZtcg8eNpMZEiErogYTXHiLpQxnWQRVsan
         MhvUVIHXg4JQdDyxgQmohOvLCRBuCSw0/gtFPCzoZoEfQkv0xI97exPW8ePPkSxyaz3V
         r61o9oxAPyW9Rx8KPVlEbaBwVsOSLlYGICfS4Kus8IMXDLqF7a386plprV4csrKil+WV
         R2+Q==
X-Gm-Message-State: AHPjjUjKqlJJXzBw3lFjzBlZD4P0gB67dVK7WMcMoFqejSuPBI1Nyfrx
        XN/EdgF33LMB/WCE71AcJK9d/mQ9SY/RIAU=
X-Google-Smtp-Source: ADKCNb792/DDoHPk+unwvEl/k/XI28Z9FDhuEj6HV7vzXJoVkWnoKj9Aw2dv/bOcMLsJfjNjkipQtoYEGI/0iVXWPus=
X-Received: by 10.107.169.91 with SMTP id s88mr516493ioe.179.1504648509155;
 Tue, 05 Sep 2017 14:55:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.15.151 with HTTP; Tue, 5 Sep 2017 14:55:08 -0700 (PDT)
In-Reply-To: <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net>
References: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
 <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Sep 2017 14:55:08 -0700
X-Google-Sender-Auth: -XZ3JuNdcvCGSx4WdDTwpnwEoFo
Message-ID: <CA+55aFywhyELmbhAorgTjJZeuNxE-+j2qSP=3d3vqQXNM6p54A@mail.gmail.com>
Subject: Re: BUG: attempt to trim too many characters
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 2:50 PM, Jeff King <peff@peff.net> wrote:
>
> What version of git are you running? This should be fixed by 03df567fbf
> (for_each_bisect_ref(): don't trim refnames, 2017-06-18) which is in
> v2.14.

I'm way more recent than 2.14.

I'm at commit 238e487ea ("The fifth batch post 2.14")

              Linus
