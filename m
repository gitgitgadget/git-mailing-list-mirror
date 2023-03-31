Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF3C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 13:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjCaNvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjCaNu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 09:50:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F3AF31
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 06:50:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n19so12932599wms.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1680270652;
        h=content-transfer-encoding:in-reply-to:organization:cc:from
         :references:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MBvrF+XFgAjvYPWCbQ/SUg8Jv4nFZoTRKZ6EEpoo6c=;
        b=Q5zmcb5AkW8hp+fNTuvliYSp/c6xIAQFXaHAAq3H2n1umztEV9Hwm4vssV4QjVa79M
         909GgqYEtSDzaWmyxULpx+TdZF9zOabVfjk5bU1Nue11x0HDH5Rdks/B1604XEx1xdIW
         PzibdoV2iXKodvfB9TQV4ADSpC+gdKhKFo/tyuB+tRR1FCkzaX00KcYI7fNRllWvF3xn
         RuUbvm3rZ4//piureYcowH4cXuN/t7/vBFArjRqeDfylZuvRRMy2y5F79FwV9/9cBlJj
         8iC4iygGX62EhtEjonBdW44Zu4sVvrUcgAOpPBHE9lgH6bzmLlSwWpGLddJXmrTwk8tU
         u62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680270652;
        h=content-transfer-encoding:in-reply-to:organization:cc:from
         :references:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8MBvrF+XFgAjvYPWCbQ/SUg8Jv4nFZoTRKZ6EEpoo6c=;
        b=fKvz94Ja4JwdwBMo4qbTTRjKBJ0Ol0Oe3LgsFnZUjH7FVKsLSw2L5RcKteSfH4c0HM
         WeWXS4wIoB1eN1BRKdAvVVLcJmDih66tbgol5X/njRj2UQpWzGUs/TAM8G3InLAEXeSa
         hhWzrAS0CzAKq3kzfZIxy4Q5eaCFA6B940H9WgDyeRxnWNGxi5jMobwIivTPBq/6r89L
         ISONqVYCOx44rZKsWUptStS9svhayz2P5gafVZPJvLT8bly8AIkHzmTHpfMiiVf6gX/b
         sgfu1DpJUdDLt1ep1+1zTf8BK5270YPf2hkLn2SCCxttmx4nLr5UL/qAxliSU8ED2Q+B
         4D8w==
X-Gm-Message-State: AAQBX9eF6jaALKUHmu/6dc3rdvHHtVv7Y4ZcbDoKv7M1VFObBthh0RIG
        1hwy283SirzTXd7SVzTzCzS+PE9Y0UCWx+3iHIY=
X-Google-Smtp-Source: AKy350Zy9F06qUOpzBXJIJJSB7c4Ebsb//p1Fwpm1Pr71lW6qOnKTXUU3EwS3jT1XqwMxULSk2eGVw==
X-Received: by 2002:a05:600c:35c5:b0:3ee:136f:bcf4 with SMTP id r5-20020a05600c35c500b003ee136fbcf4mr7168112wmq.5.1680270652600;
        Fri, 31 Mar 2023 06:50:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:189f:b19a:6f2a:701e? ([2a01:e0a:b41:c160:189f:b19a:6f2a:701e])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b003ee63fe5203sm2733146wmj.36.2023.03.31.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 06:50:52 -0700 (PDT)
Message-ID: <7c2cf6dd-8586-af27-f4a1-eb8902de2344@6wind.com>
Date:   Fri, 31 Mar 2023 15:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] hooks: add sendemail-validate-series
Content-Language: en-US
To:     Robin Jarry <robin@jarry.cc>, git@vger.kernel.org
References: <20230103231133.64050-1-robin@jarry.cc>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     Tim Culverhouse <tim@timculverhouse.com>
Organization: 6WIND
In-Reply-To: <20230103231133.64050-1-robin@jarry.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 04/01/2023 à 00:11, Robin Jarry a écrit :
> When sending patch series (with a cover-letter or not)
> sendemail-validate is called with every email/patch file independently
> from the others. When the one of the patches depend on a previous one to
> apply, it may not be possible to use this hook in a meaningful way.
> 
> Changing sendemail-validate to take all patches as arguments would break
> backward compatibility.
> 
> Add a new hook to allow validating patch series instead of patch by
> patch. The patch files are provided in the hook script standard input.
> 
> git hook run cannot be used since it closes the hook standard input. Run
> the hook directly.
> 
> Signed-off-by: Robin Jarry <robin@jarry.cc>

Any news on this patch?


Regards,
Nicolas
