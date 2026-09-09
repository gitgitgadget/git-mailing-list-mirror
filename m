Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75439DBD0
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980668; cv=none; b=Cd8Gpzm3/abpsfwIYtT8z/Mg8CcDiE06n2DyEpal2fjU5+1M5Rneztvrjlj1Z8aCnTeoPcu1e/r5VdxDFA38fVPpOB2xIU9hZLHsI0ZuAdn3gZMryVLzC+HyijxswmALqiky4SnmscJoza3rm0U49/TmY5mLe6P/+oIA7MBm3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980668; c=relaxed/simple;
	bh=T6j0EDn0toGVdd2dJvbrQXe6RLwRWbF4LRyE2zAuWmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwuL19xn/hANMC6SJWvn2iCt+ENFSYVPg9DSuTTbtnooJhWPkJEpQGlT84k0FW2u0eGsakFXuPE6tAAhUAY3uJZQhKk43qWFHySXXW2pgsMi6y02g5HFWHLZWNbtV/ZMfvo+b5jPEdVo4MFs7kDBDayUAIaMEp3qOQVGJX6GG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hoGSVdvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+LKIOmk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hoGSVdvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+LKIOmk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 238EBEC0107;
	Wed,  9 Sep 2026 15:04:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 09 Sep 2026 15:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788980666;
	 x=1789067066; bh=yiCRVMHeXIcL/t9vwm5feEEqJXvx6TXcAfs7yTjXI+4=; b=
	hoGSVdvpcfDNWetgO2h4/aLIYLpOqmrN78rurGwd0E3slUsbU+uLN9JKg8kfGAyG
	oj2cnf5A6UVE8ElhfDCwjD0//JpcjCB6Z0s37fTm/ryuFtynoxJ9GIsu1PiXlC24
	+wRYxOYydzNNQhfLqrrxcTRZ7eqr/C1p2eXXJrpMM68yE+w9qeYQvWq4BLJ/ECrY
	mACQyqc0hei9DMHyaadsEJ92hQNpcnQwhW7nHCNa9TQ1MgDv7DMPt3h8rbnwpS/q
	J8H9dluKi11e4cLA7zL5+xSjBvi+qzecTNtxvYiCnZnIrdu63nUTScYFYY5GKoev
	+bzcvXKsvnSiBJH3hd1XmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788980666; x=
	1789067066; bh=yiCRVMHeXIcL/t9vwm5feEEqJXvx6TXcAfs7yTjXI+4=; b=e
	+LKIOmkQ4gCr5rlHz4LqB3XYuH5idlX+2cAnT8H6koJGs4xIPM9Al9QVm6Z9ZqEg
	pod/gAnlW2pATK4NgLIqrHsEHCbNLCJkzwVHH5WGMBfH1YhGROPpRZrxKY9QuzfP
	2b3JRsMMnmHTWgUkAas8qFLyOQZ1lVSb1GH842u/evHGq+RmUr8Tnz2BZWzOOxoV
	4RdOanpRxbbdGaWBAjvPylBacfnFQvb+PPxsVj2FMx3uvJGqvNEexVQlwb55WSAG
	nqmS4et0aJN5cKwZTlnkmWW4FXGTebC337m1edt/b87c9H3hcLcGhfcTLMGfK1zF
	zZD4XEAtMjg0csgrbXkiA==
X-ME-Sender: <xms:uq2hapiq7rh-rT7MS17ZvKepzgnUxTJkUYcZiKyyDfilbDS0lUO1tw>
    <xme:uq2halcq1fCMm41pRchynPwGHyc5AefR54OBwAiph2g7GezOkV1GNoh2mtTShiYId
    RfiiwdJyx8I5uYwDaefs-avzicpZJQp3-kukfAmgnDCm6ViHmMwjxg>
X-ME-Received: <xmr:uq2hamc5f73RuvznPoeY629D8rssnDnkJax0p33U8vccmP6NOgHkaJEHExVcQs26RNkjhH1zSGHslG9JYKOELi0J4d3kstRqFC4E>
X-ME-Proxy-Cause: dmFkZTE25iagNwig3NvB+qIdSjDYCWlUZ3V+YqrgZ7S/gaqq1kIvODKpWj2HeTvDcjKfkQ
    DuwUt0/XdTfFi/hJV6Uzjx32BKobcuXUZAvqgt40lAlmeJXQBH2bx94ZIBzX2dBWS8Yo9F
    NEnHGNWXDQuayDCb4fVXdrpPhBXXEGi9RV7nu7L9WKmdl+nYRPbAp1Ebhu5o+f6cHv0Azn
    QLzL/vl+ivjeLPtlPbU4m81ADTW5VT6QBClJ6CISDgR6dquvBjKr+M7izQkNlIIRnJprIi
    9vo/9DNVPN6X9Aysq5C1QG2gq3L8zMElxen3GfX9LvlsIHlF9P1OYU4faISXX8WyQZ1XA6
    DOvyIJ0lFGyrzqS3ZBZkwVU/niQ2zLlLRm6rYdxWCSkm3b+X2GTeVpriYvCwcSmQpZ4wN3
    euca5AuZvIignU+b8KNMs3N3mlRWYLdpn+t8OXVXbbrDoZQXf5LXsnDphiVPalQsfZnAts
    lnPEg9h34yB7GlBZpnlK24kmL/8EBGqtEqpGhdxt5j9gT43T+TO0tbjHmkJ3Q5aTdSswf4
    2jWK2BBmPWAhpbK6C9nVJma9igu61j34YsMDPsjFHPg7HQrPolXGUF17qaemmYZxn0U4oe
    MceW2v37zEaVZPDTnw+ykBJNXc/bx0lTD2wvKXT0GVEp36E30u6yIhtnAU6Q
X-ME-Proxy: <xmx:uq2han9-fCI-bo0ycJq9Ogq-wV2vfpCPvels8nxfFCH3qeqps0PJxg>
    <xmx:uq2haqlxHbJW57YChXcuH5r_kAs0U4XUBxq74InBXJ8sV6udLcRmkw>
    <xmx:uq2hah-8BKsn01Q3fRX2MFGCJIdHvKEG_UcyloP034uhrctQE30pYg>
    <xmx:uq2hagn9bs6ApnO2BsmI0iW7DUIrdeivMOvHPiEzStg80u1NrVNiWw>
    <xmx:uq2hatmPf3-7ZnbN3KyHjcS9Xa9Qm4VdqMgShhUoM1IUa5K2VZHJEDyf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 15:04:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <8f0a076b-4822-44e2-a842-cc1e39ae1c1d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 09 Sep 2026 20:08:17 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
	<xmqqjypfp2vl.fsf@gitster.g>
	<16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
	<xmqqbjan6q7l.fsf@gitster.g>
	<9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
	<xmqqpkz24193.fsf@gitster.g>
	<b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com>
	<e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
	<xmqqcxuq483g.fsf@gitster.g>
	<8f0a076b-4822-44e2-a842-cc1e39ae1c1d@app.fastmail.com>
Date: Wed, 09 Sep 2026 12:04:24 -0700
Message-ID: <xmqqpkymqm9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Side note: using `--range-diff-notes=` (empty arg) to signal no-notes
> would be inconsistent with `--notes`. Those options just take that
> value. Then they inevitably output:
>
>     $ git log --notes=
>     warning: notes ref refs/notes/ is invalid
>     [output]

Ah, I didn't know that one.  It sounds like a UI bug we can safely
fix without worrying about being backward incompatible.

> I don’t understand why you contrast these two approaches:
>
> (I’m using `RD` as a shorthand for `range-diff` again)
>
> 1. `--no-RD-notes` means “revert to whatever `--notes` is up to”, as if
>    no `--[no-]RD-notes` of any kind were ever given
> 2. `--no-RD-notes` means “no range diff/comparison notes at all”
>
> Since (2) was the only design I presented. Is the point that you can use
> these two approaches to eventually find a way to implement the “revert
> to `--notes` behavior”? Well, if so I understand.

No.  I thought #1 was what you were doing, which was how I thought
was the only way for the command line you suggested in an earlier
message would make sense.

    You may want to turn off this notes override behavior after it has been
    activated. Use this sequence to do that:
    +
    ----
    --no-range-diff-notes --range-diff-notes
    ----
    +
    Now the range diff is back to displaying the same notes as the
    patches. Going back to the three `--notes` example: now the range diff
    will show all three notes again.

Under the interpretation #2, the first --no-RD-notes tells us that
we won't use notes for comparison, and then the next --RD-notes
tells us that we use notes listed as parameter to it (which is "no
notes") for comparison, so the "notes override behaviour" is not
turned off.  We use no notes for comparison, and use the ones that
are given with --notes=<note> only for display.

Under the interpretation #1, the first --no-RD-notes would make the
command behave as if no --RD-notes were even given, and --notes=<note>
would be used both for comparison and display.  Then --RD-notes that
says there is no particular notes you want for comparison would make
the <note> given earlier with --notes=<note> not to be used for
comparison.  After spelling it out like this, it seems that even #1
does not turn off this notes override behaviour, either.  I admit
that I wasn't thinking about interpretation #1 too deeply as I
wasn't interested in seeing it happen.

So it is good that we agree we want to use the interpretation #2.
Which means the "You may want to turn off ..." part of the
documentation inaccurate (I think I've already suggested striking it
off in an earlier message).

