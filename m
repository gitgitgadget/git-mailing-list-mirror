Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46121E0DCC
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415425; cv=none; b=lwJbHAq+cmlJtixUU+tfqiN6iiGyfot7A/WTOCbewa4OGCSUoirtM+Fv6IdM/ujbAq3GAf/btb1pxVJ8Elne0XVLvRJAw62E0eFzj+UEC63+2y9imO1RpVQAu89PVUfFpPTcS4YuIxElvt1eJeeyQNfNNbfmGjwbIBp3dJ+ndcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415425; c=relaxed/simple;
	bh=V5Nw46ZTnAoT8EuIiP33cmL6UF+c7hQacuzOJLbvORo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rw7Vzw0Ed72Fu8PWn3mQEDWy3+iFGuhFXMkNyzRnp3w77+qHYVDbI20q5/JmwcfCdQM+ex18XcT57+QHANZI7nDnNxCmyxekQdb6HNUqDkhcQo3uIi+CokasSZIuLV56BcZo3EKRTDwjrnMFXvUslwquyMv2KWo4+C18AR67Yw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KeNtVI2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e312K0s+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KeNtVI2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e312K0s+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D2ECE1380667;
	Tue,  8 Oct 2024 15:23:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Oct 2024 15:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728415421; x=1728501821; bh=dSTvBFsZc6
	wfOPjeYjroQD9W7q5pT8Yn/lFkMhlYL1g=; b=KeNtVI2Tr556qnwIMeMGj5vguN
	Mq1CotyqdPL0WlHDunW7L+MWOaJpk6K+CrumAZus2Xg1ChptZSrCo8LCk6tdZyXD
	aX0zJNik9cLWLGdPVbgt0gR/xMe0L+xbPxfR+TpKrxWgKKG/Fn7eWJXjVsiOKYl3
	0xN6LbuBVeDAkgLD0BnSCupL5/yM8+/9U+rl4SgRmrss0j8Qgpu+0crj8rr06gMj
	QHTZUB0pzNLGZ0Sm/clh/gsw01w+8EokEPZYtVqKGG91CWmO1qqw2YXxJt5pWdL4
	U2OSa3uW2dZci7fJ6HqNDgzGMmJP94TnE0WcZCvsCPR58raMETi42q0Hswaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728415421; x=1728501821; bh=dSTvBFsZc6wfOPjeYjroQD9W7q5p
	T8Yn/lFkMhlYL1g=; b=e312K0s+Kf/ee/z+eMGi7+vy//c37sAyl1NoR4WHK2Ye
	BxPAfFjyJlpiHMCNfaLAKpjZbnKRCdXFoxMIRKKrxcNiELtWIdeAwzy1MCxcZQJJ
	9LZjFCZLTUb8IFhnGk/x4RTluJoXXO+BR7jxN4MrcBqstCx8OJWIj369gex0gi4B
	6PefbC7o6DwTcsvN4mm0MVWaD7KF1qwImByhYAMzKTk8TQWGdHLy4MKSODbf9zuB
	CTjk1mujCqck54wwweaQMqADj9RrotFZLhP8GSpw1OVN3eyKfZZOPYOjEWasVReO
	oVSmPCZJ47Be0Fo9Ga7yzHmtn00Wk7q/c/sivMF3Zg==
X-ME-Sender: <xms:vYYFZ6jkhahrhviHe9ZbzW3SLA6ex9MV9ojsenONVoH1-xdjvKr-PQ>
    <xme:vYYFZ7BnR886OOMM2OCwEfePlzLr3v8QEMLFIxFAWLUxleOF2EbkSmJsf7_iK7v5E
    Mh4AaAwJWO9ApdVzg>
X-ME-Received: <xmr:vYYFZyGeL5ZFvx0tT3wBHrcfD8L2PwT5PwmjSepb1kJg9_SBEIV4Ol4VmcL7apSuF4k2WUeCVMYQ0ij_t2Y3xxoLPpAb1Hru5zGN_NU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepuggrnhhivghlsehmrghrihgruggsrdhorhhgpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vYYFZzRmp2NQTCU44DQSuYj2UxHLyIAjmoNP-h30Og2q6y_aNxu5Mw>
    <xmx:vYYFZ3wATWDsLEHGiZiv2HlOigbzYOtTFMdkq2cuEclyS_A3NbnqxA>
    <xmx:vYYFZx45b6ouxkWelYUK6G0iUgYvXK1r8_qJAkLBBRu_t7PBKdNslg>
    <xmx:vYYFZ0zX8Zxg37UkSLEUUbv8RWi7dWQswpoOkytLcLGJ24-DR4_pLQ>
    <xmx:vYYFZ39kztXodAUrbvTAVg8qNOKvdAgJ5h3QkukHgbk4Ym9wwHB1hEi0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 15:23:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniel Black <daniel@mariadb.org>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v2] submodule: correct remote name with fetch
In-Reply-To: <20241008015835.41678-2-daniel@mariadb.org> (Daniel Black's
	message of "Tue, 8 Oct 2024 12:49:54 +1100")
References: <xmqq7carzpzi.fsf@gitster.g>
	<20241008015835.41678-1-daniel@mariadb.org>
	<20241008015835.41678-2-daniel@mariadb.org>
Date: Tue, 08 Oct 2024 12:23:40 -0700
Message-ID: <xmqqzfnez9dv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Black <daniel@mariadb.org> writes:

> The code fetches the submodules remote based on the superproject remote name
> instead of the submodule remote name[1].
>
> Instead of grabbing the default remote of the superproject repository, ask
> the default remote of the submodule we are going to run 'git fetch' in.
>
> 1. https://lore.kernel.org/git/ZJR5SPDj4Wt_gmRO@pweza/
>
> Signed-off-by: Daniel Black <daniel@mariadb.org>
> ---
>  builtin/submodule--helper.c |  9 ++++-

The proposed log message is very well written.

>  t/t5568-fetch-submodule.sh  | 65 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5568-fetch-submodule.sh

Hmph,

	$ git grep "submodule update" t/

gives quite a many hits in existing tests.  Didn't any of them have
sufficient preparation steps that testing of this bugfix can reuse?

A test on "submodule update" behaviour tends to need quite a lot of
preparation.  Preparing the superproject, addition of a submodule to
it, cloning of these two projects, and then half-preparing a clone
of these super-sub arrangement.  All of that needs to happen before
we can say "submodule update" and observe the outcome to see if the
bug still exists.  If we can piggy-back on a test script that already
has such preparation, it would be far more preferrable than having to
do another set of preparation.

Another thing.  If this is not about a bug that only manifests when
the HTTP transport is in use, it is strongly preferred to avoid
turning it into an httpd test.  Some developers and/or environments
skip them.


> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a1ada86952..567d21d330 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2322,7 +2322,14 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
>  		strvec_pushf(&cp.args, "--depth=%d", depth);
>  	if (oid) {
>  		char *hex = oid_to_hex(oid);
> -		char *remote = get_default_remote();
> +		char *remote;
> +		int code;
> +
> +		code = get_default_remote_submodule(module_path, &remote);
> +		if (code) {
> +			child_process_clear(&cp);
> +			return code;
> +		}

The get_default_remote_submodule() helper eventually calls into
repo_get_default_remote() that returns an allocated string in
remote, but it only does so when it succeeds, so this early return
does not have to worry about leaking "remote" here.  Good.

The code change looks quite straight-forward and looking good.

>  		strvec_pushl(&cp.args, remote, hex, NULL);
>  		free(remote);

Thanks.
