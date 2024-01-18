Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95592D03C
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609005; cv=none; b=GIWToBRDKxp6fTYXRboG+pzFjPrVQRFCkL9okaJh9vJ24AHLzJOv+nf3EzrkGFkupcxyqaMtXSrCZ9suQEz4qzMjWD15X7DYr8C7udRCtdn1e5l3GEU9sO+dP2/r0B5ID4R0rUqWJxDFgDiWB0M2Jis2eoKZ2m0OD68cxa4+QOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609005; c=relaxed/simple;
	bh=9PhS9g73cS3DgL/ju7fm58h1JjJcy0eBIJ5/MYsS7/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4Ri0Iu5x2XCX6X7rJtXDw5LK4n1Z4XBP3XXRRp2kQQLDsIVlE+kXmU/miSj4oum6YZEEnwqnV/rMLF49j53nFkx45PDHhcz1coHwqK0LexHE9VgazuVhQjdg3ZhWekk8p4TdheTpmUuNlxg7sh6LTX809H9A5HlMWOlUb/U/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SyxjrZrO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SyxjrZrO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 321CC1CC655;
	Thu, 18 Jan 2024 15:16:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9PhS9g73cS3DgL/ju7fm58h1JjJcy0eBIJ5/MY
	sS7/Q=; b=SyxjrZrOg47h93eGJfDze1feG7a0FdpBKkSxguwEXdnA6qEpazdI4E
	vhccQew6X+iSziEwrBmLyXWTiC//TC1+xzDz4ra0WwYeYAEWkmtJyP/vOU5LE3aZ
	tbUXOlGHBVDYiF4hZ5PdKS+d0mK0j8Q39aC1zUykzLChHo9IiKsOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27FD31CC654;
	Thu, 18 Jan 2024 15:16:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 754741CC653;
	Thu, 18 Jan 2024 15:16:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH v2] merge-ll: expose revision names to custom drivers
In-Reply-To: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
	(Antonin Delpeuch via GitGitGadget's message of "Thu, 18 Jan 2024
	15:43:01 +0000")
References: <pull.1648.git.git.1705587974840.gitgitgadget@gmail.com>
	<pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 12:16:40 -0800
Message-ID: <xmqq1qaeqtw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E1AF988-B63E-11EE-B5EC-25B3960A682E-77302942!pb-smtp2.pobox.com

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Antonin Delpeuch <antonin@delpeuch.eu>
>
> Custom merge drivers need access to the names of the revisions they
> are working on, so that the merge conflict markers they introduce
> can refer to those revisions. The placeholders '%S', '%X' and '%Y'
> are introduced to this end.
>
> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> ---
>     merge-ll: expose revision names to custom drivers
>
>  Documentation/gitattributes.txt | 10 +++++++---
>  merge-ll.c                      | 17 ++++++++++++++---
>  t/t6406-merge-attr.sh           | 16 +++++++++++-----
>  3 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 201bdf5edbd..108c2e23baa 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -1141,7 +1141,7 @@ command to run to merge ancestor's version (`%O`), current
>  version (`%A`) and the other branches' version (`%B`).  These
>  three tokens are replaced with the names of temporary files that
>  hold the contents of these versions when the command line is
> -built. Additionally, %L will be replaced with the conflict marker
> +built. Additionally, `%L` will be replaced with the conflict marker
>  size (see below).

Good eyes.  Nice to fix it while we are in the vicinity.

> @@ -1159,8 +1159,12 @@ When left unspecified, the driver itself is used for both
>  internal merge and the final merge.
>  
>  The merge driver can learn the pathname in which the merged result
> -will be stored via placeholder `%P`.
> -
> +will be stored via placeholder `%P`. Additionally, the names of the
> +merge ancestor revision (`%S`), of the current revision (`%X`) and

The phrase already existsin the description of '%O', but the correct
word for that is "the common ancestor", not "the merge ancestor".
At least this one is consistent with the existing error, so we can
fix them together in a clean-up patch after the dust settles.  

Or you could fix %O's description "while at it" and use the right
term from the get-go for %S.

> diff --git a/merge-ll.c b/merge-ll.c
> index 1df58ebaac0..ae9eb69be14 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -185,9 +185,9 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
>  static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>  			mmbuffer_t *result,
>  			const char *path,
> -			mmfile_t *orig, const char *orig_name UNUSED,
> -			mmfile_t *src1, const char *name1 UNUSED,
> -			mmfile_t *src2, const char *name2 UNUSED,
> +			mmfile_t *orig, const char *orig_name,
> +			mmfile_t *src1, const char *name1,
> +			mmfile_t *src2, const char *name2,
>  			const struct ll_merge_options *opts,
>  			int marker_size)
>  {
> @@ -222,6 +222,12 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>  			strbuf_addf(&cmd, "%d", marker_size);
>  		else if (skip_prefix(format, "P", &format))
>  			sq_quote_buf(&cmd, path);
> +		else if (skip_prefix(format, "S", &format))
> +		    sq_quote_buf(&cmd, orig_name);
> +		else if (skip_prefix(format, "X", &format))
> +			sq_quote_buf(&cmd, name1);
> +		else if (skip_prefix(format, "Y", &format))
> +			sq_quote_buf(&cmd, name2);
>  		else
>  			strbuf_addch(&cmd, '%');
>  	}

I see some funny indentation for "S" here.

> diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
> index 72f8c1722ff..156a1efacfe 100755
> --- a/t/t6406-merge-attr.sh
> +++ b/t/t6406-merge-attr.sh
> @@ -42,11 +42,15 @@ test_expect_success setup '
>  	#!/bin/sh
>  
>  	orig="$1" ours="$2" theirs="$3" exit="$4" path=$5
> +	orig_name="$6" our_name="$7" their_name="$8"
>  	(
>  		echo "orig is $orig"
>  		echo "ours is $ours"
>  		echo "theirs is $theirs"
>  		echo "path is $path"
> +		echo "orig_name is $orig_name"
> +		echo "our_name is $our_name"
> +		echo "their_name is $their_name"
>  		echo "=== orig ==="
>  		cat "$orig"
>  		echo "=== ours ==="
> @@ -121,7 +125,7 @@ test_expect_success 'custom merge backend' '
>  
>  	git reset --hard anchor &&
>  	git config --replace-all \
> -	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
> +	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
>  	git config --replace-all \
>  	merge.custom.name "custom merge driver for testing" &&
>  
> @@ -132,7 +136,8 @@ test_expect_success 'custom merge backend' '
>  	o=$(git unpack-file main^:text) &&
>  	a=$(git unpack-file side^:text) &&
>  	b=$(git unpack-file main:text) &&
> -	sh -c "./custom-merge $o $a $b 0 text" &&
> +	base_revid=$(git rev-parse --short main^) &&
> +	sh -c "./custom-merge $o $a $b 0 text $base_revid HEAD main" &&
>  	sed -e 1,3d $a >check-2 &&
>  	cmp check-1 check-2 &&
>  	rm -f $o $a $b

OK.

> @@ -142,7 +147,7 @@ test_expect_success 'custom merge backend' '
>  
>  	git reset --hard anchor &&
>  	git config --replace-all \
> -	merge.custom.driver "./custom-merge %O %A %B 1 %P" &&
> +	merge.custom.driver "./custom-merge %O %A %B 1 %P %S %X %Y" &&
>  	git config --replace-all \
>  	merge.custom.name "custom merge driver for testing" &&
>  
> @@ -159,7 +164,8 @@ test_expect_success 'custom merge backend' '
>  	o=$(git unpack-file main^:text) &&
>  	a=$(git unpack-file anchor:text) &&
>  	b=$(git unpack-file main:text) &&
> -	sh -c "./custom-merge $o $a $b 0 text" &&
> +	base_revid=$(git rev-parse --short main^) &&
> +	sh -c "./custom-merge $o $a $b 0 text $base_revid HEAD main" &&
>  	sed -e 1,3d $a >check-2 &&
>  	cmp check-1 check-2 &&
>  	sed -e 1,3d -e 4q $a >check-3 &&

OK.

> @@ -173,7 +179,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
>  
>  	git reset --hard anchor &&
>  	git config --replace-all \
> -	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
> +	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
>  	git config --replace-all \
>  	merge.custom.name "custom merge driver for testing" &&

;-)

This one is expected to die and not produce meaningful output;
I was wondering why this does not need to make corresponding changes
to the expected output pattern like the earlier tests.

