Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DA4E06D1
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013767; cv=none; b=pXrqMYEhjxejd0jXgZ6Di8PLWOkSIKeeQTisrGlrmxQwVGtglbH9rdYL7J6sSDBPPG5GRMiaDmL9wdvaNCDeuvFAyimdEeOOGMVACaaF1oOncGQsJ0vXzVeJNIuGD12JE/nGfn3fuKF0yETOpfURvD8rjNRkBqIs39U5RREQEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013767; c=relaxed/simple;
	bh=0lrw+jKhxmFxLdDbhhVO6XIBE8bQr9pMbYKHNZbk3Tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cV4MDvSOmkil11UwQAsNveVVS869bMUaAjDvYrxeF2dwY7+FrDVUZ5da69bLC6ROC7BTEboCqZdlDSDKnAyZYz4ToAygAiUoaqTflICHh86TwUFZ5n2CDz9np7wRQ0UgceoJJkkXi1/lxugvBEewgL/KgKf5WjvAryEMPzxhJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n/WB3PIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qwAB/bbM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n/WB3PIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qwAB/bbM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 760F9EC01EC;
	Mon, 21 Sep 2026 14:02:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 14:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790013765; x=1790100165; bh=v8xb3GKZ22
	OtYNEUVV9rT+Cb/stWjEOHdH78aVPXurQ=; b=n/WB3PIPF2b6RdqMOaawRR9Qmm
	GETeURBnKaGFKuKkUAeVH2Jb55mVQG72tACZyvNooX9mejMFwPmXpLsbB689DZiN
	zSHjmbQlrSJn5fGx+RNQOXySycJpzSeyt3iLQdK/1ZWfWsRD5tdg9bB/pj7JnfVu
	rj+GCGXM8mfdtxOCdhL2OvrikhXvVhoL7HeUu5tTbVhW4qhCtYXbv4ev/dawSaoj
	yjX3rK1qOYB8ufyzondWfqgBl0qj7GxoV8KNx2n1w8KUQRYYJe/ikm0cgMs6o36y
	YUsxTzXBwe6ksvtrCOtpkOMuOsii3lJ+TdK1olsnII/8oDo5krMcr87bOorw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790013765; x=1790100165; bh=v8xb3GKZ22OtYNEUVV9rT+Cb/stWjEOHdH7
	8aVPXurQ=; b=qwAB/bbMDD+M3dL/gS6HqYmIyzu02CFWY0HWXq8cZ0s0qCQDw5L
	LM/oOAmG+821yylKg2ZTp34YfdWT7bh6TVqJ3Zmvpr9kbls0Rdk1JyH/x6iL5h2M
	03wUuAz63rakRkwZrlwCtOMjTW0E5UMCro8l1ohB7/L43cJ/tVNzTlOsBtuB+Krt
	at99yYSidteuY5an9AxTLfobVyupjRqdCbB6fOMD/RJHA1vHmwBW7SKNuj60EvPA
	3RC+RM0/+cbink36cgTT+glpfnNVaFrqDOb6aqqJfN25AtnkEOaaEfHd1BZ+qxjC
	wvt9ADOsATParwmpLPav2t9J9Ok6dfBkTQQ==
X-ME-Sender: <xms:RXGxavinYyYklf_3ls-gIQfCgbNYg8N4sTWHKfnXeuzcZu7Z4MlBjw>
    <xme:RXGxavuVaME-PAIdDgBQPwEIPwf-2gyomZ34CFif-x2-0cDtGJCjT4oVSKRhI-INI
    jQS56mZbO66KaHKYuGO9vMUIDOodVKWQwFRDDhjhOTTlsajcbhfzqE>
X-ME-Received: <xmr:RXGxao64boYNBGzlf9SE6B150LGO3j96ST9wmPgTiPNtuEaiUPok2Wy6WH4A0syOlGEeFtQJTodEEoE8VhiwKy0QIPE_JGeICTIb>
X-ME-Proxy-Cause: dmFkZTGAsDzGutEGgZpZZ1lptqFeZA0aU/uAnfFhEQhaDaAEd8V1LtMVUtyfnhI8b9JxV7
    4f6cjxS8YAt1E8MowbBxzXQy6BChr+w/Va956Tu1QK4+HOUahpffDgvwTM4S4+ukNgZrML
    zMx5CipOHZ+WYDVKE8GMCA122HaJqFRrzmYvmqyWBzzC3pjUoTOlsotSDYR0ulSYYlqkWl
    m0pjrZpi0LWT5ryX4FwE01DBZAYKSQspCQyaI0r38ST9e+KW6Uh4N92PiHaDPUxP/4oZKc
    fzCpUO6ee2BF66AhSd7PnMq4WdNhPK4o6Mw+UpsiHWGJ734+Gm9AI74t6Hcvun7s5T3jcA
    CFLQiwi3aHuPdudi9YbfV8fUstuMvWjpXoOpIcv067lM+X+mDyxqk20VwM2oNkG/JOw3kS
    Yc5JyxZO5lMY+jVBQmZLwsJ9DLtUhez0TmNH5tnf1uGq4+0RHAA5rlSGwqiJl8p9tjrZ6q
    //SLOy+bectjszBPmECO4BC3oJv6UVr0YLVMAFs8EKR24Fh9dBT8OKDfUqO+ZZjnCrzSb6
    LXgpCvTVkbb3/9leEL2AjCVGuKQK54Z6b2VNc42QpIV/+S6b3lFZtHHRnp6cgev6eFGwxM
    SFBf6GEYg3kYjRfPKP05pZdc2dNUpqos3TSvuN9qYkrsv48Pugn4t8QSKNow
X-ME-Proxy: <xmx:RXGxajOYyeFecZTTje1MK4y1w0P4rULhemE4V3VqHKsZsqBr96NEUQ>
    <xmx:RXGxautuDTGSpkN1HfByo6kFKzjuKfwsJ8FjpaHNFhIKRz6O41MEvQ>
    <xmx:RXGxauZ6M47SY4qsdyexOm7ojjerBNzkg5VVZvr_-KsnpWK3FBGq6g>
    <xmx:RXGxaoxuZppmmuxaWXEXz3rjZ1ehP9UpFOXKITP3gmDDIpHVcOAP1g>
    <xmx:RXGxasIwE3kMn7QENk9ogB2Vd7NzeaUBJ-mCI1nuStMyTbOV9YPz8Eyc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 14:02:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  James Le Cuirot
 <chewi@gentoo.org>
Subject: Re: [PATCH v4 0/2] Use Rust in the Windows CI jobs
In-Reply-To: <ffb1a618-5c6a-871e-c93f-0d4786745635@gmx.de> (Johannes
	Schindelin's message of "Mon, 21 Sep 2026 09:05:41 +0200 (CEST)")
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v4.git.1789315032.gitgitgadget@gmail.com>
	<xmqq8q4zosri.fsf@gitster.g>
	<ffb1a618-5c6a-871e-c93f-0d4786745635@gmx.de>
Date: Mon, 21 Sep 2026 11:02:43 -0700
Message-ID: <xmqqbj9qmqik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio (and lurkers),
>
> On Mon, 21 Sep 2026, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>> > GitLab peeps, I still would love to ask for your help: I haven't been able
>> > to confirm that GitLab's Windows runners come with Rust preinstalled,
>> > https://docs.gitlab.com/ci/runners/hosted_runners/windows/#available-runtimes
>> > did not clarify that for me. Patrick (or anyone else with access to GitLab
>> > CI), could you see whether this patch series builds on
>> > saas-windows-medium-amd64 without need for further changes?
>> 
>> I rarely look at failures in individual tasks there, but noticed
>> that a recent run:
>> 
>>   https://gitlab.com/git-scm/git/-/jobs/16576450182#L784
>> 
>> failed with "cargo: command not found".
>
> To close the loop: I am trying to address this in this thread:
>
> https://lore.kernel.org/git/6c2bba91-a1a9-3547-4be3-f4f9ce03e696@gmx.de

Yup.  I saw Karthik's response as well and consider the issue is now
in good hands ;-).

Thanks.

