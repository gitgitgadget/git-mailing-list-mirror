Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE91C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 13:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiG0NlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiG0NlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 09:41:23 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF32CE27
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 06:41:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c24so13249049qkm.4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QWP9dDNk5FVQVoLAViiD3IEFrnXYWykcgk17c1FGTMM=;
        b=SG6xfPCURjwNyheD1YshkdiAfRLZaLgg5Nh0U4wIQH3R8JekVod8+HM9Rce8mQhh8O
         HHYDFFz3p2FzINSI3R5K7C3rFvLUx86yk+ZfxGEVYtywvUX6R/Dw2qi6FvegSLjOPDjZ
         sktSjgWpCtft6OpyUXUfNzc8kzYxQhFKuE9QzDBBlsWtqIbkUZAW8VUe264BMpz55qyR
         Bt0Vg5gjd6ZvpQdS4XDxYgNQU9PnEKbQbOs5XeNgDz5jlt6uqdCotuUL8vOKaBPWsJUx
         7YLxf26HpS3ZA9NZk/sMX1ROxjf4xDXsXgBkqoMuZTnOq/fVLhraPZkvs6QwR6pUxC2Z
         JXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QWP9dDNk5FVQVoLAViiD3IEFrnXYWykcgk17c1FGTMM=;
        b=p2vm8BKCBL3wgw93hplkbUSA8baY5p1tDBNc0vFuRonh4WXa2X/GsEGJQ0lanSjhuO
         /puO+2usOejeAj/+NAU5BpC1aCtxIrgcKIETTbmuogwACmMOiBkPhN9pcjKnEiKyBuEG
         6yrHkpIY0m8cFcNZitNuM9Tv3GptA/iOBaHvO2+kYEqF26KZHBsxjD1LZoDZoSCov+h7
         RCjwsTQoh792H8iaCuuIW2UAoA3dsLIq2C8sLHWDGNDQ95YQlsYst02Bj5/zwbWraKiX
         Bgqqwf62eg8CHsL/GWnTNomIAbSkgDVKdJ9J7MNY91jVEBhxnkGjAJd5sLo/DNoG2tf4
         Wo+g==
X-Gm-Message-State: AJIora+kpfG4HPdootquJC/R8UVDLOR++NpUixaOL81R/1bqWacAQDJb
        LBo9H2axzAV+74xdF9KA/Ih3
X-Google-Smtp-Source: AGRyM1uRtzChoA/E4aFVb2R86jUI/P5sMsCbESNPvuNAuC8b7Hw5yySMLutIAPAXOKFCCC+3ecva5Q==
X-Received: by 2002:a05:620a:450b:b0:6b5:e3ea:412e with SMTP id t11-20020a05620a450b00b006b5e3ea412emr16590055qkp.381.1658929278797;
        Wed, 27 Jul 2022 06:41:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:85f5:c696:22d5:b5a5? ([2600:1700:e72:80a0:85f5:c696:22d5:b5a5])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a290600b006b5c492aafesm13738973qkp.86.2022.07.27.06.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 06:41:18 -0700 (PDT)
Message-ID: <69684d1e-ffda-367c-f0ae-2d4a3560be74@github.com>
Date:   Wed, 27 Jul 2022 09:41:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] log: create tighter default decoration filter
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <220726.86tu73ncf8.gmgdl@evledraar.gmail.com>
 <c3b14045-01a1-e207-a60d-2e3290ab8001@github.com>
 <220726.868rofn23f.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220726.868rofn23f.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/22 2:19 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 26 2022, Derrick Stolee wrote:
> 
>> On 7/26/2022 10:44 AM, Ævar Arnfjörð Bjarmason wrote:

>>> But I think this change is going about it the wrong way, let's have a
>>> list of refs that Git knows about as magical, instead of assuming that
>>> we can ignore everything that's not on a small list of things we're
>>> including.
>>>
>>> Wouldn't that give you what you want, and not exclude these sorts of
>>> custom refs unexpectedly for users?
>>
>> Instead of keeping track of an ever-growing list of exclusions, instead
>> making a clear list of "this is what most users will want for their
>> decorations" is a better approach.
>>
>> Users who know how to create custom refs outside of this space have the
>> capability to figure out how to show their special refs. My general ideas
>> for designing these kinds of features is to have a default that is focused
>> on the typical user while giving config options for experts to tweak those
>> defaults.
>>
>> You're right that this series perhaps leaves something to be desired in
>> that second part, since there isn't an easy _config-based_ way to enable
>> all decorations (or a small additional subset).
> 
> Yes, but this is just side-stepping the issue. Your X-Y problem is that
> you want to exclude certain refs that we're specifically creating.
> 
> I think that's fair enough, but I don't see why we're not specifically
> excluding just those then.

I'm advocating that we make a one-time change to have a set of "known
useful refs" as showing up in the decorations. Perhaps some users (like
yourself) need to react to that change, but it happens _once_.

Changing the rules repeatedly as new "hidden" namespaces are added is
more likely to cause confusion multiple times.

Thanks,
-Stolee
