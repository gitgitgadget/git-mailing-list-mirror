Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446812D1EA
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811943; cv=none; b=dH+oTXKbD6YxT1SbmNqnS+OBYxpkDtn5hE6a3B0Bt3PDtsrzCpmAjf2Envj8W1c+CaGCEzMYIG+y1exCYQl6MT79IHJrne8pRDh24N/xSPaGRLUJ5U7iUO6ndhXQeotb/ggkOv3sg9vQ5dHaLEovKNwKqKb5ms4yjGkv+Vy9EEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811943; c=relaxed/simple;
	bh=McprMc/PDUqwOZcZWNmJOfdzzdrR6LiTwL2szFh4FoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Taql7r0KVPNcTyTCX9r7uLGIBGnCpEGtySjD6cvtQWpAvnt90fZUrmjkYY5itBl08QUqdbbU+Y/DVCH4u81IlHLkckoP2iE1yOEC/NITwUygDJuM3/HmXoVI2Ksc5k52n8D+R8PZlnFdFalb0m2NCosAWUV1FdidVZ/QJWbI1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XAFQxM9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZzxgUEFf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XAFQxM9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZzxgUEFf"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CB7881150111;
	Fri, 16 Aug 2024 08:39:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Aug 2024 08:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723811940;
	 x=1723898340; bh=mpaMvJmc6I4GIqkqYTNOIqPzcl/mGHFhHMMwNu3xIn4=; b=
	XAFQxM9NuMJfwgpZPeF46IOqeJlvYFzbP6nLfxwxCQt/9AWnUYFIPyW/kMgbYveN
	Yj8+Yuu69h+iVPu3aLEtdT+pWw+cegZjdwv27mGYrUAxcER495xRb3N5Sc+vU+Cu
	1okrzN8HAiBTjU50WNK6SSPTWh0gXoWsuGkW7gY5EaOBLIO/te12c571FZPjetwP
	NvXDghhIqbEFqz8LrI9MVQsKh1YyAtFaGPkh+WduEAGd98vTlQa2OxDC8qbMXijL
	ctMjpRRcL9U3yXAsCh+kAP7jd1zZjSNPmX7mTUGMdHd6qfQSDFyO6hexa/nJA1eU
	Y/XPoCvecY+dvPwGDfcFvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723811940; x=
	1723898340; bh=mpaMvJmc6I4GIqkqYTNOIqPzcl/mGHFhHMMwNu3xIn4=; b=Z
	zxgUEFfpvryv6kXd7SXsgiMlRapuMkpoD+S1/1uMnDLunwYQUfIyn3sBIIIpSIfG
	Y96iVVZHA9bvx34+B+HuAXXl10BMZsgaD4bw2T2b6aDvUJCYzAeGc9zmNYtEczpP
	QQsDaWqPP9v88GXonRJJ+yPVAZo/Mc6IBIZL7J7B0oaSLEJ/tTJ6+oW6phIlmd/9
	mBVkTmjKfFNWHQZCVZyB8zgtXRts5AEmvBCYGb1RxQcWpdv8Cw5FpgRg9DHehKhq
	SuRuK1UtyFFRxDx1q0vELTB3dQfxmSlFASsm19TvviV7XFbswkg/oqLXj6ydCIEH
	YjuCs/VmS6Iy9gTqjdKLQ==
X-ME-Sender: <xms:ZEi_Zl1LSuLX975WMuiLxQtDhMaHmKxIU05hmAm63B589p77UNdMnQ>
    <xme:ZEi_ZsHACYH786SyHlhY4g9HfQq2wcoA578QeiIxlV13zho6m3I6O_0DJJRSCbLE0
    5kfD2gDBdvlOfMCPw>
X-ME-Received: <xmr:ZEi_Zl7QoLtDhyPLI-pefscf7hOktc8LlydA6VfbCNYGjS-i6pc4fJUdFIHInQXE8qorZk56V-JgKngBTk7mBaQ1-Gp6thCNPILNYi0bC88RuZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghvihhhphhitheshigrhhhoohdrtghomh
X-ME-Proxy: <xmx:ZEi_Zi2YOD7zmA8lq2HWS5hVrbIqav3fgJNY0_Om7PzWREzoW288Ew>
    <xmx:ZEi_ZoH9kOJPkzd4S5OHwKZE2zs_ucFrQeFxrVP6AfXXWGtsxjonNw>
    <xmx:ZEi_Zj9yUM1bxMTnMPBDQQfmZOt6LWcANmMYYKpQtMStZuH7ThDE7Q>
    <xmx:ZEi_ZlnQlhi3hPsvoaZ488Xhv9xljZJf0srqEpICZv_Ey2xBN9EqrQ>
    <xmx:ZEi_Zkixpo9YYfAA5UVUjCVUvJuZ4Gx588IqilWuInZlaxRH3jqEYojv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 08:38:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9055d6e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 12:38:34 +0000 (UTC)
Date: Fri, 16 Aug 2024 14:38:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/8] git-prompt: don't use shell arrays
Message-ID: <Zr9IWBRHBkcTwPZU@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
 <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
 <7e994eae7bc3dfa021262410c801ddb124ce24f1.1723727653.git.gitgitgadget@gmail.com>
 <Zr8Swsn3H2ebB7g6@tanuki>
 <1677713578.1741123.1723802016957@mail.yahoo.com>
 <Zr8vWCKrddYpABIr@tanuki>
 <701460728.4505561.1723808133505@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <701460728.4505561.1723808133505@mail.yahoo.com>

On Fri, Aug 16, 2024 at 11:35:33AM +0000, avih wrote:
>  On Friday, August 16, 2024 at 01:52:11 PM GMT+3, Patrick Steinhardt <ps@pks.im> wrote:
> >On Fri, Aug 16, 2024 at 09:53:36AM +0000, avih wrote:
> >>  On Friday, August 16, 2024 at 11:50:14 AM GMT+3, Patrick Steinhardt <ps@pks.im> wrote:
> >> > On Thu, Aug 15, 2024 at 01:14:08PM +0000, Avi Halachmi (:avih) via GitGitGadget wrote:
> >> >>
> >> >> -            svn_remote[$((${#svn_remote[@]} + 1))]="$value"
> >> >> +            svn_remotes=${svn_remotes}${value}${LF}  # URI\nURI\n...
> >> >
> >> >
> >> > I was wondering whether this is something we want to quote, mostly
> >> > because I still have the failures of dash in mind when assigning values
> >> > with spaces to a `local` variable without quoting. I do not know whether
> >> > the same issues also apply to non-local variables though, probably not.
> >>
> >> IFS field splitting and glob expansion strictly never happen and never
> >> happened at the assignment part of a "simple command", since the first
> >> version of POSIX in 1994, so quotes are not needed to avoid that.
> >
> > That's the theory, yes. But as said, we did hit bugs in similar areas in
> > dash where that wasn't properly honored, as Junio also pointed out on a
> > later patch. But that was in non-POSIX area anyway, as to the best of my
> > knowledge it only happens with `local` assignments.
> 
> Yes. "local" is special, and not only because it's not POSIX.
> 
> The difference with "local" is that it takes assignment as arguments.
> 
> A "simple command" (posix term) is composed of optional assignment[s]
> and optional command (and arguments).
> 
> The assigments part is never IFS-split or glob-expanded, while the
> command and arguments part is (in words which include unquoted
> expansion or substitution) and therefore needs quotes, e.g.:
> 
> foo=$x bar=$y echo a="$b" c="$d"
> 
> There are other commands (beyond "local") which take assignment[s]
> as arguments, like "export", "readonly" and "command".
> 
> Before posix 2024, these commands also required quoting of the
> arguments-assignments - just like "local" needed in dash.
> 
> But posix 2024 introduced the concept of a "declaration utility"
> (which takes assignments as arguments, like export, readonly, etc),
> and the concept of "assignment context" where IFS-split and glob
> expansion don't happen - like the assignment part of a simple
> command, but now also in the assignment arguments of declaration
> utilities.
> 
> And indeed, new versions of shells now don't need quotes in export
> etc, and shells now make "local" a declaration utility which
> doesn't need quotes of the assignment args, including in dash.
> 
> However, the reason we do use quotes in local, export, etc, is
> because many instances of shells which don't yet (or will ever)
> support it still exist, so we quote for compatibility with those,
> but still it's only needed in assignments which are arguments to
> commands - not in the assignment part of a simple command.
> 
> I've also updated the wording a bit of my guidelines in part 5/8,
> and I'll include it at the commit message of 5/8 v3.

Great, thanks for your thorough explanations!

Patrick
