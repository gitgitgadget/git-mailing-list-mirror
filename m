Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DC1448EA
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783113; cv=none; b=M9YFtPghynZPccCHKNjr/HOoJK429gXeVljzGffw2Qs5H5z4V7mXcZsoTadRgQwf1qC5yGHbqd2XZ1644YfTBfl6zK+kcJoCrVCpEthKpxugUmS7uNXV5L2rg6H7CcmEj7KZbmoy6E8UXcyKjTQpr6Y2/wow/E69nvdPs/Is2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783113; c=relaxed/simple;
	bh=eoM9v4jS4cYwM7HCTrUkc0faISbBgkMmVWPLk28v8O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=snjdIR5RMc2es7HBVlZ3JljIWwHY159fwpgR/xLeOJc9IMNWunnfaeznGiNOpYcN5P45PchmYR774J8yiNxmuZL+ADnsby/60ktjV/a+00yWLRlV1JZmR4uXq63KcYvV4IWZF2jSYxQh7sRjBUX1qHEL1+qtOT/fxlPOo2w9228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G0LvSd7Q; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G0LvSd7Q"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6912F2CE49;
	Thu, 19 Sep 2024 17:58:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eoM9v4jS4cYwM7HCTrUkc0faISbBgkMmVWPLk2
	8v8O8=; b=G0LvSd7QzE8Y88Slr7pOAzAO2ckeQiO5UvXt9AtfkW0RFPsPe1PpPG
	Dg06vxgReY1FdWHV37MgXVYN5777X9ClOid28DMMuN1m44jivRQpJ6iN5fN3HHPx
	/CRaTayj+d0v7TSMXDtzdNzuxPVXUEYEeoIJJxxd//z8v0mfMrCvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FC2A2CE48;
	Thu, 19 Sep 2024 17:58:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE1BE2CE47;
	Thu, 19 Sep 2024 17:58:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/6] p5313: add size comparison test
In-Reply-To: <999b1d094241b0ba8d6924ac6976eafc64c7d4a6.1726692382.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 18 Sep 2024
	20:46:20 +0000")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
	<999b1d094241b0ba8d6924ac6976eafc64c7d4a6.1726692382.git.gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 14:58:27 -0700
Message-ID: <xmqqcykz5mrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4D8C3D4A-76D2-11EF-B89D-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> As custom options are added to 'git pack-objects' and 'git repack' to
> adjust how compression is done, use this new performance test script to
> demonstrate their effectiveness in performance and size.
>
> The recently-added --full-name-hash option swaps the default name-hash
> algorithm with one that attempts to uniformly distribute the hashes
> based on the full path name instead of the last 16 characters.
>
> This has a dramatic effect on full repacks for repositories with many
> versions of most paths. It can have a negative impact on cases such as
> pushing a single change.
>
> This can be seen by running pt5313 on the open source fluentui
> repository [1]. Most commits will have this kind of output for the thin
> and big pack cases, though certain commits (such as [2]) will have
> problematic thin pack size for other reasons.
>
> [1] https://github.com/microsoft/fluentui
> [2] a637a06df05360ce5ff21420803f64608226a875
>
> Checked out at the parent of [2], I see the following statistics:
>
> Test                                           this tree
> ------------------------------------------------------------------
> 5313.2: thin pack                              0.02(0.01+0.01)
> 5313.3: thin pack size                                    1.1K
> 5313.4: thin pack with --full-name-hash        0.02(0.01+0.00)
> 5313.5: thin pack size with --full-name-hash              3.0K
> 5313.6: big pack                               1.65(3.35+0.24)
> 5313.7: big pack size                                    58.0M
> 5313.8: big pack with --full-name-hash         1.53(2.52+0.18)
> 5313.9: big pack size with --full-name-hash              57.6M
> 5313.10: repack                                176.52(706.60+3.53)
> 5313.11: repack size                                    446.7K
> 5313.12: repack with --full-name-hash          37.47(134.18+3.06)
> 5313.13: repack size with --full-name-hash              183.1K
>
> Note that this demonstrates a 3x size _increase_ in the case that
> simulates a small "git push". The size change is neutral on the case of
> pushing the difference between HEAD and HEAD~1000.
>
> However, the full repack case is both faster and more efficient.

Nice.

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  t/perf/p5313-pack-objects.sh | 71 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100755 t/perf/p5313-pack-objects.sh

"wc -c" -> "test_file_size" or "test-tool path-utils file-size"?
