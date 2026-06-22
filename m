Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAC388E6E
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115502; cv=none; b=Kn2h3qbBRywyxzsEWtEbqw5n8+L0DVG0xF4KJrGX4WvRDgK1N3SkFZKrSPVUHAdmqy6zCwFplhJ8vEzA3FxNjvoB2LEZgNndvrDXbfLZnaQI0QnJqx7F/SMy42VqjvojzvfjBHfSLqidQYXYTOb+QmpE2J1tJtpb/vGPYDyZMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115502; c=relaxed/simple;
	bh=k8o7c6JQPuC61Hus35X59sVBCYmQTDIU2oEa60Egc/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5ObuIRe953ZyzPcUpZIPy0z8T6Z/yj0S56SYL2HLsEt/kRpbxKPuM/HyCJnbCEkQklumfnAtmwG6kGoRrPc+L3Rd2W3+is+Chp7XKV6pYwi36aA6Sg7L+LR2Wia3lS4effVx5bdBvDY2qlYWkXYqOL+Kkr3RPrG10Yova9/QOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Olr3GHtX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RdE70Lm9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Olr3GHtX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RdE70Lm9"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 536261D000ED;
	Mon, 22 Jun 2026 04:05:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 22 Jun 2026 04:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782115500; x=1782201900; bh=BuRTh6qejk
	hJnrxj/KLMIrfFFM3Vw5dPHV9e9fQsQys=; b=Olr3GHtXlqosOU77ujMacdlg0e
	0iNTIQE6j5CMjU65GFtFkyfcSfjAdsvcTkb9IeFxJTo0ZGQ8GzY7fDYRd02GxDNw
	+VBL5Haz766zsKbr66m0nA8xJU0JrOkWGRLalLryI8uCNLBpIVnvYPAOdo2BDF+t
	VCVX4M52bIhu7aazxTV55tCULeNrzjkB2rmreNj9zKxMP9yz9b7xaS7kw8QG0K//
	jxeuvsTfy1S4WiDygpLlzGJ6wT0jQl0QDlFU38xhAdOZWY/nT+z1eBDKXSqeBjTH
	dI9PK/La+3ZT645xPFp8XRhZzUrM296GNT5A0r8deHNlElcvrBNcA+HfHOPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782115500; x=1782201900; bh=BuRTh6qejkhJnrxj/KLMIrfFFM3Vw5dPHV9
	e9fQsQys=; b=RdE70Lm9KsXRIL+cchKNaqeeFffwir9vy4KTz/IuSWXec3aiDn/
	mMtDlgE2jSloAhKMfpZR8n1EtgfgHCTDla5+dF5vkx3h+0YhizYe2E0cnD/3T+u3
	fOT3FR9xwezW5tEdjyTg4lYK0HpZ7SKROtFo3TMMUsrtS1/8j1CGF27EiQgZTabm
	Ob5LkNVXCSI2jXH1daE0wcj1NvM/yHvoEq18BdIwugJpSZlDay0xa6oujXRhlJAa
	e9gtpofKaMIabqZe8cKkyFSOUuTmqk9/33UK27xkZ1EQVVedF2jLyrjTcpfD5i6C
	C4/2EGZcSY89+F8QOOyh4gIbSznXSMeDlHQ==
X-ME-Sender: <xms:rOw4an5_QqPjzkOQlNQiMfuKzyynKy4o4ja2lM37UO5ORO8fejDtpQ>
    <xme:rOw4ajxjMCkaXeQtsS2aMa0tghn19AyjiTPDcrcOJTGj6L3tTbv5freHkgUpRWIxY
    FNntxCKm_QhMXmjVvpdsBZEscqAAQ0phtsBm1G03qEdfWz-z7PPxOg>
X-ME-Received: <xmr:rOw4amy7JCkO7sPLaLjISlBdKtENndoJjRX8onfFU17wsOXagqkx6J2wQ5-50-qqUELRvBUlylHNL0_csAZyg7n6PinT2KOo6zGMQ7MaGQ>
X-ME-Proxy-Cause: dmFkZTFlhErPK5vhOkpeJEjrjU683UnQlHkXeYbNnYd/by8JOv1jIsYLY1V6nYO0G3rTpI
    GgwyFh+eZp2ky0d3JKilpgwn88ICEsOPM2zZwJFSD6PXfevnMRzyurhmfnbf3bMvD9cLd+
    IgBxXrzw+PZJM49rqPNzokxH64nTfgUtc3DQDPoFdaZKNcdERXcAycBUdAfJCIc9fKVeCV
    xbILpfakZAKOwVbaTeSxc76Tl5wkeDE/bjctf+U/2pGyjb90iIk90S0iJGxMQg72yU0jqh
    hIo935L10JvF3/mwT7/XwxZQjgRJmi4ZRle1xzNJGA60XEpogq2yPdjartQh98GnNrlZVN
    66kbaL+QWIaQ+nF+08O9rRj7bVSUjcw2LkOBt2062rse/4L+pJs7fNlw7sheui0/B1x49i
    wqqd1+TeuwniAz//N0rBqBJq87mRhToI7BQbv5aFTNnPb+KwlzqYIfDMdHC5GXnukBz74L
    lruRK8/D9B/8XrlB5HiL9qMcxu1iwBNIClcM1NHANhICHjaFim1kJKV93HD48a1Upw//wc
    FVxYFoJmgNaS2jZgnBiZmdBteepNjbYTKzRwx779OVoQepxS9jqNoRoU2M3IYzAlVDEIDh
    sEdwjTk9BJl3hK97r/ObwszFU5YHHeKFuNhM7AE+nu/22Nmww2F7Q1AqokXQ
X-ME-Proxy: <xmx:rOw4ajz_N3qOlO5AWCK2o0AKDORR3UAHqU7iPycGm8PyxyQLQNrA1w>
    <xmx:rOw4aoZRjeFFtHjLda5vy92ESqhTh5sr9W6TJ_MEO2TMEfx8c1e1Mw>
    <xmx:rOw4asVz7l-Z8VsfO23NRl0kF3GADdPvwrgTAW00lDdkM4F5LXJgRw>
    <xmx:rOw4auiQX_oQUpoJ5iEkkql5TsAlkfuXWRFiUPh4mL2b7nTlGfGW7g>
    <xmx:rOw4anPpOwrx-zY9pE70kaDe8I2R8NtVOkpkyUJc9A4tChxmxhmbTOUO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:04:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 11dbb562 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:04:56 +0000 (UTC)
Date: Mon, 22 Jun 2026 10:04:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] config.mak.uname: avoid macOS dup-library warning
Message-ID: <ajjspU7lJ01GgrBw@pks.im>
References: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
 <pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com>
 <xmqqv7bei2tf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7bei2tf.fsf@gitster.g>

On Fri, Jun 19, 2026 at 03:27:08PM -0700, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > Building on macOS with Xcode 15 or newer emits:
> >
> >     ld: warning: ignoring duplicate libraries: 'libgit.a',
> >     'target/release/libgitcore.a'
> >
> > Some link recipes list the same archive twice, which is harmless.
> > Quiet the warning instead.
> >
> > Pass -Wl,-no_warn_duplicate_libraries on Xcode 15 and newer, whose
> > linkers added both the warning and the suppression flag (ld64-907
> > and dyld-1009). Earlier linkers reject the flag, so gate on the
> > linker version. Broaden the existing -fno-common version probe to
> > also match the "ld64-NNN" and "dyld-NNN" forms Xcode 15 reports.
> >
> > Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> > ---
> 
> Yeah, this looks like what I expected.
> 
> A few things to note.
> 
>  * Can folks with different versions of Xcode (or is 15 sufficiently
>    old that practically nobody is expected to have anything older?)
>    test this patch?
> 
>  * We only patch Makefile here; can folks who use meson report how
>    well your build goes?

When using Meson we also see a warning. This got partially fixed in
Meson itself though via [1], where it started to disable the warning
when compiling with "--fatal-warnings" so that it doesn't cause builds
to break. So starting with that commit it really only is a harmless
(albeit annoying) warning.

Arguably, it might make sense to unconditionally disable this warning,
as it doesn't seem to add anything of value. I've Cc'd Paolo, one of the
Meson maintainers.

Thanks!

Patrick

[1]: https://github.com/mesonbuild/meson/commit/17d1cc60ed8246b8e7f0786421bf1cdf5cb19254
