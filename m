Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769082D3723
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468906; cv=none; b=mkfQBDSwDKsX6LBgSvo9VRkr+BqtR7xXlw5Fc0OnMqaTq4bN0eW0qS1knqpAS1vWrlLsESE8N2SYk7HMiH+wJEoT+f4zx237BHFDv+iB4+F//O4mHHq53hihJDOUWm5hIlo3ByWPy/oWSFIGG+L4eX0rZkXXBB2jptnmECxzYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468906; c=relaxed/simple;
	bh=I0WfEpAGQvyOXfv+I5vaHt6Xe2YIckohbguPISp7/No=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8nvwY2WazYyJekB+WHadLfTq6TvLUqUZAZF5SGwAh8xO7eC9wfLmajQr/NDrPNtnWSX03TSz5Dqx83pUQJKXul5e9o/gDqlbH5suGgbQghK8ovZmbO6ecoN24ZetVNYBeiV17lceshzvtAD2tJbowcRo77HUIoj9qDgT8xjL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rawZPqBZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WVTiPzwQ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rawZPqBZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WVTiPzwQ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 896D57A027D;
	Wed,  2 Jul 2025 11:08:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 02 Jul 2025 11:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751468903; x=1751555303; bh=pKqlDYVM8Z
	+jrSjsA6+SGXCbjgg4V6je+EKutX823tQ=; b=rawZPqBZCWsFt5A0XipDQSV4FN
	nzmkLfuNwePMpA/heTsB391tNs6xd/bspp7Vv6M7gCZERB7k8HnG42KcfTSy3sge
	ZTXVR9qyxXvOixf9AdE40NQhPWYB1BIF/AYp1Ut3IUt4bnnjYeSQj8d8JqwgonSx
	PLIhVYNskOI99QAB9zJJ+11HBMSACXDwp085gOlO/Ekc3at4iLKw9Q7Y8nw/D6GM
	4mo5eHwdmrUkKlwmYcf78f7Utdu4yyVsk4D9AA8dB8u1FTmqvdcLRgjQmav18qbS
	CF7pXo82tNklHNBEs2qUfQ/Pjs8S79pT+JtchZ2Mtw5Wo0EzThuATH1KcOEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751468903; x=1751555303; bh=pKqlDYVM8Z+jrSjsA6+SGXCbjgg4V6je+EK
	utX823tQ=; b=WVTiPzwQ+QMNvhW9//QO+2c95xBj+k7irTN/PpEQWk10/9Rxztj
	LRBclcpoKpx+qqyQjR5nNOKnqPLoy+jtIYEAYI2uV8CvPj78SiXz4QzcQI5/6Ef3
	af5j6oXKEJUmDcTMON3Zc4ip+IVoEU1KwknyHc9/tZmWu966Mf1XJiex5nABNkYL
	Yk9unyofADacOzbF7EMhrgPv8N3DCxjVb+tppKsIvZ82SEcl5ynRtiGZxYd4pCHQ
	u5fReFBfWYuFiACcRecJlr+AUfPeftEq6geQhlKgUS4mxOoqP7I2iKEeMlZdl2/r
	xLSAmCb0NW8jsR/Zfs7m5kVCA2QTZh6+CuQ==
X-ME-Sender: <xms:Z0tlaA5JVuPtGF1rXnDx5ebnQECOneDthTq6eyAjfNjAWhWypYOQXg>
    <xme:Z0tlaB7LPRZIYccQ63O_NBvSUsMHeLZA4hPDqsIACaiSzbX7vLdtfDMvfAjCiSdT9
    QqoJw9h852MozS8Tg>
X-ME-Received: <xmr:Z0tlaPfH1DdVsiERliu2N9m_Dz4k75XXEArL1pfF3q0QW5FNXN6hm--DoStwTNkywvc7Ss6D-CAHweqXZrZ5DG9FiKZ-Xc4KVGUNgUgGgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejueffle
    fggfehfeelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Z0tlaFJ62L_ZuXx0JZQi-ENFHP3w1L44v-vlxOZFzZje1eozAdjq0w>
    <xmx:Z0tlaEKF7UjV6JKnqReSs1162R8eNlBPgkQZTCjqgyMl89NK5g0bBg>
    <xmx:Z0tlaGylmQhjX5ZKYPsWeZWYOIhgDemRUsCkV3i-iTKAHTUrYblnjg>
    <xmx:Z0tlaIIIOE4-b-7SqW1rZ5D5oIH0kDNePZgkrxxh7mJysuogES5TTA>
    <xmx:Z0tlaFjk3KU6FR2U4vt0nvIePcFO9s_MFbyD47euz9W_SwXBO4m_T3er>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 11:08:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f58b1e0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 15:08:21 +0000 (UTC)
Date: Wed, 2 Jul 2025 17:08:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] builtin: use default hash when outside a repository
Message-ID: <aGVLYey4Hemu7YFW@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-4-sandals@crustytoothpaste.net>
 <aGPIBa-1xjqk8EEE@pks.im>
 <aGRP0WiG8ZRzgilp@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGRP0WiG8ZRzgilp@fruit.crustytoothpaste.net>

On Tue, Jul 01, 2025 at 09:14:57PM +0000, brian m. carlson wrote:
> On 2025-07-01 at 11:35:33, Patrick Steinhardt wrote:
> > On Fri, Jun 20, 2025 at 01:19:35AM +0000, brian m. carlson wrote:
> > > We have some commands that can operate inside or outside a repository.
> > > If we're operating outside a repository, we clearly cannot use the
> > > repository's hash algorithm as a default since it doesn't exist, so
> > > instead, let's pick the default instead of specifically SHA-1.  Right
> > > now this results in no functional change since the default is SHA-1, but
> > > that may change in the future.
> > 
> > With the preceding commit in mind that introduced GIT_HASH_ORIGINAL you
> > could also argue that those callsites should be converted to use that
> > define instead. We always used to treat them as SHA1 repositories, and
> > we have no better way of telling otherwise, so we use the historical
> > value of SHA1 so that scripts aren't dependent on how exactly Git was
> > built.
> 
> I don't think I want to do that.  A lot of the functionality people use
> outside of repositories, such as index-pack and ls-remote, actually
> operates on repository objects and so it makes sense to use the default.
> 
> For instance, it will be a major inconvenience to still have to specify
> a custom object format three to five years after the switchover.

True. Initially it will be a pain for those edge cases, but the longer
the new default is in place the more useful it will become.

Patrick
