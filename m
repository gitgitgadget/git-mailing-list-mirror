Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0CDC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB5265272
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhCHUwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhCHUwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:52:12 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B3CC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:52:12 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k2so10133062ili.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q69hFmTLxqkHEDt9FAmblt7npFUICFkjGnfngwW5Bao=;
        b=1F8ZhEf/DUBFFpvNmsnedxf7j6dn/lfnSX4dmQYUgHiudSgfdq/QuluzUF9H+cp3hW
         +DHQ55u6Zz1IHe/r9gBKK9u0++MD0G8+6NPv2TgHnpjykRg+2q9MhUYmztvOGepxdrfv
         n9e2n/roqZwqbWgwKVvYi6zIuoP5phLkt6C1lpKEYvjbOfvFj+oDbFgL4G549ENkNmnE
         C0LFeYv3o4TLkcjDKKFRzYPj0xlL8VHDYkzGFLo3K+cpFpxJq7L1lSi7P43/vv5RKDmw
         t0c5zGKoEi2kQKyMOC01zd2bpEQ32FWHy6mO90AJH6FOBuk4voVdAnZU+ZIsIq2LhE9b
         39Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q69hFmTLxqkHEDt9FAmblt7npFUICFkjGnfngwW5Bao=;
        b=s3HMOS8iDAIQBwn9Re7LVWP7QRaDTsWD9aJdqOH+Z0gdByJZOBAH8pucZVHUnKVhWU
         sUWqI9a/YKofzCI7u5tBrUYx/bAW3/E4kekYPytywAt4rfw4BU1MrLgwR+JqQ6a6KIDk
         WwEhIbXR1Bj0Hj/SbPeul4RFnhcI6KEA8D4nN5Z3TWbHaPEzg2e26DslMcxcmfoUn+ex
         3LpTdkCW5odPAEPTJCz+d6DNwFZq/54kGutf3UQtZp63ZXGcVW2gVhHzrsfGjiD8tFN3
         Q3c0f7Y4q/rw+fwou2kA55dB26H+CqI7lTwCNPfFdUyCNRQr5PHx3gHTjAAgMAyDfV0g
         LELQ==
X-Gm-Message-State: AOAM531ECTlZ+i+XQnFL3XcnWCSF4e0R2Mka+EBeih7XAmYxBs+Bqt7E
        dfLiZLsz6lHFAoid2sNT/4X0Yg==
X-Google-Smtp-Source: ABdhPJyQyraHYlJ8dhCPQ8Aytu77EYFgYi4hXm0QvRLsIm8eUBloAfCCqjvC/mhH3Mo1PCHwyUMS2g==
X-Received: by 2002:a92:bd06:: with SMTP id c6mr22966033ile.158.1615236731744;
        Mon, 08 Mar 2021 12:52:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d4a3:1166:858b:6d61])
        by smtp.gmail.com with ESMTPSA id d12sm6615158ila.71.2021.03.08.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:52:11 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:52:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] object.c: refactor type_from_string_gently()
Message-ID: <YEaOeK96r2oo7cbS@nand.local>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308200426.21824-2-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:04:20PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Get rid of the "gently" argument to type_from_string_gently() to make
> it consistent with most other *_gently() functions.
>
> This refactoring of adding a third parameter was done in
> fe8e3b71805 (Refactor type_from_string() to allow continuing after
> detecting an error, 2014-09-10) in preparation for its use in
> fsck.c.

Makes sense. I don't think it hurts to mention that fe8e3b71805 also
wrote the implementation of type_from_string() as:

  #define type_from_string(str) type_from_string_gently(str, -1, 0)

making it the only caller to pass '0' for the 'gentle' parameter. So by
implementing it as a function in terms of type_from_string_gently()
which checks for a negative return value, we can drop the 'gentle'
parameter entirely.

Makes sense.

Thanks,
Taylor
