Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F61CC161
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338486; cv=none; b=ghBt+qzow3HLZDjnOs6tz7djvz9GQDqhcka2PYWnoh8jr3ylH9j5x3/bdSPLYAjInhO4sPx72uE8OX6N+EglLS+QucJbfNM/ZrDNZywh1VgVUVjcnToTJnPmCf+FGvpf2kvhF1IDaWfdJDPdLhCBjIKeBM5Klgv9FxnlNV8zz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338486; c=relaxed/simple;
	bh=iN4Zuc2BfxNdMlVZFG6+Kw71HyV9PTWeJv/cyThIZ9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Geu1Lo9S1AfZPkKIdPOGAoyXZ197ra8XrM+l47GIAZSjS798nHoW2GcPR4SP8ayqDIlwUUyvAZ3bIhdNWk8v4UsLXNzluWEzAXLxs9zZiWbQ5GI57kbRzlp6WN3mUGfVLE7PwrH3ah86xhwOhqYTxsLzASQvaoNEJ5qq56OLZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NfUPs2KY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NfUPs2KY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D4FF81ECB8;
	Thu, 22 Aug 2024 10:54:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iN4Zuc2BfxNdMlVZFG6+Kw71HyV9PTWeJv/cyT
	hIZ9Q=; b=NfUPs2KYnIck8SRkqjMnlW4hFXozy6PwrlP1YvLzovd1FHjOsatOdm
	gaewo3MaVv4rGCcZgcQjLHdQP1f/MFxEy26bS6ZX5CR2pUYAzJsCcbvLdPAt4CET
	ejoutQ+O7LD2tw4vjpWamj6GVnQRJ86j2cfo5W/WKCw5o40qJo8EU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CDEAF1ECB7;
	Thu, 22 Aug 2024 10:54:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1AE1C1ECB4;
	Thu, 22 Aug 2024 10:54:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Yukai Chou <muzimuzhi@gmail.com>,  git@vger.kernel.org
Subject: Re: builtin/config: --name-only doesn't imply --show-names in "git
 config get"
In-Reply-To: <ZsbTPeFIPcqnEd-n@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Aug 2024 07:57:22 +0200")
References: <CAEg0tHTWzgD5bw3oK7-Rtv9oTymqyhvZz3bcJ7yNRhF8wXMLGA@mail.gmail.com>
	<xmqqttfd2734.fsf@gitster.g>
	<CAEg0tHQVK9hgcHTzn-ZPdwoFbbYFB2joeT0jLQgtD6yEH+1GiA@mail.gmail.com>
	<xmqqttfdwq0w.fsf@gitster.g> <ZsbTPeFIPcqnEd-n@tanuki>
Date: Thu, 22 Aug 2024 07:54:39 -0700
Message-ID: <xmqqa5h4wqts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75E7CB76-6096-11EF-B0FE-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In any case, I agree that it probably makes sense to do (2). Unless I'm
> mistaken, the only case we need to care about is `--regexp`, because
> without all the emitted names would be the same anyway.

OK.  And we need to fix the "config --get-all" description, which
does not need --show-names there, I think.

Thanks.
