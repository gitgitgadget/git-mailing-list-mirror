Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B846C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B669C20774
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJL1RQPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMSLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgHMSLp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:11:45 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2226C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 11:11:44 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id o21so5833146oie.12
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HFnaFBBh0/lYyX3jEZzKHKW+cXDnSxHIZI3NqNHg0KI=;
        b=mJL1RQPyBAhDtxmC/pvj5zFwofj2LKaK3CudAek/z4rPfVymeaDmxT+a/xi70NVXEb
         IcGtppBy6WTVona/qo4zUfHH9zfSpUiKxiYpowtPxflp2aMRCIDaGQLeu1I1DQgGf3rA
         gqJNwhZv8d4pI5xDwKOHHEHCx1/Y3zZ2nwkZO/dHrpusQ3QGEEq3hcA9b6zVk8CMaDY8
         kaWagbQz6sD6rz0mvPTWo591K+jvMenXg59tr7KFhtelqrtwWDjOECOPUKwu5KDQTAMi
         s/s7dzCLC9n1NInvHW+kK4xbHU3om+/m2oru4i+GJEuaZL4HKLRK6m9TOvSDOZpYua6+
         EJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFnaFBBh0/lYyX3jEZzKHKW+cXDnSxHIZI3NqNHg0KI=;
        b=Q9twnBXdxMQwLcxMZ+D2IjZy4xcjJpwxh2V07wMTKf1TxaqTRHWtd6pgsvkA6SNp8w
         uBuFrc1EQKxkQhGgVMUNB42vF7HggunwoxxDA0SaCxJ40o2Q3l/2N7i0WVHrtOV7y3zL
         V77YxS7mNX/7/qtCPXPnewoFBKB7J1Hwi8W8VsGpJw7PAO3bUk6iWxUsgDZSx44OCOww
         4MppS5yVFSjvlkhueBHbpGdCvtCn7WHudFXa70hEj48wX5hgTSM00m0LkJGf5IX/xfay
         9eEyJuJ4hX9DXtMMuv5Y2V5ax7xd5f7GGztpCXNFW4fAvs1/+6/N1qrroR/sIhyeTWnI
         /G2w==
X-Gm-Message-State: AOAM532Cd00FGBQB/AsR4pD/NMlh4josz5olladV1HggqzjOSH11tSkx
        NbWwAJdoesW/MekMMd82TPgFYF+r7QE=
X-Google-Smtp-Source: ABdhPJwiXJBdKHA07uKp8/fNfvJLua3/SaV/K/s2Bhs/L7SYCtAnjwl3zD4AWfIjlem9T3iwVS2W/g==
X-Received: by 2002:aca:1706:: with SMTP id j6mr4557304oii.60.1597342304031;
        Thu, 13 Aug 2020 11:11:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id o11sm1398451oic.0.2020.08.13.11.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 11:11:43 -0700 (PDT)
Subject: Re: [PATCH 2/2] ls-remote: simplify UNLEAK() usage
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200813155426.GA896769@coredump.intra.peff.net>
 <20200813155551.GB897132@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <df89c33b-87c7-8d1e-501f-f0660aecbed0@gmail.com>
Date:   Thu, 13 Aug 2020 14:11:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200813155551.GB897132@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 11:55 AM, Jeff King wrote:
> We UNLEAK() the "sorting" list created by parsing command-line options
> (which is essentially used until the program exits). But we do so right
> before leaving the cmd_ls_remote() function, which means we have to hit
> all of the exits. But the point of UNLEAK() is that it's an annotation
> which doesn't impact the variable itself. We can mark it as soon as
> we're done writing its value, and then we only have to do so once.
> 
> This gives us a minor code reduction, and serves as a better example of
> how UNLEAK() can be used.

LGTM. In hindsight, it's obvious that UNLEAK() can be called before we are
done using a variable. Otherwise, we'd just free() it instead.

-Stolee

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/ls-remote.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index ea91679f33..092917eca2 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -83,6 +83,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  	dest = argv[0];
>  
> +	UNLEAK(sorting);
> +
>  	if (argc > 1) {
>  		int i;
>  		pattern = xcalloc(argc, sizeof(const char *));
> @@ -107,7 +109,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  
>  	if (get_url) {
>  		printf("%s\n", *remote->url);
> -		UNLEAK(sorting);
>  		return 0;
>  	}
>  
> @@ -122,10 +123,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
>  		repo_set_hash_algo(the_repository, hash_algo);
>  	}
> -	if (transport_disconnect(transport)) {
> -		UNLEAK(sorting);
> +	if (transport_disconnect(transport))
>  		return 1;
> -	}
>  
>  	if (!dest && !quiet)
>  		fprintf(stderr, "From %s\n", *remote->url);
> @@ -150,7 +149,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  		status = 0; /* we found something */
>  	}
>  
> -	UNLEAK(sorting);
>  	ref_array_clear(&ref_array);
>  	return status;
>  }
> 

