Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A681AC6FA8E
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 13:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBZNTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 08:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBZNTx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 08:19:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB286A278
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 05:19:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so3693139pjq.0
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 05:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wP8jhOUuJRjNARtjCBbrVk6YbsEc0eOJJmbXROQy+d8=;
        b=X6DEYUilj+MCWIZFZNbZ1Y3/9exVA1Qy/GhDHIEpBE912p0lZfyvzwulbYV963Bfqx
         rnMFwNJ+LLozmvf8n0ZUVqzbHvlyULgGnt7F7/Psn18cEot0//YAUme5pdzjGNixgclc
         zaKkamkwvSipCuk5gRwiyb0CBLUz1pczXwc4SPKoxKFqkHHD1UuOkbjTXIIRvWhgVzLK
         zhGgaWCPFb33ceHCwN+tZBriuL27LtkJchVbltDR4ZUysuA8wH1I8Yn6aTVx4GOqx9Ox
         d2sWaEeIJnHM9BCneq+x0IU7Kpr3rJ1G8arFXmhawKCQSKx9GDnbocWsAZMhJ324IyEa
         kFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP8jhOUuJRjNARtjCBbrVk6YbsEc0eOJJmbXROQy+d8=;
        b=1aWb6JWv+ANXyd1LklSvS430+J3URy6GuZj3DR7WDC7iWmKXViCKSOFzEyfJ0m+P08
         mX/7difgEFh06VX2h/BC4pg3YQtQICEnzBFJkKaemQs/XZQveqlIxmddk2l4YxkpXHxh
         GZ/dQlMEgz5JiOtcQVxHmNDZdNr0Z7WGN5drch0i6hWXyX3Whm9Tozc5Ewac+nutHZOk
         SeEzVyGqpHDGkLcvCFgjXJhCZDiH+d7JMPHIeUrSzN71huqduyvIdNBRehLPGF4L4Aip
         RJQ3oI9o489mVHh9IqR1cmtowf8Uwv+CsrCiPPIRB3eSYD3RpxZa1nEKpt4L/j5FyRkQ
         3dwQ==
X-Gm-Message-State: AO0yUKWftmT3tzJZAdFgSFgjsFg7XtOh7Sy0ic71iN4GF+ZgXBIbd/GW
        fORJjjnh+kUDYNWjd256oHAIhsNh2jY=
X-Google-Smtp-Source: AK7set/DvEL4EIPKeJdEQJGlK4IOJeyLcNGWNyhR1HnbeOz8l89Xkv0qRQyGPgsxOmHANBsHOJbFTg==
X-Received: by 2002:a17:902:cf4e:b0:19d:b20:4d1a with SMTP id e14-20020a170902cf4e00b0019d0b204d1amr886519plg.60.1677417592379;
        Sun, 26 Feb 2023 05:19:52 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b0019cb8ffd209sm2653942plk.229.2023.02.26.05.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 05:19:51 -0800 (PST)
Message-ID: <57877738-5020-f2e6-a0c6-f7ee6ce7c2aa@gmail.com>
Date:   Sun, 26 Feb 2023 20:19:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] MyFirstContribution: add note about SMTP server config
Content-Language: en-US
To:     Benson Muite <benson_muite@emailplus.org>,
        Vivan Garg <gvivan6@gmail.com>
Cc:     git@vger.kernel.org
References: <20230222011317.97943-1-gvivan6@gmail.com>
 <20230223082759.36021-1-gvivan6@gmail.com>
 <4de72b33-fb1a-ab8d-11b8-9e89554fa8ad@emailplus.org>
 <CACzddJqv=CX8LC55_RHVi46GOUuVqY7C0iMLHaFn24uNHzPf9w@mail.gmail.com>
 <a191c829-dfd4-a180-114d-147787d88aed@emailplus.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <a191c829-dfd4-a180-114d-147787d88aed@emailplus.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/23 17:37, Benson Muite wrote:
> Have not tested all of the setups in https://git-send-email.io/ The
> Fedora instructions seem fine.  It can be updated through Git, so
> contributions for other setups are possible. There is a nice way to test:
> https://git-send-email.io/#step-3

For me, my setup is to use Postfix as "null-client" MTA, where all
outgoing mails are relayed to Gmail. This way, configuring SMTP
credentials is delegated to the MTA and applications can be set up
to simply specifying `/usr/sbin/sendmail` as mailer.

However, in order for system-generated mails to be sent to my
real address, I have to canonicalize local `root` and `postmaster`
recipients via `recipient_canonical_maps` setting.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

