Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871D1DFFB
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813542; cv=none; b=FNNgf4WrF3Hk9m5qdcH1RKouKzXv6Z3YXYm4YZ69sTqpec4/XgHKiAwNcEr0ulDYouu6tucC61IVNVTBm6QaQVkhgv3VOXb2EHVDzLq9wEfLfmhJbJDHSotNHE5GZqNTcIMc7LmaomQOfu50nylrBUCBWRs41MbkjEMA0SOar4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813542; c=relaxed/simple;
	bh=LUJeP70CwbsoJT1mwjUEP3kL5Frt0caraFx+CK1qW4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YMEA1X97vhu9KXfgekPIQ+VSS32I9vI8179n0Gb7OHH6wtW9TusnQtXLl3X1kDiJ4+qdRkWEkLmJjwic6g2O1ihnz7wZJkQa9TqqBncCfFPljIiT8vOh70s8aKU+PgS5oQbqzvXxjm/G3ydIU9AC4KjCkUEMloQhSesnmyPhnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NaxCz5N1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NaxCz5N1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0253D1EB629;
	Mon, 22 Apr 2024 15:18:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LUJeP70CwbsoJT1mwjUEP3kL5Frt0caraFx+CK
	1qW4o=; b=NaxCz5N1v17MnCf/GJyGBloDFXbna68hH32aTrfwRKUx/iiqfbePi/
	9Cl3hMmbVaAGdc24p+n+GPZPz95PomdFRLanIjo/BgnalfFYov8FpZB9b71AQQK7
	OKMKoitdt7uSB0XUVz2wgt8KQDT7py0l0I750e8tLsPO+FZbINxrk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EDA8B1EB628;
	Mon, 22 Apr 2024 15:18:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28BA71EB627;
	Mon, 22 Apr 2024 15:18:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  avarab@gmail.com,  christian.couder@gmail.com,  me@ttaylorr.com
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
In-Reply-To: <CAJoAoZmOqEd9HcHMrOUwSXNJi2a8DLeO_11gW1h_HuaK79WEVg@mail.gmail.com>
	(Emily Shaffer's message of "Mon, 22 Apr 2024 11:41:43 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<CAJoAoZmOqEd9HcHMrOUwSXNJi2a8DLeO_11gW1h_HuaK79WEVg@mail.gmail.com>
Date: Mon, 22 Apr 2024 12:18:52 -0700
Message-ID: <xmqq1q6xw6hv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2812B366-00DD-11EF-B713-25B3960A682E-77302942!pb-smtp2.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> Thanks for writing this. I, for one, would love to see the process
> evolve a little to account for the scale of work coming through the
> list on any given day. However, that's a discussion that will be
> easier to have once we have the status quo written and checked in.
> ...
> So, if nobody disagrees with the content of this document, I think we
> should absolutely merge it. It will be great for newbies to see what
> they're getting into, and for me to send to my boss to explain why my
> predictions for my team's patches landing are so broad.

Isn't it a bit too late to say "if nobody disagrees with", after it
was pointed out that the world around here does not work that way
(yet) about a week ago?

If we have an agreeable v2 already posted on the list that I missed,
then sorry, please disregard the above comment.

I still don't think it captures "the status quo", which is what you
want this document to be, about "larger-scale decisions", as the
Introduction of the document says.  Can we have a set of pointers in
the document, when it gets rerolled, to an actual example of how we
made such a larger-scale decision?  Without such illustration with a
real world example, it looks to me that what it describes is what we
wish the process to be (which is not necessarily I would object to),
but labeling it as "describing the status quo" is very much
objectionable.

Thanks.
