Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF988C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 04:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiL3EZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 23:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiL3EZy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 23:25:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A926308
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 20:25:52 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g16so11128404plq.12
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 20:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TijNPxLahhl6fzKIyeqauQsKuLVN0bj+zyN1p4QLei0=;
        b=lRya8zSSfFA7X9nQpSzwUc1KmbnWb1LSeFFLa/0GddDL4R9Bh94WAKcRVhKHdr6Qo2
         NQEn4N0PVmxiuQUwMZHF7sNISgA43aOPte9/jVI0QzuXHz3cuqWByc5IWRz/e31fFIKy
         SZ2gI3HiZ11SBgV46J9R0QdgkaP6sxgXceu4PNKsrc5mqx9c3+NI859BhU96zVgWoNx1
         gbdYtQlAZpglGZrhfiwcOjo3W1TX4PlqLbMUHDbp9oZXohHvT3iEOd+1KVkMldMqFkbE
         T9K/3f/GOZ6BPfodeDY1k1u0q1h7bYpT6vw6ioD/qqQNRPjfOYsV8SnQC4sKush3yMq8
         939g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TijNPxLahhl6fzKIyeqauQsKuLVN0bj+zyN1p4QLei0=;
        b=4iSaJCdrg5BEtSN3bRou8lU9lTr46ncboMHVgJ0YIlU4CpXVkVSVM6EcNKb5GVSBfl
         wA4OaNks3N9Be545CkgWyIuXNjTOND/4mr444YXzCk0IHZaUe3a9p8hPbzQqHEj1OcwN
         NERH90VWj+jnNgI6gYHQXFyHARoeSud//rrKVCEPhRMYJH9JfSR+Z24x4EOzR8cuPCwz
         QfX8HofcWAPbtZ8Gday22sMemcrsv5H3zDtMjZvvZfIGmeS93kMdFHjTPDmQhr6foZr9
         naFe4hZ9t0WmH+tEqLNxHvIRb17RiqksIi4RgL11o3ruQpgjKKF2i03ZXfhwLq6S4h5g
         X8qQ==
X-Gm-Message-State: AFqh2krsaNnRc8gRsMpwu0JylT/um4P+vs/2mPSfs7LLicNFSrOJbg0w
        McnUO326UOrRasUDY7mu1Kg=
X-Google-Smtp-Source: AMrXdXvc6rGpg7/XVOxyIIHBzqvCpMobyrTvdtglPT0QHisTmxagViec805NU+1pM9zEaHigRkErEQ==
X-Received: by 2002:a17:90a:4b4e:b0:226:3901:27db with SMTP id o14-20020a17090a4b4e00b00226390127dbmr3290090pjl.47.1672374352216;
        Thu, 29 Dec 2022 20:25:52 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ml4-20020a17090b360400b00217090ece49sm12314316pjb.31.2022.12.29.20.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 20:25:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: Re: [PATCH v2 1/3] object tests: add test for unexpected objects in
 tags
References: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>
        <patch-v2-1.3-0abf873f1e3-20221230T011725Z-avarab@gmail.com>
Date:   Fri, 30 Dec 2022 13:25:51 +0900
In-Reply-To: <patch-v2-1.3-0abf873f1e3-20221230T011725Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Dec
 2022 02:52:14
        +0100")
Message-ID: <xmqqzgb5jz5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +test_expect_success !SANITIZE_LEAK 'setup unexpected non-tag tag' '
> +	test_when_finished "git tag -d tag-commit tag-tag" &&
> +
> +	git tag -a -m"my tagged commit" tag-commit $commit &&
> +	tag_commit=$(git rev-parse tag-commit) &&
> +	git tag -a -m"my tagged tag" tag-tag tag-commit &&
> +	tag_tag=$(git rev-parse tag-tag) &&
> +
> +	git cat-file tag tag-tag >good-tag-tag &&
> +	git cat-file tag tag-commit >good-commit-tag &&
> +
> +	sed -e "s/$tag_commit/$commit/" <good-tag-tag >broken-tag-tag-commit &&
> +	sed -e "s/$tag_commit/$tree/" <good-tag-tag >broken-tag-tag-tree &&
> +	sed -e "s/$tag_commit/$blob/" <good-tag-tag >broken-tag-tag-blob &&
> +
> +	sed -e "s/$commit/$tag_commit/" <good-commit-tag >broken-commit-tag-tag &&
> +	sed -e "s/$commit/$tree/" <good-commit-tag >broken-commit-tag-tree &&
> +	sed -e "s/$commit/$blob/" <good-commit-tag >broken-commit-tag-blob &&
> +
> +	tag_tag_commit=$(git hash-object -w -t tag broken-tag-tag-commit) &&
> +	tag_tag_tree=$(git hash-object -w -t tag broken-tag-tag-tree) &&
> +	tag_tag_blob=$(git hash-object -w -t tag broken-tag-tag-blob) &&

If the second block of 3 sed commands to prepare data for tags that
incorrectly claim to point at a commit are moved a bit, i.e. make
"sed's && hash-object's && update-ref's" as a logical group, the
above would become slightly easier to read, but in any case the
set-up step looks quite repetitive and boring to read ;-)

There is no strong reason to use broken-tag-* temporary files,
though.  Each of them is used exactly once, but you can just
pipe the output from "sed" to "git hash-object --stdin" without
losing any exit status, e.g.

	tag_tag_commit=$(sed -e '...' good-commit-tag |
			git hash-object -w -t tag --stdin)

> +	git update-ref refs/tags/tag_tag_commit $tag_tag_commit &&
> +	git update-ref refs/tags/tag_tag_tree $tag_tag_tree &&
> +	git update-ref refs/tags/tag_tag_blob $tag_tag_blob &&
> +
> +	commit_tag_tag=$(git hash-object -w -t tag broken-commit-tag-tag) &&
> +	commit_tag_tree=$(git hash-object -w -t tag broken-commit-tag-tree) &&
> +	commit_tag_blob=$(git hash-object -w -t tag broken-commit-tag-blob) &&
> +
> +	git update-ref refs/tags/commit_tag_tag $commit_tag_tag &&
> +	git update-ref refs/tags/commit_tag_tree $commit_tag_tree &&
> +	git update-ref refs/tags/commit_tag_blob $commit_tag_blob
> +'
> +
> +test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to commit & tag)' '
> +	test_must_fail git rev-list --objects $tag_tag_commit 2>err &&

Does this have to be "rev-list --objects" or would something like
"cat-file -t $tag_tag_commit^0" do?

Especially because "rev-list --objects" is a rather heavy-weight
command that does a lot of checking, I am wondering if it is
sensible to rely on the assumption that the errors expected below
will stay to be the only errors we get before the command exits
(hence a wish to replace it with a more narrowly focused comamnd).

> +	cat >expect <<-EOF &&
> +	error: object $commit is a commit, not a tag
> +	fatal: bad object $commit
> +	EOF
> +	test_cmp expect err &&



> +test_expect_failure !SANITIZE_LEAK 'traverse unexpected objects with for-each-ref' '
> +	cat >expect <<-EOF &&
> +	error: bad tag pointer to $tree in $tag_tag_tree
> +	fatal: parse_object_buffer failed on $tag_tag_tree for refs/tags/tag_tag_tree
> +	EOF

This depends on the fact that among the broken ones tag_tag_tree
sorts the earliest (and the command stops after barfing on a single
bad object), doesn't it?  I wonder if it makes the test more robust
by feeding refs/tags/tag_tag_tree from the command line to limit the
tips the command needs to inspect.

> +>fsck-object-isa

Move it inside the setup as the first command in case "git fsck"
succeeds?

> +test_expect_success 'setup: unexpected objects with fsck' '
> +	test_must_fail git fsck 2>err &&
> +	sed -n -e "/^error: object .* is a .*, not a .*$/ {
> +		s/^error: object \([0-9a-f]*\) is a \([a-z]*\), not a [a-z]*$/\\1 \\2/;
> +		p;
> +	}" <err >fsck-object-isa
> +'
