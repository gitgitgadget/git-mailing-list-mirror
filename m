Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C24E01E4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985484; cv=none; b=lzkg/w1rXPdDCKeNILUDEEOZ5iyztYodAi1nHVqJA5FXy/Jl5W68YW6XueZkmRER56dFds0vJYrvM7YI+ALfN9OiaaTgE26fBH6pk3YOL3qv6512qgCTNJ4j6Z0X3ETtXpRd43EKxsnJLuEDBrmiX26lF26N5tqjinJd/g0WR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985484; c=relaxed/simple;
	bh=Xupkd8GJcEmUrw1XLmK+TMIA+8ktQ3COiPeQfzJh5JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvQgrA8E8JuuUGijHVxkCMAepzrf3qbFTCqdRNdSUcgVzbALq3Sgd8SuXimJ8AAKO+A/BcHojyAFetN2ymgKCVbJbUz3LfStvNgvuN1Nb5PD5CNRcu45DaKzr436Qrz6jnectyFO+QfnBbUC8/juiJm+ECliKFnLqA0RUntulSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aflZfj/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TgqDvhxO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aflZfj/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TgqDvhxO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D127EC00BE
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:44:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Oct 2026 09:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791985482;
	 x=1792071882; bh=KUeb0nHfh/ohTOiNY+qpjuodJ/53mZUy/UiaRhUuwnM=; b=
	aflZfj/ONQHFgAvvsMpNaNRn1rxRZtb0OJGMBdKh5sre6GQklbMaC1pIlnbK43mG
	QBirYKMFMX9O7ZzLJuyGo1itzUhUNAseXTyEUDkCKrdHR6cekNHyUX8Q3Rq9OLC1
	mo2GXcYbHfRSSuIfNr6Q9SOy+4F7TZ7/0QPHP21QV4BBHZmnhvZoylkS0gvpoqNU
	XiF5kEz23q4UlYGk8qaEkwxKnsvnCU6fPES7NZn9v5VY5dgLMu8ZFC3ucD0Trz4X
	3Xe5uJQY26BhEfZBWULyU5GKs6/L7CkS1ollHt1jGUt9pPjZJTlGSb7UdLjp+rTi
	/aMOLn4ZS2amlyT1SwZv1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791985482; x=
	1792071882; bh=KUeb0nHfh/ohTOiNY+qpjuodJ/53mZUy/UiaRhUuwnM=; b=T
	gqDvhxO7aNK4gWqT621m/mH5ejypZSfdP0GocjI9R/dFH1GUxFHmvIaCAz/5Hvvj
	NPHdRV0jgJmMbFwmRLVSjUW8ewjpNCmvS405TSQh5ML8ZAkh85esHZ92Y/dsEyFP
	/7vjosYykl1j3AFrjFJAE/+m8cvlwzjJzXct0K5m/8CsKm7TpsdKjtWGFtl9jZ7H
	VqIzGiCxTzzQCLvmjWVP1NH9AHPoheEm6DZPmMFRaXBl2gUFLPkGcptCY8eARTkz
	dHEwpfHs5Awlw/YRYUFqmVZ+TuA2AyESdCGgNu+Lq/wc38Pm3LRM22+KJ09Oh5jr
	5soHrtZyR4v9gSETJIDGA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791985482; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pksjaFQKRoZqDqq+b3pEAIF2pjRIEA4puvbqe8OczxnzLO7
	g7EjNnx0Wdmudjy8BligcvcM3vS0EDzXadodliu00ufkgIdfaEYSH+z0Rctwdipg
	kRgIudvAyEGXs6sSQgEJX49Ur1dZdOV2dIT6+TxSb4Pskc8e3stLbobF7NMVU8Vw
	9vRHVd7CgVp59NAGObCZ8L0cgUjidYB/RGGVKhlA/ghUEX2qqki/j9STolYaP7rs
	axK2cTHenHpecj/X85NIVIcAHef/WC+Z85eaOoZM2wi0EVGC1qDgV/iPqkX5Lx9V
	F/Ibfz+eTXvPZ8xiAHCbAQP3z3uKu8xk4mIMrzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pj76DRyDz2/iLLuBxPotKmOzyoTWDS0U5r5NqcHN6jQ=:Xupkd8GJcEmUrw1XLmK+TMIA+8ktQ3COiPeQfzJh5JM=;
X-ME-Sender: <xms:SofPaoUMxebcH8Sv80NYFyXOV-jv6aEu5QfXY2Jafnh6ULRnv14YJg>
    <xme:SofPajmT8I7rC2HZEGLPTZnwdVEEI5Ntbb8f6xl60EKLcSXw8iSGxDnIqII1xTYQI
    GMAR-6ltxFZ28LSBqACEwmTdFDWu2Fi3yRaeOcoc0LNIw1MKpJa3rI>
X-ME-Received: <xmr:SofPahbzKZXc8FWzfKUdMl2cXg93PgguWnycFsZxM4IeTR-tzNcfQw>
X-ME-Proxy-Cause: dmFkZTGWChzRsuA0t0UaIzf8W2W7a7kdANYn12Gs7y/skt5k7F9ZtpSrqnetHPfD4WuJAB
    btlLTrT0Nfoje6zShcJDhLbGFJRPtNa1Mx91EF9Ltvq994+BMh7KDEcdhMRNYMDNZdWCII
    My86EfXnlg5OcGbaqp5BPYL7zSb78XegI99AmvqryoBfRoemHqVG2o2sN1oaLyvaJDT/iU
    CBzGxp1G8TU2x2vNL8JrUPiFYvUQnDeOi3Q8xjQB8834xJW+VbQldz4NQgQ2mSv1bxnk9J
    6tjNcFEubJiZBsDUBdKNwTZ6xg2K3zfL2cRejZk0EkbTGyPa2bZA6dz7CBKxxFZJMXiVJ7
    2H7TcVUbr72nHj/Qz8PPoQMdalxCJvQaBMHqaHUh4jLfr95ozgGK5i1EodeC1pnoMmJ8VT
    VOOHtFxYrhqS4BXjZSI9i6T7zHoRf9fp5RqMD10LKa0jlGrqbEvmJhST2ioD/RuMABq31f
    JbEMmyRZQImAP3sGgyO4cSS6UprarqwYxlbHXSTL1rFtMZI1aHSyrC7/jGS9158Q1I8UTK
    t/sTqVW1UkcN96kYF/AaORKR3Rtpb3nsjgHhFk0sJ5Pptg6Ggz7PLss12m9OOX7KmlpneJ
    Hnd9lrqVMw09y9P9wZsYSf4nMHxVd2qSDdOZGzRKXcWlq2ciZKMqO2LljbuQ
X-ME-Proxy: <xmx:SofPamNSqjioBfRXfimNXOd3MReQ7WWphZNCzKllxyPADvnBf8fKMw>
    <xmx:SofPauY7D6FEslL2__vbInnzVZzVSSD6EkFeCHeBqpSPsncwqp9bRg>
    <xmx:SofPas1y6z0Oht-tbHBmzO04fRdu07EvrWnlYmUV9aJr7Tl5lswD0w>
    <xmx:SofPasciSwk1r7I5dje6UHyBqZlt5DKjsJPR6L6CsJdQsiQkMeskyQ>
    <xmx:SofPakRtdJ4hZRLpl3pJCu1x3tdJaT7iswtDKUx2YKMAE_ndHJcy0BGN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 09:44:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7622fa96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 13:44:38 +0000 (UTC)
Date: Wed, 14 Oct 2026 15:44:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/6] odb/source-files: fix performance when reading
 objects with alternates
Message-ID: <as-HRIokfGK555yo@pks.im>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
 <20261014-pks-odb-files-alternates-cleanups-v2-1-fed9b2caa3be@pks.im>
 <332d341e-0a1b-790f-4b0f-55a7ebb80f3f@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <332d341e-0a1b-790f-4b0f-55a7ebb80f3f@gmx.de>

On Wed, Oct 14, 2026 at 03:35:56PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Wed, 14 Oct 2026, Patrick Steinhardt wrote:
> 
> > With the move towards pluggable object databases we reorganized how we
> > access alternates. Before the introduction of pluggability, we were
> > reading objects by first scanning through packfiles from all alternates
> > before scanning through all loose object directories. With the change
> > though, we are now iterating through the sources one by one, checking
> > each of them for whether they contain the object either as a packed or
> > loose object.
> > 
> > Checking whether an object exists in packfiles is comparatively cheap
> > because the list of packs is cached, and the pack indices are likely to
> > be in the page cache. In contrast to that, checking whether an object
> > exists in loose format always incurs one stat(3p) syscall. So scanning
> > for objects one alternate at a time led to a performance regression in
> > in the case where most of the objects are contained in a packfile of an
> > alternate, as reported in [1].
> > 
> > We could fix that issue by introducing another flag that tells the
> > backends to only search the optimized storage backend. But that is
> > adding more complexity to the object database layers that is ultimately
> > only really required because of the way the "files" backend stores its
> > data. So for an alternate backend, such new infrastructure would not
> > really be a good fit.
> > 
> > But since then we have moved handling of alternates into the "files"
> > backend itself. One of the consequences of this is that this backend is
> > now having full control over all of its sub-sources, and that also makes
> > it way easier for us to optimize for this access pattern again.
> > 
> > Do so by first trying to read objects from packfiles located in any of
> > its object directories before trying to read loose objects.
> > 
> > The following benchmark demonstrates that this significantly improves
> > performance in some cases. The benchmark uses the Git repository itself
> > and sets up its object directory as an alternate, while the primary
> > object directory is simply an empty object directory. It then reads all
> > commits enumerated via `git rev-list HEAD` with git-cat-file(1):
> > 
> >   Benchmark 1: git cat-file --batch-check --unordered (rev = HEAD~)
> >     Time (mean ± σ):     179.4 ms ±   2.6 ms    [User: 114.6 ms, System: 61.4 ms]
> >     Range (min … max):   177.1 ms … 187.7 ms    16 runs
> > 
> >   Benchmark 2: git cat-file --batch-check --unordered (rev = HEAD)
> >     Time (mean ± σ):      95.0 ms ±   1.5 ms    [User: 79.8 ms, System: 15.0 ms]
> >     Range (min … max):    93.0 ms …  97.9 ms    30 runs
> > 
> >   Summary
> >     git cat-file --batch-check --unordered (rev = HEAD) ran
> >       1.89 ± 0.04 times faster than git cat-file --batch-check --unordered (rev = HEAD~)
> > 
> > [1]: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
> > 
> > Reported-by: Wolfgang Kritzinger <wkritzinger@atlassian.com>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> Thank you so much for this! This fixes the bug we had to patch
> independently in dc305fc33833 (odb: scan all sources’ packfiles before
> loose objects), via https://github.com/microsoft/git/pull/975, first
> contained in Microsoft Git v2.55.0.vfs.0.7. Would you kindly include (my
> colleague) Tyrie Vella's regression test in the next iteration of this
> patch series?

Yeah, makes sense. I'll fold the test into this patch with a Helped-by
trailer. Thanks!

Patrick
