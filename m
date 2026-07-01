Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A89412287
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943859; cv=none; b=CAnZg8693UPE1/+Ceh0OiQqt1uZMeBGHQiNLoLenf10xva/0AzpSO4gbWeX71cUbpuar8meSnF14kkDCR9/yZiosP9NtTmUl6W3Yu1wde2ze95oKTswWu7QrtQ68UaBSvHh9rQoCerVmomruhSZ94gs6FLfocWQyhkdp1avZe+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943859; c=relaxed/simple;
	bh=XsjziWednUHgp/G6CmYplFh/ZlAzfB1wyGKog6VyrP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u+JyOu+CvgeqHRI0euTdXXeNu+tEhQhc1P8HRi3HOOz1G2LsCbqDfNiWfhpDNTkeD6GHMQJWqbU2xr/1/7maut6liiu8mHis4MO2EvAgmz8i5BHtS2qemDKYQl/dTOIqjRJ6FUNPHn+QQZ3drNeliSw21H7q/EsdkjuXGgpbpMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J2ovNYtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aq8C++JH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2ovNYtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aq8C++JH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9BF421D000C5;
	Wed,  1 Jul 2026 18:10:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 18:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782943855; x=1783030255; bh=61MC3avNxu
	ppaoV05ffZ6In2AG6fwyrBZhgfpVb1AII=; b=J2ovNYtZiPttPiZipgoqAK5FPf
	Z2Qtep+e+VtjDx5PXgODSiJwKtGtX0uBPv4pJwKRkEYg3Kp1gNtqL0FH9xee4xat
	zkB3v+jTzgGpRvp4YoV65FsY3ZkrVDBr4wy1U0hGftSe97YCVCH9UsjORzFnG8bh
	0ii07j7xY5vJ0I1xbGQSCPii3LC4lu+vayyRbXa28t9wL6dxNvOHPJdacrwvDB5S
	dV7CuHRnTCGAvzMcEgIbKDIC5PIk29ySid02z7kxLv4YVyZv3PGnAMOQXcGVJijh
	Rl28y3MHTqK/PtsBBTYZgLLVu1CRguls2f6AkyQthgGk1QfIZLCmoboT0kQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782943855; x=1783030255; bh=61MC3avNxuppaoV05ffZ6In2AG6fwyrBZhg
	fpVb1AII=; b=aq8C++JHsGOgCGzu60BxziZnTSOltiDJ7RVFoar3f3lF/P2kX4S
	yyo36USeJuFxQWsrCJqEAudLp291p1QanO4kF/Ce2P6kUkz0PIEGnjSL4Bc0D1On
	XIFkN0QkMWA7NBiUpG2uMj+ApRehUUlaB6g4bpj0zEgkufbXQb3OAF2rj9jX95Ce
	bgl1ZrV5x9g0Nzjoq1QrF2xwhNx052Z3czE2KZcZ1qeDecUb3r6ZIvkWxMYiun1i
	t+8H+VV51VTBmS1ZD7Amk+j+rUNRopIRBdTXYmQubzrmRTDqzZ1H7fr6URfV7sIK
	cbemKqvubOQcr2xzysJqVtNVE3lCEHaAzFQ==
X-ME-Sender: <xms:b5BFauj0W65nSvccx96M8sm404r2nY0DenTPyynPc5vJwMYONN5tGw>
    <xme:b5BFamB3PjRHx_Mi9fnyJsFnV-t3BjY3UW1ZFhxmew6mrm_vYGRk6Is87khEZ8hGj
    qWIKSlSQqpNx8_kk9wkYnO9-4KBjBb1sLaorGCmIm3_OUNekGlfHg>
X-ME-Received: <xmr:b5BFarEhQxjWuy9FDmfXYvNs740FQayODZl3ssJSXFnyrcZHXOo-ES2sIIA4IK5tnNzmuhx6hraeVxeEBqWeEDn5poXyWr3_IPV4GXc>
X-ME-Proxy-Cause: dmFkZTEBL0G1TewY48UaCO1TbbodYFeGLBsTa+P6gf4ZUJhMK0mx9vSta0X1tePuO6qNGi
    yKW61pKsQVMGXEIO2cSMSvseR+7/40Cy8snbeCiv5YcqocOvss/oLepy5bFfOeqVc6bevv
    70b2cwd6h5HZKN8mQz7cYzg0JBz0H0qV/Ns44HFj4SLSoewl5EYAVKSTAIj0bSIaOTTvL/
    SlZAOVYSMxWBr8EEDTRp33M00YOOANzaWz15oWVdCAitLQi8NjASXs0wQ05AHKp+FVYgmu
    Luwp1sD2s0MUu5C5ENlbLOFGh8J5ZCKi38zZuk6DQfHzp+6ARlYU01TNUQbxraXAcDUHXX
    nSn62QTb7SNp79frIYyv2CDsp30xn3S2FoX9piQulMfGoTIuGjjEVYHGVgDDd/UTemqXRi
    ZGToAPt30fbIz6I6cbqANMz5ZzAcyXynuWId9wG/IUq/66kzWmxT58bQ9dhFC+Al5DoAHd
    HQ4sZFiF3edszuXXNx6FHmFXS6DlCaoHrYoqyq7GuAhx33dVPDUTbS9AARivSOqQ+/bKuC
    2dR/qhNSnzZlQu1w2Bfpcj/rwLVnlxOBpik0CR9KzD5w7qGh1BSxQRzRT2DX48m8KibcSS
    BgjxWqPzn3q9R1eIJI8qBIAC1533vZ6awhbNK6bVTBLo153nYHoENsNQ56jw
X-ME-Proxy: <xmx:b5BFamJsJguUwUN_BibsK93cuMQsmTZQqiW1oOkOnRpQAAl9sNxZKA>
    <xmx:b5BFanlnVdhhOTKy1pPbyH-Fc26c3-o_qydgBoLUNIk_7XhzLurFAw>
    <xmx:b5BFamQSdncmBk2frIOMZmhsT7XsUAOiNnegkHhK-OGfEujaI3R1hg>
    <xmx:b5BFahLA5iVSPxCgn7kQUmjt7FQGGH4AOwJpUzNAqd39Kl6VJaVYAA>
    <xmx:b5BFajkMWE7eSZwBw2SG1fVYNoVxekdh3ONlm_qiMNQaSAzikoyzyxiY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 18:10:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] t1517: skip svn tests if svn is not installed
In-Reply-To: <20260701212442.1430084-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 1 Jul 2026 21:24:39 +0000")
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-2-sandals@crustytoothpaste.net>
Date: Wed, 01 Jul 2026 15:10:53 -0700
Message-ID: <xmqq8q7umkcy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The svn tests currently assume that git-svn's option parsing will always
> fail the tests because it exits 0 on --help, not 129.  However, in a
> future commit, we'll expect it to exit 0 and the tests will then need to
> be updated to succeed in some cases and fail in others.
>
> We therefore need to have t1517 determine whether the Subversion Perl
> modules are present, since if they are not, git-svn will die on start
> and then it needs to continue to expect failure.  Add a stripped down
> version of the tests in t/lib-git-svn.sh as a prerequisite we can use
> here for our svn tests.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t1517-outside-repo.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index c557f2f55c..583784f21b 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -4,6 +4,14 @@ test_description='check random commands outside repo'
>  
>  . ./test-lib.sh
>  
> +test_lazy_prereq SVN '
> +	test_have_prereq PERL && test -n "$NO_SVN_TESTS" && perl -w -e "
> +		use SVN::Core;
> +		use SVN::Repos;
> +		\$SVN::Core::VERSION gt '1.1.0' or exit(42);
> +	"
> +'

This corresponds to 42 in t/lib-git-svn.sh?  We can use any non-zero
value here, but just being curious.

>  test_expect_success 'set up a non-repo directory and test file' '
>  	GIT_CEILING_DIRECTORIES=$(pwd) &&
>  	export GIT_CEILING_DIRECTORIES &&
> @@ -138,6 +146,8 @@ do
>  	case "$cmd" in
>  	instaweb)
>  		prereq=PERL ;;
> +	svn)
> +		prereq=SVN ;;
>  	*)
>  		prereq= ;;
>  	esac
