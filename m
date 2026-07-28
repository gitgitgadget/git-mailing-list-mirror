Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56813B0ACC
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261703; cv=none; b=Kl01vWBvqclfB1LVeXbujt2FaOkKFNYZCsyTXcv73oobY7MVin/iZwsyRqqdIHxusmByfZVsLi1Fi/+FxBHpsd6XthcSl+3ZiEDfmcLNCvpmM6GKPtsgSQkAGj2FckFzT0xmqOe3tI9q3Iq/7P0BUk8yIWjCPuIg7w9EG5TykkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261703; c=relaxed/simple;
	bh=JfdqeEUEp19cIDDmQ028uoQxDx+6qCpKC20myzD4PKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euxPu6AYbqeNyvNFGJ4PSyEzyhlHCSUCyEue0I9ZGlUbZAi/yf5uNaf0Vb5CnZkorpK8+xjDM+XUTPb6/7LFjU7nKHXRcMk0cQrl6f1Z6AePJM9QvPvfIZVzivS8DeI7efiLTo1bAGJeTgsFQOf+4DehI2Mzl+piLlCy/8eyp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DsZXbcpn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFGzqrR1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DsZXbcpn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFGzqrR1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D0C3DEC008F;
	Tue, 28 Jul 2026 14:01:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 28 Jul 2026 14:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785261700; x=1785348100; bh=XOtlnENRfH
	U4n4wncL0if8PZgzVSl84X985Kdx7FACk=; b=DsZXbcpn6RODraMvJZCz1uMPpT
	PKecDV+3LvlQyyXQ/pT9anfLp2H5diaSSmMibC8rSqNcMC3JsZSGzRNgmegsxLDC
	dglLF9UiGnURAw7fZCZj1qpUooUom9i9MVpIo2Htf82KW35YpHPVCOAgpqVzwpvK
	dNn7vcxVHEuJTvef8jl1etxKNg/nTuL9i5lPEcDYZj+Y59K8eF0uFk5/L5OE89uX
	8tqnQ5PxusoGDuhl00URy41bXdXHw1K1AzzWVHMk2hB/9xg95QYXoQlRWpAOhE48
	agHGqex5yU3tP09/JmGI+3379j7/23MWjb0uLLC3NVy4DBe4pwUbm3oZTS1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785261700; x=1785348100; bh=XOtlnENRfHU4n4wncL0if8PZgzVSl84X985
	Kdx7FACk=; b=XFGzqrR1WE+qRon/PBJ0hrKxk2XmtUtm8EpOZeeYNfrkJtNgk+o
	QoSxxj9WC8nSPWn8OvvZci2oaS7SK9aRSuYldcJ5YKJDBHcJJhetjrB2MQRMc8CL
	4hvk5JKjcO2ouKrXMm3tQJCLX6JdnBSmVkR6nXMYZPtspjcpRldr7UFCCl7VMVq3
	tixGc5PYOwCoLpeHt0PK8dTlG7wP89T+M6U7kNBjpDkzVc5aATde9YCnIMDdnyar
	acvGXC2atYzJGPCjz7xNTJzJ69driJ6Str5v3cFpmqhzM87b+ZxMCBVt6Wi+cCrY
	cfrQoK5cZV9sBrDKKrNU8vaoNqO8n8OKQAA==
X-ME-Sender: <xms:hO5oajDaZUoq9eOxeIRq8yqfOg2W5uTVM3FOYRrLh2GIVDeUyEJmEQ>
    <xme:hO5oavilOMySROCnmIgvvtzxrP4cBTFzv0mrFFCCJ9XBebDk2Armd_k0STqBykwjg
    GwUXSo3yUmfRIwzUap67alV_tMSh5wnUkQ7cs2P2XTs70y1gDZtCpI>
X-ME-Received: <xmr:hO5oasNwJB7w-VhB3zH0VKznxDdUn1mGW09wNTglZqYt09-F2bzY24USFj7Q7a5Kr8EMRF4xsUvj3NQAQzZa86rDixALt2yPTpayVa9ySmKSVhSsE1i1CA4>
X-ME-Proxy-Cause: dmFkZTF1CzFIuzPcD7sybAknkbhN0pZ31mkJRgQemYgCkAyeiYooUjRqYyT32XoRG5Rsqt
    7HjJy+tZ4Q/uymG7vNXgLVvWAmFJZhlU6haIDsLNDSzaAFJFMSZ+lPPzOu5LKK5wKU6/pN
    +SFizrscGwQ3pFNMUaT+aO4tDPRq40Ftngqq9KRKOEYX18vj9DG3iyNBl4ztiiYpqComhE
    5tDSSFcWIrFV55a6VLJzxIQPd547eRxODFAuClWSbbmo9RDNgPmEiPLxmJUI2EAnFrSJN0
    FJ1tlkFhejpNMwyDvXEz5x61xbMyAc68n0sxJnYXnxKIZA//1WTmV92Ur8Rx3NUgeUjapi
    jBKuuD1MvpXktj1tVIZJPX1flsfCqR1yLbhu+D+skbX/krKJNciaoRIHim31/cikkbVXbM
    z5q0jW1YYQSPQIZInDiX6kd/mj8GEt9ohlg/gfOwcx+PBtGJkxfeC86zmOFCliT+vybAaZ
    m6HgsgjgYRUKV8BE841MnfowrkHwqvgI4ADG5VbXe8U0tJ/hgxpPDbfNvc+q4xOhtJXA9f
    B3y4cNuBnEX7BzfGECbIchzUX/gQdBMS/EkTjvZ1wRsfbX3gQ1FrXmdOBuP6IIm5DG2MM8
    V00Ul4O3/CxPpFbXfJo2dSHuAz12264gF5RLhsxe/PR48/8tCloNSjGyMLEQ
X-ME-Proxy: <xmx:hO5oag5-cci4c6ZMETVYMozQum54EHMCRVIpiXnQMVdCsRutFaraSw>
    <xmx:hO5oaq29QZKMn0RWBGbqoc-OC9yyI2iX6Kb_ZYdHlSphFimeetYgEQ>
    <xmx:hO5oahYce9XzfTVIrwh3jjS0MfIjEdkX_X71G2c6NdLJk1ble99ObA>
    <xmx:hO5oaiBsg1TmHOYu0CgYdWJM2RVJhCZ4ZQUgU5kWAsphk8VNcVoUXg>
    <xmx:hO5oaiz4WugBH_ggu43MNHZqvV72MKOJiMpNVNksnaQAECXk555W79-t>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:01:40 -0400 (EDT)
Date: Tue, 28 Jul 2026 14:01:38 -0400
From: Todd Zullinger <tmz@pobox.com>
To: William Pursell <william.r.pursell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: Makefile ignores CARGO_TARGET_DIR
Message-ID: <20260728180138.6TN1pzgr@teonanacatl.net>
References: <CAJPQ5NbTLnbe_VU1awCVggw5m9kGdBZssrZBp8G0YxcMjb_rwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJPQ5NbTLnbe_VU1awCVggw5m9kGdBZssrZBp8G0YxcMjb_rwA@mail.gmail.com>

William Pursell wrote:
> The Makefile hardcodes the path to the Rust static library at line
> 962, but the cargo invocation at line 3036 does not override
> CARGO_TARGET_DIR. (line numbers are relative to 9a0c4701)
> 
> When CARGO_TARGET_DIR is set in the environment, the link step fails:
> 
> clang: error: no such file or directory: 'target/release/libgitcore.a'

If the fix simply to add `--target $*` as is used a few
lines below in RUST_MEMBER_LIBS, e.g.:

diff --git i/Makefile w/Makefile
index 98e995e4be..fa6e4b2702 100644
--- i/Makefile
+++ w/Makefile
@@ -3034,7 +3034,7 @@ $(LIB_FILE): $(LIB_OBJS)
 ifndef NO_RUST
 ifeq ($(RUST_TARGETS),)
 $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
-	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
 else
 ifneq ($(words $(RUST_TARGETS)),1)
 ifneq ($(uname_S),Darwin)

Does this also affect the `cargo build` calls in the
libgit-sys and libgit-rs make targets (~lines 4090 and
4092)?

-- 
Todd
