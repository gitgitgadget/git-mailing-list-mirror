Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD5620248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCRGgA (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:36:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46740 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRGgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:36:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id 33so15652033wrb.13
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IYqdtk/n09dM/pKhUo5nmUrdeCx8xUb91URbhDrBAsA=;
        b=ei46H3GQG7vubmMW5zx7wLzA250BnCfUwr9SRbXbRPvyS9Nsej8579LTsbauYnFAO9
         FWpJTfGR4b+cs/+emNd7pdSkOUvQl1Q4sD/UG2DBgTvCAXXZny2N/D+MtzjxoC5NgVMY
         aQn1C0sP1fFU74LfdK/H+0lEnYmp0tCe7X5Wn4uZ282sc/vhz59LLdC3vjsalf18ds/i
         uNIjzN8f//J0UmtamhOEuZXo46Q25irUXKEbSLG++yR2oSpJTqPruS+h1oWC6AVsAjIK
         Ik0tOFATjJLd94UFiFrw9CTo7oOz4kmnwLoYO/yKFJszBsXVWeW9Ow/5uYirEC0zqAw7
         a/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IYqdtk/n09dM/pKhUo5nmUrdeCx8xUb91URbhDrBAsA=;
        b=WxtBOAHKpfsRvPVv0cye1wsdXL7CLG4CMjTlsCIDxQ52pZGlgCpiaBFhG62JkBRRe7
         DmQ7SQdysrnD+0R+8g3SyCGTgxvsqJGViIqTAsCIsaCnqEKAhP8ga/iYe1oppy9tnOgz
         ktQpsXnZWKZ7YIp3FX/VC3rKHoVjI5t6u3viPLZQCjjFiKHWwrDYrqblor5GQTGvmhGP
         EwePlk+aqg+TqLwwuOSg+E13F812/Xj914lJcrQgtToiTXHnOFUbV6ulGNtaJJABHf5X
         FLwUCvivDiv+T11bG8tcFclF1FD22REFVZ4k8bkG7j93MkKi9/Gx9GEkT0SYEkQqK/nW
         2k4w==
X-Gm-Message-State: APjAAAXaHePs+UWpvBaUqN77MYHy4mbTMcgebEbWMrFbxQ+cV3KeunMn
        82dIf2YSZXaKGpC0rXyzq00=
X-Google-Smtp-Source: APXvYqzgSpXGYnzORgYXJZp/c8d4RATRD28NZaETQVXK0YbktxNUkUpFYXvoASIkC2tZvpDcQRX8IQ==
X-Received: by 2002:adf:82c9:: with SMTP id 67mr2747213wrc.261.1552890958012;
        Sun, 17 Mar 2019 23:35:58 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c21sm12897944wre.35.2019.03.17.23.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:35:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 00/11] Fix scissors bug during conflict
References: <cover.1552275703.git.liu.denton@gmail.com>
        <cover.1552817044.git.liu.denton@gmail.com>
        <20190317130539.GA23160@szeder.dev>
Date:   Mon, 18 Mar 2019 15:35:56 +0900
In-Reply-To: <20190317130539.GA23160@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sun, 17 Mar 2019 14:05:39 +0100")
Message-ID: <xmqqa7hs3d0z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +	git commit ${3+"$3"} -m "$2" >act &&
>> +	head -1 <act >tmp &&
>> +	mv tmp act &&
>
> Here you could swap the order of when you write to 'act' and 'tmp',
> and thus make the 'mv' unnecessary, like this:
>
>   git commit [...] >tmp &&
>   head -1 act >tmp &&
>   [...rest of the test...]
>
> Note also that 'head' (or 'sed' in later tests) can open its input
> file on its own, there's no need to redirect its standard input.

Yup, that is better with a slight fix

	git testing-output-from-this-command ... >tmp &&
	head -n 1 tmp >actual &&

to actually read from the output kept in the temporary file.

Especially I think bare -<num> is a BSDism that has been
removed from POSIX some time ago.
