Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F2C43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AB52311D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbhALRf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbhALRf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 12:35:27 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70ECC0617A2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:34:43 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id c7so2593685qke.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ui5teW7RkBio/qqJ+tD3wZfB6IwYYXToJmROwDUPyRA=;
        b=PZf5pTKSTJ7kJGKpw/5a/wzGRwVkYIZfAfuyds3Mep2nOZiq+VFDcHgj1unRwkX/LW
         QKsSHGwVzKUAF1aPxL7kJ0jt3Ki+6Rr9q8pZFAd6UYgA6fHX1A+B+77ojS8k9i5VE5Ic
         bbljypIj4QdoX5LZ2M9QzSa80SgqP+62ImAuJJk4Z21MNijowHmT1V7Wb6Hrj0S5fDjv
         6d119M72P+kRod9zNcElcZyOmBlEGRd7nohLjAGwk3Mqu3ZLHZXgyZK6hFkRAqHLJ9pM
         7rr360dqmNPqUWCuMVtAalZntoNWlZxI1xsqvB0NzTFqfT/3+sjhNQXMnqnW9WbOUYzA
         fAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ui5teW7RkBio/qqJ+tD3wZfB6IwYYXToJmROwDUPyRA=;
        b=LaKWq/4IGZI7LrAa/F/6FRzJgZGJG/F9ZyqBEGRj/C/Cvb8/6XpqAWVb7ET/17Epu6
         YF1RasocIbvosKxhLXM0JPEYCb1ukNcmqjBvCXXVh/9cZg9xGzZHM9x2Zo6wfRxjRkzA
         6sv82vDc1Labd+UG1Rb8Vf4ACUW+XIZ5g4/SLCzxH8dRmNoSfrbtYz5JS9wtrsFZgC6B
         k14DCt4pHQO0n1JsV4hmCiDUDFJthbAaHzXMi89/JB4ji0hVm3jkc3iJpoFUDjPU8RFs
         ZrRFcKneK5kibnT2wBgmlfExWP8sTSj/XM7sc+xc3QmUxNVGreOHajK7IGPmq0jfs5ha
         536g==
X-Gm-Message-State: AOAM532mAnMS/aQbe+amRHXO9B64jbORns7OygKxQ/tISvFojU3hUavP
        kiP8iy5q0kOKa3HzDShyoiwcGw==
X-Google-Smtp-Source: ABdhPJzVvoOd8WjTV+/an3PTRW3yTbvGRru9B7/pOPO1vj5r6u21fb7FCxLfH5HXSvI9oX8mV/sfyQ==
X-Received: by 2002:a05:620a:570:: with SMTP id p16mr436074qkp.106.1610472883142;
        Tue, 12 Jan 2021 09:34:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id c8sm1656496qkc.12.2021.01.12.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:34:42 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:34:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 7/8] t: support GIT_TEST_WRITE_REV_INDEX
Message-ID: <X/3dr8oGCX7XR2Wc@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <3525c4d114c8655953aca44d8effa1652ccc93d3.1610129989.git.me@ttaylorr.com>
 <9879225b-216a-574b-7bf8-a5f772732182@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9879225b-216a-574b-7bf8-a5f772732182@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 11:49:40AM -0500, Derrick Stolee wrote:
> Should this also be added to the second run of the test
> suite with optional variables?

Ah, I wasn't aware of this script myself. Yes, it should be there,
thanks.

Thanks,
Taylor
