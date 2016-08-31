Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A231F859
	for <e@80x24.org>; Wed, 31 Aug 2016 21:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbcHaV72 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 17:59:28 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38536 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932719AbcHaV71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 17:59:27 -0400
Received: by mail-it0-f54.google.com with SMTP id c198so11082844ith.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r2I1+Y/Zcu0e6k0fQ0/1U/l1MHuYv+ROy96Ds7eDCh0=;
        b=ZhkvOxCmBZw2Zowey3zv4M/DRm2v7H/qGnXqCxMetIELlj/8WTmLeufYrDJtrFRV32
         rkKVNR1qHaR8Ao+vOoK6ILnKP6tEJIjZVkRm4XZ3D/cTFzg8EtxVbiVdALFa2tn1GXd8
         4Ocv37wRzPy3BfRH1XCnSH24M9DfbIVsRIAVVjlgPsSBk2gZ2HLVNwaRMvwPGXlI4u7O
         uRnZxHc2h0DaNw7eowyFimJwnMedFQicTNj9ry6oaEDTRq3h4jEQLRRvj9UunTE2Qmjl
         wj4QU1i+m0HDHmJ2bETKDgegYza8qUAs8MNq+nkET9yRN2QCnOn1b286yuhAGPfP2iSV
         WKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r2I1+Y/Zcu0e6k0fQ0/1U/l1MHuYv+ROy96Ds7eDCh0=;
        b=KTIPVDzEECZRFljwEUb1rDv0lGoOdyKCthq3ueJF7veGV36rrxoH+Mrpl7+I5Yymgs
         OCfsl+yffzVTCrBMPbIQ/vSmDoZG95mktMd4mKsxyjTNi/zIWO5c5MUYz0bxHLuXRM5F
         +Qk6vPOCxClV4NsLWIvon0JvRsg+ND6vwypWyRwuSMSMfy4tA8RwH+Wr8fl0MSar9f44
         4dxy37X50xj/A2EsDL/9vscRUkziap2z9yejqtWMewMKHDdgizIG2Sj91DLHrJFG5h2D
         j1dKrzYMA2r8E9IRsKF7pZ7znaMgBym820d9YfCcrXEUkMNuceG5u0JUCQkf6UMky8d1
         Rddg==
X-Gm-Message-State: AE9vXwPeFuzIu1ucbnRPLqH5VBkaYgN/d89UHTakjNo+eXotLQX38TQsp23/y4ixtRfbUxORG8JqpkwgxFknCEEU
X-Received: by 10.36.107.82 with SMTP id v79mr33760487itc.52.1472680766667;
 Wed, 31 Aug 2016 14:59:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 14:59:26 -0700 (PDT)
In-Reply-To: <20160827184547.4365-6-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org> <20160827184547.4365-6-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 14:59:26 -0700
Message-ID: <CAGZ79kYSDs=BjbF5D0CM5krqc9D8u+54fT_geMzJOFXT35zi6Q@mail.gmail.com>
Subject: Re: [PATCH v13 05/14] apply: use error_errno() where possible
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To avoid possible mistakes and to uniformly show the errno
> related messages, let's use error_errno() where possible.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Looks good,
Thanks for these cleanups!
Stefan
