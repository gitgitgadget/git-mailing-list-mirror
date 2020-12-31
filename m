Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740DC433DB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09AF2222D
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 12:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLaMsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 07:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgLaMsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 07:48:41 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D64C061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 04:48:01 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id y15so12734859qtv.5
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YsDw8Qyj9IoXbSWK0L5ZISZ9NK+ohbF+dX5aZSxrVFA=;
        b=LnzxXfqi+CcHBFf1OyAEkopiHTztTTHywX37k3X1CwXXBPuDOPv8VulBR64/odtzpo
         MFT5jelQEeFOUD4QCX+3pxC+Wfecr9wBA2QJ5DrzalfbYbM2nuI9KeWml1Dh5npEMgm9
         3a+hmXFCVe41bjJ5Dlmf2lRzcRO0pJrlYnxnVO5h8h3Nf1ehz4HICX4UnyUJ6V0lQFKX
         GHKS+azuAjlTVkr41wFH3UZnYPQCAOeYkeJdjwJZW+FHNxr+Bz0c9jqyIyD9WxuozuIr
         VSmXKrBa2J+LPUVmRZsu440vef/cNVMJh0+W/GPV0NtXfTKjCbLvwEk0c1O/7T54wixv
         QYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YsDw8Qyj9IoXbSWK0L5ZISZ9NK+ohbF+dX5aZSxrVFA=;
        b=HYe0S+Ejj/iOPdy3mGisblNNkdmKyXsrd968vK47B/tgIdQHh3D1g7LhTOjBmym9mg
         DwNo70UMy8cQO2mT1qIpIvl22/WmzBTXAdcviWF9P/tG9beoqBxaljT6/s01Z13v/ikT
         fhtHLXj/IDXIVQbZPhNcW8pxa30HDHpOTQ1QgIMosFakrg/3rVQC45TzYXHoC4vfTBq0
         kU1aK9jg4hqSi/CTM009xFPsrxJuBhX8Aiaue4idp1BODfJmu/dtQgIjaAh+I4AIeQ4S
         Z6Gt21ov8qTFSMEeuji64ob3YOt+Mc8rYFgvwKySpfJcaLoc+xGsH4IOOJD4E0hqehCu
         0B+g==
X-Gm-Message-State: AOAM532lFBg5UVwFvBDYUJwEbvFAeGLrB4+DYaOQQQ9WE+3tY9VYew+G
        7ouEUfRT0G3NMp7apCUD2bc=
X-Google-Smtp-Source: ABdhPJzohaz/SJVvRgwR0S/WWzN0x0UeByDrv+U0YBVENx8Mgeq9o81kBOwXDPs/Kv4kkP/Zu4bzaA==
X-Received: by 2002:ac8:44d8:: with SMTP id b24mr56166262qto.339.1609418880541;
        Thu, 31 Dec 2020 04:48:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id n188sm30314541qke.17.2020.12.31.04.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 04:47:59 -0800 (PST)
Subject: Re: [PATCH v2 0/4] rename "sha1-foo" files
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <cover.1609282997.git.martin.agren@gmail.com>
 <cover.1609415114.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0223aa36-7071-a37c-a188-c45a43d76b4f@gmail.com>
Date:   Thu, 31 Dec 2020 07:47:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <cover.1609415114.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2020 6:56 AM, Martin Ågren wrote:
> Thanks to Derrick and brian for commenting on v1 [1] of my series for
> renaming sha1-foo files and generalizing "sha", "sha1" and so on in
> them. I realized I hadn't renamed the header guard in hash-lookup.h as I
> renamed the file. That made me realize that I had failed to look for
> "SHA-1" (capital letters). So this v2 is a bit bigger than v1, but not
> by too much, I think. The range-diff is below.

Makes sense. Thanks for being diligent!

> Range-diff against v1:
> 1:  aac3a3c3e2 ! 1:  4d69d448a3 object-name.c: rename from sha1-name.c
>     @@ Commit message
>          Generalize the last remnants of "sha" and "sha1" in this file and rename
>          it to reflect that we're not just able to handle SHA-1 these days.
>      
>     +    We need to update one test to check for an updated error string.
>     +
>          Signed-off-by: Martin Ågren <martin.agren@gmail.com>
>      
>     + ## t/t1512-rev-parse-disambiguation.sh ##
>     +@@ t/t1512-rev-parse-disambiguation.sh: test_expect_success 'blob and tree' '
>     + 
>     + test_expect_success 'warn ambiguity when no candidate matches type hint' '
>     + 	test_must_fail git rev-parse --verify 000000000^{commit} 2>actual &&
>     +-	test_i18ngrep "short SHA1 000000000 is ambiguous" actual
>     ++	test_i18ngrep "short object ID 000000000 is ambiguous" actual
>     + '
>     + 
>     + test_expect_success 'disambiguate tree-ish' '
>     +
>       ## list-objects-filter.c ##
>      @@
>        * in the traversal (until we mark it SEEN).  This is a way to
>     @@ object-name.c: static void unique_in_pack(struct packed_git *p,
>       			break;
>       		update_candidates(ds, &oid);
>       	}
>     +@@ object-name.c: static enum get_oid_result get_short_oid(struct repository *r,
>     + 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
>     + 		struct oid_array collect = OID_ARRAY_INIT;
>     + 
>     +-		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
>     ++		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
>     + 
>     + 		/*
>     + 		 * We may still have ambiguity if we simply saw a series of
>      @@ object-name.c: static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>       	if (!ret)
>       		return ret;
> 2:  4243886d8a ! 2:  7ab29b868f object-file.c: rename from sha1-file.c
>     @@ sha1-file.c => object-file.c
>        * creation etc.
>        */
>       #include "cache.h"
>     +@@ object-file.c: static int alt_odb_usable(struct raw_object_store *o,
>     +  * LF separated.  Its base points at a statically allocated buffer that
>     +  * contains "/the/directory/corresponding/to/.git/objects/...", while
>     +  * its name points just after the slash at the end of ".git/objects/"
>     +- * in the example above, and has enough space to hold 40-byte hex
>     +- * SHA1, an extra slash for the first level indirection, and the
>     +- * terminating NUL.
>     ++ * in the example above, and has enough space to hold all hex characters
>     ++ * of the object ID, an extra slash for the first level indirection, and
>     ++ * the terminating NUL.
>     +  */
>     + static void read_info_alternates(struct repository *r,
>     + 				 const char *relative_base,
>      
>       ## Makefile ##
>      @@ Makefile: LIB_OBJS += notes-cache.o
> 3:  8d3b123633 = 3:  91617de0ac sha1-lookup: rename `sha1_pos()` as `hash_pos()`
> 4:  afee010474 ! 4:  9df53353dc hash-lookup: rename from sha1-lookup
>     @@ Commit message
>          Signed-off-by: Martin Ågren <martin.agren@gmail.com>
>      
>       ## sha1-lookup.h => hash-lookup.h ##
>     +@@
>     +-#ifndef SHA1_LOOKUP_H
>     +-#define SHA1_LOOKUP_H
>     ++#ifndef HASH_LOOKUP_H
>     ++#define HASH_LOOKUP_H
>     + 
>     + typedef const unsigned char *hash_access_fn(size_t index, void *table);
>     + 
>      @@ hash-lookup.h: int hash_pos(const unsigned char *hash,
>       	     hash_access_fn fn);

This range-diff looks sensible. I approve v2.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee
