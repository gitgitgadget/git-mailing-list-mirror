Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C8664D
	for <git@vger.kernel.org>; Thu, 22 May 2025 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747882546; cv=none; b=uRbhzlWWH4H5MiuhmMCvdI+AKcCXq4Svz//zz1nA4Ap3VArdO9tiRIpIFPOrl+jc4c10pNHmu9PAsMX9IQV/w6ZyDB2pC1y7lemw8R5LWSDGZw/ZAsMZrg6WqoLGE7G5aEmJcxwlxKSElZy0pSmKgBehhXqn6IpYJiHXVTwInuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747882546; c=relaxed/simple;
	bh=O/8zmOlp71Kyf+gr1321LCLhfc3faqL0R4Pk9BV4RAA=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=pC/1DtEN5l9znShIBk2Mus94F76TPy8717A4k1zcgeK37ocEMfbV3JnUlOjjn1RTNpHWGbJQkz0F9s+jVmZusec2EX84e1ECk77UfRGXsfcJLS5PUTr+BxwhPnSC1KESA+RjEoFMC/40ASNwRDNjAaOzZWeF9Gnn6Kg4tR8AvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=F7cCHAZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vHfYJtEt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="F7cCHAZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vHfYJtEt"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 942A425404BE
	for <git@vger.kernel.org>; Wed, 21 May 2025 22:55:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-05.internal (MEProxy); Wed, 21 May 2025 22:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1747882542; x=1747968942; bh=Vp0S2vS/ji
	2NRrsglOoVHgKhcfrKDuT/bgk/pAcZENg=; b=F7cCHAZgcHSEA+FiNPcAm0Q+2f
	XqiAXa4aMKdajQBDGPkxJPyuPLFYjcUSoS8LllOk+LxG5cHhFlcUxJX30VJsre9w
	/afdtGe/DywLfY2aCPs66Ehs9CkysdjhDCu73eFJXsxRfstweTi80/smVngD8SY6
	SMxJfQhC551J8uR4AHPlbwOLJQepdF5r0r8/YN+Dt5n9u+vpInjF7VHONa9YSFAt
	JVMTLqNBF16UrjBne/YEuG8IdyXyDTcAWV+5EcYEPjNdW4x/p9UhUwa3bW1ASDA0
	fOvJDUEj5d1okdu6mqmVOWsza3A4Jd9MFAJuNthIPFIAVqY8w4y9/HV8puRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747882542; x=1747968942; bh=Vp0S2vS/ji2NRrsglOoVHgKhcfrKDuT/bgk
	/pAcZENg=; b=vHfYJtEtQ0vszzhoXpuHAsQjANxuBUCYu2QM6EzAqHu+dFXzd2K
	cZHwGphrLKzNstdJDyzwqrWlHG2Yo+soCXDgZPu+MSb/XmqzVI1HoYF+FQjUOedQ
	KDZe6jFRAUPn2++JChryyKHdmTFwCpl60GX7bObyG/Wvqyr6L8h8q3oHsvG0cxr0
	E2wo0OAfQyT/yvfxm1Ptl69eyf32jmPagWF3YPQpyf8s5N0V3bqRzO6wiSjrv5Yj
	HXLTuQxOC3rBh3fMyHgsiRVgOKMq49nc3KnwmQmFY1fKSynnex0r/st7jCGlEqFD
	+rQ35JZCSFt8zi/3pTtLICiGdmrh9sidMQQ==
X-ME-Sender: <xms:LpIuaADLt9EjSK7JVwCsXm8404mjq9Wgws1pO1NYcPOX-W25v0u8OQ>
    <xme:LpIuaCiLmdfI4qr5L6VSanGoZfKu6q0ouNKTiXuycuwOVBsjiQX22IGcaykWqIKPF
    3IUUNH_h6qdqdqXB2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegkedvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefoggffhffvkffutgfgsehtjeertdertddtnecuhfhrohhmpehpuhhn
    khdrlhhiohhntdeltdeisehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpe
    fggfeufeevjeeigeevieeiuedtiedvgfefieelteegheetjeekvedufeeiffdugeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhunhhkrdhlihhonhdtledtieesfhgrshhtmhgrihhl
    rdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LpIuaDmIpq-edJ4UgHLCs_3GJBNdjN1dSokQtUUtcV9Os_TKrKdj4Q>
    <xmx:LpIuaGyiuq_3qtdY__RB3RBPXcWfm8PBi58CGBhIjqAmcVg5FjmVvg>
    <xmx:LpIuaFT0NyCg4wUAEJBz4IAvdBX-KBkc-jbjtJZmJ5Z0NSDDQCZlUQ>
    <xmx:LpIuaBYcrZPVTwacrpAsM_TfdsHWP1m87poCU3CgEAAFR6L_izS2Og>
    <xmx:LpIuaAHx2zfSxnXHlzMqgsH6mRbic-9__9F3cVAedA9MrytwwQZmSk2n>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B87F3020061; Wed, 21 May 2025 22:55:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4426678c4e746db6
Date: Wed, 21 May 2025 19:55:21 -0700
From: punk.lion0906@fastmail.com
To: git@vger.kernel.org
Message-Id: <087f6a4d-d276-4f1e-94a4-7423b3387b79@app.fastmail.com>
Subject: gitk: regression when opening preferences with `want_ttk=0`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This duplicates https://github.com/j6t/gitk/issues/18.

I found a regression in `gitk`'s commit 904b36b. When `gitk` is run with `want_ttk=0`
(AKA "use themed widgets" set to off), I cannot open the settings dialog since that
commit.  It gives the following error in a modal dialog, and then opens a completely empty non-modal dialog where the settings dialog should be:

```
`invalid command name "::combobox"
invalid command name "::combobox"
    while executing
"${NS}::combobox $page.wrapcomment -values {none char word} -state readonly  -textvariable wrapcomment"
    (procedure "prefspage_general" line 43)
    invoked from within
"prefspage_general $notebook"
    (procedure "doprefs" line 27)
    invoked from within
"doprefs"
    (procedure "::tk::mac::ShowPreferences" line 1)
    invoked from within
"::tk::mac::ShowPreferences"`
```

Indeed, 904b36b adds some `::combobox`es.

I tested this on MacOS with Tcl/Tk 8.6, both with Homebrew-installed `gitk` from the `git-gui` 2.49.0 package, and with the master branch of https://github.com/j6t/gitk (commit 9f27318), and with that repo's 904b36b. The parent of 904b36b works fine.

The workaround is to close gitk, and set `want_ttk` to 1 in ~/.config/git/gitk, ~/.gitk, or equivalent. Completely deleting the config file at ~/.config/git/gitk also fixed the problem for me.

       Ilya.
