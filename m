Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF17DA6C
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411461; cv=none; b=J26ikWQswOk6JCKqY1FSzRRz3PxaqS79/LbzKqWlNgaC3rjzfowSBRYbqVVFjFSA7gx0F7MTR55Qr0Plh072SzitLwyWOOTV5xq+1bXds1xezUy4sISXsceDLgG7x+6fnHDbqPjIupLRnI1mKFmDf14ISCF2p0uSqKXUrroP0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411461; c=relaxed/simple;
	bh=ySxdjtmOEUZ4EqG2+c8Kj5Fe/p/4rDnttTgGSM72aj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GRmcECX3A+vipTTcgdIVTJ44+a0BCe81V0JalFwtf+6WOAUXRIZEOv736Nu+sUkCwvuMyPRSgua6zlLNMJ4MGLMlsZ8mwhd7SYg4sW+CH7QWshqcgYOyBfxeWGnxHWi+jpQgF8t3v0icqkpNkpoRn85+Cs/Jowbr3NIaW+WH/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NlrdyEi1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lL4ijeql; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NlrdyEi1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lL4ijeql"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 615A41380115;
	Tue,  8 Oct 2024 14:17:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728411458; x=1728497858; bh=OSQp107MfK
	rxmoph9Hwa4Dr1R7y5ySMY+7coHN5Mhgc=; b=NlrdyEi1RLVt7YfU66OtFgFcvc
	5irNrslMM3HLDVajKrkhreWoh2n7ufyUbLpqxS63NqgRqiA943w7ugqZHmnyNTE3
	kM3u+W6lb0Iczg1rhBiWJTjLuIuepjN1l6YTXJousnlWqS9x2/oahnZkMPppZavp
	fsRLdhOqPCZDxW2HKVTZKCk/1pZZxhxK2Bu/VX+FJJ1gCI3dvGfKw5Z0Rr1BwiIf
	BSRAQ1qLiMtuexIc33zOaa8bmfk/a7TwsTRn12i6YTBl7ywI9JlYuCsIJFB6JN1A
	V/JwI6QR1C5b3GBlQr74hyQDRsqlsq0eTmWUqZb7HGGkwA0nj5w41xkuL1vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728411458; x=1728497858; bh=OSQp107MfKrxmoph9Hwa4Dr1R7y5
	ySMY+7coHN5Mhgc=; b=lL4ijeqlmadMvXQhW9npIj4ZFZh1XWT5PSvG66MFpZKA
	ZS8vATAmaPtWab57zFu2VJLyj3xctBIUnSEyMRH9OJT4blxy+u8J+FE0p3IZGgs9
	66BIe6SZ0RuloUu8mK+ojMFMKbdqV3ePJjDfuuXNuCWMu0Ehr5mOMhra43eWbLli
	Qz1V3NRDUTaKWAngwzlSQsw3d717l7OoeMnSftHuNnEbWC3oSrZVw/IeVgtFHyFh
	5/EM/Z89tsRgHc3x8J9cjzQQd4A6jxnNChS363reBImgBljQ1SL3aWfWBMuYvn7o
	LXX25Ukz0CJzV7rILQ830ywBDN8ZWbAZi8x0tfJJpA==
X-ME-Sender: <xms:QncFZw3nRxGsPQQ2Ico32Kyx6_STwGK8db82LP1Eos2R_dLSudYtWA>
    <xme:QncFZ7EqJYOf8XAJ1jbsJ-zAkVMebaeRXxk4M9W5TugIaKySWIJb5hPgevE4rGxkm
    3k7vTVvuTsKezdprQ>
X-ME-Received: <xmr:QncFZ46Lugv4aTsxLesCjRKWAOsEhlqa-I2FOQKdwDgWdhT1iwlxQBGeHPOq-EMzg7fTAPG3XL4ikG1uttuE8gjJQqTE6xY5uWl8fgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhope
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QncFZ51rmqdX5ICSvAf9x7tuH-6o2UlVTpE8Li4PlDyyxxkVv4b45g>
    <xmx:QncFZzGkbrAAtH_GNEZoyHxNUeqAGoL1ZWYtyjchXYy7feuGWEGozA>
    <xmx:QncFZy-LsuKiAAter2olK2MxBfhOxOGILeYLXx0Q8VwybQWDXBrPXA>
    <xmx:QncFZ4kOA3Or-QD80wTvYyTgWYvfpdZYnJ30c7YJ3HjzxgQeojcFeA>
    <xmx:QncFZ0Oa7WejuGhtgrVppJm3ItTv-TfDtS7iXaRSsOfMQ_zMulP3a8a_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 14:17:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,
  peff@peff.net
Subject: Re: [PATCH 0/3] object-name: don't allow @ as a branch name
In-Reply-To: <ZwUxdz_HobRGF9yq@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 8 Oct 2024 21:19:51 +0800")
References: <cover.1728331771.git.code@khaugsbakk.name>
	<ZwUxdz_HobRGF9yq@ArchLinux>
Date: Tue, 08 Oct 2024 11:17:36 -0700
Message-ID: <xmqqjzei1mtb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> The reason why "git refs verify" will report this error is that in the
> code implementation, I have to iterate every file in the filesystem. So
> it's convenient for me to do the following:
>
>     if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
>         ret = fsck_report(...);
>     }

It may be convenient, but I think it is wrong.  HEAD may be allowed
at the top, but refs/heads/HEAD is not, and checking only the single
level name as you descend into .git/refs directory hierarchy and
find files would not be a good design to begin with (and it would
not work if your backend is reftable).
