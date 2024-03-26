Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CC14387C
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484696; cv=none; b=HMnJ5Umj/jmAYqKl6SyPForJ/3W71YIfQULqBtqGGQR5WirNjJdJjV+Z+rAkxNkoRfppHA6E16nXYMs+WZvKqFwJanDBOLpaenWp85J6tOMv8n6wNwauyUoHe//5mgFL2YEnmedHubmHfhO3oQzZrLJsGhswAnBW7/l0I4udV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484696; c=relaxed/simple;
	bh=+Z/vluP5PvZ4FODz4SB6kKaBacYW/peprOu8EAAyGLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPPr6/kAHp+z8Dc5NZee+YPY7RBsiQqOtP9oCNDQvNckekXxY3gJxU7US45fhfHXG6KeJ1SvYwWCmoLN5KU2yQbtDjNd6SqUxTYjrNhKA8TrWWJwUFhh6ivEOZgNMaU7V2QyV9m4a5TpuDOtnOUZ5iYTeGOAdjjI2pNKPpEhFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iPjN8C+o; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iPjN8C+o"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F1FFD2FB54;
	Tue, 26 Mar 2024 16:24:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+Z/vluP5PvZ4FODz4SB6kKaBacYW/peprOu8EA
	AyGLg=; b=iPjN8C+o86a2zP42kLEZr9c6jqAv9RYGIoiHlALlpHMdOgcM2CnZ9M
	r0yuOklDj0CzggJy4KEGSKKZ3QInorNQUT+NlIvwzKTFLEYxdX1v7OoIXqzhlXUu
	9WzjA84pCBvnnign9N1OmlW+n0JNbOI78xKJpjC5cR6VKZfJ/TbkA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EA0A42FB53;
	Tue, 26 Mar 2024 16:24:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 656232FB52;
	Tue, 26 Mar 2024 16:24:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v4 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
In-Reply-To: <gh34scvjq3.fsf@gouders.net> (Dirk Gouders's message of "Tue, 26
	Mar 2024 21:09:08 +0100")
References: <cover.1711368498.git.dirk@gouders.net>
	<20240326130902.7111-5-dirk@gouders.net> <xmqqo7b1apx3.fsf@gitster.g>
	<gh34scvjq3.fsf@gouders.net>
Date: Tue, 26 Mar 2024 13:24:47 -0700
Message-ID: <xmqq1q7waghc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E506B01A-EBAE-11EE-9094-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> Oh yes, you are right (as far as I can say): I would change this to
> something like:
>
> "Asking for this list of filtered objects may cause performance
> implications, however, because in this case, despite filtering objects,
> the possibly much larger set of all reachable objects must be processed
> in order to populate that list."

Better, but the verb "cause" applied to "performance implications"
feels funny.  It may "have" implications.  Alternatively, it may
"cause" degradations.  As implications can be both positive or
negative, it would be better to say "cause performancedegradations"
when you know if it is negative.

> (Later in the document, it is suggested to do timing with the two
> versions, which kind of follows up on the performance impact that is
> focused on, here.  So, this doesn't remain an unresolved detail.)

Great.

Thanks.


