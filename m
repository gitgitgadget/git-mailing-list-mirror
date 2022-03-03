Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1094C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiCCQso (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCCQsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:48:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19350148677
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:47:56 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so3085414ejb.2
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Z5cERr8g6WtvtowF03KTdnI+FhY9xvWp5/2TuEpDN/Y=;
        b=WLakf+lghMX4QIX7K6hZi02CMzw+sUK8GgPxYCvd1QDybM+Z3TieHVGWK0xo+t4WQd
         OVlqtNvOl16+7EMKvnY+jwFHVX//ov17j/QlrACOfq7jWiDxkmvbI33AYx7G5mCrm122
         pLBLKGAyGg6XWZ7NCfYDfheYohIMa5LviCtY6z9gV3NbA1dLaEZ1gIYZxN6MvO54jxXn
         oFswT5avf0iIU8lT3xwkLrIOh07CtL5RSNrSz7cSa59XEs3sLb6B1q/K8dauXp7cjyMp
         X2Dj9ceyIDbiNCtp98+uYxilD7CziUoPXHiCxkK6txju03UPlKnmiG88xr8bP8z9biSl
         0Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Z5cERr8g6WtvtowF03KTdnI+FhY9xvWp5/2TuEpDN/Y=;
        b=7J12EgTX22ZTtl03T+RKEB401UbIinwxQjD3XkOPBdboKV4E5Gn/bzm0Vp9TzMx1+0
         uKi9zSE5AibHZhFAaNBjbaqKAydTdWk3OkeYp4Wz4bEPQ92u35wp7oK9rHeEgK5GuiWz
         /wiNeGMbzymER0svnVPiwh9f2oTO2NyD2i8O0oiZf0Tl/acwUVdPK0llosGZhIjPSGXt
         bgcMSer0ATWTjZoSAjOXGhDSMnScEoYPiJGr4xLDwK8uFfTo80gap1rb4golaJkMoFY2
         zEPAvh4fxPD36c6vNFjrcOtZXMU7Hm3VC6+f9alsvbry4wRFOngcymffc8jWqnwKjg7S
         wsmg==
X-Gm-Message-State: AOAM533PbhsH4oMXkCbo0qK2e3TghaMHyI89jSeStJL00qS2MIqWlw6N
        dE8i/OX88FeHnmdSZc8PIVA=
X-Google-Smtp-Source: ABdhPJyYz9ho11IK/d7KQ3Rvz4Y4h2P7Lxw92E1zhq+ntqmZ+CUDbAvsL69ljQEDOarMc5s7HC3qhA==
X-Received: by 2002:a17:907:7248:b0:6da:8410:c3c8 with SMTP id ds8-20020a170907724800b006da8410c3c8mr4915030ejc.200.1646326074544;
        Thu, 03 Mar 2022 08:47:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ho38-20020a1709070ea600b006d6e9207e37sm898526ejc.66.2022.03.03.08.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:47:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPocL-000eYB-1c;
        Thu, 03 Mar 2022 17:47:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 05/17] pack-mtimes: support writing pack .mtimes files
Date:   Thu, 03 Mar 2022 17:45:23 +0100
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <0600503856dbccb135aaead27693b6815a774b4f.1646266835.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <0600503856dbccb135aaead27693b6815a774b4f.1646266835.git.me@ttaylorr.com>
Message-ID: <220303.86ee3j2dae.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Taylor Blau wrote:

> Now that the `.mtimes` format is defined, supplement the pack-write API
> to be able to conditionally write an `.mtimes` file along with a pack by
> setting an additional flag and passing an oidmap that contains the
> timestamps corresponding to each object in the pack.
> [...]
>  void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
> diff --git a/pack.h b/pack.h
> index fd27cfdfd7..01d385903a 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -44,6 +44,7 @@ struct pack_idx_option {
>  #define WRITE_IDX_STRICT 02
>  #define WRITE_REV 04
>  #define WRITE_REV_VERIFY 010
> +#define WRITE_MTIMES 020
>  
>  	uint32_t version;
>  	uint32_t off32_limit;

Why the hardcoding? The 010 was added in your 8ef50d9958f (pack-write.c:
prepare to write 'pack-*.rev' files, 2021-01-25). That would be the same
as 8|2, but there's no 8 there., ditto this new 020 that's the same as
1<<4 | 1<<2, but there's no "16", just WRITE_REV=4.
