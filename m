Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CCF1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 23:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfACXFj (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 18:05:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55674 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfACXFj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 18:05:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so30426491wmc.5
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 15:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QYrlAneICyM1SeKLVc4LU2leRpvijVJrI1fvUByDHF0=;
        b=YL8CBldGRZYMxYrJxaQ6R7KgI17PEP2BTVNS78y+lU3iWJRjYxxcGgpqo0MJhHdxZu
         IwU6m8Rr+XFIV1YuFfoo+ACGD68UBINM9axDXjfnvFNoTRSOBdJDlLJoCh0yaHfp/c4n
         H4mX6VcB5DfngPWVoNWkZkMdAprDlLl6s2FAgSL33/CqQgR3kCvkkx/WFeA7h3QXwWR/
         8YEVaWHt8YAtnKL7fimW/QzTl63mUdrEgleDDu3MkrQ4NgLqofxOtmvEpn0lkRx/Qhwt
         2jerAsqhTVyKKx46bk8aoaifKuBNnrVhJuRCJxW67B6q9rIk+KjsG5O5nvX7p3oG4h91
         TYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QYrlAneICyM1SeKLVc4LU2leRpvijVJrI1fvUByDHF0=;
        b=YdxSrfyrIzuYwJ5dWn5ExQv8OCdQ4kZYwW94rpkYqCK/2REJNXb+5T4rVoLuCb5hFf
         AlH/pgaBB83aXcxXeSlNmBezPQtQmgnF4Hua0FewylLk1LtX3xO+oeWOTXFM8P6GPygE
         IPumLjq2x36E+gcT8YgtLNtP2LZqlxr9Et4vDGvuQqgFkol+DZth6Z++CJhnMw2bl2JF
         jIGB8Bb02TyJM6o2qU0u2h75qx5pHOnrab/8ssM71QHQwuJKLrogqxxc12f5hLJIsFOW
         h1594B/xOf2q/7GuMwzhYzqTHv3YA82dWiHHS3fagl++2Xj+GkUap2x/KOTWTCwkumWg
         rqmA==
X-Gm-Message-State: AA+aEWYrsoleksqT2DeXPGNNCB7Ev6nBfmK7Rp7KR5TnhTPIKivfPZXZ
        f1ToXyt6hgwbkZnDbln+SZI=
X-Google-Smtp-Source: ALg8bN7CjP/m/7CzOlKxUcjSpQ0hgBwCp+9CYJsWdEeI9oMo72lopx1gI/3bNXktyTnrovoiUxoGNg==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr38951164wmf.22.1546556737112;
        Thu, 03 Jan 2019 15:05:37 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k135sm67890354wmd.42.2019.01.03.15.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:05:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, steadmon@google.com
Subject: Re: [PATCH v2 0/2] Accept error packets in any context
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com>
        <20181229211915.161686-1-masayasuzuki@google.com>
Date:   Thu, 03 Jan 2019 15:05:35 -0800
In-Reply-To: <20181229211915.161686-1-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Sat, 29 Dec 2018 13:19:13 -0800")
Message-ID: <xmqqef9tfikg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> This makes it possible for servers to send an error message back to clients in
> an arbitrary situation.
>
> The first patch was originally sent in [1]. This version includes some fix.
>
> The second patch was originally sent in [2]. Later, this was cherry-picked in
> [3]. In the discussion in [3], we agreed that this error packet handling should
> be done only against the Git pack protocol handling code. With this agreement,
> the patch series sent in [3] is abandoned (according to [4]). This is a patch
> series based on that agreement on limiting the error packet handling.

In short, are you shooting js/smart-http-detect-remote-error topic
down and replacing it with this one?

As that topic is not yet in 'next', I am perfectly fine doing that.
I just want to make sure that is what you meant, as my reading of
[4] was a bit fuzzy.

Thanks.

>
> [1]: https://public-inbox.org/git/20181227065210.60817-1-masayasuzuki@google.com/
> [2]: https://public-inbox.org/git/20181127045301.103807-1-masayasuzuki@google.com/
> [3]: https://public-inbox.org/git/df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com/
> [4]: https://public-inbox.org/git/20181213221826.GE37614@google.com/
>
> Masaya Suzuki (2):
>   Use packet_reader instead of packet_read_line
>   pack-protocol.txt: accept error packets in any context

