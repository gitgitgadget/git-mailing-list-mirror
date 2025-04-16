Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406A1F561C
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812979; cv=none; b=CSGjijGM0AuBQWYvvYOSGtZRTRxV3sbqTIWap79WlCDgW7Le5NckSCWshfNSQAM0oKGaWpOAdULhNyLvxg2ZH+HfsgO+b8gSa5v0c0DjtB0CprCDekW53J7wpDQCS4+9XvR4HPdIHLpm4XW4ghnqEHiy9OaVDfb+Lgq+JjHrCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812979; c=relaxed/simple;
	bh=fsEiQ+utc/TeMIT4VsYH27gDlrQ5yyyF8V522PmDXPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NL6Eo2T239878Dl/aIiLPsUCCmhLkZv81vqUGyoZ2Q904o+JZErmT39luaqb+w9+gX8xYknJVzZdFKDAlfoHuYoXu+aQkrzuvLLBM35hh1C6uyoPix32aq3r4Ls0/hZcsNNZpPPxxjcFVMn8/2z7yBdQK8QbByQg+1Bm0HubfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vX2yHfb9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6QJv/b1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vX2yHfb9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6QJv/b1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 883AA1140089;
	Wed, 16 Apr 2025 10:16:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 10:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744812976; x=1744899376; bh=K4E5LKtTVg
	CHmLXPqX4FW2M52/VfRLWmR14fYh2YJq4=; b=vX2yHfb93pWaruA4gIK9DW6OhG
	rSLfVMxN18o/t2RNX4l358NqAZPeUjiTn0Ly1eBQaD92/FYxkpIzPe58IuEM84hM
	qN3cg4WFCiHVqt+8N1nUMVziVEpk2YTa8kApKKIyUPUmxyQWcshYSagTEsVW/kD1
	cI6PNSpb6HT1UXyJPaSuJhUJshcO0hjgGASdw/o/lLYGDgWkG7c2TE+hyD3L6hlV
	IjkEyfBQoWwnsUWkkOQlGDVJ1ubkWAKD3yGJONrokLEWekle65xTtmBgao3Mvds2
	GogmZFzTzUHhLoBnNqy5uDZybJMlbbD7XGANXe8YmgNtkXT2xZ+iNOfk26JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744812976; x=1744899376; bh=K4E5LKtTVgCHmLXPqX4FW2M52/VfRLWmR14
	fYh2YJq4=; b=i6QJv/b1YEO5vV1HtCF3jtjBDGEC1uaOirAeN0EwILnIJDvIovx
	k0SJrdp8yX3ABHN1otTGaAs5QTWfdEFG5KugSJWAI2ItSjJldYg+7R7FvkzX8MDl
	sfFZt11+PxUkyWOIUGVsZy3sJREyd/28v+VQpBFZzv+NHzs7uAnOUi7Fu/g2LRHL
	xTyio7hDis24rlFJrLu+2ymjbVZHf61oCNWHRDPefVr2x7cZtPg7a1cxZYd59/aP
	bkZog9IYjOx1A9juE5dd7QGEMPhWscfk8fVBPDYkiY0EfAn4Pd5Z3MMTcx4rc/Rd
	iI8ExPA+RILysi33m0xEmsix1BVEfJagY2w==
X-ME-Sender: <xms:sLv_Z_v5L9akQjkg3Zu2ho7iu4E9gcAZBEGtNl9U08jhBs1uIul-ag>
    <xme:sLv_ZwcOX7LaKBmWndsBoM7kSuX9ZNYAu94nKB1f4izAyxQ_-F78_PewkyY4wQA1c
    -qIVlurvbWCVIpq7Q>
X-ME-Received: <xmr:sLv_Zyyb51ABrclQvSI4Z00SIodQ8sTgAwlPkypYJBACoq2yIEkO1iiXuQdBnZHKyeQPFLS9Y49mfJD_iN3_orXSoUVUKIsTV8Rj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:sLv_Z-MFegEYD8HhC1Tq1dJU4oflRz14UrWWBjQqUzwsu9JdDhQN8A>
    <xmx:sLv_Z_83xsVMmbEAtvDS77xx1Iw4E0W2mpriQgRz03ujeYXci9aieg>
    <xmx:sLv_Z-WNr42B4-YixUAYwJ0CwpFlfu_IXWGRLTVaZo3SXIBXgtlgpA>
    <xmx:sLv_Zwe69OQociDNzHpymtoOeRZiDzHpqzRobjIb8eLU8K3fzce1rw>
    <xmx:sLv_Z4Ko3reNRc1t81TQa7SjtFooylvJcviCUqg5sSvQIVs60UOJK5Zt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 10:16:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
In-Reply-To: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Wed, 16 Apr 2025 11:44:46 +0530")
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
Date: Wed, 16 Apr 2025 07:16:14 -0700
Message-ID: <xmqqr01si441.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

    To: git@vger.kernel.org
    Cc: Junio C Hamano <gitster@pobox.com>, jayatheerthkulkarni2005@gmail.com

Pick a better reviewer than me if you want your patches reviewed
more quickly, perhaps?  I had only 3 patches to the file in the past
3 years, while there are others who had their hands to the file with
more changes.  "git shortlog --no-merges --since=3.years" is your
friend ;-)

> A series of patches extending my GSOC microproject
> Fixing the documentation MyFirstContribution.adoc
>
> Updated various commits since the last patches sent.
>
> Feedbacks taken to write detailed commit messages
>
> K Jayatheerth (4):
>   Remove unused git-mentoring mailing list
>   Docs: Correct cmd_psuh and Explain UNUSED macro
>   Docs: Add cmd_psuh with repo and UNUSED removal
>   cmd_psuh: Prefer repo_config for config lookup
>
>  Documentation/MyFirstContribution.adoc | 89 ++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 27 deletions(-)
