Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB6429CCB
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828108; cv=none; b=k8aBTUIiK8Zk05Us61YPCX2i3E/XQ8joKzTTLCBY8HUZqu/IKfTt7JwpxVKPnNAJ3e91pkTGYkgUrhmnW8UPsY8d/FVi1jpinuhL/mOtf9n+zqSmBDm0pncCBX2L1gQrfj7/cLROklfo4ydQ4e9I5iafg8ohjtKu/wj8h0QbUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828108; c=relaxed/simple;
	bh=gVchj1NSgj/uTptwghogd11Sce5kiUxpCIb9ohAcxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwH15rdKjfUW/P3ym6Aqj76lX5TTZQm/6m4dIjwjcrFUhGaKMdhhnb3acMIOiydc4F7uZ09VgBa/iy8CNre41XqzYhOfnZghpE3u5b8ik7+Y6Fw56+OvvxXA1H6guKCl+4a04yiki/+MxNZFbSzsdPBOL00VPu9OnZpVNbF5Oek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Phb7CQDE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+G7KiMJ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Phb7CQDE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+G7KiMJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 35B5F1D00181;
	Tue,  4 Aug 2026 03:21:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Aug 2026 03:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785828107; x=1785914507; bh=UA+lY+OfNS
	oXFo91/3gV5fEA1di0gb+F/XjR094doXE=; b=Phb7CQDEZreVYqbE3VmwTfayYO
	rh+/1NH8jepVaPWpljeUFJKYDP2okqX3tKmWW6WeV8QRj/lz9aDhaQWpqsbM8s6l
	z3cd4SEin9KEfVTuQseYSfYvII4q8g+xETC1UbesEJFXAQo0ZxlmndSDgHY0hz+n
	RM+2hVumHPzKG3Z88qoHMiUbt4kBf4CcLXUfv/b1GqBBjRgd9mNzICySpkVa5qsL
	xOqTgz361hUAL2LCCdup/0Upg0dNr2rVBg2XSO3GFp+5TnMW4jb5dEgDfQEo0saN
	cGWXNpRoc799ALWpdFh5kjNQRmYgSFO5Sdi+zCc8AQSsJ0hYI1w3k3Bl8u2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785828107; x=1785914507; bh=UA+lY+OfNSoXFo91/3gV5fEA1di0gb+F/Xj
	R094doXE=; b=d+G7KiMJ1aNXcEG9B5ZpgKVEidIzYGJ7Cd2wEPfsq5SzuzoOJ9W
	YkJHrsUhz3GeZFsfp0ks7IWy+mK3Z78jHqLo2sY9rESSkAsGbQIce/bG6rEG39+N
	3Nb7dPFKXx5tqfMXWFmBrYAOiMzSeWrvMRMQXtqiUO6zoDrgevOmXtAdvOjPg5+B
	OWVIq2pO2i2J8tNLtWTDQvznrtoC30WdjgX81s3mOFw7S6suUXYQ94bAhfWTJdu/
	h46uLPnznWC+6qp++KAVZ/z63pPoZ7ngfkw4jtHWz/f5tbyUUSf2NXFrI2PL3xbn
	n3DxbCx0PNRJPGYw8RrxpPgsp8Y6iG8dW4w==
X-ME-Sender: <xms:C5NxatcfZaS4d5DEKQKHf5N_ENhvLKwKlcXZGC8Nxzq0pVKw-LqZPQ>
    <xme:C5NxahNYcX7yBtczq3GsG7jyv1CjQLn-xHQ-ZgG-8aZ2ja82z7Zqkw586KhAEszaw
    gibxWQH585805hiViof6KHmUSHW-OXI8kXmMdFXHwM9RtldRpVh7kY>
X-ME-Received: <xmr:C5NxakKIMIv0zLEyWHDKM9XFVNXqyFCL9RlsaXnRvPYJkFOTJy-es06-dtMz0YtZuCeaV6_dUO6SgOq2MM0fkMMCjcptyxMSxTrkQx0E>
X-ME-Proxy-Cause: dmFkZTGWPAhypQUYRm27gdIhV9YbkY2BpQ5tR9YinRZx5sVc79THE0Ep50f1xE303lapVZ
    vetPfTmCy9aoiN/sAIG0kuS/PzqqhMz7sGi3uLG0MOPAo3FVtYDLsLfcFkYCaalyF0OWtk
    blBMUQ4gal/mUZpo49CpJwPH+o4xssNM8nzOMxFCDOQCxh63xfjqrXuV6ECq6kXj8bVmwn
    E4Jy3zlQ1NMTMEroh6Q4xFbDDlCPhkC/CDgPqtm4fX9fubSlZAtR/yavTxzDinj9er/Rps
    FObZCMLTGAidkOBJ1OOybouoJTWr7K4+Nfodwb4VgQs35Lm2VPBfmv4NklHZyM3bujElD4
    Kr0eoPBTPIqgJIDlKfBpdQUjGjP/qDL4mGWDs0pcLlE1JYABjrSzi+7GrYCdMykT+Qr1d1
    /NJ0wuI2Hcgrt5esqRpCZcEB14JzAvnVLSeZfTfFJK+ZBH53Ksf8p1XpNYBHpkHIF9XO2x
    IL/RkXTJiTATubuv+Zt+D5BWiwmJ06wMuQ9fNIMg7b4qzCp45fPUyAIQfovf/BRzkXhUxC
    ue56xJIzDzuVxl55Ydyjk5jtlknQD2ciJwCjAAFUYGqT4BK7VRkIbikhyXNDpE8zYt9Zs/
    H+lLsfGtzcuJ6PVbmtSdczHKSV+ZCHxGPv6zFTBuAggDWpQlOJCaWf+wsTmg
X-ME-Proxy: <xmx:C5NxaiGZx94VB4NVec7dqJS0E-_TB0KAwiqeHfz-4hm2h_j3pLkcBQ>
    <xmx:C5NxasRWwuAfE7g5Yr6T64nMPDLKwWgNpV6XcORRubtbAp6RL2VA3Q>
    <xmx:C5NxauH0-t6zeTxYtu15KS-ePckcfi8ezy11l67zz0wSyOVH8PTVJw>
    <xmx:C5Nxao8c3SGafvpZcIOcSDWqTN0Q1hwalK_SeXRgbb5_qD9Ef_EkQQ>
    <xmx:C5NxakMA-OI4FqbZhrdr0vQY1SZnS2zBxwY9ls9iHAkbMu7R1YiaL4Nh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 03:21:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8798474 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 07:21:44 +0000 (UTC)
Date: Tue, 4 Aug 2026 09:21:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] setup: defer object database creation
Message-ID: <anGTBQIYpDl7HbXf@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-3-3b3d265d979b@pks.im>
 <amkXcmwzbBYsMgjc@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amkXcmwzbBYsMgjc@denethor>

On Tue, Jul 28, 2026 at 04:13:42PM -0500, Justin Tobler wrote:
> On 26/07/24 05:48AM, Patrick Steinhardt wrote:
> > In a subsequent commit we'll make the creation of the on-disk data
> > structures of an object database pluggable. This will lead to an
> > in-between state where we have already configured the repository's
> > object database, but it's not usable yet until we eventually call
> > `create_object_directory()`.
> >
> > Defer the object database creation so that we handle both steps in the
> > same function.
> 
> So IIUC, the repository gets configured via `apply_repository_format()`
> which invokes `odb_new()`. In this patch a
> APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION flag is introduced to allow
> the creation of the ODB to be delayed until after source specific
> on-disk state has been created.
> 
> Naive question: would it be simpler to just require invoking `odb_new()`
> explicitly after `apply_repository_format()` in all cases? There doesn't
> appear to be too many callsites.

I don't think it would, mostly because the logic to figure out the
object directory and the alternate object directory requires a bunch of
logic.

I think it'll ultimately become simpler though once we move into the
direction of what we've discussed in [1], where we said that we want to
move handling of those environment variables into the "files" backend,
too. And then it might make sense to revisit this.

Patrick
