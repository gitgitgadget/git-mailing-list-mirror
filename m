Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CCC20248
	for <e@80x24.org>; Mon, 11 Mar 2019 01:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfCKByv (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 21:54:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46359 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfCKByv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 21:54:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id i16so3249366wrs.13
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 18:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x+0bTczwCql6JtW1SEuuONhJ/sHxGX8zsXpYIgahZcA=;
        b=Be9s3nNj7WaUXyW9ZShCH/Yua2gZ1alb5VFdBBAavTLakLyeGK2o8LFtFazn3fqLl/
         /c41KlsZxCMkZcE+uozwVs3z73CP98oGLT0hhe9LSPe+ME0jSB2fR8sKbG//m+lwif55
         OocfVwIwQhdLENkF7IRqy96oveuLeCxf50KXnl8PJZlE46BUybK1B+EgXcDogX4bV4t9
         1j6LoU3gs3fjSmbZfzxBA8AMxLagq4Kz49i5y8Nup7qNwkNiqfPzr5eHZ0703j8BpctT
         t9Wj6DiAWWWYIE2rVJ8w/QbIUXx59ifxlHQloKJr91lJTUM0MIwOYFBA+0l3aK0jNIFG
         vm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x+0bTczwCql6JtW1SEuuONhJ/sHxGX8zsXpYIgahZcA=;
        b=T2ZtgUd7Nrf4clKlGZh8EtvhtzD6vl9rrnMrSPnUpvSsmDnM6Ho+AOfxdyGauG9GxH
         e5HQbhiXNIiwWt3iIqYlG3whUoWEZ8YTwP1C3gX5YxoXxaucZ2NuNoXAoIo/28D71HdT
         XpQTy3dTk35oblu2Wj9mH349PW6ht/Tj90pHzJkkkgQPkGFnqA46aJn95XUPWxKTOAAe
         JZgOtoUfUtCkzrXPnOTnNULRpdJwoxlFCIIYQUxbPTEwxGXepl/hCH9s2DoLYxyfoJM0
         JFXSRaO1vbDqh0CKkTL8DCm9M2v92FGHqvClsdlniCJAFgIVyBi46LR5pH0FODeg5fXj
         x0aA==
X-Gm-Message-State: APjAAAXkTAOnvzawnl9trHcsgCtJqkJj5Hnb8sSfMZZjcEdXfvUbtO67
        pDh1aRz4gNydnD7gjU+4tEo=
X-Google-Smtp-Source: APXvYqxD4K0V5aaSBxmROBPbdwe7q8AyhaVvSAl6Ar8q5N5RnFhmdASZ15AIef3pcfYplTfx9U3QxA==
X-Received: by 2002:a5d:4a05:: with SMTP id m5mr19343215wrq.46.1552269289515;
        Sun, 10 Mar 2019 18:54:49 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v2sm23875024wme.29.2019.03.10.18.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 18:54:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v2 3/3] t3600: use helpers to replace test -d/f/e/s <path>
References: <CAPig+cR3b=jk4W=9SF4XJQyqAfFHiG8MduypD75RL1=T_qY0Hg@mail.gmail.com>
        <20190305142149.13671-1-rohit.ashiwal265@gmail.com>
        <CAPig+cT_YT-1=ymAYiTpjgRQEe8906Y6yyBU=XuP_wbw+ixxiQ@mail.gmail.com>
        <xmqq7edancws.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQFMNFTMfMz5EnMZxnXGLWnKYZ5_=D3eiNsX24hdZSPRw@mail.gmail.com>
Date:   Mon, 11 Mar 2019 10:54:48 +0900
In-Reply-To: <CAPig+cQFMNFTMfMz5EnMZxnXGLWnKYZ5_=D3eiNsX24hdZSPRw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 8 Mar 2019 04:51:59 -0500")
Message-ID: <xmqqa7i2mazb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 8, 2019 at 12:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>> An unrelated tangent, but what do you think of this patch?  In the
>> context of testing "git rm", if foo is a dangling symbolic link,
>> "git rm foo && test_path_is_missing foo" would need something like
>> this to work correctly, I would think.
>>
>>  test_path_is_missing () {
>> -       if test -e "$1"
>> +       if test -e "$1" || test -L "$1"
>>         then
>>                 echo "Path exists:"
>>                 ls -ld "$1"
>
> Makes sense. Won't we also want:
>
>     test_path_exists () {
>     -    if ! test -e "$1"
>     +   if ! test -e "$1" && ! test -L "$1"
>        then
>             echo "Path $1 doesn't exist. $2"
>
> or something like that?

That would make them symmetric, but what I was driving at with "In
the context of testing git rm" was that I highly suspect that among
other existing users of test_path_is_missing there are some that
want to consider a dangling symbolic link as if it is not there (and
vice versa for test_path_exists), and it may not be a good idea to
unconditionally declare that, unlike the underlying "test" command
that dereferences symlinks for most operations, our wrapper does not
dereference symbolic links, which is what the "what do you think?"
patch and your addtion do.


