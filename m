Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984A8C433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 12:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJAMnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJAMnd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 08:43:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79576D2D61
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 05:43:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i6so6488400pfb.2
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yNRwBL4xp6qMEqyGKO1mB2xiZmWzItmaJSSizCwLI98=;
        b=EConWNGFcj7q/9fXVfx0yB8HNk8gIqH8JgYzfBMqULOCXNSRKqm0v2OpmS4t9V//gN
         SNKXFyctbFxP6pSJDbXW4bWpv3FOWj0TKFiGsB2t9JpoqOCHrEpPWKIDMvd8B5mLjEMQ
         3wYo4EklGUn6OLKM9mRIqHQnovcjyHCbMC73mYecyJf9scqN0UEBHHwLQ0pyk8qVp37s
         G8gmHdHHPTN6L17WbystAvx4qt1rTz5CpLoFjaZ4KCZQtbFOIFd3uc8GXhxV7shyya4t
         6sbb8U8HpAXZff66T+l4jGjA2gmHG3obaNVeCoGKzxcqdhrIR8J+R486EZtJj6nYajmO
         USaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yNRwBL4xp6qMEqyGKO1mB2xiZmWzItmaJSSizCwLI98=;
        b=VjeQF8poA7uMaW+RZY7NfGKwLr1nlaS255bzu9y1SaQRkLcn12lsYxZuVFqQbvFkGK
         6RH+w5QUwW51ZwJmZBKi7T8cVfUpsRhE338sZe/7F/Y/YXJVud6y+DKIUIqfUe9QRS2U
         gDwR3rwmjvuLaKuLE/839+ePN3KK+OPbxfN6Bc2LShLqJSiOJw2U6iOd8n9WUp5k/IPj
         KIJekFlS5OGFtn0WDL+GQz0peE54rJ3hyVLGMqyktadCDtZykn7wSG7fjv1KhtaGanAz
         fJMkHFZRj41yRtpPPNqnQU5Z8ifFdX1D1daw9AI4y5lekZx1tMj69oTnxM4HIeh9Ds2v
         bQmQ==
X-Gm-Message-State: ACrzQf3pa29Rn2OFxPsOf4c+bj7ATiB5i8+cnx/SrLq8LBX9Yk8C3mbr
        XD9WKpDBClCxzRcqv4MXCXvrYlrGO35CZg==
X-Google-Smtp-Source: AMsMyM4acrH3+JFbErW1joAulec0GyKejRYT0g7aqNntd4HpkshApl+3APQ7RmMJ2QeT0oODckRB8A==
X-Received: by 2002:a63:2162:0:b0:43c:96b:e5a8 with SMTP id s34-20020a632162000000b0043c096be5a8mr11292719pgm.143.1664628211869;
        Sat, 01 Oct 2022 05:43:31 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b0016ed8af2ec0sm1652836plb.29.2022.10.01.05.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 05:43:31 -0700 (PDT)
Message-ID: <f34912ab-5d1b-6dfb-e079-0e7b135ebe14@gmail.com>
Date:   Sat, 1 Oct 2022 19:43:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] branch: description for non-existent branch errors
Content-Language: en-US
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        git@vger.kernel.org
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
 <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/1/22 05:47, Rubén Justo wrote:
> This commit makes the error descriptions for those branch operations
> with unborn or non-existent branches, more informative.
> 

s/This commit makes/Make/

-- 
An old man doll... just what I always wanted! - Clara
