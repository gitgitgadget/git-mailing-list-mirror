Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20C2C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 21:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjAaVWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 16:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAaVWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 16:22:47 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2835648C
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 13:22:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n13so938413plf.11
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 13:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mk8aBBervR0RdLRBa78q00TmOwVN5q6X8L0C3PH9RJU=;
        b=KgjgGfgUpvpoaA7ptEt5z9W7V4S2yDRX0b4NE0Ww9u/H10WFZGIFWiUxsLN2oQr5dj
         8FZD1qZ+7eg+oOb+Xip5Md9z26WxIUrBdh5DkXNm+kFTOiyHPzQfWeC5yAH8aFvjqc1Z
         yjFQK4rfn+/5Yf15YU8FHJFY2i258N0/DEhaQk7GCqdFzqsF/FlQocJQNCOJyuewKYey
         DvsPhpCnD8AsDGPu2d6Ca1va5QQ5MpBeU/VgIaK8hW5GUZdnI+Vjw0ZMaYOBumbNzuhQ
         hJKXmgz8sogEiczZF+GPmtz7SMoaSK2TAMgW5VAjqeEtibVgOW25NyzuVyt2n8ByoTci
         6dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mk8aBBervR0RdLRBa78q00TmOwVN5q6X8L0C3PH9RJU=;
        b=CAzEIfHU2TH2WLlcSE08RfXWLpBw7+bggwJMS+Kcb0HGvhy0vKD3h3dcX+crdrUw5H
         p48xHBdz4o9+y+Z6KEQhNev0lWGBc24r/GKgCrmbl/w2pQ0TPijGfmRqz3pJqX79AdMZ
         CN577y+qB9BA08N2k4X14Jnoi4FPvfrIvXo9xywm4c9RtD/UX9t+d7fN+Hu6rSkU48Ow
         QN3ZwsiwXsIDL0AJj8cXr6/F8NOkjdNzNpmXM7FPlKKSbuEnr+GxxTcbqh3vWK38ZNA3
         Ix3BsCVWxI9nxc7J7zgSW3xJZFFSrHFYiGd/RXI0RFsaZdKwzQs7cu8P+XKdXherWVEf
         E3gg==
X-Gm-Message-State: AO0yUKV8aD5RVPxra1YGB73JbIUCS9Dd6UQtQL4JRaB8srL3kffnEZif
        /s7VHUXkXIWivCJymp4Bgno=
X-Google-Smtp-Source: AK7set9FPN+BGeyMe68JxSdkGp8F0uYqpjpI49kDqZPhzl/XbVR1AlO+R78Svm70ig/Gs+1vfUFPPg==
X-Received: by 2002:a17:90b:20a:b0:22c:147d:137f with SMTP id fy10-20020a17090b020a00b0022c147d137fmr25109596pjb.17.1675200166077;
        Tue, 31 Jan 2023 13:22:46 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090a7b8100b002265ddfc13esm11127471pjc.29.2023.01.31.13.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 13:22:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 05/11] bundle-uri: parse bundle.<id>.creationToken
 values
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
        <ff629bc119b466dcd827f758b3d892fefd6a9703.1675171760.git.gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:22:45 -0800
In-Reply-To: <ff629bc119b466dcd827f758b3d892fefd6a9703.1675171760.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 31 Jan 2023
        13:29:13 +0000")
Message-ID: <xmqq4js6xuu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (info->creationToken)
> +		fprintf(fp, "\tcreationToken = %"PRIu64"\n", info->creationToken);

So, a bundle info with .creationToken set to 0 signals that the
token is missing for that bundle.  REMOTE_BUNDLE_INFO_INIT clears
all members, so unless we find a concrete value and assign to the
member, we'll have 0 in the member (and never a random value).  

Very good.

We used to avoid camelCased variable names and member names and
instead prefer snake_case; I wonder if it is still the case.
Looking at bundle.h it still seems to be the case, and we may want
to match that.

> @@ -203,6 +206,13 @@ static int bundle_list_update(const char *key, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp(subkey, "creationtoken")) {
> +		if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
> +			warning(_("could not parse bundle list key %s with value '%s'"),
> +				"creationToken", value);
> +		return 0;
> +	}

Should this be a warning, or a hard error?  I _think_ it depends on
how much we trust creationToken supplied by the bundle providers for
correctness.  If we only use the values as hint to gain performance,
and downloading the bundles in a wrong order (due to bogus
creationToken values assigned to them) does not lead to correctness
error, then warning is fine.

Looking good.
