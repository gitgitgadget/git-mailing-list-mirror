Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5D3191BD
	for <git@vger.kernel.org>; Thu, 28 May 2026 05:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945853; cv=none; b=sB54k1M+Z4FHyfHN3Xc8o4uoqOxfoINTty+EuG+TEww7I/cuuklkHgAM/KVG3G2/oyNBCBgaWIGoX/RcUV9CsHAES8D8JGz5rlE0bp5dXNFwzfXLsjyTZVs4ptKBmObKsF9Abjy0E+t4rpN4i691PtMV8ipZ9ROtaxH7749vbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945853; c=relaxed/simple;
	bh=YxoDF5gSO+3X3jMSPCVfXoC6G7UwcHQf+zygiLBCK/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btdLJPAF1bcfpqcVXzCoctb/EK+tjYLCGh0oC6KjZj9WSvK6ppfIvtoZ5Ro4jwt9qDOFUULmpEVTTPvEKwnTpLlC8LDI3wQGQTLgeS35J/nJsHr2l2/GsakoUTpOnIK9Z3z/qK6pjuTtZBzDlnrpDDEWePow6kAYZeATiOe4/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p0Zyji0Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQ74JXtZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p0Zyji0Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQ74JXtZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3AF01400112;
	Thu, 28 May 2026 01:24:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 28 May 2026 01:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779945850;
	 x=1780032250; bh=UTdbv51M7U4AwD8MHypkGEW/fViNgbpy550lmWNCwyw=; b=
	p0Zyji0YsoUyLIn+r/HXBzpHr8vSXNUW3X37K0q+J2v6MVzU5vZoGzshPI+nw84/
	/HMsxKiNB7o2Xc3BqbM/X9MOsR4Y2hBTLwDVym+Zfoa101/Yy0ZELDGrN76363DR
	S99kjtBlWd235W4Oc8ZNmpjCUxnof+OBeydN3XlGrDwQNJT0cTnlqyyyOMIGHCo5
	YvjlU2tS9PglpxRgPIfGHllAxOcXmG8KUULEINLJjdZeepuxczSgpGiXIrO80HKd
	8KUMWtoSxlYBDmZ3/70Ab62OcGz+q2ablBsEgNHxbrxaXwey6qnfI+UiwcIJUd3H
	bcbKQfn45F8bFGLF1N29Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779945850; x=
	1780032250; bh=UTdbv51M7U4AwD8MHypkGEW/fViNgbpy550lmWNCwyw=; b=a
	Q74JXtZD5lA6z6vG4XAZn+809ShbZohTPa3iePQdHxN7/kawdRBG9nYMxuPbvjDY
	S/1Qzstw8p3xeSt6Z7DM38XxPLT1KonB9FScmkO0ZzNl+yFR2JpRir7TMennqk20
	ujUYIFOKTM90f1Q66MtSz3mfQep6g066tyKov+Yrue0A16jXHyQU702iPrlzDuAc
	laGPs5XErEeE1yVD+pAUWruAAKCcVOe/dZ1z5UNiaE5lwlRrHmaXFS+wxKhkCSlJ
	n18LWDQ3KXTjATrdswbAUWLQUJM9RZ2J8ApreoovY5VR90siagcZpf+cLLC3nWjJ
	4ZurKktm2fv65EJdbT9SQ==
X-ME-Sender: <xms:etEXauoMe3t2GkdUugLqdK-PiMaYs9JY6mhW7PDQ6cFhUMCZ6rOfwg>
    <xme:etEXakGziKbJvjbSbxx9hgVg2lp1wDE6fq8GHJAZxzbLmf0gJhCK2bbgrkI_9FWOh
    drOaCUZ1htvHjv-gpiFIRzLVlYrCXtx4g5dlXxozbpt8xei2DCIzg>
X-ME-Received: <xmr:etEXagnBqovsq_HNtKloHMdSz9Met82BgN8YQJi2EKLk3BKeelZxnMRKl45xU7_yizvR3ZiuTp4_qNOxwsjME1GVPQu5z3levKdI_nGn9A>
X-ME-Proxy-Cause: dmFkZTFl5qZnB8j8cGxODzxmBI1jaoa3VeYr+z3jXNND/R/XwPp0OK4EsNgTHn1a8aYqGC
    aLmF8KdkRUM3z9Q9Op36n5hHmb//7n7Y/3q2oRGlD/m1Mwb8EKrDPa+IAPLz8ksWxeHKqa
    dObDUiAlUPVsrKAiuoYIOXzMJBkW0J2nKgeUpoBmiXT8v725MsiMkckRuzf5Fim/vneDY4
    VZf0C/C9YxjvTFqaJUoQzagDnqAorIO6JVmxH+Nk9qIkMNIQWwEH4nSYBWFqQThMOE2vDf
    FjO7maFJxiYCGiq4S4qSDx8GQwHNHpRDAQnwJnN/Utj7T/SZAipKNGNYQF6cyDupKyu+dr
    nAoqIttAMyVg1BCl5EmQxVMBLTNQ8S+lKeMYOPqIbeMyiAxBKwA0QPa3IoNNqkekIJ4Qbn
    gbMCmppF+d7vGuiOB5stdlFZKBiBhz1OVg2ILK1NjWI2DVKmRoUbpZUreu5dk26zTPAHxf
    K/Qpe04UGTuC/FX5EEeDV7is1ViI2C6sKhKvLDAeIySAGMp7bOm3K0naTEs8CWMCTZY+Og
    swcGw9KPLv3gbVvsBF8qeHtWRvmNni0rXTgU/9fmCKof/OZc0Pyp7ZQse7koT06UNHQdDZ
    RFPiUdjCGiUxr0DW+tN2PYyab6/kevsNR1TULvQdG3bsQo00sA+HAqmyuMEQ
X-ME-Proxy: <xmx:etEXannKOIwMVs3DwvHueFS109c2o8KVQI1dvF4aUR50Jt_XH8Rk-w>
    <xmx:etEXahtnBLqYJs8taGyvDkvURplhuXeW4bJveDptb7c68-k5jGxFVA>
    <xmx:etEXaqmp96kfP-GoWV1tUwPmvpQ6XxxbwphBIui_224FQVu9XSCCXw>
    <xmx:etEXasscgERJcWctWCSkrNVJXRID6uBFBXa17eeldyViMH0TGZUWoQ>
    <xmx:etEXasPVS3qMKcq1rzKKTo315Ddd22LMGiO1rac3PS3jvL9wegMPmmPb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 01:24:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fccab63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 May 2026 05:24:06 +0000 (UTC)
Date: Thu, 28 May 2026 07:24:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 1/2] *: replace deprecated free_commit_list
Message-ID: <ahfRdFXJf9SRaz5q@pks.im>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
 <commit.h_replace_deprecated.715@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <commit.h_replace_deprecated.715@msgid.xyz>

On Wed, May 27, 2026 at 03:59:25PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Replace `free_commit_list` with `commit_list_free`. The former was
> deprecated in 9f18d089 (commit: rename `free_commit_list()` to conform
> to coding guidelines, 2026-01-15).
> 
> This allows us to remove all the deprecated functions in the
> next commit:
> 
> • `copy_commit_list`
> • `reverse_commit_list`
> • `free_commit_list`
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  builtin/history.c | 4 ++--
>  replay.c          | 2 +-
>  upload-pack.c     | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Heh. Funny to see that I introduced the new functions, and that I was
also the one that continued using the old ones most :)

Patrick
