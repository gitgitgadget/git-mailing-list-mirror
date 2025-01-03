Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6C1917ED
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735943359; cv=none; b=Rvo+E8dVZ//E+rsYv2ICYfK/Ugx8rgCZrfgzLrUI84LxH8UTVD8cuVAP5UorIqCxKFbLrTs97MCcnqbDMqEYdRpu3aH4AMoaeKBvyaGRGIN3eLRAXtN3QDXkd7yyhtsYTOtQKVwlMuU4Nu8h9R9ySm7Eo1O/rygTXpZIO1fFjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735943359; c=relaxed/simple;
	bh=cf4MXjRebe5qBrSdlr9jqNU0XZyRqp5vDNnxDaWTghA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTTEpByTITNscl/AgijCyj72aMizmWRCl9cRv6g3bB3V1PMCVExb0s3JdvKWBqsHFVpkcZtnfRge+SbdUkAQWMY6H0/LdWBhTaaUMU07E6sEHqdVhlQd5zrBPf1guQLD3r7yczrXNg/QWYFIRKvJoRzK1/v+WcNLLhgYdccQC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bqDt9Z58; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8P97Zvs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bqDt9Z58";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8P97Zvs"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A1EE71380217;
	Fri,  3 Jan 2025 17:29:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 03 Jan 2025 17:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735943355; x=1736029755; bh=ulTL2iN3Fp
	EtiCAMwz++rlJzRar+11d7AU3hWxGZfI4=; b=bqDt9Z58NmC4LX0UmfQG/Z0LPB
	YG9O42eFaTq6z74QcHbkGq+4NAZ5oAZENuhrkPEwYHcpO0vm5Tg/DzDgRdsFa9Vy
	zLSIADx71nTYBt/1SzbC0usQ+dhKvKs4XvJL2SyxEuwuIjAxhv/Q710pjOSASw+x
	0Wq60pkLIuJ8iHcMn0KxO0yo0qyHvWl4y8EiqvDxpqpOQnTBl6ugHuHuOYYN8ItJ
	u55Q5KFSM0NOuupe1nLYb1oYQtWkrrjxp79tSdVl747X8ODi+OIJOK1Bhkuro9Kh
	pcgoSgWg2xe5U5kUdCIjAzdtgSu4IpyaYyUoHJ6RE0SkjsUIpm/Rqrwqy6qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735943355; x=1736029755; bh=ulTL2iN3FpEtiCAMwz++rlJzRar+11d7AU3
	hWxGZfI4=; b=A8P97ZvsNY5E9SznwqEkB4/EP07NLX+wVk5lKzrgJP29keZVf2u
	BUuUc/KOQpelDs1hVHBP8touxczwOWwK4dyhP2WcotA9XcIIiNAKUcfTgPMW7ust
	qfZgNsBSdtLR4gYA1NTvOiPaq1dMwOn9cyps6kVr568GAL/SZ1dhRLdd+U9bRWpk
	xpU9b8ZLN49Jzum1g+fTeQxt2SWOrYqk4EsZW6/pd+XGu1Wk8aQztfIMGsJWoTWn
	ovWLfYly+Ayh83ugKlqhR4N+smrNUaRcYn1xUVlPykIwE+4oZV9qlyxnNbqLdgF1
	N6mII5HmcPA+5YjxxXIxJeTm8EUWOmWSTMw==
X-ME-Sender: <xms:u2R4Zw-k_iyH1-cbPjs4hHE0ML_1cJDEvxWaNRJSsBnW2HPXA6ihgA>
    <xme:u2R4Z4twm3cUXvZrXWEngHavZaEnBKaPrlo8LcXrLd9Syw4nTNiPvBTUSNVMi9z20
    H3Y561JCRiEdwjcVA>
X-ME-Received: <xmr:u2R4Z2Al0NWlZHDQvtIu56tp0D6n4IJ_w4Faxu-Dbw-3cmsybMLN7lOzp5o1iyYMQkbR6jpTllNDomWFfD1GXCuPrae1I1o2XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:u2R4ZweWlwTZgqJWie3QZTG14kIOUmEB3uFaP5QUeq_1vZk2t4eENw>
    <xmx:u2R4Z1PvDMJV9CwfFBDt-UUfxeU-GrRbER-dEcA95-0a2f_JIaREZA>
    <xmx:u2R4Z6kU8VntY1AK2iVx9LLB5kpksAttltMuIZBrWQ-tfLxye5OFeQ>
    <xmx:u2R4Z3szn_DFmgRuqTfQVIhSfIwIM67gI7rlXvySxQX-tq2n2-eJyw>
    <xmx:u2R4Z6qWNxC5BNDJtKrxab7fs9fvLhvaAtSBjcARJKWzrAGrFxr2Pc3k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 17:29:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
In-Reply-To: <20250103195942.GA3212696@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 3 Jan 2025 14:59:42 -0500")
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
	<20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
	<20250103194058.GE3208749@coredump.intra.peff.net>
	<20250103195942.GA3212696@coredump.intra.peff.net>
Date: Fri, 03 Jan 2025 14:29:13 -0800
Message-ID: <xmqqed1jo7k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Diff is kind of hard to read, so you may want to apply (on top of your
> patches) and just look at the post-image.
>
> diff --git a/object-file.c b/object-file.c
> index 88432cc9c0..923d75a889 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2037,58 +2037,66 @@ int finalize_object_file(const char *tmpfile, const char *filename)
>  int finalize_object_file_flags(const char *tmpfile, const char *filename,
>  			       enum finalize_object_file_flags flags)
>  {
> +	int tries = 5;
>  
> +	while (tries-- > 0) {
> +		int ret = 0;
> +		if (object_creation_mode != OBJECT_CREATION_USES_RENAMES) {

Platforms that do not want hardlinks set CREATION_USES_RENAMES flag.
We skip this block on them.

> +			if (!link(tmpfile, filename)) {
> +				unlink_or_warn(tmpfile);
> +				break;

If we successfully hardlink, we remove the temporary and happily
leave the retry loop.

> +			}
> +			ret = errno;
> +		}
>  
> +		/*
> +		 * Coda hack - coda doesn't like cross-directory links,
> +		 * so we fall back to a rename, which will mean that it
> +		 * won't be able to check collisions, but that's not a
> +		 * big deal.
> +		 *
> +		 * The same holds for FAT formatted media.
> +		 *
> +		 * When this succeeds, we just return.  We have nothing
> +		 * left to unlink.
> +		 */
> +		if (!ret || ret == EEXIST) {
> +			struct stat st;

Either we skipped the hardlink step (then ret==0), or tried to
hardlink and saw EEXIST, we come here and try renaming.

> +			if (!stat(filename, &st))
> +				ret = EEXIST;

We check if the destination already exists, and do the same thing as
the case where hardlink failed due to EEXIST, if that is the case.

Otherwise, any failure of stat() we assume we are free to rename the
new thing there.  It is a bit strange that we do not check ENOENT
here.

The reason why this stat() fails is not all that interesting,
because it is subject to a TOCTOU race, and the case we are more
interested in is when this stat() succeeds, which positively tells
us that there is something at that path (hence we do not have to
trigger a failure from rename() to notice a potential collision).

Wait, what if stat() succeeds and !S_ISREG(st.st_mode)?  But that's
the original code for "Coda hack", and that is not something we are
trying to "fix" at this point (yet).

> +			else if (!rename(tmpfile, filename))
> +				break;

If we manage to rename(), we happily leave the retry loop.  Unlike
the hardlink case, there is no tmpfile to unlink.  Good.

> +			else
> +				ret = errno;

Here errno is guaranteed from the failure of rename().  If the
destination was created immediately after we got ENOENT from stat(),
it is likely rename() gave us EEXIST, which we would check for
collission and retry.

> +		}
>  
> +		/* Do not retry most filesystem errors */
>  		if (ret != EEXIST) {
>  			int saved_errno = errno;
>  			unlink_or_warn(tmpfile);
>  			errno = saved_errno;
>  			return error_errno(_("unable to write file %s"), filename);

Sensible.

>  		}
> +
> +		ret = (flags & FOF_SKIP_COLLISION_CHECK) ? 0 :
> +			check_collision(tmpfile, filename);
> +
> +		if (!ret) {
> +			/* Same contents (or we are allowed to assume such). */
> +			unlink_or_warn(tmpfile);
> +			break;
>  		}
> +
> +		if (ret != CHECK_COLLISION_DEST_VANISHED)
> +			return -1; /* check_collision() already complained */
> +
> +		/* loop again to retry vanished destination */

OK.

>  	}
>  
> +	if (tries < 0)
> +		return error(_("unable to write repeatedly vanishing file %s"), filename);
> +

OK.

>  	if (adjust_shared_perm(filename))
>  		return error(_("unable to set permission to '%s'"), filename);
>  	return 0;
