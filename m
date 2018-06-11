Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CFC1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 18:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933281AbeFKSCp (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 14:02:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51760 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeFKSCo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 14:02:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so16183717wmc.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5pw9wac5ic66crCO1P8upWIz3+7mPURR7K0oYQos0q8=;
        b=FtclQTXItdrsz3//jno1XbilWTOAu/EZTdBtYFcB1xwht/czrP8W+kFCBD1t9QymwJ
         Mu1763z7Dc6wsdIW0QFbZWcvj+AQ/J/3SYoPi2mULKshA40n4wDahhJOCPlSfMuRfncv
         5XFIHONifGHIMalvGRYSe5PlKL18wm8DjUp0HyGU61HF1CpOx7r0gM49QkT2iWbxnAO3
         Fjd5x23ye1fAS764OSrMOr4FwvQ+PbQuLN0MKb2HVzmZPjgJo0DJeiktYaztIJeGIm5H
         UVipy08AYK+YxL7jpc6b8/d0Fni+CKpdN2UcpU70UY/nXhR+YuzTLhdKkB6cuauHrv5a
         D2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5pw9wac5ic66crCO1P8upWIz3+7mPURR7K0oYQos0q8=;
        b=dDE2FpZI1xYJjorX9PPCJh2up/8q/fDPhVz/Y7ohVLZcB1vkEW2zv5k+t0oNRuUVT3
         6VSeYxhMj640M3apf7B3ZpSna91LFRsSym4aIsdUx5Ubk9ohKH62PDdMAfa32fj8LKZR
         dFOhP64eioeQ/rLt3F5XVhaeqHKdO/mqnR1/IOPB8aIwFKDUiFwKpR/fDmJ+T5AKsWc3
         kcu6Z0gAihD7LT2ZfOoPD7HewdE7hwUJ6qo/UVhkux400e993d/41tvcnEymi0b+k0la
         JUbX4XZSjBefuCpQwFTQ4pcassa593WciHnhMnVjbmjw2T42AJ5tsQYMaBpqHfTJVIzi
         dkjQ==
X-Gm-Message-State: APt69E0AS2ztb7cwwELZ/XbgazlYcV/YgubrBXHFF5M9mQjNC9dThWWd
        9WVK5ER8C91TqsviAvzCKCWz7Qrp
X-Google-Smtp-Source: ADUXVKIf3u912FlSUgFC8+RncHlgLYqsskBT8DTs+ZZ63wMC9cv5/l190P5/aVCw6IUth3DOa6HF0w==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186-v6mr24197wmf.40.1528740163197;
        Mon, 11 Jun 2018 11:02:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h11-v6sm16222340wrs.85.2018.06.11.11.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:02:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Clemens Buchacher <drizzd@gmx.net>, git@vger.kernel.org
Subject: Re: [PATCH] checkout files in-place
References: <20180610194444.GA1913@Sonnenschein.localdomain>
        <20180611020411.GE38834@genre.crustytoothpaste.net>
Date:   Mon, 11 Jun 2018 11:02:42 -0700
In-Reply-To: <20180611020411.GE38834@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 11 Jun 2018 02:04:11 +0000")
Message-ID: <xmqqvaapb3r1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> +	file prevent creating new files at the same path. Note that Git will not
>> +	update read/write permissions according to umask.
>
> I'm wondering if it's worth a mention that running out of disk space (or
> quota) will cause data to be truncated.

Aside from us not having to worry about emulating the umask, another
reason why we prefer "create, complete the write, and then finally
rename" over "overwrite and let it fail in the middle" is that the
former makes sure we never leave the path in a bad state.  It either
has a complete copy of the old contents, or a complete copy of the
new contents, and a third-party process reading from sidelines would
not get a partial copy, regardless of disc-full issue.

