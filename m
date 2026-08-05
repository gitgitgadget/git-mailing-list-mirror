Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D383955DB
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941828; cv=none; b=oTyqax/K5J4m7j8xzu/+nKB8S6oppRjSqZ/5+V3l1mlupA2JLLj6A9HfsFmq4T3eFp0bKR38QaEL3jv8shPEB1oX33l+vWHx2Q7LuSpb3JrKqc9eqTp2nuVJUp/TUT6b5q79Xd2OEOpTP+fkhWZRwr6eORDdbGNrHdpNHY6IMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941828; c=relaxed/simple;
	bh=FfZ9v1qF0/tazl/7Hp+T2wU+MlPFapEdpIk06jjbhs0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cYhOHKFamLAKuv3NJ7BblaSq2ekFSj9QYhiFD9CcIcXaIk6Vq4oH5N6XWcu+fIa8PLBQtW+7WG4k9whs1Umf9CPwbk2HvTvOFtMyQ/4TFJowIfRg2PdrdnS+UHUipz0CPuARVGLCgC7o4lGzQ2HKlArQ3mWmuNgl0FcIeeapJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=BFeRuiK8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="BFeRuiK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785941823; x=1786546623;
	i=johannes.schindelin@gmx.de;
	bh=FfZ9v1qF0/tazl/7Hp+T2wU+MlPFapEdpIk06jjbhs0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BFeRuiK8AIzde8/ABrdX5ujh8U2fQBbJ6zZ3muM4cytZW02udci01+5Ku89u0IIP
	 7evlB0/F9uhf4AKkqs5oTQSfcO/3syY6IPr1C6LPVTm3YizmKJ3aARFoWMNzpq10y
	 sqWX3SNvbroM6yY4eN574d6SfxIGBZ7CWN8Z2YipbjDDZ6cCtlxRN+JZ4L9KDrXNG
	 qFrjGE3vNr2/Wm4LxVi+uIm7jQgiv5fcTRvRhXz6nFZ9PjWpfPHhqdXSM4e7e5Ibx
	 qkxJiF0kMj16sU/Rx8Fz4ZNc+TV8uMxMbBTRTZoqUifTyO+X0M8AvssfiVvH6S2Gr
	 579Ulcnh0vfBFCm4Ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1wqG033O3R-00AAWF; Wed, 05
 Aug 2026 16:57:02 +0200
Date: Wed, 5 Aug 2026 16:57:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 10/11] bisect: check get_terms return at all call sites
In-Reply-To: <alcvmX3b6y92KE4y@pks.im>
Message-ID: <fa29b166-39e0-ad33-50bf-2a1241fa6971@gmx.de>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com> <c0827a79476d02f2b09ded919b44860e3743fbe0.1784069325.git.gitgitgadget@gmail.com> <alcvmX3b6y92KE4y@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:f4meQdehZH6+Bph6uy8AQ8ZUEmj+crNga+qIQk68FwNg4693seo
 Gcl/LRjDH0oJk/ZZ4/qMd51b+2sWkyZckAEY7WZgCQWXc98NqD797GJpaVq2rSvLp9+BdZB
 dzxyCTE5rcXgGHYNRqNAy4JY82wUpXPd45isz+agmiYKOkUE0vv7fRtjX3tGP7Qbonv8dCK
 ghSGlpgERFJeOQPcvM5cA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qcyAxCdQliI=;cgqjK/s++dN+jU35FV3T/jCXM6r
 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
 rYTLSdDX2vKf80cTkmPmj7KuSI2A=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 15 Jul 2026, Patrick Steinhardt wrote:

> On Tue, Jul 14, 2026 at 10:48:43PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > Six callers of get_terms() silently discard its return value. When
> > get_terms fails (missing or truncated BISECT_TERMS file), the term
> > strings remain NULL or empty, causing confusing downstream
> > behavior: commands like "bisect next" or "bisect run" proceed with
> > empty term strings, producing nonsensical ref names (refs/bisect/
> > with no suffix) and misleading error messages.
> >=20
> > Add checks at each call site so that a failed get_terms produces a
> > clear "no terms defined" error, matching the pattern already used
> > in bisect_terms() at line 512. The check tests the term pointers
> > rather than the return value because some callers (bisect skip,
> > legacy bad/good) call set_terms before get_terms, and the
> > set_terms values should survive a get_terms failure.
>=20
> Hm. Are there any callers that accept the case where either `term->bad`
> or `term->good` are `NULL`?

As far as I can tell, no, the case where either `term->bad` or
`term->good` are `NULL` is not permissible.

> If not, should we maybe adapt the function itself to return an error if
> so and then have all callers only ever check for the return value of
> `get_term()` instead of also having to check the result? That might also
> allow us to deduplicate the error messages.

It's a good point that we should not look at `term->bad` and `term->good`,
but at the return value of `get_term()` instead. That's incidentally what
`bisect_terms()` does, and we should do the same here (including the same,
already-translated error message).

Thanks,
Johannes

