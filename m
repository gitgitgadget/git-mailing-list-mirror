Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3B28F5
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041831; cv=none; b=ISYYXnL7bV+Vc6+3ey3Z/JTfTBvQ0f+VHoJKFZNX5PkroAlKxqUTN/t2SUnsMZ1xUnofekPBxMO65J7PYc66DMjpxG1R2l7h1hlmaolm3seghgArUPfIc+zOHzjFtOLwztdVQhcJnxh7xXsmEH0YuRAf9UWvzq7uUPLLrUOlbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041831; c=relaxed/simple;
	bh=n9C0BIMkm4dLZyLhtq53CdKSi9yGkPj7DKYuw/f0fMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HkYnTbv8QwAol+109OW2olhrerR6LG7wFQnkYjhIBuELXAWso4UTV9lItBzWnU1Rn6+dseuySHM0p2kZ1ah8pXLaggPsGo6S/VYQniLbp+ffkcodFoapmn7L1MFXxDkXiBxhXDkHDKWE/521mdOgVXZ2TPHgfg+fx88ARj7gZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hK2JbcNv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJpec/FG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hK2JbcNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJpec/FG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 57B73EC011F;
	Thu,  9 Oct 2025 16:30:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 09 Oct 2025 16:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760041828; x=1760128228; bh=2nxVqwcKd6
	Z2PST+soEXdDGPLNPAO/0mlzJSsDJ95To=; b=hK2JbcNvtJw+vu9sPsa43Wa25C
	c2tARX+Ns4iOPyt8XbGvH1QCV2muzQWIBCPcf63px5vqOTBAiQM5HBBX0FK90+3/
	t8y8Ab+/qFDlLoDWW8s274Kx7KnoUHFaNc//4R53IXGMWDGJ85KbCcreD7IaKp+7
	qmeXMFJq1vZSs1+Z2FBdrxmyK0FVgQwefcvi2SZsV6qKEH9kaSVvTS+80eCsvnE/
	5pvdHA9A70SbP08pOccLikwOq40yoEH5m606rbxaCeU6bHXi5olcNcD4/hbxA1VQ
	ps+akrhHm4bWisifaFjhPi3cTbH03mWYPpuQzog6Y4u1Z+VPLlf5xlaWatBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760041828; x=1760128228; bh=2nxVqwcKd6Z2PST+soEXdDGPLNPAO/0mlzJ
	SsDJ95To=; b=VJpec/FGq8M9qT9ynIjXFMTTL8406dRkc0YzkVv89PsujER4k+7
	PRB4/l3zeh1eubrCce88J3RRiUK5IHEe8JPxLl89ocJC3QObtPIPoSy5JGTzaa71
	W6/kf7+CfPg4oDZTKpfnmdLUwaoC4bIF0WncWNBtbLEiGuYJK/OepKFIaAWwHSVE
	WFj0rjPHSu4ZkAqzV6bCOhAEBpHesLjigy7UR/4yqrmQxoHFGOuK16kUFUnP8rv1
	3cmarnAIc50vgmGUx8hdDj12dbKdcF3k9CblE7ueQxkLztjIE+RCtyj+nkTbSk+M
	AdigSt4tUNsooW1u0Aqc8TJPXS2SVGy9I4A==
X-ME-Sender: <xms:ZBvoaPZjJhX0cmTX4ebMPgrb3Nm3F5_nrEpPJX4sz6-lUFZQXWLBJQ>
    <xme:ZBvoaFZUHl1G3eev5YtER2MCITRgosKAhogji-xdZdhg0qChNqx7nUPmLhjw0Ky5V
    xXR_Q2R36txWnfMnzyvK8lHizbMlzD2EbtePwKK8zy__eVvLe3BgFQ>
X-ME-Received: <xmr:ZBvoaG864aZnaKbKtAvP_LpoOWSV6jrTpMMqGDFVor0WvyyIxQg76dBiXgoOh_AvzTreDqeJj0UFTBRhp-JjAyIGKImP5JfkSOFU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnug
    gvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:ZBvoaEip2WFM4onFw-it-2CQ9XhKm_9-EfnwtNESOzXEaGZ3XqlNrg>
    <xmx:ZBvoaGf5ZGOHPVuXQkb3pkwzt6HjIQ89_1WefzLg4PHxe2gP709vLQ>
    <xmx:ZBvoaLoIm5XprNLkg5LPzDXeni4bQSZV8UxuUIzJOmkjE6bEPB3Wnw>
    <xmx:ZBvoaLDmPNxl3GO4yBqgoUVF6Var3U-QC83jhhNfUWDzKZLbxbACfg>
    <xmx:ZBvoaMXjnKPJ89p5KxvGlQBY3vFyG80ehz3C8isie1sFDIoIOSu48ii->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 16:30:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] refs: forbid clang to complain about unreachable code
In-Reply-To: <pull.1984.git.1759995982220.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 09 Oct 2025 07:46:22
	+0000")
References: <pull.1984.git.1759995982220.gitgitgadget@gmail.com>
Date: Thu, 09 Oct 2025 13:30:21 -0700
Message-ID: <xmqqzf9zddia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When `NO_SYMLINK_HEAD` is defined, `create_ref_symlink()` is hard-coded
> as `(-1)`, and as a consequence the condition `!create_ref_symlink()`
> always evaluates to false, rendering any code guarded by that condition
> unreachable.
>
> Therefore, clang is _technically_ correct when it complains about
> unreachable code. It does completely miss the fact that this is okay
> because on _other_ platforms, where `NO_SYMLINK_HEAD` is not defined,
> the code isn't unreachable at all.
>
> Let's use the same trick as in 82e79c63642c (git-compat-util: add
> NOT_CONSTANT macro and use it in atfork_prepare(), 2025-03-17) to
> appease clang while at the same time keeping the `-Wunreachable` flag
> to potentially find _actually_ unreachable code.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     refs: forbid clang to complain about unreachable code
>     
>     Just upstreamin'

It may not be a bad idea to deprecate core.preferSymlinkRefs now and
remove it at Git 3.0 boundary.  Some platforms may not be able to do
symbolic links and use it to represent HEAD, but everybody should be
able to create a small text file with a single line.

But until then, this is a very reasonable thing to do.

Thanks.

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1984%2Fdscho%2Frefs-clang-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1984/dscho/refs-clang-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1984
>
>  refs/files-backend.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 088b52c740..814decf323 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3186,7 +3186,13 @@ static int files_transaction_finish(struct ref_store *ref_store,
>  		 * next update. If not, we try and create a regular symref.
>  		 */
>  		if (update->new_target && refs->prefer_symlink_refs)
> -			if (!create_ref_symlink(lock, update->new_target))
> +			/*
> +			 * By using the `NOT_CONSTANT()` trick, we can avoid
> +			 * errors by `clang`'s `-Wunreachable` logic that would
> +			 * report that the `continue` statement is not reachable
> +			 * when `NO_SYMLINK_HEAD` is `#define`d.
> +			 */
> +			if (NOT_CONSTANT(!create_ref_symlink(lock, update->new_target)))
>  				continue;
>  
>  		if (update->flags & REF_NEEDS_COMMIT) {
>
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
