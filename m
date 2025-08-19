Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD726463A
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628330; cv=none; b=dXtwziKD7iQ+isAD5CaqvMH2j3GH2aG5cqK62k+9X/Zrj3QFTG0hDtXcW+hEOlWXwQL4YXcbmRJWeUQ2x7s/9FCnzv+0t7LCiw2s12y1LaTez4jiUjnkIPlhlj/ohOfI9GfOFYj9K04SgajnXB/3Ro3AeqoWzHzyecSXd2kbel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628330; c=relaxed/simple;
	bh=MW1ObgUqCfmY9VBc46ATVDOyslf6xxrdqQHld6e4rPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4OePfMf/EZNMQ6Hwfsjqozr+gx0Z5lQDmwwu9rjOoepd6251cPeNmPBkWn2c9RJnfxbervLxF07JMoOn5xN3XYyMryDjLeOiTmPBcYvtWf/EV2Czzczo3YkanJNeUZiTp5tzCGDbwWhRGXJs4wV/MTgOIk25oXwJulLVnfWyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=nLlBGgPi; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="nLlBGgPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755628325; x=1756233125; i=l.s.r@web.de;
	bh=Lf1eLG5C2l5OBQPG2dBHKDTqDnmCfftiATy0XJ7xhwM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nLlBGgPiRcVVrOP8qqLR/ufTpNi9xwOYevB+5FRsI92jxGds9bx3wyDORbc7fU/6
	 GhmbsUcCBDndsnexWVvD2KBT83gmNKKgfZDJywMVFZPIaru1WErHzUcS0CIfhoTmv
	 idWtpQgc6DkxVFCNzOzmuPTqWktHYkN52rOYgSfsVudEAMmW2A7GGQa5tPDxoFU6B
	 UT/RhlTTxuJoluvmU98djL1nzFVITBVUp7wEUwNi95gK77iozRKcmJc8e5ixVIch4
	 ONdAJAfGMIux7WRWZzeioM4MMd9KkU78HfPXqPGMvcI8SUiZ+zC4SnlN3u87Rcu1c
	 0NYigD/4EINHVLlwEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qr9-1uaEAC1FRN-00xBGg; Tue, 19
 Aug 2025 20:32:05 +0200
Message-ID: <efa90ac9-8190-4af5-9e63-ffbd04c3c9c1@web.de>
Date: Tue, 19 Aug 2025 20:32:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] describe: error if blob not found
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
 git@vger.kernel.org
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210125.GB1024556@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250818210125.GB1024556@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M6Ze1ehZ3D6/Q69V247+Gx9cRcaffJu84LmP7Mxg+mBC2BPV5nv
 SkHEPpk6BQfQT9SHeMuvLA9N4AZdUMdxK5xMxaEB+m+0/lRRTEZa1hfOd27iDIr2nfB+JMN
 NzLcyK0Jk9LamWG/nx+fSk/H2VVRQg1pY1aiaksouix8npi01pDQRC/wURKbZzGjtqQMOlV
 hq+Rnlvw09shaLiTfwEyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bd85aiRl5SQ=;5OydwJrx4Eq4fTPtE5AtqznVJOW
 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

On 8/18/25 11:01 PM, Jeff King wrote:
> If describe_blob() does not find the blob in question, it returns an
> empty strbuf, and we print an empty line. This differs from
> describe_commit(), which always either returns an answer or calls die()
> itself. As the blob function was bolted onto the command afterwards, I
> think its behavior is not intentional, and it is just a bug that it does
> not report an error.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This one is perhaps the most controversial, as it is a change in
> behavior. But the current behavior just really seems like a bug to me.
>=20
> Unlike what Ren=C3=A9 posted earlier, I didn't record the dst strbuf's
> original size and compare against that. This is a static function with
> only one caller that passes in an empty strbuf, so being overly
> defensive didn't seem worth it

Makes sense.

> (arguably these functions should just
> return an allocated buffer anyway).

Or even print results directly.

>  builtin/describe.c  | 3 +++
>  t/t6120-describe.sh | 6 ++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 383d3e6b9a..06e413d937 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -535,6 +535,9 @@ static void describe_blob(const struct object_id *oi=
d, struct strbuf *dst)
>  	reset_revision_walk();
>  	release_revisions(&revs);
>  	strvec_clear(&args);
> +
> +	if (!dst->len)
> +		die(_("blob '%s' not reachable from HEAD"), oid_to_hex(oid));

I like the clarity and precision of this message.=20

The rest of the patches look good to me as well.  The first is a nice
little bonus.

Ren=C3=A9

>  }
> =20
>  static void describe(const char *arg, int last_one)
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 256ccaefb7..470631d17d 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -409,6 +409,12 @@ test_expect_success 'describe tag object' '
>  	test_grep "fatal: test-blob-1 is neither a commit nor blob" actual
>  '
> =20
> +test_expect_success 'describe an unreachable blob' '
> +	blob=3D$(echo not-found-anywhere | git hash-object -w --stdin) &&
> +	test_must_fail git describe $blob 2>actual &&
> +	test_grep "blob .$blob. not reachable from HEAD" actual
> +'
> +
>  test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
>  	i=3D1 &&
>  	while test $i -lt 8000

