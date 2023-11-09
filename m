Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC5374CF
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ooqsgttk"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55825BC
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 13:20:55 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77ba6d5123fso203125285a.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 13:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699564854; x=1700169654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Or/J5+3wDOkM/LyyOMJJ4fjpBvjU1GqDjjhqzYumGE=;
        b=OoqsgttkwfbihTWF0KqIjyYjEYcwrfZRLeHnKQ89QBTYZ0x68cN/k2pmmP3DVFenIH
         Ru6J02pftlpbQdzSGYkpTl97XxfOfVa22IAnJ2Tt9RPzc9WbnHt8HI0xLPb6tUri2+4E
         RVadP3aGEhGhrahOxMNS/Es2QphWiwl1VLag64BGGgDOq+cjfVdTGGKfoYMFi3tLA6Lv
         znV7phmriYks/yUJ4Z7QtQFNy9cwmnSBvVDTi4RNC8m6TOKd2YLuNT2cbPNvxnAoPwlZ
         aVgctvP1AIz36owN13BzSrfwMeGCPO3Kt9F3YmAuNUjgeigRNCRndS6r6DBR7M/f1u7r
         hCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564854; x=1700169654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Or/J5+3wDOkM/LyyOMJJ4fjpBvjU1GqDjjhqzYumGE=;
        b=KRCQVZw5aGzqYd03GDX9EPAQSl0JUVtqiyYwxOvn20E9wNxM4Of9Kt6/EbV6Nrtc3B
         4gy/elRWzorP2XP/M7BDv3dm4MOZwilDi6STGIgKyDUoujdwKRHf5g0Tw9KFTpvH1Wlb
         sHF/g4njx3DBOdgHOJEiuzKeW6SGhYFpxR/o0j64Fp4tMwoh4DKUYXsh8+WBKH99ZZS3
         cs1EHiWzeICC4TfCKp9//nOeGeJfQe15IqNmMmIDjXU4FEeg/LZBFNJfqEgFkkj8NwD8
         PbzPXqGWpfDKAVfYGrkVtkx8EARbPRcWwrcofZefpNMg+xut6R5R1FdPXecREMKHf+Bb
         zpYg==
X-Gm-Message-State: AOJu0YzP4PH4O+czRyoHVuqnPcTFpR6tNBXppgYwVRmTThO7qh3AfOhm
	dr59q2rpvzQdwNLZB+Dc4kxbNA==
X-Google-Smtp-Source: AGHT+IEcDIkaVElP7E6IYn+WE88D9aqovQ+dHN8z23/seDY5biFtcNNES4d8M6yOGEPjRBoVdegztQ==
X-Received: by 2002:a05:620a:444a:b0:76f:5b9:3f29 with SMTP id w10-20020a05620a444a00b0076f05b93f29mr856381qkp.2.1699564854352;
        Thu, 09 Nov 2023 13:20:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id qj11-20020a05620a880b00b007742bc74184sm196864qkn.110.2023.11.09.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:20:54 -0800 (PST)
Date: Thu, 9 Nov 2023 16:20:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/9] commit-graph: use fanout value for graph size
Message-ID: <ZU1NNcP/ARxK6D89@nand.local>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <20231109072435.GF2698043@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109072435.GF2698043@coredump.intra.peff.net>

On Thu, Nov 09, 2023 at 02:24:35AM -0500, Jeff King wrote:
> @@ -323,7 +320,8 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
>  {
>  	struct commit_graph *g = data;
>  	g->chunk_oid_lookup = chunk_start;
> -	g->num_commits = chunk_size / g->hash_len;
> +	if (chunk_size / g->hash_len != g->num_commits)
> +		return error(_("commit-graph OID lookup chunk is the wrong size"));
>  	return 0;
>  }

My understanding is that you need this error message to come from
graph_read_oid_lookup() in order to pass the "detect incorrect fanout
final value" test, but I wish that we didn't have to, since having the
more-or-less duplicate error messages in the latter "reader notices
fanout/lookup table mismatch" is somewhat unfortunate.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index affb959d64..8bd7fcefb5 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -560,7 +560,7 @@ test_expect_success 'detect incorrect fanout' '
>
>  test_expect_success 'detect incorrect fanout final value' '
>  	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
> -		"oid table and fanout disagree on size"
> +		"OID lookup chunk is the wrong size"
>  '
>
>  test_expect_success 'detect incorrect OID order' '
> @@ -850,7 +850,8 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
>  test_expect_success 'reader notices fanout/lookup table mismatch' '
>  	check_corrupt_chunk OIDF 1020 "FFFFFFFF" &&
>  	cat >expect.err <<-\EOF &&
> -	error: commit-graph oid table and fanout disagree on size
> +	error: commit-graph OID lookup chunk is the wrong size
> +	error: commit-graph required OID lookup chunk missing or corrupted
>  	EOF
>  	test_cmp expect.err err
>  '
> --
> 2.43.0.rc1.572.g273fc7bed6
>
Thanks,
Taylor
