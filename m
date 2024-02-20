Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373A60DF0
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423722; cv=none; b=I4AyaY/mlWADZFBRLYP0ITYccEcxeelgtjhhcY3j8kHMpmFJTKGTg/i4fHxFSFEWO8cY5yZE/HgjKzBO2sF3Rq2GPl6capoQ4iomSodJY1KYTkoShycdA3l4knrXB/Xx8Eq43sDa5O+Qils9k3aGxcQ+/LioLGpagP0kMPaUkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423722; c=relaxed/simple;
	bh=WO37CfR/Wm7+srFGi5JS4C6U7S4RbnM7BUWVRiOSDE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAaUc6h6VIsYn9eQNeS2lBBYTEyvpkrRHFwMDqw+E69VwY03vYDmsRvNdCrKUpwqej8DIUHUXmBIYloBayoHmsDCDeiGjV4xYcHinlAJS+mXh/VLC7JNQpA6JQyL7vzj/Lb5ZLQHUaVzrFKyrGNtI7j3nj8AFgrUi3qsaxEEdH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EibDqKKR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RB8lrfkg; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EibDqKKR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RB8lrfkg"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id E3E751800072;
	Tue, 20 Feb 2024 05:08:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 05:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708423710; x=1708510110; bh=A7Ma7gTFr/
	+EVxcMcbY/s/XDDMpf6Q5HasdGABw1vBM=; b=EibDqKKRzAyyP66Rlh1fdwozYW
	CdmT8Q+XE1XscWobV571ljbbyHKQ5pLO+ofRsc3hzZlhLaSfkeFszoNPmnrHBJH5
	VfOhya9KNB1yEqhGOGGxZtKKPuUGiw0xCyYUsrhVYdYeXss3MHN1LPHOv1qLgihq
	8CD0q9j7fSwtil+drF8nkQSYqJx0TaMNLOIoaMad0IFdT9TumCMYHAvkDXW1a0MM
	skKAr/NG3c9LADDMHnZ+wgYi+3mgaHHG4TrlsL3t/yD8EhmXDb8PM54TV0FoRQo0
	DzodTSBnTlxQ32YbGkcm+BNbxLwC+dkSXDJ0i+F/h0tdAw5ZGdU1lZ9PnKUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708423710; x=1708510110; bh=A7Ma7gTFr/+EVxcMcbY/s/XDDMpf
	6Q5HasdGABw1vBM=; b=RB8lrfkggXXWyY4xeG3FWDJ3xPRXs2bcGK8yJZR8x8nV
	mXuz9PoLC+/Fp/8gNX37Kd90de+A0mM7fo9Ku50JwcS6T9oa0rzPoa1/xvlHLoTv
	wkwQlK+9/gKftWPW4xP58LUN7XsZGas9mOrYxEgKDC14JNlbaQCQqZfvdF7IxVx/
	lRUclGByKaLpBe0IHuyIY8zwIJ3OcLQ677/vNR6QSrHh/mFGst0DDUNxNVUgkpfU
	ju05cM1PnuiPxE/Q/KQAs/KheAsmFq9+FVHoubnYjjzdVKeNqBCxg6r5Hn/MafFZ
	e+hQ8RLyrVlCv2DhH9uhUYC9eRKdX3v/fqlIpI8MzQ==
X-ME-Sender: <xms:HnrUZUKtRNfVxc6_SPOWFJjq_6Vu3AChqSN8W03nA2cIoZmPtoTp1Q>
    <xme:HnrUZUIttZgFbaSm_CD52T_LUv-7njlIenHiJ-dMapFkIY1armz8NWYJtPZj5Po_O
    A_LZJwTm3TIw488Kg>
X-ME-Received: <xmr:HnrUZUvpBbhbtKItkMesP6EC9qRzY6bjzPgMRiauKFrN3PZ1GaPal4f-cMlP2FJhLA2kuGbu3G_i4ai1n92Q7503L6stKQfkE5EfRzA34BfjTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefvdelfeeuteegiedtkeehleffkeekgfffudfhuddvfefftdehkeeihfekjeekheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:HnrUZRYjJQp3LzVRmvyPSscGwUJI5CJoLt5vNGt7K6iXv2NCM8PqNA>
    <xmx:HnrUZbZ44VcIxirK648eyLscX_M0__sBmuUGTTUtjXxHnd20_7zhIA>
    <xmx:HnrUZdCFIpqmaDmhsbilpLsrryJ7eAUt1odqBBJ3Mm_t0PJ7NAoP5Q>
    <xmx:HnrUZXHVR7xeBsh3ow9a1rxcj12rSCUlyVeVcdKweXM5ze-RCLXdiFN-9S0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 05:08:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 153ebe6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 10:04:25 +0000 (UTC)
Date: Tue, 20 Feb 2024 11:08:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?iso-8859-1?Q?Jean-R=E9my?= Falleri <jr.falleri@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] git-difftool--helper: honor `--trust-exit-code` with
 `--dir-diff`
Message-ID: <0fac668f8fc021af9f9c4df5134da59816307ccc.1708423309.git.ps@pks.im>
References: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nS0+2t/lbjQAi7uO"
Content-Disposition: inline
In-Reply-To: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>


--nS0+2t/lbjQAi7uO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--trust-exit-code` option for git-diff-tool(1) was introduced via
2b52123fcf (difftool: add support for --trust-exit-code, 2014-10-26).
When set, it makes us return the exit code of the invoked diff tool when
diffing multiple files. This patch didn't change the code path where
`--dir-diff` was passed because we already returned the exit code of the
diff tool unconditionally in that case.

This was changed a month later via c41d3fedd8 (difftool--helper: add
explicit exit statement, 2014-11-20), where an explicit `exit 0` was
added to the end of git-difftool--helper.sh. While the stated intent of
that commit was merely a cleanup, it had the consequence that we now
to ignore the exit code of the diff tool when `--dir-diff` was set. This
change in behaviour is thus very likely an unintended side effect of
this patch.

Now there are two ways to fix this:

  - We can either restore the original behaviour, which unconditionally
    returned the exit code of the diffing tool when `--dir-diff` is
    passed.

  - Or we can make the `--dir-diff` case respect the `--trust-exit-code`
    flag.

The fact that we have been ignoring exit codes for 7 years by now makes
me rather lean towards the latter option. Furthermore, respecting the
flag in one case but not the other would needlessly make the user
interface more complex.

Fix the bug so that we also honor `--trust-exit-code` for dir diffs and
adjust the documentation accordingly.

Reported-by: Jean-R=E9my Falleri <jr.falleri@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Range-diff against v1:
1:  fd6cf7a85a ! 1:  0fac668f8f git-difftool--helper: honor `--trust-exit-c=
ode` with `--dir-diff`
    @@ git-difftool--helper.sh: then
     +		exit $status
     +	fi
     +
    -+	if test "$status" !=3D 0 &&
    -+		test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" =3D true
    ++	if test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" =3D true
     +	then
     +		exit $status
     +	fi

 Documentation/git-difftool.txt |  1 -
 git-difftool--helper.sh        | 13 +++++
 t/t7800-difftool.sh            | 99 ++++++++++++++++++----------------
 3 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index c05f97aca9..a616f8b2e6 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -105,7 +105,6 @@ instead.  `--no-symlinks` is the default on Windows.
 	`merge.tool` until a tool is found.
=20
 --[no-]trust-exit-code::
-	'git-difftool' invokes a diff tool individually on each file.
 	Errors reported by the diff tool are ignored by default.
 	Use `--trust-exit-code` to make 'git-difftool' exit when an
 	invoked diff tool returns a non-zero exit code.
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index e4e820e680..dd0c9a5b7f 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -91,6 +91,19 @@ then
 	# ignore the error from the above --- run_merge_tool
 	# will diagnose unusable tool by itself
 	run_merge_tool "$merge_tool" false
+
+	status=3D$?
+	if test $status -ge 126
+	then
+		# Command not found (127), not executable (126) or
+		# exited via a signal (>=3D 128).
+		exit $status
+	fi
+
+	if test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" =3D true
+	then
+		exit $status
+	fi
 else
 	# Launch the merge tool on each path provided by 'git diff'
 	while test $# -gt 6
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 6a36be1e63..96ae5d5880 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -91,58 +91,67 @@ test_expect_success 'difftool forwards arguments to dif=
f' '
 	rm for-diff
 '
=20
-test_expect_success 'difftool ignores exit code' '
-	test_config difftool.error.cmd false &&
-	git difftool -y -t error branch
-'
+for opt in '' '--dir-diff'
+do
+	test_expect_success "difftool ${opt} ignores exit code" "
+		test_config difftool.error.cmd false &&
+		git difftool ${opt} -y -t error branch
+	"
=20
-test_expect_success 'difftool forwards exit code with --trust-exit-code' '
-	test_config difftool.error.cmd false &&
-	test_must_fail git difftool -y --trust-exit-code -t error branch
-'
+	test_expect_success "difftool ${opt} forwards exit code with --trust-exit=
-code" "
+		test_config difftool.error.cmd false &&
+		test_must_fail git difftool ${opt} -y --trust-exit-code -t error branch
+	"
=20
-test_expect_success 'difftool forwards exit code with --trust-exit-code fo=
r built-ins' '
-	test_config difftool.vimdiff.path false &&
-	test_must_fail git difftool -y --trust-exit-code -t vimdiff branch
-'
+	test_expect_success "difftool ${opt} forwards exit code with --trust-exit=
-code for built-ins" "
+		test_config difftool.vimdiff.path false &&
+		test_must_fail git difftool ${opt} -y --trust-exit-code -t vimdiff branch
+	"
=20
-test_expect_success 'difftool honors difftool.trustExitCode =3D true' '
-	test_config difftool.error.cmd false &&
-	test_config difftool.trustExitCode true &&
-	test_must_fail git difftool -y -t error branch
-'
+	test_expect_success "difftool ${opt} honors difftool.trustExitCode =3D tr=
ue" "
+		test_config difftool.error.cmd false &&
+		test_config difftool.trustExitCode true &&
+		test_must_fail git difftool ${opt} -y -t error branch
+	"
=20
-test_expect_success 'difftool honors difftool.trustExitCode =3D false' '
-	test_config difftool.error.cmd false &&
-	test_config difftool.trustExitCode false &&
-	git difftool -y -t error branch
-'
+	test_expect_success "difftool ${opt} honors difftool.trustExitCode =3D fa=
lse" "
+		test_config difftool.error.cmd false &&
+		test_config difftool.trustExitCode false &&
+		git difftool ${opt} -y -t error branch
+	"
=20
-test_expect_success 'difftool ignores exit code with --no-trust-exit-code'=
 '
-	test_config difftool.error.cmd false &&
-	test_config difftool.trustExitCode true &&
-	git difftool -y --no-trust-exit-code -t error branch
-'
+	test_expect_success "difftool ${opt} ignores exit code with --no-trust-ex=
it-code" "
+		test_config difftool.error.cmd false &&
+		test_config difftool.trustExitCode true &&
+		git difftool ${opt} -y --no-trust-exit-code -t error branch
+	"
=20
-test_expect_success 'difftool stops on error with --trust-exit-code' '
-	test_when_finished "rm -f for-diff .git/fail-right-file" &&
-	test_when_finished "git reset -- for-diff" &&
-	write_script .git/fail-right-file <<-\EOF &&
-	echo failed
-	exit 1
-	EOF
-	>for-diff &&
-	git add for-diff &&
-	test_must_fail git difftool -y --trust-exit-code \
-		--extcmd .git/fail-right-file branch >actual &&
-	test_line_count =3D 1 actual
-'
+	test_expect_success "difftool ${opt} stops on error with --trust-exit-cod=
e" "
+		test_when_finished 'rm -f for-diff .git/fail-right-file' &&
+		test_when_finished 'git reset -- for-diff' &&
+		write_script .git/fail-right-file <<-\EOF &&
+		echo failed
+		exit 1
+		EOF
+		>for-diff &&
+		git add for-diff &&
+		test_must_fail git difftool ${opt} -y --trust-exit-code \
+			--extcmd .git/fail-right-file branch >actual &&
+		test_line_count =3D 1 actual
+	"
=20
-test_expect_success 'difftool honors exit status if command not found' '
-	test_config difftool.nonexistent.cmd i-dont-exist &&
-	test_config difftool.trustExitCode false &&
-	test_must_fail git difftool -y -t nonexistent branch
-'
+	test_expect_success "difftool ${opt} honors exit status if command not fo=
und" "
+		test_config difftool.nonexistent.cmd i-dont-exist &&
+		test_config difftool.trustExitCode false &&
+		if test "${opt}" =3D '--dir-diff'
+		then
+			expected_code=3D127
+		else
+			expected_code=3D128
+		fi &&
+		test_expect_code \${expected_code} git difftool ${opt} -y -t nonexistent=
 branch
+	"
+done
=20
 test_expect_success 'difftool honors --gui' '
 	difftool_test_setup &&
--=20
2.44.0-rc1


--nS0+2t/lbjQAi7uO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUehgACgkQVbJhu7ck
PpTL/A/9HhZyKKLAF+WAMWikamcA6Afk5Mj8li32CwRmLLaVdMTugx4NTyAIvOJU
69wFVL+wVjn+gI6cdpoHRXCDmmYFIX2336Q/0TabNuCaHI+h+8HH6mr+xHfMru6i
uiQlV+q7aFXbfE55Z5jm/3C8MfWU3G5gdKr5i7TVXEwIDXWyj2iU2dbk8lRMaGvZ
rvPQLDMT3sKIHlKPfE5XBAAA4juoNWB6DqK8Y0NBpGlhRjFIG07NKqUgi9SbCqED
90aNXHV0BRh2ApGv10lwRmSwoCP/xnUyYvGySOvJXQ4oxcorsFIK/ol42ZyT/Ha4
oltZxlYYjnLqqoww2BGy+mEyr3IGeFrnekrACmxzYEHk+Nd0xyQuZF03VxPBA0pb
+cRl5oCbq/zmf3SptiolqdJ7u0PYEo8n7nbtBMpRmtByeE0EDUi6kC6Ab/JHDnmv
uWkspFscTVTRJof4rpbHr2PzoqcfQ292VF8BOP7IYquOXcoNc03C2r6Q4GaLRsaC
IN2QX1ij4cbO7X8/3IQt2AuC2Sxr/2sAmHlvOVLvU8QDqNx6yucUQQda5rUZ82jX
2RlUrjWRYevcnj1kKY962VHCRtJqe9szIByfhV5JpV3XHKDTzj7OA0gVx9xoEnF5
dEptiVbx1DOcJ1MpKXU6hAxP6Qm0zt+Vg2PkcTHuJ9vpf89LEJc=
=wLWn
-----END PGP SIGNATURE-----

--nS0+2t/lbjQAi7uO--
