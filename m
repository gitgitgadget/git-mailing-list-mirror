Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081A78F40
	for <git@vger.kernel.org>; Fri,  9 May 2025 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821843; cv=none; b=SvTF6DECMRKEyFxGgOSeYgmdmLQD2JM1mGyHurtBBaTcyyoakbn9YDpgOjx2Ur4YkJN3biDAiHdHMfk/0qI96wawb1kT0/pijHT7+65VtRoBJyOsPEzPasN0LkyI3MtT8dPDXHXwZkzufhQl1YafBIVsdgW2a0/bdlZs429sYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821843; c=relaxed/simple;
	bh=cD8IYeLPML0fwkKcQ+ZAyOLpxYQH/XePLZ+hqxhAVSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gAc8pTbOdRFyf+Ee61zQ1epmU1vXyC4zGJssEFBe/yo1jkB0U9bUP7KXXZu/tVQAshFpGxo7RcKQCDUqj+iEtH7JzbesZqzc0yus4B1UzukkBcheOV9gov5NyqU9z2eWSUUZ0PP9HVU6xdjeB9VfNshsv0EQT+BHRdkpBw8SVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BwJf5/4H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyhEebVM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BwJf5/4H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyhEebVM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B3431380184;
	Fri,  9 May 2025 16:17:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 09 May 2025 16:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746821840; x=1746908240; bh=vCaNIRH47B
	22xHnCQpfXhD4UgOWZg2Ab90eF7Q0Niew=; b=BwJf5/4HGn22g6jRDHQJy9418c
	uYMRJKmjRtPh6BCx+5PTt9jggHgv4uSlkm0TZw7sdKfThdurUxLMHRkgpZkzXf8Y
	yaY+CgUk2i0rWi7ZEqaQrmboAQ7OxnaCJLq6lgHoXPRQrvxeGIZjzT5Y8vnpbPzO
	l1lGfWlAgYWSVjIJR/fV4ubXDUSdZ/05a8pAr1eK98WBGzxVLHp47ifqWNkbf9i5
	FfnM+c28kcD66XgHB/QOiUv/ah8lPNP033QUxx/9FLPUjaeZ5i5BDivcLQgRuy2F
	gn+Tc9UopJKZnodjJWkBCLctnJ0CqrBos4GzYYHU7rVVuD/VZ6mDNA1Wa+3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746821840; x=1746908240; bh=vCaNIRH47B22xHnCQpfXhD4UgOWZg2Ab90e
	F7Q0Niew=; b=SyhEebVMoRe9ujSd7LTdpTx3Ka/GTPXDcx7fgxslUK/42YxMnNB
	UB4hvLit5bskeKOOQuTiRrTOLmDGYCB8VuW5vKtTdB2Y/5mtGF7+aJEtr7Qu2J2T
	Y0XtyFkE9L3ac2+0NjAyw86jQoH5re0pATeP6GjZM3DTgUlcma6g9vUxN7AlEJZ7
	4JYG3qgUM+Cd/070Mfm9nxoGIu/jsgyj/zlMo0XB9sBg94DJu/UArGRRofYCPUQh
	o3WVMq0qQT7pnU2EoAzZm+W+7iv/GjFTNRUtIcqdWSRKvzKY4EOugwh3TCWadZzW
	hrEVp/RwjzQolsJwGC6oi0IV+7KwAUFetAg==
X-ME-Sender: <xms:0GIeaN0IN2djpK7HZtuT6YU6psqLjU8P5cfkGOMEjfNJM23-rcl-zQ>
    <xme:0GIeaEFwF37ydC3tcrcBfoihlsF_EpCgUVVT7MNo7htsPXRheR_g63lFZn5JvHwdd
    fmMOfli1d1VkBuJYg>
X-ME-Received: <xmr:0GIeaN6JIZBzJHhsdCZxIl_Q3vOQwss3wuClgIr6ArhnDnVX6U-UUh9RRIOxkNkDqWqJqLkZyP6fv4bWqCnozLRQ84PQIukMM8ep>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    ffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieejtdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0GIeaK2TsGFEzZ9MyHLRXfw0lmeM1O9FTr3DrPtKvq9987nEvYIFcw>
    <xmx:0GIeaAETnKKejEIrwHrpa-ZOH_G71Bxq4eosz9A5MJAt9JlMQL4W6g>
    <xmx:0GIeaL-ZWVmM2sR1_gLPmkALoEHkXapPja1w6p-tLZShNuWsW8BPRw>
    <xmx:0GIeaNmh-VtWohbxZeuIos4UtqqjSEspI9CIFayrb83rrxUKkAZOAA>
    <xmx:0GIeaOM5vQ-eKUNYcXai8k2fxu2rp6HMak0Ux36h4MtscryV4SmJhhZr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 16:17:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui: heed core.commentChar, ephemeral git-gui.pot
In-Reply-To: <69db24c0-40b3-44e0-b225-4df2c357106a@kdbg.org> (Johannes Sixt's
	message of "Fri, 9 May 2025 19:25:00 +0200")
References: <69db24c0-40b3-44e0-b225-4df2c357106a@kdbg.org>
Date: Fri, 09 May 2025 13:17:18 -0700
Message-ID: <xmqqo6w1zghd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit ae6336b6173bf5303fad53e0a52a16f92c47b6b7:
>
>   Merge branch 'as/translations-bg' (2025-01-05 10:44:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git master
>
> for you to fetch changes up to 309bb874dcba2c96f8b12d20bed16cf6a1ea0133:
>
>   Merge branch 'js/po-update-workflow' (2025-05-09 19:17:19 +0200)
>
> ----------------------------------------------------------------
> Johannes Sixt (4):
>       git-gui: po/README: update repository location and maintainer
>       Merge branch 'ob/strip-comments-on-commit'
>       git-gui: treat the message template file as a built file
>       Merge branch 'js/po-update-workflow'
>
> Oswald Buddenhagen (1):
>       git-gui: heed core.commentChar/commentString

Thanks, pulled.

>
>  Makefile       |    2 +-
>  git-gui.sh     |    8 +
>  lib/commit.tcl |    4 +-
>  po/.gitignore  |    1 +
>  po/README      |   74 +-
>  po/git-gui.pot | 2666 --------------------------------------------------------
>  6 files changed, 23 insertions(+), 2732 deletions(-)
>  delete mode 100644 po/git-gui.pot
