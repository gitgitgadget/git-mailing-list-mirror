Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43EB3BFE4B
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345528; cv=none; b=hT1dTeX73SNTygYj9/74bEdweOg4KN9mbNJ6wrg4NPWXKY89crTD5+/M4gUyu+zMR4rJDDP9ea70SYYpih26M6FD00eUBMv2W4hg9jkBgXxubrcGZdAdvNsL1L7aCAxIEQKE8z/tmLS0RypRVOUEnbAlVxpkbB7rm/nG7YYDjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345528; c=relaxed/simple;
	bh=qoALPdx1WNk+2t17eFMfljun16m9EVWduJZC/M2ydgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIafH++hfB4tCJkmPlzvaghjaK14Bl7lw2v4qdyf5cPg0a46xIK5aqOmm7eurgYLFv6ke/lUW0YlVJyaknv90qUZuhPm90/el5kEc8iG/x7x4GMIXESRxVPJFxSyuweb+b2Nr6cRkBDpExh6PUj1TNlCQ4bzeNvo77hciLbG1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HIO6/ijm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tAZwyfn0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HIO6/ijm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tAZwyfn0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DD9ECEC0AE2;
	Thu, 12 Mar 2026 15:58:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 15:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773345525; x=1773431925; bh=9ElXixXLxd
	NrTIIRurj5rvjJhP5IFj1WRLSo9bAy2TA=; b=HIO6/ijmadx+k9E+r3STXvKO6c
	CcaBgs22cAoHXK20t3kQ9yVFSda1NIjpOLo5WD51a12QUpHhv19Sdn0PEvnR9MBk
	V3RL/dPNxDbRky/S/SDgHt2uK30ELe+rcxQcx8VSRE6jfdgnNkxa79ZGmrXsILW4
	vmY+BazQx1UY+JhYIhZVYr/SinxaEKR57TCC6CBXlb219F5z5zyFb7trvWjWWPpx
	ILyxU4MTN8zSXM7cnSGzqongvFVRNFpqEXcBjwUN7BWPgwp+NpYKgXe7q3iqD63T
	Gmhz7Ii6q2yO4MpOVQ8EiPEILoYcmJm4IPKFYRwU24jHWSJgP1YVlNoNVniA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773345525; x=1773431925; bh=9ElXixXLxdNrTIIRurj5rvjJhP5IFj1WRLS
	o9bAy2TA=; b=tAZwyfn06wLu5OYwu7m9VX99KeFDpJOZDiJ/LO6vMw+nX5U50LG
	qind62EcBB+iCKiqB8Kk7ztDpR5N8wC/2Y3bFW2ztbDQSQAYvxnVERrRhbJNy3u/
	EIP4NsBoc6FCdGAiuHt36oXgqy77xAWHFWRSKIP6XBU11Mzd+FUrougOO8/Aqm5Q
	ODXxk4DVSRUFNRmJyGcnrfitQ2EVyCHe7BuwtS0T1+7arg3BiPlAEekoLVttqVYk
	8mRt7nhJU4EJPr2eXMEHu9QSXUsDavZrKLXlRYDb58ROeQTAjmRKZnqSxhFXCw59
	8T42VMlmrYhhNI0luVin6S1anoP5h07g+/Q==
X-ME-Sender: <xms:9Rqzab81GdSkLBIjrMjbjrww3JUDcLGgCmPRhv-bFIZI2jgOZn19ig>
    <xme:9RqzaYbqyLHoLbOMlZy3XnJi9FVRBubH2e9wxZpbPV87o8LH_Z5Zw83WIU8PgM2na
    MpgcSbkmFmVKJpdDboKHEtXTOz2XGlaV2F6Wm6N1ec3FOqSYRT4>
X-ME-Received: <xmr:9RqzaXMTfeTFiSPB9T_I8oKsYh62VYOrwg4diR-x6NNyGmLMncKIkEg-BmtyzF5AEbne2OHFYGzMH4GXZ8QJQBZ02FNU9U90xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtsehm
    rghlohhnrdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9RqzacD5C6OdL22keP4jbBHO8Ne0C3DkDjUxvaLhiBhD6pJnuLyM4g>
    <xmx:9RqzaWIyVl81yJXYGKWlFkfoOcSh33NsgHEFvKLLrTl72COBkhq6bw>
    <xmx:9RqzadN6uAWcPku3n61janZyxZ-_dkTTFlOOIl_2mXQI0reyf73XXg>
    <xmx:9Rqzac6b9vWOyegKk0sX1Ri2giO4OVJpnlnrwV584kWJqmo0hRdTJA>
    <xmx:9Rqzad5kToXocWWAiYVpzHENokeheotXp2ZjJq43tGZomHWzUl8aUZyR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 15:58:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v2] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <2c9861c0-fdac-4123-8cd9-4a841755abf3@malon.dev> (Tian Yuchen's
	message of "Fri, 13 Mar 2026 02:49:05 +0800")
References: <20260312164203.964033-1-cat@malon.dev>
	<xmqqsea5ezwl.fsf@gitster.g>
	<2c9861c0-fdac-4123-8cd9-4a841755abf3@malon.dev>
Date: Thu, 12 Mar 2026 12:58:43 -0700
Message-ID: <xmqqfr64es5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

>> As somebody (Phillip?) said earlier, we probably should update
>> document and clearly say that removing USE_THE_REPOSITORY_VARIABLE
>> is not a high-value target when done in the builtin/ directory, even
>> though it is very desirable thing to do for more library-ish part of
>> the codebase.
>
> I am fully aware of this, and I did not specifically modify 
> the_repository in builtin/ during previous patches. It's just that this 
> macro makes me particularly uncomfortable, and I believe it would be 
> better to remove it.
>
> On the other hand, this patch is indeed boring and useless. Feel free to 
> ignore it.

Nah, I think we do want to keep it; once it is written, it is a
waste to discard it, especially given that the change is not wrong
per-se.  If anything else, having it will save somebody else time
and effort to do the same thing again ;-).

Thanks.
