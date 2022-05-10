Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D1FC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 13:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbiEJNOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiEJNOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 09:14:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A7054FB3
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:10:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so1397450wme.4
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PBh1GQ8mc8xEcHBS7fBQfsYQiKBQGBZhkLu9nHiA/MQ=;
        b=NGsDUQStlZjqYJH5nM3VhkEdCFKJLNHxYmE+MjWajDHv8dCMejGlh+5UIc/4+bM5w6
         vGStk6OU29Rrcy0XSDfAVMFpne5y87KPsdjWf2JfD237uGKu6+gf5kZNU7u1waYtQYke
         qV5eee/5d7aw+Q45t9dlOLVBvPNAAgywnABinYVi13H7RcNPqvzb8vHqSu8oX3U8DsHA
         jwq8KyaASXD+MWn9A73im4PFFSjhDo9XAjd3Dg6uSQvKo1wxHbKLnKXHWXKjXnhq+GNX
         bdePF885Q3ahrTo7iIRxfa4d6Me1haAdAh/nEBmLWSyLcDaN+tb6u+zoIkaNM6QIXYKS
         535w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PBh1GQ8mc8xEcHBS7fBQfsYQiKBQGBZhkLu9nHiA/MQ=;
        b=ZTw8MMOGzz0ovkvcCzamG6aC4WaLlRu10k1zTrCgHH1Iuls+HTGMIN8p6gsd1CjV0x
         XGNcnJ3pM0W1onhCqvXvp00gKxeN1+kD7OYpXkr1vyskFgM1HNF48SBoQAg72f7kRH9u
         L/DtP1uLk8E5Yy52LN5VogAgawdsWXlMvQYD8UWlEm/Yo50iOZlU0b5ZSjYQ73YaIxuC
         SX/IQ7Z7cuchfqEx7+QL+kg9rGMAMv6+RtM4wjYlCPwfrcCPFD06yqtNVrJR83ngSrV2
         LcEkfqV+e/x0a96qZP4oux/LL03zqAVHbYxoAIGiwf7NuZp90gg9bW+qFug/mA7GdP3M
         3IRg==
X-Gm-Message-State: AOAM533F/Dd3eHncxJaTY6LzHOQ1JBTc8VXdo5MEjUsEykh5jh66X5uy
        lhV94ZDzYOoA8gqDBxvp3djnsfozA+g=
X-Google-Smtp-Source: ABdhPJzZaF/KSUFdHoMmGDmJURlqkkxAD0VRnbvLDUmY4hZBTEFjVV5SAfE2VC3Pwt8Vuv2AGApLsg==
X-Received: by 2002:a1c:5459:0:b0:394:1191:a1ff with SMTP id p25-20020a1c5459000000b003941191a1ffmr27911836wmi.96.1652188208997;
        Tue, 10 May 2022 06:10:08 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id o41-20020a05600c512900b00394832af31csm4892987wms.0.2022.05.10.06.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:10:08 -0700 (PDT)
Message-ID: <091db194-2e6e-8c15-2e84-5f873fd08b55@gmail.com>
Date:   Tue, 10 May 2022 14:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 15/15] entry.c: use dir-iterator to avoid explicit dir
 traversal
Content-Language: en-US
To:     Plato Kiorpelidis <kioplato@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com
References: <20220509175159.2948802-1-kioplato@gmail.com>
 <20220509175159.2948802-16-kioplato@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220509175159.2948802-16-kioplato@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato

On 09/05/2022 18:51, Plato Kiorpelidis wrote:
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at remove_subtree() function, by the dir-iterator API. This
> simplifies the code and avoids recursive calls to remove_subtree().

Thanks for adding this conversion, it is nice to see the post-order 
traversal being used and the end result is an improvement on the original.

Best Wishes

Phillip

> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>   entry.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index 1c9df62b30..46ef145f97 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -8,6 +8,8 @@
>   #include "fsmonitor.h"
>   #include "entry.h"
>   #include "parallel-checkout.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
>   
>   static void create_directories(const char *path, int path_len,
>   			       const struct checkout *state)
> @@ -52,26 +54,24 @@ static void create_directories(const char *path, int path_len,
>   
>   static void remove_subtree(struct strbuf *path)
>   {
> -	DIR *dir = opendir(path->buf);
> -	struct dirent *de;
> -	int origlen = path->len;
> -
> -	if (!dir)
> -		die_errno("cannot opendir '%s'", path->buf);
> -	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {
> -		struct stat st;
> -
> -		strbuf_addch(path, '/');
> -		strbuf_addstr(path, de->d_name);
> -		if (lstat(path->buf, &st))
> -			die_errno("cannot lstat '%s'", path->buf);
> -		if (S_ISDIR(st.st_mode))
> -			remove_subtree(path);
> -		else if (unlink(path->buf))
> -			die_errno("cannot unlink '%s'", path->buf);
> -		strbuf_setlen(path, origlen);
> +	unsigned int flags = DIR_ITERATOR_DIRS_AFTER;
> +	struct dir_iterator *iter = NULL;
> +	int ok;
> +
> +	if (!(iter = dir_iterator_begin(path->buf, flags)))
> +		die_errno("cannot open directory '%s'", path->buf);
> +
> +	while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
> +		if (S_ISDIR(iter->st.st_mode) && rmdir(iter->path.buf))
> +			die_errno("cannot rmdir '%s'", iter->path.buf);
> +
> +		if (!S_ISDIR(iter->st.st_mode) && unlink(iter->path.buf))
> +			die_errno("cannot unlink '%s'", iter->path.buf);
>   	}
> -	closedir(dir);
> +
> +	if (ok != ITER_DONE)
> +		die_errno("failed to iterate over directory '%s'", path->buf);
> +
>   	if (rmdir(path->buf))
>   		die_errno("cannot rmdir '%s'", path->buf);
>   }

