Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7D25776
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018988; cv=none; b=alqBRukH+/5VVDPm0fi6lx9QvvKIh1uoD+CabFjV745B8iV7fUyq0Azev5Y4i3rV7aLOafmh8BJGI65/+QGLv8a/Nxxa7lau9UbE9/qtTBPvAacuaBEVCfkXheMh6/8V/R6RQI0jNZBceSEOk+jYLYNKOnV5fH3oMkCRiOd0p1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018988; c=relaxed/simple;
	bh=isXvvZqsG9zd9NiPYMv/SFTKOXY3UhUxYgJ+7OC36HA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASQx8WW+yrXLKFDNnUzUcT8Z+Sg1p/4WIpGQc3IpuR4NwtD5pG6ftMcuxIMiVy6bvLyJTwdyRrimrgLO9Nq8OfYc+9LopcmSJE3JWQTH6yfEqgytc3wKqHV5O9qa7+6reCzx92ivOQHrdpkyfbmOXBiFlWtiQCHbMmREEr6loUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BfqvWr/u; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BfqvWr/u"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F151F27C8A;
	Fri, 26 Jul 2024 14:36:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=isXvvZqsG9zd
	9NiPYMv/SFTKOXY3UhUxYgJ+7OC36HA=; b=BfqvWr/u+sT39U5VxGayepA2SVOZ
	Ti4TUO6c5ta/ZXhX3AznqjZTpmBhhMHyh5492U/7gd+fbvNWBcto7EhTcqViLgIb
	zCqvjgQrkt6pt3kx7HEZ26rCJPVg89jJsgpkMCnp6XKySRmEDUaO6c8a0+7Ycle3
	LJB4W3dw+Buyqh4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E963927C89;
	Fri, 26 Jul 2024 14:36:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7344727C88;
	Fri, 26 Jul 2024 14:36:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] add-patch: render hunks through the pager
In-Reply-To: <38e190de-cbe4-4f75-acdb-fe566e541179@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 25 Jul 2024 18:43:45 +0200")
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
	<62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
	<2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
	<5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
	<a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
	<97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
	<xmqqcyn1lcjo.fsf@gitster.g>
	<24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
	<38e190de-cbe4-4f75-acdb-fe566e541179@gmail.com>
Date: Fri, 26 Jul 2024 11:36:20 -0700
Message-ID: <xmqq8qxouhjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F4FB332C-4B7D-11EF-A699-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Make the print command trigger the pager when invoked using a capital
> 'P', to make it easier for the user to review long hunks.
>
> Note that if the PAGER ends unexpectedly before we've been able to send
> the payload, perhaps because the user is not interested in the whole
> thing, we might receive a SIGPIPE, which would abruptly and unexpectedl=
y
> terminate the interactive session for the user.
>
> Therefore, we need to ignore a possible SIGPIPE signal.  Add a test for
> this, in addition to the test for normal operation.
>
> For the SIGPIPE test, we need to make sure that we completely fill the
> operating system's buffer, otherwise we might not trigger the SIGPIPE
> signal.  The normal size of this buffer in different OSs varies from a
> few KBs to 1MB.  Use a payload large enough to guarantee that we exceed
> this limit.

Up to this point, it is fine.

But ...

> For the tests, avoid the common construct to set and export one-shot
> variables within the scope of a command:
>
>     VAR=3DVAL command args
>
> It happens that when "command" is a shell function that in turn execute=
s
> a "command", the behavior with "VAR" varies depending on the shell:
>
>  ** Bash 5.2.21 **
>
>     $ f () { bash -c 'echo A=3D$A'; }
>     $ A=3D1 f
>     A=3D1
>
>  ** dash 0.5.12-9 **
>
>     $ f () { bash -c 'echo A=3D$A'; }
>     $ A=3D1 f
>     A=3D1
>
>  ** dash 0.5.10.2-6 **
>
>     $ f () { bash -c 'echo A=3D$A'; }
>     $ A=3D1 f
>     A=3D
>
> POSIX explicitly says the effect of this construct is unspecified.

... unless the patch is about changing an existing

	GIT_PAGER=3D... test_terminal git add -p

into

	(
		GIT_PAGER=3D...; export GIT_PAGER
		test_terminal git add -p
	)

then all of the above is irrelevant noise that says "as the coding
guidelines tell us not to use the non-portable 'VAR=3DVAL shell_func'
construct, we don't."

Always write your proposed log message to those who will read "git
log -p" 6 months down the road.  To them, the trouble we had while
diagnosing the true cause of the breakage in the previous iteration
do not exist.  It is not part of the "log -p" output they see.

> One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
> 0.5.10.2-6, so avoid using the construct and use a subshell instead.

And it does not matter if all CI platforms are updated.  As long as
our coding guidelines say not to use this construct, we don't.

In any case, that is an appropriate thing to say in a commit that
fixes use of such a construct, but not a commit that uses the right
constuct from the get-go.

I have to say that the [4/4] in the previous round, i.e., fc87b2f7
(add-patch: render hunks through the pager, 2024-07-25) in my tree,
is better than this version.

Thanks.
