Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5591B6CFE
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734986231; cv=none; b=LBKo7tcnbyZKXhcG9zdvF2XvD6w0DOoB6MbWXzOIynNl7ilc8TdjFGNJep4R0SAEP5dHtar5VJoPNmkvW+PCPgvy90AymoyfHHiy53NLb1YahEofzUh2fkLqWyT8yVxLiTElnazEz0LTBnsCH8uzozgTImvuU7GMVr9JqT/MPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734986231; c=relaxed/simple;
	bh=PKH3p2j0D+A8bP++IlSHSrRMyyu/xuYDS96OkLaMz6o=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cftsoDPT43WtoUrtBNxBg1XuRKeVd/Crb3igewOn65uI+myL+CuB71udSDrkAkzg8XkNRskjWSZVkxwgXU80iI/uGKBxzou+K67ZscCMQuq29BQDbb1eLtPy4phWDk5MTeDjw3sLYPyNSQRMnLbJuItt842TVEf/JLkVodiO20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=On/0msO1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNCF4DVY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="On/0msO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNCF4DVY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AB3AF138018B;
	Mon, 23 Dec 2024 15:37:08 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 23 Dec 2024 15:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734986228;
	 x=1735072628; bh=KE6HIYM5Kdxy53UY5CCDbfx7OPnWBQKZptSKyGOohZM=; b=
	On/0msO1/cxiFhhWVMj7jmt6cIt0EtxPWLpMkJghh6eK8acfga7YCRP8ReJSpgZq
	FWnpw/Ni96eg6eZmIlNnJ1UXDB1au2tgXXe3KEa1/fMFSYGhvGPqYZHZKjMdnqy5
	khXRmvi6kLqur9juQ2q0MUoeFerRCH1eHkc3+ubXoF876+9nR3tXRSZSwoRffp79
	jVl9qbx7tLXe/D/kWIXdg95rFVSjfaIPwMMaOGfE3nCnTc+gj0RsoNvl7t1G8FZN
	Pw8sqI4Xzd0c0A9JWg8tvn+XuMYkO9N2mEQeJwH1fqAvlE7vchii1PdYvdLZq8h3
	YbTsS/Sx1yjcywpJTTnK8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1734986228; x=1735072628; bh=K
	E6HIYM5Kdxy53UY5CCDbfx7OPnWBQKZptSKyGOohZM=; b=fNCF4DVYDka/efsj8
	JIJ/Fu59+weSRqb1xuOyKgGGkKZJrpwCg1ox4htDa1/7pApg5L2cPq9aIVGUAqe3
	7VO2pnVgRP6fQuAKNyE62e9CH9OJBLP9/fZN/kFLE24tnws9OUnffuYsJE34AWBy
	ftR4XACV/kI9z/jZm6Oi0E2i/+xriM0iwYgR8hySFHborQbUELGzcER7IkU9uJme
	5wzT5TRdomNEfypUvUWpQOCIlpPaft9wsrw8iftZN9zYOYc8DVZ5Q6eC5T4JISGJ
	K8J94lUM0fstr1nqt+nt6SnpwiM5muf7Z86KZbpg9ihIcq/dYX8003JdGMZqilKr
	/9V/A==
X-ME-Sender: <xms:9MlpZ7zlBwhbNMPwJZxPNFV_r6j7Vz3e626tEmcXBQY-UuMq9U0a38E>
    <xme:9MlpZzTVCZ0_3dZUQ57FSHa-knLVpD1hS42LozSPdsgjJ7A_NNroH7YMCa4_sxM6D
    _fJvZriIN5D22dqsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludev
    heetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegrlhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9MlpZ1XXDE5cXzJ3QNbkWnvqVzC1hN4WV1TpPyxj2zbsgWGUZ213AA>
    <xmx:9MlpZ1h5LUJvP5IC6LqfD44HJbrN4zXLCP3jfUTu4zhQ0-B77t_nYg>
    <xmx:9MlpZ9B-xXHN9GynGWL2i07QmOS_OsorDurCV0MLUL9TumM5WnkQsQ>
    <xmx:9MlpZ-J6rKlEs03MBHOV_c7GJHlWJ7EF6rzWej33JRGd-TW7MGyTEw>
    <xmx:9MlpZ65XSRPr40o3pJ-5Oj7Qttgy9NkYBBAisIQuSFQIbWGwTAI2euS3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E2AD780068; Mon, 23 Dec 2024 15:37:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Dec 2024 21:36:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Alejandro Colomar" <alx@kernel.org>, git@vger.kernel.org
Message-Id: <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
In-Reply-To: 
 <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
Subject: Re: git-log --format missing trailing newline character
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 23, 2024, at 21:28, Alejandro Colomar wrote:
> Hi!
>
> I'm having trouble scripting around git-log(1), due to a missing newline
> character at the end of the file.
>
> 	$ git -v
> 	git version 2.45.2
> 	$ git log --format=format:'%H' HEAD^^^..HEAD | wc -l
> 	2
> 	$ git log --format=format:'%H' HEAD^^^..HEAD
> 	2ff431ab1b46a25088fe40baf1faf35ea9fac722
> 	e75e6c4504022ae52d877926e63c908d9572088a
> 	178442837d39560a789a8044a8eb90fde3ad7cd7
>
> Would you mind fixing this bug?  POSIX requires that text files end in a
> newline character, precisely for being able to use UNIX tools to process
> output from arbitrary commands.

Is the format here simplified relative to your use case?  Or do you just
want to process commits as one-hash-per-line?  I would use
git-rev-list(1) instead in that case.

-- 
Kristoffer Haugsbakk

