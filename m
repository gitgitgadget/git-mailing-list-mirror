Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4090C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2C720866
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNIau1sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgHNMbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgHNMbH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:31:07 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46201C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:31:07 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o22so6711465qtt.13
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NVOxAD1Dkfkj1ivgXj1lWT/kQq0LB/Gbtj8t/zuqIwg=;
        b=bNIau1sdbtlFFQgVY3BlW0DOSE2KWW0IBx4PHgU8aTjxzKjIVS28SI8vYjownedGzl
         0zZbSZKM2obk5URlCji9M28IEkV+UWb4uZMVj3ia9dcQIHK43lIyu+3SxseUgYdhm6ry
         wFziT+LynFmANaBZctxl1sgBFYHR7FADZCra5vcW04OkPktiiBrxvQQYMgjTUCehy+NI
         BKA0YN+F1LGV7adT8uZslcLQq5BrFS98/wpTYiQ3qhJMWQ6P5aMPkw5P+A4dmkG0q4Ah
         W8bqraBt7a7qwa2rGjwP2ItpW7DT/Yn1Tj0JJCU3vQvG8GdvCCaGUlBDhD5mXFwJ7Tt0
         8hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NVOxAD1Dkfkj1ivgXj1lWT/kQq0LB/Gbtj8t/zuqIwg=;
        b=BSXNaXx9uiiQhtAQvAy1V3z8ZK7pjK1UxdIL7uWY/id1aGALc0DoLgoQsFoWdu9zJ4
         z4dhk8M5XF+ACaPiDBDgLsS6fRB/Bl7W2+prINJmAAGwsODZQkRFlWq6pOWiyq2oNDXN
         iq1DfLetli8xIOoyGI1K72jdg5mqsmHUW5GbIi0HRiKVv4vAY8S2sAzSqyF2z3BwrwIK
         jDnH4durkEelBfef4+D6Q8N1veUcBNR/KeoVB91VGn6gAIPhX1U5n1LASTZS4PUN8gHp
         HxGEu6kKqR/bYJUVGR1OG2HIz679tqVTnWM0U1PXW3V8RTNsaGp74FUOydXLVAiJGRXC
         Fi8w==
X-Gm-Message-State: AOAM531i/Ws+u33FAwKw86EaAuhf5yTC4DiBoaSKzQFoh1CU5nIP35x9
        lHz4z6OsAdMYqctmNgpocuU=
X-Google-Smtp-Source: ABdhPJyW2/S/dc+nHsFRjg3cNElmqC7103mKbr9fT+NJhG8a+bODxpqcnKq2FgMiUDwdSbhwuXNnTw==
X-Received: by 2002:aed:2a82:: with SMTP id t2mr1788320qtd.280.1597408266308;
        Fri, 14 Aug 2020 05:31:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4116:add4:1500:aeb7? ([2600:1700:e72:80a0:4116:add4:1500:aeb7])
        by smtp.gmail.com with ESMTPSA id s30sm10183775qtc.87.2020.08.14.05.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 05:31:05 -0700 (PDT)
Subject: Re: [PATCH 3/5] protocol-capabilities.txt: clarify
 "allow-x-sha1-in-want" re SHA-256
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com>
 <13798dfb121c9631e9d811f5f74f9a78c1fcfdf9.1597406877.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <73e1ce78-a461-1204-99d5-a588f8e65fc9@gmail.com>
Date:   Fri, 14 Aug 2020 08:31:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <13798dfb121c9631e9d811f5f74f9a78c1fcfdf9.1597406877.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2020 8:21 AM, Martin Ågren wrote:
> Two of our extensions contain "sha1" in their names, but that's
> historical. The "want"s will take object names that are not necessarily
> SHA-1s. Make this clear, but also make it clear how there's still just
> one correct hash algo: These extensions don't somehow make the "want"s
> take object names derived using *any* hash algorithm.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Documentation/technical/protocol-capabilities.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
> index 36ccd14f97..47f1b30090 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -324,15 +324,18 @@ allow-tip-sha1-in-want
>  ----------------------
>  
>  If the upload-pack server advertises this capability, fetch-pack may
> -send "want" lines with SHA-1s that exist at the server but are not
> -advertised by upload-pack.
> +send "want" lines with object names that exist at the server but are not
> +advertised by upload-pack. (Note that the name of the capability
> +contains "sha1", but that it's more general than that: in SHA-1
> +repositories, the "want" lines provide SHA-1 values, but in SHA-256
> +repositories, they provide SHA-256 values.)
>  
>  allow-reachable-sha1-in-want
>  ----------------------------
>  
>  If the upload-pack server advertises this capability, fetch-pack may
> -send "want" lines with SHA-1s that exist at the server but are not
> -advertised by upload-pack.
> +send "want" lines with object names that exist at the server but are not
> +advertised by upload-pack. (Same remark about "sha1" as above.)

This "as above" is brittle to future changes. I think it
could be improved with

	(As in "allow-tip-sha1-in-want", the "sha1" in this capability
	refers to object names, not the hash algorithm chosen for the
	repository.)

Or, just repeat the same note again.

Thanks,
-Stolee
