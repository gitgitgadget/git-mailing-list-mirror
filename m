Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D73A8749
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582172; cv=none; b=Pk4VfT32qCRRNHYIIuYNXs5cDQF2NalVD8BW8z8m3PxpQqEG+gQlL7dKmY634CM9pRaiTUmzb2p33rhtd2BiloVneDVmSP9xM2Ab2Y9/7+ugYRdAs/ovmfl1tP+dbZ5HvDjM9B3oi3p2Y1q48MlosoxfxqG1HpNWAbbmoPOy2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582172; c=relaxed/simple;
	bh=fr9Gf9i2ZmapC9QCEbXqJbIbHvwR7aLosF0RhGshXKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XYeGmSu3x0NNpcVevjLdWarMJJKR89fbk+8I0M4Q34cz41ydHUri9IkqPPCx78iM/fhvTxX+EoReHFVrlbwYGoLWZbs8D2tr96/kgrPkGnaOLlsK89WqR0ugjco0/lvnursu9r0YN0GbrK42ry1bLLOwvG/6Er6qRlSNB4pefos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=plIusFz6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSsLhBGr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="plIusFz6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSsLhBGr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 53EB8EC0075;
	Mon, 24 Aug 2026 10:36:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 10:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787582170; x=1787668570; bh=uHUrVfBTYG
	oWEYwoKYYNewKropp6D1UMKuqOsIE1Sdg=; b=plIusFz6FAjueh33SNJRmhb2no
	JDxHDEvdZ7W6ousHpvznrZdJ0hTJ6ASHV4QDqGbeeqi84VcDMQYwfR1Qh6nmpfyL
	KF9C0L+o5+hWqGoPiHo3IjsnhUILIxlvfdGGKTT44aShsbPWLV+UzfWiE7fVTFA9
	rSSoAiKa5xo9ewljtHcslpqtiTtTCjSJ/7Nquh1IR1oqg3bDnRwU+M0cuPnKDRp5
	KVqNGWk3z0g+/RFGPneuklzU2CaPco5GCDlAAsJWoP1wZc4yzxfiXTh1rcZ9wDds
	MdNqRq0HlXox/8ufzEtIxzKIGQWdup5tSYXXl/nqtCPOLz+uGQIMvxOS3qKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787582170; x=1787668570; bh=uHUrVfBTYGoWEYwoKYYNewKropp6D1UMKuq
	OsIE1Sdg=; b=aSsLhBGrzRS/I7Z2mxlHUpKqOH5TRMNKBYALmj86xHRAkcS8Xap
	QuzeaRF88QVnfnh1ONF4eC1ianAnyp5ZkI3OPXoB9y2eQKEkA4gUTU1AdeLx3lEY
	fzAgSrFER+zq5WUrhKaaHaJArrmDSdjamBwV2vhgR0wimzdFwLN194ysTeRt5AGL
	b3O5fqE/a+3aoaNae5yP1fweqIatFbTgdQRJ5wrPZ/XbbG9txSZ6+tzjWOcJRH7c
	Pyr3t32EM52hExWqFBjXSPqq89q27KWIsOO5tbGKWyB27OK3/Zbs/vrj5l06dJSi
	Vmq7FrtibhfNQ1lShAj9rgsAhhrYUnZjrHQ==
X-ME-Sender: <xms:2laManriROXENUml0yt6cqQAkHZYrG9iuZoABAjLQVHX2i_7xabN-g>
    <xme:2laMaojwcjF5rT6xwCC8oW-WvsNlhjFccXG8YqBfAwZk-pwxHbfRFYES2TiWJl5gf
    iZGMr-CQUw6IKAfcXtdmapYzeyOx34X1l55W4ud9-FMcCVMtSIp3w>
X-ME-Received: <xmr:2laMasgsfaJTb01a8X2l8dZLNFNM3uuOyZEwgjidOklCuzMn3KeknGKEAVzfLqqYcnNYyajLQVpRDOZX7lOCjnFQd5QJLjuIsQ>
X-ME-Proxy-Cause: dmFkZTFsQZkjQv38lFS7uu58WxnbAnF/KHnpxIHRX0MV/kwtILUy2D/jS4wV4ix2XrAHK5
    fadhQpFcISCW4V9coNxfjZ4CscWzMZHj6X3WF4KvzZFl0OHTT3Ae9LDeLhBDYsb2mEBpKp
    df3gf9XrH9ER+W7G60vL0X4ClAHpefHcUU4P7mYMSl6+sZmEnU8ghg7vpiTSds1o6Z8QjP
    vHLgD19UFL6aBYIEHPGx/rek1QHxJqMB96E5TnSHpPwz8O5riGfYUwMyabH7EBINSA3AMR
    VDIuHcisJXRi1raLzCyZX3yNbbVpuEYqopF5JqaRijKw8oJMR04lggGVrJaLoGCJHPc+VL
    s33tAukRNniE0NuI6cCIzQe4mZEuK7H0hPN5wcoH8JIiRwhjVU0vxAwdZh1glf5U0PSynh
    0ZA9njMr+/AxfX/qOnjR/inLrx2Q2sdMikMXpwu2KWw9GfgQavTZMldgklpzojwAx2fsUB
    FWgi6WoMatx8M/IR2fKnHPzhP4hcyAMdfNJNg9tcA5IKmg1zrImQfMY3GV7mgqdkIjvlbf
    B90P1K18WwVBcDlcijRfjh2iPMlH+MTjcf+GFnxDq02XWOVDZK5JZkEH5XQZs27y57nPlu
    TNFotMQsRr80zDsvGSJF255Hkb8RGOenWb6HraeSF7x1feNCsyIAJqBNIE8A
X-ME-Proxy: <xmx:2laMamjriOPENjR_-rB0ZqVMMRlh9q102chw69VinPsWB5jIIxlUZw>
    <xmx:2laMakJowU1i_QOYacUNqnuhRQTqEW7qQORGl8WUhbccFQ0kQWNZDg>
    <xmx:2laMatEJ2TsfcFeQkA2WfOSvzG1Xfb6mkmbkSZuV3G0QuntTUoaqLg>
    <xmx:2laMagQ8IBsGK6QxBXWHDQ77n9vRYYc2yf4vvEXh_h6UgrmL1WhuJg>
    <xmx:2laMas5RXNvlBES0AvU2LAx3JDm51luuGg9BPzXjMKNmCPgzcdVXG8nZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 10:36:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] sequencer: release the ODB before spawning git commit
In-Reply-To: <a786e6c0-1c17-4121-8623-b4541478a88f@gmail.com> (Phillip Wood's
	message of "Mon, 24 Aug 2026 11:03:16 +0100")
References: <pull.2198.git.1786388689444.gitgitgadget@gmail.com>
	<pull.2198.v2.git.1786528498689.gitgitgadget@gmail.com>
	<a786e6c0-1c17-4121-8623-b4541478a88f@gmail.com>
Date: Mon, 24 Aug 2026 07:36:08 -0700
Message-ID: <xmqqo6ersi07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> This looks fine as an immediate fix for the bug but I wonder if we 
> should pass "-c gc.auto=false" when we fork "git commit" from the 
> sequencer. We call run_auto_maintenance() at the end of the rebase and 
> its not clear to me that repacking during the rebase is helpful.

This is a bit amusing as I was reading old discussion the other day
around the constant 6700 [*] and saw it discused that because
"commit" triggers auto-gc, there was no point in doing so in
"rebase", which does series of "commit" invocations [*].  With small
projects and short rebases I tend to agree with you that gc at the
end of a rebase session should be plenty, but given the widespread
use of Git, itt may not apply to everybody.

> Another 
> thought I had was whether we should automatically close the object 
> database when forking another git command. I'm not sure how easy that is 
> to implement but it would prevent future regressions and I assuming 
> re-opening the object store is cheap compared to forking another git 
> command.

I think it is a great approach to study how feasible it is, as we
will not have to sprinkle fixes like the one proposed to many code
paths.  Thanks for raising it.


[References]

 * https://lore.kernel.org/git/?q=6700+d:..20071231
 * https://lore.kernel.org/git/20070906023934.GI18160@spearce.org/
