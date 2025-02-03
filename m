Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC81D5174
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618362; cv=none; b=JYjdbt8qSantXk+Ur8qmCQSm27pqYJT2yach7rVRmwD/uj0S1HWBkM1v8jz3r4+IwRaNNkPppvPOwHRHU2IbkcO6+69GvpzBarzhzyoU3meCpuOLkfv/VHl67GQQXniJgeZYxKmIZTPZE+79umWcLIPzugQHVOmwxOjWv6YAGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618362; c=relaxed/simple;
	bh=IR4FIV/cIQmJVlW9DHG3/LSlPK8PBzHv8n4iL79su+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y15enFdiQPNJpef9BVC/3rwo9x6W1beyydx1qRYa/jjTaNhreNStie5k2lQq9R0UtQBojAC77UbsDO7yqBJNBwB2SvzI4ZPVyqbRADt2w5BpqHnF1cIiHnfBCbYOXb0xbRAvBFIJIr88ufldhCWqNnpoRuHj/mYxrgej1tDWY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qx3kWDUV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8rKTKHs; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qx3kWDUV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8rKTKHs"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67AD025400A0;
	Mon,  3 Feb 2025 16:32:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 03 Feb 2025 16:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738618359; x=1738704759; bh=g3InqsXHt9
	7Jwn0D6bZRsws+2y2gQScYsK7z5gkENUg=; b=qx3kWDUVi3Z4pqlavz9MmdgxK4
	sVrO1mgwtbPXKEc3NEhuBGb0PqTtOb6D4boYB00zRgYBJUuouv62tzjcUb8VyYrY
	NGpYDwvAgKfJ9BYQ16YOk1Vu2luH0fXOufV7s5a8rwNHaQbNXiiGm7CBoIQcSnrt
	v3JkvLWm/pLX9NpW5jstCrnFUuMD+jfliLY1d0EDOqE2PCRJXPX+LpEiksxzk9rW
	POkhpqpkm+q+zmyO+8t0kvkd/0uwJWw9dd8RRGE8Q4+v2p0zKL+B/mO2vHdVR1Td
	Eomsmtb1eDKtFzhKXumaP7u5DUjWrSzTwD618kkjG0m3aHaHXCA9Z+eC3Xig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738618359; x=1738704759; bh=g3InqsXHt97Jwn0D6bZRsws+2y2gQScYsK7
	z5gkENUg=; b=E8rKTKHsxXuYbAu34SSqNf49xw5sVbiJK45YqiqwP/S6I0fZjOG
	RmnXp0LZSnGslaeKprHm7jnNEASjH8I9v9R/gjnfhPGvEI61MyabR1ceaHWqSpy7
	7nEu9Fp/1sslhhxJAkA4sZT3f/nQLHN/NIo6fJLMGSRa2xG4xnaNvbLvRsAr7gWF
	tBiOxfnD6OdTHVQ4ubOl3UGdTOFIHoB8eZwbIOps9A9DM0pKf/MShyPbg+4fFbWu
	z+xyhHokZO4frIJAiJbIV4Nqq8cIbhqt/K2I7FiXAuJs/1fYDhMcYTDneMArXLYK
	mcGnifqLRQDfqB70q64A/lbscFkkVDLqtBA==
X-ME-Sender: <xms:9zWhZ8n1CcL54VpjWkevVijhwKvCHJCQOl_YPw2qrHJ2N8EfKA3DQA>
    <xme:9zWhZ71YUrz4IHwLiKxU8491eJfUUfVJhoAWaZ97nbx9USdQlNGz_7JNrw5DNJcvJ
    BJ3cHOV03lbF2Nnlg>
X-ME-Received: <xmr:9zWhZ6ruZdYtVoynknriwV_Su6bgnsvpzUh_6naabDbnGxkkD2SmuBgWQ20cDFQh6dfDwBU2XYGFd6jp6fCVxeByAWn5WVwifAe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:9zWhZ4nGbpNrV3Z78ALtJ-DPrWKm0xcTSseivFQ7bHTMV4Zt0IasYg>
    <xmx:9zWhZ61iGV3aLlmODZfTb5UE7YGj54mpVZKoKUD5FWtXQ1Lwm-s-AQ>
    <xmx:9zWhZ_sN2fCvkPybny89QPILZFX6E9GOY_cQHy-wJiipP3HeYbH1dA>
    <xmx:9zWhZ2UH_I4IWb_h3Kif-v5QEpKyEH6QfBNwM5fNLwsGvc7zhfaRdw>
    <xmx:9zWhZ9Q9nxgH9MBq4-EDhvUw0K7Ri_Nza0qJMhEZECpPGoY1hwOoMz1S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 16:32:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #08; Tue, 28)
In-Reply-To: <Z6BdWjgd8kk2c9u7@pks.im> (Patrick Steinhardt's message of "Mon,
	3 Feb 2025 07:08:26 +0100")
References: <xmqqlduulbgn.fsf@gitster.g> <Z5nfcAUZPNdDSI0l@pks.im>
	<20250131233015.GA3544301@coredump.intra.peff.net>
	<Z6BdWjgd8kk2c9u7@pks.im>
Date: Mon, 03 Feb 2025 13:32:37 -0800
Message-ID: <xmqqo6zi1zpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 31, 2025 at 06:30:15PM -0500, Jeff King wrote:
>> On Wed, Jan 29, 2025 at 08:57:36AM +0100, Patrick Steinhardt wrote:
>> -- >8 --
>> Subject: [PATCH] ci: set CI_JOB_IMAGE for coverity job
>> 
>> The main GitHub Actions workflow switched away from the "$distro"
>> variable in b133d3071a (github: simplify computation of the job's
>> distro, 2025-01-10). Since the Coverity job also depends on our
>> ci/install-dependencies.sh script, it needs to likewise set CI_JOB_IMAGE
>> to find the correct dependencies (without this patch, we don't install
>> curl and the build fails).
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> Grepping for "distro:" doesn't find any other instances.
>
> Doh, indeed. Thanks for fixing!

Thanks, both.  Queued and pushed out.
