Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420925CC66
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359785; cv=none; b=tpaokRCS9DB8P37/YZ1fBcYbGXW2fyD6FeMOjL0+RsE3YBkX66vWEGAZ6ZlYlVoDdoOZE2aEcpYvrldnVGYrfU9QiA6DJvrdyyliIpN8J2SJCx+jIz4ZADfRPgdyFNN/hbdQguT237yW8sUrVEpIemYbbX5dPU5AIs42BtGzHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359785; c=relaxed/simple;
	bh=QswOgweFTZp6zCGiMDKHYvFIeZ1tBy0y9j+fGTaLz2U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI9jj2cxjHFfe+g0ylF36OioXFN0ETRD/pqZQt4COnxQl5sJVMu716YrU9mL++XUvOjoXlC81u3IMb3w5jmLvlZFEjMtgoeeAMa1E0sOx9VmRrDZKA2wUVkrNXd2nHPAYZqbbBax164mtJpvCid13I7+6mwUkQeo8aA6LU0HRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g//ir8Ee; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hjPUj53h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g//ir8Ee; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hjPUj53h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g//ir8Ee";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hjPUj53h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g//ir8Ee";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hjPUj53h"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE60F21163;
	Tue,  1 Jul 2025 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751359780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVWpXpCbLJKzMgXww+XAFWt/XJCIImax9QeWnzZ+ryY=;
	b=g//ir8EeijYTyAPw/jzJahhe2yeNR4rxmpwWHu1TBE1zzgV6YvXhdhuKnUWl1UauINcpyN
	0oUlWDZbFe5DD33qbfqJxxHthKdIByKSaEswX+q6pIKOUG5O7XxnyC2EKubJXnkY7xHK9E
	0OrbOlVoNxBVPHwea36Vx+qfymYJX1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751359780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVWpXpCbLJKzMgXww+XAFWt/XJCIImax9QeWnzZ+ryY=;
	b=hjPUj53h214VPn3mue98lVdLNVR3Oydda+f9PtMRJNKEUB16w9GyfUDU8BxFQ2O02ZeAMT
	rAz26ES1JEX7gOCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751359780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVWpXpCbLJKzMgXww+XAFWt/XJCIImax9QeWnzZ+ryY=;
	b=g//ir8EeijYTyAPw/jzJahhe2yeNR4rxmpwWHu1TBE1zzgV6YvXhdhuKnUWl1UauINcpyN
	0oUlWDZbFe5DD33qbfqJxxHthKdIByKSaEswX+q6pIKOUG5O7XxnyC2EKubJXnkY7xHK9E
	0OrbOlVoNxBVPHwea36Vx+qfymYJX1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751359780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVWpXpCbLJKzMgXww+XAFWt/XJCIImax9QeWnzZ+ryY=;
	b=hjPUj53h214VPn3mue98lVdLNVR3Oydda+f9PtMRJNKEUB16w9GyfUDU8BxFQ2O02ZeAMT
	rAz26ES1JEX7gOCw==
Date: Tue, 1 Jul 2025 10:49:39 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Failing to push to a repository erases authentication helper
 credentials
Message-ID: <aGOhIxqloEdxUcn6@kitsune.suse.cz>
References: <aGKU-o9eXB1VHuN9@kitsune.suse.cz>
 <aGKfs5VRdmnw6Pqc@fruit.crustytoothpaste.net>
 <aGKokqPJPh5fQ3fc@kitsune.suse.cz>
 <aGLXmiYuM2C_xfWJ@fruit.crustytoothpaste.net>
 <aGOGMpibpUM2JJuV@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGOGMpibpUM2JJuV@kitsune.suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

On Tue, Jul 01, 2025 at 08:54:42AM +0200, Michal Suchánek wrote:
> On Mon, Jun 30, 2025 at 06:29:46PM +0000, brian m. carlson wrote:
> > On 2025-06-30 at 15:09:06, Michal Suchánek wrote:
> > > On Mon, Jun 30, 2025 at 02:31:15PM +0000, brian m. carlson wrote:
> > > > It is in fact desirable because otherwise the user continues to attempt
> > > > to use the bad credentials and then can never again authenticate
> > > > successfully, since they are never again prompted for credentials.
> > > 
> > > My proglem is that the credentials are actually valid, only the
> > > operation is not. The current behavior erases valid credentials.
> > 
> > Then the server needs to return a 403 or 404 and not a 401.  A 401
> > prompts Git to expire credentials and a 403 or 404 does not.  Only the
> > server knows whether the credentials are actually valid for some access
> > or not at all.
> > 
> > RFC 9110 § 15.5.2 says this:
> > 
> >     The 401 (Unauthorized) status code indicates that the request has
> >     not been applied because it lacks valid authentication credentials
> >     for the target resource.
> > 
> > and § 15.5.4 says this:
> > 
> >     The 403 (Forbidden) status code indicates that the server understood
> >     the request but refuses to fulfill it.
> >     […]
> >     If authentication credentials were provided in the request, the
> >     server considers them insufficient to grant access. The client
> >     SHOULD NOT automatically repeat the request with the same
> >     credentials. The client MAY repeat the request with new or different
> >     credentials.
> >     […]
> >     An origin server that wishes to "hide" the current existence of a
> >     forbidden target resource MAY instead respond with a status code of
> >     404 (Not Found).
> > 
> > So the server is incorrect in returning a 401 in this case if the
> > credentials are actually valid for a different operation on the same
> > resource.
> 
> Is there any way to see what the server is returning?
> 
> As the repository uses SSL capturing the communication with a proxy
> would be challenging.

mitmweb works for the purpose but it's hard to interprete the data.

401 is often returned even in the cases when everything works correctly,
probably because git first tries to access without authentication.

403 is not ever returned, the error only happens on the git protocol
level, apparently.

Thanks

Michal
