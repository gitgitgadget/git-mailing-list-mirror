Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C663112C3
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558555; cv=none; b=GsLLCkwPw/ViB/jcrsn2DeOaT6hBa/d+G1PHpM0yS0ZhvmLEaQOZkWA7oAIZaEK5+fyXqTabW6C3/xbzCxXwC6MPes2MX3VkMVpZpErjJFIaiylhQ0Q77TyJBRdUS3gJBOrfs8IMchDvu9wTeIRinDz+4jNn0ZB5yJx13OqkhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558555; c=relaxed/simple;
	bh=npC848oWqTsloiF+SG0KkQVD5qNge101Boz4gTLGTSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p93w2vmYj8SQWtOFl66we9Vp35VB8KP3qpLTB+63QiGzHx4aej9sHeRLETyMv6ZsdXcEOo8AtgNJAjv/kUFmztGTupG4bv5mbwJhW7WeOG7pmAAe0BQRN1Q+3NydRhJw7//sEVmy7lH7RdggVNse15tVkKKZNTdPp32USpFUXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1keVCCsL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSpnBw/r; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1keVCCsL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSpnBw/r"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08F1B1400167;
	Mon, 22 Sep 2025 12:29:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 22 Sep 2025 12:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758558553; x=1758644953; bh=04eanJEZq7
	7qgI1aesXasO+f3OUmIUMkC9QTF1zlxR0=; b=1keVCCsLWt3Wa8JP5JUnv7aehS
	B0beJ370UnT0bB8jA/pluJVaXTeBGrNPBumGImNIsPILNK26PWKkQ/BdI+mBGAir
	at0ReIYr5yN5kFmFU/O/iPm0WiN92L5/dlVvUxA93B3a6w7g5FlKvsRIC13zz7eC
	lcQS90hIlIe7YEM8GcoTfUhY5YgisxDC+4Q/FW4dklD3/BWc4AsETC+gtltZWR4S
	54dge8/k6qXFw3iYMle3+wCG5Se67w2Hadn98DmBhSWtei8IrGRbh88Ambu7MdrV
	NGgP5Wd9X+C8u0F3FeGchP3bdsnOjhbOsoKgIhDirOBnIlHBgPVGqtj+Guow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758558553; x=1758644953; bh=04eanJEZq77qgI1aesXasO+f3OUmIUMkC9Q
	TF1zlxR0=; b=NSpnBw/rS81tOp12UVriDN7fjQp3WglD1qd15hYUOtCTv0pgiPr
	rIbXrb7aEkr7ymCJH7kGLFITR7l2vgZB71ewMaAWtblUiykgynJKYhCw49qUi8ib
	qWFlxPPdrQIxB3xh9c5pAj6zM0AoYAqXdEQNdFQ+x4qokQrRXoUtmQugNn5vbplM
	/B0rGxwBPmnKNGkxoKX+Hr5iCmwv75apOk4uIQjwa1UUnastkE7PxHxRQRaOpugF
	Ah/1eMwX8NYO+VwvDdBZxbsVhD/npX9LQ2sH4SW2t9K98B3A4p+DdtR0GmwyJg4T
	/nE2RT6fssbuaT2PLZTDushL9Z7ZBFVRd+w==
X-ME-Sender: <xms:WHnRaP74dR49e41EL5UL52keUNuxKb3Vn22IQhmFSGVZlkf5KUlA9Q>
    <xme:WHnRaLweRN9xu3NT-AbtfFn9sJ2LopZhvsXsmBsZFInhAQKhatM2p75XgXc5UsLBA
    gGK5Noubl0DeCqdfs37qEu_wdL_3dU1yMHs0kVgtopKSAPc2ugmx48>
X-ME-Received: <xmr:WHnRaOyQAESwrPl1BNcS9k1zHoan0PsJSy--EJQN0kxb-cxOfTheAD73kTUA13C3rqI6AIDAC-uuVAt7Gom0CQRl9yf2tExjttY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:WHnRaLzmoj0rPV3HT-xUuxPPz1sEQVB0gZRlON1KtKsdHTPQSBvJKg>
    <xmx:WHnRaAbjDoywaSOoc1yZugiE8EFdPGVqrPLJ3JheMl3Tzp-N-ixbBQ>
    <xmx:WHnRaEVn0oMwazznTym94OGlcTMfcSkTRmGEpGxTl05jLpa3kzv1Nw>
    <xmx:WHnRaGg-M4mpNxnOoqf6dum6F1SqSjEsDzdkd-TWtg1HvbDA5ifVWw>
    <xmx:WHnRaPCLojaga0z0P8yQ938ZKzO2HyAFngdC6yOj_IMAiyDH1GenzwlU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 12:29:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 4/5] builtin/config: special-case retrieving colors
 without a key
In-Reply-To: <aNFJanpSY8wd8-b1@pks.im> (Patrick Steinhardt's message of "Mon,
	22 Sep 2025 15:04:42 +0200")
References: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
	<20250918-pks-config-color-v3-4-08ea618cae26@pks.im>
	<xmqqikhg9rwx.fsf@gitster.g> <aNFJanpSY8wd8-b1@pks.im>
Date: Mon, 22 Sep 2025 09:29:11 -0700
Message-ID: <xmqqo6r2v4bs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> If we are willing to handle this as a special case anyway, I wonder
>> if it can easily be arranged to take this as a(nother) special case.
>> 
>>     $ git config get --type=color --default="reset"
>> 
>> I.e., instead of (or in addition to) "if the config key is empty",
>> special case "if the config key is not given", which may be slightly
>> more intuitive.
>> 
>> But even without it, what is presented is a vast improvement enough
>> ;-)
>
> We probably could, yeah. But it starts to become even weirder than it
> already is, so I'd honestly just leave it as-is for now :) I doubt that
> there's too many users out there that care about this anyway.

Yes, unless we can require "--default" to be spelled "--translate-this"
only in that specific use case (which we don't want to), the keyless
case would be even more strange than the empty key case, so I am
happy with what we see in this series.

Thanks.
