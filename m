Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D561F453
	for <e@80x24.org>; Wed, 31 Oct 2018 13:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeJaWgH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 18:36:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43583 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeJaWgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 18:36:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id r71so9476456qkr.10
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Lodwrr+0iqIoAlZH6FZWG/W5PD5VjUqhKrrTISlMru0=;
        b=n1EKlxptlnwbiBdhyzPjb4LbPMJQ2Xd/ZDMLhqo2K+E6uz+XcDJikg+iGbiVY8XU0/
         k3LRd4r4ZGSehmKrgXHWG4c86iBU98p46jUVNjWL0XhYMIQZe0SmuLLp6VNvgJlwxXiQ
         Y1UW017QQGu3iFUBoR7Sc6Ql1/NS1wLB94ZrfFntJ6OVn8pKDw45YXmUEXqPwGJsB5/l
         ctgh5TaKdA3Dac/8lJ6t4Spl02Z9tcDy93x23vAy+yb0qRLHoStdfV8I9d8H48Aa+ouv
         H0TB2703vQLFp6z5hMskmbgIokhYwre6YXxzBa3D/JpMvBtGfSJllnomqszRD9MsYZGo
         0LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Lodwrr+0iqIoAlZH6FZWG/W5PD5VjUqhKrrTISlMru0=;
        b=ua74G71sxgzK6bArrS1/PP5EFySAM6zQTLp6XaXunSy/ybjwLZa5jP286qVVjwE0si
         G5PCxsvH9q4eJABcD8u/C8mXxMv2SP8IcnE+mgyM0aG1YbG+guoz7v+6CSrc1nCKZRIW
         Id4Ol8a9IE819CmdZv6Zjs4bUTnUp4GatvlfDFNBq2LU+lGvBV9/hF6TjAIwORHe2DY4
         8vNHx26EC/RifvRh7HzoQ5A1n1AerhQPnQQDeXb0rUAUWePbIK2qHkYGpKd8cdqZdKIJ
         XFBH+W7WZk+M3uxFb3vAkUybyLezZFWTzDbEI0JPxBOUvfFP5wNXvy5qLZLq4R5AWs+R
         qd+Q==
X-Gm-Message-State: AGRZ1gLRMAHHBbIfWgjysmT8XxiZayQRUbwM2QXO3G/LBkISJpvzzFTh
        l2Ky68cVqxudG9MkDxtvyJQ=
X-Google-Smtp-Source: AJdET5f/MwKwSDvo87i0JljH6XhDAXtrCd6uxQwqXq+QHazRYdVREz425zd3dUi2jaSvX4aRVnY2oQ==
X-Received: by 2002:a37:ba44:: with SMTP id k65-v6mr2367087qkf.239.1540993082161;
        Wed, 31 Oct 2018 06:38:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1547:f48:38e6:a522? ([2001:4898:8010:0:fe7c:f48:38e6:a522])
        by smtp.gmail.com with ESMTPSA id q62-v6sm7037090qkf.74.2018.10.31.06.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:38:01 -0700 (PDT)
Subject: Re: [PATCH 18/19] submodule: use submodule repos for object lookup
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     jonathantanmy@google.com
References: <20181016233550.251311-1-sbeller@google.com>
 <20181016233550.251311-19-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ab0f5b37-b4f1-3efc-b30f-f3b34f2a11cb@gmail.com>
Date:   Wed, 31 Oct 2018 09:38:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181016233550.251311-19-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/2018 7:35 PM, Stefan Beller wrote:
> @@ -482,14 +483,46 @@ void prepare_submodule_repo_env(struct argv_array *out)
>   			 DEFAULT_GIT_DIR_ENVIRONMENT);
>   }
>   
> -/* Helper function to display the submodule header line prior to the full
> - * summary output. If it can locate the submodule objects directory it will
> - * attempt to lookup both the left and right commits and put them into the
> - * left and right pointers.
> +/*
> + * Initialize 'out' based on the provided submodule path.
> + *
> + * Unlike repo_submodule_init, this tolerates submodules not present
> + * in .gitmodules. This function exists only to preserve historical behavior,
> + *
> + * Returns 0 on success, -1 when the submodule is not present.
> + */
> +static int open_submodule(struct repository *out, const char *path)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> +		strbuf_release(&sb);
> +		return -1;
> +	}
> +
> +	out->submodule_prefix = xstrdup(path);
> +	out->submodule_prefix = xstrfmt("%s%s/",
> +					the_repository->submodule_prefix ?
> +					the_repository->submodule_prefix :
> +					"", path);
> +
> +	strbuf_release(&sb);
> +	return 0;
> +}

Based on the recent test coverage report [1], this xstrfmt() call is never
run witha non-null the_repository->submodule_prefix. Is there a way we can
exercise that branch?

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/62f0bcf6-aa73-c192-d804-e6d69cac146f@gmail.com/
