Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45B29ACC5
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410597; cv=none; b=gXjB1iMsf/85KnssbCTWWCtWpB8NsHyZ3xq6cD2BUAc7FDRttzgO2Lful1UKb9G0x+b8oUnyMnoEoMRfExx93eq/UrScok+fOkl/aArCjHuaXAq+u/lAERGoZhM0cYYjw5Ls6iosEuH2UPqDEhM0wXMaR4Bx7fWgZgK/DXHYZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410597; c=relaxed/simple;
	bh=Pi3dPuKISw1/8JRtFNH0mDnkb1A9C+klPHuJDCPfwGk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jom/d60LUkNUZXn5KmHGaSi62GD9c+U887MKSDtzRKWODszTYu/0DW2T4br+M97ehHKXl7c68PDMQ/dzWlhcw5/2CFfbc8h2r7b4K5Nf5Z6yALvFE1C4+frWTgjtekMQrsFw4hGbzVM0+onPDN8jD/JBvyP1LslaeYVfAYIBoM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PDnSa7Jq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T5Ifyk7X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PDnSa7Jq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T5Ifyk7X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PDnSa7Jq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T5Ifyk7X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PDnSa7Jq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T5Ifyk7X"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7535C222B5;
	Thu,  2 Oct 2025 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759410593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HrJrdSiRZowVbo1+VjujDemz3WYlGJmfsQ4/P27/eI=;
	b=PDnSa7Jq4UoahBpIvofegAZijjtwT3774j6RsK1q/ZrF6B8OBfxEMl/lXN950nwYeDCFgC
	ML/hQyJ/g6mibrwNILMNd+QEc9tPCBFu6emlU+Rb3fMMjKg0bb6el9heRf1TiMP6gAMpFc
	J+4Y+BmMOpIToDsINlhhJ4zi9gYpa1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759410593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HrJrdSiRZowVbo1+VjujDemz3WYlGJmfsQ4/P27/eI=;
	b=T5Ifyk7X6ZsnpS8BFylFJedXWb4ubYU8fHHZBgmUvB3EfjshWq0hoBGyy4okN1OiLV2xTn
	eG1ucSBHKbJY5QBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759410593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HrJrdSiRZowVbo1+VjujDemz3WYlGJmfsQ4/P27/eI=;
	b=PDnSa7Jq4UoahBpIvofegAZijjtwT3774j6RsK1q/ZrF6B8OBfxEMl/lXN950nwYeDCFgC
	ML/hQyJ/g6mibrwNILMNd+QEc9tPCBFu6emlU+Rb3fMMjKg0bb6el9heRf1TiMP6gAMpFc
	J+4Y+BmMOpIToDsINlhhJ4zi9gYpa1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759410593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HrJrdSiRZowVbo1+VjujDemz3WYlGJmfsQ4/P27/eI=;
	b=T5Ifyk7X6ZsnpS8BFylFJedXWb4ubYU8fHHZBgmUvB3EfjshWq0hoBGyy4okN1OiLV2xTn
	eG1ucSBHKbJY5QBw==
Date: Thu, 2 Oct 2025 15:09:52 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN55oCWX1l_VUuNh@kitsune.suse.cz>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <aN1QUDzYli0GsGy9@nand.local>
 <aN1UtbJRIhgvMmaF@kitsune.suse.cz>
 <aN2oSBz8s_hSBMPq@fruit.crustytoothpaste.net>
 <aN5sVXNdW8-GSMAE@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN5sVXNdW8-GSMAE@kitsune.suse.cz>
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:helo,kitsune.suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, Oct 02, 2025 at 02:13:09PM +0200, Michal Suchánek wrote:
> On Wed, Oct 01, 2025 at 10:16:40PM +0000, brian m. carlson wrote:
> > On 2025-10-01 at 16:20:05, Michal Suchánek wrote:
> > > From my very limited point of view as a user the interop is the major
> > > planned feature currently missing in git, and I do not see much point
> > > without it. Then again I do not know how useful it will be in practice.
> > 
> > It is the major planned feature which was missing.
> > 
> > The primary use cases are converting repositories and working with
> > repositories using a different algorithm.  The latter might be useful if
> > you're using a SHA-256 repository that someone else has created but your
> > tooling cannot handle longer object IDs or otherwise has some limitation
> > of that sort.
> 
> It cannot, and the compat will not help with that because it's using
> pygit which will not get that compat code. Presumably some baroque
> scheme that re-exports the repository as sha1 might be possible but it's
> not clear if that would be practical.
> 
> Another problem people are comlaining about is that with a mix of sha1
> and sha256 repositories submodules and subtrees don't work. For that the
> compat might actually help but the repository will then be
> unintelligible to tooling that does not have compat code, which probably
> includes all forges at this point.  Again, some baroque scheme that
> re-exports the repository in the other hash using the compat code might
> help but it's not clear if that would be practical.

I would assume the compat client could upload the same repository to
both sha256 forge repository and sha1 forge repository. With some
scripting it's possible to publish twice making both hashes available.
People that have a compat-capable client then would see the repositories
as identical again on their end.

Not usable in every situation but for cases when mirroring is already
done anyway plugging this in sounds fairly straightforward.

Thanks

Michal
