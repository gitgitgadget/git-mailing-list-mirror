Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BB188580
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099417; cv=none; b=IN8ILzpnSFlbyyMOqbDC5UD8XqWm1lmqTUx25pAP4NACCX+NiywMkGBEAdeBKPmISvjXUEbM8Dc1zmju98k9NLgMdhwPNHGXLa2fGTWX9DwsWcsAVLROtbIoZyifrCtCN2mHLwvToEf0mFaw5C6yQBScbhsX1es/D+wP9DBFFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099417; c=relaxed/simple;
	bh=EMC5Do73x3u6cDt5FC6jWBPbrmSOPUJaGlJTGhmDMr4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A+SUF1Ihx6p/PNpK0g16mPk9vHGtY3hvishCQEnTJp8nIyrXz273BLQueu6VZMu86DfGXogGMmjp9a3Ilt95+/MEIp5R3zBkjXQeC9H8Z2LeT5drs6qLIvAiKb8gvYmz4JI94STYkdydMopywOlCeJc1w6JhHblTM2z1oXZspSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qY+qKrx1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUUFS24O; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qY+qKrx1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUUFS24O"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFB3D11401EE;
	Wed, 16 Oct 2024 13:23:33 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 16 Oct 2024 13:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729099413;
	 x=1729185813; bh=2FOHzZvww23ePGE59pUpFtezsG+iO/ubibIQwNo5mWk=; b=
	qY+qKrx1aX6kqZpjL2/1Us4VFngyD0i2AP7GkfbDosM6jzWjqvZ8cFlKCC0RI6f4
	pyGcbTEyYLMftgCBgorDVp9yFdx8fRKD4FjTTtcC4HifBdi0ImAjdxfAeK1K1J/m
	gZ4AQXzrn3k5HbfQly3sBRIKiKHnbqE7J14s26uTVKy0Gpvb7ZINm94eTwDA/2yw
	u0lxx7JTRCqkHwNQo03EqOFvmQdWmzPRcoPFc4L+0iT7Du7jgWTjmYgaf1PMTKF1
	XR/9vbz+Ojz8ZW7Q7pKJQy+HIJUwd3iiefyRoT+dMdHKBipBbKN04EdVR8MYnwxX
	lRP6y4b0nDaAzvu/Ok0uCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729099413; x=
	1729185813; bh=2FOHzZvww23ePGE59pUpFtezsG+iO/ubibIQwNo5mWk=; b=i
	UUFS24Ojuxu6qlaimuiWmRsM4Emk5hM0yfs7CvPs8bY6B8/xdiUjBhtPJaLbDlBJ
	ELrRL4t6qn9a4+9PXGfgJ3hSGl3jeo9JppLDgfd7mfEm0xgSIZ5nv3eS3FwGtirU
	hDHmf6imDphM21Vy91ZecDdNccC6QoXFSSk+7+pkpQAB0dphsD2mYxeJnzKqbiqh
	gtgVv7MZIP/sDarVZHxfI+JUyIf+DAHkbpI2EOCO0sd0S2FbCbaIRvwXUkR4DsNo
	YdnQC0HJTHxeCc9fO44UrqgEaPqMPahUfV0GuGq9fsC6sVBN48faxzpJ2UyoLNu0
	OE5U95klulCRH/9q4baYA==
X-ME-Sender: <xms:lfYPZ5S2UgReAAHvLl-KQivh_PMSsNBHt9BLS3NIKQLuN4BZC5bPLtU>
    <xme:lfYPZyzRphfl-Wehf_-WbUvCXdkpQGVIvEokjL8vyHPph-Xj3FgQ5iq5bvD_ewSdU
    GyfnQGXyujM1ujHQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lfYPZ-3v5OWlcOZszWN7z84Asf6cEFRLk0WBGDirZenReIrD-waXFA>
    <xmx:lfYPZxCCaItC82svqbd1Rc5v-rBz8lRB_XqhSsyPY9iOkIRb-huRxg>
    <xmx:lfYPZyiFXUPKCMQV9GWfjMDLcVcRtd4aAvdY6rJqevFc2exLukKrZw>
    <xmx:lfYPZ1o-OqYu_Gt07rKAUAmGpYWjcMrF6-xsbIXJ4un_t9IPAQ2JiQ>
    <xmx:lfYPZ2a_57jhmcdNrdZLVz2w5r6_p2VT9UD1XQHQhHWYJh1TfqCAg1Ns>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45758780069; Wed, 16 Oct 2024 13:23:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 19:23:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <7347e29a-f33e-472b-b993-06c4767a9456@app.fastmail.com>
In-Reply-To: <Zwzvgby2_oCjQpii@pks.im>
References: <174f3704-6319-48f9-955e-b36a25836e3d@app.fastmail.com>
 <Zwzvgby2_oCjQpii@pks.im>
Subject: =?UTF-8?Q?Re:_What=E2=80=99s_the_intended/reasonable_usage_patterns_for_?=
 =?UTF-8?Q?symrefs=3F?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024, at 12:16, Patrick Steinhardt wrote:
> On Sun, Oct 13, 2024 at 09:57:23PM +0200, Kristoffer Haugsbakk wrote:
>> [=E2=80=A6]
>> This seems overly restrictive for this day and age though? No?
>
> There at least is no technical reason to restrict this from the ref
> backend's point of view. Neither the "files" nor the "reftable" backend
> enforce any restrictions except the restrictions we have in place for
> any other reference: a ref is either a root ref, a pseudoref or it must
> start with "refs/".
>
> Now the only reason why I'd say that you maybe shouldn't create weird
> symrefs is that tooling isn't prepared to handle them. But that is not
> sufficient reason for me to say that you mustn't create them.

Thanks.  This makes sense. :)

=E2=9D=A6

I discovered/re-discovered a pitfall with the following approach:

> Create a `refs/heads/<symref>` which points to a remote-tracking
> branch

Again, so tempting to do for me because you get a shorthand via
`refs/heads`.  And this is indeed fine for read-only operations
(effectively).

But don=E2=80=99t be careless and do something like commit while checked=
 out
here.  Because you are checked out on an ostensibly =E2=80=9Cproper bran=
ch=E2=80=9D (not
detached HEAD) and the remote-tracking branch will move forward with a
commit.

So I=E2=80=99ve gone back to using one-level (root-level) symrefs with
all-capital names.  Because git-symbolic-ref(1) allows that and I
haven=E2=80=99t gotten any weird warnings from it.  (I would presumably =
get
warnings if I then defined a ref named e.g. `refs/heads/M` if `M` was my
top-level symref.)
