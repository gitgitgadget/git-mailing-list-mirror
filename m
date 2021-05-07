Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5236C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 12:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F57B6145D
	for <git@archiver.kernel.org>; Fri,  7 May 2021 12:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbhEGMsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhEGMsH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 08:48:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C901C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 05:47:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a5so496310pfa.11
        for <git@vger.kernel.org>; Fri, 07 May 2021 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PVpgsLGS8BGCpOcmUCj+yvwPz/qrpLVVWtLYH2wGYuk=;
        b=hUmrNZOk/M4Z+47ghiLMsa2Xs9NZu5dfCSvf6xdE0A8SWSZTZv6YHVm++tSajGbA5H
         AE9WYYder1KlLlx9CdPApeWpVHoXGK2h0cWZ1vkEvW7FGPj0PnI8H9helgB3tsoSFp3p
         kOxufWXp/oHRPsnvid5jwpjRQ6dERkAEy4lbMGLq04QZ+bYJ0yPp7KdyjFVgjUgvht+p
         K8CnGXlY2FAheD6jQQisGiuJ2eHSFHAGtsRU6SX42koYqt+ahnFg6ScWhYoSnfi1O4WT
         3bRo8n8duh0Wo5SMkM/btRQtS4oGEYLTGkRSJCGsaBBiVeSeBVhV2rr4v2pY3SUuobBr
         6KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PVpgsLGS8BGCpOcmUCj+yvwPz/qrpLVVWtLYH2wGYuk=;
        b=fSLC6wypUZqYy9iaWwRurpXLKjJT804W3FmwqMzu3bUGUcM3kup/IOQZl0I8Bxjoli
         aXD3CgoXVtVIZ7/bfZlgaJXbukSZQvda6MnfTYPleJIXT7WtVVw3EbMmgdM4L7CBBxu9
         4Ztidi5y29G7B5GMiSzv7ycXTRdwsiYAYHzx7W1VRZ9gkAMXVn5O7hYxflZm5W3tMvSg
         OQ0E6Iq//T5FMzGxm2mlVkp5XrnW/EO/CjhV0QiIXAD4Kjf/+WvBEw8rv+Icw0CQqQvM
         X5pXGSPw7P87FhmVaox/6V2DG4toB1OU3HvBo3klD6meVImQ1HNMiYP/c4kl7iO341qN
         T8iw==
X-Gm-Message-State: AOAM530ZuIg+y5KeqdkkK7eN34FNhXQxlvwzrBxWtDgfZwuAaeAd9Aj9
        xw2O0yqg3YLlTG/wLp7mohlBT6PJlMAGDw==
X-Google-Smtp-Source: ABdhPJxyw0XwOkPpuxKa0ZqQIjASnAx3Tf/mfbe87h8x7gmk+wqQHhG//A0WkgtEkR33nKRwjwh/fw==
X-Received: by 2002:a63:bf0d:: with SMTP id v13mr1736170pgf.303.1620391626510;
        Fri, 07 May 2021 05:47:06 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id j24sm4408305pjy.1.2021.05.07.05.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 05:47:06 -0700 (PDT)
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJUyHkYAIth0W9dY@danh.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <91eb6197-41b5-257a-34d5-6865df793880@gmail.com>
Date:   Fri, 7 May 2021 19:47:03 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJUyHkYAIth0W9dY@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05/21 19.27, Đoàn Trần Công Danh wrote:
> I'm pretty sure xmlto doesn't depend on dblatex and/or texlive.
> 
> I'm building Git and Git's documentation on different Linux boxes with
> asciidoc, most of them don't have dblatex and/or texlive.
> In fact, I only have texlive installed in my laptop.
> 
> I guess you're using Debian or one of its derived distribution?
> Debian puts dblatex as xmlto's rec. [2]
> 
> I think you can use:
> 
> 	apt install --no-install-recommends xmlto
> 
> to avoid those recommendations.
>

Yes, I'm using Ubuntu (derived from Debian).

> Hm, I'm pretty sure Ruby (asciidoctor's language) is very hard to port.
> Last I heard, it's buggy on some platforms.
> 
> I think we're better to do like this:
> 
> * If we're using asciidoc, we will use xmlto
> * If we're using asciidoctor, we will generate man-pages with
>    asciidoctor directly
> 

Nice for your suggestion.

But will the resulting manpage from asciidoc+xmlto and from asciidoctor
syntatically and semantically same?

-- 
An old man doll... just what I always wanted! - Clara
