Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9401C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 19:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLITdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 14:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLITdm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 14:33:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B2AC6F9
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 11:33:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so6161149wrv.10
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vYut0WCgw71Jj8QLDYA5MmLbajrIfdh9Z+dMhyONyM=;
        b=AfmlbqjLYTM9y2mlSOtUm0gAkZktcxTax3Tk6il6W13ilw2xRvbumGr0kQx8Isl6lY
         pyLdVJ5ankphhnxPpvZnCLzPxRkbQ55KK+dS6UINn6crqU0vpZIEZUqSJgwSPwDYOyES
         yeJnlNWwxZQWaeVjCxT9lVCEq6hWM3Gh0oxrcv+Oy/aS9d2VUgnoTMhETtxFYwHsmg3g
         PVaNYPxGv00NnCtlNfly2RIzMrBmhIjErZZ2rcyjel8Ekc9vwsLko5ijpkQoEGQis5Fw
         g1+FZWcfdehQgdSvYdb9zKpn/mtXMNUduKYCUb86oN6dZ/nEOlUTXVVU1G8yiNYyaCbE
         gXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vYut0WCgw71Jj8QLDYA5MmLbajrIfdh9Z+dMhyONyM=;
        b=xe6CNtaP98Qa0+53YBrs02tjMMJ75BjY3ZNv651yQ47WC0ShW2AHnfuVF7H7iinoS/
         komRVxubGG1u6ASoeeq915DHgK91kCZUQUF/xhFJk4uFV8CYpXLf9kfhIOmfd9LnPPex
         lNcZycBx8dR72lbLga5Bkg3ijCiSYWEG6GyD0Ti+lWw3wcC6IWlP+HsC+uL5Jlw0kEB4
         kS8JXydVJRSiw9oZJ6smtnP8X5UcNcZO/qbvKPt3PQqcw/P1puul4VxBk8HvMHuBaOpk
         i2S3GDKZrSPn3+RSh4NhLogobQrBDJYcULayye/qCgiVHRh1jJXhBKVoUqt+Pg71ME/h
         4Pnw==
X-Gm-Message-State: ANoB5pm+9+W0LhzTfHtW+4RoSE97X6lyDPhT0oxEIc8Ecc1EqwX1+yz9
        8/IOCykjBWHFV+TQdORlvIcBKcucQQk=
X-Google-Smtp-Source: AA0mqf4qEg5J1XjWFVQ4Vtgp5bLgM8BDOpNaaiyrLNT6OVoJEJZmN9gAXV/C4ldN+qmYk8bySdT6FQ==
X-Received: by 2002:a05:6000:49:b0:242:5cc4:db0 with SMTP id k9-20020a056000004900b002425cc40db0mr4869574wrx.41.1670614419064;
        Fri, 09 Dec 2022 11:33:39 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm2141519wrb.113.2022.12.09.11.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 11:33:38 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
Date:   Fri, 9 Dec 2022 19:33:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
Content-Language: en-US
To:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
References: <20221209150048.2400648-1-toon@iotcl.com>
 <20221209150048.2400648-2-toon@iotcl.com>
In-Reply-To: <20221209150048.2400648-2-toon@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Toon

On 09/12/2022 15:00, Toon Claes wrote:
> Since it's supported to have NUL-delimited input, introduced in
> db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with `-z`,
> 2022-07-22), it's possible to pass paths that contain newlines. This
> works great when the object is found, but when it's not, the input path
> is returned in the error message. Because this can contain newlines, the
> error message might get spread over multiple lines, making it harder to
> machine-parse this error message.
> 
> With this change, the input is quote-formatted in the error message, if
> needed. This ensures the error message is always on a single line and
> makes parsing the error more straightforward.

Thanks for working on this. I'd previously suggested NUL terminating the 
output of "git cat-file -z" to avoid this problem [1] but quoting the 
object name is a better solution. The implementation looks good, thanks 
for adding a test - are you sure we need the FUNNYNAMES guard on the 
test even though it isn't creating files with funny names?

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/66b71194-ad0e-18d0-e43b-71e5c47ba111@gmail.com/

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>   builtin/cat-file.c  | 10 ++++++++++
>   t/t1006-cat-file.sh |  8 ++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b3be58b1fb..67dd81238d 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -14,6 +14,7 @@
>   #include "tree-walk.h"
>   #include "oid-array.h"
>   #include "packfile.h"
> +#include "quote.h"
>   #include "object-store.h"
>   #include "promisor-remote.h"
>   #include "mailmap.h"
> @@ -475,6 +476,13 @@ static void batch_one_object(const char *obj_name,
>   	result = get_oid_with_context(the_repository, obj_name,
>   				      flags, &data->oid, &ctx);
>   	if (result != FOUND) {
> +		struct strbuf quoted = STRBUF_INIT;
> +
> +		if (opt->nul_terminated) {
> +			quote_c_style(obj_name, &quoted, NULL, 0);
> +			obj_name = quoted.buf;
> +		}
> +
>   		switch (result) {
>   		case MISSING_OBJECT:
>   			printf("%s missing\n", obj_name);
> @@ -499,6 +507,8 @@ static void batch_one_object(const char *obj_name,
>   			       result);
>   			break;
>   		}
> +
> +		strbuf_release(&quoted);
>   		fflush(stdout);
>   		return;
>   	}
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 23b8942edb..232bfd1723 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -447,6 +447,14 @@ test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
>   	test_cmp expect actual
>   '
> 
> +test_expect_success FUNNYNAMES '--batch-check, -z with newline in non-existent named object' '
> +	printf "HEAD:newline${LF}embedded" >in &&
> +	git cat-file --batch-check -z <in >actual &&
> +
> +	printf "\"HEAD:newline\\\\nembedded\" missing\n" >expect &&
> +	test_cmp expect actual
> +'
> +
>   batch_command_multiple_info="info $hello_sha1
>   info $tree_sha1
>   info $commit_sha1
> --
> 2.39.0.rc0.57
