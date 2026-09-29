Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816A4E0B8C
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716771; cv=none; b=U5B0dRJwclnBUkI6ouiRuASUWnNaO3yU8fiqZ1uuuYPekbsoREjYtM2OqXA158y9LimmJl/Rhdli/A3SiaQHH9c1wPpcLC42mpv2IiAicAe7sfz2eJnSEnvT2bTP5hLNsutMYGzXCoN9RMOdUScHmdEEvsE6ldCFT+khBtf+eVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716771; c=relaxed/simple;
	bh=WIlEvzJNelz6WVNhyBeLlrL7eeYd6oES4qqlFJG/mg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHKsktVlo6xcyBytzWoQlMLAIp1M4Uq2TaNnWTHtpJ8SLrpdaGOwgtOiraXPh/zb5R+UG2PjgUj3KIUrLG8GBcmVg75UI26Le/xWUMHcxgIiyD7F8G1lcQBbknZ/glNbsLsQaeACbSLic2jdgP39sr+1ki81fsWMa2lbZfkqL+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=biHqb75z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmlt9Ifd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="biHqb75z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmlt9Ifd"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB8FB7A07C9;
	Tue, 29 Sep 2026 17:19:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 29 Sep 2026 17:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790716768; x=1790803168; bh=JquTPXbZKV
	mSgd1SjJlBYZNyPWgztUnSH3ZdtB5HnNI=; b=biHqb75zFknN/yldM/Ew7VD5CB
	62rAs8uTD2DNyJALZmiQZSxXb2R76DvDPgCEWR5Sq4n2PRay7AV8rztLjXYRXKhF
	zf20Wa9KyWydtt8RVgrD3QAxlU5I+bNPfV3IXT0Qddms03HUOT9qUhUxo1Jb1nmL
	Xy63/uRxYAJljQli/HX/zb1tJW2/znGLvt/25ZZHv/GO+diTtD5wTc2vQbApjpnR
	bFXwnV8IUvWlcWrKFBnOc2cbF+MYYrUjcSVENN4ciwcwB2BctFEtVOWnnd1Udd8X
	nSdDTgNCyg7ERk7QJcoQH2ee5rKhPG2u44ZzHJ7pBmbtUMPYEYgawCsaB/7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790716768; x=1790803168; bh=JquTPXbZKVmSgd1SjJlBYZNyPWgztUnSH3Z
	dtB5HnNI=; b=kmlt9IfdF+Cswki6GyE6Hjm0nDjqLhqIqRHUP6Hr3CXNYGgKbUd
	itgob1g5XD9LWJwSserM/w5xNJ4Kn4/Xm2lnXmgRGXMPeG2SHkUIGS1t/TE/fAmb
	F2TzUediS5cRK5rES739b5JnLQw22hnov3q6WzSdR+Va090j4pgDYokaOwolGc6w
	sZ4B4E4bb4WASFqRwCp2W+8Pm9hicJaTic4b1bK+ysjSxihBAvzswuRD3fwDiKGj
	NW5Goc6rP4PVNPyM5d1jcV9Z7CQ1loV/irLKens6tnY9xizFnzTQgq6N6gehMeI3
	5/oslHvrnBLfHF/g99uPwtpTu8EjodtYONw==
X-ME-Sender: <xms:YCu8arlHeHHOvL9yZpAenS_VnjOi2hqeALFOfV7d5XLy7UZOwJ-NpQ>
    <xme:YCu8al2AYVAwDfMPzdl-LCmQyPBR7jRa2VcFCqUXnpI9d_glBdwB9j6DWwAWyX4I2
    keOqovMicHOWHneu32cZd4TJ9rIWL6GRFvBbg-SPFtapZ2CEVSUijY>
X-ME-Received: <xmr:YCu8ampDfTx3dv06CgTbu33Sik2ezS6rx8Em_WyNOGKkDmIvx7H7_yfye_5jj2v2jnJSk7zzb-JXyxnOXiQAbG6909g1GoUmAwLJ>
X-ME-Proxy-Cause: dmFkZTFcSXR5EAyweUoxqkZ6LQkIMKK6ybh4XLwGneqNUgoFKzvCAm5+n5CUuml2LawR5K
    bA/OuJEWNI+3ULkituYBCSxUQwGQSEJrh4DLibfJAaYWYJoppohbDKj6iohAVKNNEwBhrG
    +lfdrIxMlcq6KpEJutLpsu7hyCsoA24KbZLABWHXiJy4fBZTGLfwjUGozVEtzWkbV94nf1
    MMVB/7rv4fx6LrqUUnEfIGXa28ruxHBcBfbXb/IgNddlDDVno/3bOOqrJIks5QMBurGCNW
    zQsySIwqxCip7nLHOcRSgOa38Ye/hAgFzY7kJwZwmPTvwhmlWeDQZJh45MSq5UyJv/S4I/
    hozdLt+eK9EyOMez+Z0Fy45ZxUziaqyKGD/xGOUDfv71lxk1Bv2dfNuGtywR/0BMwgY238
    p5M1Xw1LKXzOmqmdZLQSoEQLxXfhKf29I6zrfUiafcXy+S2Wp0GrGz4pjPJckhe8C9GvJQ
    fM3IDIskgDedJObTTfU+Zn6tylKTFZE3R6mngGyH9HVOboj5WD/ioSZb1cIT+U7TMrzJix
    xUWqJ6/l7xVh3lGYdQ6A7oQExI0pvvQYsgK0Qy9CS5BijLLR15NcIU2HGDoqq0yX8MsjKd
    RKBInL5KaHk104Z5vHC2wPWJf/3/khkWrE6AFJeoAL2VUZ/rnTLbpMUGV04g
X-ME-Proxy: <xmx:YCu8aif-vjZ_0CGNmSy4nQm0uEoDL6IU1nnwi6HLpHSFn9hHYJiCgQ>
    <xmx:YCu8alp23rK2b3U11CwDbwd4nISy5OAavpHSoKhUeY_dRmItvLLLOw>
    <xmx:YCu8ajGOm3zQrq4imYXEFRjFbt8eQVMwjhSjhk89uBbp91mFR8aEiA>
    <xmx:YCu8alukEutQdF90c4thX4eq8hzDGs1Zmuoc0LzLtCLE-tMld-XLew>
    <xmx:YCu8amnmkhrS_7odp2eM0O-aIapqByY_t0X_FRu6IZy4M_pkFTNByzXb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 17:19:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/5] merge-ll: report an error when reading external
 merge results fails
In-Reply-To: <20260929204421.GB1734030@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Sep 2026 16:44:21 -0400")
References: <20260929204157.GA1733321@coredump.intra.peff.net>
	<20260929204421.GB1734030@coredump.intra.peff.net>
Date: Tue, 29 Sep 2026 14:19:26 -0700
Message-ID: <xmqqv77neowx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> +test_expect_success SANITY 'rerere preserves conflicts when driver output is unreadable' '
> +	test_create_repo unreadable-output &&
> +	(

> +		cd unreadable-output &&
> +		git config rerere.enabled true &&
> +		git config rerere.autoupdate true &&
> +		write_script merge-driver <<-\EOF &&
> +		git merge-file "$@"
> +		status=$?
> +		if test -f fail-read
> +		then
> +			chmod 0 "$1" || exit 1
> +		fi

Can we lose SANITY by "rm $1" instead of "chmod 0"?

> +		exit "$status"
> +		EOF
> +		git config merge.unreadable.driver "./merge-driver %A %O %B" &&
> +		echo "file merge=unreadable" >.gitattributes &&
> +		test_commit base file base &&
> +		git checkout -b one &&
> +		test_commit --no-tag one file one &&
> +		git checkout -b two base &&
> +		test_commit --no-tag two file two &&
> +
> +		# Teach rerere a resolution while the driver works normally.
> +		test_must_fail git merge one &&
> +		echo resolved >file &&
> +		git rerere &&
> +		git merge --abort &&
> +
> +		# Recreate the conflict without replaying the resolution yet.
> +		test_must_fail git -c rerere.enabled=false merge one &&
> +
> +		# We will expect the same conflicted content after rerere fails
> +		# below.
> +		cp file expect &&
> +		git ls-files -u >expect-index &&
> +		test_file_not_empty expect-index &&
> +
> +		# Now we try rerere again, but the merge driver will cause the
> +		# read to fail.
> +		>fail-read &&
> +		git rerere 2>err &&
> +		test_grep "Could not open" err &&
> +
> +		# And we expect the conflicted state.
> +		test_cmp expect file &&
> +		git ls-files -u >actual-index &&
> +		test_cmp expect-index actual-index
> +	)
> +'
> +
>  test_done
