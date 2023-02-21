Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B38C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 14:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjBUOY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 09:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjBUOY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 09:24:57 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2115428859
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 06:24:56 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1720ea61e29so5205697fac.12
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 06:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mi1moy853OZYmmNP0MZay5v7G4R/rYzH7P7GxQkLrE=;
        b=dBkM36+76OLRk7rkCKSe9HwFZkQdXeY99PMZTWlPf6i6bXepUIwSNLnHR3FhDg7wba
         iqszo1hpaKyqWbLAQ71quWVsTAvnAePB1rv5Rdh/YeUZ2EhrZBfM50aFZuPZlHmrcD/X
         rCIxLp2jtxBSVr9Lfp7FJBdeY/wRIQXV+Yw/2+IMHI9UygTRnTUqHp8eQX4JgUDxiYLj
         hD6Bozwk5H8ObD5UAfK4gLcH+FlDgj3A61kSzPB0ra/sVsESKj7zRrDAy/fCXG7+Dcf+
         +QqjJblGUE2P4QivPuN7Z4tER+LgTlTJ8nMxr8gdmKdlW5W8e6zoswCiIOBnY4/pdbgx
         A9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mi1moy853OZYmmNP0MZay5v7G4R/rYzH7P7GxQkLrE=;
        b=DK7/Y4FcMnO3hetLH7SlH83hHS8jU4yk9ZFPJ8RfXTOmM1UGJYHs9YdRPxDpa3IOdV
         J0F2pF8qentt6pSU1qzeXITy0ZjITl2H/WjcbxR+DpMAUAyKc9J4c++ALcpzkIRWeVok
         gYeTCY/zaCQPOwbjNZP5wtod6Z+nAa07fWNIm3Zj4iGkk9Bt9XShyKqodiHcedv3jyO+
         CJtIsRoDWwhMTZrUYQQdWQs3RxO9zhK1VgWTc8mt7euHRyCbnCs9Iw5YzQ0N3tbUGgSg
         R8RpS5E4jkMfLcAA9SXTvxi1rDQnm3dUdW0a1FNjpeSmeXFV1n1If5Vv9xF9UfHYclai
         MacA==
X-Gm-Message-State: AO0yUKWi2QfAnk2rWav9WMTcaGIQRc2DYnBe3RUVmwfK4Nv44cHvUuzi
        TVl8sty1gPsbhL7L+1Sli25w
X-Google-Smtp-Source: AK7set+AR0dfoOaXBEc39wmTsFXHFVku/clgzqkFoCL/1g+ykj1xcWyDwTg91SORSnHh1cAlOGd03g==
X-Received: by 2002:a05:6870:b520:b0:172:156a:f027 with SMTP id v32-20020a056870b52000b00172156af027mr2511226oap.26.1676989494710;
        Tue, 21 Feb 2023 06:24:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f4bf:9183:9c31:c1de? ([2600:1700:e72:80a0:f4bf:9183:9c31:c1de])
        by smtp.gmail.com with ESMTPSA id ef5-20020a0568701a8500b00152c52608dbsm4384959oab.34.2023.02.21.06.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 06:24:54 -0800 (PST)
Message-ID: <f99d7043-7757-2e19-d1e1-4ee9b887af1f@github.com>
Date:   Tue, 21 Feb 2023 09:24:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] rebase -i: check labels and refs when parsing todo
 list
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
 <pull.1482.v2.git.1676902774366.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1482.v2.git.1676902774366.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2023 9:19 AM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>

> +static int check_label_or_ref_arg(enum todo_command command, const char *arg)
> +{
> +	switch (command) {
> +	case TODO_LABEL:
> +	  /*
> +	   * '#' is not a valid label as the merge command uses it to
> +	   * separate merge parents from the commit subject.
> +	   */
> +	  if (!strcmp(arg, "#") ||
> +		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))

Tabbing is strange here. Within the case there seems to be "\t  " to
the left of each line. Then the conditional has strange spacing. I
think it should be:

		if (!strcmp(arg, "#") ||
		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))

(The "check_refname_format()" line is correct in your patch, but the
lines above it are not, for some reason.)

The rest of the switch statement is correctly tabbed.

> @@ -2525,10 +2553,19 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  
>  	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
>  	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
> +		int ret = 0;
> +
>  		item->commit = NULL;
>  		item->arg_offset = bol - buf;
>  		item->arg_len = (int)(eol - bol);
> -		return 0;
> +		if (item->command == TODO_LABEL ||
> +		    item->command == TODO_UPDATE_REF) {
> +			saved = *eol;
> +			*eol = '\0';
> +			ret = check_label_or_ref_arg(item->command, bol);
> +			*eol = saved;
> +		}
> +		return ret;
>  	}

This diff is much simpler to understand for the purpose of this
patch. I saw your comment about splitting out TODO_EXEC for a
future change, and that would be fine when it happens, too.

Thanks for the updates. Outside of that strange whitespace issue,
this patch LGTM.

Thanks,
-Stolee
