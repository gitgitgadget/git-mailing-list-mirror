Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171112F58F
	for <git@vger.kernel.org>; Fri, 17 May 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964009; cv=none; b=rbltvBlHuWAx2rmW6n/z61lzriG0/jJlYxj1qtpbnv/XkL0/nINFvutl6h28qdeD+w4oxwDN7/qFCZbgVKyKPXRoznYOaQmmpC/qtPy7EBqVyRW7ZlmfwiFWq5H+9wExaKoZ0h0PzHfMEalf3sJ4v/D/Zb3HZEq1ljJN0liXzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964009; c=relaxed/simple;
	bh=8I/nA6bpefRnM2zv0EUxjO4zPCWQq/bQtS+pBF0uHL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hwEm8J5QOCz5n9mFsIuyStEJe6MBuZt2XPsHOPOGZDq/Gf65kh8AdUllxJPikEoayQbZAxsPeHOvsVr2aXUuFYcPTemQ9zSevVxN6VhGhiQFJYMinivRgb0rOwgiy1IBQoHkW9CVy8X7ClmPNDUJRaIXoIOVAufPiolSpeNxkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bOiWE9Hm; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bOiWE9Hm"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 449612F752;
	Fri, 17 May 2024 12:40:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8I/nA6bpefRnM2zv0EUxjO4zPCWQq/bQtS+pBF
	0uHL8=; b=bOiWE9Hm7miktlcevtKJ8u6v+wF6p67njUxRoOqKiI6pqI7qPOxUpI
	yA83cDs7hEClkUjbqUEP6rJelfJ/fPrB4mIOLaJgEzJlaZsYmFXvPFETPHsTsmov
	9fn6dnHqd9dAGUcOaLfe9U0fiyriaXB/9OWZBPSked0sdgwZXRGQ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C30E2F751;
	Fri, 17 May 2024 12:40:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF9492F74D;
	Fri, 17 May 2024 12:40:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  karthik.188@gmail.com,  me@ttaylorr.com,  emrass@google.com,
  nasamuffin@google.com
Subject: Re: [PATCH v3] doc: describe the project's decision-making process
In-Reply-To: <Zkb5WeaTOLg9b5p8@tanuki> (Patrick Steinhardt's message of "Fri,
	17 May 2024 08:29:45 +0200")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<5446ca49e042b104923ac2004d845a5f9018c9d9.1715894135.git.steadmon@google.com>
	<Zkb5WeaTOLg9b5p8@tanuki>
Date: Fri, 17 May 2024 09:40:02 -0700
Message-ID: <xmqqy188jst9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1C67C6F8-146C-11EF-AA48-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +This document describes the current decision-making process in the Git
>> +project. It is a descriptive rather than prescriptive doc; that is, we want to
>> +describe how things work in practice rather than explicitly recommending any
>> +particular process or changes to the current process.
>
> Nit: I think we _do_ want to recommend a process, but don't want to cast
> it into stone.

Yup.  How would we rephase it?  "... rather than recommending an
idealized process that we wish to use (but do not)?"

>> +When consensus is reached that it is a good idea, the original
>> +proposer is expected to coordinate the effort to make it happen,
>> +with help from others who were involved in the discussion, as
>> +needed.
>
> One thing I want to eventually propose is to go further here:
> documenting the outcome of the discussion, regardless of whether we
> decided for or against it, in a low-overhead format. This could for
> example be a small paragraph in a "Documentation/Projects" file that
> points to the on-list discussion together with a small summary of why
> the decision was reached.

Having such a list certainly is handy; the problem is how to keep
them current, though.

> I don't think that this change needs to be part of your patch though, as
> your intent is only to document processes as they work right now. But I
> wanted to bring this up regardless as a foreshadowing.

Yup, I agree that it is probably better left out of the scope for
now.

If we are in the "expressing wish" mode, another thing we might find
it useful, if such a thing existed, is a list of principles for
designing new things.  E.g., not changing an established behaviour
to prioritize protecting existing users' muscle memory over whims of
the day by folks who haven't had enough time to familialize with it.
E.g., the plumbing output is sacred but the Porcelain output is
subject to change to improve human-user experience with coloring
and pagination, etc.
