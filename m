Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC4B1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933160AbeFUVPI (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:15:08 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38217 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932856AbeFUVPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:15:08 -0400
Received: by mail-yb0-f196.google.com with SMTP id q62-v6so1770177ybg.5
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGghy5O4joVW1ehM98NgsC/Ynz15PTN+9YElll2bAiQ=;
        b=uQo9bHNV5FqJIOhMLv1Qj/EFREsQwjL0txWVBV6GT/XPfJk/YLMHEuI/IdjlNkqmWW
         PEWGeo+7kYfxypVmbMrPQVH4CXQrmCm9onXwcS0Q28RmYTse4oopI6rI2jsDCM4G9FFA
         PnAEqiz1Am0dz65tr21QMo0WO9c62jd48b7rcwmJKSBScoNk5YDesl8el0j3hTIiP4Qo
         9VWg8Ynk9fEZZx9llJHcmlRKfDOTv0UbxP2KZIoGLTUn8Ru+XUhu6RsM1RLHtA7xREP/
         lXUPmTlPBrARiTa251c39k4V8Sx2AE6YP9vGY9v4es+BJwPFNHHNvVzYLpLXus/xYICt
         Tt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGghy5O4joVW1ehM98NgsC/Ynz15PTN+9YElll2bAiQ=;
        b=Xib+0PEAlqnHZE2DbNglgzVPPAlcESV3FsLc9y/FuCN/gwM+Kok8k3E8OTgH5s3Nvt
         NmR+vyZOFdINsaw0RgILcr7Tk6XTBWt0vlhGuDESAaTVifRtjsdKarVq0exS6RTm4YeK
         CyZG8cG2gB0QMCxdRqtcbIbsZufCIARB/TbelIyRgTUwV4D4NYz25hBMFcOCwjizZR6W
         n8cg3Rbmo/zJT1SnDVPJ/bHzfcVFI9HeqxsnBxaSKh2STamlpG3ZKrTqquDtxzFfus23
         S3RD0WVDM9ezfTQA2tGDIrrqq1Is1udhQQvZoNtQHK45RRmMf5d0hUCE3SnOzyxAbTt2
         j9tw==
X-Gm-Message-State: APt69E2Or/Qut7NCtM2Mn8Um3ilnP9k0G+KBGEX7qOUUM5Srzdf2UMf3
        1lmxN/CmZ6S/lOdioRT4Ka4QBujJFsTji+rg8ftYgT+Q
X-Google-Smtp-Source: ADUXVKI3qa7VxqvlDTXqai1Olxo0Jt5/Fc9JD2M7gAY72QwnNQRR3mB8R1phkvdUBKTKM6Irg26RLxKOVUGBaKqxelo=
X-Received: by 2002:a25:dcc4:: with SMTP id y187-v6mr10636624ybe.515.1529615707005;
 Thu, 21 Jun 2018 14:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180417163400.3875-1-jamill@microsoft.com> <20180620201557.77155-1-jamill@microsoft.com>
 <20180620201557.77155-3-jamill@microsoft.com>
In-Reply-To: <20180620201557.77155-3-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Jun 2018 14:14:54 -0700
Message-ID: <CAGZ79katH2Kk2NDDyZjYzC9fEKS6cDdHK1Cw2JLjjSfmYOPapw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] block alloc: add lifecycle APIs for cache_entry structs
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> --- a/cache.h
> +++ b/cache.h
> @@ -339,6 +339,29 @@ extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
>  extern void free_name_hash(struct index_state *istate);
>
>
> +/* Cache entry creation and cleanup */
> +
> +/*
> + * Create cache_entry intended for use in the specified index. Caller
> + * is responsible for discarding the cache_entry with
> + * `discard_cache_entry`.
> + */
> +extern struct cache_entry *make_cache_entry(struct index_state *istate, unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);

How much work is it to convert these to object_id while at it instead
of char *sha1?
(I think we really dislike introducing new sha1 based code; If it
doesn't sound easy
maybe we can have a static inline wrapper here that just converts oid
to sha1 and
then calls this function?)

Is it possible to line break these functions (c.f. refs.h which I
think has one of
the best styles in the git project. It has long parameter lists, but
still manages
to stay below a reasonable line length) ?

> +extern struct cache_entry *make_empty_cache_entry(struct index_state *istate, size_t name_len);

> +
> +/*
> + * Create a cache_entry that is not intended to be added to an index.
> + * Caller is responsible for discarding the cache_entry
> + * with `discard_cache_entry`.
> + */
> +extern struct cache_entry *make_transient_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage);
> +extern struct cache_entry *make_empty_transient_cache_entry(size_t name_len);
> +
> +/*
> + * Discard cache entry.
> + */
> +void discard_cache_entry(struct cache_entry *ce);

Please be consistent in the use of the extern keyword and omit them at all
times here and above.
