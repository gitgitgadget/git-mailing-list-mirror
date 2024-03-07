Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05312AADB
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815451; cv=none; b=B3tRXMf3eN2ttQyZEO9DGfvzDIv8WGqu1RuJ08c8yNLp3BNA5FbxC5+As7GGlBSWuEhgeyR6GKbVlPyaXSo9xogFja0M/47edpi32fS/tTtDPkcSjPPXw2PMwrXkALpG+VmrRXAIlcyGPmb25gtMshCJmonOJ0eMo/OYx5pm7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815451; c=relaxed/simple;
	bh=5EROu7PWO8I1rgdFD3kLYk/wPUfGv0flAMjUDHJpvKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WJQVXsqot9qRrsCcn8Vp/N6l+uanKh9jJc5widfXSxZ//vsvvvRnyQ/EXZ4d99ImrUe0qTg993C95zPk8lYzbDCKhY2fqsTd3JMcRH4X9JhhcMIwgQDtvSEURxI6tVEBKqcAbYVD7Qe3M4W/lmsNuY1KrqfDuLYW7zTK1zi9Uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=ZyTXKNqU; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="ZyTXKNqU"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id 11838BE0031;
	Thu,  7 Mar 2024 13:44:05 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from ra (ra.horus-it.com [IPv6:2a01:4f9:6a:528d::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	by ra.horus-it.com (Postfix) with ESMTPS id E2559BE002F;
	Thu,  7 Mar 2024 13:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1709815444; bh=5EROu7PWO8I1rgdFD3kLYk/wPUfGv0flAMjUDHJpvKs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type;
	b=ZyTXKNqUKPxrwwUrI6yxd0GkrytjmCPkX3Ofg5ToiOPgPxJInrIGVuM0cJi/9NdgX
	 lwjdtVveWPpz8YISbZGgFB7KqobjmK+Q5fBZR2Pjd0VnNuELSEww8qlFEDov++mXMA
	 kxhDkfKe8f+uyvO8vlxHAaSV8u6Oog5WgWHdw1bIhb0OJtRindEJZqGPrexUgO6dO1
	 C0KoBYsbFAsHMju/XvKM6pUPYcESW+Duw5hv7JDyAr6Y3P/OUqMJ/IWPxC2HjOjcS7
	 E3s7qRvtezLZlIZ8VzLkJSAp02mI2GDg24mhUMxqWpmFRFPDOsdYmycagWHmK9W7xE
	 Zzu7gGajF6hYA==
From: Ralph Seichter <ralph@seichter.de>
To: Junio C Hamano <gitster@pobox.com>, Ralph Seichter <github@seichter.de>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH] Allow git-config to append a comment
In-Reply-To: <xmqqplw6nsuz.fsf@gitster.g>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <xmqqttljtkn4.fsf@gitster.g>
 <2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de>
 <xmqqplw6nsuz.fsf@gitster.g>
Date: Thu, 07 Mar 2024 13:44:04 +0100
Message-ID: <87plw6xld7.fsf@ra.horus-it.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* Junio C. Hamano:

>> My patch only supports single-line comments, and only as a suffix to
>> newly added key-value pairs. This is a deliberate design choice.
>
> Such design choices need to be described in the proposed log message
> to help future developers who will be updating this feature, once it
> gets in.

Just as a brief interjection: I am sorry that my inexperience with Git's
mailing-list based process caused me to leave out details which were
discussed earlier, be it on GitHub or Discord. However, me not
mentioning that I am aiming for single-line suffix comments only was due
to simple forgetfulness, without an excuse behind it. My bad.

I think it best I flesh out the commit message before anything else, and
then resubmit. That should bundle the necessary information.

-Ralph
