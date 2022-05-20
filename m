Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E9BC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353224AbiETTnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiETTnB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:43:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF35190D19
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:42:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so12382333pjb.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KmyvVF/HpBUHZ/g2TJ5hL8iM58E45WBwBfpRgz/z8m4=;
        b=i2fQKyENk52q4vuEATKn6Jvqwt7+um8wzUuwWmPdaYpmxWfneCRH3TiqNl48hx0M7l
         1XJdIQuLtwIu5ONuDnsBTXIomT69xoHKX7wVsg84qjoO86gQ7jVrKfTYY29Xph8LKS8l
         Esb88xVsOKXlCFyO3Ytg33MhFFCSAUGGHlOeHQi+ISrbgN1XgYve82v2/I70W2CSB2GM
         64ZfSZatiluAzzbybjvIvIlSX2gfjIV0DWQuMgffqfHB01ZI40IeS18U8ZBAA2wolGyi
         V5uFc2cmHYZjcnGt94DjbFTx5ikPc95/bwpwHaeolzH9wKkcOPn/I/KY+YpjId5BgWOy
         6b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KmyvVF/HpBUHZ/g2TJ5hL8iM58E45WBwBfpRgz/z8m4=;
        b=QtTWlMkOO4YsbcA8nmtObbJPmA3lm1ISq5zTfOPLe6Q5gO79+Va9KN6ToUeyWZInV/
         T8pjB0FXtEGMNGog5ryKXuIEdQg0yTYU9GrsaOA1SNUOkT10Tr369gq3vuztB+KLxEeO
         tLaJe6PO2dLzn2YSFyPapKK4olG+4fMzoAnUYKyEGXwhuASb5Ubnl0ieCDFSaW6QXJWP
         vLoVVre0rhuGY573/ZE/NOgBmLbj8r5OouJiA54Xk9uwgA2yJW5tpgo5hcL3jozvpH4z
         RCdjkfR+qN6LS6/42O8bdPcgzmzSHfKKih1gJjhpS0ls9ms3RBK6j7vbga+0m4slwD7j
         0SEw==
X-Gm-Message-State: AOAM530FBjc+OCEX4EJpFQYenzmxJlsNQZgD+yuH70E41lv5Ejnt/Qlx
        KHp62EcZiR0AUHte8yO1GB6vbxgF2rG+
X-Google-Smtp-Source: ABdhPJxrBrACCMHxCjVdVo6CH0rpJtRX4eZU/k3CPN8TtVR0fkjbliLWqsQnerde1QNxCiK5tz7UQA==
X-Received: by 2002:a17:902:ee52:b0:161:96bc:da8f with SMTP id 18-20020a170902ee5200b0016196bcda8fmr11020130plo.25.1653075779453;
        Fri, 20 May 2022 12:42:59 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902a50900b0015e8d4eb1c7sm138962plq.17.2022.05.20.12.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 12:42:59 -0700 (PDT)
Message-ID: <a060d672-df82-95a3-072a-7ab7b0566556@github.com>
Date:   Fri, 20 May 2022 12:42:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] t7703: demonstrate object corruption with
 pack.packSizeLimit
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <cover.1653073280.git.me@ttaylorr.com>
 <08da02fa74c211ae1019cb0a9f4e30cc239e1ab9.1653073280.git.me@ttaylorr.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <08da02fa74c211ae1019cb0a9f4e30cc239e1ab9.1653073280.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> When doing a `--geometric=<d>` repack, `git repack` determines a
> splitting point among packs ordered by their object count such that:
> 
>   - each pack above the split has at least `<d>` times as many objects
>     as the next-largest pack by object count, and
>   - the first pack above the split has at least `<d>` times as many
>     object as the sum of all packs below the split line combined
> 
> `git repack` then creates a pack containing all of the objects contained
> in packs below the split line by running `git pack-objects
> --stdin-packs` underneath. Once packs are moved into place, then any
> packs below the split line are removed, since their objects were just
> combined into a new pack.
> 
> But `git repack` tries to be careful to avoid removing a pack that it
> just wrote, by checking:
> 
>     struct packed_git *p = geometry->pack[i];
>     if (string_list_has_string(&names, hash_to_hex(p->hash)))
>       continue;
> 
> in the `delete_redundant` and `geometric` conditional towards the end of
> `cmd_repack`.
> 
> But it's possible to trick `git repack` into not recognizing a pack that
> it just wrote when `names` is out-of-order (which violates
> `string_list_has_string()`'s assumption that the list is sorted and thus
> binary search-able).
> 
> When this happens in just the right circumstances, it is possible to
> remove a pack that we just wrote, leading to object corruption.
> 
> Luckily, this is quite difficult to provoke in practice (for a couple of
> reasons):
> 
>   - we ordinarily write just one pack, so `names` usually contains just
>     one entry, and is thus sorted
>   - when we do write more than one pack (e.g., due to `--max-pack-size`)
>     we have to: (a) write a pack identical to one that already
>     exists, (b) have that pack be below the split line, and (c) have
>     the set of packs written by `pack-objects` occur in an order which
>     tricks `string_list_has_string()`.
> 
> Demonstrate the above scenario in a failing test, which causes `git
> repack --geometric` to write a pack which occurs below the split line,
> _and_ fail to recognize that it wrote that pack.
> 
> The following patch will fix this bug.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t7703-repack-geometric.sh | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 91bb2b37a8..2cd1de7295 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -7,6 +7,7 @@ test_description='git repack --geometric works correctly'
>  GIT_TEST_MULTI_PACK_INDEX=0
>  
>  objdir=.git/objects
> +packdir=$objdir/pack
>  midx=$objdir/pack/multi-pack-index
>  
>  test_expect_success '--geometric with no packs' '
> @@ -230,4 +231,50 @@ test_expect_success '--geometric chooses largest MIDX preferred pack' '
>  	)
>  '
>  
> +test_expect_failure '--geometric with pack.packSizeLimit' '
> +	git init pack-rewrite &&
> +	test_when_finished "rm -fr pack-rewrite" &&
> +	(
> +		cd pack-rewrite &&
> +
> +		test-tool genrandom foo 1048576 >foo &&
> +		test-tool genrandom bar 1048576 >bar &&
> +

I was a bit worried about this test being flaky in the future (relying on
particular pseudorandomly-generated file contents and the subsequent
ordering of hashes on the packs). But, since neither 'genrandom' nor the
pack hash generation seem likely to change (and I can't come up with an
alternative to this approach anyway), the test looks good as-is. 

> +		git add foo bar &&
> +		test_tick &&
> +		git commit -m base &&
> +
> +		git rev-parse HEAD:foo HEAD:bar >p1.objects &&
> +		git rev-parse HEAD HEAD^{tree} >p2.objects &&
> +
> +		# These two packs each contain two objects, so the following
> +		# `--geometric` repack will try to combine them.
> +		p1="$(git pack-objects $packdir/pack <p1.objects)" &&
> +		p2="$(git pack-objects $packdir/pack <p2.objects)" &&
> +
> +		# Remove any loose objects in packs, since we do not want extra
> +		# copies around (which would mask over potential object
> +		# corruption issues).
> +		git prune-packed &&
> +
> +		# Both p1 and p2 will be rolled up, but pack-objects will write
> +		# three packs:
> +		#
> +		#   - one containing object "foo",
> +		#   - another containing object "bar",
> +		#   - a final pack containing the commit and tree objects
> +		#     (identical to p2 above)
> +		git repack --geometric 2 -d --max-pack-size=1048576 &&
> +
> +		# Ensure `repack` can detect that the third pack it wrote
> +		# (containing just the tree and commit objects) was identical to
> +		# one that was below the geometric split, so that we can save it
> +		# from deletion.
> +		#
> +		# If `repack` fails to do that, we will incorrectly delete p2,
> +		# causing object corruption.
> +		git fsck
> +	)
> +'
> +
>  test_done

