Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3FE1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 15:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfBRPRb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 10:17:31 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:32921 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbfBRPRb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 10:17:31 -0500
Received: by mail-wr1-f44.google.com with SMTP id i12so18841530wrw.0
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yO61odtHCBc0Q5y6QHDc0hnfF+jsLIwgxpbAb2/qI5w=;
        b=TRDOlWO5Y13I6F/uWec1zwI8vuWoOdMAkGGWeKjhUxTKtYZjGj1XqZHd0mPyugId0X
         0gJk3Q/me6Tvb9LWpsG5oH4QoVt/nBy1E/DWwfphZnhbIeDX8sN71y95UmE7hh3ujEKE
         HYeHpvi24m4HzC5vCswhJ/tymhIePTLw/ooYFkx2CVlIkEdtS/GSoqkWUAImMmfr/l70
         tHwL59SwosLJZZumx351Zpb3rYdan7DZBYhg3UxWoud5dq7EucNpwtG1S7/4u8bZr9nv
         ZWsu27Wg+8du2sjo1IVH8najC4cK7artip0RDF6hjUD6/h8/8XgMVFgcnAj2RyYjBqu6
         JW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yO61odtHCBc0Q5y6QHDc0hnfF+jsLIwgxpbAb2/qI5w=;
        b=REz0+VkBcJ4MJpv8pZ+YZtUIFheMYCkhcTrvKH76H0JgT1IrXcie7XxFQp30jZ0H/O
         UEFWsHSWn+dCivnYuDeYwtEwo7Mz4yzPZAGmcBMArQCQunDF8xZ1H43cudwWkBLc3koP
         GTpJe6EhcPf5jVIFfg6S1u+N0vwxeC9BRgqU9MksVRf1si5u173QJXXQLvGi+B0A7xTi
         ThTiXvZfS52uEdbCvQwwY3RVdoFHPhZ0fpKLeFpiDPeaa5EhwyAXohIJnECwy3VUMmNw
         ZpEGZ4DPVCES0F2KVa4dpIsmaNlohZGxvAzmgj7HU9sDWA/gzTtJKmXjeTxhedriYaLk
         qMxg==
X-Gm-Message-State: AHQUAuYpK6mJuTAtr+NkfoE2ExqSSu4iaujTzUdesg7VjYpIlbbd5llG
        3ARCA6MJsdYxlsgaqxG2Mu9kaHNw
X-Google-Smtp-Source: AHgI3IaLDROzUKwQt8ytFHZh4I/CcQjg2ui6tBbDhri7RirxvFzaIPBHuj62u8LFNh3cuEdAiwTLxg==
X-Received: by 2002:adf:eb01:: with SMTP id s1mr16459403wrn.101.1550503049263;
        Mon, 18 Feb 2019 07:17:29 -0800 (PST)
Received: from szeder.dev (x4db52463.dyn.telefonica.de. [77.181.36.99])
        by smtp.gmail.com with ESMTPSA id t18sm2641187wmt.8.2019.02.18.07.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 07:17:28 -0800 (PST)
Date:   Mon, 18 Feb 2019 16:17:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Joe Ranieri <jranieri@grammatech.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] ls-files showing deleted files (unchecked lstat return
 value)
Message-ID: <20190218151725.GL1622@szeder.dev>
References: <1ff48830-f3de-11f4-9014-c20eb3890c21@grammatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ff48830-f3de-11f4-9014-c20eb3890c21@grammatech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 17, 2019 at 08:49:39AM -0500, Joe Ranieri wrote:
> "git ls-files -m" can show deleted files, despite -d not having been
> specified. 

To my understanding that's intentional: a deleted file is considered
modified, because its content clearly doesn't match the tracked
content.


> This is due to ls-files.c's show_files function calling lstat but
> not checking the return value before calling ie_modified with the
> uninitialized stat structure.
> 
> This problem was found using the static analysis tool GrammaTech CodeSonar.
