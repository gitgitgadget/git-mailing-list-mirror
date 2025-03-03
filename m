Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1AE25C71E
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021944; cv=none; b=BWgnw7Wk9IDzBP0Pzn34cP1NkeSB+OHEcFQ2yhZ9ezd4Sm7dWfrmPA70NiXl1Bp0iaErfGjWllOB4XfsbCZ4Ap4HdkIAJSWDpvMJCOHss5FFsk0OtuFRMPe67Fmu4UcHCIPINWs3rish4gVeXtAaFlLKecykQ9hGI6nV5acHUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021944; c=relaxed/simple;
	bh=t9zWNJzp4gvvwxfqFcFiM0BWltnjQXai7dOtNu6Culc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sS+1f77WNfwvfC8xdVHb52oG4HUKz/B4zy+biSdooEvOt1PCCJRL1nvtSGHCon1U2xpfENCHwBh4jqPsSYzKppJYlZXNy0bhEoNL0YxBozUxB79+wONNMkBri7lSxrA3CbGQr6Z5uPqCrHsUL2s/M5YB9fLACAiLMkL8W1R+8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y1Uva2w0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cT6V/i5B; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y1Uva2w0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cT6V/i5B"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F0F42540170;
	Mon,  3 Mar 2025 12:12:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 03 Mar 2025 12:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741021941;
	 x=1741108341; bh=hUtYiB8/HV+IwQnqkyFw97VKHhREtkhzmlSBNzp5018=; b=
	Y1Uva2w0wpC8vyAjwTA3T/JkKlqj+5CH9axfMSb6fSTvKvO8m+kcFdyPTd6qqyRc
	KJ6S/6QnyPulW3xGcgKPO5+pEEyj4abLsRPFw0yv+oIlz7XXC/n/jCoCYvRug59F
	OBUWlgOMh/NmrK1pahr4ss3mvMfzUDm7FPRzx5jF+eubNHjaDc49/7FdphLQCqaG
	zcR75LzXXoXVGJoiszQxoPSeIngS+BEck5BBDaYJXnYs+m2isZaTdWk4wv8Ui2FI
	Jmorkr3AeoUKVByxBgRmrSQ7zPpEQU7N2Ey/JsQPTkam5oqo1DnLgjNsjn11zhyP
	AzizFWAqi8zYpUCRK4A2hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741021941; x=
	1741108341; bh=hUtYiB8/HV+IwQnqkyFw97VKHhREtkhzmlSBNzp5018=; b=c
	T6V/i5B6B6wnL8Wvwe+mEV/PsmKkqrN28ARFeGYfpHvJty/7OrlsSwyp+mPpTPHi
	w0Bas6WVVhyOnLc/cUVjmY1XE2MDN9UVERBMJOMMhBXUcTtpmKjenurBqmumRfGC
	uj1K1qmP3zVIV4lEgTMAwoYTxXQIy+a6CeANKSsQST9WeYektNU06sC/DqNbe13a
	U86n1DuxaDcuVO6Ycbb7ymU3fDSgRfwO2d4hSWfkwD7J7XdsVvmV2jKm9fF6bja3
	iY2aRNsrfnnrIEGrVb9R/gNivWnq5cBqwEXPe8X+wZ2qMAqEc1c3GDVaiky6+LJu
	ex8kXgF/pJUX07GcGZyJg==
X-ME-Sender: <xms:9eLFZ0Q0A0IyyXEbGRJOdhP53UyTYw9ktcPTTztjk90O_dQjcFCKsg>
    <xme:9eLFZxx1-GpWBSOA99ApSguks-4rn8APbd780Mu8SLhWLACUWI-Sw94OXE0-UndqH
    uDvMXzA7L7atWGLCw>
X-ME-Received: <xmr:9eLFZx1dMfonMHVxF4xWKjFNC7fyk5jngwn-d7A6HcE7l3b-32zwXeiPwsc3FyujpiU5GiuKgCsbbJpTu_1iB4iXKs5GXMgzZHwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgthhgrtghonh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9eLFZ4AfTCI0EE7BWLnSCRu9oXCCOD_Ebo9f4kdrFSR9UYRoFediYA>
    <xmx:9eLFZ9gt-kS9U2_PectCSrrBUEtK5xmdCWX0P3xDSUA-HZyWjg-DoA>
    <xmx:9eLFZ0oxvDc3yi68KEzT71ignZmcwnSG8k_NqpRQqBTLFNtO1NF6Pg>
    <xmx:9eLFZwgKP95-aG3ZlGDfHSVBxRrFIOcLZI8DQH4XBg0X_qmweaeqdw>
    <xmx:9eLFZ7Z4wUf-4IPSQxizzqqPEKF1wKtqhC80272u5oNeB5mCIWLNp58S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 12:12:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>,  Scott Chacon via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: copy all bundle references ino the
 refs/bundle space
In-Reply-To: <CAP2yMa+YoxRaf48mS7mUbNnsfCm2Z=FT5Gohq_oWz0Q8XnH_eQ@mail.gmail.com>
	(Scott Chacon's message of "Sat, 1 Mar 2025 11:23:08 +0100")
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
	<xmqqv7sxki36.fsf@gitster.g>
	<3a180cca-0573-474a-8835-8015dbe09541@gmail.com>
	<CAP2yMa+YoxRaf48mS7mUbNnsfCm2Z=FT5Gohq_oWz0Q8XnH_eQ@mail.gmail.com>
Date: Mon, 03 Mar 2025 09:12:19 -0800
Message-ID: <xmqqfrjuvy18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Scott Chacon <schacon@gmail.com> writes:

> Hey,
>
> On Wed, Feb 26, 2025 at 12:36 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> The intention of the design is to avoid having the bundle URI fetch
>> changing tag refs, especially annotated tags. Those tag updates are
>> expected to be advertised in the "git fetch" output. It would probably
>> be best to peel the tag refs to a commit and then create a fake branch
>> for the bundle.

I am not sure where that need to avoid including tags comes from.

>> The biggest question I had (and tried to get ahead of on the PR) is
>> the use of a test to demonstrate what kind of bundle files cause this
>> issue. It would be important to demosntrate that the repo is still
>> usable if "refs/bundles/tags/v1.0" exists and points to a tag object.
>
> I have written a test and I'll submit the new series in a minute, but
> I'm not sure what you mean by 'usable' in this context. Is there a
> situation where Git gets mad if there are annotated tags that aren't
> under refs/tags?

I do not know of any at least for a local consumption of these tags.

> I have done these test clones and nothing bad seems to happen having
> them in refs/bundle/tags/v1.0 that I notice, but I don't know how to
> write a test that specifically verifies that.

Can it be some brittleness Derrick is worried about auto-following
of tags during future "git fetch"?  You store a tag that a regular
fetch may want to store at refs/tags/v1.0 in refs/bundles/tags/v1.0
taken from the bundle, and then a later fetch may advance the
history based on you extracted from the bundle---without having to
run an explicit "git fetch --tags" or "git fetch origin v1.0", would
we ever obtain "refs/tags/v1.0" with only the usual auto-following
when we have the same tag elsewhere?

In any case, instead of me speculating, I'd prefer to hear from
Derrick, who is a lot more familiar with the mechanism under
discussion, what the issues are that we want to limit ourselves to
local branches.

Thanks.
