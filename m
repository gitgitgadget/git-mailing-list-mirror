Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930E4A2600
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359853; cv=none; b=pdmiV4OR2ilKhZW2mUtc9YpkL/vU9lwlGF0BcpcM8kr4r4fYsmEszmnN+7YQZuXi3ZXTK1+RujLHYU+9zz5KJi92eUF5xjvV/ZTtBM+RTYyl81xrzau8zr0aYmJe/OacUDEIYMwEtGFoLgvdo9xP+6yqkeyh2gkWkXlVtC0fSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359853; c=relaxed/simple;
	bh=59fy0C7YIxey3dXKyrJPHutTqN7iA+UaJW+bSwvLNUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4zFSsmQMSntJxQuDPR1zl5tlLQ7aNzuys2tTzWU2n2LCjGYxLBd1d03pAKIwqSv8+ol7fF9WZBI8WAYWDTplUXgy9ra4N+QV1X8IT5WNIDfHw3zuhoqh5d8Q93Vr3Gcb753FJ93BmJrVrhRAVtucWXXhJntxDTpaDmSU/bVLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rKrCJJdY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OELKUTIx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rKrCJJdY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OELKUTIx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E5527A0121;
	Wed,  2 Sep 2026 10:37:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 02 Sep 2026 10:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788359850; x=1788446250; bh=k+qldtWZFp
	YH/a5ew+oaJoa5L8MvbHOoc38oeHSTiGI=; b=rKrCJJdYh1in5cjvRrHs1S1d98
	LkwQeDspkGxuj8RJiYI0DugqXe2Nah1DMQb1ezeG44Ep8NdSkcvzZUY4HxSFUsPo
	QAxH72mAzxIvks1qJbEH/lK6AZNJs/onx3ERAqRGBYsUs5RUj6j3BDpAPDMhKgsB
	rv9l+ZmAnnwW5wvQ3/X+ZMdCL/4G1gnxojnnZS871M5d4AH7eediZPEKdQq9gyhU
	zNkGkDzlWP6KSRDIuZSDqXp/P7tzC0iExYNsWiA2KIlkYrxlhX7kJ6udccqJF4mv
	FSlAcfBjITVpvoudpUwOXCHhchIfn225pCqWNGS4CI3A4Dcer/bpz3BZ6NGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788359850; x=1788446250; bh=k+qldtWZFpYH/a5ew+oaJoa5L8MvbHOoc38
	oeHSTiGI=; b=OELKUTIxxTTBVw25eeHJBz53uwYDYys2YbeKDBG4ySd1sbFsteB
	1pPoZNpjn+6/qM6Tj5a1+rMekirjTC6kNg8Zbmmlwho6dztj5l/86LijIpmzr+t0
	TxtYd7dSeisKxe8k7C4t4vtBXxjUVrHhn42MzzwScHQxD4RrUmJh8o6LznIHi/d5
	U7ROnRLhusChecBEzxXvjipBMKiKndi1cC/looXQYOcKvFJE76YMg950k0Wo8DzV
	8cSms9N0xIgTSqo+T1wtujpFk3zqFjzLAWyJApXPtlFKgi9LL9N1kKeOK/mX94u+
	DyLlZy53SX1V0qi9KhNaIo5c74vVBcvCrdg==
X-ME-Sender: <xms:qjSYajkLyqu9kUrOn59j9Iz1Dg4L4yDgGM57rNn7_dmmrsuIk3ChJQ>
    <xme:qjSYat291tQPK0ii_Jd0kry1dNfoj1kaGwU4fBQAjdfuLuf5qP4kdTNCTPmi3hdWz
    3VaTpsdp_qP_JwgIh8bKi3DG6RTzjOylyJbQbXcZwyco-chJp_iM_0>
X-ME-Received: <xmr:qjSYaupyqan7HW-9zoPzMwEBPRRWoytUxhYksUu8vqDDclSwegmdYrZ2sLI2cMizc838nFAWOBSlnjaGFp4K_y4krH6pwKLymA>
X-ME-Proxy-Cause: dmFkZTGT3XRUbcaU2Z1cqeaNLhpeB0C8FBzd7c8yLZ7aF07pis6CXPyRU3MT6skoCfB6DD
    VgPYWW52vFgM04prA3MNmN52S3b2AfO9eXbUNGTEfx6AFDyCRM6OPM72NN6rOEdYrU9Xx6
    xZfjPrluyjLl7e8Ty9XbQSI9ZXWa9iN3e/17QD1Z3mgkDtDstz+YMLsnTRMmLPmdSFvNp0
    b4088LG+Qk/Mq7QFZt8x4RTwgr6YBds7Dj+3TCnNS9J/dn1Fwt6oRCvIMVvA9OyQrfaJA4
    PA7cIiwJrV+8P2EBXAh6Ssb5YGQIDFeb5Z6ERrtDHWWLPF81v6jShexoiFk5JsRFZu8pCh
    jJdaq4xoIprxRnI5+bI0KxhsjWNnkkwIUaosETSdt46GLiyys1ZtDZUwTQgezSdjbem7Wf
    tkZFlPCtXHGWDJWp90fWGxZHoiOxv7r3lRqzA7oSJmfCVet100IewrolKgL8kVvw42k0wS
    yJqDO1tjhUc5RDe2zMLKS+4ufxvh/IYntvoZ5dn1YrQBVajcwujwctKBjHnzv/fT2qEMVI
    mA1M/4FCYA1/mH8nn0x9HzG03+r7sXGCxYQChoqPjMFnPGBBNFUHVfam443QOhwrCIWRzb
    EVrpxFtSZ8brhddqi6VUhoyv/g3T+igKIhI/v0BbunkJmzVqBlmUEC9F+ZPw
X-ME-Proxy: <xmx:qjSYaqc3PC_F49a5DmVPWTNOJHDrh0jpZ3OVdzEr8g4NJ4kfbvwVWg>
    <xmx:qjSYatrx2AMBcqARpq_BocngKzejCWftjVSRrHdExYFtEphdsZz1-A>
    <xmx:qjSYarEjN9xqemUhYQfoHqYxlpXS9_6bvgu6F1aHMOGfNFKQZfnDvg>
    <xmx:qjSYattLojrsrffCSvt-pgcu7C6OKi5kdZ95V7vAI0a5rwbrcX8k4A>
    <xmx:qjSYahSkItowmdgftSt_PNIfPSiwamtj7fxkEup4c2qYywUeUBlTi7BU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 10:37:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
Cc: git@vger.kernel.org,  "Aditya Garg" <gargaditya08@live.com>
Subject: Re: [PATCH] imap-send: add --draft to set IMAP \Draft flag
In-Reply-To: <31d24dc3-3ef6-41cb-acbd-4cb4fb0d2338@app.fastmail.com> (Wolfgang
	Faust's message of "Tue, 01 Sep 2026 21:28:55 -0700")
References: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90>
	<xmqq8q5kl4gq.fsf@gitster.g>
	<31d24dc3-3ef6-41cb-acbd-4cb4fb0d2338@app.fastmail.com>
Date: Wed, 02 Sep 2026 07:37:28 -0700
Message-ID: <xmqqtso7k9cn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Wolfgang Faust" <contrib-git@wolfgangfaust.com> writes:

> I also read in some past thread (I forget which) that we generally want
> to start by adding a flag, and only introduce a configuration if there
> is demand for it after the flag has proven itself.

That indeed is a strong personal prefference of mine.  Sadly, nobody
seems to have followed it in their topics---you are the first ;-).

