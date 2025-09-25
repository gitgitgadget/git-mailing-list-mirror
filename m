Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B03191C9
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825368; cv=none; b=fhoCpYwReNSv9q0w+ui9FzjF+ArQme4yGVOsVOps7+bFC5I2ml2zcKiSR8UIuQoHAewKEPz0/ZwsNSMgM8xQBHiAzUslzV+yRXGXIngeCocJun2HSI37OUWIDUtEwR82TUH9uX4BPsTdt3yMkevO3DLjdjRgHivXo17/ZnHT3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825368; c=relaxed/simple;
	bh=QNy2LumQnng13yz2/+Wvnmdp7euD13JknlUJg2h/Yqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pxwyp1kLc0YpOEFteZElem+v3YeY4jg5oQbqeDwJLM8KJvxPd6yi4T3gs7x3e2mODzdOnaGnX5niG3BOt+QdaNV7oC88xDytpE+UPNkGl76g6cXUiwLumS1xWt+C2bCM5B463WbZWT9swFkgX4NzV3luxQA0rILdcLCLVTuajFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mv7AQtYU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cIJHvwEf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mv7AQtYU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cIJHvwEf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2797D14000A7;
	Thu, 25 Sep 2025 14:36:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 14:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758825365; x=1758911765; bh=SfvOFc2VXH
	ZxnOZ3LkSVHrmZ3jRtyeKt9ANEa/clSnQ=; b=mv7AQtYUjGSeEqKsTbCxxF6ctD
	SwylIFg4++QSv44WfvJO+IQ6ZZAuImgP9vBWypPog5a3ZXKwhFnrhbBlHPYc2QWQ
	pssS01Ru8PlqT1iIF4taw7I/nEo0XRpwUxcKtmu9+HYVc4pQpyY/gdRzn93mZoXP
	QHwhTdEUulgfaNLB5kjue0uSdSOHNFtXJExKWiPEm6j5UYveb0PgGYkkKCPAUSRa
	y+iSl8gnYRfTuR85dA+3kBkA9vPsiQrn0sWdUVaat1ghw6NK86VsizRiva4PwpNS
	Mta3H52BF4GLJv9Q0vg3Btc4uDeKzfg397sQDuwDsNFELrcoJOnnenfugCLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758825365; x=1758911765; bh=SfvOFc2VXHZxnOZ3LkSVHrmZ3jRtyeKt9AN
	Ea/clSnQ=; b=cIJHvwEf2XB0dmWvpokr0figEgoTqydftmBLO2Io+H1H+v26l4c
	4znHePskZ9/wsYDyRNJWJStauwWbSTzszIaDCYfrqCP4Ys2W8q0ROCDSFfpdLa0r
	DAM8oH0cExUB7R/7nf8rzjRSQlGWfhFjNsJQ9035ol5/em+etOMR82NLF/rkDGo/
	Ob+uOU5O4ngBiNEshCcVR0Lr5cGChC1oNehBadlByMs9jnuInRLcqF19k3IOZkTz
	gVaZdfp3sH43JlWvGotHfUMY/6bBgE0ay5e+nFK7cFneuI/v3UdwfcPIfquA5VWx
	B4mNP2MYKMIYTLMlffqrOmD5eIySIycXDDA==
X-ME-Sender: <xms:lIvVaN4C-tEu1chUAHvmgTa_PLfVZUTN8ekvNxBhW1xqQW4Q7L0pCw>
    <xme:lIvVaB5t3ZGEeGOy4sf9A8JolU6PNCgDcV-svhMQb6cPtVd-_cJiLb19JsvCLQuAa
    rl6YpWNbjNBbI8UaYPy2aQz0FbU7vHeNNmlVmmbpzsE8LFsGrbtLpA>
X-ME-Received: <xmr:lIvVaJd34hRaNVpi0V_WvFIFRET90uDZb6V_AELpkwZeUo_aAtrulPMzMMYtdBZrqm4ryzZg0fTyamTB3RH4YsI3SBA5DjTFlDG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtg
    homhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lIvVaFCjMmYHPsFhQ1lft6bHeEoyD__SCYZEYjZdPd6zISgwUAvocw>
    <xmx:lIvVaM-eSp04R3NByYpMsVSvtxcAacSjvRe-0qpdLDhpF2Oth7b2_Q>
    <xmx:lIvVaALm3TpUDH8X71vIyR5HbQtrJhxAZrjTEfmj_6FGK4OkxYSktQ>
    <xmx:lIvVaFjO47qpWrolykSiawCXE_12o9q4QdOakByKr8ZBMwzWJd9_Xg>
    <xmx:lYvVaFq0rejX12AHaPMzA2rYeFdVNoU2MDWBpgH3gomlPXXR9qtVetx4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 14:36:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  <git@vger.kernel.org>
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
In-Reply-To: <de75e7f3-6c59-4f62-8d11-dea33804cc59@intel.com> (Jacob Keller's
	message of "Thu, 25 Sep 2025 10:17:54 -0700")
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
	<xmqqa52jjxyq.fsf@gitster.g> <xmqq5xd7jxpq.fsf@gitster.g>
	<de75e7f3-6c59-4f62-8d11-dea33804cc59@intel.com>
Date: Thu, 25 Sep 2025 11:36:03 -0700
Message-ID: <xmqqy0q2fkh8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

>> Now I did, and my speculations were both correct.  The SANITIZE=leak
>> build fails, and with these two releases the test passes.
>> 
>> You can squash this in, or I can do so myself if you like, if this
>> is the only change that is required.

Will do.  Thanks.
