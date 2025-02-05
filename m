Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88261DF242
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776288; cv=none; b=EoBzwX+nxC4wjq+pXKNCdhQzT60ag9GhhZh3Nc/i+rA/MfTNRTBKiyQP452jzbIcGBJsRvxUcJU/fwNb9iiV+cxONSqRacBYdMvlzTo7JA4E5bbB3km+YvpsSw++5/vsjs2+Id179XZu6DsYLoLQEoXNC/yJnNNqBzu58KW05/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776288; c=relaxed/simple;
	bh=kXNx3fSOTyTW/WsXolP3PKuLj8JDGCnDpwYpqGnZHy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6XxYjCjI1MFzEj3fYC4lZvLSEafT9uSMQT0JRVQEY7jpbmbVu1AA/i90v4gt2E8i/SBfAiDRQEPIBiLF0SOXJUeAMr4QtCUQ8esusxtbgV3/lWzub92SMQ618q0Iz3cKbBjFI3uEu80f04c24sIBAmnVrU632REDQUS91jCJT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kl8K/0h1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZwwuc70; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kl8K/0h1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZwwuc70"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA2D825401BA;
	Wed,  5 Feb 2025 12:24:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 05 Feb 2025 12:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738776284; x=1738862684; bh=frTVwb3XDP
	3ee3v1mEfK1R3pO/5VROCfdJQFbxwOvk8=; b=Kl8K/0h1TWexSqGel1c/YZDrO4
	zRukNqReimgWNVOV8NvJQjgk54lQbi0ezikt68T+ThBMyGFWvioWn2fyNo0IbTDj
	1nc7exHt9dCu9tcPL9kGpQoW9rWr2M5vW1LiOUIaxUvqwH+3xGor2tbGxsOwgMfp
	FYbuemOpBeqxk3Iz/Gygr5REYJNiu8gDEDs0lMM36F/CUA7480Q2H4Mpx8jW9mom
	Mq+90fcOFFb75Heurz1TCR5GKzhOVsGe1NOVPM3uiBm+4N1aKWxE41Qu+0JD++gr
	H4Shy+aMfy9vt/w9fhYoNk6Lwiu+O24OMtTu4PHSfHrEp9FZgzfG/cYp0QqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738776284; x=1738862684; bh=frTVwb3XDP3ee3v1mEfK1R3pO/5VROCfdJQ
	FbxwOvk8=; b=ZZwwuc70QA0LllDiXv9J9HTbHoiqFyboeAv2q3QaGR6Y03T8ZEl
	YCBQbjqpYx951lj4uJA2lO4mQbK6lNNbwtE3wUyAT9++MqGRvwEPpvn3KWwQITFd
	kdxPbYBcgTzKITHxMm3ePRwjfBJ6RexCUur0qMEmIQf/lCtFskbki5nwM2ifmRzm
	QZeh8VVVL+ZmrO06RMD3nmvLxrd8efcm8vtpaVlP3FqTTIM3IRWq7HWtieLwE0zF
	uN4RK0S2K8ztwBPOHHh5cI4UXXLDrOaRKqv069T9XDRRjL2x3gQdfraLGE+lf4my
	dIyo2l+ieVDIen5evgz2Pp4JkQJ0p/DHiUg==
X-ME-Sender: <xms:3J6jZ2mK0vBnrE5jh7qTp2neSzJBXjBN3MLvSxWOycNTOUgjnTYENQ>
    <xme:3J6jZ91gwaDIVMXYtqVupFyp4EOIKdW-Zip8rgs4N5lhMG_h8k7cuMAMUJyq94eIj
    PMpMRv1qj0kD-wy1Q>
X-ME-Received: <xmr:3J6jZ0okeRgyZUjL54yA0eCp39w4q2X6qBj62rteNnYWxAdXDeU8EbxmP7vlN_HAfbTB1lxvAk_MMi_d8g-qi48wlpUw9vL5Qdh2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvgdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3J6jZ6lbSidN15MfMXNGGwKL7lOynhHnQQmhxvbD_8XvwJjmPzcrVQ>
    <xmx:3J6jZ02hEtNWA4zhH-xi7IaUEW8RWMS_A43CJRkBJOEFeOH96K8grg>
    <xmx:3J6jZxt4vJX6qrg6pZe_1qQ_rMXFKDDM7ZaTHrHPwAdE1YUjc_cgEw>
    <xmx:3J6jZwX3qKrA3sKMv1GbgtZk6m3Ha_ik1J6HlN9xkFfKHSNNLwykqg>
    <xmx:3J6jZ1ncaAo7EL6vQs0c3zqQKXQydn5BU2UIUhyEp3s7_bvuVccd5EU0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 12:24:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 7/7] builtin/clone: teach git-clone(1) the
 --revision= option
In-Reply-To: <20250205-toon-clone-refs-v6-7-0bbc8e6d89fd@iotcl.com> (Toon
	Claes's message of "Wed, 05 Feb 2025 17:47:22 +0100")
References: <20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com>
	<20250205-toon-clone-refs-v6-7-0bbc8e6d89fd@iotcl.com>
Date: Wed, 05 Feb 2025 09:24:42 -0800
Message-ID: <xmqqbjvgpan9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> The git-clone(1) command has the option `--branch` that allows the user
> to select the branch they want HEAD to point to. In a non-bare
> repository this also checks out that branch.
>
> Option `--branch` also accepts a tag. When a tag name is provided, the
> commit this tag points to is checked out and HEAD is detached. Thus
> `--branch` can be used to clone a repository and check out a ref kept
> under `refs/heads` or `refs/tags`. But some other refs might be in use
> as well. For example Git forges might use refs like `refs/pull/<id>` and
> `refs/merge-requests/<id>` to track pull/merge requests. These refs
> cannot be selected upon git-clone(1).

These examples made the motivation a lot easier to see.  Very nice
compared to a much earlier edition.

> +`--revision=<rev>`::
> +	Create a new repository, and fetch the history leading to the given
> +	revision _<rev>_ (and nothing else), without making any remote-tracking
> +	branch, and without making any local branch, and point `HEAD` to
> +	_<rev>_. When creating a non-bare repository, the revision is checked
> +	out on a detached `HEAD`. The argument can be a ref name

Micronit.  I think the resulting repository, even when it is bare,
would have its HEAD detached (i.e., instead of being a symbolic ref
to a local branch, points directly at a commit object).

	... branch, and detach the `HEAD` to _<rev>_.  When creating
	a non-bare repository, the revision is checked out.  The
	argument can be a ref name ...

But then "When ... checked out" probably goes without saying.  There
is nothing special wrt to bare/non-bare this option affects the
behaviour of the command.

> @@ -580,8 +581,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  			install_branch_config(0, head, remote_name, our->name);
>  		}
>  	} else if (our) {
> -		struct commit *c = lookup_commit_reference(the_repository,
> -							   &our->old_oid);
> +		struct commit *c = lookup_commit_or_die(&our->old_oid,
> +						        our->name);
> +

.git/rebase-apply/patch:62: indent with spaces.
						        our->name);
warning: 1 line applied after fixing whitespace errors.

Other than that, looking good.

Thanks.
