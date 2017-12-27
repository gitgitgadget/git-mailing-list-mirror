Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860471F404
	for <e@80x24.org>; Wed, 27 Dec 2017 23:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbdL0XyE (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 18:54:04 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:42416 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbdL0XyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 18:54:03 -0500
Received: by mail-wm0-f53.google.com with SMTP id b199so41778503wme.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 15:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/qpEEzwBa+3WTyRfTt3nqWykKUIuenXEXogNYgZAFLs=;
        b=lJc0aDoXhRDgTDG8psz7R/rhZpg5OLpq8Bn8Y8Wl7HohBxzGzM5ioC3X7cfTurdcK4
         dnXwXczUFOMwMrtocOk1kL1jhSDBteaiXIt3cwsXBn5iuYICriFbCwEOd/2TSvDisoq3
         YroEs/Yba3MTIXGhh1r8wEvRin4SrGJ7r1chcWde6GfA7Pn5qJ4GnBOidINSOi6d7fR4
         y7LtysF+s2o8roW10uEcu9dgjCCE/mUwTqK1qTFccv+iFwukeVAT7oiWVqtSzZOiuGpI
         QRjvWbHj9temGdvH99zf5sgq1nEb+tQRaq1lHzIzAd2MkV+uiUfcdhzcqPKKDwJ7jZrO
         H61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/qpEEzwBa+3WTyRfTt3nqWykKUIuenXEXogNYgZAFLs=;
        b=hIG5KnXsmzmSqpJk02HoBIiryScaeSOTQCswEdPqWfnVzaTrrsgs8KTx+wwyzsKwy1
         zBwzC41MNe1s8KWZYuCOC9eImqJMcRgNkuSshAcjrxqpag2dOrKo2kiYY2Mm6Uv5IFmL
         HrerxVKYICnmgU0GJlhldYVALlTPvZrK/scTs4PuI2s2dSazLYjLhZIb8K2MbH+ECW3m
         hgFwW8uxu1woQGA6H9MBTEqi95TzQIP/JsuvKzUUOqRukKKLbTn8YR0n9gHLWRRmfk8D
         69zpQqeT6PUTesbQO3K78mSM5HRO614yrQymNLHHpwzk9YeIrycs34NIOvIRK2d5+p49
         xBUw==
X-Gm-Message-State: AKGB3mJWZJ9Id79y/oMydy7n6WJvFjiY19zyqxdDt9habJANlkZo8Hsn
        LYbxEsUdUfPHdimtMu25sxE+P8tt
X-Google-Smtp-Source: ACJfBos5W8KoHV53911s4cGhscpRPAkHhrCzh4GTRis6If5MX5pelW2YAc4f3pc+nseofqqlp/0qpw==
X-Received: by 10.28.218.132 with SMTP id r126mr23274772wmg.59.1514418842254;
        Wed, 27 Dec 2017 15:54:02 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id m70sm11484251wma.36.2017.12.27.15.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 15:54:01 -0800 (PST)
Subject: Re: [PATCH v2 7/7] wt-status.c: avoid double renames in
 short/porcelain format
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
 <20171226091012.24315-8-pclouds@gmail.com>
 <cd764b8d-8a85-964f-eaf2-3e6fb784a2ff@gmail.com>
 <CACsJy8B7P-ObwG8yDH8A6RXccUgk-HowJfa4t+yPJ0ovSoUazg@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <46af07ed-31bf-f9a8-7e28-621baac93e14@gmail.com>
Date:   Thu, 28 Dec 2017 00:53:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8B7P-ObwG8yDH8A6RXccUgk-HowJfa4t+yPJ0ovSoUazg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/12/2017 01:49, Duy Nguyen wrote:
> 
> > I lost you a bit here, partially because of what seems to be an
> > incomplete setup script, partially because of this last sentence, as
> > Git v2.15.1 doesn`t seem to be showing this, so not sure about "like
> > we have been showing until now" part...?
> 
> Yeah I missed a "git add -N third" in the setup. And "until now" was a
> poor choice of words. It should have been "before 425a28e0a4", where
> "new files" could not show up, which prevented rename detection in the
> "Changed bot not staged for commit" section in the first place.
> ...
> Sorry again about "now". Before 425a28e0a4 rename detection would not
> kick in to find "second -> third" so people wouldn't know about rename
> anyway.

Yeah, no worries, I had I hunch that it might be what you meant, but 
got too involved in all the rest that I forgot to bring that one up, 
too. Thanks for clarifying, though.

Regards, Buga
