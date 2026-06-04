Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B809231A41
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535688; cv=none; b=SZkX0kLC0VtcZ7bIhMCrv5CTCSsl2w30jVj5KbkIpLG3FiLZ60dn/GAW8CxDOZqCf0v2ifCNboxxOyqUESe+LOC+2Hh2qKgQaVeGmL+9EtbBIsnslO15Y0pU9HW69rgiKwZ+1IVNuK5Ete+5jWd5WdP2r05p6LwZXs0YJ/zw6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535688; c=relaxed/simple;
	bh=px+CwKV+VcNRoQr5hDXPRZWIYhdAmyqrcib7mpevAXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u7E1Nvqy1qoT/Oj+k4hUdO4obQ07LUfGOocAEisTgeZ0tDdrWE69gJP18CWp+f0W7SwKrqPRAh4H8gQpzpbYUkhCiYU2bSpzGXPy9Cac3NE4mfE/CjejpF6rCzPBa8UeiCXIxgUL8IlIUMwTMS/xZjSxHhHomDw3i8BxzB9+Qwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g467Q3+4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ai4c3T0S; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g467Q3+4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ai4c3T0S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C34F140008A;
	Wed,  3 Jun 2026 21:14:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 21:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780535686; x=1780622086; bh=WwgfFZ7TOx
	2vnOTQO1ryudKodrbW+fz59L+0EFn+1jo=; b=g467Q3+4W7j6dZgZwVEBHI0x+K
	tkZXZiyXK2va20IDXoi4X/7qYjc1aXhICgG6vrkZz0X024hACEZIignRW/HUTlW8
	V20n8GV3iucZke2o9khSJrzNqnwJpU/mopY+LWe7QYdNTkyCgl7mnaXbx+u7oTiD
	Pn+vVlu3W6DnA9oAks0dMiOIkqdpJw14lMMk9/22huO6SPaDWqsLtQwIsKDDupMS
	fDPmoaHoQZ89Clc15H8TBPCCFbNuXhfL4U1CAPjejh5EHU8/lpXOBCkiZetz6Iqw
	xe6CHaQq+Ji8CckDQSRrapiKBO+W8y1Lc5qF2Dc22yO2CzD2wGSQGJEhWqzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780535686; x=1780622086; bh=WwgfFZ7TOx2vnOTQO1ryudKodrbW+fz59L+
	0EFn+1jo=; b=ai4c3T0SiXUNfW0rq9120+VsMpFQCXv14aclPGxdrs53pXvyYxN
	ERxDbgMaktR+q1QT00XSG/zaRIIkKy1imTdDLsr6xd3m9yv9/72srFGQ0Sz9iPaY
	JgY+V+QTgD0aWsy6e02IIZrChJLTYkrmebdRTBTqLIA85+oGYCUPY4hSn0ujnu0Q
	gV40xTQ1l782vy6sllufbiW4pUPDRMg3bxk/svdLH5rCxCclSoRdd0cmDayUj/o4
	OHnQ22AtnWmroDIV+1RKw9qtZGEPMKbo6MxvvilIf2j718XABJztPjTfwoCeF7as
	yTV4CpGDCtumFlElIBOnZil+yDgrlRGc3gg==
X-ME-Sender: <xms:htEgavIgnXb818MbRK4UrWR8dgOwjU4paw6L45Bxc-b2puy-F4Pbpg>
    <xme:htEgaqlqapkeT2Zvn7Xt2vYblPCLmj5Z-qSUYnLpD39CExo3gHW4TGNFQ7spcTni8
    i4CVYbh9ZAvEdlcB41omRlGfTIjxKnYzIDIhDEo6cuhG5byzS5AHA>
X-ME-Received: <xmr:htEgalFIbQSxcNcCfd_RAelcJTewIzzd0jKRwIUgV6x-TLrfsNtcFLUA9mXbeWaFjR9mWf2d_IEElOgYr--oiP9N0j2UyaHiHdDK>
X-ME-Proxy-Cause: dmFkZTG0bg5CLHXYfYAkT6GBYQERMy3gfdZgblcgZES/kRiJM89Iof5ZtKpSwEzy44Stut
    uEaNE/eFnBaGcxQmpxqGOl8yaWN3s09vwuL/6Fr1/gDxoztXku/CevHqtMSFFM8NQr5XK5
    713zPu5XR1mCuDdl76col9hns8Te/ADdKqJJbdfusSeeKRu6o9Fl7AgXr6lFYGF7lj7LAF
    nj/JJBcuaFnNXQHYB7KcHn8jCRcDXBT8X20YwjEH97RvlIhaqET4ri4eldgcj1nYlX1QAm
    soziGnIrD9m0NdkXVzY+1utWLLUtjlAGPZUOYtJlylA1JMi28iP7GmQODPpmbgkDpjtbXc
    2ru5I1NFBrXNK6Hj6UdvSagZQgc5zIfxbntrjw4mOwAU65uZn0KcW5jBlNHE56Kxs0Ezol
    MA7mp3n0nlz+g7njM5gmoPyXxoIwPmDAK1tz86J1NFDy7DgjILmFXB/ExUG8XxPWsjvmZu
    JSMJ7DLPPwnUzqnDfwWNk40pqMBH3YU7lhr03aRplf2kpwwcieJUJLEiGjBFIkNcGVx/5I
    T2fjYvvD8G9cfyNZJ8YcQeOL55Qxj+qnsDIPzqtxFIBDz0kwkbG3GA9Nl7HyRImW7sa6Hf
    wWNuxm3+jkkNawHMckEOaxGizJG1bZX7F2c1tp9doK/tnI8fwk/qiznnJtPg
X-ME-Proxy: <xmx:htEgaiEU9-LizqHkVWpj_RrANFKK7v1e8BDfhJxX9HQZf8lBlRJpIg>
    <xmx:htEgaqOzFjbFMA-fZo8iwTrRFr5EIyZk5fTzDbaeFjZfDVx_N77_ag>
    <xmx:htEgapFv5Gu4ApWU6hNTqZSm7FvIRUVkNbFhDI7OqoK8VNghgEsTEw>
    <xmx:htEgapPQ_jEkk7BF2k4ZrjFmm7TplXPbzX5A0754kVkD-7CO_jrfDg>
    <xmx:htEgakun-yMJCR8g7py6U2xquUCAVm71REZVnvoZN12SuRSjBRkrD42s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 21:14:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] worktree: record creation time and free-form note
In-Reply-To: <CAPGaHktHLPUeSuhETwyBo+jE2fMu40jHW284PN+2oY1YJ2j0Yw@mail.gmail.com>
	(Norbert Kiesel's message of "Wed, 3 Jun 2026 15:51:23 -0700")
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
	<xmqq1peots9i.fsf@gitster.g>
	<CAPGaHksjsSefYmGPBxKLw8DDADR5AwTiHTbHq0UyBBtg3CKq9Q@mail.gmail.com>
	<CAPGaHktHLPUeSuhETwyBo+jE2fMu40jHW284PN+2oY1YJ2j0Yw@mail.gmail.com>
Date: Thu, 04 Jun 2026 10:14:44 +0900
Message-ID: <xmqqik7zp0mz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kiesel, Norbert" <norbert.kiesel@creditkarma.com> writes:

> Hi Junio,
>
> I looked at the usage of `.git/description` and I could not find any
> usage.  We do have
> Git branch descriptions which are stored in .git/config, but that does
> not seem to be
> usable to store the worktree description or the worktree creation timestamp.
>
> So are you ok if I send the PR again, just using "description" instead
> of "note"?

Not really.  Not adding "note" and reusing "description" merely
removes one smaller problem I immediately see.

As I said a few times, I do not get why such a "feature" is needed.
Also, be it a "note" or "description", people notice typoes in the
message and go in to edit with their editor, which would update the
mtime of the file, so if that is the timestamp you are using for
anything real, I am not sure how well it would work in practice.

I'll let the others to figure out the merit of the feature and will
come back next week to see what concensus they reached.

Thanks.
