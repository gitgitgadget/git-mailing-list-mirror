Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F391509AB
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 05:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771823406; cv=none; b=opwXcg+HJuK4XXIc0awoWxs2d4A77KHjQrhDzroebC4jRtL14BOAaeQiHf+wGjCHpxyQQiiVNSPJAlgCWK1txDRP9CE2P5D+sXx+WzTR5CC/ovqnXXr7HW3jvf8vONMPkKi8B6OZBnUqJcK8u65fIiF/FenbFSGi3yfK9VUe/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771823406; c=relaxed/simple;
	bh=7WLulpkSU/TrdS+Zsg9Y/pAYuUA/4x6Pfp5oxcsJRv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cDWA/GjBpieAP/X1C4bR4MRtvlEQR+1pPuWA/E2uZzsM0JpTLzm+zgz8l69llRWWSTe8+Awp2TnYqzjITNcJZiD5HhPHW6Augd7a766L31asfzKz66XlNr5XCUtBaznJuw3MjeL9IEduaOfv8xhixsbDhOBr9w3fWGwYIzRg6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aOhAofOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwCJVb4q; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aOhAofOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwCJVb4q"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE4731400108;
	Mon, 23 Feb 2026 00:10:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 00:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771823404; x=1771909804; bh=auH3nFxJXW
	3mUKO9FEr4nOA1UurelH8/GyHQ7BjHA3U=; b=aOhAofOjhnmGzng3NCXw9dXvXO
	YUAvIZ0uYAz9/ikzkktcRo8bMH5tj87jr5vfIvRHQ6RgBq8gyw+y2syyxC3wmrHz
	apcRwXBjalLXaxq1wcR025nP+hMWQVSnxMNQFVVRQJTZOSjrUQo6uBjb6RP88Acm
	y4kFG+WumSi0Xt3qs80dhlBfc6Ly6m2LSVJEzGZ2DP7ZYfLIf10FhWWRDU+uH7u6
	Wmcs0C9nVjKfE8P7Jmf4hgHPovCPdutGlQy7NldVmnZBdCz4SSsRcGC6b+gFdIW8
	AwRhSfPTBcqtPRSG2/yN0K3sWE/2cSz2GjDEjDlGJr6uy+9fC1dzIK4VBkgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771823404; x=1771909804; bh=auH3nFxJXW3mUKO9FEr4nOA1UurelH8/GyH
	Q7BjHA3U=; b=gwCJVb4qQHjq0fCh7a45sUG50NAjdgfdGvu0sGjDp3usFS23/Sy
	YdlelCES56fDvWZYWm1x5lJ7LMSvtIOzhOINENEMtbl2CZ2gJaiuqde7QvSEvaYI
	PPKW3ReSCzkyQhkKMNLA+AEO4ywU6imOUfha5eE7nKuzf1FN6e7di+erSk2dacMo
	RBD2XA9AHK2ryNgBJJeqAwPJHWhJbjzFtek6NY4wMF862jWTrXTiKZ/FBftNFauu
	O4X/APRbtZFZyAqlvE/BX9SCGpliRme8gGU0nWfKo5ZMrckkWKT1t8IrYwEaP7yT
	9TSvAG2EzaKWnEQ8Q46Ud8Zc3dOXgJR+kYw==
X-ME-Sender: <xms:LOGbaYmVNtMscreyW0Kmr6E50UE60zWCMFUB7o1NHDATQ7hM431Nzg>
    <xme:LOGbae2BEQQBg9dCa898_7g2AAM0Fc-NfTH5JoxgNlZaAvOCCupC7uaLyb4YCM-rq
    ssFlNaxE46PJOgz7-xXBC8PspLCUC3bUEVm2zdVFWKa9Mnl8Vidpg>
X-ME-Received: <xmr:LOGbabpNlTBytc3NBILYaHzz1u9QMlP47l2Ov95w0vSt-eaE_vLl0wiqwjz-gVsY-EbTNTnlkHhYNy60xDjBNcz6kmuGDMdogg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeifeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LOGbaTdC_59l2XdMOop-dWgVl-CbiZC5TD-p2KIi0zrLZdNgZulKBQ>
    <xmx:LOGbaSrRId8E-dgbHx0JkuYpZrD_xjEHppYH7sNPvNbBVCnb_unnmg>
    <xmx:LOGbacEYoPADbJrLZpclYm1He21M2L1ulwMlxSVpa0GYjJ4nCyI_DQ>
    <xmx:LOGbaasDPwLt3qgFYq5KeHpAMxeKSU_KncRQcWFfFeYeawvLG4y7GQ>
    <xmx:LOGbaXIgwwd8AKD_qlkvhSWk7_OO4rERopiIMtXlp-5y5BYGySrNEvkT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 00:10:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
In-Reply-To: <5263825f-163c-43af-bac7-152d670919d9@gmail.com> (Tian Yuchen's
	message of "Mon, 23 Feb 2026 11:35:46 +0800")
References: <20260221083001.220061-1-a3205153416@gmail.com>
	<20260222102928.377519-1-a3205153416@gmail.com>
	<xmqq4in8quxn.fsf@gitster.g> <xmqqqzqcpatz.fsf@gitster.g>
	<5263825f-163c-43af-bac7-152d670919d9@gmail.com>
Date: Sun, 22 Feb 2026 21:10:01 -0800
Message-ID: <xmqqfr6soxjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> I must admit I hadn't considered this edge case at all. Thank you for 
> pointing it out :]

It is easy to see, if you run the tests, though ;-)

> I will:
>   - squash your diff into my patch
>   - rename the error code to `READ_GITFILE_ERR_STAT_MISSING`

I think MISSING is more appropriate than STAT_MISSING.  Our stat(2)
call positively identified that the given path does not exist on the
filesystem.

>   - combine this with the commit message refinements and test cleanups 
> suggested by Karthik in the previous thread.

Yeah, cleaning after yourselves in the tests is a good idea.
