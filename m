Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CB92EA147
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770440193; cv=none; b=IjpRleYFdYCLj3Quq+da4+8wGGsQ3sDchxft87alHQGZ/A7hWsVpezgL5FuX8p62XWMKeGRukO/z4kk7X48cECYIQ5o1U/QwtlGDO7nwH8rrCkgOXnAtezUk69k7D3PNit3q4TBHJyW/50CbprrjSa93ne+PScXXOjo4+Fg3fLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770440193; c=relaxed/simple;
	bh=n2jfw3tb18rxAp9hVW8GmgH+eGcn2CsZZ5V/eMTk7Kg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYtqZ8oHAP8iZCB8uix/HK6lqpQXCmUjR1nrl0vL37pG8P+4HuZ/1qESPdWb9g4UCl561IJ0a6GYUq0ssy2id4wI19myCNZugC9GmMeYaGvBHwkHTPIfc4M0+nHOhZBawApEY7jpCwy4VnjF7hEXQda/xEYZ1SO6WCxAxqraUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rJnvPoGM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3/3T1QP; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJnvPoGM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3/3T1QP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 98A4D1D0000F;
	Fri,  6 Feb 2026 23:56:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 23:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770440191; x=1770526591; bh=rUkz7v6dw7
	q73rEt+OwRNZFW+mfY8p+tafN5cqYafEY=; b=rJnvPoGMGz7hnphcrZTI8IyYm+
	x5MAxhti6A4a5bkjxw5qlYvNoJE5JP7Fr/CZuyDsj/mInxU20/vOknKiKLOavisg
	2fZbSbyabGMrJs6KnaDo9xMKLnA+aVLa2EQEwsCDPjFLzKprwc+m4HDuaRQcQY5Q
	bbjTW24yg+9SBYefCq1CzFwMJe7e7KWFMtVIHVLaOUoCP//Eb8fJJSIHacsGEczR
	j33tfXqTZuYariI28xk2szKrN3yYRv0glVT6a2HxGz7T+AIUwKP2F1ssmMwrOW2I
	PVUZBSymr7cFjrrFyr9Gyb5TQGEPrCCA1yPCRROQpNHqUYysr+PDcdOh3HjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770440191; x=1770526591; bh=rUkz7v6dw7q73rEt+OwRNZFW+mfY8p+tafN
	5cqYafEY=; b=S3/3T1QP58zk3H1rccRj9CxTwUBwsPyXBWgefvckEjTFWezXnj+
	fOULtrt3e25kbNoK4L16rW/1Z/w1bbi7s6M6ueskgx/EyH+Vswe/n46DHaGGp2+m
	Y6ZZKGBoosyDgx1P7FbyizYYt+TRuGon7nrqZzl8WU3BgGmiPu7vBi20onDW9jJm
	CIyYmHSY3TaklC3ruiOej3r3Jj1d+SU18fTB1ovYg6SJPJcIT6IAkuqHVlD+ODVB
	rSSippGT7XJpKx1j3JPvTzX4ELXMKNE2Ofq0oDNPyA2XZe0G7oT9m+SqlNyc4VLi
	SGJb60JnEzeK6Q360SGZSWVI0acXaJLHM6Q==
X-ME-Sender: <xms:_8WGaaykBujnUubd8ariIXhfuyTVtZdVcTlrq67Ypa9zhnHI7LRIlA>
    <xme:_8WGadRlhRynIxkdOR1oZYLAT04k_ldG14K_OA5HMOkNIWyFrcQNsDGqq3IHCKL9L
    kUozBwdk4Tp8XosAL47sPOvzSoHECFZ2ztcxBfSav-FTEqE_Xi_qhM>
X-ME-Received: <xmr:_8WGaRXhoiOwQUKaGgRQiP3QS1VJIV1av5IbpWZYNyN7q4fhh-O2oH9N1-GgYX3uzuCiu4WfcEmN5VFOra58Vojji4wgnYjj7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrsh
    hkodhgihhtsehhohifughoihdrlhgrnhgupdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_8WGafbBDhECmZodltNbwQkwqS-AT4LUXGTtISsMtXCk7tiRwJrVqg>
    <xmx:_8WGaX3PlFXkQlxk0N3XmBNwND6VJujqWy8zEuyfgiPVhM-2onLSLA>
    <xmx:_8WGaRj0mB5_fgX6rLeadFWYWO4qTyiAbGdfKZyTfTKPBpfBlv_vNQ>
    <xmx:_8WGabaReNBA93RGYNqGaRQFm6HBLzNXfKY7Zl0FRV5puElmaEDwow>
    <xmx:_8WGae6kz8PzNFWIcRVinc40FXR8iNvzq7_t1xVeQh6q71jNlRwTJAwP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 23:56:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid ubuntu:rolling in most jobs for now
In-Reply-To: <20260207042703.1180704-1-ask+git@howdoi.land> (Colin Stagner's
	message of "Fri, 6 Feb 2026 22:27:03 -0600")
References: <xmqqy0l6khkd.fsf@gitster.g> <aYWaytvnR8wOdc1s@pks.im>
	<20260207042703.1180704-1-ask+git@howdoi.land>
Date: Fri, 06 Feb 2026 20:56:29 -0800
Message-ID: <xmqq343dcfsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Stagner <ask+git@howdoi.land> writes:

> Subject: [PATCH] ci: ubuntu: use GNU coreutils for dirname
>
> The uutils version of `dirname` has output that is inconsistent
> with GNU coreutils. Prefer the GNU implementation of this command.
>
> Signed-off-by: Colin Stagner <ask+git@howdoi.land>
> ---
>  ci/install-dependencies.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Hmm, this certainly is a more focused solution.  Let me revert my
demote-from-rolling-to-latest hack and replace it with this one.

If we hit more breakages and at unacceptable high frequency, we may
want to change our mind and write off rolling as not stable enough
yet, but if we are lucky we won't have to.  Knock, knock...

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 6ee8216a05..617b90cbc9 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -71,16 +71,27 @@ ubuntu-*|i386/ubuntu-*|debian-*)
>  	# sudo(1) or sudo-rs(1), with the latter being the default. The problem
>  	# is that it does not support `--preserve-env` though, which we rely on
>  	# in our CI. We thus revert back to the C implementation.
>  	if test -f /etc/alternatives/sudo
>  	then
>  		sudo update-alternatives --set sudo /usr/bin/sudo.ws
>  	fi
>  
> +	# on uutils v0.2.2 from rust-coreutils,
> +	#     dirname "foo/."
> +	# outputs "." instead of "foo" like it should.
> +	# Use GNU coreutils to provide dirname instead.
> +	#
> +	# See <https://github.com/uutils/coreutils/issues/10508>.
> +	if test -x /usr/bin/gnudirname
> +	then
> +		ln -sfT /usr/bin/gnudirname /usr/bin/dirname

"-T" is somewhat exotic, certainly outside POSIX, and is not needed
in this case, no?

> +	fi
> +
>  	case "$distro" in
>  	ubuntu-*)
>  		mkdir --parents "$CUSTOM_PATH"
>  
>  		wget --quiet --directory-prefix="$CUSTOM_PATH" \
>  			"$P4WHENCE/bin.linux26x86_64/p4d" \
>  			"$P4WHENCE/bin.linux26x86_64/p4" &&
>  		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
>
> base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
