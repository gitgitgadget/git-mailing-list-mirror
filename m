Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA00FC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 01:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C4C6101E
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 01:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbhJPB7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 21:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhJPB7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 21:59:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34284C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 18:57:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i76so7692182pfe.13
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NuzvaGrYb7RTnUnYEpXVU1TuJQH1o9jpDwkhKA1jJVw=;
        b=agOchhkLQNMJsIo8vYBAIK+MTzw/pszeHWr8eOs9Y3yA1b+CU8qLLnXleOEutv+NX7
         uxc+n8NQJdy0Bd7SfHQFAgUguAxI+WXR7UEe941cyIZv988ax44crJIosYI62veJ12Pr
         /uZmUVX1jiPknWc3/nezZ+lnvOa3xdQEodR1fO7mnP7kWJDYrjrZMBAJn2PcWgcKiSLC
         dtLME3dCEM1vEs81h+lFlotVpwTelOQ6vuGVMywz1XVR2kLkSB7Gveq3H9ID6u8cFwtY
         J+fWXDSlKxJFBy1/qtTLHM2aZ2O4cd8PYeoEJTKi5zwwk5cTFMXKnyLW5hq1LWofPTfq
         yaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NuzvaGrYb7RTnUnYEpXVU1TuJQH1o9jpDwkhKA1jJVw=;
        b=xsMSG+tvgpfXGJ/J4J2g3ygSpYo5LljZvFa5OMInDl0NgpZeZt9j6D2+LE3DqnP45g
         VzevNkTnPvv6UI1zd+0HqYHvk1LqTeWbK+HZJTmlu5lvfxCWqRCjLEKmPAMxQbMZHwJJ
         DEwLx/ID/Tm6bg3XSP53HGR+rbVPgXxU0jHhyW0Rz2OP761n/bY4Q+LUkufR+mmolAmL
         ijmtkwv9glZWooLlRZCsZNXbAicCWkoWlXY+hqCvzNvHtZ4mlU8QUNr4OTBohbpQ6emg
         Y8q9wfEJFfTbzNfG/D4dNPgLnex8WSTAVKr5NazCqSPfaigBhdfTp0tU6/VmATmBMlhS
         7JqA==
X-Gm-Message-State: AOAM5325rglRy8FB+32YgdlpWzH6T+3t0FucNuOUYTt0ZUrkWlQJTzXt
        B4kujbsDaLwr1iqFw59rH50=
X-Google-Smtp-Source: ABdhPJxXXwg0whjLdBS/JtTfkhpUBZd3YjtnWLckHoLN3n+f48sPwGIwKsUyd7uZFVXxO8r415L2sQ==
X-Received: by 2002:aa7:9258:0:b0:44d:4f03:6a7a with SMTP id 24-20020aa79258000000b0044d4f036a7amr15195298pfp.33.1634349444554;
        Fri, 15 Oct 2021 18:57:24 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id y22sm12276692pjj.33.2021.10.15.18.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 18:57:24 -0700 (PDT)
Message-ID: <438804d8-eedc-cca5-acbd-5534df601b24@gmail.com>
Date:   Sat, 16 Oct 2021 08:57:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] doc lint: make "lint-docs" non-.PHONY
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
 <patch-4.4-800d7d81d42-20211015T123619Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <patch-4.4-800d7d81d42-20211015T123619Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/10/21 19.39, Ævar Arnfjörð Bjarmason wrote:
> @@ -343,6 +348,7 @@ GIT-ASCIIDOCFLAGS: FORCE
>               fi
>   
>   clean:
> +	$(RM) -rf .build/
>   	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
>   	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
>   	$(RM) *.pdf

Why did you clean the build directory?

-- 
An old man doll... just what I always wanted! - Clara
