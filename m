Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FF2DC32D
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055074; cv=none; b=CPBHTnUb5/COB580gDLLtfDcYvwVbdH5K3vx9cjyAv5e9DI5ifoAc0Ru8p0ftmNTrW1FFwRlxbZqL10KAk5W88WNIIpxlfZugdrA9GMpihpqoJ8o0cMSpkCVQnmq6175L8AptdSjcK6ymrR8upCfmjgdDExrX48pQ8F5rRUuMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055074; c=relaxed/simple;
	bh=XJxeaStoNICkTBMHiTEVULzZCBdQP+MidKlRuWL1reo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jn9LueYWHfZJxmZHsaptbt7flcm97bVCG3ak2RtewcvIIjg0eUX5xe6Ynphz5+raXKtA9AHxlEsCdUd/n4zyo8pXXlZjAcZM0RLzvTO8PRqAKeRzzErI5pnPD2Mxq8q31NOn1NU8eUdOWYFAu9ZBs9WMe0kvkFqKLDKywbrbadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J39ScIix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gO71Hl/k; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J39ScIix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gO71Hl/k"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD05E7A0098;
	Mon, 29 Dec 2025 19:37:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 29 Dec 2025 19:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767055067; x=1767141467; bh=H8gsWPE2A8
	TtWB/Y7nU7REMiazFCOrdC9sJnPelHfm0=; b=J39ScIix/e1+gRx2HLmDvayK5y
	oZVIJjiAd2YTmB/PMS/k0cawRJ058olMZKQIfAeKOMuJ203FLiTOdDsXVMutYmW/
	7WruRO6Ix72Fd0w2WuAjeWUI3hP6WIWt1OqA3i0Ytsz4QsULgK7XAHOPwPkcYJGT
	kVEikhmIhuHkDNrJBLs7LZ7h/a2FCkyu0q9oayso8nZ33fFy934a5g+L0ANIvNhy
	78EYIOK4QFxbmtzVWeG+S2CCksMOSq0uXzh/XA+HWFJQoH0nUwptZH5nXnkVHTok
	4cBI0qSKgt58oLMfAQufxKXvxe/KvgjFAkGtEQxlXlRAqP8hEfsJxmcgtmiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767055067; x=1767141467; bh=H8gsWPE2A8TtWB/Y7nU7REMiazFCOrdC9sJ
	nPelHfm0=; b=gO71Hl/keaq/0mxsPnoF+OcpRPqiDoYA2ApOdEpN19h9mJBnkXM
	k5B9eiFj5gH4bUky9+rIw7AlfTAy8w9okKQol6mQ1IroZ7PyNgdWvxWMEEn7duiL
	p7epBV7ONlYCoQh/8URtUOUmJI26CdfN5YQxYYbZo8NwNOMAs98pp8Rl5NJQmSSZ
	LvUh4cOgjG3U03LRjtLB+hRUGTdxyZgrvwrD99FNbkH8GX7Uf9yVF6e0uXblHywV
	Qoz5dxFDa5D7eTycFGGobWuhMYkDkC3LCSVKSBCqH8WtJCIRor0jkWkcCiHiYHR8
	PYwC83/nIRfMn+GPDo1AQay18ZI4ttrSJEw==
X-ME-Sender: <xms:2x5TafFtkyYuhdI2gARDWxGs0klwDpNyf8ul2pV454S3qh1T3OBE_w>
    <xme:2x5TaTUW55xks_VQsZNYskazJkY3mMKP2A0gPpf271bn3wf6C6xjBOm37FYhMdN9K
    Q7iIlFdnd72aKwOYNls0h_Z2Nqf0wQAx-uJDUBS6WVUGHBkzVHRhw>
X-ME-Received: <xmr:2x5TaWIgHkk05Ag4iTy5uKVGEm1xSywGY9W7jNr1z7KWgtd1ZsjTIeJN7LZW7kjIjEBp8C9nI8tIMc0__qWB56JWGLQEuALPNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtrhhovghlshesthhhohhmshgvnhdrihhopdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:2x5Tab_jY-IKFR5ju4sfrd5wBxWPx5v99jygGXkkQ2kbQKCK7ZvrKA>
    <xmx:2x5TaRLIembLLm3p6QAAZDS_pNExfrZDlB-OVqUQLVw2l7yv_Um3SQ>
    <xmx:2x5TaYmpNU2orbif364uetuQHb1b9dOCKtxRjUhRpt9JR2s1sgDejg>
    <xmx:2x5TadNYYbZxGN1Q8wpvVwgdEqWqUZW7Urky-rKtPRdA0KHh-JUsBg>
    <xmx:2x5TaUmW7mnWh-6DDt4f6VdPOGCvQrPd24eRsnAE4Oew_HAGXMY0fh6c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 19:37:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Troels Thomsen" <troels@thomsen.io>
Cc: "Troels Thomsen via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix crash on out-of-namespace symref
In-Reply-To: <a16bf8a6-2f57-4794-91b5-92615f184c4b@app.fastmail.com> (Troels
	Thomsen's message of "Sun, 28 Dec 2025 17:26:45 +0100")
References: <pull.2144.git.git.1766850014289.gitgitgadget@gmail.com>
	<xmqqfr8uk61i.fsf@gitster.g>
	<a16bf8a6-2f57-4794-91b5-92615f184c4b@app.fastmail.com>
Date: Tue, 30 Dec 2025 09:37:45 +0900
Message-ID: <xmqqbjjgiz3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Troels Thomsen" <troels@thomsen.io> writes:

> On Sun, Dec 28, 2025, at 15:57, Junio C Hamano wrote:
>
>> Fixing crash is certainly a good thing, but when the namespace is
>> segregated and receive-pack wants to get updates only within the
>> given namespace, would presence of such a cross namespace symref
>> cause updates outside the namespace through the symref, defeating
>> the point of setting up a namespace in the first place?
>>
>> I am not objecting to the new behaviour, but am not sure if it is a
>> sensible one.  You _might_ be able to argue that an attempt to update
>> underlying refs outside the namespace through such a symbolic ref
>> should result in an error (i.e., a fix to the current crashing
>> behaviour is to die in a controlled way).
>>
>> Thoughts?
>
> I think it's important that the symbolic ref needs to be explicitly
> created on the receiving side.

Yes, and that can cut both ways.  In an ideal world without any
end-users who make any mistakes, deliberate cross namespace symref
may be a handy feature to break out of the namespace jail on purpose
in a controlled way.

But if the symref was made to point across the namespace boundary by
mistake, catching it as a misconfiguration may be a crucial chance
the user has to prevent it from turning into a security incident.
And that is why I asked.
