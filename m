Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A38C6FA8E
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 00:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCCAZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 19:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCCAZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 19:25:05 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A281F43447
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 16:25:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y2so866700pjg.3
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 16:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FVeMuwQ01t661320J0cZvLyhoF4lYNwAgENP6wCnF0A=;
        b=PcdOFpGK9d9aUkOulChlZGfRosx/gYiAkpDlwwTt2IgMz9+PfBdl3l+jeG7gOrf7Pv
         yqa2udBGaKFgojd8ZkfLclneY4MVnQsM5SI4hgubc+o1RGy5X9ORFOW3kuUlHXSiqAJ+
         nn8zH6iMNTEYr0pNaOtRSCcp0VRpSRNLsEe/qUbOBujwWY8dK0PiAiqiTD8FBYugqu9i
         pPTOKP+tXV/ehlvtlApsrRuKorkv2JVl34zz285pXf3VxNyH5UriXODsDV8p0m3bjO2b
         mBc6UW0czvjuig5ep6JVHqXtjWTV81FgIYCo3DOPCzwKwbhU6dYyK/N+jGmWUcB9kRkX
         nipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVeMuwQ01t661320J0cZvLyhoF4lYNwAgENP6wCnF0A=;
        b=pg810OAjSEFvSG9W+jCu3QaJRKqMtsT7tQ32e9tfmpwsRwst4Iow8WOcyMpKjJjgfu
         1DoFZ5OPuJAN7OpXDS6WQG8J+OCPvNf+vqJEJNbAMb6ovQDSnC/M+2IMYKgVDemk2gp6
         nEnJ4iEKn7cxrQ86niaulFzamowknSJRC5SUvWiKEjJgo/n8BtytCmetqNncnNuEhJxs
         o6XG+YD83b9SoqsR8VG65XIrGG82Qhaaz8yOUn3e2l423ekgRShsTzT2cA5ASvHSja/6
         G77OVFb7ghwhT4z6y5Jdv8A7Svf114g2kwC2NZ9+NAeYoPbRPuMv9XI8JGE7QdUWaSH9
         MyBQ==
X-Gm-Message-State: AO0yUKW0SVJgxuZRumF9L61eTILJDQKVjKo3T9l2FF/VJ1HDXrD2qSa8
        YF3tFsTScAQt0PIPFszNJSE=
X-Google-Smtp-Source: AK7set8Aqn8+1XsJDo3Py72H9g/xdozQCKJ1019QaNp8kG8ZzxTjbiqLaiLYNTo2U1pAGuC+ZLVw3Q==
X-Received: by 2002:a17:902:ed8c:b0:19c:bd2c:b33b with SMTP id e12-20020a170902ed8c00b0019cbd2cb33bmr163013plj.11.1677803103970;
        Thu, 02 Mar 2023 16:25:03 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902eb5200b001991e4e0bdcsm228802pli.233.2023.03.02.16.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:25:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v9 2/6] submodule: rename strbuf variable
References: <20230209000212.1892457-1-calvinwan@google.com>
        <20230302220251.1474923-2-calvinwan@google.com>
Date:   Thu, 02 Mar 2023 16:25:03 -0800
Message-ID: <xmqqv8jiheao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> A prepatory change for a future patch that moves the status parsing
> logic to a separate function.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  submodule.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

> Subject: Re: [PATCH v9 2/6] submodule: rename strbuf variable

What strbuf variable renamed to what?

I have a feeling that squashing this and 3/6 into a single patch,
and pass buf.buf and buf.len to the new helper function without
introducing an intermediate variables in the caller, would make the
resulting code easier to follow.

In any case, nice factoring out of a useful helper function.

> diff --git a/submodule.c b/submodule.c
> index fae24ef34a..faf37c1101 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1906,25 +1906,28 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  
>  	fp = xfdopen(cp.out, "r");
>  	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
> +		char *str = buf.buf;
> +		const size_t len = buf.len;
> +
>  		/* regular untracked files */
> -		if (buf.buf[0] == '?')
> +		if (str[0] == '?')
>  			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>  
> -		if (buf.buf[0] == 'u' ||
> -		    buf.buf[0] == '1' ||
> -		    buf.buf[0] == '2') {
> +		if (str[0] == 'u' ||
> +		    str[0] == '1' ||
> +		    str[0] == '2') {
>  			/* T = line type, XY = status, SSSS = submodule state */
> -			if (buf.len < strlen("T XY SSSS"))
> +			if (len < strlen("T XY SSSS"))
>  				BUG("invalid status --porcelain=2 line %s",
> -				    buf.buf);
> +				    str);
>  
> -			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
> +			if (str[5] == 'S' && str[8] == 'U')
>  				/* nested untracked file */
>  				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>  
> -			if (buf.buf[0] == 'u' ||
> -			    buf.buf[0] == '2' ||
> -			    memcmp(buf.buf + 5, "S..U", 4))
> +			if (str[0] == 'u' ||
> +			    str[0] == '2' ||
> +			    memcmp(str + 5, "S..U", 4))
>  				/* other change */
>  				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
>  		}
