Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744B34D4C4
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448780; cv=none; b=DbsOrTjUVxhaT7ObJgTBl5WNnF++18mWqhabB8uYWBybbsjcVD4EPv7zCLC2aAbMPFO8mISwcz/k7rQ56Z+DH8RRJTVgDcxi+JDkjYt2zoFuI0YMX6VOhKHlNXZPcz5XP06pBbRYZsDmqLQVMrqr2W2GxOuAV7UPyO/rSUuZ0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448780; c=relaxed/simple;
	bh=bEUfjk10HsB9C8MGtjzqkpwHDbWW/lnkmqDFnuP9k3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RSYiLWgnMR+r1ONccxqnAZAJkD2e/n+P9xxmXk/UeeLOBkRCvw6WKy/6Q1qsdNU4ZknyBLjHlcPdKjXvlbAeWUejKhFamowL9RGVXd4KQMQAXf2t7nF1oMOl2xMGCHR6YYwRte997F2iWj7lvUwb6s3GwwFs8SzBG1TeJi+N9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X/pe4L5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jh/D7RUG; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X/pe4L5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jh/D7RUG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9136D1D000C4;
	Mon, 26 Jan 2026 12:32:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 26 Jan 2026 12:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769448778; x=1769535178; bh=NWr9cHd3PU
	RpqYWWiAzDLwbiEfrxAfCeXLs7NO5/iyw=; b=X/pe4L5ryAzPmjs3/tm1tQzq9v
	nsEHwu7i97WkRqvix0VStRNBqyDo8Q5Jg98wwi4E6rOPsiN+2Yc3vtsXJGW4hcfR
	9bIII+dvotmBINQm5eCEgLQsXWpbOH5b57NFXUhq+QFJlVgLZAyE/RJo72CNEYS8
	4UyTSLZQYvr3Fj9qDsAcNWFu8B5+QuaA8LLy5FWbe8XyFtqWm/j9UNIoReOYAe/O
	/uyFtUk/TDvCVH+zts6LPAzJqcpGglWnVmX9GF86F2eDVSQzR3oOk/mEhE6mfXQY
	9tRvrqY2reFusn63KoIqVJjtsnN/fEun6xB81HVx1+/DnAx2vOv1RVkr5g4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769448778; x=1769535178; bh=NWr9cHd3PURpqYWWiAzDLwbiEfrxAfCeXLs
	7NO5/iyw=; b=jh/D7RUGqCDvcorReunBW76CbQMVVEE2FTTsHP+ExirS1C+pjii
	9WMg8gXdbKM46tXlCrvnjw9kJelXpu09IgdmQYMK4d+qDC+EUiquib7qThbhyYQg
	8YlFZsfP957EuNogZua1nGGBaHL0km50sTh37kWGrDnnp4jlme9E5ubL5W+1LBXB
	EBrJz2ub9xmrXr157YQCkShPGQmDUTyThLfWhO1Ma3tPx7TXXBsnmMSm8iddWYxW
	oEi0YhtfcqkF7MPmatfTWN+2bYfL+g1jQKh6r6b85ubyx/2ntF212xv2rDOUORKm
	NYh1FPjZfG+pKhY5knwiTbVxKtEN4nRaPkw==
X-ME-Sender: <xms:SaV3aYt-jHlDgwqvzLmGVu2iM_CkJDOmrbSQXMaxlONlg_PjDzkvfQ>
    <xme:SaV3acWp00f_-iPoqI69Xp_GEoB0KD5J9uw0lkDT1mof-NPeOcAVS86UnXCdHeSSl
    3gWxJqyjRN5cSzzxFr8iWthcqVm13faO4vfBvjQNoZ_ALqKP-PYyXg>
X-ME-Received: <xmr:SaV3acHZVLqQbg6hL-sa9axr0X3GT7LwBTmJO5Xzy22OqyvP-eWwcMeHOPkJo64JcOoNdjO-6ou3s-tWf2cZuDYutTbMzPiD3q4EMMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghnugdprh
    gtphhtthhopegthhhrihhsthhirghnsehhvghushgvlhdrvghupdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhsthesvgifohhrmh
    druggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SaV3aW1HUTPEvVrebLlu63hTGgscSC64wl-6dTZHWnm3p5KTC36J_g>
    <xmx:SaV3aWMUWXNEBhcMmyQfklowgjr-RPJICYePfNr6VQOmS2oQhywsyg>
    <xmx:SaV3ad75fs7vua80KQVVDitzF5PsfGdD3lko7HckfmpvXA8Ekb4usQ>
    <xmx:SaV3aY0fbzN8uDUsLhxTB-SE18kxa6VulOAm0-Jvty89WhxgpARdXw>
    <xmx:SqV3aY8ycxl_qpgmovLfMBpxDsG5_HhbNZjejyKUHPh1IOaETuyDWhee>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:32:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: Christian Heusel <christian@heusel.eu>,  git@vger.kernel.org,  Christian
 Hesse <list@eworm.de>
Subject: Re: [regression][bisected] git-subtree remote desynchronization
In-Reply-To: <023ae712-8f67-441c-aada-fb5b097ec617@howdoi.land> (Colin
	Stagner's message of "Sun, 25 Jan 2026 23:14:25 -0600")
References: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu>
	<xmqqikcql8cq.fsf@gitster.g> <xmqqecnel2fs.fsf@gitster.g>
	<023ae712-8f67-441c-aada-fb5b097ec617@howdoi.land>
Date: Mon, 26 Jan 2026 09:32:56 -0800
Message-ID: <xmqqy0lki8jb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Stagner <ask+git@howdoi.land> writes:

> On 1/24/26 22:51, Junio C Hamano wrote:
>
>> Unless a fix materializes and gets verified before -rc2 (scheduled for
>> coming Tuesday), we should revert the merge of the problematic
>> topic.
> Understood and no worries. This is a surprisingly complicated issue, and 
> while I've made progress I don't think I'll have a fix that is mergeable 
> by Tuesday. Feel free to revert as needed.

Done.  Thanks.
