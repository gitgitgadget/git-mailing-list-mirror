Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AF364025
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941984; cv=none; b=PKurTBYgO+TZZzXp+qrnH2Pz0CL/vIU9lcyNwc0nC6/XgBKFsJNecQwezoCQN8r/3YFNt6YydtPl11FH+6ilud1AAqsZ7b4ptSknsR0n3L50m70H+RETrmwap+WFU1v/EXnOYtJd9M7dfa58z2cV5XHRe06mH4XC1h+bW4jxDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941984; c=relaxed/simple;
	bh=YJlGpjk4CQbubQzgKdBDO9sdwmiMN/JIhXATBo5HaeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ed6AP7wTYD8a9tLwWY3Ub5ILW2OlCJNESdKpvsIb8XzO/07nI1cUYEz6qE1Diu//XnyEA8oUb2D2HxYIRZ4c77XCH1gjEmU2MTYOlQfg4WxoOwDGYonuMX/5cBSuRMZ0oeJlzzfGwcfZdliMy0UkxBDb9XpwQ4vTn+Tycng7fhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jZJYpe+A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gs4KoV0X; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jZJYpe+A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gs4KoV0X"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85C237A006D;
	Tue, 20 Jan 2026 15:46:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 20 Jan 2026 15:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768941980;
	 x=1769028380; bh=5HjTGdL15LOsYOsoFQlMUfa8h/ROCyYvv8LEtdwtZRg=; b=
	jZJYpe+AKLNPxZCwN8TxRwzMcWltbwXrVPrirohPTzqhCPm88tCKobupxk+58ptN
	aEpOyLd3q2rGMrNMx/EXNcOs3qoHpcCX+A5BmaOshs2DAHPhxrR80mgvudjhE2P0
	+3gepgK83cbgAeP//lmUaTejgM+FWaO9Pwk+nPgYHj1w8H/T896sSLUIqsIGwo5u
	QnaQMEdrkeG8gRtahFIO+vNr7Ul8eX2qsgHqawd/3mnApIrJt7sEujfJVKyIYD0b
	lAOA+Km1vv+lggd+MvD/R/KBUccOjycyAJcu1QdyCYt9txi1pZ1jtBCM8bH2uhor
	jQm5mW2pDIiUudgHsny8Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768941980; x=
	1769028380; bh=5HjTGdL15LOsYOsoFQlMUfa8h/ROCyYvv8LEtdwtZRg=; b=g
	s4KoV0XXjkjfthrje2/a4IhZutrTgPOU9PFsKQyqBCBlgLze2TNI8ajnk84UPhae
	DJIXfNDxcq5ljIjU/1b2zJQgslSEpI9RtwwIXlNuBrntFTx/O0OaB3otblGwzhLU
	3CIWRawOq8HAlxeFBNS/zzBpCQjp0u9xhy/LzlqSE60O1OVCrFYcI8MuH1SfW2pZ
	9AJxSxOyDZrpyKD7DjVzAy+P6yWXkeST94nikc5t/plncOFKsZaAZPWNZ1R42Doi
	AtyfLOk1jLHKRtD0t6DogCOM7vi/1PZsFoPrT0gTzkwp53n+RUr8/xgwC2SJLDY0
	gWph8mnWj/XISSI8GOqVw==
X-ME-Sender: <xms:nOlvaZLgmY-cts280Lu4rvislgDycPn-jZ0-C0D55ld7fTElIeYwpw>
    <xme:nOlvacnBsbh-5u-xWoLAxNtlqa6DJopzkv1Y6zTodz9LGsz1NkxIv5euE5TGwj8Wm
    3aqASPd12Y2p2ubiQNiFkrKmIdiaqq6LBinISqgtYNtbcDXAWcbIw>
X-ME-Received: <xmr:nOlvafEglH_R1QiZxH5IL7wuYI4jdAOdgUjqWYDLuJe6qulQxmMhnfj1Yzgy3_py-6kaYn5MUhUCKr3IxD-HyWPbfDQnyiaa0WsnTqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhephfetvdejheduheegleehfeeive
    dtgeelfedvffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrvghnvgdrrhgrhhhnsehpfhhiiigvrhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nOlvaUEQoawoWYwPvjvrS7IKRzZ_2-lJCPT5GlNthIRwQg-pND0TiA>
    <xmx:nOlvaUPNe_nXJb8xPTXx3IDX0tjU_CdaVK_Q67qa0T3JHEQr5dh1Fg>
    <xmx:nOlvabEYdtJACKocouNkRYormIm7oJPjaRpD4Igb7VAJAgP8rdnCjA>
    <xmx:nOlvaTOTdmXr8VRBL4rstnXDx4w5vZUS4mp78PwDXpU4-WohCS4ThQ>
    <xmx:nOlvaTKmf9wOJqU1pX5Us79mjd0lnJ-Yc8o_2P5Dwf9jOx-jqm04GZAz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:46:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rahn=2C_Ren=C3=A9?= <Rene.Rahn@pfizer.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-add ignores exclude markers for ignored files
In-Reply-To: <xmqqtsz9o3cn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	04 Nov 2025 14:11:20 -0800")
References: <MN0PR01MB761143093D1A4D226E8883A380C4A@MN0PR01MB7611.prod.exchangelabs.com>
	<xmqqtsz9o3cn.fsf@gitster.g>
Date: Tue, 20 Jan 2026 12:46:18 -0800
Message-ID: <xmqqwm1cxbad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> "Rahn, René" <Rene.Rahn@pfizer.com> writes:
>
>> Steps to reproduce:
>>
>> mkdir git-add-test
>> cd git-add-test
>> git init
>> touch .gitignore
>> echo “ignored.txt” >>.gitignore
>> touch ignored.txt
>> git add --“:(exclude)ignored.txt”
>> 
>> Expected behavior:
>> 
>> The git add command recognizes that the file ignored.txt is
>> already excluded despite of it being ignored by some gitignore and
>> thus does not check if it is ignored or not. It simply will not be
>> added.  Note forcing git-add will do the trick, but this could
>> also have side effects for some files that are ignored but not
>> present in the list of excluded files.  Hence, this can’t be the
>> right solution.
>
> It is not quite clear what you want to see.  The command would not
> add ignored.text even if you give ":(exclude)ignored.txt" from the
> command line, would it?
>
> This may be an ancient regression when e1b8c7bd (dir: remove struct
> path_simplify, 2017-01-04) was rewritten exclude_matches_pathspec()
> function, which was written in 29209cbe (dir: fix COLLECT_IGNORED on
> excluded prefixes, 2010-03-11), back in the days before ":(exclude)"
> and other pathspec magic was even invented.
>
> Perhaps try this patch?
>
> I have no idea what the ramifications of the change is, though.
> There may be unintended fallouts in some distant corner, even though
> it does not seem to break any existing tests.

As I haven't heard from anybody if this patch improves the reported
situation or there are unintended behaviour changes that degrades
the system, I'll drop this topic from 'seen' soonish, as this topic
is not exactly my itch.  That does not mean that it is unwelcome if
motivated others pick up the patch and polish it to bring it to the
finish line.  Anybody doing so should consult the original
discussion thread [*].

Thanks.


[Reference]

* https://lore.kernel.org/git/xmqqtsz9o3cn.fsf@gitster.g/
