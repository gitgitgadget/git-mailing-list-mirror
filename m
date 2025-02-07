Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F118DF86
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908986; cv=none; b=HZKjgyiyKtbf1nK0vRxHWGALDAl3xK3F2ZXS46gaflj8/1Tr/W4o+qY7R0Oet7ZUiDR9aL0AiOArwvttU/TgZy+l7eG7hTaDIsdy286DS6WgFkY52TTCBy72Ob2lbit6UAOD48WsFZ3EHrczzzeG92ExaI3Ed6OFJqhqVz+vS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908986; c=relaxed/simple;
	bh=Le+exsi8gje3sZXZR6p0OQ0rFw09ts8kt1PaZEPLA6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb9OuWkQ6ssGFOQZtbFNwstWJaC03tPstDaQ/A/ZFZ3eimow6jO85ANFzCw7xJsg1rfg9UWWPOvWOobC5bZ8UJPLm6WMzvHZQv7yzLoTOKsuiCEnXLGQ8t4Y+uiGT9NWbmb3iOHyP2rQSfcQFgMT8AxksSK7Is5j9PxdSmeyc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yt0TYFsF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XE8DOm+4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yt0TYFsF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XE8DOm+4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C3F8C138021C;
	Fri,  7 Feb 2025 01:16:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 01:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738908983; x=1738995383; bh=AB1H7pSm5Z
	FMe6I9riuEyMy3FZF007kxaGKsIxqCCOA=; b=Yt0TYFsFCbuFxGI+r2meO47qhS
	6FUMBINwlzDrLjQqIZYyfT6S3NVT0zPOc3wZsr5wxm8xz6tETDPglLcfPylMVmEj
	NjpfnCny1i1qKIlOMK/zt9qHRdTv9zDJChuKcjWmpXOo0rLYwxegiuZvCvdzL5ll
	3l9aBNRvp+aSvFPJs/7ghojdqoNs+bjUveXYq2PutdDgA/AAOpwwxyHS+A1ezR8S
	/YlWLqZjymZVyhACEIs2JdXntlrQMLFe8QxWiJhEYi3Ug/WgjTXQH2RcOXztXj1N
	d7M1wmRKI1IceRwMOQQz+yMKDTTa4tmrz0xxEw7zn63G+AyEfLGQHfgVJi5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738908983; x=1738995383; bh=AB1H7pSm5ZFMe6I9riuEyMy3FZF007kxaGK
	sIxqCCOA=; b=XE8DOm+4GqSphKOHtj+PBA2MVyaNhKONxbuBMAO2/brBOFnAkP2
	282yNrysWi+GBtrAfLCkmBXCQatTfAf3IFcN+95ujg0Lu6WITYAFqmbuY1HEkgrt
	1Y0aJjCkgi7HSqaYsTIUHq0koXfEh12wNRT7tHHDDNul0LMsMs6kUGu5Ofa5UAfa
	NADuiih0FxPAEA4StVwiWscm0MaHnThsMg8AExpEx+0EqgnPGmrMRL3ioU0WrgCv
	t790+el9TGzpco0F6XCRKPz3k1YZ5U170bn1I5Q3Yrem7jm/ZFTHPohlSe230l8b
	Nfplme6jAunnZMLvvDaxNzZIAaQDbLsvLSQ==
X-ME-Sender: <xms:N6WlZ8MgEzrNwotnvpBNqTOWDq7XbBE5zblRIjSYOY-2W-OQmXh0kw>
    <xme:N6WlZy9BTn9seuQwq9Q8JD4hoUVo0JZyZOqM_lceniqsN9dHf-jsQz0GBOsd1mEWG
    p63Uk7mn4B8ezM39w>
X-ME-Received: <xmr:N6WlZzRTllOkUyclrGvSUvz8E4O2vfDN99ghZXYmjX46HWKLCgNfaRwI9zJWXqikolcB0c6SKohMcCV4ji_eHL6SQ43tn5JWfaedmJfG92BlkkB5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:N6WlZ0uRlbYkP7Qq8n0HicZlPfpVPeQ5Ar4hABBb2Ef4MGGoUfEE9w>
    <xmx:N6WlZ0cDoFVc1IEWb20MHSqs1nY3QP_FJh8rZln4xmUF6xnjDk02Cw>
    <xmx:N6WlZ43LbVD7gClX66PWa99ZRZsQ4pK7x1Y0fzvhUYTfATJsRNxlIQ>
    <xmx:N6WlZ4_qOULINN1VJvPTvKsOGZM0pKD-SMbNgkSC_U5zwhIfz046Sw>
    <xmx:N6WlZ1qSt7qW_jRafTN8vnfznR6Vr76xWDH-CLDBzsqHWaS1rv3VOMh->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:16:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be62d3ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:16:22 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:16:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] path: refactor `repo_common_path()` family of
 functions
Message-ID: <Z6WlNXbw6s4ojsiP@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-1-4e77f0313206@pks.im>
 <CAOLa=ZRSSnqRO_=N-sVrYSRpCZkyW0KFh5=rwX0NY_VqyzKz3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRSSnqRO_=N-sVrYSRpCZkyW0KFh5=rwX0NY_VqyzKz3A@mail.gmail.com>

On Thu, Feb 06, 2025 at 03:17:12AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > diff --git a/path.c b/path.c
> > index 07964f5d32..273b649e00 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -414,7 +414,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
> >  	else if (!wt->id)
> >  		strbuf_addstr(buf, repo->commondir);
> >  	else
> > -		strbuf_git_common_path(buf, repo, "worktrees/%s", wt->id);
> > +		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
> 
> This is the only place we replace `strbuf_git_common_path` with
> `repo_common_path_append`, whereas other places it is
> `repo_common_path_replace`. I assume that is because in those places the
> buf is newly initialized.

Yes, exactly. I think that it's easier to reason about to replace
callsites with `_replace()` where we can. But I'm happy to adjust the
approach when it's putting too much of a burden on the reviewer.

Patrick
