Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF82580D2
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204328; cv=none; b=vEcVvE+fuLMWj+ZsUMvIW3s+JFP9S7MNvI4ShbrSk/m69z2w2+FFF/nKgO7xvUdKkfMheKMAic1vn43xz3kii82CvHD+3UVyQio4Ya+3Thm5J8vfy3voL7gF/8+bji092uaNeKs3m8SRKmo7Oi0oBbFI4T5uzTcaiv7xp9/W4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204328; c=relaxed/simple;
	bh=OUz79LXTZrItRfStz707MpZEG41mwlMqEcoKTGcZhzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pU2pyU9yJBckg1FvwfgJ1rnYLrLOiBQZo2shyR60sad14AHcNQIkHlGzwtRWH0cyVMTy4ORZgQdnX5P8XOpAGBmJwqZGqUwcAno6dJwmEjmG3s7rCcfHCAVFEJB+xVj/NThcXgBs9i3mC0CdS8SkR+GTiWVuHruwAIdzDaabb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zg5J867s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hf3lMUwL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zg5J867s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hf3lMUwL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC96D1140228;
	Mon, 10 Feb 2025 11:18:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Feb 2025 11:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739204325; x=1739290725; bh=wncOryGJq6
	OzY3CnmtVOrA5lHGP8hc6gGmt78nwaW4w=; b=Zg5J867sp//tnzif7Yo/rG4vdP
	jzs6cZLts6lMLO3VzvO8oiN1KXBYgGD7gne7ZzLt+i5tYPwO4hyw8d3Qe9cVNpe+
	EHWb4U6CB8Ygn4NFB+epSeQGm6pE761X7pvRBBiluf5sZ+QOSG4HWiEAhpHiJRB7
	U9RmfXmxPu6FuW1ooM7jTK49x1hEOXfYkp9mG1FqqWF+9L0xCv6eM9d+6PCjCuP7
	2CcmiE6nPdG35IX4HJHQ7POziUjxJ5BTiHTBGqfq9M/kpiVBn3N+m5RthHNGUGEV
	Ul0klabujEOX9FIi7mSHL9pl0jy7ZtOYJM5OUTso9TF6LS3iffpkE64TQh9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739204325; x=1739290725; bh=wncOryGJq6OzY3CnmtVOrA5lHGP8hc6gGmt
	78nwaW4w=; b=hf3lMUwLfe1cAB1zxBAiN9+qTFkb5ybILcJ4EePM2lQDCeFTR7Q
	dzV/eKRS9xsJOjwWv4AKNB9G0uwgekNINBPrfgQwWEE0wM0/zGzOMo6uCRNRSfw0
	4/Uqrm3b3ua51rBDUwi7u4LPSIRBkqkXU4AQgwQbUqQDhMAfcRbAnNKFio6FoNDO
	jRlmlraLIn4s91cjWmxUAQI6zx0Zimckd3YqBkxkFw4wdQHVwUm2N4eLLgSoumbt
	JsBeveqYRZSflRTVMuxx1GnHiQSgATtwlEQl65w0ecHWSeZ5fDk5XdJ9S/89EuX0
	/1JXuFmSe5YXjzY57Lvwn7hjH/CcuZr8H+w==
X-ME-Sender: <xms:5SaqZxEPn-LgCGPSagsNv2JA9ad1NZBXhp6nXLDossX0gORiFiI3Eg>
    <xme:5SaqZ2XM5E6yAFnId0D61AJxIg92d31Ew63xrWXCkliJT9XnyiMl0j_n7jcWh0yMp
    TAlu2NCFHnNerWamw>
X-ME-Received: <xmr:5SaqZzIdiiFjTD2Up-rLrFOqjdf46d9obU4VfOuyIeeDHpZwFk2spllnwdLCLN2dPwEzoh6TS_5SERo5tln5sQN1ydedLWkDiCi3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepphhsrdhrvghpohhrthesghhmgidrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:5SaqZ3HGBOkjjwjHDMi3i8vL6jknq-LVED2l4Yyn2-B1RkGqZdF1aQ>
    <xmx:5SaqZ3XIwasQmxAQ9stjXeUCg-C9D4G2-rBV6agWklt4927yliy8vQ>
    <xmx:5SaqZyMUXv4FJwIKpSN_2FvXNaWGkpkoeURMeoF0sEn4C6b3GOR7QA>
    <xmx:5SaqZ22WBzG3umS5CzZfk9T1swKZm0MRPeX7v3fQxmBFtljCMfwYQw>
    <xmx:5SaqZ9ylGs6Eh9eH3lcftP25u1TGZTmvTpSNGil0BQVAYowv4Sw9OJV1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:18:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Peter Seiderer <ps.report@gmx.net>,  git@vger.kernel.org
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
In-Reply-To: <Z6mtnmvKMsIOEVz5@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Feb 2025 08:41:18 +0100")
References: <20250209133027.64a865aa@gmx.net> <Z6mtnmvKMsIOEVz5@pks.im>
Date: Mon, 10 Feb 2025 08:18:44 -0800
Message-ID: <xmqqlduddb8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Feb 09, 2025 at 01:30:27PM +0100, Peter Seiderer wrote:
> [snip]
>>   The meson build tries to execute the non-existent '/usr/bin/sh' (instead of
>>   '/bin/sh' as the autoconf build), 'which sh' on the host returns
>>   '/usr/bin/sh'...
>> 
>>   From meson.build
>> 
>>    [...]
>>    186 shell = find_program('sh', dirs: program_path)
>>    [...]
>>    685   '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
>> 
>>   Do not use the result of 'find_program('sh',...)' for '-DSHELL_PATH='
>>   (at least not for cross-compile), use fix '/bin/sh' instead or make it
>>   configurable via a meson option?
>
> Hm, very true. We're mixing up concerns here by treating the build
> environment and the target environment the same.
> ...
> The patch should look somewhat like the attached patch, but it conflicts
> with my in-flight patch series at [1]. I'll wait for that series to be
> merged to `next` before sending out the fix.

Interesting.  When we did our make-based build, we never seriously
considered cross building into a platform where the path to the
basic tools differed between the host and target hosts.  At least in
our build procedure in olden times, I think we used to assume that
what we just built can be run inside the build procedure on the host
platform even outside the tests, which would make cross building
impossible.

Now, since we are "fixing" this aspect of the build for meson-based
build, should we also make the same fix for make-based build as well?

I'd have to say that I prefer to see it done out of pure principle
(i.e. we earlier declared that meson is not yet replacing make, so
adding new shinies only to meson-world is like making the make-world
bitrot as if we do not care).

But on the other hand, nobody complained that they cannot cross
build with make-based build seriously enough to cause us consider
doing something about it for the past 20 years, so the pragmast in
me tells me that it is not worth it doing it in make-based build.

> Thanks for your report!

Yup, thanks.
