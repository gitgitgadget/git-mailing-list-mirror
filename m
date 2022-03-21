Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A5DC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 05:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiCUFXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 01:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245302AbiCUFXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 01:23:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7036B3D4B4
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 22:22:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so13431659pjl.4
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j7PGdPcZM3p80bYnJK9eDTtxDPxL2dIvCiikvFRYc80=;
        b=i2+2P6zqyRsUd+4nw/R1w88GaSR9VRk/Wv2VU2/NRLA1KzzLbJ9Afa5cB3ldGphF0A
         +psOPKcJNGB8eAVIGoPg8jtt7OJbfI7aEgsutASseTGblRtQZ0m4kefj7xV4o3Ezrm+X
         /rim1kvz6u1w3IylwDMZ17kH8HpDRWnTb4yL/gAcLKx6E6wozEQ7sO77DSpu5OIjZMs6
         lDeaOQI9rIvjQX5eZ2K7dF9I4dJ6OmPM5KpcHaMnvmZ9XbcXc2Fcm6/01Bm4LAU2p55d
         k9eYqYd12XJlV6pvg+5Br2qgz+K0Q9bNr5SLiWyayBUpMA8H/Io0L5DC+V68aC90Hcxt
         r6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j7PGdPcZM3p80bYnJK9eDTtxDPxL2dIvCiikvFRYc80=;
        b=rfOOyEzTYw573mybdI2AWvwX19S/TRpTH4Z7tQe/jmmv91C2zIW2rvZEJq6T6UHU6H
         WQb8TBE2DxdsSoWHEpZlvbCy6k0pTqLfYpRbkLbtpnuGjLnMfuTeYi22oB5iaNsmxfg4
         Ji0y2O51zDvAeoYj8Op6YNlVmQ0ND9QUiR3bJkUuX9gda4GAhaJdHXuygjoZKY4P98dK
         9sMpwa0ocpNLml9W1Imvo3FKDukAYNDSf3wHOxTp+CQSSO2Pw1CQXdmm8yWMI8Jc1FtE
         vzo5ZFvdowhLg8VeVNO6BPdDvw8yK9fO2x2NOnTqCaedkLnSpbomZYCW+pyhTsPUy6Tz
         SD9g==
X-Gm-Message-State: AOAM533ooA9M66LawCOxYjjDNN01bx14wZl9k+DrbpSGqgPHqx8rCpK+
        6lwMWb3Om5Ebx1QpDSsFXRM=
X-Google-Smtp-Source: ABdhPJxYh5VsJohXyMel88eL1gPbRBGtlRj1vZ+Se/o+NtHNiC5/1c/gojf3l/VYUI6qnSGNgU6TVw==
X-Received: by 2002:a17:902:7e47:b0:151:7d11:3e9f with SMTP id a7-20020a1709027e4700b001517d113e9fmr11210198pln.162.1647840134912;
        Sun, 20 Mar 2022 22:22:14 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-17.three.co.id. [116.206.28.17])
        by smtp.gmail.com with ESMTPSA id 2-20020a620502000000b004f6d2975cbesm17026425pff.116.2022.03.20.22.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 22:22:14 -0700 (PDT)
Message-ID: <19947a0f-fdc2-eb80-741b-0ba5ed6335d8@gmail.com>
Date:   Mon, 21 Mar 2022 12:22:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/7] sequencer: factor GIT_AUTHOR_* from message strings
Content-Language: en-US
To:     Bagas Sanjaya via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
 <8bdbb32f54421f99be55493257b31b203a11f202.1647813292.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <8bdbb32f54421f99be55493257b31b203a11f202.1647813292.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/03/22 04.54, Bagas Sanjaya via GitGitGadget wrote:
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Factor messages containing GIT_AUTHOR_* variable.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   sequencer.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 84eed9e96bc..647f5efa656 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -848,17 +848,17 @@ int read_author_script(const char *path, char **name, char **email, char **date,
>   	for (i = 0; i < kv.nr; i++) {
>   		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
>   			if (name_i != -2)
> -				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
> +				name_i = error(_("'%s' already given"), "GIT_AUTHOR_NAME");
>   			else
>   				name_i = i;
>   		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
>   			if (email_i != -2)
> -				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
> +				email_i = error(_("'%s' already given"), "GIT_AUTHOR_EMAIL");
>   			else
>   				email_i = i;
>   		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
>   			if (date_i != -2)
> -				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
> +				date_i = error(_("'%s' already given"), "GIT_AUTHOR_DATE");
>   			else
>   				date_i = i;
>   		} else {
> @@ -867,11 +867,11 @@ int read_author_script(const char *path, char **name, char **email, char **date,
>   		}
>   	}
>   	if (name_i == -2)
> -		error(_("missing 'GIT_AUTHOR_NAME'"));
> +		error(_("missing '%s'"), "GIT_AUTHOR_NAME");
>   	if (email_i == -2)
> -		error(_("missing 'GIT_AUTHOR_EMAIL'"));
> +		error(_("missing '%s'"), "GIT_AUTHOR_EMAIL");
>   	if (date_i == -2)
> -		error(_("missing 'GIT_AUTHOR_DATE'"));
> +		error(_("missing '%s'"), "GIT_AUTHOR_DATE");
>   	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
>   		goto finish;
>   	*name = kv.items[name_i].util;

Looks OK. Thanks for picking this up.

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
