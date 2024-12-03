Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84711F4722
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236149; cv=none; b=RMpqnk0MJyTGdcdiCvY/m1V64tv2Y1cTdpzxeT57eiUCCWZTLjjjFRKs/EG/gcV155A3MeXbHKPHaLxu3hGcLpMMmgGCLjk3DRRs22UqCDM/f1xQAvWD5ViRcxIbTc+HYF9TrJdWEL0LSMPnBVlapuIwOtyeW2UODP17/eq8l0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236149; c=relaxed/simple;
	bh=716mckX2MlZdd6F5kBWL8QcCTN2P+UZOOBRGt1YQ8Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtvqT/gWpLqbYime27y4p3DK2YgGx4OcpfDJza4oeeX9PK6MS45V57OGW9pa8j9gEh1cz5aWAH6Thgy6DTTlMQq/hyJy0MakjwK/l1TeUkmLgGZogTFBcweLDFULi4q2CzUiep9AFo3aGf1RoM4Z+y/HQaeXNbWPxshtXBzgCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IwYeYwr2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQhT0ZsZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IwYeYwr2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQhT0ZsZ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A52551140175;
	Tue,  3 Dec 2024 09:29:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 03 Dec 2024 09:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733236145; x=1733322545; bh=iBfinDQYdj
	BIJ6AW6/nfqFzlwXdKTWmCx+fTC7HJsk8=; b=IwYeYwr2nOOZgYi2a2n3teIQ9k
	BZkzizLE3zkbkaZ1YMlNYaeeLFxw+WpQ5oFgse2WYsu8YJNNug/koVg5dmq7TA2K
	FKDU6w2hJ7y7rjPZbEriTqdED31JLzwbfYWOqsETxVjx5YnbvlgQu1bgPNA9HBL7
	SecsIjJI7fgiiPKD0IUfrGTeTY/5Y/ccb48WW+KFkDXZKUKkpoBda2UumHR4lMFd
	CMf7vxjvLYYfMOTcD+N3ziMmAkMJjO2xsIRnJec+pfD6y66lUZUdSsB56PGbkwHK
	MZCQZFiwZx0FfLzvmVW1U3/c8pFu+kEgKwyninxCI6qxBCDwyxiOI/QXmN1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733236145; x=1733322545; bh=iBfinDQYdjBIJ6AW6/nfqFzlwXdKTWmCx+f
	TC7HJsk8=; b=ZQhT0ZsZGoyvAT4rQxX2DPM1IgRnq39UkK9CG4OPlJNgSojOOeH
	sSg77wIlNpQDqunCDXYtxL/Vlntfp4sBh8MEIzTRsik9UXZJI9FDllXOku5OeA3P
	EBS9HT3w46wMzJEblNGNlni6h6b4jkHemuxPgmW/NuhUgZrzq18E+Dn/UW58qHKS
	INE/gw4R+1FKyqhf1iuwNfS9KIYCO8Nh7Nav70/lw5C6O7TpSPZhy55E/A+KISxE
	DOF3vyMjgeM7r0UrOzN0iQ8OoY5ZadTLZUOtR/zv3rsqH4S77GtKmKcOmVGYlmKb
	+hDez5JOaqXcT6YjewVnFCgO/jA3YhI/rQA==
X-ME-Sender: <xms:sRVPZz2Ca1NbCKxRku2zSwT6PVyl05sXIhARnQ6scDgUHcsYRb9Q5w>
    <xme:sRVPZyFe-1nFE3bSFMgpTZ2519uZEGEwwfH2z7o3_NaViXQLwV1U8fPqaZPWWYrX9
    1PrjWu-qmHDqdjEcg>
X-ME-Received: <xmr:sRVPZz4SZYIqGVzP5hlsqgcO1TiQhJhPiqf_r-t2alTB3Z3hw_qXdCwvN1pKuny4M9kKuKDiuz_dKScwhs0CSLdse8I_f2UeGHviatTts9LNqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgs
    lhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sRVPZ43kdy3nQjQk9iTjvkEaAjJuOmjxys4f4KLVY1YcXNtqqszH-g>
    <xmx:sRVPZ2HCokf_SUWU-Tnk95gHSW9sRVeAVMI_np52p-U4rZFtfu0Vtw>
    <xmx:sRVPZ5-FQov19Pg9CNocjfHXzo-rQcWElEcP-xATJl88AKRqQpNqNA>
    <xmx:sRVPZzlQkZJKNWRwIxzoMWKsfXVt69SB1oBmFNCKuYsD_hbjsVLzTQ>
    <xmx:sRVPZyBgNDszWysBZk7Ah8hLlmlp00WNMxYE0ks1EZpOg41MfIqFjsl->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 09:29:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc7ab6f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Dec 2024 14:27:44 +0000 (UTC)
Date: Tue, 3 Dec 2024 15:28:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fetch-pack: split out fsck config parsing
Message-ID: <Z08VoOHGZ1wecUx6@pks.im>
References: <20241127005707.319881-1-jltobler@gmail.com>
 <20241127233312.27710-1-jltobler@gmail.com>
 <20241127233312.27710-4-jltobler@gmail.com>
 <xmqqed2wox8n.fsf@gitster.g>
 <Z07QqowPVEgJ3sIw@pks.im>
 <i7tvwk462uwe3syarrnmjttgu4p7urtymq4n72kj7ziaptu7iy@vh4td5fd24ko>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i7tvwk462uwe3syarrnmjttgu4p7urtymq4n72kj7ziaptu7iy@vh4td5fd24ko>

On Tue, Dec 03, 2024 at 08:23:11AM -0600, Justin Tobler wrote:
> On 24/12/03 10:34AM, Patrick Steinhardt wrote:
> > On Thu, Nov 28, 2024 at 12:25:44PM +0900, Junio C Hamano wrote:
> > > Justin Tobler <jltobler@gmail.com> writes:
> > > 
> > > > For `fetch_pack_fsck_config()` to discern between errors and unhandled
> > > > config variables, the return code when `git_config_path()` errors is
> > > > changed to a different value also indicating success. This frees up the
> > > > previous return code to now indicate the provided config variable
> > > > was unhandled. The behavior remains functionally the same.
> > > 
> > > > @@ -1866,9 +1866,9 @@ static int fetch_pack_config_cb(const char *var, const char *value,
> > > >  		char *path ;
> > > >  
> > > >  		if (git_config_pathname(&path, var, value))
> > > > -			return 1;
> > > > +			return 0;
> > > 
> > > So, after getting complaint about a misconfiguration, the caller
> > > used to be able to, if they wanted to, tell two cases apart: a
> > > misconfigured variable was ignored here, and we happily parsed the
> > > configuration.  Now they no longer can tell them apart, because we
> > > return 0 for both cases.
> > 
> > I wonder why we want to ignore these errors though. Grepping through the
> > codebase surfaces that all other callsites of `git_config_pathname()`
> > return its return value directly, which means that we'll die in case the
> > path name cannot be parsed. Shouldn't we do the same here, or is there a
> > good reason why we need to ignore it other than "We used to do it like
> > that"? In other words, I would have the below diff.
> 
> In both "fsck.c:git_fsck_config()" and
> "receive-pack:receive_pack_config()", the `git_config_pathname()`
> callsites are set to return 1 on error. The main reason for ignoring the
> error was to keep it consistent with the other fsck operations usage.
> Outside of that, I also wasn't quite sure why specifically
> "fsck.skipList" parsing is not as strict.

Okay, so your refactorings are simply keeping the status quo and are
consistent with what we do elsewhere where we parse the same config key.

> I do think being consistent would be nice, but I don't feel super
> strongly either way. I'm open to changing it in another version if that
> is best. :)

I think the current version of this patch series is fine as-is then. It
might be a good idea to adapt this in a follow-up series, unless there
is a good reason not to.

Patrick
