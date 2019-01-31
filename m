Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5451C1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 18:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfAaSMO (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 13:12:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37041 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaSMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 13:12:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so4385230wrt.4
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 10:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+fARrME1I4VVBzrJojwkywx3qNyj4OByjX2ABMJ15I8=;
        b=q0iTyj7CDI1AxwooYbna7G9EAlLAUvp/KiwEITaD9cHALIOED1HpE7G/D2YoC7DXte
         ygapUnTdu3XEGM8qlhAzscRKH5CQKBDh7IKrA8FtFcPwlNbRYRn1k26EAgQU8teWUkVl
         PrBv5A50xPkCYwh4hy/fldbRWyHlXe+IIMB4J8qCYLPEE6UKC2XwpCBDKOAYyw+ZUwuY
         6J/m8CdQBg2lgZzEU1F3YWyuUT6gInQxVNSgYlWDZFtK+wzDnU8Sw2h7mFkqGpQT3CcE
         U7C+fQUlMDQYYHxyheQJNlSLqf2Gsk73XB2jLedGVBnSsnunrBskGc8cXg63MVPH0w37
         I9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+fARrME1I4VVBzrJojwkywx3qNyj4OByjX2ABMJ15I8=;
        b=HwLLUX5CVJN9sjqaC2is9CQgxjVhVQt1ZIsAr2gQfRzE2hp2G9Y7PuVrEmmUdEF00/
         c+x4CMctFj1YC5gkZHdO2cNeW6bk8XJwBDJZ6M0XSiaZeRx9OZgsGR/RTg9TnMJFMfAW
         8JiWNK0lJ1Fot42Zq6ky6QqyShmj+yJ47Zk/yN60H1KHKiwplDFhfSsy2Jzz4olM20l7
         2wrgOmh25Bb7VVYzMWdEEB2XbEsBF968ajgn1nmvlmgQa7aS6EUdetNM9R2g1i1BLp+5
         jUjYx4lqTHHrP0C9Gln6HTcO5Zt4h5dhdO1rK017kTaE/SRWhP6beqoUFDBBSSJDuqMF
         2NFA==
X-Gm-Message-State: AJcUukehEHdFDAH1JRLaMqs0Sv3o+9WY81s3rsul5YR5zFjIC8OXvXIy
        kODQldS218PdBGrMRnliAvk=
X-Google-Smtp-Source: ALg8bN62xI2Hf+pfe6mWTrqw5sCFUSuTUoaNoWI3QhbG0OwLwdhYEcj49syEkHyyh+0sE3GepGmZ/w==
X-Received: by 2002:adf:8143:: with SMTP id 61mr34238106wrm.47.1548958331584;
        Thu, 31 Jan 2019 10:12:11 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u204sm6826395wmu.30.2019.01.31.10.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:12:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: t5702 failing under ASan on master
References: <20190130085855.GA24387@genre.crustytoothpaste.net>
        <CACsJy8AVoETLkB5rLft27Rz7V9xPFN9fk=8g9-fCR61fVi4vjw@mail.gmail.com>
        <20190130114016.GD24387@genre.crustytoothpaste.net>
Date:   Thu, 31 Jan 2019 10:12:10 -0800
In-Reply-To: <20190130114016.GD24387@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 30 Jan 2019 11:40:16 +0000")
Message-ID: <xmqqsgx83ddx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Jan 30, 2019 at 05:07:20PM +0700, Duy Nguyen wrote:
>> If I understand ASan report correctly alternate_shallow_file memory is
>> already gone after the first fetch, when we update the shallow file.
>> But we're doing two fetches in the same process (the tag backfill
>> thingy), the second fetch reuses the dangling alternate_shallow_file
>> pointer and ASan caught it. Resetting the variable seems like the
>> right way to go.
>
> Ah, I think I was missing the fact that we're doing a tag backfill. That
> explains a lot.
>
>> But should we reset it to an empty string? We would pass
>> "--shallow-file=" to "git index-pack", which is treated as "no shallow
>> file" (i.e. complete repo). This sounds wrong because this is still a
>> shallow repository.
>> 
>> I suppose setting alternate_shallow_file to NULL would be ok. "git
>> index-pack" will just go back to reading $GIT_DIR/info/shallow, which
>> has been updated and contains correct info.
>
> Yeah, that sounds like a better choice. I'll send a complete patch which
> does this.

Thanks, both.
