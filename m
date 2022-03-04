Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C1C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 09:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiCDJwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCDJwa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 04:52:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9B6D979
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 01:51:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so16250548ejc.12
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 01:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E3rva0S9K4FjGRtRvxmoKMAm319ZtPK+U1RQXa3Iyl4=;
        b=W8vW7casYpAbU4mtUQUJNFoOIickd8wXFFfunwDBZC6sUnEBrdquyjDlWYVZss4zx6
         SvN2GnV7FAELTcerE3o5W3z6IR1Jq5pT8o9TzfoC8DLIqaSekhmw/FQSgaLDOg0rfg8J
         lhd6fic4JYokR77Z7vPuEiNvA7mYBbwYn0ruZnQ/sv42cORVEJFoDQPog8smRkxgOr3K
         wwAfWG9x+OTvAXc1VA6K17N8x645bWjQMID1wMZAnt05wZpauf+hPp1UUXcqw3y3IvFM
         dWXfmpLWCcix2CS34IoRoywDIORnMphnG1OfAHHrzMIOfnyFXFJr4AuLJiVi9DIvh7FE
         Lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E3rva0S9K4FjGRtRvxmoKMAm319ZtPK+U1RQXa3Iyl4=;
        b=IcECrQLFEn8/VNprXspJEIN4pJZwOUuX1XexaK2J66yLHERun99LXT9ws8m6ByeyRI
         PIXVdPiQCFi5jUb/EVM5NQVAkQPpdUVhBvSH8geP8NjlqQhdjWPUYDJB3C5h+OhFVAtF
         EgjiUWnUMCzdggf7LwIBqv6pCK8VDSqk+wCjTAWZU2x0oeb4+i0H+S9QrIpojYoeumic
         Zcpaddvs4jqbYqR3pf6n6l99wVfk14oCW1Ez7LipVBd2q6zfZMixVu4TRpJBhu5+WoLS
         9Ql4ZnYGFgwdMHYJltW0gMvM2EwUMq1hNj0BnMTYiCpZpjuL7m77+FbANfjo8hLc7c+c
         wBTQ==
X-Gm-Message-State: AOAM531XVx673cdDLcETFJBkuq1le4gm1ek7Tiz/FA0lekKkP/gPJlHY
        8NAYqb6xyR30gKkBKcQ1TXg=
X-Google-Smtp-Source: ABdhPJwtRB+v0qQTjt4pwSfzQUIndhnx1sD6aJg2qOkAmwNwi4CZVBhspZwX73zCYCjonKle7jyC4g==
X-Received: by 2002:a17:907:1c13:b0:6da:62bb:f1ff with SMTP id nc19-20020a1709071c1300b006da62bbf1ffmr9721172ejc.276.1646387501631;
        Fri, 04 Mar 2022 01:51:41 -0800 (PST)
Received: from [192.168.1.29] (176-136-227-224.abo.bbox.fr. [176.136.227.224])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906435700b006b0e62bee84sm1578279ejm.115.2022.03.04.01.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 01:51:41 -0800 (PST)
Message-ID: <a30ebbe3-596e-84a5-9023-b53402dfe70c@gmail.com>
Date:   Fri, 4 Mar 2022 10:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/1] blame: Skip missing ignore-revs file
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Noah Pendleton <noah.pendleton@gmail.com>
Cc:     git@vger.kernel.org
References: <20210807202752.1278672-1-noah.pendleton@gmail.com>
 <xmqqr1f5hszw.fsf@gitster.g>
From:   Thranur Andul <thranur@gmail.com>
In-Reply-To: <xmqqr1f5hszw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/08/2021 22:58, Junio C Hamano wrote:
> Noah Pendleton <noah.pendleton@gmail.com> writes:
> 
> 
> That cuts both ways, though.  Failing upon missing configuration
> file is a way to catch misconfiguration that is hard to diagnose.
> 
> I wonder if we can easily learn where the configuration variable
> came from in the codepath that diagnoses it as a misconfiguration.
> 
> If it came from a per-repo configuration and names a non-existent
> file, it clearly is a misconfiguration that we want to flag as an
> error.  Even if it came from a per-user configuration, if it was
> specified in a conditionally included file, it is likely to be a
> misconfiguration.  If it came from a per-user configuration that
> applies without any condition, it can be a good convenience feature
> to silently (or with a warning) ignore missing file.
>
I am very interested in this feature, but I'd like to add another point 
to the discussion: in the case of ignoreRevsFile in particular, no one 
creates a repository with such a file; it is always added later. 
However, when bisecting (a typical usage scenario for git-blame), we may 
end up returning back to a point _before_ the file had been added, and 
then, git-blame fails. This often happens to me, and I am then forced to 
`touch` the file to create it again, only to ensure git-blame keeps 
working. And then, when I want to return to the HEAD commit, the file 
must be erased again otherwise there is a conflict. So, for me, the 
"ignore if absent" behavior seems to me like it should be the default.
