Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA84C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77EC613AC
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 09:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhJEJty (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEJtx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 05:49:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B267C06161C
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 02:48:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 187so12532001pfc.10
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sa2rMVIOLAcGIUKDHZVPw8J7IGMMMQMEqLfxamwlGxA=;
        b=I1m113VS1U9B/0pcds9x7s4w8TwTOw4lN6+/kS20e2W3Gw00LELhtNRCvojt1DTMJ4
         4v1dmJ/UOVZtsjtnT4plY0SCxNmNGjAIRa55cnJN4iyG3peR8Fet7J3xajY/VMJ8rH78
         7cWyKck9fN9fS4hMYvg+hGgwPV7/BGCE+htWL+hrItPCq7XOj/DiEjKG30HgmRTQuWH4
         3c6rdc1nHoiObXYoFpYZxbF9W8oiCYFhIIyX0eUF0XqmzcZY6Do8gANlltq+pZHMYC/s
         c+UGzGLWUREaG+hwbx8QigfopxUTXOTunOJmwvI/JE4pWpn8w34SlAgxesHQJdNLePNU
         iPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sa2rMVIOLAcGIUKDHZVPw8J7IGMMMQMEqLfxamwlGxA=;
        b=u6Pdh47Ufw8U56UdT3n762SXUNbNaqqs4lVvv1xBU5k4D5ICUa9hLU9O2K8qaksbnq
         d2LmDos0bO8srOZBALfOT3Q9Np9sZBtT8YEDRNckkfeF8B4XlyhLFpJq2/3oJB+ZjbRV
         ivp23jlLZhiqCJImKasKMLWr6u5NTaJrKQ01M8Xu1AHQjj+MdXF3zw9jsHMOEps2gXGU
         EieatxKMJci66TQXG0waWqSTxxVpZhqxJXddLWShdENNrqvm5EOrUEA/Z882Lwtc2NE4
         n2nn5N+UBYOaEorhR+ZMaanFFmGJf1zshX8lPGDAPXqR9DHkN+v1rbRBPvWQFNSGoiDa
         1oNw==
X-Gm-Message-State: AOAM533gzMAAATz8efE1Qb9T7r6i1fI2sI+HuF3hmSeeWapYGfDIA5B6
        dYInmw3RTKl1MmquZafO1XoR+BM+JBg=
X-Google-Smtp-Source: ABdhPJwmFvqqtA7WG0zgv784pbmgJj2vyuMrIkyGVjX1w+tSO49ho4JJasZwKghORYZjbJ9AQWMa/Q==
X-Received: by 2002:a05:6a00:16d2:b029:300:200b:6572 with SMTP id l18-20020a056a0016d2b0290300200b6572mr29370729pfc.62.1633427282666;
        Tue, 05 Oct 2021 02:48:02 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-56.three.co.id. [116.206.12.56])
        by smtp.gmail.com with ESMTPSA id v20sm10547953pgc.38.2021.10.05.02.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 02:48:02 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] Documentation/git-status: mention how to detect
 copies
To:     Johannes Altmanninger <aclopte@gmail.com>, newren@gmail.com
Cc:     git@vger.kernel.org
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
 <20211004190050.921109-1-aclopte@gmail.com>
 <20211004190050.921109-4-aclopte@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <31f46980-7e40-46c0-87b7-f5ea7034af2b@gmail.com>
Date:   Tue, 5 Oct 2021 16:48:00 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211004190050.921109-4-aclopte@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10/21 02.00, Johannes Altmanninger wrote:
> @@ -211,7 +211,7 @@ show tracked paths:
>   * 'A' = added
>   * 'D' = deleted
>   * 'R' = renamed
> -* 'C' = copied
> +* 'C' = copied (if config option status.renames is set to "copies")
>   * 'U' = updated but unmerged
>   
>   ....
> 

The config name and value can be formatted to monospace 
("`status.renames`" and "`copies`" respectively).

-- 
An old man doll... just what I always wanted! - Clara
