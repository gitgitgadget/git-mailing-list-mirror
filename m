Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7B157493
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934648; cv=none; b=ps0nfBcRZ6Hfx2qMs4vJmXINAy7o2N8Do30miu0u1aUlQlKBvoVC0BoUVJWhxma/glSflrHFyKUFc3kjV7cuUzvvVetyoctDVUtbfY3UeBUU7YGpxyWv5FP9lTvj+7xTy+C6YftOTLT8vOuM87L6CakQRJCEZa8GD+GkCC+VjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934648; c=relaxed/simple;
	bh=x40lZR0epLmRzq2JMX5u4cL4Nr93w5P1t8pI5c5q7AY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jag2DidJXOuhOAsUBxwoHOo67mc8qUsMpld5PLb8IRR6EXkqE5j8G5Fo+EEFkOCU7Y01VXMEwu4ni1yUSUpkUJupzw2MVmSp9bxrFXhcRF1FmOFVIUn0V4bz7VP0cBh/2NzLc1+OjVSg8cEd0qU+9q3KkC4+eQLUJiZO0FHcAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DEygnXa7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvPWkf4C; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DEygnXa7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvPWkf4C"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 93581EC004E;
	Fri, 31 Oct 2025 14:17:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 14:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761934645; x=1762021045; bh=54nfEgvQSy
	SDu9RQb8GisBeyODKqZlXtaxsf1S4n9AI=; b=DEygnXa7e7klyFZD2VwbNXtcKO
	KiCBLqE+emrO15z/FSw+33JmAdylVop+pZjC5slNXUhVU6beYvZmiIhFjIXJzbEb
	7oXxuYVuyOVy/P6ygv47aESTMttkP++hP5B9iuIfyS4aVDcy6pn3C2MpfzU387EF
	rnxr4/Acskx8cEinU2x6k5uvZFbhS6lEEI4Bf5Gi6wb834Dm62ypVEvDmcaxwYGJ
	kzsGbX1m9ZM4Nvhst2F7zweBL27a5DEX+gDVfqOynLBkb6l+AlXyNY9Udu/bSo0N
	cdsL62jhyzWQ/MD+bIfGb4NUJRfVplNxdajeCII8PSe7qISZX5yDkKzyaGcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761934645; x=1762021045; bh=54nfEgvQSySDu9RQb8GisBeyODKqZlXtaxs
	f1S4n9AI=; b=XvPWkf4CbVfIrlDcXtt1XqW1o8kDWRSiaK71x8yhJO+nWvkIbhl
	AjOfkNlneT8lnoauicHYepINxUlRNqCI9FgdFCONZZ4Iekq++arlVTG7pOEZZC65
	/ZaNTgdrgTk5e6MB5jp0TuGlcRQ18qDjAzs2czWctxACdiKlXxkwQbrDgkiPFJJp
	tibRRrVfvzcs4V8WyZGTv77ixcQPpgL3NxiY9vK8QUD/mYo4jQ+AlZTm5x1ZNlNc
	KjYqEczlOM5zBGkCLCBXm/Kp+ZP5+7f4CRGROBNMQpLnQ/Ynln/jBVbkPyS4h8bh
	klUh8nv7FEyltUnAmPT80K3XjMWSX6D8b9Q==
X-ME-Sender: <xms:Nf0EaWstPDNwIRpx8Ho-Nun7JA2oasJE9vg5pDY52hjA5-ugA2wF9A>
    <xme:Nf0EaSc5QO3Hf21GnRHjUEh_VGLOZIdYEf2JFTWeK9b3y5x7Mg4n186oCtNNsne5Z
    xrwFJlRxjVh3RXMxQBdjCmfC6RGtZtOu1G7JCRSOBf51-TSNXqQeDA>
X-ME-Received: <xmr:Nf0EaWxtj6fePWJGRw48B1CFAnY0k0RvtT0Ahs0UzORhBb2LKtvtVE3y1OxlZkDMKYjRFGsRx69UzRdX8dCqm8BX2Jjy1MwLwK_V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:Nf0EaQGtEJWYco6ST5DP_w7Zmh0eLQ8wTW4jyoW-YovVgBegNnPD3Q>
    <xmx:Nf0EaSzFtXt1UT878VRn0xLay_JknLn-fcRR4qaVBBoJGOFkG1v-_w>
    <xmx:Nf0EaZvJsDYy67XTuI8kiOLa5aMwpnf_WKVMtD3yBR_Z4q0-73xypw>
    <xmx:Nf0EaX0sNuuVt-iW3PurY_x73ss-xUHtbX0R9Q3F1U-YWl3HRAzh6Q>
    <xmx:Nf0EaaQSzR22E96LfqC28s88cBhTPRQlkAIY1k6yDSedBAuvoHlrSoxE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 14:17:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] reftable/stack: add function to check if
 optimization is required
In-Reply-To: <tdgxvocyp2armupgbti2wnbjphdvidooddbdyrynmdokjgqr3o@tzrbu5lcgipt>
	(Justin Tobler's message of "Fri, 31 Oct 2025 12:02:25 -0500")
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
	<20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>
	<tdgxvocyp2armupgbti2wnbjphdvidooddbdyrynmdokjgqr3o@tzrbu5lcgipt>
Date: Fri, 31 Oct 2025 11:17:23 -0700
Message-ID: <xmqqseez0wcs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>> +	err = stack_segments_for_compaction(st, &seg);
>> +	if (err)
>> +		return err;
>> +
>> +	*required = segment_size(&seg) > 0;
>
> As mentioned on the previous patch, I wonder if we could just return the
> number of tables in the compaction segment as part of
> `stack_segments_for_compaction()`. A negative value could indicate an
> error. All other values would reflect the number of tables to be
> compacted.
>
> This way callers interested in whether compaction should be performed
> could just do: stack_segments_for_compaction > 0. We could maybe avoid
> having a separate function like we do here and just expose
> `stack_segments_for_compaction()`.

Is the cost of compacting a single table expected to be roughly the
same across tables?  The number of tables to be compacted would not
be a useful information to help making a better decision otherwise,
so I am guessing that it is the underlying assumption the above
suggestion comes from.

