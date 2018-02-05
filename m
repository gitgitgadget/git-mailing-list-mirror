Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDC61F404
	for <e@80x24.org>; Mon,  5 Feb 2018 17:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeBERoJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 12:44:09 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33300 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeBERoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 12:44:07 -0500
Received: by mail-qk0-f194.google.com with SMTP id c82so5656273qka.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dEJHLIvS0N4XNJy2eKgPG5zH8gcW2hzmiUGyQPxgjEM=;
        b=iHLF1UaOnkrm9BUR7U7wRxsCVcwJzVUwWwHEVN/yZMoVRbuJ3/uMMBIIgzz+4ERyUR
         s2aWNKEV61UqBpllW0F7JN0hljMoJ/yeN+FXVCyjJoyOWB2abusro/Y1AFr3XGv/3G6h
         JN/EPnR2TbyejHHrO4WmM2TnkUQEcRwyPBvekLNlXKuF4Uwh/7tdDmbzaQmByfuK9ynn
         LW0L9xjCg1GSaQFXFMHSMOmqgktY81o7Zpf55vuJRhRWf2IvYka+JBRyEsgPc0a8mU36
         gLtRmjFr7EOTyzECxswsvp2+EppISXUHNKkP765URW3qhqiiP4xFXdoh4IcbJmBIq5Lc
         VrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dEJHLIvS0N4XNJy2eKgPG5zH8gcW2hzmiUGyQPxgjEM=;
        b=ftb99kSJbMxU2fMmQODEdwsfGZX4dUWPnTTETZjZ1pjH0S/KqoVFzH8ZlOBfQzy0tA
         pB4JuWUdwEKyR66mUM27nNQRtRsOqv+XsPTF+sXk2wlTywUiY7wC3muHVQZHwNxJtCOV
         w0EegnxXGQXClFhHc4xdp4FOxUl2FP5Bxl79/E1YtNQzfG/KNDAQH1bZtZUGo6byGmFo
         cpC/haAUeA4aqJSoa1Pcv4SMV7KNssuRAvh+Gi1uI/Lo9NfrbhT7AlVzBaq5TnBsRcLD
         BavfmUgYR6KPXsB3L89aOUJ+VTltnuSslrfvaMz5BT3bnNmakl7PUARtS7dYL2x2oNSG
         hP8w==
X-Gm-Message-State: APf1xPBW1Iwu0EGsJPTJT5k9nTd58qYvrYO3jUwGqSp3RY76oegN+T8g
        I+y/NZY9c4E4B8iJhk1iaFYxqeBa
X-Google-Smtp-Source: AH8x225HhRwPbaU97FUXwxwxdiKFNXWk8gHc996Mv2HMm8tRNIqfsX7QKzjFAZHVNmB/Hdzv0REG7A==
X-Received: by 10.55.114.131 with SMTP id n125mr18556704qkc.55.1517852646514;
        Mon, 05 Feb 2018 09:44:06 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id y62sm6216316qtd.84.2018.02.05.09.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 09:44:05 -0800 (PST)
Subject: Re: [PATCH] dir.c: ignore paths containing .git when invalidating
 untracked cache
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
References: <CACsJy8DH2_gBqj3xs4Cr6kOAUsQ5hn88weMeXR8GtYCNvYgLDQ@mail.gmail.com>
 <20180204093823.3671-1-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f002344e-e8ae-84e8-a1aa-45e44c0ccc88@gmail.com>
Date:   Mon, 5 Feb 2018 12:44:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180204093823.3671-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/4/2018 4:38 AM, Nguyễn Thái Ngọc Duy wrote:
> read_directory() code ignores all paths named ".git" even if it's not
> a valid git repository. See treat_path() for details. Since ".git" is
> basically invisible to read_directory(), when we are asked to
> invalidate a path that contains ".git", we can safely ignore it
> because the slow path would not consider it anyway.
> 
> This helps when fsmonitor is used and we have a real ".git" repo at
> worktree top. Occasionally .git/index will be updated and if the
> fsmonitor hook does not filter it, untracked cache is asked to
> invalidate the path ".git/index".
> 
> Without this patch, we invalidate the root directory unncessarily,
> which:
> 
> - makes read_directory() fall back to slow path for root directory
>    (slower)
> 
> - makes the index dirty (because UNTR extension is updated). Depending
>    on the index size, writing it down could also be slow.
> 
> Noticed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   Sorry for the resend, I forgot git@vger.
> 
>   dir.c             | 13 ++++++++++++-
>   git-compat-util.h |  2 ++
>   wrapper.c         | 12 ++++++++++++
>   3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/dir.c b/dir.c
> index 7c4b45e30e..f8b4cabba9 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1773,7 +1773,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
>   	if (!de)
>   		return treat_path_fast(dir, untracked, cdir, istate, path,
>   				       baselen, pathspec);
> -	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
> +	if (is_dot_or_dotdot(de->d_name) || !fspathcmp(de->d_name, ".git"))
>   		return path_none;
>   	strbuf_setlen(path, baselen);
>   	strbuf_addstr(path, de->d_name);
> @@ -2970,8 +2970,19 @@ static int invalidate_one_component(struct untracked_cache *uc,
>   void untracked_cache_invalidate_path(struct index_state *istate,
>   				     const char *path)
>   {
> +	const char *end;
> +	int skipped;
> +
>   	if (!istate->untracked || !istate->untracked->root)
>   		return;

Thank you for this patch!  It's great to see people helping improve the 
performance of git.

I ran a quick test and this is not sufficient to prevent the index from 
getting flagged as dirty and written out to disk when fsmonitor detects 
changes for files under the .git folder.  What I'm seeing is that when 
".git/index" is returned, the test below doesn't catch them and end 
early as would be expected.

As a result, invalidate_one_component() is called which calls 
invalidate_one_directory() which increments dir_invalidated counter and 
the regular dirty process continues which triggers the index to be 
written to disk unnecessarily.

> +	if (!fspathcmp(path, ".git"))
> +		return;
> +	if (ignore_case)
> +		skipped = skip_caseprefix(path, "/.git", &end);
> +	else
> +		skipped = skip_prefix(path, "/.git", &end);
> +	if (skipped && (*end == '\0' || *end == '/'))
> +		return;

If I replace the above lines with:

	if (ignore_case)
		skipped = skip_caseprefix(path, ".git", &end);
	else
		skipped = skip_prefix(path, ".git", &end);

Then it correctly skips _all_ files under ".git".  I'm not sure if by 
removing the leading slash, I'm breaking some other case but I was not 
able to find where that was expected or needed. Removing the leading 
slash also allows me to remove the fsmpathcmp() call as it is now redundant.

I wondered what would happen if there was some other directory named 
".git" and how that would behave.  With or without this patch and with 
or without the untracked cache, a file "dir1/.git/foo" is ignored by git 
so no change in behavior there either.

>   	invalidate_one_component(istate->untracked, istate->untracked->root,
>   				 path, strlen(path));
>   }
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 68b2ad531e..27e0b761a3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -484,6 +484,8 @@ static inline int skip_prefix(const char *str, const char *prefix,
>   	return 0;
>   }
>   
> +int skip_caseprefix(const char *str, const char *prefix, const char **out);
> +
>   /*
>    * If the string "str" is the same as the string in "prefix", then the "arg"
>    * parameter is set to the "def" parameter and 1 is returned.
> diff --git a/wrapper.c b/wrapper.c
> index d20356a776..bb888d9401 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -690,3 +690,15 @@ int xgethostname(char *buf, size_t len)
>   		buf[len - 1] = 0;
>   	return ret;
>   }
> +
> +int skip_caseprefix(const char *str, const char *prefix, const char **out)
> +{
> +	do {
> +		if (!*prefix) {
> +			*out = str;
> +			return 1;
> +		}
> +	} while (tolower(*str++) == tolower(*prefix++));
> +
> +	return 0;
> +}
> 
