Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B94B1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfBKVHT (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 16:07:19 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44856 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBKVHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 16:07:18 -0500
Received: by mail-wr1-f44.google.com with SMTP id v16so304035wrn.11
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 13:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9xy1cEdRfwdyXheMuqXSvD8aMpkTj4uc4QailjKQbfs=;
        b=ZKsi56dMqDObup3hqI4GCHEG4gMyHchzo466KEAkwn2HWV0dtWDBBy9ovU0i3GQcoC
         yo3FoXzJkDm6ZB25smevaedMrswk9wQvhXvrG9GERIUNK+mLOWikc1f8z8g+jGMMh+Pf
         VALat+3xDwb1UBXbz/j/FSVNp0lkZ95SN6/ex2ism0F2AqzYjhpsASFvpiAy72p6tTvK
         R/9MxevHQQKNpLTu2P17f7iobeE9xxwuHuUlpxmQLnn7qZ6n6w+QzInl2UjmBdQoNkWK
         QNPJRS/XRmSZYGGDOyeOke2r9H4Ku01HSrxOwyRlm2hMHcSF7f0XON7Iszru7EnGoUSt
         NejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9xy1cEdRfwdyXheMuqXSvD8aMpkTj4uc4QailjKQbfs=;
        b=oNuM3hpeyjZFso6hqh+7ggn2kRuv33XbnBdV2Y2Taw2iyK5Z+c0rgPcBtK/32UQmgs
         v18CllbFcLCVl2MxxKb1Adpt8+Ox6rU1X4Yo11Cf412BMbboMgrEgviXglKLpkrv33Ki
         osHOI+omCpMifyBXptXCSjkW7xBr7BNb8fLaPOSSzQs1Y81EIGOJv2gOB+dVTmVd2nW4
         OxEcXC6A94plAz7Z1irhMgOR9b+YJOYJEI53ZsbOb+b00K30sGXJLA8ia609xUOgqTeU
         Y/5QuRBuCOJ2pfTxO9iaxv3/ytRvaHf47YIbeU8cOPCvu2NvEoNc+jDXym34VMKnGISJ
         Hfyw==
X-Gm-Message-State: AHQUAubE3RRahHxZKipOxpw3ksTDavGhot8eN6v5bSP2fjZopekggqru
        Zqs/UNrhP5t7Nk1bqBvX4/o=
X-Google-Smtp-Source: AHgI3IZZ/Jy4LNSyXySLDlGUAZi3e2pqdq8cO1SFtWWd8rRR917c5g0Im5J06Hef09pOSnwPlToemQ==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr168946wrx.110.1549919236607;
        Mon, 11 Feb 2019 13:07:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f187sm663379wma.4.2019.02.11.13.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 13:07:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
References: <000801d4c174$05b76860$11263920$@nexbridge.com>
        <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
Date:   Mon, 11 Feb 2019 13:07:15 -0800
In-Reply-To: <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 11 Feb 2019 16:56:33 +0700")
Message-ID: <xmqqftsughks.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Feb 11, 2019 at 2:09 AM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
>>
>> Hi All,
>>
>> I tracked down a breakage in t1404 subtest 52. The line
>>
>> test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err
>
> The message does not match, does it? Here we grep for "File exists"
> but the message you showed says "File already exists".

Hmph, this is from strerror(), right?

The question is if we should be using grep to match on strerror()
result in the C locale.  Do we really care that the reason of the
failure is due to EEXIST for this particular test?

>> The verbose output, with diagnostics, is:
>>
>> error: 'grep Unable to create '.*packed-refs.lock': File exists err' didn't
>> find a match in:
>> error: Unable to create '/home/git/git/t/trash
>> directory.t1404-update-ref-errors/.git/packed-refs.lock': File already
>> exists.

Otherwise, perhaps we should loosen the grep pattern, not as a part
of "NonStop fix" topic, but as "tests should not depend on having a
canonical spelling of strerror() result even in C locale" topic.
