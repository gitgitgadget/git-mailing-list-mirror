Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C03009CB
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626261; cv=none; b=o5DRfLDMddqpi0YNVhQ4EdC6E2yeGlcxVDI9fNRdq9FvcV3vcVps1JnuGIEqRjTNq01IjzFr302wzYICJjbpbB8vA5kBX6ShZVuy5mZdccMNXijfDnzmoViMU2tSjzZqKSzY079lGGUWYWHwNnasU48EtwCHvZ4uFUr8slxkgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626261; c=relaxed/simple;
	bh=XQbg0JSnxA96Xj67M5EZvAkO+4ah2FWoRUOvgtgDQFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3SBDjSRZbcrCATBaike0935z7WXIz4EXAa2O/JUew9NpAaVHS9RX5cuHaNpDnQiF8+ifLV1PospAfuGg9QcYc0VV5YbKRyReYTE0c7Mw4kO2z9Vsc4vEgPiX82aBZHg0F7KyZkdbW1+NGR7T7eu0peaoYJ4G2ZHUmwwy9n/Ovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nue6Nnw7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OkbfJr3i; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nue6Nnw7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkbfJr3i"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D58B1D000C9;
	Mon,  5 Jan 2026 10:17:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 05 Jan 2026 10:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767626256; x=1767712656; bh=WmScXHmA3+
	eaYTh5xpJkjEEDaVGGmzHzHvy/JjducrI=; b=Nue6Nnw7FSqGivifxr+sa0bfKM
	NZP7WPoDzHXcdxx+5AmjKz+imgiNMvBKYJVj83uG92s3XyIhy/aqH0K2RC9ZYUO+
	vMdcZoVw9vQrj+QOdXpiqV17YfCC0thSQwuB+u5ykd/GyC51BmYbu+AGVEtE+Kfs
	0PzpNBiAFoT9+BNqagD4i8eycVVWSYOnP8Z1uOew0aHt8Zz5Ngocw0RyjGZkmkrY
	7KBwn9ClmdQ7PvOwmxdRHFmJXH0k3ZTSIDJmxyt2VvmJiRkLy7nCVk8Ik8nW4Id3
	X//hzQDkuysHdq0w+WBIbIJXTebSETLVyyICjZo8+old+pUnR0wyUQe/RHVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767626256; x=1767712656; bh=WmScXHmA3+eaYTh5xpJkjEEDaVGGmzHzHvy
	/JjducrI=; b=OkbfJr3iB/ENF098KZ4qawKL6bpZoNrR1ihIhHY5Fcu9ZbmDOtr
	TFwQf3195sDShqua8jKT1b1EC2oDUQNqZdtklQTiALuGvsbGXvzvlITqxV6p+goY
	u1HdVcMVBp9wwzEsWz8Cc+dtgxwPcQJ5PLl1drVcEGDteTi1I7vlKHgkuUFkgdXe
	cRIqLf9+Z4LIQBUbS6KX6KRhu6NkPRg0X0cVlW4BlQeTz/WHEHKxIXTC8zWsdqtg
	Km7eI3SQGpQcACCkZyttAX5EODlUWt3kaczcxSiwZBj+oMsf41xY7GJXWVmnUSxG
	UoRW3tHEjEtWZCJ7z/tKeqTC+uuNL4Nac0A==
X-ME-Sender: <xms:ENZbaTsr8MKp0_GtIGvpEBEWn8-p4sJ0jft8WfNqQ95IE_v4m8oIsw>
    <xme:ENZbab5hT32ZBM2S_uMH-_LgIg261RweYMkqbt7PBivwxppjSfihWtVEux0CejWZ-
    jhTiH-q6T-At5D0ylt72W05buhD0dlYU6n4FqmhNrC_WJHz3HrbcKE>
X-ME-Received: <xmr:ENZbaUJaQ8DXItKBpzlUfiJ26chrHya5AgLmNOON4Uuqupn7JB8xY2J6eXziDO_eu7lE-enn6iYcsYuuC-R-U6AZfOEKhGlY6QyybMmv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeeludekgeegieekjeehlefglefgvdevieevjedvtdegkefhjefhieetfeduudenucff
    ohhmrghinheptghouggvsggvrhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehguhhsthgvugestghouggvsggvrhhgrdhorhhgpdhr
    tghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:ENZbab49Z7li3n6nCuJ9FbQQpbMrVUwpT-xhnl9clwHfW_tbP-93Cw>
    <xmx:ENZbaXx598sTliHyXVAyRyLLomnDnaJn_GhCjs3pm756YQb02CjlIQ>
    <xmx:ENZbafaiZcCdBu6WL0CbK59V-HjFhWMHvba_4cppxgKDlq8KZzuhWw>
    <xmx:ENZbaZRwSjiGcsj4DCRgi6GGWemAw10wLdJVP4sGkvnauTbMiAe46Q>
    <xmx:ENZbaYlSXw09agKSkIn_TGv7bTOQO6W_AxDRV3p9muDU2G2CSxoIyPyT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 10:17:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2122d747 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 15:17:34 +0000 (UTC)
Date: Mon, 5 Jan 2026 16:17:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Gusted <gusted@codeberg.org>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: git-last-modified on bare repository
Message-ID: <aVvWDDtBeJMIF3F0@pks.im>
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
 <aVvSwkK7RdpFDaVv@pks.im>
 <8e6dd4d7-6e0a-477a-b10c-8571d6b7da4c@codeberg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e6dd4d7-6e0a-477a-b10c-8571d6b7da4c@codeberg.org>

On Mon, Jan 05, 2026 at 04:06:39PM +0100, Gusted wrote:
> On 1/5/26 4:03 PM, Patrick Steinhardt wrote:
> > On Mon, Jan 05, 2026 at 02:35:56PM +0100, Gusted wrote:
> > > Hi,
> > > 
> > > Now trying to actually make Forgejo use git last-modified after being
> > > pointed to the non-yet-documented options but I quickly noticed that it
> > > looks like it does not work as intended on bare repositories when looking
> > > specifying files.
> > > 
> > > $ git clone https://codeberg.org/Gusted/math-accuracy
> > > $ cd math-accuracy
> > > $ git last-modified -- LICENSES
> > > 768f05837e7db2832425bc3b65d0f524e81b2769        LICENSES
> > > 
> > > And on a bare repository:
> > > 
> > > $ git clone --bare https://codeberg.org/Gusted/math-accuracy
> > > $ cd math-accuracy.git
> > > $ git last-modified -- LICENSE
> > > fatal: ambiguous argument 'LICENSE': unknown revision or path not in the
> > > working tree.
> > > Use '--' to separate paths from revisions, like this:
> > > 'git <command> [<revision>...] -- [<file>...]'
> > > 
> > > Is a worktree required for this to work?
> > 
> > A worktree is not required for this to work. The problem is that you've
> > got a typo in there: you say "LICENSE", but the actual file is called
> > "LICENSES". If you spell it correctly it should work alright.
> > 
> 
> Ah, sorry the typo is on me from copying the wrong command from the shell
> history. It produces the same output with using LICENSES as path.
> 
> $ git last-modified -- LICENSES
> fatal: ambiguous argument 'LICENSES': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'

Hm, interesting, this works for me in a bare repository. Has this
already been fixed...? Indeed, bisecting this points to 05491b90ce
(last-modified: support sparse checkouts, 2025-11-29). So you should
probably try with Git's "master" branch.

Patrick
