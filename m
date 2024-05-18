Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A704503C
	for <git@vger.kernel.org>; Sat, 18 May 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716060745; cv=none; b=SvQkZrm7VFC7W3SGeq4yqd7a34CLEIBRTe997D2uEzk7PaWCUevSP4tTcm14Cr3yWODZchMHHr7XrsN/SNsuYZrhZSpNFqnSWfs+4AgtiOEjOIv188yjG8ccy/2RMV6ho9SRf6aO+7Pr+hmf5P28Ccrj2PVFc20Q3BFvHXOjr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716060745; c=relaxed/simple;
	bh=PdjmwHn6CYtpYQkB+ubYBz1xHIJmXqxhrQoTBssa+jU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MnQZBG+JN5QGaPVvU26k6RHNoEOn4qGcd7eP3HVZD6saGx8ctaDAxpp71ioQhbwX77NHCplxDh3gHd8uGkFsX9hqyv7eFKCATdQBpt1I665gjky4kslz7t/oK/fcaE9SHe4nvLzyhuZ48GFCfKRIzQB7vK1X5SHUYEXRwJZbMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WAwC+RME; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WAwC+RME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716060728; x=1716665528;
	i=johannes.schindelin@gmx.de;
	bh=QXC42t8/7a8YiPL/rNUcD+/xIh5LtBU85nZo17WV22Q=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WAwC+RMEW9H2/PBe/+1l/f6912vBRYuSVnngayiefojMFGLgimX5OchLnkU3z1In
	 M2Yiy1WMheShmok6q9Qxi/m/2AfAItkk7titMZrGetCMrVYQ5IbC5hC9l5qZolEwX
	 WVbl9uEmVu+hNJHaktXMLZiByMmCEdbFOrmgQL3KJeTvFSuQ6ESUTNeWPHnQPewzt
	 reSSbE21iMSlSj5etct2MjloUG/geaxsYrUCQZ9WUoXFghMeF43MtPazYXdPV00sw
	 VLah2dt0KCPq03pqplfIBF50nY3WDZN2LA8/7/yG0sXvkBuNyebexCs4lg5PpDyiF
	 EThRZikix1iAuRWlvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1sJTSS2AwK-00FR5x; Sat, 18
 May 2024 21:32:08 +0200
Date: Sat, 18 May 2024 21:32:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <20240518181432.GA1570600@coredump.intra.peff.net>
Message-ID: <c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com> <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com> <20240518181432.GA1570600@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zKnYV//UodTsZK8uUY48Xnd90rjiBV6yncNiB7bTgZve6C2M/ET
 kHJsypatsXvXyVEtbhsYTTSkvWfS8hbgwP0n8skvLBicg8Nc6lYuIuJUPL5ZCPs4JY8PE5L
 jYwpwHx3qV6O8HWsrcMX2WO1291GGTKyYNGAwqMjrp27N++ylnE5yDhzE6glFdfTcvN/kK5
 tWb25Fc5uX/sxNyRhVZVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jy4WrflMrZ4=;c+QQni+g/hDhAeFUweCJW7LmbSH
 QfKfa6JcLtcJvLu4RSyynp9uso76STzhx5muOfSEutoltsdPJVXjv8hooQYl18KIHmUx/fELr
 F+Dfl3b3iHL+DmrAgyaKDAITOgIsoQXSExaQ8/5XeOG0/oA5PyUQNPgiope3iHzmXJzXA0Cwq
 OTJhxY9QCSZevXOuIvwnXbvD3CEBqf0koGCzgJnKrgQCtr+HOcT15CM5+eYP337AFySSDkWxi
 Iej7w0VqxFi35mr5cSuoEYhfZ7lgH8ItIysRLyXGc1TN1G1Q0hX0PlrO3rErIUfyfI2UjWGMd
 Y8lUpSyArMXeK71aS5lmQzMyxFVVoUdbVE7b531KMfGJ+Ntvw8F23IXEfs1H3onQRueveAz5/
 8/kZKJW7oHb8+3LaWal4h+4Ov9slI0m8yupub+VSYKNdPkdBmFYoZgIWTViL82gdliWrltvv/
 y9USUvPitjC5t4+2EsQWLJTyfCjUkJjUlGrGXcoDqvivkHoR/xysGXEPVMygKchcy8xsNtLdU
 0bc1WNu290ztEFfhewZ582fE6FG3iVP8q/Ayw1a9DmMPmuBtI6B44L96Qdqd09PGqPJBFjptH
 JZNIvpD+w618J67zMBX5eIfo9uil+CPyFAh36i2XrPIaiaAZ996GAkBUFZUdADi9sjYYQ+hi0
 vkXWKK3p28ouhDYnmLkf8Rw2v263Vbg82fodVqvo2bIOsu1Vr4RdRTenoDcDUaqxNHEpSHiJj
 DtC+gaDf1R5gwZxNIoGH38ipL8InsTMShOvnm4WhpJ6uUFRFspOluVC0JVJI1s7mK95Uyl7m9
 2PWQFHM27CQa2zL7FTKaNcD1geuwnyB3UmqBAi6qG7jsQ=
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Sat, 18 May 2024, Jeff King wrote:

> On Sat, May 18, 2024 at 10:32:43AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > To help Git LFS, and other tools behaving similarly (if there are any)=
,
> > let's add a new, multi-valued `safe.hook.sha256` config setting. Like
> > the already-existing `safe.*` settings, it is ignored in
> > repository-local configs, and it is interpreted as a list of SHA-256
> > checksums of hooks' contents that are safe to execute during a clone
> > operation. Future Git LFS versions will need to write those entries at
> > the same time they install the `smudge`/`clean` filters.
>
> This scheme seems more complicated for the user than the sometimes
> discussed ability to specify hook paths via config (not core.hooksPath,
> which covers _all_ hooks, but one which allows a per-hook path).

Right, it is more complicated.

But then, we are talking about `git clone` protections, as Junio points
out, i.e. preventing hooks from running that the user did not install.

Git LFS' `post-checkout` hook is an example: The user never explicitly
installed this hook, and it was not there before the checkout phase of the
clone started, yet it is there after it finished. That's the same pattern
as many attack vectors used that we saw in the path for critical CVEs.

> In either case, we're considering config to be a trusted source of
> truth, so I think the security properties are the same. But for the
> system here, a user updating a hook needs to do multiple steps:
>
>   - compute the sha256 of the hook (for which we provide no tooling
>     support, though hopefully it is obvious how to use other tools)
>
>   - add the config for the sha256
>
>   - install the new hook into $GIT_DIR/hooks

Well, there is tooling support: With the proposed patches (patch 5, to be
precise), Git will complain about hooks that are installed _during_ a
clone, and then provide the following advice:

	If this is intentional and the hook is safe to run,
	please run the following command and try again:

	  git config --global --add safe.hook.sha256 <hash>

While this won't help with the just-completed clone operation, it assists
preventing the same issue in future clones.

> Whereas if the config can just point at the hook, then there is only one
> step: add the config for the hook (presumably pointing to a system
> version that would have been copied into $GIT_DIR/hooks previously).
>
> Likewise for updates of the hooks, where the sha256 scheme requires
> computing and adding a new hash. But when the config just points to the
> path, there is no additional step for updating.
>
> In either scheme, programs like git-lfs would have to adjust to the new
> world view. The main advantage of the sha256 scheme, it seems to me, is
> that the baked-in sha256 values let existing versions of git-lfs work.
> But we could also support that internally, without exposing
> safe.hook.sha256 to the world (and thus creating an ecosystem where we
> have to support it forever).
>
> Implied here is that I also think config-based hooks have a lot of
> _other_ advantages, and so would be worth pursuing anyway, and this
> extra safety would come along for free. I won't enumerate those
> advantages here, but we that can be a separate discussion if need be.

One disadvantage of config-based hooks is that it is quite hard to verify
the provenance of the settings: Was it the user who added it, was it a
program the user called, or was it exploiting a vulnerability whereby the
config was written inadvertently?

> And of course that feature doesn't yet exist, and is a much larger one.
> But besides un-breaking current LFS, I'm not sure that we need to rush
> out a more generic version of the feature.

Exactly. We need to unbreak Git LFS-enabled clones and release v2.45.2
before I even have the head space to think more about config-based hooks.

Ciao,
Johannes
