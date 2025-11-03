Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBDA11CBA
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186552; cv=none; b=t73nte9YYedgd2gDc776/9U1ASyU2xWE92EI1YRDIk0YimZ4VXGvNWOMHqia02KKaiUJAPZsC95rObdGZsG6G3PPPv18mT9NpP1gOnlUudcmiru2PPx2YkipEQWF7+5p/i+DZj6Ip0HdS06Z4/flMD+Cdk78ReyVy1MePmrR768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186552; c=relaxed/simple;
	bh=EXz/NRui8rynaNFMCGuoT7Zw4hgPYM52M5G6OrPaDz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSP6efKf0zFCmJike5tFPK4hRXlulmynQJ4grIAEcOi7jGKhukt0Bcz2oDpr44qgf1ju0zvvH+MoqYhiaxYlroVEesMLoz6lp1NPh9aYKTTj3xQsvcHue7J3qMV9CMwpLy/+Fr0uFNO76aSlqxFSvRXM9VWFNyvZJ75j53yxdmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hpfbQ/9C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v0D/l9dA; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hpfbQ/9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0D/l9dA"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CF8F01D002BC;
	Mon,  3 Nov 2025 11:15:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 03 Nov 2025 11:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762186549; x=1762272949; bh=v/FzDPiv/b
	CZmGaNp/BcyjsIZYoFBKUT76tUVfDHOEA=; b=hpfbQ/9CVSHbrgLA1nkqaeYL15
	f17hO+Sv+UMT4TrNSCB1aP18yfrW0YwE+7EZ0d5aeK7N/u6u6zLrj/9BVE4rcqq6
	HwyDEDMsIEe7SY0nw5AUdexjDOa0rhxQIL79pPoT7SOympBMBtIfhOO0quWiJT+x
	7lbDkuaESzku587YNAjUFbhpkpqH+vTgwYsPEVIB+12dMb53OErTKVzT7gW31cjA
	dwR1mpVIBoFhTzLJ0SOlL+CMtMbXR4KN3Brudf95kPLWZzif/C87A7C0U7D0a0/Z
	QWBvjZsTGQltsJIOSs65sCD0CBhjBvJ3kWD6CRQkaGbX93dsXH2CiPRxPNCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762186549; x=1762272949; bh=v/FzDPiv/bCZmGaNp/BcyjsIZYoFBKUT76t
	UVfDHOEA=; b=v0D/l9dAsgupLla6Ai6uasTm3OkxuHDdTC1xyKUaXFO20li9vUO
	bJ69oJAgDDwM2C7QISfgOjwPe6N1sQQQ4n+osmddumYaJrxQPcBW9Zg/JvaV+/1T
	LcLelWdEQOO/dTrry9LhbrTZNUSB62XhFuBTxrtwtPj+iBXWMOnh0ExescRRj1qL
	S50yX9hzBrGZN6SQwH6iD4Jal3w+KAuoWK0gHf2lNbwkWz9zLQg9k38sh1Fh1ABA
	bdMBn2bGQwL61Tzap9FSgqN2JyD1JfegW97nSA9qAVtDLJ14AkByt2+Vav2nJKTi
	o7av9nbKIfkXyU3ZUUMJN3NAUcZzw9XOzBw==
X-ME-Sender: <xms:NdUIaWSkjmfR5tNR-tTpVmO5aYWmNWVaf8EhAyZTqE4984a1ic6L4w>
    <xme:NdUIafcXD3s7vL8NQfxm8DhXi-mDYRBcu5sJ0vhIOf0UEIgUWuMIhP18ABu_Bkvn3
    Z0ebhQxsJGvz8MpzCqp1NPaCash6EYekcfO10n_2eakR2gqlLsWkg>
X-ME-Received: <xmr:NdUIadp4bIdF7F3nJAl7y-Zj-KBvb71dUPqdGMrPP-h-DjFebu5iRyzXeE6od3WvOWm_IJSWtV_25INc2ByOmZOW1MDVbMPSAE75>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnthhonhhinhesuggvlhhp
    vghutghhrdgvuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NdUIaY_AqHZX-z7NVZzwgqSiMwBYYBEGOmIirBJ9oVyK5DYSKtHU8w>
    <xmx:NdUIaRdGJA_k9cH6zlqqh8P8_ktLvMZXORhirkZLGYGopXBnTgjMTQ>
    <xmx:NdUIaaKgzicld3xudWSzwxk67YZ9b4vBViayihIKgqdUunuP4wxTAQ>
    <xmx:NdUIaZhnrDYXPPsAE2T2Nthf6e80jM9K0JAJ-hMexGzZlU9Ao_NKiw>
    <xmx:NdUIafW9iOV6GPGymwYXGqDIb9gQGObI4XFARx9LVhHs5Ewyk3k-Pup9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 11:15:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Antonin Delpeuch
 <antonin@delpeuch.eu>
Subject: Re: [PATCH v4 2/2] blame: make diff algorithm configurable
In-Reply-To: <d0bee2f2-106c-42cf-8101-c76bb54ee1ba@gmail.com> (Phillip Wood's
	message of "Mon, 3 Nov 2025 14:32:39 +0000")
References: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
	<pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
	<920a6f3acbc86e72c6ea236f8dbd3d559398409a.1762034252.git.gitgitgadget@gmail.com>
	<d0bee2f2-106c-42cf-8101-c76bb54ee1ba@gmail.com>
Date: Mon, 03 Nov 2025 08:15:47 -0800
Message-ID: <xmqqh5vbum6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> One thing I'd not thought about before was the interaction between 
> "--no-minimal" and "--diff-algorithm" The code above makes 
> "--no-minimal" behave like "diff-algorithm=myers" which is consistent 
> with the current behavior where the only options for the diff algorithm 
> are "minimal" or "myers". An alternative would be for "--no-minimal" to 
> just clear XDF_NEED_MINIMAL and behave like a no-op if it is given after 
> "--diff-algorithm=patience" or "--diff-algorithm=histogram". I don't 
> really have a strong preference either way.

Good observation.

In the longer term, I think we would be better off if we treated
"minimal" just like "histogram" and "patience", in that

 (1) If the command takes --diff-algorithm=<name>, giving it as the
     <name> would override the previous setting.

 (2) If the command takes --<name> (i.e. "git diff --histogram"),
     giving "--no-<name>" results in an error.

 (3) If the command takes --<name>, it should take all the variants
     as <name>, not just selected few, or it shouldn't take any.

IOW, we should deprecate "blame --no-minimal" as a past mistake, and
in the longer term deprecate "blame --minimal" and tell users to use
"--diff-algorithm=minimal" instead.

If Antonin's series wants to teach --histogram and --patience to
"git blame", then we can and should keep "blame --minimal" (i.e.,
(3) above), but in that case, "blame --no-minimal" should still go
(i.e., (2) above).  Under the new world order where there are more
than the "minimal/no-minimal?"  binary choice, where you can specify
other algorithms from the usual repertoire, the option "no-minimal"
no longer makes sense.


