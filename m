Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E640320379
	for <e@80x24.org>; Mon, 22 Apr 2019 06:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfDVGZm (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 02:25:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43765 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGZl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 02:25:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so14668991wrx.10
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 23:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FDsNhPqLwPqJ6NTRs59+sPzC0rXI27TOQcZcIHQlp94=;
        b=tbnpbmzDkzOg1URvPK1yUqRiEknKgePyayH/kqEpEreKvzuPVKtTPLvRI2y870siHa
         vMPf44znJTTfn/AwqTo8bOXmQjkb5Cddu1hHIsoTpYEk/uVLtc8n6AGzqhp6AY9SKw0g
         7eLRKgl7/vHuUwnQy1Uo7RbN8qz738RVEq5JDQ78VcY5dy19jxf3VGZ8zFU5LQ8p+Jb4
         wUQ8CxPURy/TXTgbro3atYoxX67fqxoYiF3r1nLHpwpUIUSyOw85yvoDohJpotGKY3dO
         Zy717waWSC0e/bhBymsBSDV8OSKqqfDAlCghHs1p9LvYHxJsTFZE+Myie1x1tNL2Kzn7
         A04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FDsNhPqLwPqJ6NTRs59+sPzC0rXI27TOQcZcIHQlp94=;
        b=V5oY0v5Bm7S8nTJuUJKd4NOs69H9vuQPsdMaIHuv69Q8JYyBZYpPqdlTYvJre6Y37r
         0c9F7pbuH6/v360DcExwR4g0O4fN41KJKy21WgCDSMAcuB3OA7d+nAMBgasSugdBeWTi
         jWhXolvGSfs8irXovCKmbnK7A9jqvU0SpuTJJAFGt/oBbwe8WTtruqfgEXsvKS7sL+03
         54Y/YCQUjJZCol0rTQmjY2BJQNmP+UUgGvR/E4MT+r9E1NyyuLZa3/4q2TxvrgoNNTsN
         LpuK3JVZ2KTqNJ93muRVhgxkmcJFfjTA6XbwGzBiyw+8HURTWjxouhDNtmr6SfUlmTX4
         IrVw==
X-Gm-Message-State: APjAAAUSzH02CV7m2ir634ZDteCPnfWQ80vNK9C68d1qxxdPge6M0BCE
        kAj/GJWQEi7xAoKoE4T8xzg=
X-Google-Smtp-Source: APXvYqzHDBs3DA5hiYVKW6Qg+QUrUqAAeAl1pnjlra9Szn5kTtUtP/xeiY6LsotF4lXPvPTIzh5cCw==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr11746581wrn.43.1555914339885;
        Sun, 21 Apr 2019 23:25:39 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h9sm9296332wmb.5.2019.04.21.23.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 23:25:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5516: fix mismerge in 'next'
References: <20190422044812.GA28493@sigill.intra.peff.net>
Date:   Mon, 22 Apr 2019 15:25:38 +0900
In-Reply-To: <20190422044812.GA28493@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Apr 2019 00:48:12 -0400")
Message-ID: <xmqq4l6q8skd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The merge of jk/fetch-reachability-error-fix conflicts with
> jt/test-protocol-version, but the conflict resolution done by
> b4ce8375c018 has a typo (looks like an editor mistake):
> ...

Indeed it was.  Thanks for spotting.

> The same problem is present in the merges to pu, which is not surprising
> since the 'next' merge was probably just resolved by rerere.

Yup, here is what I did:

    $ git checkout b4ce8375c018
    $ git am jk-t5516-fix.patch
    $ CG=$(git describe)
    $ git reset --hard b4ce8375c018^
    $ git merge jk/fetch-reachability-error-fix
    $ git rerere forget t/t5516-fetch-push.sh
    $ git diff $CG ;# shows the typo
    $ git checkout $CG t/t5516-fetch-push.sh
    # I should learn to use 'git restore' one of these days.
    $ git diff ;# shows --cc
    $ git rerere
    $ git reset --hard
    $ git merge jk/fetch-reachability-error-fix
    $ git diff $CG ;# shows no difference

That should teach rerere about the right resolution.  And to carry
the fix in 'next':

    $ git checkout next
    $ git am -s3 jk-t5516-fix.patch

Thanks.
