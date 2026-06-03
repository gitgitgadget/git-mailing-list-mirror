Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395744CAF7
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481196; cv=none; b=DIVF6Ygqh87eSwxpUDQDVV4YE9szhPzbXmbg+rWmwkxP+1oV4grg0MCTLxPHx4HKkcvR1REHN6cimJmGeZuJdmmZ+MHYUlIi8hMFWr0XRxpXvyi+1hYBnw/D0bbsAylZMUhurZBpI9/3UEPAhrM4QJao+SoMefbCHSdzUXmpxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481196; c=relaxed/simple;
	bh=uWq+JoeCrFP/lohnt1e3xMzoONmphEAX/Q0hwjYqmSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDAPTV13VDUhd5DoEKIAC6E8LzFRWrGk1Oy9RKf6B4YErWc7JaXG9/dASAkOftE4PVg8In7Nv7qivq8wcr7xruVECMOInIaX09b+JKj10jbwG8VvidZBwP4+wsW1elaDBGGPOFC2hCw57a7zt6jH3J//nv++OGjyid2Hpt+sFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mUh/M0Zy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lay1i9MH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mUh/M0Zy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lay1i9MH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 72F591D0005E;
	Wed,  3 Jun 2026 06:06:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 06:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780481193;
	 x=1780567593; bh=psrlC/HesUSo7OwyD+utt2Rq7m2tpdVadMOlYoLG3+M=; b=
	mUh/M0Zyy21jmUUeMbkyV+pY8OVClKtfOOcE2FgJs/OSi1dgthUQJ+p949d2YO1N
	mVMy9PLiI42CsO3eaNH2kyjt6HjzovTn+x/0S3EwGkvWYgPW9JsXPSI8en/gwZzJ
	VSjTfW2ZhbzTSM5svRUhdST/m1j+It8oWQb9Aq31igNrxZm7DGrijhnQucdSMb99
	yXU17NdLVyGQCNf/r5UWKW0L7lFGqtKfxkNZS2sakxL4Zf8yBLdo3g2sLzfIeKL+
	eDTDJeD2ui+FQRsdcwbf5OnHYfDLg1xYvsylvzu/gsBHEv6XwPzueJavU8w5V2An
	0lneNuCmcd9iJBMSK/ahFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780481193; x=
	1780567593; bh=psrlC/HesUSo7OwyD+utt2Rq7m2tpdVadMOlYoLG3+M=; b=L
	ay1i9MHfo1Pqy0Sti5zRirx5WquuK5tSDULpMY1dopw+fRlZyplDwfnRGRRkkvVU
	nEoGUHYmEbFzGD2hM8VBYfyiNNa9sENyu5RCgxxUHlpzPLRLu5oZJGRzKtUGP+5p
	iXP06DWUzJmKTW6+c6zlbU30Sb2CtrNst139R1pKvkhXJqngT22F+sNG7p3HeEh5
	gY+CgpDcU/sq1jTaSaBpLzEg1eCPiUAqwvuQyVBe92YcWtuKp1dFAhAwOh4Y2Uxj
	goanjo4WAniWVM9ZZYD45tYnuEoQoNadyIx42e5yUw/HsBHfpPaOdfGIsP5xGWfy
	ou3/XMQnhQuNp9RqSIg5g==
X-ME-Sender: <xms:qPwfaosZFcvccPWVP4_ax_6jciw78jcrYO-4hz3HK7hnWpURCCmXAA>
    <xme:qPwfardhpluTH85To7K8e02IpwWbkACPFkV3gr-xqySRpbRaLuFVP60h2xbWZo1ZS
    lOFQPVU8zLZvPOpUQBb1sM-0GBOQV2V8zktdZ3RxQ1YH16T4DUfsQ>
X-ME-Received: <xmr:qPwfahb7nnwcs-MJGTdKVJbpMfSn_bOjpY9LQy2L7lSB0cunDYCddt-En2OIRkYKqQUJR6H5bBrpkNG4YRskJ7i8erv40AMLekD9yactfe4C>
X-ME-Proxy-Cause: dmFkZTEvLAGyN9C658ziAFnZRvtf5uYrAjVyX4J3znN0wvz90vVy7VmHne2TO8yyMQnrKl
    NnD2r06DBH1rHRrQNKFoMP2JG/TBNRYH2QzpOV0MUX0f9ESdp85sqG1jVs0qLfhXfw3/7E
    t9BMBhXcFual2rZfzJO1Qohdju61SBpu1ezxfiEsdLohiNrTBY/E2OWudFj2PPshBpsaGm
    gJBohH/p5DI/ZVKbkUw558UXatPOjw/UQ/5wXD9aAW+iiV76oBJkZzmXnpr3wws91LQB29
    e4VxwrKPNpiKRdrvoPfLYmngXWAXUZdT40VwbTmGxmVlRuMYsuMbgJ+t667qmX8ewI9dXA
    X13hxygEuFMT+QkP5QRvp80o8sscvxo6Jqk53Yc+olmVb4UEeOkdyqIWDEX0qRWs2xWZrn
    //SLSH2iPZl2gg2xTNzrE/fBh/bQ3BzL1h2PzWZWZE/AcFGZerDb+JS4lcy00ftiam7slO
    4/biPOQ/02A29LLulTbdTC/7ohfBSvDschSCJ8fTwaxTy/JGi1XzPN6tsanLO8qR1YN7/2
    d4zppc/rplT1t/2u8NRai0s0u1CVSTtm2bZyVl+Dgr6IHiPQDQtIhNjrLBXodkD02it1ME
    nbs+i+dhMCDBIYurWfmNPJZ/teZKOR8QFh8yM7ZGZlQj6urmqM3gBWXIy6Ww
X-ME-Proxy: <xmx:qfwfamX1aJmqh0w2xusmzB7Xk2Yze7_wM9HH0gjFXfLEV9LAvRosfg>
    <xmx:qfwfari3C1fHMvQDDjIf7XNOQOCbDNn8itGCkEBnUfIee9IMduG07Q>
    <xmx:qfwfasV0RCKY5UT1C9k0nzxjUA_9gY5Un94IUXnfbJ7fPVC8hxd4WQ>
    <xmx:qfwfaqNoP2-rCPKCrZMB1KN45BFTo1HRvcvbAxEj8tbzy-I_8uRgvQ>
    <xmx:qfwfajd1HZooti3MThCKZT0vbPnSJ7fyFwYbOas8WQwtYMgzV5ZrMtmh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 06:06:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a600799 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 10:06:29 +0000 (UTC)
Date: Wed, 3 Jun 2026 12:06:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/history: implement "drop" subcommand
Message-ID: <ah_8myzMQJ97Y0n0@pks.im>
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
 <20260601-b4-pks-history-drop-v1-2-643e32340d55@pks.im>
 <CAN5EUNQbSN7+SDWcrh3jTD7SXrnD=e-fQ9Qj9778R7cy2q4b1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN5EUNQbSN7+SDWcrh3jTD7SXrnD=e-fQ9Qj9778R7cy2q4b1g@mail.gmail.com>

On Tue, Jun 02, 2026 at 09:31:17AM +0200, Pablo Sabater wrote:
> El mar, 2 jun 2026 a las 8:16, Patrick Steinhardt (<ps@pks.im>) escribió:
[snip]
> > +       original = lookup_commit_reference_by_name(argv[0]);
> > +       if (!original) {
> > +               ret = error(_("commit cannot be found: %s"), argv[0]);
> > +               goto out;
> > +       }
> > +
> > +       if (!original->parents) {
> > +               ret = error(_("cannot drop root commit %s: "
> > +                             "it has no parent to replay onto"),
> > +                           argv[0]);
> > +               goto out;
> > +       } else if (original->parents->next) {
> > +               ret = error(_("cannot drop merge commit"));
> 
> Why the if block adds which commit context, but not on the else if block?

True indeed, will adapt.

> > diff --git a/t/t3454-history-drop.sh b/t/t3454-history-drop.sh
> > new file mode 100755
> > index 0000000000..b320ff09b3
> > --- /dev/null
> > +++ b/t/t3454-history-drop.sh
> > @@ -0,0 +1,513 @@
> > +#!/bin/sh
> > +
> > +test_description='tests for git-history drop subcommand'
> > +
> > +. ./test-lib.sh
> > +. "$TEST_DIRECTORY/lib-log-graph.sh"
> > +
> > +expect_graph () {
> > +       cat >expect &&
> > +       lib_test_cmp_graph --graph --format=%s "$@"
> > +}
> 
> This function appears exactly the same at t6016 and t4215 but named as
> check_graph. I was gonna do a cleanup for a commit series I'm working
> on to bring that function to `lib-log-graph.sh` because all these test
> files share that they import graph functions from `lib-log-graph.c`,
> maybe you could do it?

I'd rather keep this series focussed, but I wouldn't mind a follow up
that deduplicates these call sites.

> Also:
> 
> lib_test_cmp_graph () {
>         git log --graph "$@" >output &&
>         sed 's/ *$//' >output.sanitized <output &&
>         test_cmp expect output.sanitized
> }
> 
> Already uses `--graph` you can drop it from expect_graph()

True indeed, dropped the "--graph" argument.

Thanks!

Patrick
