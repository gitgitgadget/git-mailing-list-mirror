Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F538C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 17:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiGARyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 13:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGARyd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 13:54:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89C3BFBD
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 10:54:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i25so4217577wrc.13
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oBrZ6WADPqwoKp1LVy5GmAU/NIs1V3Uu20WrTd2mN18=;
        b=WcurXlL6ZU+GCORu7TUCUW0HqvOD5TYWdiDpay9u/R+qIBQhSStShzwcoz4KJed1g6
         nB4c8h2gXN63yLqZNBzp6cyoGsQfE3IVOBAmei2SnxX4m65/xtW7Smk3xBT7DHo0pzFV
         pcnLOj+ySy97lPZ12rYa+plXQyGb3Au7WhlnfDwMLmq3ozSmLG/HtWWRZw5Pf8E0Bdgk
         VxGEwO/O+LFLU3k5s4jMT+FNTLGutNti0Vb2GDc7gVI/PP+Trjd5M8KugOkV8TKxFGSH
         u3s/ph3CreVoLPXr1PqCdldmVR6q0v+NSvlrwZV0NaR2gc5uAb3dYJyj3reC6UItwecD
         3U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oBrZ6WADPqwoKp1LVy5GmAU/NIs1V3Uu20WrTd2mN18=;
        b=dXGduPx92yRI1FkZ1qFb/qP87e2xE79xdRhaCNI0ESRWy+1JybAJ1R8SbF+RyBLtdb
         IirJksZhXuaO4rNObl0sVGe7bDuwUgbYZ+Y9z7OHaWkR0Uet66TjAks7fZod+IhS24uG
         cAZfqM4Ae17qwrlT/vaES+yh0nYW0W6NSnMY3+RYiOv0VGWmWXLQuEEellH/bJuzWmpA
         W2VXglT3x+r4uyn1jx9HAO0ZKknB8cmEtkFGyMt259xEirkaM5wIXl4oJHRyrGlEKgcd
         C7CgzfvfuQzpbIzz3muK3d+5vy2IyBcyRJWUcferXl2JYpZrKpICrkui47pqbAL+8F98
         xhlQ==
X-Gm-Message-State: AJIora9pwwffIGO53D1ql7ZMmo5L5VfS6JW9KDpTA2mM0n4YfhWJ6pzx
        omwROPNl1qqPoTALsFgbxt4=
X-Google-Smtp-Source: AGRyM1udKGBAb9yC3lcFWume/zaoe9Z8AdEq1MaNv/Hy3oDs4f6VyWb558I6okBvlz+zYMx014dthA==
X-Received: by 2002:adf:e8c7:0:b0:21d:1c7a:a45f with SMTP id k7-20020adfe8c7000000b0021d1c7aa45fmr14976622wrn.168.1656698071131;
        Fri, 01 Jul 2022 10:54:31 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id r12-20020a05600c35cc00b003a04e900552sm8760761wmq.1.2022.07.01.10.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 10:54:30 -0700 (PDT)
Message-ID: <d717324b-d7dc-fc5c-7bd7-2b74c4dfb644@gmail.com>
Date:   Fri, 1 Jul 2022 18:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: undefined behavior in builtin/am.c
Content-Language: en-US
To:     Roland Illig <roland.illig@gmx.de>, git@vger.kernel.org
References: <130c3636-b978-1600-df53-6a38c3414a88@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <130c3636-b978-1600-df53-6a38c3414a88@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Roland

On 01/07/2022 18:03, Roland Illig wrote:
> Hi,
> 
> builtin/am.c says:
>  > static int str_isspace(const char *str)
>  > {
>  >     for (; *str; str++)
>  >         if (!isspace(*str))
>  >             return 0;
>  >
>  >     return 1;
>  > }
> 
> The macro 'isspace' must only be called with an integer representable as
> an 'unsigned char', or with the value of the macro EOF.

Thanks for reporting this. Git uses its own version of isspace() (see 
git-compat-util.h & ctype.c) which does not suffer from this limitation 
as it casts its argument to an unsigned char.

Best Wishes

Phillip

> On platforms where plain 'char' is a signed integer type, any character
> whose value is negative invokes undefined behavior (except for the one
> character that by coincidence has the same value as the macro EOF).
> 
> To fix this, write '!isspace((unsigned char)*str)' instead.
> 
> I have no idea how to trigger this part of the code but for someone who
> knows this part of Git, it should be easy. Depending on the platform,
> this kind of error may be silently ignored or crash the program, as
> always with undefined behavior.
> 
> Roland

