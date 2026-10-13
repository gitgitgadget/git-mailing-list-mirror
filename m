Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2694F93B1
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894171; cv=none; b=pcI/OgkXMFUji+OSHpV8pDuTzeNuaRFlkWGcBdXfbPv8JSAZhcTosvULZFiAp4/aIZcdh/FEScJIAGqBPSDY6L6FBbYCaWBB5wvPdKSV0pzd+uXhlVAun0ceeo2NjN6nRgvBfWwb+2VpWBaOXd+UGWal1xnUqhljMWbSVMQj37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894171; c=relaxed/simple;
	bh=2d+/EZLyeX0fToQ4Nn9UrkxhpAenoqJa8nbr889vMrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evf1KPrUT060iQby5GPBNF/GiOF3K3bM95Po7Zy94WqCkeBnK1gv7SS1jjnQ9Uy7BLuS29IF6ZCBrvq77v5C8rdnY01/2IULxl1DD+btEvegRwI6oeGM8ywR1h+rch9yI5hr3GLSP4idcCnoeCcm8gpvPyq60hsK8HwHf9WBf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SgBexP18; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RPBQUhJw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SgBexP18";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RPBQUhJw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BF36C1D000B1
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:22:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 08:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791894168; x=1791980568; bh=3j4IyeM/M1
	P2Sv6dyNqI1kHs2ZO9pAT68qbujL7TY0k=; b=SgBexP18qGFdm4YDPfV3dks9b7
	w6oDSZE5fHiAuJhOajLC6fvmDzRoGm/6wp5Nx8hdaPJZwirYkbgWeeImW5lLyx88
	goppoj2Ix9o9eZTp4MqkU2eXzcXkGCR2Nd1JA0F1HRemnwHEqAQ9ILPCA6RpJK1N
	Q182nwSBjxEl2XEarde+3I9WyUEkp6VFP2k0ttYYpYMPjqN96yjvzwV1ZOibfTDm
	6/Wcf2FWlI8zdO1StZ5f0hhhzXTpe1wEm2eepCoc91QJEvjycY0gb2wvClKAEPNB
	5/u425NAy3+7qTkVs6Whvof4NOcBVmtFKTJv8dbZtyTZcvfDyf+OpjGaLtUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791894168; x=1791980568; bh=3j4IyeM/M1P2Sv6dyNqI1kHs2ZO9pAT68qb
	ujL7TY0k=; b=RPBQUhJw0nZ6FsFFRmADX+rHJj5Lk/yYct0XX6YkqryhHUKq2LU
	qZGY2DJl9VbyG9yFxKyh4CetsZm1z7Ya43rB7W0OyZpKJ8B6k4b5nGfL/lwQsIoy
	S1XoCxAoRF+BOL59/dTDw6YJf9So/GFfwWUpf8A5iTMj9h/A7+RhTCAoa3s5/xzz
	lX/lQnUz+W4Vw6+5KoPn3pnly1+yiJ1RFGhxvluQNQkBM3ly8kYbQZvfEo+ecoK6
	6pBpfAgMvVtCc1oC6PZsd8RpXifLGF0ZAmInTI8y8f5CKJ40wEtJDZaUzu7OuRF7
	9jxBMuAdHFW3RTYwLoyBQia/ltoSyG+IRbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791894168; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Q+2pAu5FviO2/2YBKuWdc8z/CwG+t4LFhBx2wkM4wN1wrm4
	ZDbtz/8sVjl5NfAI1Ac4QDZa1+yQVHT4qyZBMn5v0iHpOPtHI/Is52MEnCGStWL/
	exnapxE7LB0OdcdIU54LA/i0qmb5Xsno5Nyxd5YqSwXl/uoWAWmt5FYV0Vk7zvjI
	gfsHDfb/ZBBCQztlS9IRzbQOOu329zbdrJ7RDvjFn5VoYp74QQ6PxVliwjvyhAzs
	SrIWlZoMKD2Fr3tnpCGoEixX/5/fQQOTqmu4uxd1XZFrF0xhwV72nA8ecjaDRaBL
	ucadqhJwB9ncFdwevTa6lggJBPG8mIkSzcvpgEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SpDOLFJcfBWSSihudCfdeQf3P5sX42FEcdU/m7gU4CI=:2d+/EZLyeX0fToQ4Nn9UrkxhpAenoqJa8nbr889vMrU=;
X-ME-Sender: <xms:lyLOaiylayuYY28R1iQPXgoYNEM1xpbyvNRCKCqCm53j5FT_fs9BNw>
    <xme:lyLOanlLuIMYXospO2E75rFVMxhHsb6l6vZWMJ7Rcrx0ICvqbg-r0fF0gK0YZzMmX
    t4zDeGQszdtrSjjN_DF-LlIkLSXusxknlUqfVEs9OVhF59vydhy62Is>
X-ME-Received: <xmr:lyLOarmnSJHTNqq24P8QfhWrfTPSo9MB4z6pynT0UMlsfdteXVZjuA>
X-ME-Proxy-Cause: dmFkZTFXKr+mdviivPPAOJwA9IFoK70aFIjFgrb6JPK+zzSyIuanO3DN2cCAc9I/809Uid
    uVWtKmGkIvbL0DNeW00PRYYlMn2Nq9FRK8FDXcw91+JYMJ/+Ml3BLS+P6Y6RkEuAhFmM8x
    hs4VPgHoPQPSddDN8XjmlvUddFo9756MEs8buYeuVvbUreSXHW+yXERv4qsGEGgJdcZrXO
    +YTvfrlpAyZ6k7GUmryaEImDZ1WPSmnUjTKdNRsoZaR3QqLuRytGJs4XXPdjWshriO4+uQ
    LGwOroyCn9KJ8cEOT/mI3rT+CJNTDDsOOn6DlDRFKtZvdtB9vdODqJJL+nL1KygVkvC9OL
    Cs0utZuU7GOMSiC5cuwTIRCfdW7UXRxoVZAqrdXL1pEz8U7J5P3n34v8f9sleXCMiGCc9K
    uUv1dS4KhqMcHzzIgVNELaqkZx2CIdv2oScK9eYXhyrqutm04uLLyq0UkmtSSQRwrPJZ2M
    DbG6wz2wlVuEZB8j67m2qf9WvaB2sWZ5+/s0jZg0btpIllNqH1s1rZ1XJoXbWTxJJdTyIu
    3BFtBGA3zHjV2EqdnM3ji8oqJw08oyvE0xDl12nVTJZORPVyOmoqlC9+0gdlqW2CKqfuBL
    DXyUdG4mx9JHfaFUn5FYuJHawjm32iE2awP1vaOlJQ9WitSzT5QfXwJYgxQQ
X-ME-Proxy: <xmx:lyLOapy-W76g3zK5_x-3Uz-TzJRYK2BmYVpe2MJNskiehRlVXushyQ>
    <xmx:lyLOagrHKIh-qtgsG8tn8VdGMKTX91-5JHlWe8GcXLdXervrtbwp2Q>
    <xmx:lyLOao6_NcQSRRzGajiBZIYlSSCOyPbv_Fn7UG96myPIANX3xKy0cA>
    <xmx:lyLOanf_J3vvgcP3MjRQ74_5avgmN-zHw5bxt6sAQ9CP6-9GkqkX-g>
    <xmx:mCLOansFc__r9YVg-AudGJNe0Q5a8NRKckOqbyP5TcDnyA9jglkjuUf4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 08:22:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5d4f264 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 12:22:44 +0000 (UTC)
Date: Tue, 13 Oct 2026 14:22:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v8 0/2] rerere: wait for MERGE_RR.lock, but not in auto
 maintenance
Message-ID: <as4ikRUi0NZv_jKr@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>

On Tue, Oct 13, 2026 at 12:07:51PM +0000, Thomas Bachem via GitGitGadget wrote:
> Changes since v7:
> 
>  * The rerere.lockTimeout entry no longer says that the command fails when
>    the time is up (Junio).
> 
>  * The lock tests grep for the "Unable to create" message about
>    MERGE_RR.lock (Junio).
> 
>  * The wait for the background unlocker is now in test_when_finished
>    (Junio).
> 
>  * The rebase --abort test aborts its rebase in test_when_finished, so a
>    failed check cannot break later tests.
> 
>  * The test "merge fails once rerere.lockTimeout is up" never waits, so it
>    is now called "merge fails on a lock it cannot take".
> 
>  * In patch 2, rerere_gc() takes RERERE_NOWAIT again instead of its own enum
>    rerere_gc_flags (Patrick).
> 
>  * The comment about waiting in setup_rerere() now says "by default", and as
>    in patch 1 it sits directly above the call that takes the lock.
> 
>  * A comment in t7900 says why the tests with a held lock create rr-cache.

I think this is in a good enough state by now. Thanks!

Patrick
