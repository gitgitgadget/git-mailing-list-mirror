Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C75C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4447B2187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYmFxh8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgBNOjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:39:53 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33750 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgBNOjx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:39:53 -0500
Received: by mail-qk1-f170.google.com with SMTP id h4so9421406qkm.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Uxcu0BXtRrBMT0hU/0QHVv9EvWIqt1/a3WMqm04Obqg=;
        b=NYmFxh8pRMA1tYZ7QjWr1o9ZJvM/EEeB42DSp/Cei3AoKUD5nGU3F5Hj4jtZD5X2Gh
         i0KI+j1HjrBNusuaUq+C7L3Z2yz8WMEYQpFQJTdJT59UWc94B4f+MnOG44fGs8auZhtx
         0d9CocFniseFNKpaFIMZwM3rC9XibCVXI4XUCyYlif5DZQcUtwYxM9MHuB7azobUn89g
         2XBXrdhLwbpzlhU1OMRncA0pxymnnM1hp/zsm2xbrbPzaWp3LIMitgupwuA8DKkV3C7t
         c+6TFKuvpKJ3CY3Q9ieMo5Qs+zgXxwkfYeaIndDMkI/db804mwZBgkbOFHHs5g9aZMXi
         xvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Uxcu0BXtRrBMT0hU/0QHVv9EvWIqt1/a3WMqm04Obqg=;
        b=oU7ZVEHrm1ccoDaye4svofVbZCOp0VMBTWKGHKYpjKmIDaJypVal8+CLClyiM6Y6f/
         9pm9924Sj/59ET7GJ2SiIQtOSLTwribD/GFRRILJXaf67Biqcz0crrnLcj3wp6WG9CH7
         RfDYMWHgEHWon7TwWnTJWwaGVX7wAzPCUu6X43X1uurEOcCY0LRMfqbtG4oyaRy0FXzw
         7CmluQohUSkVO4KLlcvM+0OoZcoAlmAwjMeUT9uMEVozLPJU38ubIS0foP1BBpSbKzIe
         DPQiL14WBoPJq0U39EfjdF5SgTjTCQhelLipRcVjn2bF1pRXGkoU1D7MmNKPbrObI7Bk
         v+KA==
X-Gm-Message-State: APjAAAV0qzQDD6bZN3YpJ0tqmn92fpWUu9VzCldvAEyqxC9jCOnVcWHw
        ckqDaN+eyUgdTmls4n6tYi7ljRokWdOE9Q==
X-Google-Smtp-Source: APXvYqx4ov3NakPiW1OK8HeFg/Ur8+ajtjY2bJEUfKGOcpr/JNScWF6nK2ng5tiqfhXuR8Aiw/OASQ==
X-Received: by 2002:a37:9a4d:: with SMTP id c74mr2876903qke.18.1581691191991;
        Fri, 14 Feb 2020 06:39:51 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id 11sm3245498qko.76.2020.02.14.06.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 06:39:51 -0800 (PST)
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03; Wed,
 12)
To:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
 <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
 <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
 <xmqqtv3tpzto.fsf@gitster-ct.c.googlers.com>
 <20200214051505.GA16130@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <7fc48fbe-4cf4-7a0a-22f6-eac9692abc9b@gmail.com>
Date:   Fri, 14 Feb 2020 09:39:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214051505.GA16130@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/14/2020 12:15 AM, Denton Liu wrote:
> This change comes from 'git-p4: restructure code in submit' in
> 'bk/p4-pre-edit-changelist' which introduced the use of the `<>`
> operator. In Python 2, this is valid but in Python 3, it was removed.
>
> We can simply replace the `<>` with `!=` which is the new way of
> writing "not equals".
Absolutely. I'm committing the change now.
