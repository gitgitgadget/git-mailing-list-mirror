Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D5E1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 23:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfAJXGp (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 18:06:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfAJXGp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 18:06:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so641048wmd.0
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 15:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JfwNQRG2JcqbMgEKF5VGSrvhpD4y3cK8+d3W8zC4H8A=;
        b=gnI9hgdFAKYqefLJfcpNwzXwJTctjVFqywWsiEfjlOyoio/zXJMYSaEFe/1O3OJSEF
         aIMVBQAKI+Y0S4/y7qOeyXHYsfaQ/fQw6PKBEpt7hOMCMuD1Kol5t+WC/ruwX/40C6KL
         5bibsy20cO+tliiiSNpVkWLqKRjI1JdwUCs64EjGtTpPvXrbFgJdIUMBkbqPiN9MOJOK
         A1R8E7AxQNj3VrW1B42UyqaYHx4LtIDweYmpnDAYfMiEGLrCk9cVzcY2G17fElijqaMV
         8XpFHIt5yw0MIEmW2bq+HItkD2pCtXjjFf+PVImIxWAWfeMGwwct0lZNlf6Ga7Zr3KY/
         Vdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JfwNQRG2JcqbMgEKF5VGSrvhpD4y3cK8+d3W8zC4H8A=;
        b=LTdeHap47xNDWUlBoMERnW7u2b6jiTBdT5sJcmm0lew/rQpbmHYpPYX6kqDX4ihDWE
         K6TSzhT+K7xa0tz9OszSTldmtxRkm8HiNvhXN4xTvS440yiVe+cROljcMJtes3+PLNa7
         JyfUPf8QN40zTvkPr1B3S5RgqUAFo1sDtRUzi8Zwp/dGE+Z3H6CxmKkCbZaPz4fCVGjm
         s1dgCQixNLYge4xio9KMDgP3v6zFZMpL3nG9aoES+BemVCZtfbzfrCoG1M4uYqcGzaKJ
         8prdNLbbSOqNnKWFlDMt0mojDSj1Zwn1L94dAhLbrqelt2Ym6gV/x0YTSWrrh0JVNBCn
         nI7A==
X-Gm-Message-State: AJcUukdQrHy9ZrYI+8dVdfJ2ljFT2hUdu5Sc5lcdDaecNihAI8mTTOTm
        98Lfho4VmtT3o9nlDLKz3A8=
X-Google-Smtp-Source: ALg8bN7sA/gPHgUMqG9rh8nDCL10pDle7bU2MCDiLi9rM3sr3jq36LJMGz9QktDBX0H9ytEV9/Ta3Q==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr53083wme.41.1547161602651;
        Thu, 10 Jan 2019 15:06:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s3sm14724422wmj.23.2019.01.10.15.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 15:06:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/5] Show HTTP headers of failed requests with GIT_CURL_VERBOSE
References: <20190108024741.62176-1-masayasuzuki@google.com>
        <20190110193350.213327-1-masayasuzuki@google.com>
Date:   Thu, 10 Jan 2019 15:06:41 -0800
In-Reply-To: <20190110193350.213327-1-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Thu, 10 Jan 2019 11:33:45 -0800")
Message-ID: <xmqqpnt4yuwu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> Diff from v3[1]:
>
> *   Handle ftruncate and fflush return values
> *   Call rewind to set the position back
>
> [1]: https://public-inbox.org/git/20190108024741.62176-1-masayasuzuki@google.com/

Thanks.  Adding the error checking even to 1/5 and moving the
updated code in 2/5 makes the range-diff a bit noisy, but the
resulting series makes lot of sense.

Will queue.

>
> Masaya Suzuki (5):
>   http: support file handles for HTTP_KEEP_ERROR
>   http: enable keep_error for HTTP requests
>   remote-curl: define struct for CURLOPT_WRITEFUNCTION
>   remote-curl: unset CURLOPT_FAILONERROR
>   test: test GIT_CURL_VERBOSE=1 shows an error
>
>  http.c                       | 32 +++++++++++++++++++-------------
>  http.h                       |  1 -
>  remote-curl.c                | 29 ++++++++++++++++++++++++-----
>  t/lib-httpd/apache.conf      |  1 +
>  t/t5581-http-curl-verbose.sh | 28 ++++++++++++++++++++++++++++
>  5 files changed, 72 insertions(+), 19 deletions(-)
>  create mode 100755 t/t5581-http-curl-verbose.sh
