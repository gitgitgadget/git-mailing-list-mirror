Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFA3403E8
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352574; cv=none; b=AvGwytpIzE7+nK/hBwZ64AqtUF0wz6pxuft8PwbMSbcm49oyceMj1OYmXnbgRwufc+cz2W8NK5kDPtDBCMedldSrZsCSVhnoapK9DU9+SySDuLekaa7pom810So/6mY/H1V2SrpGbj4365L2dFShGe6O0hoVEEJ5shd92BmRaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352574; c=relaxed/simple;
	bh=PKBlfH4tuPU7JyTBAh0TaUcY8NJm0StBZSIwjq+Sb6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eExRHZhFWBMIFc5u8Yl0SZX8wXT888IexuPDQKegwrT2+XSx8lSY6PnJrXczUcUJPi/h9HInEOyJnL+UbwAMl+/K6H0AA2IRI12dV2/LnbxyI0B2WJVWr5ewyd4Uv8LRv1azgV2UkQ5wWgWYlSqnJby3rFW/0LLKXD4rORUNQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mjgtWjWa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AlDewVf1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mjgtWjWa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AlDewVf1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 370D71D00097;
	Mon,  1 Jun 2026 18:22:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 18:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780352572;
	 x=1780438972; bh=vdU/O2S0zMZV9Qby/HfIL1o+7u6UjbtsD+uf8RG43+c=; b=
	mjgtWjWacQyLS7CqJV4hKtZkqwOdL+LdCYg24bL2QiVmLrojAJVIrnIKEbOcEltF
	3/bVqKWa7ChJZ1XIVNh/n+xFGmtZCSTMveepq07i10xaFsaWMMyTdjgHX8cdVAQh
	Cm45evaPNHOaP5qIXVMT++j+16A035UVR0QXCoLC2YIxufnacylwlx3ZVsuTfCwD
	XhP2uW0kixBvwDaYgGHgChfYz1jHDt31VLPLAijEYXvX9Z5MktCAt4xFJEj5kdjq
	9ZVb8+nGFzIOAQhHj8DihjvuX4bptqVuFBYR4fYe8JjDaf1rAJojXe/6yX0BikvM
	CeiLWUOykd2kRXGOCujwag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780352572; x=
	1780438972; bh=vdU/O2S0zMZV9Qby/HfIL1o+7u6UjbtsD+uf8RG43+c=; b=A
	lDewVf14P6KsMzATLIufSBUTopcxFBjUfDTMlaow8ooRKEsHRi0GwRzUiOK284Wt
	4FLJuMokT8OqlR6/4MxU5BgVlyGRcE0OsXVMsutKrpykRhK3cH/MMYiS/QgrAMtP
	KLUsJNxryES50Q2qzE6GE4I6jRdrQaVzXRx746noexAfnxvz08kpex7vfmfWfP9Q
	D3olHylEPPrBz20UeNhDaafDl0KKespmoyHNXbkwp8TpxDIVtStXgHpQ+fzCElrA
	uC1mSvLMiodsOMVkwyEKgJGfodDWK9ChufkOAKR07f81pIX0GLL81+mkT+J2VbMW
	Yhu6oFCb3RnCvtX4A4u1Q==
X-ME-Sender: <xms:OwYeaiswbF0GfP7NTXUfGEf05TEhNQf2jdq4kH4vgD7x1B9B4XcrDg>
    <xme:OwYeao9OnDGoEKugxc4bnfwOKtXdQ5vI83yxc0S86SvEjMAykazorkknYCqJJM7fU
    HUq-ow4foyJDZfI3f6u209gx3qmbYVRK__mF2GMKVp3fNa7TUMoHFA>
X-ME-Received: <xmr:OwYeat2pCzG7XH4yisgqxgP3fIVC9YNQSnGEnwqd4BnJ0LiD8IvaCioKwWr0KTGAJeQt0s7St46IFNLJxzvv3Rx_uN0Ea8DurUrZ>
X-ME-Proxy-Cause: dmFkZTGDNN7RbT6sF55rMYXd3gArnyoEh8eFZQSrxM86+QdpWEJuZo+kpXN8GsVFr1VbE+
    mXQ6y2f6khffqdKbEJoOv4bSNOegJyTF/lhtUYDjzVtVAme1b4QaEyduAr8Tw1JvQVEwME
    Ncuta3y8UmDGAAHCfriDVTXIGYzhrHHB8/P48rWjkcNJvlVY+y8CwuP+d7tWoNth5xtOyc
    gsa+RhzOtwETFhlR9V2bIFS+3d3d9Uysk5M+Uln7zcyoUG2vxfcsJdwtuFBwhEJ0InzEup
    PcrOB3TOmpEOqftm+8L0kg17g9eKbcIlqAy/JZVD7OXwvymQC5sp89rhT6XmapCUxIJFGM
    0VaS4W0c01rFxFYUvEZK74oWiQnoIBsP8KzX0BbCAcSApEbxCNcjtmpIKUjCh5dqYrAMS9
    Rc6tTF5G4b9S4IRESBSjb3i4dDmRW4dgSdt6MdH7NjaYCA92O+o61258smLDbMuEqsc5CV
    pgz9aLsMmS2jhP4lXC+ZMdRlqd2ZLgZhklVboUH8nP/TgMQCNckNHc2A3wtz9yG4+KnXDL
    4PFfLgrqtCPXf+ynrDbnz6di5GDbSneT5jKBmD4BjrptULQik01QdNQ6wg7h2HSR2IidmC
    3bt0eLf7jw/DP4qkFiqf2AAOj4QVXlbkMDj5K0t0oACnxJxmYSNxqxTsTkEA
X-ME-Proxy: <xmx:OwYeatA6TJ7sFw06zTk6ir_zBw8cga1Jz4qnXUnMBQxGemB_vtzFaQ>
    <xmx:OwYeapcyRdENJbZcbffOKg6TEU5W05v9jLqODYKrwlchWgD_clqyhw>
    <xmx:OwYeaq51j9JCHLd8cfVZS2YSCRXtjAwLk28nPAc5_hSt1PAm78hQ8A>
    <xmx:OwYeasXJ-jOUKsmZ83BrSkpN5WU9So_ApaB7Q87It2kMnVAdLpQdEw>
    <xmx:PAYeaoDXQ8I5ApvVOndW6UWwj7mi0yQpdkEAa6nTzKMM5pUrjrDiXito>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 18:22:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Phillip Wood"
 <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
In-Reply-To: <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 01 Jun 2026 23:23:44 +0200")
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
	<20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
	<276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
	<ah12uk7IFxS92OR1@pks.im>
	<042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
	<ah2VL-ftCQelNoOc@pks.im>
	<2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
Date: Tue, 02 Jun 2026 07:22:50 +0900
Message-ID: <xmqqcxy93nph.fsf@gitster.g>
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

>> I found it to be a bit heavy-handed as it's so trivial to replace with
>> git-init(1), but on the other hand it's a trivial thing to do.
>
> I imagine that most potential git-init-db(1) uses will be buried in some
> scripts that haven’t been touched in years. Then the Git init might
> fail, you get errors about git-commit(1) or something not being a thing
> you can run without a repository, and it ends up being a headscratcher
> since the original failure gets lost.
>
> All to say I think a simple warning would be nice. ;)

Or just leave it without deprecation.  It does not cost much to keep
"init-db", and because we expanded what "git database" means in
later versions of Git since its invention, the name still makes
sense.  Thank Linus for not naming it "init-odb"---that might have
been a valid excuse to rename it because it does not cover the ref
database and config database and others.
