Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8CAD20248
	for <e@80x24.org>; Fri, 12 Apr 2019 05:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfDLFfc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 01:35:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42366 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLFfc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 01:35:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so10208481wrx.9
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 22:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/feh0d2oN0T0MfCip/kdHZfxtZnZuCQ0CxAzCMvuVcI=;
        b=XgZV+SXAeYWOqqkcR1tPnkXxrpr7wrwg/w4/DEY8LtnHxOyabZapuSozlaKgHCXsDd
         nkxjhL6+fyFhwwVNolO2xlFTrcWDVRNq5aCYjBUViMZDmrA6APySNG8/kpn3fmDCum2T
         Izi8lvEQqdxe80x1iwIYw18z3ycVLDyiFD7ys2f/7M185claz5jiTAI4EvO2xAgMQPrn
         cSi9XTVcLeobZRUn4o2XpqetFLvktMP7fyDs7ZgXM/6KHqkAabzRvhIe9rljdrPmY4sm
         pkHqTUnGXVBZjhdS+HYP/Aag98mmqiP0nYAHnkeFuMWQ7yGF2sPrkB4dTJGNFUMviXe3
         69WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/feh0d2oN0T0MfCip/kdHZfxtZnZuCQ0CxAzCMvuVcI=;
        b=qqsvwNGjAeaa/eWlz4Zx86tdoRYf7jugKPcE4svPGlg1A8sG0vR73W5+7TNWPEpjgy
         ABQQANYo329qjPqFuah0XH0+tR+Q7S4HHhbwpqfbaATGIbU0Mj4L12WhfJTkJ2q3iv7j
         xloKudCsXfUOYJTl9/2ww1mYDzw7AbJJ44XfDLHa+Zcf5TEpuj3wVymM68aC8PhwC092
         OssiPl7HdtGS//iGHg2ymiunDuw4F6nznL3eIpW4Bmlso/mGgvtZ5Rb0/PPrMkasPK9F
         exLr5sFWT1RczW1CVMihzzXwEuowLUY3ARKtq9enTZ1iNhfFZTWSsD9+UuHEl6nPZHbQ
         MD+A==
X-Gm-Message-State: APjAAAXyUNNNuxP7y5whTM9xCLY2f9/9vqw1TQd8przNvZDLcSVsU/q6
        my/47QNKM4q/CmrUWBzQ63Y=
X-Google-Smtp-Source: APXvYqydsYWuVIbnmJagKSN4+JQT54Z4OX+M8a/miY3c3jKJsAh316pHBlVghiFOvaksUvMt0qk4dw==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr32728860wrn.90.1555047330324;
        Thu, 11 Apr 2019 22:35:30 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w11sm115090786wre.15.2019.04.11.22.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 22:35:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/2] transport: warn if server options are unsupported
References: <20190405204413.93900-1-jonathantanmy@google.com>
        <cover.1555014408.git.jonathantanmy@google.com>
        <63049081c98b8612bd233a6f01104c6196a09946.1555014408.git.jonathantanmy@google.com>
Date:   Fri, 12 Apr 2019 14:35:28 +0900
In-Reply-To: <63049081c98b8612bd233a6f01104c6196a09946.1555014408.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 11 Apr 2019 13:30:15 -0700")
Message-ID: <xmqqzhovyee7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
> +	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -c protocol.version=0 \
> +		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&

test_must_fail is not an executable but is a shell function.  Do not
expect VAR=VAL in front of it to work as expected.

"make test" triggered test-lint that caught this.
