Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD8C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbiB1Pqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiB1Pqx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:46:53 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033A79C7E
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:46:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm8so18222873edb.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=v/VMQ9ZXrS49BFDp9eRgvuMUC4N4nK+gZkD26AAB7Xo=;
        b=dem0+Cvi6KjIX+Q87RFDuB0eNR1av96eGE2x0x2ALzLokOBkjsAenZxQwQRZelHjtu
         g3SR87GvI9QLpjsyAOQp5N50dJDRIrHeCKaNpgBT295iPJQkOPB02F2cKdshpNJXf4C1
         5HVhMY2N3dBaJyGIAOcXQOX2uSNCq4CQzFupQzuGR5XrOGDV+HY5NfAzz3zWUxVjFFZM
         XXfp1PPeSDro6oN8Lusxpm2C8DZXuVRncKwTTO6205ssJ+Pmqqx8Fd3kZdvvSSfCuIfI
         3WNa9YeyKQdGDvFnhXwPncymbIFj3+YaJgrC8rGfYONxCRrlyL9TYFnO95/FJISD9/Wf
         MHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=v/VMQ9ZXrS49BFDp9eRgvuMUC4N4nK+gZkD26AAB7Xo=;
        b=rzrD/6W+n2qeaYL0DaBHfCP5+jbAAR7IoGvfCZ1FbN3IsqnP900YXljcfj6dLWxM3f
         fo/fC/u1s2iVBKKwVA+UVYblP8DWFSrU7rDIZ8+3ivYbkyB/4gCM94Wa240To9cS9OM1
         tLPsnLdWYurzNaeiHgXr+uaxBvp5wWWeuxfeNSFwoiLHnBmfLoECO5ROlVrly2FQRVhP
         U0PNzA0spp5WazYbinJTZtnGFJdtJNPJH9+/kOZWi1FHU1R7PxPbKUG504B+tmu0ajcv
         aXBqgHs6I/YfosyaEPtWyWTBxpKpAFHXmHP1i8Pkx5ncgpi/kG+C6U+ryiJnXp9ytyIu
         qmdw==
X-Gm-Message-State: AOAM5322Qz2M/MPVH9R7pOZZB7CgVokPn+Us72pZ6r9tpqDS6n/ii7K2
        BCupgkjgPyc19vg4pxe0MniSemd0Vrs=
X-Google-Smtp-Source: ABdhPJwQYvdK9HRnVLJiARW9DIPHbSwjxizghDe/aX4NPMi1R5Xe7EQDoRR+sWKj2pWLA4XVSrt2TA==
X-Received: by 2002:a05:6402:2343:b0:413:2c28:ee90 with SMTP id r3-20020a056402234300b004132c28ee90mr20203464eda.413.1646063172176;
        Mon, 28 Feb 2022 07:46:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906770900b006d20acf7e2bsm4428973ejm.200.2022.02.28.07.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 07:46:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOiDy-001RWV-QA;
        Mon, 28 Feb 2022 16:46:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/4] commit-graph: fix generation number v2 overflow
 values
Date:   Mon, 28 Feb 2022 16:40:26 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
 <193217c71e0aaf3f56a02d9abec6753bd19aba71.1646056423.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <193217c71e0aaf3f56a02d9abec6753bd19aba71.1646056423.git.gitgitgadget@gmail.com>
Message-ID: <220228.868rtv3sfx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The Generation Data Chunk was implemented and tested in e8b63005c
> (commit-graph: implement generation data chunk, 2021-01-16), but the
> test was carefully constructed to work on systems with 32-bit dates.
> Since the corrected commit date offsets still required more than 31
> bits, this triggered writing the generation_data_overflow chunk.
>
> However, upon closer look, the
> write_graph_chunk_generation_data_overflow() method writes the offsets
> to the chunk (as dictated by the format) but fill_commit_graph_info()
> treats the value in the chunk as if it is the full corrected commit date
> (not an offset). For some reason, this does not cause an issue when
> using the FUTURE_DATE specified in t5318-commit-graph.sh, but it does
> show up as a failure in 'git commit-graph verify' if we increase that
> FUTURE_DATE to be above four billion.
>
> Fix this error and update the test to require 64-bit dates so we can
> safely use this large value in our test.

Hrm, so perhaps re my comment on 2/4 @2147483646 was never used? I'm not
sure I understand this.

> diff --git a/commit-graph.c b/commit-graph.c
> index 8e52bb09552..b86a6a634fe 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -806,7 +806,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
>  				die(_("commit-graph requires overflow generation data but has none"));
>  
>  			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
> -			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
> +			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
>  		} else
>  			graph_data->generation = item->date + offset;
>  	} else
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 1afee1c2705..f4ffaad661d 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -815,6 +815,15 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
>  	)
>  '

This goes back to my comment on 3/4 but:

> +# The remaining tests check timestamps that flow over
> +# 32-bits. The graph_git_behavior checks can't take a
> +# prereq, so just stop here if we are on a 32-bit machine.
> +
> +if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
> +then
> +	test_done
> +fi
> +

This...(continued)...

>  # We test the overflow-related code with the following repo history:
>  #
>  #               4:F - 5:N - 6:U
> @@ -832,10 +841,10 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
>  # The largest offset observed is 2 ^ 31, just large enough to overflow.
>  #
>  
> -test_expect_success 'set up and verify repo with generation data overflow chunk' '
> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'set up and verify repo with generation data overflow chunk' '
>  	objdir=".git/objects" &&
>  	UNIX_EPOCH_ZERO="@0 +0000" &&
> -	FUTURE_DATE="@2147483646 +0000" &&
> +	FUTURE_DATE="@4000000000 +0000" &&

Hrm, again this may be over my head, but @4147483646 instead of
@2147483646 in the other test, but @4000000000 instead of the same here?


>  	test_oid_cache <<-EOF &&
>  	oid_version sha1:1
>  	oid_version sha256:2
> @@ -867,4 +876,8 @@ test_expect_success 'set up and verify repo with generation data overflow chunk'
>  
>  graph_git_behavior 'generation data overflow chunk repo' repo left right
>  
> +# Do not add tests at the end of this file, unless they require 64-bit
> +# timestamps, since this portion of the script is only executed when
> +# time data types have 64 bits.
> +
>  test_done

...and this would really be much nicer if we split this test up into its
own file, which would be obviously named to note the
issue. tXXXX-commit-graph-64bit-timestamp.sh or something.

As shown in my recent 0a2bfccb9c8 (t0051: use "skip_all" under !MINGW in
single-test file, 2022-02-04) you'll also get much nicer output from
"prove" in that case.
 
