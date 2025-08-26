Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75232FE054
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252677; cv=none; b=XSg6FwpLFCavXjRAm3qTfp/1CXEiwrWehSf+UAcze5JjIViYGO99YIsmegDTLDVv2nnLjx3M0eW5Xu+6/7VRpGPp7WK3bOCj+CW2d+8qUQacuDJyHj2ppifgmOCrMpdxFxRhvGSKPmE6LXVlVqgMtnbjoHbjAW1N3SvyQ6XK0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252677; c=relaxed/simple;
	bh=ww6752a1Gnxbycu4KKXzqIW7sKcJjbCcxYCoHWa6OV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o1HD+qhrH9HsjC3q4Wj9t7ici53dup8bYq9K2d/GHgT7wsouZQYhl7mH4Yvcp8DnptLpaeyCh2lwg2if4eYvboi1UqNN/yt0ijwK/O5TEMvn+mtgTRv7UuFaIxUGBZWlIvkFfVghW15aQ4NRBN6UbLKpS5zF+n7AGiXFNSC35jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=urX+CKj2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dC+7CkDy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="urX+CKj2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dC+7CkDy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE25014000BF;
	Tue, 26 Aug 2025 19:57:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 26 Aug 2025 19:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756252674; x=1756339074; bh=G0XQHDV7je
	wGK0YWt1Aw6Xm8B0Npq+wxZS7EqA+1GBs=; b=urX+CKj2rJk6WWSs76A+7C20Mr
	W3x9lcSRgupyMA6TF9jxtmnGeej8wDqPPsYlcySs8Kd4U75QnJ/QJKtZ9wja8eEp
	KhgdWnkFlXnAOB05tVFqJPBwWuNNeAGSNz5JlSv3DDlDvIKv6G8zNwkCDMhD84sa
	y8fcDG3KEWj6mAofopT9dEDvnm2H8SZ6Cq8uB25k9vEp/qu59x5srJFadss8hBj4
	mXYTbJYmN9hjF/5N+QuBVV3ccuDAM3Gnwds7ew8MIqzcP31EghElQHoI6m+lXHej
	ucCyTlDQ5c3g3KXsZal0wcgasHdFg5AP+hvjuVApJ5fLH0v12w3E0igJ73gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756252674; x=1756339074; bh=G0XQHDV7jewGK0YWt1Aw6Xm8B0Npq+wxZS7
	EqA+1GBs=; b=dC+7CkDyuEDvFt0UoaVtSq8EyIvCbnzEznrQ52MfE8K4Oei+ReM
	kqyUg9Vhu/W6xFkJmcme//g/LBeODRXsHaAi4E62M/2pxBZmPVBPpD1KpAf1B7J2
	dCaZmxeDWyLbrjz7k/R/aa9mvyD6IQl4i2dUpUmVzUA9ELyq7achdaEVYkxL6rrs
	oVLpzKayT5YHFNbsYa20mO2G0srNBdOnk21Cu/ypm50RjCo4p3MVHpj6kXeLwou0
	7WwK9JkjgCVVOmMe+5MVL8KEqx97OOpbY5F6oR+vu0GFPIzERZFFxlCnjO8t1Vz1
	f6dWNE3r1vq3UmDrZwnMLV2bR7Gk9ea17pg==
X-ME-Sender: <xms:AkquaNCBHQT3q6gSGUgdcb4G20n7xmgBrmboEWrCNzCShSwQDiz0qw>
    <xme:AkquaGEz27yriOFYWIIp2nfFPUs2lMAiSnQfXsUjOWQafYFNOT3bX3-jezK5l-4aT
    o0Fnoja0A9sp6Zhng>
X-ME-Received: <xmr:AkquaFIUCq6VETgUKLtEY94wqLRvruCl3qCaXOg-FJB9XpHOFmArys332BQ_htmMlt1MrZk_QKpoFj2dAvrIIdjZgnqqckzuCnhOOeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeiieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepveegheekffeiueelveekteelgeffhedvtddtiefhtdfggedtleetudeiuddu
    tdeknecuffhomhgrihhnpeguvghfrghulhhtrdhtohdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlih
    grsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AkquaKmIZa2mQlECIrUWiHHeKWyfgtIzpX-q152rMlZNMbXgX_PGoA>
    <xmx:AkquaNRTZeXx31sVeQKGnygoPXnTXZ0THWotThGRWH38wj-EnxENxw>
    <xmx:AkquaMI80FzXXiq1AX3UJ1V8E7oQ1gelB9vHuhXD20jvoPBdh2YxXQ>
    <xmx:AkquaDARRfUb0KQmHuEd8ND-61WveIvWZl7ejZM7Fp3M3EXd1v3dMQ>
    <xmx:AkquaJwcjR7v7tJCi-geQ-lYwFGoRhX5_oxeSjlp7-uoCaAZo-EDqQ6T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 19:57:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 3/4] doc: git-push: clarify "what to push"
In-Reply-To: <ac554cbe75444880bbb2791c4d85dcf083d833d7.1756240823.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 26 Aug 2025 20:40:21
	+0000")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<ac554cbe75444880bbb2791c4d85dcf083d833d7.1756240823.git.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 16:57:53 -0700
Message-ID: <xmqqldn5fxfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -When the command line does not specify what to push with `<refspec>...`
> -arguments or `--all`, `--mirror`, `--tags` options, the command finds
> -the default `<refspec>` by consulting `remote.*.push` configuration,
> -and if it is not found, honors `push.default` configuration to decide
> -what to push (See linkgit:git-config[1] for the meaning of `push.default`).
> +To decide which branches, tags, or other refs to push, Git uses
> +(in order of precedence):
> +
> +1. The <refspec> argument(s) (for example `main` in `git push origin main`)
> +   or the `--all`, `--mirror`, or `--tags` options
> +2. The `remote.*.push` configuration for the current branch
> +3. The `push.default` configuration (See linkgit:git-config[1] for
> +   the meaning of `push.default`).

The use of numbered list does make very good sense here, as we (at
least conceptually) examine these rules in the order.

>  When neither the command-line nor the configuration specifies what to
> -push, the default behavior is used, which corresponds to the `simple`
> -value for `push.default`: the current branch is pushed to the
> -corresponding upstream branch, but as a safety measure, the push is
> -aborted if the upstream branch does not have the same name as the
> -local one.
> +push, the current branch is pushed to the branch with the same name
> +on the remote. The current branch must have a configured upstream with
> +the same name, so this will fail when pushing a new branch.

Is the last sentence correct?

    $ cd /var/tmp/playpen
    $ git clone https://github.com/git/git src
    $ git clone --no-local --bare src dst
    $ cd src
    $ git checkout -b alter
    $ git commit -m 'empty' --allow-empty
    $ git -c push.default=simple push ../dst
    Enumerating objects: 1, done.
    Counting objects: 100% (1/1), done.
    Writing objects: 100% (1/1), 185 bytes | 92.00 KiB/s, done.
    Total 1 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
    To ../dst
     * [new branch]            alter -> alter

In "src" repository that is a fresh clone without any customization,
the current branch "alter" does not have any configured upstream.

Puzzled....

