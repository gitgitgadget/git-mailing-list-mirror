Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399E6C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB81F2073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zivver.com header.i=@zivver.com header.b="mZqztoAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLIPx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:53:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34689 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfLIPxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 10:53:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so16810496wrr.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zivver.com; s=google;
        h=subject:to:references:in-reply-to:from:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oUrSQTdS8b8BPnWAd93mfpkZmETq3g6Ogi3frlUCzUY=;
        b=mZqztoAHvlZTz3q5Ql/O+3m2QThTYQdjq94ncW7jZVY5P2OC0fiZmTHtCCXiDSr6uh
         jRuhLlA/iS78K0GHKqoTn6GXQnyU6q1GAJBjh3CWD5Z8RbgipPp8ohW20ddkHDEvv8KO
         ocFbPNCvdNKLcoPhLB+kQNgN2Irf8QxgcKvdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:in-reply-to:from
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=oUrSQTdS8b8BPnWAd93mfpkZmETq3g6Ogi3frlUCzUY=;
        b=l+CrenlQX5X/SiotJ1ZdkZBHDSBz9qlFzwGdzNyzkyy7m/FwaHJ6yJQlO5ADHDz6rI
         ktlWBFezSYOXI9h1JYIvh+hN8CwQsOWX1FdZnJCKoznKezmTY3OqKUJqhZcFw9/WW+4X
         ZVoD9vS9WUGfzj8C/K9I4HARcWG1ByZHC8Kc80NPXGwf38pwMpYO4+OduZru2W1+XiwF
         ZbAfUlSMrVxOUR5KsOheVkoPXRFGzFXlFBOfD+0WQJjAqWvHtTUG0zEU6QEfZbm1xXsH
         APbdDYtm2S7aW7oeTKDoSz1CzJQGBcZ58U6oYXFuw3tVkOfC0s3gcDX3GMX6evC3O8sy
         9dSA==
X-Gm-Message-State: APjAAAX060XCEqKKPgzpDDVCri31NAp0R7zw+ESbbHB7pxuP1ZCEbvWX
        m8qr7SVtV99OICieT8j4o1Zd/VZnpUk=
X-Google-Smtp-Source: APXvYqxWGYtq9XLoFPCOjx+PewvLbGxpBDuInxXJpmbjz7/NefarNnODcJ4wrkrHN5fiYEZHspJP6A==
X-Received: by 2002:adf:d183:: with SMTP id v3mr2997539wrc.180.1575906803689;
        Mon, 09 Dec 2019 07:53:23 -0800 (PST)
Received: from ?IPv6:2a00:a000:8:16::2d7? ([2a00:a000:8:16::2d7])
        by smtp.gmail.com with ESMTPSA id h2sm28816205wrt.45.2019.12.09.07.53.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 07:53:22 -0800 (PST)
Subject: Re: Re: [PATCH] git-gui: allow closing console window with Escape
To:     git@vger.kernel.org
References: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet>
 <20191208194046.csf35b7rgycst2vc@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912091014220.31080@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1912091014220.31080@tvgsbejvaqbjf.bet>
From:   Vasili Novikov <vasilii.novikov@zivver.com>
Message-ID: <1313cb5b-9d6a-f038-bda3-757b4e55bf33@zivver.com>
Date:   Mon, 9 Dec 2019 16:53:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What have console windows to do with git gui though? I'd work under the 
following assumptions:
* we're talking about a GUI window, not a TUI one
* the window has no useful information at all except the fact that 
something has "finished", is "done". There are no actions that you can 
take except to dismiss the window.

If we agree on the following assumptions, then I see these real-world 
examples:
* Mousepad > About > Esc = closes the popup
* Firefox > About > Esc = closes the popup
* Thunar > select any file and ask its properties > Esc = closes the window
* file-roller (GNOME compressed archive manager) > Extract archive > 
Observe success window upon completion > Esc = closes the window.

Are there any real-world examples where `Ctrl W` or `Esc D` work but 
`Esc` doesn't, to consider these alternatives as more intuitive to users?


On 09/12/2019 10.18, Johannes Schindelin wrote:
> Hi Pratyush,
> 
> On Mon, 9 Dec 2019, Pratyush Yadav wrote:
> 
>> On 07/12/19 05:24PM, Johannes Schindelin wrote:
>>>
>>> On Sat, 7 Dec 2019, Pratyush Yadav wrote:
>>>
>>>> It is often expected that popup windows like the console window be
>>>> close-able with Esc.
>>>
>>> Seeing as the console windows is not your regular popup window with an
>>> "OK" button, I could see how it would be all too easy to close the window
>>> via the Esc button all too easily, annoying users.
>>
>> I'm not sure why it is "too easy" to hit Escape. If you're hitting Esc
>> (which for most people is pretty far from other more frequently used
>> keys) you expect _something_ to happen. People don't just spam Esc for
>> no reason, do they?
> 
> Is it possible to issue a command in that console window? If yes, Esc D is
> what people like me would possibly use to delete entire words.
> 
> Even if not, if there is no "OK" button, it would annoy me no end if the
> Escape key closes the window (it is not a dialog box, after all).
> 
>>> For windows like the console one, I would expect Ctrl+W a much more
>>> natural keyboard shortcut to close it.
>>
>> But, that "something" the user expects to happen could also be "stop the
>> command". AFAIK, Esc is often expected to stop commands. But closing the
>> console window won't actually stop the command. It will keep running in
>> the background, and when the command is done, the window will open again
>> showing the final output.
>>
>> So all in all, I do think Ctrl-W would be a better idea. Will re-roll.
> 
> Thank you,
> Dscho
> 

-- 
Vasilii Novikov
Software Developer
vasilii.novikov@zivver.com

ZIVVER B.V. • Koningin Wilhelminaplein 30 • 1062 KR Amsterdam
www.zivver.com • +31 85 01 60 555 <+31-85-0160555>
Follow us on: twitter <https://twitter.com/zivver_nl>, facebook
<https://www.facebook.com/zivver> and linkedin
<https://www.linkedin.com/company/zivver>

✓ Voldoe jij al aan de GDPR-wetgeving?
<https://get.zivver.eu/nl/gdpr-checklist/>
