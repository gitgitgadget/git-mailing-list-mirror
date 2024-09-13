Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AF323D
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210068; cv=none; b=Pd+4F76sz0mRmbDML48gPe3e4EJSvO3U6ZVdVI210rcMDiya68blzTXro0ja0eanpZSZvBOLEH6rEV1Ai5GFry2ugP+W3ViFmSZX6Bejh8j7Ovi49iuc3xYL7kJm0to89zBQa6G/1QLUmzd81aHfqsfT4aG5VnTwSwUYAbifGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210068; c=relaxed/simple;
	bh=evs2HF0XYOo8VhmDyNqvbdKO3aJjKz26FE+wkYAT9+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHDC+BUbukCmawNS9zvGJGsS8x7VfEuWQYRzJGWEBbJwFtsYDVmZ+c0BAQ0boVvH+h2s2ROO9d49HxysDINVZUjx6owndFGS6GgF+d9L2jlQ2yyEPNvvnT45bswlFMKP25orKLkYmFJb+0v7UaDcfgEAemXPNPolRxTt6ua7G8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e303gpuL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N4BWrrkH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e303gpuL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N4BWrrkH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BD3913805F2;
	Fri, 13 Sep 2024 02:47:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Sep 2024 02:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726210066; x=1726296466; bh=fMjS7A5ame
	zHFH/Boaia4s3lMEy/wCRamf1/cfTNsew=; b=e303gpuL2lFjCojv1MllqRsQgP
	5XXIFMYMZDx86Sr3umaQqzFCdZ4HPHFr8bOMB1vgr3r9NkXwRj+0+g8oVLnPpdR/
	A72ZYUcbM5Sp4z81MlhkkJNnBs+g3s/hF8asCsKFyuPgnMqDB1qWekBZAvbqwz8t
	/v9xPSMxsm4ZAJUuAKlDRvckkdcr4SjM/Lj2e3hSa9Qdwa/bCBJTIKykVH3438nR
	R05JNCu3qYx0O5KpHrd+h40rAGm9i3sLVJdnXsMpOjSgd9GcoSdJUOqpqF0uSq3x
	2NNfw0ogf9OIKVceb5fvq5xK1PCZhcvc+uLrvMreF2MrvaDsmc7y/fL7zSoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726210066; x=1726296466; bh=fMjS7A5amezHFH/Boaia4s3lMEy/
	wCRamf1/cfTNsew=; b=N4BWrrkHf5s8uG8MJqTNC2g8Xlj8sX3G8G3vwz5T0WEd
	o/dli2u3d5cspxDps05i8ptCNzn3WTTn9tDBmlbmcZzW/+zuE+8uUF7Xkev6Ev7k
	4AbwxL4fqi0uGjHaYU8sJqGM2yqh/rllTKKzHKTmigCfacszAtAOB36E5pgbZ/KG
	ki5yEYXy/ZFgXHoBsrYaJyF9XIprYY351zON7SdhNLVpeeLiIfdalIXyV/OHxwLj
	tVnvxcj09NIlOUmAtx0nx+AtI522N6HAee66lI7JllUAFFUpgCqsfKFo2KxW2o5i
	XOGM6WGQ0rIoP4sApqxHmg7bmyubzSttlaMiEqZfmw==
X-ME-Sender: <xms:EuDjZr5OP33TfcHmAS70xi6KGbcSROcSoXZG6ygWKncChFNsVZxV4Q>
    <xme:EuDjZg5X0ddV9Zhbs7V-CGEOFtrtr1wkKEy2ktagcZGu2mlFY9tE9OtD40WUc7CpE
    geb-hOrzHYzxqC-Lw>
X-ME-Received: <xmr:EuDjZif9oFSqFW6YBxWA5MSgeRnAlouDH_R4Av5QRSlKbzeD-iAnGSUfvWaLciQDp7riBLX0yU9yaqaSh6DWHUGaeMhLH9O2Xre2r1lLinBh8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeegveejgfegie
    effeekffeijeevvdeilefhhfeuhfejieevhfehjefgheetkeefgfenucffohhmrghinhep
    rghhthhhrghtshhtrhhuvghinhguvggvugdrrghsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EuDjZsI_1CJyO3O_SY1BTpNlLFK7mpoJO1kCXu6avnPCVgf6rnk05w>
    <xmx:EuDjZvI1w8SegPHuPP5HhTdKAejIbnEjIz5qauMKLSjK6-K65rDqXg>
    <xmx:EuDjZlwAlEFFkLGSGs7zf_bpqnkamM2jDIPxtyPQqce_wgMx0job2w>
    <xmx:EuDjZrJgxHOleRPbxU6sqQskMNah6C1xFW19BR2ZolDoolGQQ3T79A>
    <xmx:EuDjZn2VQXcVo5KKzdyj3h_5W1zo2zt76s8rQYJ0NFREPad_vjvNO7Ri>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 02:47:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e25bcf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 06:47:33 +0000 (UTC)
Date: Fri, 13 Sep 2024 08:47:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/4] ci: add Ubuntu 16.04 job to GitLab CI
Message-ID: <ZuPgDQ7s0B07pzPz@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <00a9fe6b7d77c16c9fd6dfe746aacf9068a76942.1726206484.git.ps@pks.im>
 <20240913062113.GA1232933@coredump.intra.peff.net>
 <ZuPeJqOg2GFqqOxa@pks.im>
 <20240913064352.GA1234648@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913064352.GA1234648@coredump.intra.peff.net>

On Fri, Sep 13, 2024 at 02:43:52AM -0400, Jeff King wrote:
> On Fri, Sep 13, 2024 at 08:39:34AM +0200, Patrick Steinhardt wrote:
> 
> > > OK, this looks reasonable to me. I do think we could have our cake and
> > > eat it too on the Apache support if we added a GIT_TEST_HTTP2 knob. But
> > > it's probably not all that big a deal in practice, and after another 1.5
> > > years I think we'd drop this 16.04 job anyway (since it will be out of
> > > LTS then).
> > 
> > Note that we _do_ run the Apache tests, but only for HTTP/1. That's what
> > the "auto" setting does automatically: Apache starts up just fine
> > without the HTTP/2 module and thus we run all tests that don't rely on
> > HTTP/2. On the other hand it fails to boot with HTTP/2, and thus we skip
> > over these tests automatically.
> 
> Right, what I mean is that we would not notice if that job started
> skipping the HTTP/1 tests (e.g., because we changed something in
> apache.conf that didn't work on that old distro). We know it works now,
> but our ideal config going forward is "skip the HTTP/2 tests if needed,
> but fail if the HTTP/1 tests do not run".

Ah, that's true indeed. As you mention it probably doesn't matter all
that much. I think it's nice to verify that things work to the best
extent possible for such old platforms. But wiring up a new prereq just
for that doesn't feel all that important to me.

Patrick
