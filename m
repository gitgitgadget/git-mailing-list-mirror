Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1E3C433EF
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 17:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860F66108C
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 17:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhIYRTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhIYRTh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 13:19:37 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03447C061570
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 10:18:01 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so10924811otv.4
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7oX4zfnNm0xOzKKJLWSoP98KBLcqeFl0VKzuDRLxryg=;
        b=I8XJuqehBnBySFe0tRY8GnCx90bknodlXBY2XKXbGl7LEHTGkAJ0FTcTU6EVrqE86c
         GYB4Cmq0XXFqwWnLNrVsiOz81qQB01omlrZlmJ4d543hqzk38VquzI5ZjZPsWYpYCAOM
         EKX58DDCyqgwphK7R068NqB6dxe/ZzqAob3kow9ov2DNEk7a2m5UGi5cumUE+5ZYVlHW
         CSQ5SaJSsm1VJb9XXbpcrhLnIyRO4eQU56s98s5/ZExFzazVeRFBASkRRUlUiGg2HFRB
         bZuWoSzRIcsGadtfiRjkDHs3Ldu3Ll37bR/rK0jWktHXIY2j2AlMiwt6yVJaFOp1M4Ff
         RyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7oX4zfnNm0xOzKKJLWSoP98KBLcqeFl0VKzuDRLxryg=;
        b=JG/KFJgVBjJk0+eI5Q3kK1qjkbOLexHTtISZHVDuIfoQurvFHSVh+/plKiBbkPNZnc
         6BsmfgDScdjEXIobsZA6ORYwwKdOG6RgUGH0rCIlqaGA+n/gpc9fcfTQ1xftYObSunkp
         Z1pSoDi3RubCOUIePZyS2M95P7E29nDglC6eF3UEW/DSPxgfYJhCkQTDXBJ7GDYneARG
         VUj+4TVA3s6ZANsynaKCVda/jW7rTj4wwCepn1y8gjfrXIG9aoKueIvvAN3LNjoPT7kC
         s1wOyhCl2lT+zraxCoH312p8lUoQenRkzJLnJtE1yQ3U4dOM2RnNqrKVxAg9b1jfSVyt
         iA6A==
X-Gm-Message-State: AOAM531YnID82FA0hPgZ5w2IQq1Ii4usr8IpnTRq+h9lhjnH+AFozokO
        uZ8/ImtL/3P4TdDl/Yax6Hw=
X-Google-Smtp-Source: ABdhPJz+iu+58kfgX5Rfm/Qjiu8024OX5F+ioyDEUKdAu5SJueZF/l+mI7ppJOZvUjDUgqqXUGye2A==
X-Received: by 2002:a9d:4c11:: with SMTP id l17mr9406478otf.106.1632590280310;
        Sat, 25 Sep 2021 10:18:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b8d5:1f00:5c83:e0ce? ([2600:1700:e72:80a0:b8d5:1f00:5c83:e0ce])
        by smtp.gmail.com with ESMTPSA id v186sm3093169oig.52.2021.09.25.10.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 10:17:59 -0700 (PDT)
Message-ID: <be95aff9-b2e4-c3b8-a32a-375a3053fdfb@gmail.com>
Date:   Sat, 25 Sep 2021 13:17:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3] doc/technical: update note about core.multiPackIndex
Content-Language: en-US
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20210922221342.6867-1-e@80x24.org>
 <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
 <YUy9HzRgHU2zvI4P@nand.local> <20210923201252.GA25980@dcvr>
 <20210924111136.GA15127@dcvr>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20210924111136.GA15127@dcvr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2021 7:11 AM, Eric Wong wrote:
> MIDX files are used by default since commit 18e449f86b74
> (midx: enable core.multiPackIndex by default, 2020-09-25)
> 
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  v3: I cited the wrong commit in the commit message of v2 :x

Good catch.
 
>  Documentation/technical/multi-pack-index.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
> index 1a73c3ee203e..86f40f24909a 100644
> --- a/Documentation/technical/multi-pack-index.txt
> +++ b/Documentation/technical/multi-pack-index.txt
> @@ -36,7 +36,9 @@ Design Details
>    directory of an alternate. It refers only to packfiles in that
>    same directory.
>  
> -- The core.multiPackIndex config setting must be on to consume MIDX files.
> +- The core.multiPackIndex config setting must be on (which is the
> +  default) to consume MIDX files.  Setting it to `false` prevents
> +  Git from reading a MIDX file, even if one exists.
>  
>  - The file format includes parameters for the object ID hash
>    function, so a future change of hash algorithm does not require

This looks good to me, too!

Thanks,
-Stolee
