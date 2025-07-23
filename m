Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F52F5B
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289326; cv=none; b=HVVCKKKNhPB00iIRqWZF8yktTpPrhx2lZ1PT6Nh7De97Fw1rtogkYyM0CXzMe93eB6BeFc3H7SaPpVriqUEh5YMVrjy7Q/j3WR/wmzdPecz6TJAI/8dHeNa3BLkMYh7cGYcvPbGFrtWz//pgJYZZvp18VgcDtkn6686N9kYEhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289326; c=relaxed/simple;
	bh=K8mOI8y1dHvK4aR1o2bBtN2d5DC9mv3qv5exCRLlq4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fD35EUQz+09m4/0n9CZet99UVyUDi/zj7hmbfOruXCnBEc23cvGaSz5MsfbNo4AgBDBbn6N//rAa70k+y7qVVjBzlcATpBO53BPHOcei46z6HN5xCZKOLSvDZVjO5OdJcHW8FBRHmM26PeLy9pHqei+o5PYwist7tLC3BQUY6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qRV/naAW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hd/XTCXn; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qRV/naAW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hd/XTCXn"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 66AB2EC0B92;
	Wed, 23 Jul 2025 12:48:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 12:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753289323; x=1753375723; bh=Yr4X3d4Umf
	+/z/sk4nZHnIx1K4P9gIU2VsMbzx2g5jI=; b=qRV/naAWk10tz0oz/ybzurqyOh
	em+wqhC+WY15VQs1vdurvIUlx4aGo9kI/kbB7j7/Y2CidHgfBqsbSnSNoYixw5e3
	XWhp5LECDeWZW5G6VBzncTmrlLbYKNSs/7N7400pPTdUW+IUXkmo11dPII2xnYyn
	wJPrgQ3PocmjZ3OxgdIkIjTks7SK0CQQEdT9h9b7vaH8KD5VxfEcdqs9edttwcoe
	O5aJVZWtx72e1kENYzA8NQbAoXF8A4cKbJ5GM+xLm2WaOFx9nGMSZhMteVCWR+Yl
	7Yyph1Jpf7iemU43VaLe2iOxVeUbqYJ3NcGfPg4tnogkZLRN4/ohFUqZCavw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753289323; x=1753375723; bh=Yr4X3d4Umf+/z/sk4nZHnIx1K4P9gIU2VsM
	bzx2g5jI=; b=Hd/XTCXn6SNah79TxaaIYdU/oaAu9TjDI22zl3Pm8k0+4YRdXZG
	G4m0NO5dpa4n64EmhY/SJSNwuQ0anPor+xTCz+8m/mKHE0bwV6g+JyLQgnjKbu7L
	kK+LStvHanUn8vm2VUIu9YnqylzH1Bwy6PYbYZJGDE7Kk2MdahAj4mPY0iROxGD0
	q3VZ4199mTh2v9HyS1GDYV7Z5aylAse0E24h25GZf9rLu/fPdpc/Qg/CLBPsDunZ
	bxTNEuEVRZXOnn7jsT7FhxVe54aCRst6sRmuY6/va75K8s4ZSeXQqNhm7Z/K1l4u
	u9BMa4Bk+AfYWCQW6x5qSx5giamKNw7YFzQ==
X-ME-Sender: <xms:axKBaEvM2E-E5IcY6WfnXDsuGh4FnakcpIjJnNu9JLPKaQUVVD1R2w>
    <xme:axKBaM_wEMnRdtgU-XFxqidGnyfQJwgqjqiSPk58hYV1s0PmkROsuEo6vLfQ0ghAx
    Ac4O0LXnEqsGfOM_w>
X-ME-Received: <xmr:axKBaGOsBds0vCWZSdsHwEfatMVObNl3b4RnVmDF-Irv01cKu2UQuygsreWI-KJSO1q9C5lX9IlMrZ_GWWTTC1cMf6CpMk99fMcFHoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehlhhihfihk
    ugdvvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:axKBaCEVpVTxpE_3wPsv6ALyfD1HJYpwEsaG-oazDVubF9uXROUAYA>
    <xmx:axKBaMT-rXe6DijoWJ2od-HdtuhtAZtQpQZ3IadQO9r6dXYa3r-DOQ>
    <xmx:axKBaHvZ4nKJSWYzmT7LSAXFN0YeZMkrHkBuSaWYLdC9l6sruxaHAA>
    <xmx:axKBaMJc0Nj8Ct_SZS6nxzuQ3gOWattcMW5k9LlQzftt3gRUdJnbdA>
    <xmx:axKBaLcrIRVN_nOm1t3F_ImZjQA1TkI9FUolSmV6kiQzLRvOImoXwFTC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 12:48:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Hoyoung Lee
 <lhywkd22@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
In-Reply-To: <20250723075513.GA570540@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 23 Jul 2025 03:55:13 -0400")
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
	<20250722174102.1876197-3-lhywkd22@gmail.com>
	<CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
	<20250723075513.GA570540@coredump.intra.peff.net>
Date: Wed, 23 Jul 2025 09:48:41 -0700
Message-ID: <xmqqwm7yonti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I dunno. We are reaching diminishing returns spending brainpower on a
> function that is meant to be somewhat quick-and-dirty.

True.  After all, the function is ready to exit and have the system
close the file descriptor anyway ;-)
