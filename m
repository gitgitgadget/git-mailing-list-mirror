Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA858286D59
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210212; cv=none; b=JKhXVttTZvuIszw1aKrv/l29p2T5xb5LaGHqk7jDbkgYCtunQzN8oY/U181Ga0NQvvsTen2hn/c0tAN1SaK3CYJ1FNzqYxxhFrPMvVguup0Xw6CXmalAxTcf5dPYjM2s3mRNCQZBtUIlHNZz8V3x37ycMZGhZgdVFGbdxiiDeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210212; c=relaxed/simple;
	bh=GKFLn885joxanc0uqx+TIIPFsimV+EuezbRa+uYHAMk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VDI90e6idFypxTzh9eJ2HJBbG8R9bfzh2eNCZkFZZ1GQvnnV800w2Uf7q0S1/lACpsq9MmXUCu4/x5OWyBFymoM85L2Sed+H4CX67jvLijogRFOkJK3Hk7+rUAEj/jZDlEau1bzv9LX7A2cUDjEBDAu1xetB0jkgDmjNdAAOxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=g00OeirG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSOAP4BP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="g00OeirG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSOAP4BP"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 87A47138033D;
	Fri,  6 Jun 2025 07:43:28 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 06 Jun 2025 07:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749210208;
	 x=1749296608; bh=0BijDtofNgkUs1le0ZiNV8ZhsXIg868JW2sW63WJn1U=; b=
	g00OeirGL2AL50QNUwcbFSwQTZKpaqr/IuZZSnsySjzptpTVbUd/a6Q9gHWq1yBL
	WR9Kl0qlHPuORIq220qwJ8HwpiNCzsSLQa0NeQ9UtUfSMF4KNF5InnT5P0eC8+Gl
	XhJHnrjcxFsoA0wD1kmbQ9IGGm2Hg7JLwKaNMeNLHRDeaZnbdRp0ciAB8XjFxIOm
	wmTanUVPFqoAMdIoeXymERZZZTykIfS/C6AsWZOsE5r+cmTeGtx2myMNqNoJEUO6
	FiasMo+6s/M3xvfyMuTtUb6+lJg0ESAgA26XXSP1Gwu4T8mcuoWuxdJZizJhswQB
	+D+T+0AIT4N0ppLjxBH+0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1749210208; x=1749296608; bh=0
	BijDtofNgkUs1le0ZiNV8ZhsXIg868JW2sW63WJn1U=; b=jSOAP4BPEecSjEC4h
	3CuWxrBxmh9MGtUEorcbtkYxmRyNhN6OdvBYmMGdtWBZLszFCwY+h7CZskCq0Sze
	C8ORzrG16+jDpKqUGnIkbSC7RHn+5s56MLFYuHksRCg9BC4mUjdjPTvwitKoEj2F
	QJ6JkmYw4umuT39wSUvayLH2ePfzZmHQP/yGDjaWybMOCRH2YC45tqMdtebeM5LE
	LfbOVXQz/Xgc2IOQLpFHEeBjSfSwBkE/MghDf+f2wRmPPZTmwQOqcAEqgk0LvYTa
	/q8eyTnTR3ZkTKCugs1aK7cgQXreuasMQcUvRTDnBJk4RgyUscxCZfqy128N+lxs
	FMUTg==
X-ME-Sender: <xms:YNRCaOCHneP5IzEhzZiyiYmLQ6n-IvlIjU6KzKnblsnKCckqtvbqPLM>
    <xme:YNRCaIg2nDwAL2H6eoCzHaLVWqo_Bv3PTGCiwsT-IxGGGLyj-eSUjOu5glZwB2YeW
    6at_Fay4KVrIXxmsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludev
    heetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopeigmhgvuggvkhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YNRCaBnAQVQ63UAZCFZUwA82K8QvZPBfhBMdF4MhdYtQwMw90L-7SA>
    <xmx:YNRCaMyshPzB1fMO09_FBT4Q0KlQ2eK27KY_4zWEWJDTe7aHM1W5rA>
    <xmx:YNRCaDSfECjz6pqr9mNpquWUcNaRF7G7saOBV1cWEdRAHZI6-MceNw>
    <xmx:YNRCaHYd81rJlfVIkzzILuOzQTfKA-B8jBtQsTbFtVYC763IiYazdg>
    <xmx:YNRCaAAXY1c1WlwbxNjPGKq3fNuZ-zwrEm2zs7Au0IjLVLbaTgMxm_zo>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 529A31EA0060; Fri,  6 Jun 2025 07:43:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T299fe5d221e736f5
Date: Fri, 06 Jun 2025 13:41:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ondra Medek" <xmedeko@gmail.com>, git@vger.kernel.org
Message-Id: <ad141d46-3170-47d0-860d-46e7b92f878d@app.fastmail.com>
In-Reply-To: 
 <CAJsoDaFKRz8om1d4YPtaqdyuBuPAiC-xHDuvmYW=VQWEzzXAtg@mail.gmail.com>
References: 
 <CAJsoDaFKRz8om1d4YPtaqdyuBuPAiC-xHDuvmYW=VQWEzzXAtg@mail.gmail.com>
Subject: Re: Git push tries to delete branch twice and fails
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jun 6, 2025, at 13:20, Ondra Medek wrote:
> I have a git 2.49.0 (Windows) and one local working tree is kind of
> broken, when I try:
>
> $ git push origin branch1
> Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
> To file:///c:/...
>  * [new branch]            branch1 -> branch1
> Everything up-to-date
>
> $ git push origin :branch1
> To file:///c:/...
>  - [deleted]               branch1
> error: unable to delete 'branch1': remote ref does not exist
> error: failed to push some refs to 'file:///c:/...'

I was note able to reproduce on Git 2.49.0 on Linux.  Both through a
HTTPS remote as well as a local (filesystem) remote.

```
$ ./git diagnose
Collecting diagnostic info

git version 2.49.0
cpu: x86_64
built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.81.0
OpenSSL: OpenSSL 3.0.2 15 Mar 2022
zlib: 1.2.11
Repository root: <path>
Available space on '<path>': 202.28 GiB (mount flags 0x1000)
```

> So, the same `git push` command first deletes the branch and then
> fails because it does not exist. It worked well until something
> happened and since that time it's broken. I've tried `git gc
> --aggressive --prune`, but it didn't help.
>
> When I do `git clone` of the same repository to another local working
> tree, then it's OK - the branch is deleted without the error.
>
> Is this a Git bug? Is it possible to fix the local working tree except
> for a new git clone?
>
> Note: I am developing an app which uses (creates and deletes) custom
> refs often. So, I've hit this bug when trying to delete a custom ref.
> I have cleared all custom refs and tried that with Git branches.
>
> Cheers
> Andy
