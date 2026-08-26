Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB38442B15
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764582; cv=none; b=Zb9Mna8hNK1hBssPMnrnpkktH2ZASgLz2b5fZgtUmC/+gtJffTILbGDNmNhlbFu0A5jPtdk/XD1dKyOuqXwRd0BIwnceZiu9T/XIaXHDUmAXnHvA5h13iu4WjIf/JIbMdiHf7frdb4M3JY8XagPQxIj7FJS9QD65O+/yGwQc5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764582; c=relaxed/simple;
	bh=a6Age0ZAUwf+zNlOinttJV0dHYPig1mE6dLoMqpt9E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZQLbgU4PFHs3g5lUhmEmg/rrowxSqMol6aqYmtwJxf3rQLKmh0fq2L6zXCp9MorIK/gACUozv4vWNdkoVKmgxawqh/c2tBozxGOzajagmXIf90a5ufPQbSE/MbNM8OvU8zXj8HZL1hLayvDMjZZg/VSTsrOVeKpzDyRJCRsyR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SpkB7NAJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9sRrd0s; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SpkB7NAJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9sRrd0s"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDB017A0111;
	Wed, 26 Aug 2026 13:16:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 26 Aug 2026 13:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787764564; x=1787850964; bh=gsjTfSdCnG
	Ea0qVQ60RsmbYQJfw7azyvrHDXFSWkG0E=; b=SpkB7NAJq8WEQXOhoSMyZaxwTF
	BVFvJb06IkNhplFKFZ6EV730zpAkEfY6gpkgmuaMCqdRMJChQ29wU6X6gOslnd2b
	i3R69XBo5SHFO1KcK2xAyITzTfsGuxVQ++wRYQE8YtTxQx4HO+pDnc852r0wgv+5
	iZ2Z5NgfEztJqsl2SdN0xvtlhT7yQMCK1759WBkxLOcJKno+3+1/eKCTK/SajQkQ
	G1cav25N0UpyghhF6SK3y1bJQLGq+a65wEGbML3vn4RDoIFksXU09w0pnx49J45U
	T2Fwr1N7nzkfsCL/TmVwdVhPAj5ZQpj3yu+3ZzyrMIlOnVQjdLTHnn/hJHcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787764564; x=1787850964; bh=gsjTfSdCnGEa0qVQ60RsmbYQJfw7azyvrHD
	XFSWkG0E=; b=J9sRrd0sCMYlQme8uG1tWMbJv8Zo1CiITh1ZqYaTZzBdobvngF5
	Pv18GD0cLz6A6LIuIWwYM1VyhJB48gDavvejUF7ZIBnwtZ5c7byv8Bm6fkGyj9so
	2vgQI8I+2avCMAC+VbUEjYVJI6KeIf4UnIrq9PA8ikeejDMKPXpe+T8pI2jVgzGY
	OZhdlcImGN3o0xplsFCSRxhsZln+IgyxoH6EE7FBWgnNyoKp1yDYxJCWt/1YXd6J
	D9EICjizddshrrDcT/QjewHorn6gohiJKkGILWCK2+eLx2Pe3MP51RCNuvDhTp0f
	HF/fpYZJQTgmiO0hCHATk+IZxQcs8OzDsdg==
X-ME-Sender: <xms:VB-Paodk6WhShUxqrZoryEwGxArrbikPRH6Vs3qWGGYu7xkVt_tBIA>
    <xme:VB-PahoP98uoDR1eMYW6CY5UsRCI_5WtgBHPtfq4Nv9BpkmfC4Eb5frzy8voNLiHX
    HbBKjZxg5caJBhDEfivvtYhL8eM2ge4QrrRShdwNiWfZJGpebnR>
X-ME-Received: <xmr:VB-Pam7SOHzisvDNMUokhWnV_ys2npVsQRWiUGpwaofOlO0E-oKR3kH2jMlNPiw47i4WVo3vOZX80u1NHVXthHwKH4cgPYBubA>
X-ME-Proxy-Cause: dmFkZTEQtFkf2zpagliWJ+znjAUk3S+P09frpa632DpA+UZ7kXeMdgA7R7aK/keZQzZdOi
    GB268wW8yLbYzrEvQz88olEtO2ebNXvyjMhN2l2SrjX4CqriPXjnVs7CuaIQkbrju+HoA9
    n/xfY2bmXevVdKjkLQWd8geS6wu1hDminaSkY/r91TLZmk9dxWZROh/FvkIS5bkJAM34Rq
    7XXFDsDpHX7Q3dPZNNFO3gSmL9tknZGcO8vLqgC8wKb6pJK1d1NMEoufQ7leGyp9iNctPO
    B7hzurvLMu9nqwNeCmPSXj6wvFz7Gr/aG21Ap+nj7Ig4T6qaF7yoidJNhsqXAWTzc+p5VL
    GSIjN2nZNuUJk7s0NYLux4ChHECWqH1y8uBejsg1LNymBQkDS7GoIqsynh+Y56F5x9sPL9
    L1lepz0YazMb1oY9CqOGoTSpiC4cnQLRgW/fwsYkzbu1Y0ZfSOEb2tsJAClI7dOa7WOv9y
    PxHEUdW7ZeTdg+PCRgBjc2z1+w6yqHnrPIKSug4rZdjwi4ZUMMSQ2/3owqGQdOAcrvlG9n
    Mwfyxh5NX5aQD9JNVAXitZAzzTGDjY3TSqG5Y487WqaEFuWqg1i/ZnSuMGlsMZ39dSkDrt
    Hh77H0Ae/CyZmGFwWofwKqwAo7TceJb4AAPtIEfloE9oHOPiL64wmWDSGNZg
X-ME-Proxy: <xmx:VB-Panrwcjt1t6TlEM0FuqRQjhcKjuuhOL_7W5xZZ7AGpubDt7ibfw>
    <xmx:VB-Paoh713qc3JVsQ5qDgu3GvNngm44Mc0yS_Bx4iCpEesatWhtgyA>
    <xmx:VB-PahJKrcK4VgIIcmsNr1hKWJIS3-s-NKNvWniBERkxNdkxzjD6UQ>
    <xmx:VB-PaoC_v-bWQ1PLs7NxTiiSiFWjKo0HK8DziCyu5IxDSGQGU54QVg>
    <xmx:VB-PatrdiiBCYGRCy11pye6IhGZtoSdJxAKfV5M6R0AZyzKPqb-g6Cbq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 13:16:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: Re: [PATCH v4] builtin/add.c: replace run_command() with direct
 apply_all_patches() call
In-Reply-To: <xmqq8q6to4em.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	29 Jul 2026 14:46:25 -0700")
References: <xmqqechab03t.fsf@gitster.g>
	<20260711061246.58079-1-gatlavishweshwarreddy26@gmail.com>
	<xmqq8q6to4em.fsf@gitster.g>
Date: Wed, 26 Aug 2026 10:16:02 -0700
Message-ID: <xmqqbjaoiyzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Now the way "apply" API is used in this new code path should be
> pretty much parallel to existing "git apply" and "git am" code
> paths, we should be fine.  I do not use "git add -e", but those who
> do who may care more more deeply about keeping this feature working
> than I do may want to lend an extra pair of eyes on this patch.

And nobody seems to be interested in seeing this topic move forward,
unfortunately.  After reading the patch again, I think this is safe
and correct, and if I merge the topic, one of three things can
happen.

 (1) the patch does not regress anything unexpectedly, or

 (2) the patch breaks "add -e" completely but the feature is not
     used by anybody and nobody will notice, or

 (3) the patch breaks "add -e" and the its users will start
     complaining too late.

Reverting a merge would not be too involved as the patch is
small-ish, so even in case (3) it won't be too much trouble to deal
with fallouts.  So let me mark the topic for 'next' for now.

It still is not too late for "add -e" users to interject, though.

Thanks.
