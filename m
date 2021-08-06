Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6528EC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478A861165
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbhHFPbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 11:31:45 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:60014 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231613AbhHFPbo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 11:31:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 84B4A113F;
        Fri,  6 Aug 2021 17:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1628263885; x=1630078286; bh=w3YqzRtjuN2qsSjABGA
        mhIhqNahmF3c3GY/IlAK/h7g=; b=ZSwxPALm+ioD01UjBNQ9Vge7jnIDn8rVGFG
        hgIoWswzW9NRKK9GNRtAlzp4Ge3toZRUy0u+3Psct8lGPRjhHWPINxcbj1idhDgh
        9E6GWfD/QR0FHCf+Znncsv3yEqB4ixGulJMmKKISV1w5yiZhaD3AHAukhU2RG8GV
        /9WGXzOHIfk6HSCv6albckqw0Mbm/tOnUH4gdwj9Jb0vBL/1QRcUoWxpvtISHXrE
        2J5sviM7SGSn2VQx97TVeV88n+2u5SIV2JciIbBlEqSHmn+8pw5wU5Qw7Zxe5eN0
        76UMnQrCaOHja4BjRu9t+tqsK5mUvxgor50AitvblB0UdufqLKAzHWIICi/mdNTF
        ZpI2dHG0L9MuSR8r6YQ0RGDSdHTe0gJQsMqSW0RS2vfRXfoHna6PqggEetS/FmiG
        Vk2d0yFtOb13Kd0A7P0cfHgEDUXal80gOGJMiIN7/GtfcKbPBXed2/qOuu/9rjZh
        /24XAxREcjFpa0qQKmuiScYTJmLivmSk1KJWyGCuVP14nqAebZAd54XBb3VKXwGL
        AEOulA6t0H9YdqXK1yj/RwNwEaAKoKLds4fSRRGVHIT9BfvBTQ7sDp3ZmYv0cmvd
        Kcp9eYs+n2K5ejaydgRe5HjNYsnyBqSqqinJfD/iabh1s7GRgbcW3unCxGBklbGj
        gWoe4oQQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8uq228eBABn1; Fri,  6 Aug 2021 17:31:25 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 8631D627;
        Fri,  6 Aug 2021 17:31:25 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 814D986FD;
        Fri,  6 Aug 2021 17:31:21 +0200 (CEST)
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
To:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
Date:   Fri, 6 Aug 2021 17:31:19 +0200
MIME-Version: 1.0
In-Reply-To: <20210629205305.7100-6-e@80x24.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/06/2021 22:53, Eric Wong wrote:
> [...snip...]
> diff --git a/oidtree.c b/oidtree.c
> new file mode 100644
> index 0000000000..c1188d8f48
> --- /dev/null
> +++ b/oidtree.c
> @@ -0,0 +1,94 @@
> +/*
> + * A wrapper around cbtree which stores oids
> + * May be used to replace oid-array for prefix (abbreviation) matches
> + */
> +#include "oidtree.h"
> +#include "alloc.h"
> +#include "hash.h"
> +
> +struct oidtree_node {
> +	/* n.k[] is used to store "struct object_id" */
> +	struct cb_node n;
> +};
> +
> [... snip ...]
> +
> +void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
> +{
> +	struct oidtree_node *on;
> +
> +	if (!ot->mempool)
> +		ot->mempool = allocate_alloc_state();
> +	if (!oid->algo)
> +		BUG("oidtree_insert requires oid->algo");
> +
> +	on = alloc_from_state(ot->mempool, sizeof(*on) + sizeof(*oid));
> +	oidcpy_with_padding((struct object_id *)on->n.k, oid);

I think this object_id cast introduced undefined behaviour - here's my 
layperson's interepretation of what's going on (full UBSAN output is 
pasted below):

cb_node.k is a uint8_t[], and hence can be 1-byte aligned (on my 
machine: offsetof(struct cb_node, k) == 21). We're casting its pointer 
to "struct object_id *", and later try to access object_id.hash within 
oidcpy_with_padding. My compiler assumes that an object_id pointer needs 
to be 4-byte aligned, and reading from a misaligned pointer means we hit 
undefined behaviour. (I think the 4-byte alignment requirement comes 
from the fact that object_id's largest member is an int?)

I'm not sure what an elegant and idiomatic fix might be - IIUC it's hard 
to guarantee misaligned access can't happen with a flex array that's 
being used for arbitrary data (you would presumably have to declare it 
as an array of whatever the largest supported type is, so that you can 
guarantee correct alignment even when cbtree is used with that type) - 
which might imply that k needs to be declared as a void pointer? That in 
turn would make cbtree.c harder to read.

Anyhow, here's the UBSAN output from t0000 running against next:

hash.h:277:14: runtime error: member access within misaligned address 
0x7fcb31c4103d for type 'struct object_id', which requires 4 byte alignment
0x7fcb31c4103d: note: pointer points here
  5a 5a 5a 5a 5a 5a 5a  5a 5a 5a 5a 5a 5a 5a 5a  5a 5a 5a 5a 5a 5a 5a 5a 
  5a 5a 5a 5a 5a 5a 5a 5a  5a
              ^
     #0 0xc76d9d in oidcpy_with_padding hash.h:277:14
     #1 0xc768f5 in oidtree_insert oidtree.c:44:2
     #2 0xc418e3 in append_loose_object object-file.c:2398:2
     #3 0xc3fbdc in for_each_file_in_obj_subdir object-file.c:2316:9
     #4 0xc41785 in odb_loose_cache object-file.c:2424:2
     #5 0xc50336 in find_short_object_filename object-name.c:103:16
     #6 0xc50e04 in repo_find_unique_abbrev_r object-name.c:712:2
     #7 0xc519a9 in repo_find_unique_abbrev object-name.c:727:2
     #8 0x9b6ce2 in diff_abbrev_oid diff.c:4208:10
     #9 0x9f13d0 in fill_metainfo diff.c:4286:8
     #10 0x9f02d6 in run_diff_cmd diff.c:4322:3
     #11 0x9efbef in run_diff diff.c:4422:3
     #12 0x9c9ac9 in diff_flush_patch diff.c:5765:2
     #13 0x9c9e74 in diff_flush_patch_all_file_pairs diff.c:6246:4
     #14 0x9be33e in diff_flush diff.c:6387:3
     #15 0xb8864e in log_tree_diff_flush log-tree.c:895:2
     #16 0xb8987b in log_tree_diff log-tree.c:933:4
     #17 0xb88c9a in log_tree_commit log-tree.c:988:10
     #18 0x5b4257 in cmd_log_walk log.c:426:8
     #19 0x5b6224 in cmd_show log.c:698:10
     #20 0x42ec48 in run_builtin git.c:461:11
     #21 0x4295e0 in handle_builtin git.c:714:3
     #22 0x42d043 in run_argv git.c:781:4
     #23 0x428cc2 in cmd_main git.c:912:19
     #24 0x7791ce in main common-main.c:52:11
     #25 0x7fcb30aab349 in __libc_start_main (/lib64/libc.so.6+0x24349)
     #26 0x4074a9 in _start start.S:120

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior hash.h:277:14 in


> +
> +	/*
> +	 * n.b. we shouldn't get duplicates, here, but we'll have
> +	 * a small leak that won't be freed until oidtree_destroy
> +	 */
> +	cb_insert(&ot->t, &on->n, sizeof(*oid));
> +}
> +


ATB,

Andrzej
