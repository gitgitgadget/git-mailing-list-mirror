Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1061C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 07:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhLKHgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 02:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHgP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 02:36:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D2C061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:36:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p18so7710722plf.13
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RQFx6re32YdSUGXnfDNIoub6fkCLVIo5GTA0dYFbh3s=;
        b=ToGVnBq/ygVmfQTS3mKBS9dZq4L8erdnAOac5tPUKezTqCbJXyuj1AV/aZmDBfFmyu
         tl1sE0hOwJo7wBgVHcW4zFCULR0AP+7gtwkfmGGpLpsPbvtHRm/X//ZlXiKtKMR+njh3
         6Nlefn2XzcSBmhq3W8JQsXDlIvBVKo/AU/D5SZqBQ2h/6mO/XtRUqQ7Kwz5zRGlMfI32
         1C31kWuAjJ0rGSn3ZThL4VGpemhD18FQ15JbulhfD7NCrp3KymZGwqVW/dQqGNwkjNEO
         LjZueI+o6Q5y4SbZGevieHqUIF+C/8ITCIfIOtS9gIj8vXR4Sp/UwC4/WGQLDXAFTB25
         GAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RQFx6re32YdSUGXnfDNIoub6fkCLVIo5GTA0dYFbh3s=;
        b=Jg78r3bJBfpZIrF/mh8PaECqodCgcc5465SwXhx1wqlb0nKKAnhjVAv3VsSB6x0eBH
         IP4UZe2O0Gp2Q1hcZoo/9tdK7Sb/202BlhZ68dBkPT/CiahTcCS9NUMZ+Z1MesdRVqxU
         njLJM60KYuG7oM+E7QJ3cVHrOrVxyLhhOpyC/L10cRO3ORko8Byeulpw60fU/AwNKkrk
         aR8YXIXt3QkOiEdpkOuQThoGyP/Ni8tjuO9Bhoq/ju9fThrzhs14gIIf+OVKugNoyvxu
         CxOeKuFDxS0j4a4DNW287dxLn9IwJAVwaDGQEqTSjeWYIX4VK93sU8J1uCbPTFZtduyE
         67tw==
X-Gm-Message-State: AOAM532W29EsneWwFnXV4jmSPH/ddy2f4G26ptDN2zxICJM8C+QwG443
        Romgel2yAFjzMVELVB7/+uM=
X-Google-Smtp-Source: ABdhPJz5mjjfrBReSmrPn8v5LjEaOXBE2tnj39RsCflhRGqZFDmtrCxYiKZKmZQOuhMLhLe/JS1GJA==
X-Received: by 2002:a17:90b:3a89:: with SMTP id om9mr29654899pjb.29.1639208173540;
        Fri, 10 Dec 2021 23:36:13 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id g1sm4216555pgm.23.2021.12.10.23.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 23:36:13 -0800 (PST)
Message-ID: <d8a07706-bbcc-059a-fd1e-6f0e920279a3@gmail.com>
Date:   Sat, 11 Dec 2021 14:36:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3] git-apply: add --allow-empty flag
Content-Language: en-US
To:     Jerry Zhang <jerry@skydio.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <20210427194049.14399-1-jerry@skydio.com>
 <20211211031343.15818-1-jerry@skydio.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20211211031343.15818-1-jerry@skydio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/21 10.13, Jerry Zhang wrote:
> +--allow-empty::
> +	Don't return error for patches containing no diff. This includes
> +	empty patches and patches with commit text only.
> +

Looks OK.

>   	if (!list && !skipped_patch) {
> -		error(_("unrecognized input"));
> -		res = -128;
> +		if (!state->allow_empty) {
> +			error(_("unrecognized input"));
> +			res = -128;
> +		}
>   		goto end;
>   	}

When we apply empty patch but we forget --allow-empty, we got generic
"unrecognized input". So for this case, we should disambiguate the
former case and case when malformed patch input is provided.

-- 
An old man doll... just what I always wanted! - Clara
