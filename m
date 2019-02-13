Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16161F453
	for <e@80x24.org>; Wed, 13 Feb 2019 17:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393002AbfBMR0T (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 12:26:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34945 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbfBMR0S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 12:26:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so3315922wmt.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 09:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NGRIR9O3w8jNS4uz6mPLe8+TedorC9HIclh0UCnvZ5U=;
        b=Rc/y4EJtXcCgmXg3F3+tvhU6X+IsQusiNzJoEKGxGvWSjuzn+GkXVv8b6E0ATA24OG
         i83kXH9nu4/5OmiDTx0sVrmU5/sHY/56hZiHg4QV3hvu71pHbEA7UXc5UDX9Tdfggf+0
         ZqKyF8y8ihqzpjjhA2vPQHtMdMrbtvOHnlzUC6M/W72vFjXVh1dBcsY+gKrEFy4W8W0a
         oQJEhBVDKe0klQ83hdm3AHGO/NjAuDY7LwK16o3IycXmwxpHt9NQnyU1wOCQT3Wru3uc
         B0IkVBRLDwn/t+UHFZuVPgus2+xTJwtlnRSzEVPgBbmbdg3BQvIOhKffAgNDO2JrGlGe
         //zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NGRIR9O3w8jNS4uz6mPLe8+TedorC9HIclh0UCnvZ5U=;
        b=IsEBQUQ8EBuaPb2vrj0bMcGIberSBFxl6H7IHxW5VkD/mCebF2StiwYsu3CJzYQXmb
         SBHzNF3nrH4I5aUUdCqX4zWaPlgM0dazaquiQF5uixa/c1c3vF0pwlNBvG5WgUqywR6g
         Q6F8glFDnlmMHT0DDdiWsHKJcgL1C/bBfAc7tinvEuH+3vtV1Hh3XRCgn5esRmyF5yXV
         ub1PhcfwWb7xVx7cFReSBtXjqfK2q+13SflGa9kVJPqVJItjqX3AnnqxcYuF4kOmPn+v
         TDvCljee2kIe3vV3qe2mioQNwyowlCm/mkbaIgbbAsMGXAvo9ypRFf1yWag/a1K4Dh85
         UP0w==
X-Gm-Message-State: AHQUAub9ynG4I4+MNZEQgsGHt+1O1CKsgCge/3EU+79vXs/ALFxLZ+WV
        WJppo2KGs18XwdWzQoiyj/ragCRo
X-Google-Smtp-Source: AHgI3Iahb5VB3nWXlXCxm5yAuJRzdhoZwuViU53i+OZ1XJbfiitfbNVWVg+YefU6zYKlxOiQ8KEAaw==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr1246173wmh.76.1550078776040;
        Wed, 13 Feb 2019 09:26:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o2sm9921361wmo.33.2019.02.13.09.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:26:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        randall.s.becker@rogers.com, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [Patch v1 3/3] t5562: replace /dev/zero with a pipe from generate_zero_bytes
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
        <20190209185930.5256-4-randall.s.becker@rogers.com>
        <CAPig+cQY57w9rmGzVifKMTMVwt209b959iL9+K79AMfEgiVTfg@mail.gmail.com>
        <xmqqd0nwex7w.fsf@gitster-ct.c.googlers.com>
        <f3b506bb-52eb-3a1f-ba3d-0cf327271ab2@kdbg.org>
Date:   Wed, 13 Feb 2019 09:26:14 -0800
In-Reply-To: <f3b506bb-52eb-3a1f-ba3d-0cf327271ab2@kdbg.org> (Johannes Sixt's
        message of "Tue, 12 Feb 2019 21:50:59 +0100")
Message-ID: <xmqqd0nvd2h5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.02.19 um 18:24 schrieb Junio C Hamano:
>>>> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
>>>> @@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
>>>>  test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
>>>>         NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
>>>> -       env \
>>>> +       generate_zero_bytes infinity  | env \
>>>>                 CONTENT_TYPE=application/x-git-upload-pack-request \
>>>>                 QUERY_STRING=/repo.git/git-upload-pack \
>>>>                 PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
>>>>                 GIT_HTTP_EXPORT_ALL=TRUE \
>>>>                 REQUEST_METHOD=POST \
>>>>                 CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
>>>> -               git http-backend </dev/zero >/dev/null 2>err &&
>>>> +               git http-backend >/dev/null 2>err &&
>> 
>> Doesn't this "inifinity" mode have the same issue that was worked
>> around by 6129c930 ("test-lib: limit the output of the yes utility",
>> 2016-02-02) on Windows?  If I read correctly, the process upstream
>> of the pipe (in this case, perl producing a stream of infinite NULs)
>> would not die when the downstream stops reading with SIGPIPE.
>
> I think we do not have to worry, and the reason is that the
> justification for 6129c930 is simply wrong.

That's kinda surprising but in a pleasant way---it's good that we
have one less thing we need to worry about.

Thanks.

>
> As I did not find the patch series discussed here to pull and test, I
> repeated the timing tests with t7610-mergetool.sh with and without
> 6129c930 reverted, and the difference is only in the noise. The reason
> t7610 takes so long on Windows looks more like a consequence of the
> 10,000 processes that it spawns. It is a mystery to me how I came to the
> conclusion that the change in 6129c930 would make a difference. :-(
>
> -- Hannes
