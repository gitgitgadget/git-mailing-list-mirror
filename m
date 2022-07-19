Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA107C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbiGSSQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiGSSQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:16:58 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F748E92
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:16:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e69so4974103iof.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+bzCKCZbDPQXsI3YU8PttZzIl9kG7royEyDMv3bTJGY=;
        b=TYICfyqGxyCTkhrstmSvkQcQAyJ7EAmbj2eBQ2qT2evDalkeLQ/eq/Q+dTyQGT3jZq
         SwMtg7EUsbXKYw/NU+KmughquIn88JF7GdwJ7LtITaQ24sdrV0AV0XYC0zT/XFyLOM1p
         pXQoTlIKc92n5V9iJi/nGi+U336zjcB21/JZDFCxapXGLVCA1UlLm71W/ARbPTMWrJz4
         +nLizDDPipT531ZeQq2uCWqyu0AVI4oNjgCrakIzPb6YdlV9vy36aWeirylbsttMJa74
         qvZcdKow6tLw4pIOHMdxKjChIskjc+8MYyGMcC2tHzc3QnOR/NilMb6oETdWw0Xv9Zwi
         0Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+bzCKCZbDPQXsI3YU8PttZzIl9kG7royEyDMv3bTJGY=;
        b=2hAI0JzJjfozSUzctvNntgIQGfMSzBHDVwJQt3VPXFUHAFe2F+8CX5APi6ylRfyFzV
         qyIJasQqckSgyu690ZN5W4TszJFFJY9qDEcN+oMHCOhf50EjMsdy+ZYK+Yp07Hg9u2z3
         p3E7d0VEWrZLDHwEDQiFNWPIQ92YyeSFWLS3MNq19stCzFX3vDFOrub8Xz5Yty0Q77Lq
         jTKAnNkoBqNn93qN//fhpfYEMEc0QPDiSMhIOE5RN13Li5DMfYUpBU3bWSrqBPogyLzq
         58pxsM1c18tTryJ0jIT+ee8Akx/74aUgqsgJYFR6DnfI9i+ed6baKbafiOInjqqWxMI0
         MLGA==
X-Gm-Message-State: AJIora/nO8UIAzSwJdMtigd0h0hiRfj/oM1jexQ89PFbaZ/XpnSbFigj
        ZMAA6nGk01FTbf1Q5om/p2ft
X-Google-Smtp-Source: AGRyM1t9yBAN5n2yGHu2VwG7DpIOmde4cXaf/isBoZPrKrAbxmiG34vz5tpIvOhWtvdt9091oD9k9g==
X-Received: by 2002:a6b:4909:0:b0:66a:e3fc:e7b2 with SMTP id u9-20020a6b4909000000b0066ae3fce7b2mr15738292iob.29.1658254616618;
        Tue, 19 Jul 2022 11:16:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id a19-20020a027353000000b0033f3fcba96bsm6996907jae.100.2022.07.19.11.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:16:56 -0700 (PDT)
Message-ID: <16b9fd86-ba06-47b6-84f2-38a6e53e45fc@github.com>
Date:   Tue, 19 Jul 2022 14:16:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 0/7] mv: from in-cone to out-of-cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:
> This is a sister series to the previous "from out-of-cone to in-cone" [1]
> series. This series is trying to make the opposite operation possible for
> 'mv', namely move <source>, which is in-cone, to <destination>, which is
> out-of-cone.
> 
> Other than the main task, there are also some minor fixes done.

I'm happy to see that the main task is less complicated than the previous
case, because of your hard work refactoring some things.

I still have some ideas about how to break up the change to be a bit more
readable. Most of my comments on this v1 are nits, though. Good work!

Thanks,
-Stolee
