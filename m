Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F00C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCWTk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCWTkY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:40:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687381F5E1
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:40:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y14so21777159wrq.4
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679600421;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk5bPaQz9W445Zas6GvPSSU7IBycDTTXzL7oBm0wUWQ=;
        b=JrOKSSmZLJ6FaOYsYZ+GwySLieFlVAL/0RVZROqwd4VXRR+cDEzvumzk4NKpZE/uMC
         saqqmSJRvhMnasN1AWRnr4PYedMMi++3nMxiK2tR5zxTgMiFaqxjooU/ZxWkJUaniW0l
         N8A5w61jqV7CQgTsRt0tzyR/GRkhfn5sPdLu48OmPfg1p6sUjX350EfCnMGC8YBpP/xW
         MCX7eZ2I42ZzFmlp1mV+gXT6ANfm5oUPhdUmadUyGtTpE5lecQwNbGHfTmBMIzqnSXDP
         8mNPABMlEHxqBGF4zJjCqYRSuFFGheelSiEIf8yZkjRmBTPA1o4qBguLgg9UqS6D+SoP
         zuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600421;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk5bPaQz9W445Zas6GvPSSU7IBycDTTXzL7oBm0wUWQ=;
        b=BV5myfs22/oP+YJ8OB308iU5fup3Vnedu3xzKOm7BLLgvckGl3Ru2ACUe5TsclvK8H
         JIBnggCjpOdpGAbXMm1/3TVUplIYIxXHdxddVe0JM9niY1U2wS68o+ZK7+8oFBYYWOTk
         mXwTFJnDBZFdRcn9wmgOhR4uX/jxLvjjJKEwNs0p5G+OWZUTV1dVmSK9ncgxBy9r18dY
         3TRjo1DO5Km4SXjADcw0EeUetNRlnyS3L6GBYKkGWo3Bl+Z0OEIXizGuOxF6e+KyjYnZ
         fVDHy02IZ9KsR5PeopU+SQuJZpZHRof0+uN63/coc1hAAc4POIAusT9gvYOhVLNjFSAW
         NkCw==
X-Gm-Message-State: AAQBX9et2O2l5pnU3C7v/E+t+porLNDCsd62YGUoV9PcQaRZ4oVzwVgE
        qcvYYitT9JMYcCYLIDnjUl0=
X-Google-Smtp-Source: AKy350Z+6SvKpfIZQa5ymvLQvJh9tgc84TijXdwCqPfrUBDur3gprqGF2MvAjfGkXzvBx7nmR8fCEg==
X-Received: by 2002:adf:ec86:0:b0:2ce:a8d6:309a with SMTP id z6-20020adfec86000000b002cea8d6309amr219268wrn.61.1679600420765;
        Thu, 23 Mar 2023 12:40:20 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id b9-20020adfde09000000b002daeb108304sm3746113wrm.33.2023.03.23.12.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:40:20 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <2b296b75-3f8d-28a9-a3d8-8134450852da@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 19:40:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/8] rebase: simplify code related to imply_merge()
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-2-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-2-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> The code's evolution left in some bits surrounding enum rebase_type that
> don't really make sense any more. In particular, it makes no sense to
> invoke imply_merge() if the type is already known not to be
> REBASE_APPLY, and it makes no sense to assign the type after calling
> imply_merge().

These look sensible, did imply_merges() use to do something more which 
made these calls useful?

Best Wishes

Phillip

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>   builtin/rebase.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5b7b908b66..8ffea0f0d8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -372,7 +372,6 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
>   
>   	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
>   	opts->keep_empty = !unset;
> -	opts->type = REBASE_MERGE;
>   	return 0;
>   }
>   
> @@ -1494,9 +1493,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		}
>   	}
>   
> -	if (options.type == REBASE_MERGE)
> -		imply_merge(&options, "--merge");
> -
>   	if (options.root && !options.onto_name)
>   		imply_merge(&options, "--root without --onto");
>   
> @@ -1534,7 +1530,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   
>   	if (options.type == REBASE_UNSPECIFIED) {
>   		if (!strcmp(options.default_backend, "merge"))
> -			imply_merge(&options, "--merge");
> +			options.type = REBASE_MERGE;
>   		else if (!strcmp(options.default_backend, "apply"))
>   			options.type = REBASE_APPLY;
>   		else
