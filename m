Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE0C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 08:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjEJINS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjEJINP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 04:13:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A90C4499
        for <git@vger.kernel.org>; Wed, 10 May 2023 01:12:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-306f9df5269so4518361f8f.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683706354; x=1686298354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XX3UCZzpfNU6VrcTj6j8g9c6ucrLSoHHbm1E3P0DIeo=;
        b=ppW/hnB3HAiwwxoIOF8jjCX19MvsDL3FHcQPRp3YqSX5jYhAqkmL8HL9vbRy61Eapn
         rEG/uqN+K7AoMxykc/jRJ3+vV5g/4koAmrznEffzKK9I0nUTzm1/m8G4pwedHgvds4gQ
         v7gFPAYsziKJWhLISMrUr8gfwXGSKPOKGp7EIYo/c+MZFmKDryEiUArYGTqU07u1gJdg
         72nFlGYgf4+SvUl4uINRdgJUP78PFGmIsASOftfqHeCZXT4nuIFyrg2oWxFXZCaiEjpJ
         eJJJhddcdVAZKASb1ZcLHNJYobi5GFWawWpLCtbnU3fwbSz9pMuN4Mn+jsPNRzZNNJCq
         HJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683706354; x=1686298354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX3UCZzpfNU6VrcTj6j8g9c6ucrLSoHHbm1E3P0DIeo=;
        b=XNjC1kV+6a6Jyojj7qoVdiN4Dge3y0k+ryzINA+B6a1pGh+aSLQtYFcjVFo/tpAUIK
         uO8cVh6by0YPajn9W6/Oc7V9tncBH0tj415/PwQW/V5l2MZj2fMd7fWF+D4brN4/BEBu
         hrXPKyPsEVCwpE9vXgia5DhE3jLaSQ40kw9II4mHIJtc2nxnExNNXBdktKk8rEWYHn0f
         4H2aHtZVby4cdmnJQFInGt+yq/LFJnpkqj1YrUfqG7ihFSlPLJ/h71W3WR8rkT4LNPAB
         mCjX0BCVvDGYizcUWZjoACqOX757jcKTu9JETgCGJrt2K3pfQYSG2OovYv2lq4H+gTGg
         2POg==
X-Gm-Message-State: AC+VfDwSYbAyPlq9T42OwPdeqKEXQexPU+fqgXwfGgjG4Bmn4XkGJlbR
        KeoSPZFL2aBsmJKya8LpGAW0fwy8gVc=
X-Google-Smtp-Source: ACHHUZ7DVnZIdms4dBz6AE5P3qGjMkSswZv4ff4E1UzbAyohTC0MuC571GUi8GJB9WvT7x8VtRIsDg==
X-Received: by 2002:a5d:5589:0:b0:307:8666:a50e with SMTP id i9-20020a5d5589000000b003078666a50emr9238730wrv.67.1683706354237;
        Wed, 10 May 2023 01:12:34 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id z6-20020adff746000000b002f103ca90cdsm16559285wrp.101.2023.05.10.01.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 01:12:33 -0700 (PDT)
Message-ID: <8c8afa4a-ae2d-5a13-f9fa-5a5e11a0c810@gmail.com>
Date:   Wed, 10 May 2023 09:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 7/7] strbuf: remove global variable
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     newren@gmail.com, peff@peff.net
References: <20230508165728.525603-1-calvinwan@google.com>
 <20230508165908.526247-7-calvinwan@google.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230508165908.526247-7-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 08/05/2023 17:59, Calvin Wan wrote:
> As a library that only interacts with other primitives, strbuf should
> not utilize the comment_line_char global variable within its
> functions. Therefore, add an additional parameter for functions that use
> comment_line_char and refactor callers to pass it in instead.

I find the revised subject and commit message much easier to understand.

> diff --git a/strbuf.c b/strbuf.c
> index d5978fee4e..eba65ca421 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1,6 +1,5 @@
>   #include "git-compat-util.h"
>   #include "alloc.h"
> -#include "environment.h"
>   #include "gettext.h"
>   #include "hex.h"
>   #include "strbuf.h"
> @@ -362,7 +361,8 @@ static void add_lines(struct strbuf *out,
>   	strbuf_complete_line(out);
>   }
>   
> -void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size)
> +void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
> +				size_t size, char comment_line_char)

I don't really object to this change as I can understand why you are 
making it, but it does make this function more cumbersome to use within 
git itself where we now have to pass the global comment_line_char 
explicitly.

> @@ -1054,7 +1055,8 @@ static size_t cleanup(char *line, size_t len)
>    * Enable skip_comments to skip every line starting with comment
>    * character.
>    */
> -void strbuf_stripspace(struct strbuf *sb, int skip_comments)
> +void strbuf_stripspace(struct strbuf *sb, int skip_comments,
> +		       char comment_line_char)

Rather than adding a new parameter here could we change the signature to

	void strbuf_stripspace(struct strbuf *sb, char comment_char)

and not strip comments if comment_char == '\0'? There doesn't seem much 
point in forcing callers to pass comment_line_char when they don't want 
to strip comments.

Best Wishes

Phillip
