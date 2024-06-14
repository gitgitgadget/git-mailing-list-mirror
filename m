Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73817C72
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392903; cv=none; b=AQQ/UFtxNaVth/cHyUr7tleMAMCGyL82OvDF6G6uVdz03rqYtMCyCarB+LfUXGOp+8o0rDPNKLkaZQ+Fmd8r4L+wdz7j7CDp/XDnutXf0B/kXuJhT1CzQa0iaXAzbP7ZfLxSPaynIN2/JnndzQwBBD2aiaNLJ1mwXOwTydRVjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392903; c=relaxed/simple;
	bh=cPVT3UKZsDJZDrBtyGqtNuy3AxXVOwpmPnVbz3oslvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lanYQ2HwqEZuJGA899L8t2amAkGkoqOtm0okI2c0TCsJTaGQlBhLNXC3CNFjqgDeA7uSe3tP3Bn9JJLkzxXoq/EFaPEvsusOUMbGRb4WfHjx1339Sj6ik0gOSBM4+4+dmMopgsByxjXRrHkj47UYtg9HuILzn/2YS4c3DKSDtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G+1t4sok; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+1t4sok"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03DCF33BFB;
	Fri, 14 Jun 2024 15:21:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cPVT3UKZsDJZ
	DrBtyGqtNuy3AxXVOwpmPnVbz3oslvI=; b=G+1t4sok5wxmBQkNtsRTFiatwdSJ
	Bb8ib60GdcP+5LUmfJSGGHlrPYUHpxH+Oh9G9kX7TyY1efOL+rBEMlNMPzka3xJy
	cFHAbyHegkHqd1xgKZlFKlvpcmsmWpaG9RddrSeFK3SVYqRrAn4+hHBdkDugDJWW
	cC2w4uE28ZoGQ2g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED0C933BFA;
	Fri, 14 Jun 2024 15:21:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67D2B33BF9;
	Fri, 14 Jun 2024 15:21:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] worktree_git_path(): move the declaration to path.h
In-Reply-To: <CABPp-BEnhJt_5mJ2rY3FFU-4_v41zt2NHOkf_Xp8DYxUsGgYPQ@mail.gmail.com>
	(Elijah Newren's message of "Fri, 14 Jun 2024 18:50:43 +0000")
References: <20240608183901.2084546-1-gitster@pobox.com>
	<CABPp-BEnhJt_5mJ2rY3FFU-4_v41zt2NHOkf_Xp8DYxUsGgYPQ@mail.gmail.com>
Date: Fri, 14 Jun 2024 12:21:39 -0700
Message-ID: <xmqqwmmre3ek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 53A883FA-2A83-11EF-85B9-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> writes:

> On Sat, Jun 8, 2024 at 6:39=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>
>> The definition of this function is in path.c but its declaration is
>> in worktree.h, which is something unexpected.  The function is
>> explained as "Similar to git_path()"; declaring it next to where
>> git_path() is declared would make more sense.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  path.h     | 9 +++++++++
>>  revision.c | 1 +
>>  worktree.h | 8 --------
>>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> Simple and straightforward, and the rationale makes sense to me.

Thanks.  It helped that there was only one customer that needed
adjustment.  Will merge to 'next'.
