Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69060C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFC3613BF
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFCFFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 01:05:09 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:41571 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhFCFFI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 01:05:08 -0400
Received: by mail-pf1-f177.google.com with SMTP id x73so3983593pfc.8
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ugm6feAo4Cx/FX+h1mnA1lsl6MmzQJZ7HEt+x5FioZI=;
        b=p2XfDLXkoSK9uNyCZyl7+IYNndtsV/lIc+u3FdbmtelC/TPHBFyDKN5dOIqgqSE8bK
         EzkL5D95VWf4PP6s/mF6ljToiPLYcQswfmLT7yBqingOaX7XP1cx/9jPhWys+Ypr8w5A
         KAPXQzHsxwSVaKCvJz6agQ8sIGO7t3Bl9EpAxND7XgSuVpJeA3fH57NNVVZ0Kcau5+Ak
         3fD0dDxx6uVg/0t6Z+cDUdbJVyaEVSrXjvTZDIYUEr3JBOtaWf3eH/JeKuw85NulIg16
         5hhCE8AXI6objmITdixF7QJuB0QzqlPD9DXrrRkv061f5bhkVs+BZoB7jZgJsqbE1GAW
         i9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ugm6feAo4Cx/FX+h1mnA1lsl6MmzQJZ7HEt+x5FioZI=;
        b=X+hFSqFt1XyvJlBf83gwnd1TdCUGn+BliXlhoN1u909ybYrG4QqeP/q9458QPjJWRi
         wXBv3E/kjHKCCNQY1hIYqHfeAAh3FnHT4DFARql6xkmj3OlohMwsirrjqL8kd/LbbeTJ
         um5wH0FD70idwK2BEXoVgFYWQ+UI952hgpPq6MIIA2iUFPoipQfZwERiQenDFkFORhmB
         dvVFQU8texNopS+h8SRiFlK7OrXEVVLDrKdycqG8SLb30E5SNeke7tamix7M8PY5GRnO
         WfvZDcfn+sFx2Vo8Urt2W11Nt0vxWadzC/8Atba/Jo9UuPmKXreOVGAJI+TjQg4uB2eg
         6Tzg==
X-Gm-Message-State: AOAM533U3OgAxYsZwMmsf78FTrdcuhfB7kjDiOY5QcX0DFoY9okUBgmB
        gl4F2BfQ+nXpGSsMakB2FawIL8Ar9LcZ5w==
X-Google-Smtp-Source: ABdhPJxn4LkFf3SDoXJHzK1ZfkEPPn66Cu+S3eGv2r5GJHUoXfJV+RKbCZ2QrAFp426tDbMN9saspw==
X-Received: by 2002:a63:5d19:: with SMTP id r25mr36735694pgb.317.1622696530940;
        Wed, 02 Jun 2021 22:02:10 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id fy16sm882248pjb.49.2021.06.02.22.02.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 22:02:10 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Gmail OAuth2 in git send-email
Message-ID: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
Date:   Thu, 3 Jun 2021 12:02:08 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

For most email providers, adding following .gitconfig is enough to 
seamlessly use git send-email:

>            [sendemail]
>                    smtpEncryption = tls
>                    smtpServer = <server>
>                    smtpUser = <email>
>                    smtpServerPort = 587

But for users that use Gmail (like me), we must either enable 2FA and 
generate app-specific password for use with git send-email, or enable 
less-secure app access. That's because Gmail prefers authenticating with 
OAuth2, but git send-email use plain text authentication instead.

I personally prefer the latter because I know that I enabled less-secure 
app access only for duration of sending patches with git send-email 
(that is, I switched the trigger when I run git send-email).

We wonder whether git send-email can support Gmail OAuth2 so that we can 
seamlessly send patches without having to choose either action. But 
however, we have to create a GCP project [1] first in order to enable 
Gmail API. This can be overkill for some folks, but unfortunately that's 
the only way.

If we want to enable support for Gmail OAuth2, should we hands-off API 
configuration to git send-email users, or should we configure it on 
behalf of them? Note that when we go the former approach, some Gmail 
users simply can't afford GCP pricing for whatever reason (even don't 
have any of required payment methods), whereas the latter approach we 
must cover that cost (and Software Freedom Conservancy can raise funds 
needed for it or git.git developers can pay it).

Thanks.

[1]: https://developers.google.com/workspace/guides/create-project

-- 
An old man doll... just what I always wanted! - Clara
