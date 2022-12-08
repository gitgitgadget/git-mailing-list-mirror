Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D533C3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 08:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLHIb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 03:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiLHIbN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 03:31:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F660B4E
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 00:31:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso5303116pjb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0Fh9z7OfijqsKOLvMdud1Ita3LmzyIGN1XkGDQj8M4=;
        b=qDSYznVlZK/X9ZCLuAejke7yl7v8cxvvlQtWsuT6elNHR+yEiGzDCtKOYlhj6oSYVQ
         WAeYttydB9NUsGwMh3+9iEHRvpkL06FMVDnc2S9q5WuFtBP0Ucwoz9nsXoG7miunavnf
         E0bBuzWrQ3YnvQlaE7CnzmfzsRDpjmqtiE/35tdGgZKf3nR13L+2i1x3qQarnYqkRgce
         78Adsn+fZxJfHCNdxeVwOvpmxaLiwC6b/9HdnY9rG0pWgGIPCnSlSehjfHQVBgpzARpQ
         8F6ZD1o9CFHy8ya0c6VtityZkeyP2AD0gG9z4jyJsGQtg9TzreLRt30sYvR66q3XNHFz
         uZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0Fh9z7OfijqsKOLvMdud1Ita3LmzyIGN1XkGDQj8M4=;
        b=wEBEnwsZZfGjWoVnaHAW64QHCeixeY2fDPZMC/++grZ122+tUzQsQIep2yNKHv7ygu
         9YnIIHWZGdkZ/4yH1Y3HAS+SOqeHV3ymuxeRkEEl2ApFH2mESpWqityf3aF1aU3qtN7p
         zR+0uvlLRPUTynyX/DFwQXTi5MpQ7nJGyy3vSZ9W1UeLnGzuyrlFqhFgkZU6F2umazim
         kyYtybx05G+k2iJNrTG7OdK0DHiuCxZDI/6HwyzS0pCI0OimrFmM2ly6buRh9QW+p+/j
         x4Zq++ZfSL9IjP8Qg13IY47AJiTKSKKKVsEIWf5nKZpSDIQuq4ibUovbwESNYZRnQQFV
         MKFg==
X-Gm-Message-State: ANoB5pnFQ0NRAs9dYJaHcBTSu4eXUEybbYxWtsu9dfldUmRsTBoEkrDd
        yx5kdKlXsWbX3wTtmqM4rk4mpWG7XFE=
X-Google-Smtp-Source: AA0mqf4t9ELT5ffNQa7hxpcOjBMkV/wYFq5HRn6HKQtNR6N/yDeD2auns6BIRQ/d2rAOKFIiykPeQA==
X-Received: by 2002:a17:902:7104:b0:189:bf5d:c968 with SMTP id a4-20020a170902710400b00189bf5dc968mr26809362pll.118.1670488271739;
        Thu, 08 Dec 2022 00:31:11 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-79.three.co.id. [180.214.232.79])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a1c0f00b0021984d697fbsm2379543pjs.20.2022.12.08.00.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:31:11 -0800 (PST)
Message-ID: <ca897325-f04d-3b13-9fed-c30d09f28d1c@gmail.com>
Date:   Thu, 8 Dec 2022 15:31:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Bug Report
Content-Language: en-US
To:     Jensen Bean <jensen.bean@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CANqKdC_ZULE4ABFTrRfC2JMkJp=i83MJy+PZ-hdWzWGO97gYHQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CANqKdC_ZULE4ABFTrRfC2JMkJp=i83MJy+PZ-hdWzWGO97gYHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/22 12:29, Jensen Bean wrote:
>  H e l l o ,   I   d o w n l o a d e d   g i t   b a s h   2   m o n t
> h s   a g o .   E v e r   s i n c e   t h e n   m y   C T R L   b u t
> t o n   h a s   n o t   w o r k e d   c o r r e c t l y .   I   k n o
> w   t h i s   i s   n o t   a   h a r d w a r e   g l i t c h   b e c
> a u s e   t h e   o n l y   t h i n g   t h a t   f i x e s   i t   i
> s   u n i n s t a l l i n g   G i t   a n d   a l l   o f   i t   s
> a s s o c i a t e d   f i l e s .   A n y   h e l p   o n   t h i s
> w o u l d   b e   g r e a t l y   a p p r e c i a t e d .
>  J e n s e n

What are your setup? Please try git-bugreport(1) and fill the details.

-- 
An old man doll... just what I always wanted! - Clara

