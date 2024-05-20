Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DA11CBD
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233454; cv=none; b=or0LEn1DA9NqVWI1Mf/BXGsNGjYw60tJ46YTSvG6iLZ4GgrSGnyCHSTna9mbFQCrDY2nOI4zyUL3jGt7VVzU8oZLW9sH35s1UQoxgQ+5AgqsTyKaFtixhu3XeSlgU/rkVaPw9hBuWTD3uHk5xxhiuRdGzR0IMF8wjoU1T8miiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233454; c=relaxed/simple;
	bh=nyjziM35AUFdDWV5q/IJvnqWGy27oLiHOOt9iHWMCP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uIkd8oBHvnyO/CXtyPA+PMDlbf86MKAOBvij99JLaq0BrcbhXKW41m0YMVE+MjvSuUDEgn9bqdij3LDp+TCxqxPAZIVGgT6OYR8lrttEXNWrc5iuaHrQ/FxEr8vMC8HPGIfC4gY3F+Bn9Zul8zYS/vRGgtAF3Eqy/jUe1Ec1fV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iVZI6rR3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iVZI6rR3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB2E5284E9;
	Mon, 20 May 2024 15:30:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nyjziM35AUFd
	DWV5q/IJvnqWGy27oLiHOOt9iHWMCP8=; b=iVZI6rR35/K9JEPMLMnkkQNxgNaF
	61WJWIeXWc3znT7cEzt5hi7Ela/7rwzwiGEwH0JIP6emqBLvghd4ltLLnyPVOK8K
	USSoTZIBTnPDbMe6hmyWjQkyVVRkQhG0riqbJFqnZY4V3kforEYMiHSJRmYcC8Tb
	zhNHlxFm99HxRTg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E42F5284E8;
	Mon, 20 May 2024 15:30:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5907E284E7;
	Mon, 20 May 2024 15:30:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 19 May 2024 09:14:58 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
Date: Mon, 20 May 2024 12:30:50 -0700
Message-ID: <xmqqh6esffh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 77B73DF2-16DF-11EF-A2CC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Invoke the pager when displaying hunks during "add -p" sessions, to mak=
e
> it easier for the user to review hunks longer than one screen height.

If the hunk fits on one screen, it is annoying to see a pager
invoked and then torn down immediately, even with "less -F"
(--quit-if-one-screen).  As we know how much output we are throwing
at the user, we'd want to make this conditional to the size of the
hunk being shown and the terminal height.

Or perhaps show them without such a trick, and add a new variant to
'p' that allows the user to request the output be sent to a pager
(perhaps 'P')?  It would certainly be an alternative with much
smaller damage.  The existing end-user experience would not degrade,
but when the user wants to see a huge hunk, they can send it to the
pager.

Another, ulteriour, motive here behind this suggestion is to
encourage users to work with smaller hunks.  Being able to scroll
around and view lines on demand (i.e. use of pager) is one thing.
Being able to view all relevant lines at once (i.e. not wasting
vertical screen real estate and making things fit on one screen) is
very different and much nicer.


