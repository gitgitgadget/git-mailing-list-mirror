Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7520C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGUVqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiGUVqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:46:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7EA192A2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:46:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v21so3068794plo.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=DjQOSRm59jib1Nus9oYu5UoZoaXIenROWusGLd+prBg=;
        b=kErUx0AjncfJi/2LSN0br2nT/4L2zO9a0lEnN+myErxyKjyJ12r+/hxc34Xz/X4RzO
         jSDbmuwtmvUEv4+dl5FzG3Uv6uDuUgiAUSogRXQRgt6vit8NXO0vEtRojdsPSfC8PdXh
         cuyUwVBRw19u6u1tdgccYOoqcz7l40GkKDMgnN+2oZECoVdwX5SIz8/jdLNJXeZMtiTy
         72YUnba2IFa+DGbuZ3rnY0ggA/LP5gaxwSWITvJxDHSXwxNQ3RnXF2FNFC8g2KJ+ae51
         ulEDZXqaJOj33Km0IRVGrRglf4seOsOLX2KvUm5VcUjZm0a8cXynXcfiPTRdl4kst5KT
         kdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DjQOSRm59jib1Nus9oYu5UoZoaXIenROWusGLd+prBg=;
        b=i25eIGrIEZI4GhOmqFBeseAODDb+KwPnr5AKmh5XGVfkb9b/qGL3etRpk9Z3z8H7Ot
         IC2TOip/JjJIm06Up1UPGjjRvqXxodShJKNA4H2U+ZI/z9T7O6Q6gag+7b3d2I91s9xX
         5z86xyNz3kdO25Ldr4qHcikpGSVU/GW0T5pjiI+MgAHHYQ3rgjiZi12zlwtdjkDlfA4f
         171W4r3mtANrBdveUL3mdH055SJzwmAXgGlzum0UQdn2J8vV/WPavF/SKrSnlkEBesDN
         VSS2+yiUlXvIStEPN937JXWFlIBROGJl4H5FPsqTlPq5TW22kKpYvGG6NRuwApx7sa8n
         DDzg==
X-Gm-Message-State: AJIora/msUoLbqhmKXt0qeQBehMtzMXlsCAXjveBrVZ7O3mB6M/zLa3U
        uPoWfDob81X2VHsGsHr3q2EOPQ==
X-Google-Smtp-Source: AGRyM1tSmJZUZMYBnH0moyoRdkTps9CXKKNUhWo3Vpc8dmXMuxNSEV45k9YRo5EE4QRh+/SuetRXDQ==
X-Received: by 2002:a17:90b:3788:b0:1f2:44c4:f9a0 with SMTP id mz8-20020a17090b378800b001f244c4f9a0mr1550100pjb.171.1658439960941;
        Thu, 21 Jul 2022 14:46:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:fe53:c5fe:7cbc:be96])
        by smtp.gmail.com with ESMTPSA id a11-20020a631a4b000000b0041a919ed63dsm802730pgm.3.2022.07.21.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:46:00 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:45:54 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/6] bundle-uri: create basic file-copy logic
Message-ID: <YtnJEm1N5IQ/y3mj@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <abec47564fd9cea5ef9d8f112e90368681a4e066.1656535245.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abec47564fd9cea5ef9d8f112e90368681a4e066.1656535245.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.06.29 20:40, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Before implementing a way to fetch bundles into a repository, create the
> basic logic. Assume that the URI is actually a file path. Future logic
> will make this more careful to other protocols.
> 
> For now, we also only succeed if the content at the URI is a bundle
> file, not a bundle list. Bundle lists will be implemented in a future
> change.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Makefile     |  1 +
>  bundle-uri.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  bundle-uri.h | 14 ++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 bundle-uri.c
>  create mode 100644 bundle-uri.h
> 
> diff --git a/Makefile b/Makefile
> index f8bccfab5e9..8f27310836d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -887,6 +887,7 @@ LIB_OBJS += blob.o
>  LIB_OBJS += bloom.o
>  LIB_OBJS += branch.o
>  LIB_OBJS += bulk-checkin.o
> +LIB_OBJS += bundle-uri.o
>  LIB_OBJS += bundle.o
>  LIB_OBJS += cache-tree.o
>  LIB_OBJS += cbtree.o
> diff --git a/bundle-uri.c b/bundle-uri.c
> new file mode 100644
> index 00000000000..f0abbf434c8
> --- /dev/null
> +++ b/bundle-uri.c
> @@ -0,0 +1,93 @@
> +#include "cache.h"
> +#include "bundle-uri.h"
> +#include "bundle.h"
> +#include "object-store.h"
> +#include "refs.h"
> +#include "run-command.h"
> +
> +static void find_temp_filename(struct strbuf *name)
> +{
> +	int fd;
> +	/*
> +	 * Find a temporary filename that is available. This is briefly
> +	 * racy, but unlikely to collide.
> +	 */
> +	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
> +	if (fd < 0)
> +		die(_("failed to create temporary file"));
> +	close(fd);
> +	unlink(name->buf);

Is there a reason why we unlink() here? If we allow the empty file to
remain on-disk until we write to it, wouldn't that prevent odb_mkstemp()
from being racy?


> +}
> +
> +static int copy_uri_to_file(const char *uri, const char *file)

Nitpick: from a brief glance, it seems that most other copy* functions
take the destination as the first parameter, and the source second. I
don't feel strongly about it, because to me src followed by dst feels
more natural, but perhaps we should be consistent with other functions.


> +{
> +	/* Copy as a file */
> +	return copy_file(file, uri, 0444);
> +}
> +
> +static int unbundle_from_file(struct repository *r, const char *file)
> +{
> +	int result = 0;
> +	int bundle_fd;
> +	struct bundle_header header = BUNDLE_HEADER_INIT;
> +	struct strvec extra_index_pack_args = STRVEC_INIT;
> +	struct string_list_item *refname;
> +	struct strbuf bundle_ref = STRBUF_INIT;
> +	size_t bundle_prefix_len;
> +
> +	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
> +		return 1;
> +
> +	if ((result = unbundle(r, &header, bundle_fd, &extra_index_pack_args)))

Can we just pass NULL here instead of creating an empty
extra_index_pack_args?


> +		return 1;
> +
> +	/*
> +	 * Convert all refs/heads/ from the bundle into refs/bundles/
> +	 * in the local repository.
> +	 */
> +	strbuf_addstr(&bundle_ref, "refs/bundles/");
> +	bundle_prefix_len = bundle_ref.len;
> +
> +	for_each_string_list_item(refname, &header.references) {
> +		struct object_id *oid = refname->util;
> +		struct object_id old_oid;
> +		const char *branch_name;
> +		int has_old;
> +
> +		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
> +			continue;
> +
> +		strbuf_setlen(&bundle_ref, bundle_prefix_len);
> +		strbuf_addstr(&bundle_ref, branch_name);
> +
> +		has_old = !read_ref(bundle_ref.buf, &old_oid);
> +		update_ref("fetched bundle", bundle_ref.buf, oid,
> +			   has_old ? &old_oid : NULL,
> +			   REF_SKIP_OID_VERIFICATION,
> +			   UPDATE_REFS_MSG_ON_ERR);
> +	}
> +
> +	bundle_header_release(&header);

We also need to release bundle_ref (and extra_index_pack_args if we
decide to keep it).


> +	return result;
> +}
> +
> +int fetch_bundle_uri(struct repository *r, const char *uri)
> +{
> +	int result = 0;
> +	struct strbuf filename = STRBUF_INIT;
> +
> +	find_temp_filename(&filename);
> +	if ((result = copy_uri_to_file(uri, filename.buf)))
> +		goto cleanup;
> +
> +	if ((result = !is_bundle(filename.buf, 0)))
> +		goto cleanup;
> +
> +	if ((result = unbundle_from_file(r, filename.buf)))
> +		goto cleanup;
> +
> +cleanup:
> +	unlink(filename.buf);
> +	strbuf_release(&filename);
> +	return result;
> +}
> diff --git a/bundle-uri.h b/bundle-uri.h
> new file mode 100644
> index 00000000000..8a152f1ef14
> --- /dev/null
> +++ b/bundle-uri.h
> @@ -0,0 +1,14 @@
> +#ifndef BUNDLE_URI_H
> +#define BUNDLE_URI_H
> +
> +struct repository;
> +
> +/**
> + * Fetch data from the given 'uri' and unbundle the bundle data found
> + * based on that information.
> + *
> + * Returns non-zero if no bundle information is found at the given 'uri'.
> + */
> +int fetch_bundle_uri(struct repository *r, const char *uri);
> +
> +#endif
> -- 
> gitgitgadget
> 
