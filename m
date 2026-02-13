Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11287224AF9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000986; cv=none; b=UVA6SLPz7HqShMT9dpSpfMnirt9ss5hUmsS/yDFCWHjSe7z4s9093rpT9YaHLEBQT+4yn/JtV6Tub64Nk9eyuie4FPkINFPH7BVUB1Sv6794ugZKUVBUsrfsXO2tAwQ/xqGVc3UENbHv2agO3p9HOmmgix3IGWev+WotuTj0nLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000986; c=relaxed/simple;
	bh=zqcULH7MF2m0KDDU0QgvnrByGccNNhNP+i55tD7NkDA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=r2MQV0nJFaS1b9Dh1XrQPJiEs2BZi1L+Jwy5vas/cPwfx2j0ETKXLSPLZ3wfC5Ge/HPMJW0nh6B/6e2qYCBDdXs+PQ1BckAXTA0hqeRsp6fPYu7FG1zgTMhevDrcPn6MWM2aY9Gr8fhHdGZJ20yr8VJr4RSaaYPklZ+bIppIJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=uir5fr0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G0/ztjMG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="uir5fr0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G0/ztjMG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CC1B1400154;
	Fri, 13 Feb 2026 11:43:03 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 11:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771000983;
	 x=1771087383; bh=yA+Nqx/U4Cy+2rxzJwWeobmbfyOwM9wBNQrFiiWhDRQ=; b=
	uir5fr0N2/6qfQsrfU0PcnH9GEmJIMxB+UYK4ERsRKikGKHjmWA1GPL1U6B3GOPg
	bAd52as38P4Nw9gPaXHH5J12WXwHKw/lE33c9vRzf7uVMrNSqgpycFHmK0LUY6Q2
	hEg16fsGmuoCkLzmqexGXlaE8yvpEUmQuEl199APbcUACuvdsdmA/K3crTE7dzyC
	n+hMvXDX0KzwZzsDVQbN3UVgbWfTgswycIDn1nXf/tZb9GV+AIM7/nNe0aEeP+ro
	SEGblW6fpJ3GR9JX6CSavx7VFNeFlG58OHAjBua8naEFfpwaef/hvuowXuOvWc1r
	8KG62c7uEvBR1BF5nLg2CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771000983; x=
	1771087383; bh=yA+Nqx/U4Cy+2rxzJwWeobmbfyOwM9wBNQrFiiWhDRQ=; b=G
	0/ztjMGU6g0xCVfSBmv9phaKXH+cRuI2a2783Pe5u3EFBHD5dFqXeSCYKtsoqB8t
	WBHPa2EBfu2vuwrPHSltAeA6C/yLfG4S48uIfvvw5rj2GW/39E0Xn2VLPVz6XL8t
	okXmBS1a+5PuR/PeAEXAhm2c3Mb1ZlCp876lrcL21qrP9lG5HYwCZ5pmrVnIVNvJ
	jREzLCZ0SnxT4hbL2/5YO7RYDD5Yhjd+oHeDgV1KEJAM1UKrtfyK3v1pKKMFE9kg
	MyOsmKpeTek6+mU5o60gcx8L3khLad6y7R0VfzlZG7qy7moGX0RnSua/t2LCITAE
	yuDDKSn1TDQcDPQR7iaYw==
X-ME-Sender: <xms:llSPabvY2yUmFebXNk6XGrnEugOV1dLahhOF3EAs3WCGBnrvU1vbrGk>
    <xme:llSPaXQdRnXMkEdcLVT4DTpzVgyHSfn9T-r5lCUzoCHHJH0itaWJjn3BjoHG5x5c4
    P5OTJQKvLfBTdjkZ5cSGM9WZ3K7CuTullvvVahxiOFxSnbn-uVq6MM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeuueeiheeh
    ffejgedtveefhedthfevvdegudeltdffheejvdfhjeduffehgeelnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjrggtohgs
    rdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphihohhkrghgrghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:llSPafOGkYSfMZCpNo2kiZxq8a4DXf1Bd0aGjlumYaTQlilwdUJk3w>
    <xmx:llSPaV_F8DN-LFY2N2kqsUeGpoBJGCbqz8E7RVAAq5NL5HawlZhBCw>
    <xmx:llSPaQe0LkeH1J-pximz4Xq3457UrquWjZckB_rF2CjczTvP-tdy7A>
    <xmx:llSPaUzRyH_IlLOmfhqvwzp5ZlxtYTYA4zMo93gZtGh4Ml92u3Unzg>
    <xmx:l1SPaTlAu0quosmozviU3UWd7Mod43xQ0zfBNJ8xETInngnhLd0IQwqm>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B83F91EA006B; Fri, 13 Feb 2026 11:43:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJxSRRvp7wek
Date: Fri, 13 Feb 2026 17:42:41 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>
Cc: "Matthias Beyer" <mail@beyermatthias.de>,
 "Jacob Keller" <jacob.keller@gmail.com>, pyokagan@gmail.com,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <7bf9cdde-de61-46fd-8730-592f87017a19@app.fastmail.com>
In-Reply-To: 
 <494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770993281.git.phillip.wood@dunelm.org.uk>
 <494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/2] templates: detect commit messages containing diffs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 13, 2026, at 15:34, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the body of a commit message contains a diff that is not indented
> then "git am" will treat that diff as part of the patch rather than
> as part of the commit message. This allows it to apply email messages
> that were created by adding a commit message in front of a regular diff
> without adding the "---" separator used by "git format-patch". This
> often surprises users [1-4] so add a check to the sample "commit-msg"
> hook to reject messages that would confuse "git am". Even if a project
> does not use an email based workflow it is not uncommon for people
> to generate patches from it and apply them with "git am". Therefore
> it is still worth discouraging the creation of commit messages that
> would not be applied correctly.
>
> A further source of confusion when applying patches with "git am" is
> the "---" separator that is added by "git format patch". If a commit
> message body contains that line then it will be truncated by "git am".
> As this is often used by patch authors to add some commentary that
> they do not want to end up in the commit message when the patch is
> applied, the hook does not complain about the presence of "---" lines
> in the message.
>
> Detecting if the message contains a diff is complicated by the
> hook being passed the message before it is cleaned up so we need to
> ignore any diffs below the scissors line. There are also two possible
> config keys to check to find the comment character at the start of
> the scissors line. The first paragraph of the commit message becomes
> the email subject header which beings "Subject: " and so does not
> need to be checked. The trailing ".*" when matching commented lines
> ensures that if the comment string ends with a "$" it is not treated
> as an anchor.
>
> [1]
> https://lore.kernel.org/git/bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm
> [2]
> https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
> [3]
> https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
> [4]
> https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  templates/hooks/commit-msg.sample | 54 +++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
>[snip]

This works for me with `git commit --cleanup=scissors --verbose`.
