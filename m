Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38717EB64DC
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjFVUT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 16:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFVUTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 16:19:54 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843631BFE
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 13:19:53 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-47148f11fe6so3033300e0c.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 13:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687465192; x=1690057192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eoluqKgtzp85VZVrIoYKO67vXQHtvCe1a+Orr7oJLU=;
        b=PKTYJfnM0XBxm3hg9xR9DJbsa3bWGacGBG24tl2ZGM8p4xd34PcTOIXav2VoFyWDkg
         yiIHMLHYPLvoZNlhfPhhlVWXVd2dyK9Pe3XTEmjjMd5l4UIC5Cmxy1XO9hI+bMZTzv1y
         K74kvhxxdiYrOhbFHjgAdFYJPbpzmFz8CIdkrQM9BRLtkhoO0/ZWTB2MpwvMhChynUAG
         6LBOwEgQK0MLpywDT4dxIR2960NX+oBHE6hWO+DsFFRXonlY/wrvJ0YO8wjshC0rm20q
         TGmGwxOhdTBTaQnNMIuSaqVetn+VMs7+qHNJKwsWzGwMtQCDKh6dyJoJyEcWjuRbLiNV
         dVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687465192; x=1690057192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eoluqKgtzp85VZVrIoYKO67vXQHtvCe1a+Orr7oJLU=;
        b=km7M02nB3FWVExhNCKRn/K3MVq84nRjwArU7tyhV7okfjlJZLlBZQ/utctTeJZwoXo
         WAnLyQ2h6C02cgWwBADRv11iPluIcXV/rGRHfBTQQZ/T/Yp56X47pwWPF4+MTz4dD67z
         p5eeTTC1TUyGeB4Dy/iPK1OgLmZjVsYjviBs4P44b4+vvbjdyH7R766QTDrYIzeTEx50
         q0n6jW5EE9G3F/AIlqoHvRvC0CVmBgO4SQkwHc/mCvQ2zZV8h8EnbBq/A92sHM/vDSO2
         Yheom1g2O4rx59f9Y+rQ6a79O02Zd7uBOW3yDwxOFsMC2wYvSX3Xvd+ERoJxcy7D4VZh
         8uxw==
X-Gm-Message-State: AC+VfDzB0qR6Gy2XUnwMyX+re7ttV5hu3QdFlVvDFY+0H/wTQAIFhaNq
        envKfdFJ1W/TE2g5tvXnazMH
X-Google-Smtp-Source: ACHHUZ5K3rGd8ytrMG265L79EXx/sp65SmGDPSbjbzw/GxJZbonL7SBbc8DdWt4aVlUGL29j9ea6sw==
X-Received: by 2002:a1f:bf41:0:b0:453:b080:632d with SMTP id p62-20020a1fbf41000000b00453b080632dmr10537849vkf.0.1687465191138;
        Thu, 22 Jun 2023 13:19:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b14d:d0d8:2007:6c0f? ([2600:1700:e72:80a0:b14d:d0d8:2007:6c0f])
        by smtp.gmail.com with ESMTPSA id m17-20020a0dca11000000b0056974f3f32bsm2055186ywd.1.2023.06.22.13.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 13:19:50 -0700 (PDT)
Message-ID: <ebdf8a20-9ac7-dcf7-8cc6-b63894b7eb45@github.com>
Date:   Thu, 22 Jun 2023 16:19:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] var: add attributes files locations
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230622195059.320593-3-sandals@crustytoothpaste.net>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230622195059.320593-3-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2023 3:50 PM, brian m. carlson wrote:

>  struct git_var {
>  	const char *name;
>  	const char *(*read)(int);
> +	int free;
>  };

I see you're expanding the git_var struct, and you do it
more in patch 3. At that point, there will be two
consecutive 'int' parameters, which can make things
unclear as to how to proceed.

>  static struct git_var git_vars[] = {
> -	{ "GIT_COMMITTER_IDENT", git_committer_info },
> -	{ "GIT_AUTHOR_IDENT",   git_author_info },
> -	{ "GIT_EDITOR", editor },
> -	{ "GIT_SEQUENCE_EDITOR", sequence_editor },
> -	{ "GIT_PAGER", pager },
> -	{ "GIT_DEFAULT_BRANCH", default_branch },
> -	{ "GIT_SHELL_PATH", shell_path },
> +	{ "GIT_COMMITTER_IDENT", git_committer_info, 0 },
> +	{ "GIT_AUTHOR_IDENT",   git_author_info, 0 },

This also makes for a big diff like this.

One way to solve for this is to use the more modern style
when initializing the structs:

static struct git_var git_vars[] = {
	{
		.name = "GIT_COMMITTER_IDENT",
		.read = git_author_info,
		.free = 0,
	},
	...
}

Bonus points if you do this conversion before modifying
the struct, as later changes will only add lines to the
existing initialization...

  static struct git_var git_vars[] = {
  	{
  		.name = "GIT_COMMITTER_IDENT",
  		.read = git_author_info,
+ 		.multivalued = 0,
  		.free = 0,
  	},
  	...
  }

Thanks,
-Stolee
