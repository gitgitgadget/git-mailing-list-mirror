Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E788C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073AC60F58
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhKBOLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhKBOLp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:11:45 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F795C0613F5
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 07:09:11 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id v2so13302715qve.11
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2fcJ7HrpCmnETpsqtC5q8uymJvdgUpZmTHzzVcs4PHc=;
        b=IQs+u8mM7R5NtEWttbb4CUH5bTMVZ2Gtp1x7d9hfcqUz6JehWz+jABnoQQyB0Tr1Hc
         GXMNzuEmIeHs0vfjBihPY4jDENge/bZv5tn84pZzby63Flr5IsCcFJjL7Jy9IOOgebjk
         jwnvCUjMf7e4K9d/cT4Xn4uwKEg5q2SBGeypE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2fcJ7HrpCmnETpsqtC5q8uymJvdgUpZmTHzzVcs4PHc=;
        b=qlboWvc95A8Da2wb6ydg9ImFdDG+Ogf4qoAlqSAkTkxPAUFdAToV2aPcyncdbCYEce
         UAtoOounM5CtlwycThMiBikxwy9l4vV61HyxWTDn54IkO1lPtEVGzskPFg8xE5KHjZ0Q
         iInyLXbXFWoyn0OxcZ7w9/0wrLUtgIpWO3zvBH9R31Ujb3ina8/h17FZrNMGdBV1EH7k
         axD28qscPjWFcBhdp2eZ6vmhw5npA+4VxQhMDPrztfrBk8DE6YbiToGTjlmhkWBt0e9D
         PEGWvB730N+i3w5iheqaQ97zGsvlL/T+yfTNBYPE75b4U3mLyMGgZr/fFD7EmuHOukup
         RBcQ==
X-Gm-Message-State: AOAM533TLrvUhLT/aSqcjWngJKt+a5FU9Y9DFERw5ANciNs/lSAczbwZ
        RkzOANRjVmWBDjugoKOem/1HMQ==
X-Google-Smtp-Source: ABdhPJz8t1CV4HWURZNA3+hnwyVectpkAEY8hr7WErkNDqrQr0ZgAhSEtNWFfqY9Aj9VDSV/1WyMaQ==
X-Received: by 2002:ad4:5e87:: with SMTP id jl7mr24508714qvb.19.1635862150183;
        Tue, 02 Nov 2021 07:09:10 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id s13sm12861115qki.23.2021.11.02.07.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:09:09 -0700 (PDT)
Date:   Tue, 2 Nov 2021 10:09:07 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, users@linux.kernel.org,
        tools@linux.kernel.org, git@vger.kernel.org
Subject: Re: b4: unicode control characters -- warn or remove?
Message-ID: <20211102140907.d7turl5zhaxkcp7w@meerkat.local>
References: <20211101175020.5r4cwmy4qppi7dis@meerkat.local>
 <20211101190905.M853114@dcvr>
 <211101.86bl333als.gmgdl@evledraar.gmail.com>
 <20211101202220.dlcebvckeoz6c26k@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101202220.dlcebvckeoz6c26k@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 01, 2021 at 04:22:20PM -0400, Konstantin Ryabitsev wrote:
> I think the following would be a sane check:
> 
> 1. are there unicode control characters (CCs) present?
> 2. are there other characters from RTL languages present in the same line?
> 
> if both 1 && 2 are true, this is a legitimate use of Unicode CCs. If only 1 is
> true, then it's likely worth a warning.

I implemented this solution in b4 master, so it should error out only when it
finds control characters without any "other letter" unicode character category
present in the same line (where Hebrew, Arabic, etc live). There's probably
still a way to take advantage of this, but hopefully it's a lot less trivial
now and less likely to go unnoticed by the reviewer.

The error message will point where it found the problem:

	WARNING: Message contains suspicious unicode control characters!
			 Subject: [PATCH 1/2] SPI: Add SPI driver for Sunplus SP7021
				Line: + /* ‮ } ⁦if (isAdmin)⁩ ⁦ begin admins only */
				-----------^
				Char: RIGHT-TO-LEFT OVERRIDE (0x202e)
			 If you are sure about this, rerun with the right flag to allow.

One can rerun with --allow-unicode-control-chars to override this.

-K
