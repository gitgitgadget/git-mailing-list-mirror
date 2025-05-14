Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78EE1F4634
	for <git@vger.kernel.org>; Wed, 14 May 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249252; cv=none; b=QLLhl4WfaCiKqENJcVjjAZR21KyvfYNKz7jMx6ED1LSRnHRfgNJWsSrlFBOB5Z34Pv/CQ9lpHudOL9C1jwCrs4oHRr92LKxHePtQdJgVUIY494O7hzSZQ6CXq+LzxcrARIjOq3NSaZfQCUCHQkYcSY5ek6kyUDEkFcaUHcsw98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249252; c=relaxed/simple;
	bh=K0YSbO/UsDjg+MAL0w6PmBAF9MPYjj5s4q0HTfsvHZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vAqsAqioLKypihOOGxYWg2+R/NiCEiJytMhxu30YvhIalgaq/RlNMAW2NpYi8bfw2nbxqPJGho+wxik/24bFHSqTbsoCtG6s8q4oLkuR/Q/BTBZMttPlA5wbfdppq277i4wK44KkU4UWgVrERzaFePJ07ROUEJ3bkxzve4y0Gog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OeCWWmSF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVIHcE7l; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OeCWWmSF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVIHcE7l"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8B9D254011C;
	Wed, 14 May 2025 15:00:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 May 2025 15:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747249248; x=1747335648; bh=cA5fP39gzh
	zuVHOpNYSUYiRaa8BtwGSU9pe1S6vQFPU=; b=OeCWWmSFVI2Exb1siFw5admXD9
	ZPADktbYf7AfHVSkO313K9n7SQSXYge2eCuo8MsqlY/aG2qskHQUR4mpjffjLnnb
	DzlMg1A37jp8TaBGLsvP2BwJB72zGQCX4C4E6XTKdZV0D5Uy9upHK8/k6w7mUxeY
	aRxZe+dX8rb4OAp+XaGRxRb8Zfdzc3D9MuRvZ/X6oXuNA6JxWV5AWl/1ravCSt17
	EGs2IqdCVYKYyHPWzMhkrVGqW8iK6TZyFhKZAVdQJBqVoAheGcYGxCFP+OJdajBb
	qsMiU287Jr1o1zmLpNmMCTThEB9O6gWqsDdkg+dKnAZzv+5SgOIpWKsz2fHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747249248; x=1747335648; bh=cA5fP39gzhzuVHOpNYSUYiRaa8BtwGSU9pe
	1S6vQFPU=; b=DVIHcE7lWaF8TkXgFhDg6B+D6b7b0ASpW/fxKf+GEYxOzBDQ9oM
	zPVc8UCyI+CshEEaseBqjC1ZSFFOdp9GJiNVdovyWKXc6A/ibjLBxj5ySb1AEltz
	lqyzeSViPuzOuu8tF/rVLgtYVxyLF7YXhHg4U8Mwy8pMuoSFMv1jAldXd7sXCyHW
	uPJ5y5C+3GBgbhtBXPB2LeDC4Ru1HvsyPIYlM5qPNy4VhwuVqu71PXjm2iEsQ1LN
	R0s5Pc/EYtfv9NiX6gOeGLN9y1lU+pg+quIIzI/aHRLjj6H0oWOVCD21n4xTWtw1
	T2Uuuo/UKhUQPze4y9I2O5/4jvA7keld53A==
X-ME-Sender: <xms:X-gkaEU8zLqhKeN550L_t6Q4TK-c-F6hS6z98HmV20ta0uLhYR7AAw>
    <xme:X-gkaInDrbTdM6PikCC3AZ2lvXwi49sM0KHjYc5x7sf_NWZT5412UVaed6_nspwTm
    AR2Xz7mpvOgvehl8g>
X-ME-Received: <xmr:X-gkaIavVRM-f118y65vL0m2Tt4n-VnzEmTjDCQ74SX30kLK4XTdOxvxI63uC4O8_aptkd1AYJ5NposVjQ5s4TBmYHsBlukE5_PQTLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X-gkaDWMmX8KEYLJwjZpmRXkNIboXA2fw-aB6H8G_6VwkuvCyEBPBQ>
    <xmx:X-gkaOkUeLtOlym58rDdNLC2Zv142QNkof5epSTWUSOgp7nDV_y7Vg>
    <xmx:X-gkaIfZnIpKXZYn2xw4KchXMtHosuEkHC615O-Vl7gi4wwoXRZWaA>
    <xmx:X-gkaAF6Sf1Me3J8sNvPP8brb6UwM2Fr2aWvTq8K3PKAz5hxAJnneA>
    <xmx:YOgkaO-m9-WNfuuDdK-84OC2CFlkhcc6aUjKLltS8yU_8R_UX9zl65sO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 15:00:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com
Subject: Re: [PATCH 3/3] receive-pack: use batched reference updates
In-Reply-To: <aCSNDbUX-MMJZj5S@pks.im> (Patrick Steinhardt's message of "Wed,
	14 May 2025 14:31:09 +0200")
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
	<20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-3-7c65f46493d4@gmail.com>
	<aCSNDbUX-MMJZj5S@pks.im>
Date: Wed, 14 May 2025 12:00:45 -0700
Message-ID: <xmqqecwr9fvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	switch (err) {
>> +	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
>> +		reason = "refname conflict";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
>> +		reason = "reference already exists";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
>> +		reason = "reference does not exist";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
>> +		reason = "incorrect old value provided";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
>> +		reason = "invalid new value provided";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
>> +		reason = "expected symref but found regular ref";
>> +		break;
>> +	default:
>> +		reason = "unkown failure";
>> +	}
>> +
>> +	strmap_put(failed_refs, refname, xstrdup(reason));
>> +}
>
> I'd have expected something like this for git-fetch(1), as well, so that
> we don't silently swallow failed ref updates. Would it make sense to
> maybe provide an array of reasons by enum so that we can reuse those
> messages?

Excellent.  It does not have to be an array, but a helper function
that takes an enum and returns a "const char *".
