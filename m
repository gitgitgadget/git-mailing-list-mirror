Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6792D7DF5
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128691; cv=none; b=Vd8p4i3nn1oG6wrjez3x56TQUkQxUXSV7suCK9/HE/fmRUJg4N8B+R6ur5JfARD9ESLX/kIYqNL26K6l4sZRZajry0PIIjGPtax8hxSGp+n+vc8N6n2uwlqDrNDWWQG0MORS7WqVkaI+dOQOhb9vzS3CUDDVMi7u1EO2AJuYKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128691; c=relaxed/simple;
	bh=r5WVLQDcPC30raG9hMux6oVE4u6oqAPO3goMOUY3iqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGXIoZGku+YlPEzrSsCm5itipfWRhe3IO62a6B4E1+lwWcIVK8GMSJauZBZXWlBxShjQkLSLq4fsEgxBdBVN/5kcCSK9CXXSng6uld3U1uYBpeHkybkawfpNURm+M6e5YEwDzDrElNf8o0V7j6pO8zZ2RANDChSBYmj/IMdXqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lDFvufuZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYBdq0bz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lDFvufuZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYBdq0bz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CDA0EEC021D;
	Wed, 17 Sep 2025 13:04:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 13:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758128687; x=1758215087; bh=cl84CMiLrY
	y4jpAPpAbVRwxyXILKP+lMUzsyTDisOjY=; b=lDFvufuZsylxiD0jAlxaSP4EHy
	XLb6NJYQiObx5Mf5+xgc9a6AeTK+/CxlxnOd5wDuHWBKjnrP/cHiIbK9NUW6ta7U
	4FKC/oRjb3QDEi4Tjil2LUi0GadLS42geGBfvUCYIbjz8nbUtKvHvPX9bxmktDUx
	HaF+tKYlXOme8wVjpQ05K8zcRpVot1aiuIAUDNcZ56c1zF6gaCxJF3B+KezO2Dmo
	gjo59S+4Fv49UN3rd+apq95avIoy4ChYiOZJTp8gJ1kUUJOjxna4tfcjwUGrMk5f
	a70veeskhG/AGorN48NMdSYdoDuo1R+0zSYlx3vf8rywt+cr3AZIY2gGQKug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758128687; x=1758215087; bh=cl84CMiLrYy4jpAPpAbVRwxyXILKP+lMUzs
	yTDisOjY=; b=YYBdq0bzfhxRlF9L7dIaAFhNTNOdkax7M/+fyTSiistIMXUu8/T
	AUgJBlf4QWSysFcHsVpJoAqg/JvvRFQ6gTKbH/a5C8EiQlvGDwmqOzH+vpovMx7O
	mJj/NvVdCYRCt3m8HUpFdF7K0QQHO2x6jZWMAvzJA1HO8cFnWJDFCz3i01QVz9DY
	QpJ6liLRIO70UGV8AFxWdtCE4sfi/20XBLedB+FV2LzsHen7hz70/Rm8J3RlAeda
	CWxACnT9n6Tb/G3GASu6Hg/SxWtVjyw97xQALezeyXZRb2i+PcojFcPLIdI1+AS6
	8L91JOxH2My9VQjUNmBURBJiqBuPZS2W3Mg==
X-ME-Sender: <xms:L-rKaB3axUYlwTTL_CreCD-Un1H6bVD-_yezj96YAnoYGCRyp41wWA>
    <xme:L-rKaFrIMwiH2QaumkiUB7LtY7L5PADEETwqBcMDZpW9o4ZYesokzXWNk7jAWFf86
    swK_lrvndfPeRXiVA>
X-ME-Received: <xmr:L-rKaIWYtFHK3R92aRCikL5pscboi66Yi_S7rlobLFHDo-dAub5KESDM0tUxnrgp3t8Ua6jzlgbqtgFy8AIh_NhGqFyjxP6l8HlpWsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvrdgurhgvfiesihhnuggvgi
    gvgigthhgrnhhgvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:L-rKaAZDPUOVzJCpU3FusL9uofpoqWglzy58_EVhe0W0h6a2uq2K8Q>
    <xmx:L-rKaFdNIvv52KYcNg63hNdmZ_34lL1uU-7YT-Jqmt_nqpPIkDc3FQ>
    <xmx:L-rKaK1zJfEPlzTwXjZPS8ZzTb_xY8nDYIiOTgfhqmCnpVA51-XWBQ>
    <xmx:L-rKaMKpxIrGblM0HOrv3h3KV4OeZQKTBrWMs_cYkzfWKBonhRGolg>
    <xmx:L-rKaDucV6wg2CXQcKFCxnC06rWLQNjfmNk9u-TOrffBYfwZyM3on1dB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 13:04:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,
  joe.drew@indexexchange.com,  peff@peff.net,  ps@pks.im
Subject: Re: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
In-Reply-To: <CAOLa=ZSBpSyU0V08OBrr-QPrZPsYnO1bTZewESY=C7Jy4NTcWQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 17 Sep 2025 11:24:40 -0400")
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
	<20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
	<xmqqh5x2m5d3.fsf@gitster.g>
	<CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
	<874it1noh2.fsf@iotcl.com>
	<CAOLa=ZSBpSyU0V08OBrr-QPrZPsYnO1bTZewESY=C7Jy4NTcWQ@mail.gmail.com>
Date: Wed, 17 Sep 2025 10:04:45 -0700
Message-ID: <xmqqjz1xc8nm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> I've noticed another issue though, at the moment it's possible to create
>> a ref like `refs/heads/foo.Lock`. I can image this gives issue when the
>> remote has `refs/heads/foo` and `refs/heads/foo.Lock` and you pull those
>> in on a case-insensitive FS. Unfortunately I wasn't able to verify this.
>> But anyhow, I don't think that any reason to hold back on this current
>> patch series. I approve.
>
> We don't fetch locks from remote. The locking mechanism is simply a
> construct used to update files locally in race-free manner. Locking a
> file ensures no other concurrent writes can happen.

I am not Toon, but I think Toon meant "foo.Lock" to be a funnily
named but a valid branch the remote has.

Doesn't the remote advertise refs/heads/foo and refs/heads/foo.Lock
in such a case?  And we can ask for both of them.  When updating
foo, we would locally create "refs/heads/foo.lock" and then rename
it to refs/heads/foo", right?  I think Toon's point was what happens
when the fetch of "foo.Lock" from there somehow has completed first.
Or we can simply fetch foo.Lock branch and then foo branch in a
separate invocation of "git fetch"---now wouldn't the second
invocation have trouble creating the lock file foo.lock for foo on
certain filesystems?

> In-short when you fetch references, the prepare stage of the reference
> transaction will create the necessary lock files. This locks in the
> updates with guarantee that no other process can update/create the refs.
> The commit phase simply removes the lock files post updating the refs.
