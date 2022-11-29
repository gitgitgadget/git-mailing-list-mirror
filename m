Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ED3C43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiK2BDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiK2BDg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:03:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FAF29365
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:03:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so264177pjt.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hG9+MmNJl5MAW927ldLPStkhHAM06FBJ6Y0dG3jikRY=;
        b=AL+u52Vm8K8c4s3AwFCpIJVnUSayLMsrnbDJONktXvVn7vTf5QPPblS9aYdKDKf729
         3FjA0HgV4OTcXNYCF4xzCfyPY+AjgfKCIsGQlK3/HXjT+tCsuuwcMCprKoyief4ozh3H
         kBM+iOuWbTfOGrDU7UK9uHdXvPjfN7KYi/+u5yjrNZunvV2A2B+KVhz+PN5kaf59Uqk1
         +754SIUFRsi8WZ/tV1qRBfmXzl1g8xs5hLoMAQtLMxG5V3LPBItM9hIMDX0mfAhp1yXH
         tLNAJda3s9vI0SXORQBpUX3f+TgGgaZt5WQTSWN3OUUS6WzulRUnxuVWLlxFQaPa4HDJ
         z6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hG9+MmNJl5MAW927ldLPStkhHAM06FBJ6Y0dG3jikRY=;
        b=Vzv7qLR/l/LjCdyXmQh6tKdObl1Dc6kZc6lzZMRlk57x/sTa3kBMfKKbB5xtx616pA
         La2aOFuaClhGfUslKX5BHzxhvyk00T4jawjgZMerp1y2CYZaoeKHlC0Njy5vlB9C1hVG
         1zqjF826+hhAFZI5M072f7gjoY8mfW0TKsPys1JVGDszuDaIw4b8u58uWDwNUOOWB9qP
         bV7sZAvQCoIESbRd3sDJ+TZVGW9WXLmdfvVsQRZcsTQ3PiYoXS0/azyA8jOZWf88csnS
         BZ6dTN/2k4j8thh+XITb/NsDdyKGDIbwJeODzG+6OZxMHbmcCnrrKCg2CPS2s9HBUwEY
         DytA==
X-Gm-Message-State: ANoB5pmDS/OY6d4tWC+J6a4NBa2g1j1U8NCZuh3mpGWkin8W3LKWXgUd
        woIpKCjx+7+UE3U4Ctll6gyC
X-Google-Smtp-Source: AA0mqf50j4CFgHVXoHqFqZqPVSubRu+gH3xqqq+hDSuO1sCwjY1EIX14NfdpVtQq2CXQ6mVp0Fe5mg==
X-Received: by 2002:a17:90a:294f:b0:213:d04:7529 with SMTP id x15-20020a17090a294f00b002130d047529mr61596304pjf.181.1669683815027;
        Mon, 28 Nov 2022 17:03:35 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b00189240585a7sm9463882plg.173.2022.11.28.17.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 17:03:34 -0800 (PST)
Message-ID: <be89bbec-1a8b-1337-a5f7-f43420da64de@github.com>
Date:   Mon, 28 Nov 2022 17:03:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 6/9] strbuf: introduce strbuf_strip_file_from_path()
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <7d86852c01513ee131bf993302416f4c881a0bc6.1668628303.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <7d86852c01513ee131bf993302416f4c881a0bc6.1668628303.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The strbuf_parent_directory() method was added as a static method in
> contrib/scalar by d0feac4e8c0 (scalar: 'register' sets recommended
> config and starts maintenance, 2021-12-03) and then removed in
> 65f6a9eb0b9 (scalar: constrain enlistment search, 2022-08-18), but now
> there is a need for a similar method in the bundle URI feature.
> 
> Re-add the method, this time in strbuf.c, but with a new name:
> strbuf_strip_file_from_path(). The method requirements are slightly
> modified to allow a trailing slash, in which case nothing is done, which
> makes the name change valuable. The return value is the number of bytes
> removed.

*Extremely* minor point, but why return anything at all? The call in the
next patch doesn't use the return value, and some similar-in-spirit 'strbuf'
functions (like 'strbuf_trim()') return nothing. 

I don't think this is worth changing if you can imagine using that return
value for something eventually; just wanted to point it out as something to
(optionally) consider if you re-roll for something else anyway.

> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  strbuf.c |  9 +++++++++
>  strbuf.h | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/strbuf.c b/strbuf.c
> index 0890b1405c5..8d1e2e8bb61 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1200,3 +1200,12 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
>  	free(path2);
>  	return res;
>  }
> +
> +size_t strbuf_strip_file_from_path(struct strbuf *buf)
> +{
> +	size_t len = buf->len;
> +	size_t offset = offset_1st_component(buf->buf);
> +	char *path_sep = find_last_dir_sep(buf->buf + offset);
> +	strbuf_setlen(buf, path_sep ? path_sep - buf->buf + 1 : offset);
> +	return len - buf->len;
> +}
> diff --git a/strbuf.h b/strbuf.h
> index 76965a17d44..4822b713786 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -664,6 +664,18 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
>  int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
>  			      const char *const *env);
>  
> +/*
> + * Remove the filename from the provided path string. If the path
> + * contains a trailing separator, then the path is considered a directory
> + * and nothing is modified. Returns the number of characters removed from
> + * the path.
> + *
> + * Examples:
> + * - "/path/to/file" -> "/path/to/" (returns: 4)
> + * - "/path/to/dir/" -> "/path/to/dir/" (returns: 0)
> + */
> +size_t strbuf_strip_file_from_path(struct strbuf *buf);
> +
>  void strbuf_add_lines(struct strbuf *sb,
>  		      const char *prefix,
>  		      const char *buf,

