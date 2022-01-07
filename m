Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC7C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 21:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiAGVxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiAGVxi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 16:53:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C4C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 13:53:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m1so6216066pfk.8
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EHKzXOSWZI0GXOdq59g4RsmW33I58HSLztoeFHY6mks=;
        b=FLqLydOoQjTHOdF/dSkIlqPAS4lBgjTH5HwXpmLqxieMoHdHMUbzRn0u+ybM73BX8b
         kG9QttBb+cYPF2tB3hLSIE1BNsMHnImayA1IjJL9YaTJer5JyaNdaXZ0sOy3IjEEaI5Y
         tXMUIu7NCVpc6LsvE4F9pG286K/7fwmzo2zdH38WCT/bQsINAl5XPm25eipwQrKxoDtb
         5w8CnYbcTB1baUyl75PtbtCRtSR2+XEsLpdmV9jjxGBPFU8HZnccSX9uSw6Q53xmhdtw
         ATJn6odbsNjJlF/nm69CGZpG4bNFekHo6+TLOQAxMXi/9N+bdw2aPM5XLK+c3UBH9wiB
         chZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EHKzXOSWZI0GXOdq59g4RsmW33I58HSLztoeFHY6mks=;
        b=Z8YjsxMBbHE1Qlba8Yb5V/y4amDA4o/0xww1y0g36KW4DSahibthKYws3KbT8RFyCK
         izp4pIqek9mpPH+bFdFa2yYK/TQaSQUCh4Eo/0v6S1CZEnhfnf2ro/ti/J0kdP1858uI
         Xh3SNtjh5wZDNFYq1dGGHrnjlGvbUBqxckRXxVDrx2X5dmCnliEQhRnLQ/TPxLEXYZwx
         e+b7pG12xuoUre6HMv3kVHg9h2t733s5jFauUdf1qJB8plLYAWY0T6Uang7H/PKR9EUC
         PZ5XSs9Xeg2tKe7tX+AwD4FafifLG6IDGOFgVGXIIMf3qEke1zoIRZnWQebU/86Smsba
         5zYw==
X-Gm-Message-State: AOAM533krYj51kIhOPH/EwQvyv+LtReDhvM6Z+Uzlz/sR1ZPaE22831L
        jVEqYAVJobu16EbTCBiNh0EKbQ==
X-Google-Smtp-Source: ABdhPJxS45tWwRuu0RKfb9iVETp0vpjth6zTwSQS8W1/kOIPrJpH0CGxBDzrfuz1BXRSFQZmxIEuBw==
X-Received: by 2002:a63:e555:: with SMTP id z21mr58375840pgj.555.1641592417618;
        Fri, 07 Jan 2022 13:53:37 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:3205:d63a:54aa:9c9d])
        by smtp.gmail.com with ESMTPSA id u8sm7094383pfi.147.2022.01.07.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:53:37 -0800 (PST)
Date:   Fri, 7 Jan 2022 13:53:32 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 01/17] hook: add 'run' subcommand
Message-ID: <Ydi2XEvZywEyImfC@google.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
 <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
 <patch-v6-01.17-ba6fd47482e-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-01.17-ba6fd47482e-20211222T035755Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 04:59:27AM +0100, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/hook.h b/hook.h
> +struct run_hooks_opt
> +{
> +	/* Environment vars to be set for each hook */
> +	struct strvec env;
> +
> +	/* Args to be passed to each hook */
> +	struct strvec args;
> +
> +	/* Emit an error if the hook is missing */
> +	unsigned int error_if_missing:1;

I wonder if it's premature to include error_if_missing, if we will
always set it to 1 until way down in patch 11.

But I do not care all that much - at this point, I'll be honest, I'd
just like to see the series merged.

> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> new file mode 100755
> +test_expect_success 'git hook run: nonexistent hook' '
> +	cat >stderr.expect <<-\EOF &&
> +	error: cannot find a hook named test-hook
> +	EOF
> +	test_expect_code 1 git hook run test-hook 2>stderr.actual &&
> +	test_cmp stderr.expect stderr.actual
> +'

It's a little unclear to me what "nonexistent" means - does it mean that
it's a hook unknown to Git (e.g. not in hook-list.h)? Does it mean that
the hook path doesn't exist? Does it mean the hook path is not
executable?

I had to poke in the code a little bit but it looks like this whole
known_hook() distinction has disappeared, so maybe I only find it
confusing because I reviewed previous iterations.

It might be nice to at least leave a comment on this test case and point
out that it relies on nobody having created a test-hook script in an
earlier test. Or to clean up that path just in case, at the beginning of
this one. I could see someone well-meaning adding another test before
this for something simple and breaking this test.


No serious concerns here though - just a couple thoughts.

 - Emily
