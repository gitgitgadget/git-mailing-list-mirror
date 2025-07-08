Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5562BEC30
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964272; cv=none; b=onXYhGFTHIW5ZGNXPMNImB8M7RQth4JxeS1tRi8UeZXN67KOaeN7Sd1Xxmi5LWxRlFd0YL6msk00E+VpZNNGncYSt/PNQek7Wr5gIb9vwFGqoh0FqsCMVvVoKlXeE0I1KJtSbeYHPxCQWkZs2KNndc4Mpd9E/KIFh5YQl7loqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964272; c=relaxed/simple;
	bh=MVe1wsoJvaNOnd3j2v54sUy9hnSY2nNI9FKQSOmWe84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtfCsSHP1ByRckmgkkyDSQ065gI/jeGwI+bjubuwWCatuMc7RF/sublz+s5zeNhr0Z51OoKXu+U42IqtooDAxt5OxtEokKbrhrR6o+ISxg0tdXTgPwlnhxLwCCKdmklcwzFSJJIIpoUAp7lb2L2OVGaYWTHdECU7xEuKytljaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hCsXMsxr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FERMAcXb; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hCsXMsxr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FERMAcXb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 027E214001BB;
	Tue,  8 Jul 2025 04:44:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 08 Jul 2025 04:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751964269; x=1752050669; bh=IquHOl8uem
	bPMOnHk4F9po+t/LqJ9RkBCEmrVxk7wTE=; b=hCsXMsxrXwTKIc76WQ7fcjwgiR
	DX8HyC5j5xCvvI3s/hwkuziXWbKiDUDSs6n3YicxyiYPAuOaLBgd8Ixyb9+zG+X2
	nANlt/1kb74x7jFL7fbomnymzfzsNMKv/kEQeN6EU6w3LXRct4tK+OliF7CYJxdi
	mmvI5isDT9xILerJwe8XzLObFFy5mahQ83zJyliy5zqzACZ4OnN9olvNmdY+ND8U
	GC181lnQdm+yH7CKTna7GBYrZkylqX55NCBApQR9nkEdbq3sSqqJQP33KkHgbgYz
	kLmOIQ7Ap7yb+TxDHYxUOs3ncFkBx6QVqwWYX4l+JP6kZE7538AFavh8qGoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751964269; x=1752050669; bh=IquHOl8uembPMOnHk4F9po+t/LqJ9RkBCEm
	rVxk7wTE=; b=FERMAcXb53oVYosF6HT41BMoi+o5bfwhsUKEPw/MwZYS32uKy2L
	WuqYFiF0AFPMmGlu2oOBtJioGEpSrG6DlNA7Lo/0ew3aKKSWkYoQImDpFceyb8hO
	BzEvcc3avgHALbV62TQvPobHs7HrfJJzVbAq7SFD1NSLrflaIEKElZr1YKHvcZJa
	d6giuaV77+QKu1ddprDaQbzerZueAkhT8mZZ1yAW5oX0ZN5rOKXz98pmTVFCpJ+h
	f4LvxZN2vh4V/g890JX1XLkc4hEWmQOfvcsq6M2S9yxzXOfLsVXqbekzk1d6pQUM
	cJ3nLtlBuemXBYPN/9eErGoLfDVykcGwcrQ==
X-ME-Sender: <xms:bdpsaNeOFn1GotRJnZ074Ktz8NwdbxCD85qzjgh2iPiKoq5gXisD-A>
    <xme:bdpsaEoxZVQSqYNP6arx0j31AjV1unBIyonnlyOgM6Mi_LY3ei6YhtpoIGvp-MyRf
    v7wfp7qFkYjKVy-3Q>
X-ME-Received: <xmr:bdpsaGHGLMSSGXTqx8GZxJN_qei-6thJr3q0_-va4BM0t935ceQOeoCdPUUl-T9qoNv11iYrTLQT1H0qO-7zqHd_MYxU8OZ4-Ztvt_iPH9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehirhgvtggtrgdrkhhunhesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigr
    rhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:bdpsaMuwokhBbZQjoS2WtNpLuQf55IkDy-u-kW3D4ip1RNjaMgXhtg>
    <xmx:bdpsaAWPbDifEAYjrSCaARgAmjndeuSx1AOAcI7Vo09pgcoOHTKwBg>
    <xmx:bdpsaAH2ZWBv0cHzCH3-QV5Jj0seCp2_2N02LwX9m7cfPr8U3k2FKQ>
    <xmx:bdpsaK3O-9Iq4MnIh2-jWTWljNeuN7p11yTUD17X1dQL-ngQtXI6HQ>
    <xmx:bdpsaN7knGZx6k79_muCsDEgzG6BOhcipvSF5eQ2jAnuVBdQHOvcRjE7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 04:44:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ef3bb09 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 08:44:27 +0000 (UTC)
Date: Tue, 8 Jul 2025 10:44:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, irecca.kun@gmail.com,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 6/8] meson: fix GIT_EXEC_PATH with overridden
 -Dlibexecdir=
Message-ID: <aGzaZ7zHYbjzFo23@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250703-b4-pks-meson-cleanups-v1-6-2804c2932abe@pks.im>
 <ad58469d-e8a7-4a9e-9f34-2afa68458f00@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad58469d-e8a7-4a9e-9f34-2afa68458f00@ramsayjones.plus.com>

On Thu, Jul 03, 2025 at 05:39:31PM +0100, Ramsay Jones wrote:
> 
> 
> On 03/07/2025 10:28, Patrick Steinhardt wrote:
> > In 837f637cf51 (meson.build: correct setting of GIT_EXEC_PATH,
> > 2025-05-19) we have fixed how we configure GIT_EXEC_PATH in some cases.
> > It was reported [1] though that this causes a new issue when overriding
> > libexecdir with `-Dlibexecdir=`:
> 
> Yep, I noticed this report when I got back. My first thought was 'no, we
> may just as well revert commit 837f637cf51', since that is in effect what
> this patch does! ;)
> 
> Then I had a quick look and left a diff/commit 'note to myself' which
> effectively did a global search/replace of the string:
> 
>     install_dir: get_option('libexecdir') / 'git-core'
> 
> with:
> 
>     install_dir: git_exec_path
> 
> and put it on my TODO list. (Note, that is *all* I did - I didn't even
> attempt a build, let alone test!)
> 
> Of course, I need to spend some time on this (if nothing else, git-gui and
> presumably gitk will need some changes as well?).

Neither git-gui nor gitk are currently supported by Meson. I do have a
local patch series that backfills the support though.

> Hopefully, I can find some time soon (those round tuits are in short supply).
> 
> > 
> >     $ meson setup -Dprefix=/tmp/git -Dlibexecdir=libexec-different
> >     $ meson install
> >     $ /tmp/git/bin/git --exec-path
> >     /tmp/git/libexec-different
> >     $ /tmp/git/bin/git daemon
> >     git: 'daemon' is not a git command. See 'git --help'.
> > 
> > While we correctly propagate the libexecdir to Git's GIT_EXEC_PATH, we
> > forgot to append 'git-core'. Consequently, it cannot find its binaries
> > anymore.
> > 
> > Fix this issue by appending 'git-core' to libexecdir. With this, things
> > work as expected:
> > 
> >     $ meson install
> >     $ /tmp/git/bin/git --exec-path
> >     /tmp/git/libexec-different/git-core
> >     $ /tmp/git/bin/git daemon -h
> >     ...
> 
> Hmm, I'm pretty certain I tested commit 837f637cf51 in a similar (but
> not identical) way! ;) I will use the above test next time.
> 
> Sorry for causing a regression. :(

No worries, it happens to all of us.

Patrick
