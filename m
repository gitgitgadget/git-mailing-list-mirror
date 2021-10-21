Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B93C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 13:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E017161038
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 13:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUNeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJUNeg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 09:34:36 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C60C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 06:32:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d125so968964iof.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0LCF9Mm6ku5jnHQulJiTlc3Yb4nCgVkPWfOx9PLgptQ=;
        b=UPbEs+tVV8d9LjZ8M/4SlMHcVzqy8Ccq0rY8/5OrP5u013+zpRO6VV58nbjHpV/Ypu
         ZDrsStBvCiE+eGe8xNa5aaaqZwNDex0jofvzXYGJU3VXcj/ELS2Lrg+eW8hEMZEOrqRn
         6RUCuAQ/Xz4aqtyUkJGgGoeIrG3BOuRQbhksxpw3Ss9F7vVTTkGyQoKIzX10rcucWCg2
         1xtaRI+pBpYo0VttVhUmLVd3Rk20JNjS88wVbG3k1KNpoqZ7qrUGscxB0xpctb4YMiJc
         dcVTnv2TsrMTUkf0DQcI0btT+VaQKG1/LNvH3QIL96u85CJ5bCQRy9dJs+K3XruW/kku
         vniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0LCF9Mm6ku5jnHQulJiTlc3Yb4nCgVkPWfOx9PLgptQ=;
        b=CReMOkclUAPR34ucM76Ee9peUzw2ZEhlfJruxvCiaB5ixvbQ/hszMpNv3lGhKg3wo0
         dReRMBVlXF6EnjZfLSR+ITbFSgIBBEuBtSCCF6iiC6zP1DafMOTCVAGgkkgBnlITgdRT
         7HGpcn1FaGyslfLTyiysmyEha4RRe5T6C1KS+09WWZwROwST4WXgIQcrQZPa7hDLgVEa
         TZHr442wwnSjAih9yRsVaKgQ4bcJGskTRr3lbP9s0QrpLYCv5Pt41KGQf1U98iLrf5L1
         LXkIvE6A4DyuSASx1RUJqlmXrmFD4r/hfzo/tEcPTjZnBe7MGQDQdII2QhG424nAP6oV
         TnNg==
X-Gm-Message-State: AOAM532OlIst6muBICe0Z7Tb+sG1UY6qNlJ/PN/ORYh5IZkDkzDqNAha
        5MChgf7T/I9MFWeV/QLHgTc=
X-Google-Smtp-Source: ABdhPJz1p0X1KyYkwLBuYjpYRLRDOINC9VKNfk5lJChYpuu7YZ/2lTFCYz1mE+ERqzNO85fy5xYtUQ==
X-Received: by 2002:a05:6602:2b90:: with SMTP id r16mr4018417iov.66.1634823138958;
        Thu, 21 Oct 2021 06:32:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:144c:9bcd:5030:5cda? ([2600:1700:e72:80a0:144c:9bcd:5030:5cda])
        by smtp.gmail.com with ESMTPSA id a5sm3026382ilf.27.2021.10.21.06.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 06:32:18 -0700 (PDT)
Message-ID: <67b553b7-4e69-9906-b237-9c44cf8aaf44@gmail.com>
Date:   Thu, 21 Oct 2021 09:32:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 05/11] builtin/repack.c: avoid leaking child arguments
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
References: <cover.1634787555.git.me@ttaylorr.com>
 <a68c77c00638bef7e8ce88929015a587d2d1b6f8.1634787555.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a68c77c00638bef7e8ce88929015a587d2d1b6f8.1634787555.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/20/2021 11:39 PM, Taylor Blau wrote:
> `git repack` invokes a handful of child processes: one to write the
> actual pack, and optionally ones to repack promisor objects and update
> the MIDX.
> 
> In none of these cases do we bother to call child_process_clear(), which
> frees the memory associated with each child's arguments and environment.
> 
> In order to do so, tweak each function that spawns a child process to
> have a `cleanup` label that we always visit before returning from each
> function. Then, make sure that we call child_process_clear() as a part
> of that label.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 0b2d1e5d82..d16bab09a4 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -244,6 +244,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	FILE *out;
>  	struct strbuf line = STRBUF_INIT;
> +	int ret = 0;

nit: "ret" is short for "return" which makes me think "this will
be used as 'return ret;'" but we don't do that. Instead, we use
it as the _result_ of an inner call:

> -	if (finish_command(&cmd))
> +	ret = finish_command(&cmd);
> +
> +cleanup:
> +	child_process_clear(&cmd);
> +
> +	if (ret)
>  		die(_("could not finish pack-objects to repack promisor objects"));

For that reason, I would rename this to "res" or "result".

> -	return finish_command(&cmd);
> +	ret = finish_command(&cmd);
> +
> +cleanup:
> +	child_process_clear(&cmd);
> +
> +	return ret;

Here, you are taking the result of an inner call, but actually
returning it. This makes sense to be "ret".

> +cleanup:
>  	string_list_clear(&names, 0);
>  	string_list_clear(&rollback, 0);
>  	string_list_clear(&existing_nonkept_packs, 0);
>  	string_list_clear(&existing_kept_packs, 0);
>  	clear_pack_geometry(geometry);
>  	strbuf_release(&line);
> +	child_process_clear(&cmd);
>  
> -	return 0;
> +	return ret;

Also here is good.

Thanks,
-Stolee
