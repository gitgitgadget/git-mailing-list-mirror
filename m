Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAC56B6A
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194063; cv=none; b=S6HAMhA/YPzFkCg0kr3ekpkiWUkkPNyar9OE3nVEpUCbFbOMol5EfBk6r2qsCmt561muBl2VYMsIwqveicYQwvIpXZZoYfTm8I0cCECqw3wFSXJHiKYGkTlsNILX8+xw5mORph/MOq/mQbwTaesgfA9/LcXdVauMeioY9Gvhvag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194063; c=relaxed/simple;
	bh=jLgVPgr2U4Ej4HrFrrhVCxWsQX2H0AZsXoT3KJYRYNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t3xcmBqAsj4tEwU3+NNnSTiTAHyFOxQqR7OC+1fnrdE4j3wEUfzuGl+Ij0aR7LURhq54vf/MCI6qSGyjQgS8jRlsOjmEzcbqw9ioF0+YF6rqWuTbpicOCZbS2JgGCej+gxg1ZNJgWNKAoKFRsHZ3/p6UtNCe49YH86Zv4PzEud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YC2/wgbv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YC2/wgbv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DF6282F13C;
	Mon, 11 Mar 2024 17:54:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jLgVPgr2U4Ej4HrFrrhVCxWsQX2H0AZsXoT3KJ
	YRYNg=; b=YC2/wgbvRv+tf8WxQK+1juREJlUOhsvvdweEK/x0Wlo6CQJUCjLmvQ
	wL0wAOLmxI9O0XVmKN8RxUQrzqQzVPWLGkHxWgGT71r1JEzYok8Wxh6ckDQkntkG
	3ZlaTSt9Ay28n+twKnwyH/aytEGEK5eV3YaCyH9Qp+aIDdxO0OW+k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D731C2F13B;
	Mon, 11 Mar 2024 17:54:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8246B2F138;
	Mon, 11 Mar 2024 17:54:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/3] t1006: update 'run_tests' to test generic object
 specifiers
In-Reply-To: <765d7240311e145b43bbe40f00436f3854a4a177.1710183362.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Mon, 11 Mar 2024 18:56:00
	+0000")
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
	<765d7240311e145b43bbe40f00436f3854a4a177.1710183362.git.gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 14:54:15 -0700
Message-ID: <xmqqle6oo2ns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E87A01FC-DFF1-11EE-8A7E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Update the 'run_tests' test wrapper so that the first argument may refer to
> any specifier that uniquely identifies an object (e.g. a ref name,
> '<OID>:<path>', '<OID>^{<type>}', etc.), rather than only a full object ID.
> Also, add a test that uses a non-OID identifier, ensuring appropriate
> parsing in 'cat-file'.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1006-cat-file.sh | 46 +++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index e0c6482797e..ac1f754ee32 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -112,65 +112,66 @@ strlen () {
>  
>  run_tests () {
>      type=$1
> -    sha1=$2
> +    object_name=$2
> +    oid=$(git rev-parse --verify $object_name)
>      size=$3
>      content=$4
>      pretty_content=$5
>  
> -    batch_output="$sha1 $type $size
> +    batch_output="$oid $type $size
>  $content"

As "object_name" is now allowed to be any name in the 'extended
SHA-1' syntax (cf. Documentation/revisions.txt), you should be a bit
more careful in quoting.

	oid=$(git rev-parse --verify "$object_name")

>      test_expect_success "$type exists" '
> -	git cat-file -e $sha1
> +	git cat-file -e $object_name
>      '

Likewise.  You may not currently use a path with SP in it to name a
tree object, e.g., "HEAD:Read Me.txt", but protecting against such a
pathname is a cheap investment for futureproofing.

Looking good otherwise.  Thanks.
