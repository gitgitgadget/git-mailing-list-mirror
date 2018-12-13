Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3099A20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 03:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeLMDqL (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 22:46:11 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:39252 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLMDqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 22:46:10 -0500
Received: by mail-qk1-f171.google.com with SMTP id q70so371962qkh.6
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 19:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Xw3K6exjbmR/Mg3v7eqWgD98vOXPDxgJxuB06dXYnc=;
        b=pP+a0DI4zhlBTgdzpihsB7wtzhEKeXyNkMA1z6v+ZvymUE5H+bTZYlorPjYi/aE/qy
         b48G19Px8lreycBIo9mox9ZhOvwbDdL9GHrZmiWIzPpHoYSpin+VTvWHrLRMJ4Pcy2je
         mbzWzxgB50DIxX8z9aJ5bqZik14untIHsL0f8vRZS7wnvP9Ias3JxlPLCAfB7CDwDJyA
         HFmMGvalBz51kha9I5KwisPCl30WKLJUKmvJO6Y8iMw5+45/TWOzVRAD0E7r8yjeYKOK
         wqTW8JNBldi7zrwSR3hvRBiPSiY/2sc92DO3iXGCN4MFWYytD3oOfJ8HHyCEAH/VBoaB
         jyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Xw3K6exjbmR/Mg3v7eqWgD98vOXPDxgJxuB06dXYnc=;
        b=ObAsxoySaPWT5fcJCljii6fVrUrXzUOP07/VwHrgwLd68p4ASCuCo9cYVHHOTCfKFj
         Ts/3AnidXNYE9QNl5q67hnjtbX7FCSOnWJKwMhU7LKUK3tu0U5E7SVnaFTq2QRzd2qY+
         Jy7z8fNEn+deOwlIa9NJgDbMo7MtYLsnuznYOrI1ASrE6gM+4/t3rhduZcz3WNBYdL1q
         MABQEdEo5FzJk7+h5eZj6olHs91Q2y2QNZnOxTJeCDsHrjJY5GkHXz8/x0VFk6IC2+I6
         QlbR4yHhff0ld43xZwIlWvtDKco5joHnCEYsmO08H/+6EU2P1qVnLPFyZrHJyf3AmiM4
         FudQ==
X-Gm-Message-State: AA+aEWbAzuItgXa+B46hl3JPLz0Daj44dHhzNvaWP1owjGEEAmIt2yAB
        XcocHHAV82vWlTKFXLEuvoA=
X-Google-Smtp-Source: AFSGD/Xzl6wV5gzupoYY3xPSd3huYSwIYGtFyXmTxKXyd+uwgf+Ay08vPjeD7cTv8a6TXabwo/iWvg==
X-Received: by 2002:a37:7206:: with SMTP id n6mr20349532qkc.64.1544672769453;
        Wed, 12 Dec 2018 19:46:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:15bc])
        by smtp.gmail.com with ESMTPSA id f201sm385448qke.0.2018.12.12.19.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 19:46:08 -0800 (PST)
Date:   Wed, 12 Dec 2018 19:46:06 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, kernel-team@fb.com,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks
 and other cross-references
Message-ID: <20181213034606.GS2509588@devbig004.ftw2.facebook.com>
References: <20181211234909.2855638-1-tj@kernel.org>
 <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
 <20181212145456.GQ2509588@devbig004.ftw2.facebook.com>
 <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
 <xmqqa7lagm18.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7lagm18.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Junio, Stefan.

On Thu, Dec 13, 2018 at 12:09:39PM +0900, Junio C Hamano wrote:
> Please do not take the above as "don't do notes/xref-; instead read
> from the 'meta commits'".  I do not have a preference between the
> two proposed implementations.  The important thing is that we won't
> end up with having to maintain two separate mechanisms that want to
> keep track of essentially the same class of information.  FWIW I'd
> be perfectly fine if the unification goes the other way, as long as
> goals of both parties are met, and for that, I'd like to see you two
> work together, or at least be aware of what each other is doing and
> see if cross-pollination would result in a mutually better solution.

So, from my POV, the only thing I want is being able to easily tell
which commit got cherry picked where.  I really don't care how that's
achieved.  Stefan, if there's anything I can do to push it forward,
let me know and if you see anything useful in my patchset, please feel
free to incorporate them in any way.

Thanks.

-- 
tejun
