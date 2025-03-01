Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB51CA84
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843283; cv=none; b=CWxpKYPR1i5oyzqb3so8+v+94UBieIsXSVtNbRG1fuxWJmjodAdTMLZD+eHgqmsJdGJh2JYN1O1EzJa47ENW5JVS3HfmpDLhZQXcyq8L8Y9EHy3ajSvxSKgFnkXPto83RO9nIO7K7MMH2P9YXQau7HXn4s919StUGk6dvDOjw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843283; c=relaxed/simple;
	bh=ntg49MpnKiUGCAAnkJHubvwLFzThKu0DwGb1f8TbCyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK+K7FBS9wbkXHGjrwNnrqXCrcpgDb3TF73vExbr4e0aHsnre5RHR2LeQE/c2GlzA1Wo+e8/VyYnn4XV7jOSC8Ada9OgjC0ibdLb4xAlnfptEoBywaWn5UgYNX1ynnAvIYArzeMvln/BfA5O/vF2Mw+7Ar1NFkHN1LSbIEvjGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b9kj3YvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6zIzBXO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b9kj3YvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6zIzBXO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 10F3611400F8;
	Sat,  1 Mar 2025 10:34:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 01 Mar 2025 10:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740843279; x=1740929679; bh=6cJsusqSsQ
	Jrvi097fPgFVMY8SwSUpLiIi8knEE0kIw=; b=b9kj3YvD3nxxZljBt2fLR6TKBk
	kzgP3mcP3TxeCqwUWUj/jyHUfUtyOPIH/WIW0da0Bsuia5AtlVMkMkNXARLlJPoi
	9g31kR7z8ShLynkSPXd0ecNgSiYoHXgW3y5TPZqRxXqacQxiU7/fIk1zFJaRfyk5
	pd37AlWhr5uAKfnSMX8LRk85hWLUdKoPkz7yCY540pzMHAOiB4RDGhrGXr1BQhLj
	8x58zuA5H0bdHDuutTE407gD8j5g9OfNJKjSLJCZHzfqfGWzTpuP3f3UYzIIofA5
	Sao8rEjjg+1DPqOXGTO6Isn3SPRZPINlgeTZ8Xgkqqtl1iT5Rw7iHMQJnECA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740843279; x=1740929679; bh=6cJsusqSsQJrvi097fPgFVMY8SwSUpLiIi8
	knEE0kIw=; b=a6zIzBXOoWkbN38UjcQqWq/kRTt+RFrxfX/3wHpDFDzbCo/uFbi
	hGTEmfjRCcbj0jfh1CQ+z4maL9t4yItBHyV7xAWS+pwaba1NVqnRuQMTCEG0TW7Z
	V1Bqx60UdkXJj80a3eLralMRcp8umgF8Vm0j1XAvcQM5CXonAR2b4LWoZILK8Ec9
	6X6tjGPsMuiWR9pJfUFzwo+IVMVFfIX5DIWDee5sXCfiMWFkVfK+rdP/VDIEFyfJ
	4nzJ9l5RjELJ+dEIFgOowixqxfyKO5OGVJvxLWjFgMbg7N/uQLLsALHcgbHmjura
	YUeQqnEbsHZb9PLSFdlwcQ0BG5v94mbJvCg==
X-ME-Sender: <xms:DynDZyasYh-5pbn-JIZ9UM-qVEBoLL7EpEQh1se696NVw6emmzkWpg>
    <xme:DynDZ1aMq_LSqkIZ7kIGbbbkOwir_3k6pttuoWeMNjT_HOvP0PEFMVwM5_l9-zoX9
    m_frUD43KIsdCUuRw>
X-ME-Received: <xmr:DynDZ89cyF1dXPxt23nnovCNniGIIIlOE7diI8-RaVhBBQN0HCj7FN1D3RFi6WWtSIVtId_RWXN37AFVSX4wiEwni8G1Vz4Uaw07p-0oojTPya_cwtMy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    peffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghulh
    hlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedu
    veekgedvveffveeuvddtveeigfekhfdtgeejleehjeeliedvfeetgfejkeekfeenucffoh
    hmrghinhepthhinhihuhhrlhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtth
    hopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:DynDZ0rqaEcouvjqBP_etnk-HGoOSvnXnc2nEhq6v3Ce20c9D81TJg>
    <xmx:DynDZ9oBpg5UPczLyqrva91RzUxxvsFbC7XQ06rE5z31rvpl9pQ-aw>
    <xmx:DynDZyRCN6Q7yu93mfUUXkEXYAPK-SD0jW6giOTjvzdIDllyZojTBA>
    <xmx:DynDZ9oSwTSzk6U5zRvlVSnGAfYPNCIyABDjo197jhuSFQt9RYwplQ>
    <xmx:DynDZ-liDCzMFZx8u3XLvzlqPIctSN2h5j7iWH8EgMB0nQuNeSRt6Y25>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 10:34:39 -0500 (EST)
Date: Sat, 1 Mar 2025 10:34:37 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/3] contrib/contacts: rename .txt to .adoc
Message-ID: <Z8MpDTLpmDs5Qiz8@teonanacatl.net>
References: <20250228034713.203461-1-tmz@pobox.com>
 <20250228034713.203461-3-tmz@pobox.com>
 <Z8FwIqnYYPk5bV7O@pks.im>
 <Z8HAv5I1hoNiQYoa@teonanacatl.net>
 <xmqq1pvh3o00.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pvh3o00.fsf@gitster.g>

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Since this is only in next and the first patch of the series
>> targets a "breakage" in 2.49.0-rc0, should I split the
>> latter commits into a separate series based on next or is
>> ef18273a2d9 likely to be merged into master before 2.49.0?
> 
> ef18273a (Merge branch 'ps/meson-contrib-bits' into next,
> 2025-02-27) WILL NEVER be merged into master in any timeframe.
> Doing so will pull all the other merge commits on 'next' into
> 'master'.

Thank you for patiently correcting and explaining that.  I
did intend it to be as you described, rather than merging
the merge commit.  But I was both lazy and sloppy with my
wording, unfortunately. :/

> According to tinyurl.com/gitcal, we plan to tag -rc1 on Mar 4th and
> -rc2 on Mar 10th.  The topic ps/meson-contrib-bits will have spent 7
> calendar days in 'next' before we tag -rc2, so unless people find
> issues with the topic while in 'next', it is expected to land before
> the 10th.
> 
> Creating a merge of ps/meson-contrib-bits topic into the 'master'
> (you do this yourself locally), and building your series on that
> merge commit (and you send these patches to the list, saying that
> they are based on such a merge in the cover letter) would be the
> most appropriate in this case, I think.

Sounds good.  I'll send a v2 with that shape momentarily.

-- 
Todd
