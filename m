Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A8C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 09:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE60260FD8
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 09:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhJEJjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 05:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhJEJjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 05:39:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0FC061745
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 02:37:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s11so19229565pgr.11
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fOSjkLmHjgrBLLfMX2qt4kFPqrvx/CofR/+Pa5DaO1A=;
        b=Q71GUks95Hs6atyulN4nZ/XKrZcdSPUo3DJj+WHD1OSx+ugWqGS67Kmj3Hmg1xd38G
         zXKD5eyxt7pRAVQE/kYliuwZAILX4CanZujZY5ksj74l1fy93sATpY2GIolcbh+5f2QE
         2jJyYEE4vyKFpjK3j1RWhBBH1fVAafpIAEXLDVCmdnZL3m8zGE8JG9LQuJrRVgpoQRu+
         IF/fzeyOMiFQCo539TwcnuIWtf7u/ZwoKAx9qkdXERfhhx/bETdrap8K/66vjfUUUsvh
         vQ5kTmCro8bDQ/oIMWj1s3dWfgxuCAifXU/sl86vRShVkJklJixiLww2Mqmk8VhrO8/h
         QHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOSjkLmHjgrBLLfMX2qt4kFPqrvx/CofR/+Pa5DaO1A=;
        b=ZtEjMaid1jp/X6XAHbV8e4M7AT/7K9MmHJzUYCjFXdeBxqNYbnfU0egcKU6X5G6VcW
         YOvOLOq7j8PBXJiKaOXfcusEqjEme7tTNyAghHz3XEvBC0Ajg6RXQdPWHFd41K4l9f7Q
         8Bnjwti+hC2ot21FCgT3JZyR5hGji59oVU5sSmYYxdaROTHxBHzZZRpLYThvzpA52wyy
         ovGZ8I35nAhMah3Poa1xmILtX4BaQnNncBAK10atuKcEOyfPQZep4KOfYOd0fYF0/gj1
         4SyIbyNvcQ9VIyXtu6/sRL1Mi5Ga5lpYI89Pk4iT2Zluw8XKZS3Yl9o2d75Kpyuur/g9
         NZug==
X-Gm-Message-State: AOAM530vbY9sOPTn2TSvTmrxywywipJuRBHXgsXLsQ9owtUJzDaedWaJ
        Rk7Df3wxO2OaUbltvRxlVxg=
X-Google-Smtp-Source: ABdhPJzraGfHzWlG7oCITnTuNiGos1zmP2dNgicgsvj41P9lSXCBCvMH2KBqrmg8Btd+O3CkpCNWXg==
X-Received: by 2002:aa7:80d9:0:b029:2ed:49fa:6dc5 with SMTP id a25-20020aa780d90000b02902ed49fa6dc5mr29943371pfn.3.1633426635677;
        Tue, 05 Oct 2021 02:37:15 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-56.three.co.id. [116.206.12.56])
        by smtp.gmail.com with ESMTPSA id l19sm1925191pff.131.2021.10.05.02.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 02:37:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] object.[ch]: mark object type names for
 translation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
 <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <5d47caad-7f0b-f6ce-b055-dc21d58892cc@gmail.com>
Date:   Tue, 5 Oct 2021 16:37:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10/21 21.27, Ævar Arnfjörð Bjarmason wrote:
>   static const char *object_type_strings[] = {
>   	NULL,		/* OBJ_NONE = 0 */
> -	"commit",	/* OBJ_COMMIT = 1 */
> -	"tree",		/* OBJ_TREE = 2 */
> -	"blob",		/* OBJ_BLOB = 3 */
> -	"tag",		/* OBJ_TAG = 4 */
> +	/*
> +	 * TRANSLATORS: "commit", "tree", "blob" and "tag" are the
> +	 * name of Git's object types. These names are interpolated
> +	 * stand-alone when doing so is unambiguous for translation
> +	 * and doesn't require extra context. E.g. as part of an
> +	 * already-translated string that needs to have a type name
> +	 * quoted verbatim, or the short description of a command-line
> +	 * option expecting a given type.
> +	 */
> +	N_("commit"),	/* OBJ_COMMIT = 1 */
> +	N_("tree"),	/* OBJ_TREE = 2 */
> +	N_("blob"),	/* OBJ_BLOB = 3 */
> +	N_("tag"),	/* OBJ_TAG = 4 */
>   };
>   

Are these object type names safe for translating? (e.g. can they be 
translatable without affecting private API string, which aren't 
translatable)?

> +/*
> + * TRANSLATORS: This is the short type name of an object that's not
> + * one of Git's known object types, as opposed to "commit", "tree",
> + * "blob" and "tag" above.
> + *
> + * A user is unlikely to ever encounter these, but they can be
> + * manually created with "git hash-object --literally".
> + */
> +const char *unknown_type = N_("unknown type");
> +
>   const char *type_name(unsigned int type)

Did you mean that "unknown type" is generic shorthand?

-- 
An old man doll... just what I always wanted! - Clara
