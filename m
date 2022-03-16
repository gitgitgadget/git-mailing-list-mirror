Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F7AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 14:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiCPOsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356884AbiCPOr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 10:47:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF46E39B9F
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:46:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m12so2986749edc.12
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UjMkRE+q9lOymor4AUrH3R50vnoZGq8EumHpV6Wyro4=;
        b=NH6ufhjwCHO49mFrKVbAxtoStEVAiQg7RPS90nzeLUidq/4JS+Ut/Oqido0PvjUEeA
         /TpOMI77NVeyO011gUy/TBk2dnAVTvgScHuB7sr4YKh5gG68QDzJI7euQltx/vHuaKXU
         z2IDql1voHTsxnnj355PWB81Vd5us5kThFgM13wAAGwgV8QzRgWyrfpz+B7PC0hFCXqx
         HGBHqK7BbqKGVR1/9pcvYY9xHwwjwIu90+epvRQi7LmKw9Udy/0Zps55BSX7eC3edSSS
         Te121e3x/gSn5OzP9OpdBeeOPgdPqQ6nVPAoxTcUVoV58wxhFCDreaMaxQElMlNlWq3D
         8lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UjMkRE+q9lOymor4AUrH3R50vnoZGq8EumHpV6Wyro4=;
        b=m5DigWiy6hd1JakmTw0vG5Y2AdE8idg9LwnBRlaveitYQhg9ShrataFUc4HCDz1tCP
         nRzVnDVoDnJ//gLtQzBFSLFmKpLHWBcG/TaioMeL2VIcgnUxsyLouh12GIPPbyedBP6/
         csYYfKYezda7g+K478D0KhA9PcX7+HWev0g/UAzjBQGeSrOdv0aNLMuNkOieL6gCj93Y
         L7TrC1pOyhhoaR5HP7Ugfx+RFCIouKABnyMJmgdTBmiXO2rGLtzp+IO8EpiS8Jvxf9bd
         qFNM/zpqmyT+WkuNsq2/G/BSpeHDUat2zJz0Nm0uACwxD2C5VTFgKrTwpgyPbE29nyGF
         aWGQ==
X-Gm-Message-State: AOAM532IhfJw7uVqOgtXqKH7lctO0tKV8M8F2JdmnLVeqrMspgWQvYRW
        5qCy6YRctXRfmA5kKcWgBQfgyXJpfoA=
X-Google-Smtp-Source: ABdhPJw8lHLb8Bl4I/95Rvv/WXrzSaaqi/Ib55ZHtm3aONADABugWt1jyymPhE7cgrSnCbjsHcuSxA==
X-Received: by 2002:aa7:dc0b:0:b0:413:ce06:898e with SMTP id b11-20020aa7dc0b000000b00413ce06898emr30265953edu.244.1647442000163;
        Wed, 16 Mar 2022 07:46:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090606c200b006a728f4a9bcsm983543ejb.148.2022.03.16.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:46:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nUUv8-001Sze-PI;
        Wed, 16 Mar 2022 15:46:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/2] curl: streamline conditional compilation
Date:   Wed, 16 Mar 2022 15:43:09 +0100
References: <20220316140106.14678-1-gitter.spiros@gmail.com>
 <20220316140106.14678-2-gitter.spiros@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220316140106.14678-2-gitter.spiros@gmail.com>
Message-ID: <220316.86h77ydkfl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 16 2022, Elia Pinto wrote:

[Meta: Please chehck the -vN and --in-reply-to options to
git-format-patch et al, i.e. make a v2 a v2, and have it reply to the v1
patch or cover-letter.]

> Earlier we introduced git-curl-compat.h that defines bunch of
> GIT_CURL_HAVE_X where X is a feature of cURL library we care about,
> to make it easily manageable to conditionally compile code against
> the version of cURL library we are given.
>
> There however are two oddball macros.  Instead of checking
> GIT_CURL_HAVE_CURL_SOCKOPT_OK and using a fallback definition for
> CURL_SOCKOPT_OK macro, we just defined CURL_SOCKOPT_OK to a safe
> value when compiling against an old version that lack the symbol.

The way it was being done before was intentional & discused on list.

See my original
https://lore.kernel.org/git/patch-v3-7.7-93a2775d0ee-20210730T092843Z-avarab@gmail.com/
which did it pretty much like that, and Junio's subsequent
follow-up. I.e. this breadcrumb trail:
https://lore.kernel.org/git/?q=CURL_SOCKOPT_OK

> -#if LIBCURL_VERSION_NUM < 0x071505
> -#define CURL_SOCKOPT_OK 0
> +#if LIBCURL_VERSION_NUM >= 0x071505
> +#define GIT_CURL_HAVE_CURL_SOCKOPT_OK 1
>  #endif

IOW we should drop this.

>  /**
>   * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
>   */
>  #if LIBCURL_VERSION_NUM >= 0x071900
> -#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
> +#define GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
>  #endif

This change is good.

> diff --git a/http.c b/http.c
> index 229da4d148..d7ad7db1d6 100644
> --- a/http.c
> +++ b/http.c
> @@ -517,7 +517,7 @@ static int has_proxy_cert_password(void)
>  }
>  #endif
>  
> -#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
> +#ifdef GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE
>  static void set_curl_keepalive(CURL *c)
>  {

As is this.

>  	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
> @@ -536,7 +536,9 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
>  	rc = setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
>  	if (rc < 0)
>  		warning_errno("unable to set SO_KEEPALIVE on socket");
> -
> +#ifndef GIT_CURL_HAVE_CURL_SOCKOPT_OK
> +#define CURL_SOCKOPT_OK 0
> +#endif
>  	return CURL_SOCKOPT_OK;
>  }

The whole point of git-curl-compat.h and its big-brother
git-compat-util.h is that we'd prefer not to have such hacks inline if
at all possible.

For most of the GIT_CURL_* stuff we need to since it's conditionally
using symbols etc., but in this case we can just define a fallback
centrally and not worry about it in the code.

So the pre-image really is much better.
