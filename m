Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE9C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 02:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21436109D
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 02:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbhJ0CDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 22:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbhJ0CDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 22:03:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233BC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 19:01:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id m184so1809027iof.1
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 19:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ei0GC2EJ/rFcjlY/d2OqTEaZUu5l/d3mHHiN5MqMoIY=;
        b=ECRqNr/R4TiG9odKBYIMpMsBFiNOzETcXFuJ3jjaXs0UFTB8kqqLM6lmPlluelp4gH
         IiIWnUr7bBOtwMpxsihUxWryZEyrxPmYRmOl9Xbh0IFhVj3iuawh034/SByB4ew3MT1A
         qzVasAQcGFb6EgkONmzYb3fQk74QW2M3N98LmhjwhspWG9Dsd0JnLuiXVFF1Sxxqhl0K
         XRhYdedchfxD3G5ToWIHjSaVkmZa1nxtC1bVndC9P3pNvLB/xAyCsN+qcKUMcMCyz0al
         lh73SiLpf/BHha97KbA7laoXgIjEAwCgQikRy71VFtbWrgD6z6ICquyQnsIXrzCY+Qtn
         YqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ei0GC2EJ/rFcjlY/d2OqTEaZUu5l/d3mHHiN5MqMoIY=;
        b=nZRmUDo7F4I6hmqq8GHYlYIZObKVSNgYJmKK0ZzkvOoDqYf2ljVFvv175jpzfw5ARw
         l4r2LHDKjoUCB9JI16SSoP1oS6vFggDEy9QRCxMBJ5jrcr41AoLknHess0NSXxnJ+0Ei
         1binNLB/CSVX7nRpfLRwAhh9Ql8aI9v9JkFGtPzli9rkH5n76rLbQtMhwkfXav0zUkPw
         yW4WawoQEPWKPrWMgF4al+dlP4FdLyqFsYE+Tw1OaMKCEF6HFRd3t/YEOLNyLUNg0vAg
         yHrHC3Xy6LR7abHwt2peUURclEvJc7/sICO+prd4z+fvPVS6rBNsQaVGMhe2VPTVMk3c
         IRew==
X-Gm-Message-State: AOAM5304D6GGGoMiSeVtnO8EoHuufEfFzCweuQpviJE29O/+xwaIQpcz
        LBgMmQNlueJQQqCnBCEFE18=
X-Google-Smtp-Source: ABdhPJxun6bwMGVtSgVvzb0kb6sBmxnH+jyYcilrFaMg2dcznUaVVM0/qrgDH93Q7Q53kAkL862oeA==
X-Received: by 2002:a05:6602:2b90:: with SMTP id r16mr17511761iov.66.1635300079141;
        Tue, 26 Oct 2021 19:01:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:51d3:ffb0:5109:cde2? ([2600:1700:e72:80a0:51d3:ffb0:5109:cde2])
        by smtp.gmail.com with ESMTPSA id a15sm1866347ilj.81.2021.10.26.19.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 19:01:18 -0700 (PDT)
Message-ID: <7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com>
Date:   Tue, 26 Oct 2021 22:01:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2021 5:25 PM, Ævar Arnfjörð Bjarmason wrote:
> Add a server-side implementation of a new "bundle-uri" command to
> protocol v2. As discussed in the updated "protocol-v2.txt" this will
> allow conforming clients to optionally seed their initial clones or
> incremental fetches from URLs containing "*.bundle" files created with
> "git bundle create".

...

> +DISCUSSION of bundle-uri
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The intent of the feature is optimize for server resource consumption
> +in the common case by changing the common case of fetching a very
> +large PACK during linkgit:git-clone[1] into a smaller incremental
> +fetch.
> +
> +It also allows servers to achieve better caching in combination with
> +an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
> +
> +By having new clones or fetches be a more predictable and common
> +negotiation against the tips of recently produces *.bundle file(s).
> +Servers might even pre-generate the results of such negotiations for
> +the `uploadpack.packObjectsHook` as new pushes come in.
> +
> +I.e. the server would anticipate that fresh clones will download a
> +known bundle, followed by catching up to the current state of the
> +repository using ref tips found in that bundle (or bundles).
> +
> +PROTOCOL for bundle-uri
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +A `bundle-uri` request takes no arguments, and as noted above does not
> +currently advertise a capability value. Both may be added in the
> +future.

One thing I realized was missing from this proposal is any interaction
with partial clone. It would be disappointing if we could not advertise
bundles of commit-and-tree packfiles for blobless partial clones.

There is currently no way for the client to signal the filter type
during this command. Not having any way to extend to include that
seems like an oversight we should remedy before committing to a
protocol that can't be extended.

(This also seems like a good enough reason to group the URIs into a
struct-like storage, because the filter type could be stored next to
the URI.)

Thanks,
-Stolee
