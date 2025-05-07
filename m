Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790201CEEBE
	for <git@vger.kernel.org>; Wed,  7 May 2025 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599266; cv=none; b=jogx3CDkslQ60J3S2CgFsQMqYjNUf9ReRScTAvLS94muEtQW40gPeu5y3konQqpnrzuY8sl3tZvkQ93nlQZkB3an/txx1Z7Ydx5g78fddthpD0ZWzfVm7nVXCuntyCTPRAbMHcGUDAffytqqPIXDci5FKA0OkDhezQk4QMn89LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599266; c=relaxed/simple;
	bh=dW0Ov+FXoxV01UlvAWSrqtSt7lMb5XKjHKLfFYobpnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNjj4+ABT5zEYqYla6zAhAmyWEQ0yMz5I9orYii1JE1o8LsUJ3eims6wbIR5C12RJVEYFrs0qVzfaet4wLEWOlCdI165YDUi7MoG0K0NkyCtPKAANXYNgokfZJyg/OgEK9WnKGtehUy3aeabuKwNV9KUfNjj5yKOACWjh0AW6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ql2k8lUK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HfPL2Nxe; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ql2k8lUK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HfPL2Nxe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53C4125400F6;
	Wed,  7 May 2025 02:27:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 02:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746599262; x=1746685662; bh=dKAhFSHRFV
	f4PiKFhz8HG4yLYeFl+YYp85FjKVN7W5A=; b=Ql2k8lUKGjg0kZIG9s/099fCO8
	obP+EscE81NazfoyARaT8wF2/Y97rRX6j+6z3NMrNAPs+sjdTwkI3UUS+IkW83hZ
	IVI9afz3i0LSDwpeJ/LNqLW+S359gcpc+kxvbrUMzD6qRRBWXrH8rqB4PJRSbNXY
	FaeQvYo/nxyA85FhQYHeEwU9oLQDTZ8XtnUMzukWGIViEFh/gptbbSWOQvJtEldy
	BtFKV143Hg7H9oD/f1/SoyPS5O9c78IRiTRf57Z2Oy9XDYxcigwlfavOHJoDuoU1
	wm3cnmEr55qmL0kfVrP/tA6efKs7siwXrRn3PVXiRAMSEB80KC3tZrMUK1YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746599262; x=1746685662; bh=dKAhFSHRFVf4PiKFhz8HG4yLYeFl+YYp85F
	jKVN7W5A=; b=HfPL2Nxewy5J+2B9/Ngcc8iPv7AP7sYBIgf6Nkf43R9Y68LMXqe
	Pw9IJetygw2TFrfMxLUYWhNKoUufppLhmCcy0RqKSS44X+yNWoYQXu/ZVKZOUSuF
	vmFLy1eggg3T7ali8n2OXyJ4AL93raxy3+gaRgn8F0wL+QQbCK55+aKkR6B5zfm3
	ypcAc4LDPHLbc4kuQQgwqZbqFdLCD06hY+hxQa2rwgae6h+Zm8L3Dmbfqd8t2qFP
	Ud5JpgNkRshfVv2RYebCzQbc9j1l0+RfLd9VYeaOPLu4wPCzeM/0oFKyLvlysvD2
	D6F5TCxuIOhvJxkcHm8pnK+0phWNj9L0VZw==
X-ME-Sender: <xms:Xv0aaEMJ7edy9Bu7ZH68vSJxMEL6UWHVbmtZoXM_1HCZuXUEQo97Zw>
    <xme:Xv0aaK8_-aEi9FkgDuxKtiOShSQ3QKE0yp3QXgBnpDo-Oi00f1lQ47kkfswysht1j
    uAi9RI558Yf9L365w>
X-ME-Received: <xmr:Xv0aaLSvC1VtZW1PMkIG5DKo6kSuEcjMUlAAvEWaSX4cQWij-Rjous96q97BbAFJrKY9sxqfslHKLBoe0xc2t4Iidsbcb-phSThAdRrkZnR3pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:Xv0aaMvzqAyvJffIy2qHOM0Tt18Fsbwpzxq4h-o9v9Cg4vEch8cYHg>
    <xmx:Xv0aaMfzXzSX3Okk08bvXP6ewvPMN0iJG83MDl4gu64WDAVcgOt8lg>
    <xmx:Xv0aaA0yOlBb0PfelJC4AQseqXrZO1Y520HwzvizyvPbeeyh8doptA>
    <xmx:Xv0aaA-PWE7kFuwA0yljn1r8-m7wwE29YWGWIRd2ssXfcQSYKrJyFg>
    <xmx:Xv0aaAMBJ2Awxu4PyTxjniXM9O8ftXkBcVBMWyEqBRMa1GwLemiMSL7u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 02:27:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e690c07f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 06:27:36 +0000 (UTC)
Date: Wed, 7 May 2025 08:27:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] contrib: remove "remotes2config.sh"
Message-ID: <aBr9VuYurCCvRYnj@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <20250506-pks-contrib-spring-cleanup-v1-1-e6d5ddd79a72@pks.im>
 <xmqqr011ikjc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr011ikjc.fsf@gitster.g>

On Tue, May 06, 2025 at 12:52:39PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Remotes can be configured either via a repository's config or by using
> > the ".git/branches/" or ".git/remotes/" directories. Back when the new
> > config-based mechanism has been introduced we also introduced a helper
> > script that migrates from the old-style remote configuration to the new
> > config-based mechanism.
> >
> > With the recent removal announcement for the two directories we also
> > started to instruct users to migrate repositories that still use these
> > mechanism to use config-based remotes. Notably though, the migration
> > path doesn't even use the migration script. Instead, git-remote(1)
> > itself knows how to migrate any such remote via `git remote rename`.
> 
> Makes sense.
> 
> This logically comes after your series, which ended at 8ccc75c2
> (remote: announce removal of "branches/" and "remotes/",
> 2025-01-22), lands.  After that, we can safely remove this script at
> the 3.0 boundary, at the same time we clean up the code paths that
> are conditionally compiled with WITH_BREAKING_CHANGES.
> 
> > Furthermore, the script hasn't been touched since afa75bc8aa1 (contrib:
> > Make remotes2config.sh script more robust, 2007-12-02).
> 
> A single-purpose thing that is done correctly on top of a right
> abstraction does not necessarily need further updates, so I doubt
> this paragraph contributes to the decision to remove the script in
> any way.
> 
> > Given that there is a migration path without this script it is very
> > unlikely that anyone still uses the script. Remove it.
> 
> Sounds good, but not right now, I presume?

I think it should be fine to remove it right now. If it was the
canonical way to migrate repos to the new format we definitely
shouldn't. But nowhere in our tree do we even point to this script, and
the deprecation notice we have created explicitly tells users to use
`git remote rename`:

    static void warn_about_deprecated_remote_type(const char *type,
                              const struct remote *remote)
    {
        warning(_("reading remote from \"%s/%s\", which is nominated for removal.\n"
              "\n"
              "If you still use the \"remotes/\" directory it is recommended to\n"
              "migrate to config-based remotes:\n"
              "\n"
              "\tgit remote rename %s %s\n"
              "\n"
              "If you cannot, please let us know why you still need to use it by\n"
              "sending an e-mail to <git@vger.kernel.org>."),
            type, remote->name, remote->name, remote->name);
    }

So I highly doubt this script plays any role in the migration towards
config-based remotes. Also because the script only cares about the
"remotes/" directory -- it doesn't even know to migrate remotes from
"branches/".

Another data point: the script doesn't even work as-is, as it sources
". git-sh-setup". So for it to work it would need to be installed into
"$prefix/libexec/git-core" together with our other tools, or it needs to
be called so that "git-sh-setup" is in the user's PATH. Both of which
seems quite unlikely to me.

All of this reasoning should of course go into the commit message.

Patrick
