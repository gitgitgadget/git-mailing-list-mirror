Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5573D79EF
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993056; cv=none; b=a5wCVbFrG/Bj9W4/mJMGnnijbc+JRHzucuNyp+yNUt6OTRlMwjAzKKYOMiCgXQb40jP5MRcPdf8FzH5EJO4bFErPkSxLZEApOB+96HhLkPr63dRmKwjEf2ckAfjC15E1CDtcTQj8sgbaOPqxbqH724S6/j7XtC2tCraIWzuZX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993056; c=relaxed/simple;
	bh=x0u+n9Whb40rYZ7Djkk+4dR2WVAIf8RATFZf8nz3VB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuGKQdddtGRSdNq24cxOOIOFfxNXedJld0FDEDLB8RwNNEjdSN38W2ql2n5ueE5dJ8E/vVvf0895PWSic0tZdMap2iHMoiageINtPssDzvZyMbttUV0LI3L6LB1NSoZpeUukTRKBbIKRxd0Glsxz/gmBEVmxPxlLWyunzJQ65mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PAm4cB35; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffBaEQpg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PAm4cB35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffBaEQpg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A521EEC02C0;
	Thu,  2 Jul 2026 07:50:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 07:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1782993054; x=1783079454; bh=dsmVhE134X
	svKXDdjp0ptYzrHufHgq3R/3OvS8qVXto=; b=PAm4cB35v0PvfxNHnxpgdDdpG1
	yM6NsQVgz59F66iVXF/+XehozutbmoT+3xypNM4AC2gHeQJQki9OGSWwhoKFTCxt
	ETdO2dHfXcMxgSNNUGcPJiZWSzCsOwrgv8Wjp452aFeu9C1Rx4kTX+H4RW7lUKBt
	sIkfiGE9+dbbqWBuzP6YlYes7aOzipXRzOJcftqoi74y3XmNMSvvB16iJD8WOkqV
	maKwqGR8JdiCmHnXm58IgtyK6STS5wVzFJT2JzqaKXHeX+MUYsPVgrCmwhpnifVH
	M+Kmwc933sU1VE6tk5hLdjwCe/SdKuVFpQCOQERT/Zcsz2Yj+L3YivDeUNsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1782993054; x=1783079454; bh=dsmVhE134XsvKXDdjp0ptYzrHufHgq3R/3O
	vS8qVXto=; b=ffBaEQpgQJBn1RhlQ8r4/WS4sD2BzMbYVKhfddg/opwc67tmrvA
	AUvsmFmjR5Bq6PgyzEZc0kmTNMW7KQQt5wwj1gkN3MND0ainYOxinhNFm9PvC6xX
	ewjupPX3xKc4jlTLi65puidyZZ+x43jwAjxRQ7EZqM7qnScwA0e8M0EVBEYQvgrL
	G7YSCMw3zY8HSuKlhhbpDyJwTRPJrkaUxMOfpJWr8Qs1B50W4t9XfHRbI/jq1Rkj
	F+e568k41yg0dN6S5lNsUYBU3bFL2Ab/adK7WZ5uaPk5upXSq9VeCq2iI3+i/g61
	AIQy/ON5dvTLM/XuXCezBQ9mOKdO8dUP/Zg==
X-ME-Sender: <xms:nlBGainw_TtiIlwuozdtZ8tk_bGrcJUi18PPlUMl1zzh1HQNY8SVSQ>
    <xme:nlBGagv-3L90ADtJ6PM5xkq0vZmfd80TV_R1UdC6JSL2hYgwXNL9kLmH2pgjm-KXx
    yHIgNG18B5CbLByJkES1FaWz5s9shrD5V-1zV1KfS2z-A44zO380A>
X-ME-Received: <xmr:nlBGao-fjJwGOVZK1fw5hIqnq3ca6SBsJ78NrTk4IN45VxNhVixGPsiV22okl8fNJBlVLKaxTpHnavDpiR4iFkStje8HPBx-71Lfl9L_iRxdJw>
X-ME-Proxy-Cause: dmFkZTEF1+wrETUdJbJLs2KgTo8YRU1C/678fkVFX8Ra2FAyMn9xSw19Be5hBKpZT4a7dc
    YYpU0StBfI+NT1CTLVrcDBqZb1QDNN69YAh3xTx77/VNDvxPpWC9djvJlBIsXUW9iWbDa4
    plMkRYuYeVAFrGraoWhjgtxuFUIPXun9oZX0MK+btGVUdf1m4eCsN9GbSkGxoupZdp9EJj
    D6NXbUql+RzctqiXYKl3CEwLl8pC0E4udPn9jZS9RknzhqAGdJ5cA70IiBVjS7cMDPkJS9
    PzTseF2sabARB4IpPdL52j6nasi9B6TJSwOHVFl5vcDf/tvG+5ifbIXyM1O1N5YjJSyShT
    kTTU32wjshPgRfYrNollxEYYKr3i6g+wI9BF+IEFokCnn4Y7K+0drcVePGQsAWXRUkXBqb
    qHcWcQQ32+taZ9JLL9O8guhHoNGuHcRUsSmtRHr2RQPulsHz6EK+aI9I3cvYdSX1dpl7ox
    uOBfvmDWnFweTuuv7YislxsReRSu5DOZeGqyBRoGJkPOLWCzL2wdSH6Q8TjmMe3ix9wE/W
    18c+IxYySD2epYnnyogcvKX3FaKS2tJxSDxYbyEneyZmyVDZq2tK6XISzPrzGBocxnl2uS
    4CD6z+jIITNo8PZE4NrSZjnZO5BlITei9eNLY1+s+L74fVRqYlCb0QLYDn7w
X-ME-Proxy: <xmx:nlBGaiOUr57LFBINKiDM5MK23mSO015OJ1MLDwaSThbD_MlgEsGtww>
    <xmx:nlBGauFBM2-NL23TfFev4L4Sq5PZHNu2_B2p4x89uYWcicC8ygF--w>
    <xmx:nlBGaoSMa0PAynfTXo_XcEDeklqwjPn6qcgxS9fxLfR7Ov_dpEg_RA>
    <xmx:nlBGaju08qwIH3o4ULYJOfFeRB8200HauMEoHlVMHnpB9UM1ptIDrw>
    <xmx:nlBGanVnObtkuFAa31XRDRORLnCMwoG2-wU7UV3Doc_gOVYIrS4yXpN9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 07:50:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dba203d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 11:50:51 +0000 (UTC)
Date: Thu, 2 Jul 2026 13:50:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Shnatu <snatu@google.com>, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v2] Makefile: link osxkeychain & support universal Rust
Message-ID: <akZQmDYe9MtTdGM2@pks.im>
References: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
 <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>

On Wed, Jul 01, 2026 at 10:01:43PM +0000, Shardul Natu via GitGitGadget wrote:
> From: Shnatu <snatu@google.com>
> 
> When Rust is enabled, ensure that the git-credential-osxkeychain
> helper is linked with the necessary Rust libraries.
> 
> Also, introduce native support for macOS Universal Binaries
> (multi-architecture builds) in the Git build system by allowing
> the user to specify a list of target triples in the RUST_TARGETS
> environment variable.

These are fundamentally unrelated things, aren't they? So I'd argue they
should be split up into two commits.

I think we could also use an explanation here what the universal binary
buys us for those who are not deeply familiar with the macOS platform.
What are they, and why do we want/need to support them?

> To implement this cleanly without complex shell scripting in recipes:
>   1. We introduce a declarative Make pattern rule (target/%/...) to
>      compile each target-specific library slice (e.g.,
>      target/aarch64-apple-darwin/...).
>   2. We update the $(RUST_LIB) recipe to depend on the list of
>      compiled target-specific member libraries ($(RUST_MEMBER_LIBS)).
>   3. On macOS, if multiple targets are specified, we use lipo to
>      combine them into a single Universal static library at
>      target/release/libgitcore.a.
>   4. If only one target is specified, we copy it to the standard
>      path.
>   5. We enforce that building for multiple targets requires macOS
>      (as lipo is only available there), raising a clear make error
>      on other platforms.
> 
> This is a highly elegant and native Makefile solution that avoids
> complex shell scripting in recipes and fully supports macOS Universal
> Binaries.

As Junio already pointed out this self-praise reads quite weird. I'm
just going to assume that this is AI-generated fluff.

> diff --git a/Makefile b/Makefile
> index 1f3f099f5c..8d49ecc897 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3019,11 +3030,33 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
>  $(LIB_FILE): $(LIB_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>  
> +ifndef NO_RUST
> +ifeq ($(RUST_TARGETS),)
>  $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
>  	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
> +else
> +ifneq ($(words $(RUST_TARGETS)),1)
> +ifneq ($(uname_S),Darwin)
> +$(error Building universal Rust libraries requires macOS (lipo is not available on $(uname_S)))
> +endif
> +endif
> +
> +RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
> +$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> 
> +	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
> +
> +$(RUST_LIB): $(RUST_MEMBER_LIBS)
> +	$(QUIET_GEN)\
> +	if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
> +		lipo -create $^ -output $@; \

Can we assume lipo to be generally available on macOS? Also, is it
sufficient to just do this for the library? I would have expected that
binaries would also need some treatment there.

In other words: what does it help us to have the Rust treated this way
if the rest isn't?

Thanks!

Patrick
