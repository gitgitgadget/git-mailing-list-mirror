Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB43783C7
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789917848; cv=none; b=Gh6qYm/h/WcRUkGGMunr3mIQdnbp/Cnjik/LXwleoZoLGk8F03mJywXEUvE5teHquEXUGN4/mGDwdQSGFDvMixNu/A6D+baQkF7sHdXFGPzvTkx3YGa82uN6w8qRwSumns86YOFZHu8gf3pVhMyLLNLZIlx0pj5hnXaeEC5dVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789917848; c=relaxed/simple;
	bh=Y8s0MIDE7IElF3qnPDYKw42YTukj+9bnMpkIPev5aew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxhSjVFcsy2ULl18NCZG/QKkItzQLyOeik93zo8H7F3KQKRweniC/N/s6E2oaIOq3XBVTIyZpjs0PLJKE2fO6Kr5DtA9g4Hcyw0+Ep/D6XLjgnDJ27x56KR1B5xUzKEKadFmSRKf/r70GPsTo/aPm+E++fQDvebrV3jsh0TVpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=sIJiw/zS; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="sIJiw/zS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789917826; x=1790522626; i=l.s.r@web.de;
	bh=Gq6Tc2iQtOi8LcpdReaPnUUntJjc3J6T9X/pJk8LtRg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sIJiw/zSZb+4gixwDqcSvfoSvadBiPxB/wZI6OvB1aNGyqnEnL2iU0UsN1fNj4Ej
	 At/KXeRJ/qqXx6RiU4FtNelmwIOpB4SrCPl6aAns0uRNSC03u5wEyjoY8laXk6cCd
	 8AzkOVN/kWuFsiMJd75NC0hD5/6xVqXdsNxM3RPpAjnHgta8d3r/ZytVaLexVLmoY
	 68LXm3jNF6x8lvDTH1h9Tp3Q+IdffbtDpKxd5WVMyRApyoFQ7E8Zy0pVEr18Imq9V
	 waJ54WmdjxBkqiKkfgc8Im8jYX2g3p+ONHGCg8gD9E1eprtlH0uKc5JLUvrNGzElh
	 5qBCsSFcC2vj+klJzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav2l-1wVwRF2Gkt-00jptc; Sun, 20
 Sep 2026 17:23:46 +0200
Message-ID: <9b97c14b-1d25-409b-a72c-d8caf298bf87@web.de>
Date: Sun, 20 Sep 2026 17:23:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff --no-index: fix -R with file/directory conflicts
To: Haokai Ding via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>, Haokai Ding <hk_ding@outlook.com>
References: <pull.2232.git.1789715946888.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.2232.git.1789715946888.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S1f4KZNjTrkSFEhOlF4c1t6V33Ojz9oKjx9KrPbtSG5QZoVcMAL
 37hdg6w3wTGSJIhCkZeVvT8JCp33InBBjjRQbw3AEw62AW+XFugwXJNSgLCRBkn+eVfqdde
 YPArDOqvblh+wyh4VZ/ll26hEMB5k09bpBuOt+ZTU4NhaBAGGLDlUzLMs905vRTBfkoJ0Jq
 6q8r4CRJMPi9vBO/Gb3Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E6leSROO6Cc=;ljUfeqD50NcoN8yN9rWHWE91wXb
 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

On 9/18/26 9:19 AM, Haokai Ding via GitGitGadget wrote:
> From: Haokai Ding <hk_ding@outlook.com>
>=20
> When a path is a file on one side and a directory on the other,
> queue_diff() queues the file separately before recursing into the
> directory. This early queue entry bypasses the reverse_diff handling
> used for ordinary files.
>=20
> As a result, comparing directories d and e where d/sub is a file and
> e/sub/file is another file reports both paths as deleted with -R.
> Reversing the operands reports both paths as added instead.
>=20
> Swap the filespecs of the early queue entry when reverse_diff is set,
> so that -R reverses the file change as well as the directory contents.
> Add regression tests for both directions.
>=20
> Signed-off-by: Haokai Ding <hk_ding@outlook.com>
> ---
>     diff --no-index: fix -R with file/directory conflicts
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2232%2=
FHaokaiDing%2Ffix%2Fno-index-reverse-file-directory-mail-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2232/Haok=
aiDing/fix/no-index-reverse-file-directory-mail-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2232
>=20
>  diff-no-index.c          |  2 ++
>  t/t4053-diff-no-index.sh | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/diff-no-index.c b/diff-no-index.c
> index f320424f05..a9151cc27a 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -188,6 +188,8 @@ static int queue_diff(struct diff_options *o, const =
struct git_hash_algo *algop,
>  			mode1 =3D 0;
>  		}
>  		/* emit that file */
> +		if (o->flags.reverse_diff)
> +			SWAP(d1, d2);

Good find!

>  		diff_queue(&diff_queued_diff, d1, d2);
> =20
>  		/* and then let the entire directory be created or deleted */
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 8e0394cf5a..c3c703f4f4 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -120,6 +120,24 @@ test_expect_success 'turning a file into a director=
y' '
>  	)
>  '
> =20
> +test_expect_success 'reverse diff when turning a file into a directory'=
 '
> +	(
> +		cd non/git &&
> +		printf "A\td/sub\nD\te/sub/file\n" >expect &&
> +		test_expect_code 1 git diff --no-index -R --name-status d e >actual &=
&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'reverse diff when turning a directory into a file'=
 '
> +	(
> +		cd non/git &&
> +		printf "D\td/sub\nA\te/sub/file\n" >expect &&
> +		test_expect_code 1 git diff --no-index -R --name-status e d >actual &=
&
> +		test_cmp expect actual
> +	)

Looks good.  I like the explicit exit code expectation.

> +'
> +
>  test_expect_success 'diff from repo subdir shows real paths (explicit)'=
 '
>  	echo "diff --git a/../../non/git/a b/../../non/git/b" >expect &&
>  	test_expect_code 1 \
>=20
> base-commit: d38352cd43ab9745686d697872408bc3249a153f

