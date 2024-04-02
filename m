Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66E604DD
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055979; cv=none; b=PlNEQ0opXY7TY45923yII387qcivzedStfysERsV1mkycrQBO8fwxmuucbusSxvrJRbFzP3L+LVu4KWClqpftFf1mrt6oY7rxIPVbSzlPwRCrR7NF0HyLVl8rToaGDc9nLXn+KqH2H2+vvJXpo5KzGJE3UC8j3kH6FO1ZXBOGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055979; c=relaxed/simple;
	bh=p/BW6ES1VFyjVfHnfzHwYUzYgCCqluqrvkDT0x+Z9kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFRSzoil6B5w8CbxdH8wMof7wwPU8zjStE9sz9fAUXehekS6PBRlwLzZLfkKllVnGvavBl7w8W8kQQ0TQXr8q5xCIwidmS0/8ETHZvgaKxgK/XCO/uARMNFOrmf/01Wg6Lm9G7r1plAl0vuxaYA4YQpFH1i7iNv+0N9d6ohGaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GPFEM3cg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=anNMkVXJ; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GPFEM3cg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anNMkVXJ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3C15D18000C2;
	Tue,  2 Apr 2024 07:06:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 07:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712055974; x=1712142374; bh=rGXVMhM2Xp
	WULnYlY39uhI752NuaecezZWDSiFdkejw=; b=GPFEM3cgYcZzQ/2obkuXxMcjgF
	Pm4tdotNzna2CDP/zhovD8jD60Xt50/vuhaMxsZVPeVx25s8i6+xIl3pfdAsL+sy
	nXrA6+cbpjbYhSO7Pe0EF0a7GGV2qfsYYJbKEb1FxAiACa+FjM6MyQJHQh5q7mWB
	HCMaOOkv8fl8QS6K0Kzp+T85V78QAaQscCMnrlUubDdptnQST+9MQo5rO45/Dvbr
	r+UOmvfiInnYeUBjq4G0P+8ewgJqo07qXouE99cMnPDwSuzef9Qc5J+NIyRKHHL9
	hAGUW6LZ6J71spAzjeXPxgcaKLFFoBZ36fsyXwEYwyxkgBaNMZHQlfU88KVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712055974; x=1712142374; bh=rGXVMhM2XpWULnYlY39uhI752Nua
	ecezZWDSiFdkejw=; b=anNMkVXJVSUKKzpYb/OmzK4UWdkketMQEL3QOsyfgouQ
	59la9PRGGQxWJF55zt8X3eIgjL6sl/vwcwzkkM2eLv7v1E0fHxQWhsM0oMUXt5/q
	kuSGdENNQOz+B0jOY2DQ3nhRgzx8xSPW7XbhBRymNBPlrKYKB33uL2asX7c1jeoT
	45/WUiOJha6PjYwxesMw8HfzHihbC3aVYoHD3hISF3+2BbX8u2HPeSubNii9Rx2T
	tYplDIc/m5mlgR7p0UdzAoAD/1rskF1sCVS9ku6lnRZXfpu/UUDR4XTW5SpUt/ME
	Rx7Cf7E9CXhe2EJEI9BT6vqFzhlkDrGWz5risEjDdA==
X-ME-Sender: <xms:puYLZnPinaQXVQ9bxpGj3ZC9ziEnKuqGZ-t48I6xIE1LeeVMgCIBQA>
    <xme:puYLZh_ZprQ7Ju4WZ1uHJCg9Jtjkztl8a8206cbtKNXxeTXu8YgmDi3BFt899i0dP
    89EI44S3BBOR3hkeg>
X-ME-Received: <xmr:puYLZmSkENSVuto0goKc1C0xDZ4Rqk0f2uRkZmZ1dbiLAHOHEmhjH_W72ERInPKEfl034UwN4mrAbBxTW9UCSBeNprjbiJgmktklUYIsFYIeufk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:puYLZrtC28fnQui6s06dlCo72DIQCfJxSHJMtpoUPKJcR6OLOJLJ3Q>
    <xmx:puYLZvcv9wC8AwUcuCBVSUyYnLCTWi6_lF7wXRIIx3ilLieqOXo-yg>
    <xmx:puYLZn3y8WgaVBff63Q6WlbFb-cUiQaKFxNbI-TVN5qMCSU7ykQHxQ>
    <xmx:puYLZr8eunLdX5O9vXWROdnF58lAEXh5uYIFM_WLcOdQxBhdXe_OXw>
    <xmx:puYLZr5KhWEEu7xqNT8OfW2V16lMaT-9r79Dc06KKOUBfdVGx3__EVHF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 07:06:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f05d652f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 11:06:02 +0000 (UTC)
Date: Tue, 2 Apr 2024 13:06:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Aishwarya Narayanan <aishnana.03@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: GSoC 2024 [PATCH v2] Fix Git command exit code suppression in
 test script t2104-update-index-skip-worktree.sh
Message-ID: <ZgvmoSOPs6FG4jGZ@tanuki>
References: <CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A8vTga8epWTpt48S"
Content-Disposition: inline
In-Reply-To: <CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com>


--A8vTga8epWTpt48S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:17:25AM +0530, Aishwarya Narayanan wrote:

The subject of this mail is not in line with how we typically write
commit subjects. For one it is overly long, we typically don't want them
to be longer than 72 characters. Second, commit subjects are expected to
start with a scope.

> This commit addresses an issue in the `test_expect_success 'setup'` test
> where the exit code of `git ls-files -t` was being suppressed. This could
> lead to the test passing even if the Git command failed.
> The change ensures the output is captured and the exit code is checked
> correctly.
> Additionally, the commit message follows recommended coding guidelines
> by using `test` instead of `[]` for conditionals and proper indentation.

We typically don't say things like "This commit", but rather use an
imperative style ("Address this issue..."). Also, we typically start
with the problem description before we say how the problem is being
adddressed.

> Signed-off-by: Aishwarya Narayanan <aishnana.03@gmail.com>

Paragraphs should be separated by an empty line. Most importantly, the
trailer lines need to be split from the remainder of the body or
otherwise they won't even be recognized as such.

> ---
>=20
> Dear Git Maintainers,
>=20
> I'm writing to submit a patch that addresses an issue in the test
> script t2104-update-index-skip-worktree.sh. The issue involves the
> inadvertent suppression of exit codes from Git commands when used in
> pipelines. This could potentially lead to false positives in test
> results, masking actual bugs or regressions.
>=20
> This patch modifies instances of git ls-files -t and similar Git
> commands used in pipelines to ensure their exit codes are correctly
> evaluated. It achieves this by:
> Capturing the command output in a variable.
> Applying checks for the exit code immediately after command execution.
> Adjusting related test cases to work with the new method of capturing
> and evaluating Git command outputs.
>=20
> I've carefully reviewed the Documentation/SubmittingPatches document
> and ensured the patch adheres to the recommended guidelines. The patch
> file itself is attached to this email.
>=20
> Thank you for your time and consideration. I welcome any feedback or
> questions you may have.
>=20
>  t/t2104-update-index-skip-worktree.sh | 98 ++++++++++++++-------------
>  1 file changed, 52 insertions(+), 46 deletions(-)
>=20
> diff --git a/t/t2104-update-index-skip-worktree.sh
> b/t/t2104-update-index-skip-worktree.sh
> index 674d7de3d3..8fdf0e0d82 100755
> --- a/t/t2104-update-index-skip-worktree.sh
> +++ b/t/t2104-update-index-skip-worktree.sh
> @@ -2,67 +2,73 @@
>  #
>  # Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
>  #
> -test_description=3D'skip-worktree bit test'
>=20
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> -. ./test-lib.sh
> +test_description=3D'skip-worktree bit test'
>=20
> -sane_unset GIT_TEST_SPLIT_INDEX
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
>=20
> -test_set_index_version () {
> -    GIT_INDEX_VERSION=3D"$1"
> -    export GIT_INDEX_VERSION
> -}
> +sane_unset GIT_TEST_SPLIT_INDEX
>=20
> -test_set_index_version 3
> +test_set_index_version () {
> +  GIT_INDEX_VERSION=3D"$1"
> +  export GIT_INDEX_VERSION
> +}

Sorry, but this patch seems to be completely broken and rewrites almost
the whole file. It's basically impossible for a reviewer to figure out
what exactly has changed.

I assume two things happened:

  - Your patch may have changed line endings. Please make sure that your
    editor writes Unix-style line endings ("\n"), only.

  - You seem to have changed indentation from four spaces to two spaces.

It would be great to pay more attention to such details and review your
own patches before sending them out to the mailing list.

Patrick

> -cat >expect.full <<EOF
> -H 1
> -H 2
> -H sub/1
> -H sub/2
> -EOF
> +test_set_index_version 3
>=20
> -cat >expect.skip <<EOF
> -S 1
> -H 2
> -S sub/1
> -H sub/2
> -EOF
> +cat >expect.full <<EOF
> +H 1
> +H 2
> +H sub/1
> +H sub/2
> +EOF
> +cat >expect.skip <<EOF
> +S 1
> +H 2
> +S sub/1
> +H sub/2
> +EOF
>=20
> +# Good: capture output and check exit code
>  test_expect_success 'setup' '
> -   mkdir sub &&
> -   touch ./1 ./2 sub/1 sub/2 &&
> -   git add 1 2 sub/1 sub/2 &&
> -   output=3D$(git ls-files -t)
> -   echo "$output" | test_cmp expect.full -
> -   if [ $? -ne 0 ]; then
> -       exit 1
> -   fi
> +  mkdir sub &&
> +  touch ./1 ./2 sub/1 sub/2 &&
> +  git add 1 2 sub/1 sub/2 &&
> +  git ls-files -t >actual &&
> +  test_cmp expect.full actual
>  '
>=20
> +test_expect_success 'index is at version 2' '
> +  test "$(git update-index --show-index-version)" =3D 2
> +'
> +
> +# Good: pipe only after Git command
>  test_expect_success 'update-index --skip-worktree' '
> -   git update-index --skip-worktree 1 sub/1 &&
> -   output=3D$(git ls-files -t)
> -   echo "$output" | test_cmp expect.skip -
> -   if [ $? -ne 0 ]; then
> -       exit 1
> -   fi
> +  git update-index --skip-worktree 1 sub/1 &&
> +  git ls-files -t | test_cmp expect.skip -
> +'
> +
> +test_expect_success 'index is at version 3 after having some
> skip-worktree entries' '
> +  test "$(git update-index --show-index-version)" =3D 3
>  '
>=20
>  test_expect_success 'ls-files -t' '
> -   output=3D$(git ls-files -t)
> -   echo "$output" | test_cmp expect.skip -
> -   if [ $? -ne 0 ]; then
> -       exit 1
> -   fi
> +  git ls-files -t | test_cmp expect.skip -
>  '
>=20
> +# Good: separate command for exit code check
>  test_expect_success 'update-index --no-skip-worktree' '
> -   git update-index --no-skip-worktree 1 sub/1 &&
> -   output=3D$(git ls-files -t)
> -   echo "$output" | test_cmp expect.full -
> -   if [ $? -ne 0 ]; then
> -       exit 1
> -   fi
> +  git update-index --no-skip-worktree 1 sub/1
> +  if [ $? -ne 0 ]; then
> +    echo "Failed to update-index --no-skip-worktree"
> +    exit 1
> +  fi
> +  git ls-files -t | test_cmp expect.full -
>  '
> +
> +test_expect_success 'index version is back to 2 when there is no
> skip-worktree entry' '
> +  test "$(git update-index --show-index-version)" =3D 2
> +'
> +
> +test_done
> --=20
> Sincerely,
> Aishwarya Narayanan
>=20

--A8vTga8epWTpt48S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL5qAACgkQVbJhu7ck
PpR2RBAAi9hCi6a9C0uPns1slwjBGKmcLj+USeVadYEvLS7rBhDGrBNxZnggIgGz
klGMCDCni4PokcewOFwb2jJIL+04MQ001qXwSL6Q32t2tbOaZQh9eUm30xeSRjBB
K0wTkZGhTuPwSrRGZpd5MURtIsWxpV1joaBAamwSbu+VOCtJljiM1ebIgzX3jW7u
cFg2V8hkAXNV075YXpsenzt9vcHUhXEYdpzop2/I7cp3Ey+F1u41zZD4S5oxiwFC
VYkAtMbc/unMOS3Y5Vhu5eYbWoEAna+wISj9mzkka53viifW6vKYoNLW3CsMoKxN
FBWZeLD+QPTqHVye7JcW4RX/zTsLtYNAqw0hatWU77oN9abyIyxC9A8Bq+YMO09Q
GtZjZUyJ1H5UNPPx/FZ8J+9KVBG5cx42jMUhfz/arKDff5BFFmFzp65FHI6oA6+F
mNO1GXpclwwC6GtqH2zcNdaGJmnAZuzGMi7pED48mgmb/wBhEA9w/Aj5GZpF/mq1
DWFcbhT9W4JYW8tnbL+FNUmQUzfQARaJhMXXLRCMRvJitsXgL3pQHuxOI9BVqDBw
7t/L/BVP3smw+EVGjlpr+1otPBvXYQUbFIGpyu7Wt3uE7cpCMBrnkf3mwKitKijj
Lwn5mVCrgb2Wu1uUjbjsIVFTyzNAPCDUNt7qzHQf+z1qkFtf3Q4=
=+U9J
-----END PGP SIGNATURE-----

--A8vTga8epWTpt48S--
