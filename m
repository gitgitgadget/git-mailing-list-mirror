Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8AB31F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeHNXot (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:44:49 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36679 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbeHNXos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:44:48 -0400
Received: by mail-wm0-f49.google.com with SMTP id w24-v6so13468936wmc.1
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5UCKk95kKi2U70hESC0EAXcx0PqcDOoWja7vEM4WexI=;
        b=hGsc7klqE0vfS3yjk6+ADHADWbcgF9KAbaH6UDywGOxRZp5B7jWfXDFc/0HMd2+Gzx
         zrQqgCwDmcBYm5i5A6Ba/VDglEPZ8z1mWERcasuUwbAkm9C2bWaP1vnVkH5VbXURHukb
         reOIpSFXzR5bMSM8a1aHbliQJ0LZ41Bx6ZqXqABQh3GQPjRHoa6SMToK1LKSsU3fePhV
         6bODNMCIBtrf89mU51qGw46PuUrxcCeTfaqJy7UsD6iUG49MOMd+//H4Sgh1U3VvJKm6
         2NRsQuip0b6Tx8bMqqC4j+tqTw6tSXwo/WosxO6lESl5xIjVlxX9yuVaWTut3QGvenp6
         nrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5UCKk95kKi2U70hESC0EAXcx0PqcDOoWja7vEM4WexI=;
        b=jUE3TnW1jQvAbXkSkmkuJc7oV7pODn6/TxPqsjrkw73D9UAkZB4tXGPzaZVPiLnHuN
         XsTRfu8Ws6uKwXr8iGP5GpGf5bzcgOTcSaSd7ym723GgZKP32zy01v//NBJ4c+Wx+hLf
         HoxLgfB5adblMnCeXU8jmZRV0v1fbkp/L8sYLCirs+MzZWdoCIiwrUw44LFpwMlCiTsv
         TLLVqUqNO19Xa/CkdbnrtJ3GqZvAgZzrVxOIzXas+2j40QZHISU5Is13PrYBddhzPyvf
         VkajOmL5/C4M+NbtTD7ASvwI45oZyRyeBJbTHKJRvyeSzcr+Z0Trq+4zvfEG1/SMZrEA
         QHfQ==
X-Gm-Message-State: AOUpUlEzj5uVsQ36DyHb0lth8QcIR3171ygTaoNxDDq/ZkPr8D+kZi7c
        Oxmm32izWq6RORLriVLp0QE=
X-Google-Smtp-Source: AA+uWPwfv1Ridl8ScAV99lTjSuhR6/QvgNxixAjmM4oIqfXB0yyUi77Qj8UPCgHZdRmx0+lBVdNwnQ==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr11470425wma.85.1534280149079;
        Tue, 14 Aug 2018 13:55:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u7-v6sm16959321wrq.13.2018.08.14.13.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:55:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
References: <CAMfpvhKr4jmjZ3NUmxMyTM7KJxQX30UYXKf_rJ30A4C=P3tB=g@mail.gmail.com>
        <20180814201920.56534-1-jonathantanmy@google.com>
Date:   Tue, 14 Aug 2018 13:55:48 -0700
In-Reply-To: <20180814201920.56534-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 14 Aug 2018 13:19:20 -0700")
Message-ID: <xmqqa7pozmzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> - grep -E "tree|blob" objs >trees_and_blobs &&
>> - test_line_count = 1 trees_and_blobs
>> + grep -E "tree|blob" objs \
>> + | awk -f print_1.awk >trees_and_blobs &&
>> + git -C r1 rev-parse HEAD: >expected &&
>> + test_cmp trees_and_blobs expected
>
> Indent "| awk" (and similar lines in this patch) - although I guess it
> is likely that you actually have it indented, and your e-mail client
> modified the whitespace so that it looks like there is no indent.

No, wrap lines like this

	command1 arg1 arg2 |
	command2 arg1 arg2 &&

That way, you do not need backslash to continue line.

Also think twice when you are seeing yourself piping output from
"grep" to more powerful tools like "perl", "awk" or "sed".  Often
you can lose the upstream "grep".
