Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3E42983D
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122507; cv=none; b=XbZrGjepT+FcPAX4vAUfFh2u3yCmL0kedqfmgSZn23WRAG2udNRELllxnJhbInwdlU4Yu80JM5868kizZbDTasu7NrUlNIiIfqUdo0rZ/xqkCE20BrjrPx/GadFL+sbJtcoyTUit44PH7ybwhoScz36NaIgHpsn+yW1CLSm6BS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122507; c=relaxed/simple;
	bh=Rp9Cp7P3+VJbpwCzZCA5lmOLA9pgWlKZHbojsKZbeIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkDI95wG5vzep7HQOrVTiwRh7KKVMMln/a+hwrbqiACe6T1TdmzaOJKdejx9jq3FvkLsQthD/2bg3vAcsiHkAZgHagM9oBHd/tp3W9Kr/S/fQ1z3dxmCrjIXz/353D9aBTcDieJ6jsyN1cTxAHyXUbMwMMOEnHUdM65DfJ1Gal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iVxCIYcL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1zGpJol; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iVxCIYcL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1zGpJol"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A014EC05AA;
	Thu, 26 Feb 2026 11:15:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 11:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772122505; x=1772208905; bh=M5be925ac+
	y77JZ/o5a3x+msO0Y8aDMwMv9bPohghq0=; b=iVxCIYcLKLyi5xvkk1f7LJps+c
	Pphtr+DJldmkSNPeyHWrkVOnPodX+GDyCSA5YO9XA1T68uNUnmC/YUPnmUBkqbr7
	WpjXA2plmGsRLGqaiApFnOHF5iEkd6JQGoLtnOR39x/TY8hwTXY4PHGq+yMJ5JJY
	C3w1H5363gszJ28AKS9dESBhKhoUtfA8ZshAAfmwplr5UC2lgdq1vCdiMSu6MwAu
	LOE/K4/hA1qLkJQcG5C8zGCyqhSUfuSnXBwCheyvLR7DhPBZjNRfTHWmTWOFzRJY
	2NK9XOHo3KNLeZitQUU9wbEZWbpQ7ilvtdyPdXKzSAT0svuQpBjoOSrp1Feg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772122505; x=1772208905; bh=M5be925ac+y77JZ/o5a3x+msO0Y8aDMwMv9
	bPohghq0=; b=b1zGpJolPJv8jXUR1gd3S+ACwumvy+BDtskN5z/79gMIYoa2JdV
	sGPYeE+v0GNGp3uk84DkULMjsn760mSg2f3bGoDpTPXDjtrAXNmeAam9qzX7Fr7w
	QOfOnygVyiefWHYt2kdwAQbIO0F+6VVEpz1gT7fc1/mA9iN5JPWNt4hYKq6tfXNQ
	fPL82BlQ51QUdpLMrNJVo/rdl2jHaqrHC5DkdtV1x73b9ec/rF45tSceIkV0bYfo
	9x5GJ98ntLBm/gQHEJjS4NlaO1tKjawv30H97neGlPCkDWHxwpZ8aGpDN/cduH0a
	sqF2zgVs2LsT9aWDCnWdB1Q6DgVMCbPMnKw==
X-ME-Sender: <xms:iXGgad-QNg98468hREjp0_ktR9CKuwqArPAr2_E6NUawTi7u6eYt4A>
    <xme:iXGgaVZKaWfS4nGF6wfOQQCDBwoQo7klxeEmCXUGVQVX2pzUQRB0PyjVOX_70936i
    kQ-s7l7gnf4uC2p9tH9T0-KQxeD1w5atZqVlU5otMyGURPcWxKP>
X-ME-Received: <xmr:iXGgaU1FqQRzTERuo4yuIn6HemfhYvRwBVurDhjROawN2UGZBk9ESIkhdsGiAKUh1Bj6MszzdGYPzhLTUvUJMxY9SnJWnaRLww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iXGgaYYfP53rUZVJ9l5DmcXBe6hfDbjgaMOTyUN5bz6CGEE1oDTQwg>
    <xmx:iXGgaUKfMFRcbtQQc6mjyZ7MEsQ19p0XpL817P7cFn_3KdqTrvC6Gg>
    <xmx:iXGgafE50SMcakVslL8Q6q6Ws-yxi2FhDzfGrOBi6k2lrIUoqIdopw>
    <xmx:iXGgaTuoWLD6z7TD7mBabWSDMtBQhhOgZpb2YciUCgrP-5hHJc_dYA>
    <xmx:iXGgaWquDAPSHT-72RvfBDKXi7z5HLDexRZAST6Gm62AO89mfju-oWIz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 11:15:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Shreyansh Paliwal
 <shreyanshpaliwalcmsmn@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/2] wt-status: avoid passing NULL worktree
In-Reply-To: <d5866041-3e2f-4f5e-a8d1-725fd3eac2e2@gmail.com> (Phillip Wood's
	message of "Thu, 26 Feb 2026 16:09:48 +0000")
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
	<cover.1771511192.git.phillip.wood@dunelm.org.uk>
	<902295b87146e5cb5358cebab51f8d66701290a8.1771511192.git.phillip.wood@dunelm.org.uk>
	<xmqqv7fs4jlp.fsf@gitster.g> <xmqq4inc4ghg.fsf@gitster.g>
	<8397f971-39dd-4a18-b520-3157ae15324f@gmail.com>
	<xmqqjyw0bve6.fsf@gitster.g>
	<d5866041-3e2f-4f5e-a8d1-725fd3eac2e2@gmail.com>
Date: Thu, 26 Feb 2026 08:15:02 -0800
Message-ID: <xmqqy0kf4h2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 25/02/2026 17:11, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>> This series isn't in next yet - shall I re-roll with an extra
>>> preparatory patch changing is_current_worktree() and
>>> git_worktree_git_dir() to use wt->repo, or are you happy to have that as
>>> a separate follow up on top of these patches?
>> 
>> Thanks for investigating how we got here.  I do not have strong
>> preference in the order, as long as we eventually get there.
>
> In that case I'll send a follow-up series next week.

OK, then let's merge what we have to 'next'.
