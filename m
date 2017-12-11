Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03371F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbdLKOFa (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:05:30 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:44437 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdLKOF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:05:29 -0500
Received: by mail-qt0-f172.google.com with SMTP id m59so38599676qte.11
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Zz2c4RPNDqLAASYjc2DKWGZliVpvs6tsn1pZFUCxDs4=;
        b=Us619+15K6t2xbuXWHcmfAKSntW/bK1JPJyXsXB2F+wrRY3grqTHdeEqFSRqMy7hdt
         EZLsiSw/0nPccGLVxBjIuHGLP/lNk1bnpx8b39S5+jSOrhuPOy77O+pdKoRjz90Fydma
         kF1KqHdXSgyVkbybmw+Gi2BVTATi5Aj2w+lkJVGq8dzkHpCfrutawZ4HU/AzLuPWZDSV
         25L+Bdno6W5WMp+Kb0xVB7P2Brd9ia78qRgKWHUHxnWiDaOPjImGiwYhJmTDAx9/XcFO
         kmB6CPSNB/BqYEO3X1NwmaCNUv7Waqlm8cs+rBlW+pCyCaKIkelrapqWAasCl3yltP54
         Rp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zz2c4RPNDqLAASYjc2DKWGZliVpvs6tsn1pZFUCxDs4=;
        b=WP55w5vUr6tBlWdqXZhD66VwrFClB6WZhskOub4juIVjQePYh7EEoRUvfXCUQRmmzo
         SJYbq22vw7NaEAMkPA2cBdgUn7rWND1ww9uj7le+AaaQoDfkUPLQwc4BgI1dNRB8PCso
         pE+ZgMXRe+4z9QQoGPqdo/uC7FqIdz+iI4ryyKH8sjCslXC3vZfl96nK3x3mnmiZeAlp
         T0PU7xLMkY3Mbh91+VMPNQ0/UrjawFyiLFtwJ/3DW0ao31Ui4H3pQpfGHLoJqbkvAfwi
         mj3eJJCzTDoXeMAXAA1X8WwSDLgvqF4+tVCxIXSucW5HM76PEMcer2GiVgID/DNIyZ/d
         ag5Q==
X-Gm-Message-State: AKGB3mKZiM8rCRDYNPJXF64F8GvGKf3o2oaZvIVlUJIv0X2AAd77fLzr
        tSO8bGYY8dwbopHKJDJsdj51elrN
X-Google-Smtp-Source: ACJfBouCFm+aO5cYYy8fCIaQ63BxXfgoDfSmNocBz5i8JzMDaEi/kyz28GJ8xF5lQIQruWBYqz8abQ==
X-Received: by 10.55.50.129 with SMTP id y123mr675441qky.86.1513001128471;
        Mon, 11 Dec 2017 06:05:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u21sm4178536qku.8.2017.12.11.06.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 06:05:27 -0800 (PST)
Subject: Re: [PATCH] builtin/tag.c: return appropriate value when --points-at
 finds an empty list
To:     George Papanikolaou <g3orge.app@gmail.com>, git@vger.kernel.org
References: <20171211134409.13339-1-g3orge.app@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ca421d38-2d9a-8681-7947-3799c59984a7@gmail.com>
Date:   Mon, 11 Dec 2017 09:05:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171211134409.13339-1-g3orge.app@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2017 8:44 AM, George Papanikolaou wrote:
> `git tag --points-at` can simply return if the given rev does not have
> any tags pointing to it. It's not a failure but it shouldn't return
> with 0 value.

I disagree. I think the 0 return means "I completed successfully" and 
the empty output means "I didn't find any tags pointing to this object."

Changing the return value here could break a lot of scripts out in the 
wild, and I consider this to be an "API" compatibility that needs to 
stay as-is.

What are you using "--points-at" where you need a nonzero exit code 
instead of a different indicator?

Thanks,
-Stolee

