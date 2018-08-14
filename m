Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933701F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeHNVHI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:07:08 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:34102 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHNVHH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:07:07 -0400
Received: by mail-io0-f201.google.com with SMTP id f9-v6so17466705ioh.1
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T0u6OVzzjKN5oVCmHPjH2ytAA/gtTVmbOWrvoRt2Tng=;
        b=JYQa/1J1REnibMTJQmzyN+ck6zBSuFE/n3VjucqRHrFuaoaVKiMcfAMxiigqbBI6Qa
         wADZ9Q2iSTnxPuTFzh1X08ZuZS/5NXrZQJh/Xmbuim8MJlPfLl9ahu4nzPylyR3yPxOH
         Yw2pQdI1z7uh9eastFNCZ9HcZA8MKpZZcLoUKCUswcBSRi/JcMA4zKW3EsEf5uh2wIww
         vfDsT8TW8Y5Mu9LJqzmVJZi1KUc3IFj9O77k5I+XelNKSXnwu9fCrCdg3G/U2ITLWxZ7
         p3Sct/vlgLN2PVWwUxaKh6XG0V0/NthLs7mVUQTfQnjoHC/ckV/gEjvenGU2bvigl3kE
         Xceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T0u6OVzzjKN5oVCmHPjH2ytAA/gtTVmbOWrvoRt2Tng=;
        b=qMjojaO+sjiRB9OgklT4O0opycuD4dcU/w8ZxTt3OHkAToWwPnxHZ6/kZm90b8HqDU
         cr2fPeCu+KCELjorB5VesVh3s90Pk/b0R5gRZ2t0m/+3Sh2MSdj4mybAlnEPFjRYKDE0
         k46WbMF8Dbecll4gQxAc8IbzjSJHYLxlSRWTX4IVo7dprlxa8FuGWdjQYSq31UquXv9V
         F5qbfNN9CIi9lD1/uYPBbZImApr3H6C2dkgIGsPu16Uyz5ofxPhJo95gugMgl+Uc4CUx
         KxVXwjDN6dZnhDGfVoKJofW2T8elxlmdX6dWxise2aXdxa0KmuC95DEJoX/IFQ8d21OV
         C+dw==
X-Gm-Message-State: AOUpUlHw3qx+vJNIf8pPnKE6j8OGLaTumA8umbxmKgAkmaTVZQ4WxHlx
        lByS5i2mguBlJQvEK8XiEKcP9vYD/k5WWKOpCsxj
X-Google-Smtp-Source: AA+uWPyww+2ySt1e2tK+aSP6TEAdMPgULzTQ75guMvGEvbtlsKkyYbmvVHHTFHAYFzdpyXym98zSgHiny0NwHTPtWqwW
X-Received: by 2002:a24:4567:: with SMTP id y100-v6mr8930719ita.37.1534270725106;
 Tue, 14 Aug 2018 11:18:45 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:18:41 -0700
In-Reply-To: <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com>
Message-Id: <20180814181841.34446-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -743,6 +743,9 @@ specification contained in <path>.
>  	A debug option to help with future "partial clone" development.
>  	This option specifies how missing objects are handled.
>  +
> +The form '--filter=tree:<depth>' omits all blobs and trees deeper than
> +<depth> from the root tree. Currently, only <depth>=0 is supported.
> ++
>  The form '--missing=error' requests that rev-list stop with an error if
>  a missing object is encountered.  This is the default action.
>  +

The "--filter" documentation should go with the other "--filter"
information, not right after --missing.

> +test_expect_success 'setup for tests of tree:0' '
> +	mkdir r1/subtree &&
> +	echo "This is a file in a subtree" > r1/subtree/file &&
> +	git -C r1 add subtree/file &&
> +	git -C r1 commit -m subtree
> +'

Style: no space after >

> +test_expect_success 'grab tree directly when using tree:0' '
> +	# We should get the tree specified directly but not its blobs or subtrees.
> +	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
> +	HEAD:
> +	EOF
> +	git -C r1 index-pack ../commitsonly.pack &&
> +	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
> +	grep -E "tree|blob" objs >trees_and_blobs &&
> +	test_line_count = 1 trees_and_blobs
> +'

Can we also verify that the SHA-1 in trees_and_blobs is what we
expected?

> +test_expect_success 'use fsck before and after manually fetching a missing subtree' '
> +	# push new commit so server has a subtree
> +	mkdir src/dir &&
> +	echo "in dir" > src/dir/file.txt &&

No space after >

> +	git -C src add dir/file.txt &&
> +	git -C src commit -m "file in dir" &&
> +	git -C src push -u srv master &&
> +	SUBTREE=$(git -C src rev-parse HEAD:dir) &&
> +
> +	rm -rf dst &&
> +	git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
> +	git -C dst fsck &&
> +	git -C dst cat-file -p $SUBTREE >tree_contents 2>err &&
> +	git -C dst fsck
> +'

If you don't need to redirect to err, don't do so.

Before the cat-file, also verify that the tree is missing, most likely
through a "git rev-list" with "--missing=print".

And I would grep on the tree_contents to ensure that the filename
("file.txt") is there, so that we know that we got the correct tree.

> +test_expect_success 'can use tree:0 to filter partial clone' '
> +	rm -rf dst &&
> +	git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
> +	git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
> +	cat fetched_objects \
> +		| awk -f print_1.awk \
> +		| xargs -n1 git -C dst cat-file -t >fetched_types &&
> +	sort fetched_types -u >unique_types.observed &&
> +	echo commit > unique_types.expected &&
> +	test_cmp unique_types.observed unique_types.expected
> +'
> +
> +test_expect_success 'auto-fetching of trees with --missing=error' '
> +	git -C dst rev-list master --missing=error --objects >fetched_objects &&
> +	cat fetched_objects \
> +		| awk -f print_1.awk \
> +		| xargs -n1 git -C dst cat-file -t >fetched_types &&
> +	sort fetched_types -u >unique_types.observed &&
> +	printf "blob\ncommit\ntree\n" >unique_types.expected &&
> +	test_cmp unique_types.observed unique_types.expected
> +'

These two tests seem redundant with the 'use fsck before and after
manually fetching a missing subtree' test (after the latter is
appropriately renamed). I think we only need to test this sequence once,
which can be placed in one or spread over multiple tests:

 1. partial clone with --filter=tree:0
 2. fsck works
 3. verify that trees are indeed missing
 4. autofetch a tree
 5. fsck still works
