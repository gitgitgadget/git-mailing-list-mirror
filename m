Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272C3D98A
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938280; cv=none; b=k/pZaWT14+ojQ1P3Y3mo/cvURHaYt59Vj8aY8UI7r81IOHBXtDsrgw70F+e/4KNc64OTP313jGBz7IV1hIST+aY7qEHcdUMFChNYQncFTuwPHwYvFZ4MR8qvQ25WJVEC00zdp4e7W2LlBpxeqrgbvqdmwRmO/pQPwWaLBOnPM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938280; c=relaxed/simple;
	bh=GdUacYrmxdig6sUFoAT+ogucwbqx4Ug6goTTvCG0+O0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TQXZ4zEDWetluL7bRwrJ9uU2dURySIJb1khGmGE3tDLWVkiuAYd5/Vetc1qWttdtS9tprnuhRWwXUyEjZd7CtvkIiyffGOzPa3JkBZEbgG9SNX0McY7HJYZKKIKdiOeUfr5XqehIwUNQPa0yLC+PaVABAPuaSw7SabgAYTGgVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V+6cGjYf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V+6cGjYf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AFB628E24;
	Mon, 22 Jan 2024 10:44:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GdUacYrmxdig6sUFoAT+ogucwbqx4Ug6goTTvC
	G0+O0=; b=V+6cGjYfl1t0Ojsb5+ioQ98EmEBOepI/9hv0hXrvfj9wNYjYFcdLEW
	TIoMU4P/n9+BuT7Tu3rQ8V2huUXML+di5jd4MAnZwN0T0f1UM5TUzbO0mFBrbqUN
	VmzWjgpblnu+EkRS3OJV9zE9keikRsm0Hn8niUyCYLUKa1/UTBJxQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7346528E23;
	Mon, 22 Jan 2024 10:44:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DEEBD28E22;
	Mon, 22 Jan 2024 10:44:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Matthias
 =?utf-8?Q?A=C3=9Fhauer?=
 <mha1993@live.de>
Subject: Re: [PATCH v2 0/5] ci: add support for macOS to GitLab CI
In-Reply-To: <6e190a32-ee45-451b-b841-25cc6eb2c5ab@gmail.com> (Phillip Wood's
	message of "Sun, 21 Jan 2024 14:50:05 +0000")
References: <cover.1705318985.git.ps@pks.im> <cover.1705573336.git.ps@pks.im>
	<6e190a32-ee45-451b-b841-25cc6eb2c5ab@gmail.com>
Date: Mon, 22 Jan 2024 07:44:32 -0800
Message-ID: <xmqq1qa9e5jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 23C4AB8A-B93D-11EE-822F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
> ...
> I've read though all the patches and they seem sensible to me though
> I'm hardly a macOS expert. I did wonder about the use of pushd/popd in
> the fourth patch as they are bashisms but that matches what we're
> doing on Ubuntu already. It's nice to see the GitLab CI running on
> macOS as well as Linux now.

Thanks, both.

