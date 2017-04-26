Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BD3207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 03:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167353AbdDZDZw (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 23:25:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34457 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1045932AbdDZDZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 23:25:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id t7so11178993pgt.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3RCFlIytfGceLQt7+7ba1r9PORKfxdivEbvE4XMBkkY=;
        b=jUUjeXVykI7PdRCHTwiJpIOVNW2NjFC6nZY6/sQIi871VFlQzlh+DAR1PuMGoWdS/D
         UH4VQN8aCcfC/7J4ES/Qqj3Nikj6Tkh7p3D8qC7hpOPADX1/6RS4qpObxfU+rMXXAZu1
         BnJX21PnLa5h4gJzddq0zxppLFomZ7AHyn68W1T8cZ19cyOunMM5tXdYeUN3TtQIPoCh
         nJt5FCkqndHAt182OFyDLHYim3W91hpxqJFB4O+kMK0xZNUlQhPNB1uFqciiVvVqmGsU
         Qm/cwDKIGHqHNTkqkeRVgyBVASnxDZeEMQtpv0eBeacAvllvmfylrq/FXilhdGJ64liO
         iWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3RCFlIytfGceLQt7+7ba1r9PORKfxdivEbvE4XMBkkY=;
        b=fAAJIwc+cr46PnKQotNkEEAaucE6I/wWJehJowhXNZgzpyES6gUtukdNh6PA0mp43T
         0P3EXjstaPv7SuGVf+ekStr7jY1omW6koopqcH7CBOlwfL9JHHolTylIKyMXIanTDoSn
         GdrIGtHwLFa22ts0s/z7Md5N9VfUZyK57LZ8wFAAPR6bTY7pyKaLUWTKgNDiQR1mJYTQ
         uu2N22w/Ju5DX7zvlTxjWWBQuJfSXQY5pW400GRE3uRsMm3kgQXEX9Hf99qyGinldQDf
         MXUd9Env0rHan1LoJ7CUZhpSO5pm/++ebj0r9ayxWmddF98ofFY5bnumY64eIRuxfpAq
         Vefw==
X-Gm-Message-State: AN3rC/7LRTTcWm9J+6NMLMrwb/wqU7dgWMJQyxXWgKLksodvRqbPcnaP
        mAj6CjdzoB0jtg==
X-Received: by 10.99.109.75 with SMTP id i72mr30055606pgc.215.1493177150444;
        Tue, 25 Apr 2017 20:25:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id y187sm38722232pfy.67.2017.04.25.20.25.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 20:25:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
References: <20170414203221.43015-1-git@jeffhostetler.com>
        <20170414203221.43015-2-git@jeffhostetler.com>
        <870a8a36-fc6c-6b07-d09e-eec8a9f46a5c@kdbg.org>
        <8bde0b54-c0f6-364d-1f08-ce5207eb6c86@jeffhostetler.com>
        <xmqqk269xmmq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704252225450.3480@virtualbox>
Date:   Tue, 25 Apr 2017 20:25:47 -0700
In-Reply-To: <alpine.DEB.2.20.1704252225450.3480@virtualbox> (Johannes
        Schindelin's message of "Tue, 25 Apr 2017 23:04:33 +0200 (CEST)")
Message-ID: <xmqq60hru9xg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Just in case that certain reviewers favor length over readability, let me
> offer this snippet:
>
> 	size=$(perl -e "print -s \".git/index\"") &&
> 	dd if=/dev/zero of=.git/index bs=1 seek=$(($size-20) count=20

Yup, this does sound like a good direction to go (I think you have
some unbalanced parens but it is sufficient to convey the idea).

> Since whatever hash will be used in the future is most likely larger than
> 20 bytes, this should still work fine (and even if somebody sane replaces
> the SHA-1 of the index with a CRC-32 for the same benefit we have now, the
> test will fail quickly and it is easy to replace the 20 by 4).

True that, too.
