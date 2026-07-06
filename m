Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B836F42B
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334980; cv=none; b=juxmPRnkSAKUeJlWj9GNNyjB1SXiePcp5CYF/Fje81MJC79n0uG8SsnGk6kTiqMVPk/NRHMZhfhd9tlnsfiEHkqv/QjFQpctS3akTfQdljbXFJN2+QZb2bVsB1VRc1NIbA7pgxc19ZhZHkCdhskZAZlbaYMpZvFmhoTLsmPwyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334980; c=relaxed/simple;
	bh=D9wiK+7C7voNL0unt8vDhWL3TI5m0Cnd3lzP+6lnl70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txCwTpJocl0bMs45cHkl3ZIcRDHwY9mvKu2QkHV356lkioiUcvIVwe6x9Nu/X+FgU77O6Lmy5diXlGGqlKKiXlM7WrIK9PknHEtDXIclVeiNyNQYhQBbIMFOmEBZC4xYz9CiJxBzTeuNFsWOVB71q6YKHQSe9lJMY81cUCJpyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kfnbkv7u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNqFk0Ff; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kfnbkv7u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNqFk0Ff"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D5587A011C;
	Mon,  6 Jul 2026 06:49:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 06:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783334978; x=1783421378; bh=T2VngoSAmY
	2iLGTYNqW/984tQmutgIoyuai8kGKb+RI=; b=Kfnbkv7uyHCanz6rXFeaZl2XDH
	WRhqCDFDCBY48E1sqhNR1vhQit4xoEYCxLQLq20Lc5XU+cF3L/WecK9NqljTxw6x
	Laay2YBINYQHURVyba6MrZxNNcbnsHkG5oX3tddh281OzxS2p7qf6MeAslud1C/a
	orzbVjV8Ws0XWbBJF7PmohmiybQZuzyzHulE5SeV8ZgqulVETab5Cg9R6fu/0CjJ
	7HerrQinq2wiBfDv0QUFzFXtziJkElcyBIq+gwPtdpgWIxzeG0KLgifvPsX/34YK
	/njpotdT3D4lQONCO0qvTtKhmeFpgsQOZMCs0wJkGE16PVDSH73qak86N29w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783334978; x=1783421378; bh=T2VngoSAmY2iLGTYNqW/984tQmutgIoyuai
	8kGKb+RI=; b=rNqFk0Ff8SLbiFUmzfVzVUF3cT3Za58CT6uNwk3hzw5eSPrHVYZ
	AQoEFWSFvmOT7vvMaCqCwbX4+G3CnGZRmhHZ+YWMsm/LknUXBIPAMsxGbt2hBWdD
	BuM0jxqxYBMTJzbsAE+tr8Im8BwmoCfwZ6XoiL5F8viRD6EH4cqfyDb9njG8xvx6
	vD8D9djtQaQ35qUBx4bY8FSDrpvWCYW9C70JjEdKSjZcLKXPZXDDZ7VGZsGY3YZ5
	0v5zOu2r+NXGmBvQ/mluZpIzZZdaYFVgy5DvshUkLAIcogU56rtL2uHF3kxORbn4
	ZQOTwnT2nm9HROBRockUas94e+y40OkJQmA==
X-ME-Sender: <xms:QYhLalYhMFOPlJGdmJHC9okd6VHYjmTaFAe3Pd-tV7aRHM2FwddPIQ>
    <xme:QYhLajRc5hMQXb1g-TDOylis2b4AvZ0ewmT7JxyNk14DbSd0R2xIEUm7P_cEg6fSP
    2vk5Q4ZpC0_iZZFTGHczzn-DmTeFZoB__tTyzAWiiCKdvmcT0Rxaw>
X-ME-Received: <xmr:QYhLagSN7ipjHPkj0laVf7TDFLOnYTusWpfPvYNKYEPdM937KLm9bLQn2kUPb4--5CJGSm-AFklkKGyF9st_iTnBFqJtELI3eZOWIQ6ruXg>
X-ME-Proxy-Cause: dmFkZTFD10TcuDPAH0cNPpo52DhWt8u1rrOL7/OIeHoKTIvCvIdckXJpBmr2UXeFwFvYrD
    z+0W/4MUnM+ru2eRQexz3unX8Z9Q8Vy27RUXusUOhxK4ycDXB/eAPwbk+6RAKGczbMoZPR
    fGxDn/cg1Y9n4WifAw65C/KqnRJ3vzKG/6w+uqeCZ6JI9VGxmPalJWojIkEZTLone+CFHN
    x0XkFIRlXzTnaPyfcVqwFfCX7P9AlMk5qwJz+I75WeyeQ7jUCGPmL1tVZm8yfqTVEjDJd0
    Qn3HNh1MXd1guxwVvs08hTCKZ9cNZrwp/j4R8eIz4Eo/mhqz0ku9UJJlNtoSz6G8t6CrCb
    zauZqS0paVRXIygBCOEE0GavJbn5x5j24ipPfGmrJqFVq95YnznhieZMxT9qo4YhfAFLsH
    Va2OznqzZVQxyBuMQivpBnlyM/J4uUbF8XjLfvj7R7md+AY8eTLhwIwktJitqbm1PnyMNg
    OGqFPwhXJDFQLljMeBWW38Gze/3IdhNEx5gsNXu4ee9S3Tl0rUdZmQrDL4Lz8ZF/Dh2f5Z
    Po6Y298b4z0nxZsIg/06+StHVVO80VhOak05iB3WgMW3tkMxufxVmh7VqQO32AEcVsyYNg
    1wP2VWXMN+yr49DRzB2AhujTZ9zHDMWu0pD4adjmecUfsjy7dOT2kJ24i6pA
X-ME-Proxy: <xmx:QYhLavTMlJeVkB9h9K9YNe2TWwB87eik_rTyVeKtAyuoiCj_3lMPuw>
    <xmx:QYhLat44hPh36sQNdM3Em9xnH7jNp3CfPxW4ubPpp5JuSjQoBSQ12A>
    <xmx:QYhLaj0ECJC8U_1TW2Sdo2wfFZTlQQiyv1fh4NuD0jWH3i7Fi3idbg>
    <xmx:QYhLagDkrasqicBDkQam2zjOQHLGS59rPX0AyuFz8LscnPxXcydbUA>
    <xmx:QohLap5nlSaOeQnwP7j0OMS6T-DbTqUS50SPDXNXVkY_vgeI7ouyw98Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 06:49:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5136d00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 10:49:34 +0000 (UTC)
Date: Mon, 6 Jul 2026 12:49:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Shardul Natu <snatu@google.com>,
	Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v4 1/2] Makefile: add $(RUST_LIB) prerequisite to
 osxkeychain
Message-ID: <akuIO-uOy3KhqIAE@pks.im>
References: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
 <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
 <41de7d391ac00c70bfa981d20ed9df22dbdf7ace.1783188355.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41de7d391ac00c70bfa981d20ed9df22dbdf7ace.1783188355.git.gitgitgadget@gmail.com>

On Sat, Jul 04, 2026 at 06:05:54PM +0000, Shardul Natu via GitGitGadget wrote:
> From: Shardul Natu <snatu@google.com>
> diff --git a/Makefile b/Makefile
> index 1f3f099f5c..7db38ecce9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -4074,7 +4078,8 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
>  contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
>  	$(AR) $(ARFLAGS) $@ $^
>  
> -contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
> +# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
> +contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
>  		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation

I was wondering why no other target declares an explicit dependency on
RUST_LIB. As it turns out, all the other targets that link "$(LIBS)" all
already depend on "$(GITLIBS)", which includes both "$(LIB_FILE)" and
"$(RUST_LIB)". So shouldn't we also depend depend on "$(GITLIBS)" here
instead of on either of the other two variables?

Patrick
