Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88473264A97
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777377099; cv=none; b=L14cFSSMhOTjTttlgzz76coDMJf/Wby8/lNfJ6ldjj8nn3DUeAujFykSz2G8cv/cRw43gZ1aTiRrhLlNmOgBh0c8X3kQpfdSPu8NPOqdFScthdF8L2tfYlOqMz0xN3qU5miGusYgKBsgExJHEKoT8amFssEs1PxlbeIoO1MG2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777377099; c=relaxed/simple;
	bh=d50eU9r1fyJvxqXZJQxpVC0bHRwkHAsitXReM1rP7ik=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN57jO45P3+ssMZpssLdX8F+BphL4i2s0RYwE/U/NM0Oqd6cG6jHSi5bCd0+694p05mz1dTTbHVdc0z7OjmNSVqc+dQrMYFDXWJ+TkCFBC16MByNmzEbyV13g4U/j0NyagvjLNVTZUB5HwGvJu7yioFGKRWjeHYnVx105OWQO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lsStx3Un; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lsStx3Un"
Received: from macsyma.thunk.org (pool-173-48-114-3.bstnma.fios.verizon.net [173.48.114.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63SBpIxP009908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 07:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1777377080; bh=dhAH5Gz8B46z0E7suRIqKlHXVTYKBrZmXLINHuoZ7+w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lsStx3UnKWuM7v9r8fjmOTyuS8rqioxRRm0MU0QCRMj3AZm1UiFQy2+L6WZAL3qnK
	 pbB7DSoRbM+bVJkiKurDSvauEukVQHpb0/UOfXBPkxqCwqrHp8UpadwlZcrqMQ7Orv
	 PSE0hyOBoWvEKRqFeyqUSMQy4QgHhSenaQn+uzNZyhrJwCjALkqWMyMvPULyySsOJT
	 Q2VBPcQgIOYMDOFp/kijpeHOl2XJd1hnNuMto0y521i/nSMw2LHFBZC4N1m22WJ5UY
	 kp/NROJo2MHf5hgg94kZnD5++Y0Nf6n2NtBQb0eOMfjDeRAdBDW5Crkppzd4jjd7zH
	 imrBWpjeTZ9Vw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 955336555522; Tue, 28 Apr 2026 07:50:17 -0400 (EDT)
Date: Tue, 28 Apr 2026 07:50:17 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Richter <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: Git generated tarballs and Debian
Message-ID: <20260428115017.GA71700@macsyma-wired.lan>
References: <9030b26d-02ed-4452-b212-a69a4ff21e2d@hogyros.de>
 <afCLFJX86yEPKKfk@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afCLFJX86yEPKKfk@fruit.crustytoothpaste.net>

On Tue, Apr 28, 2026 at 10:25:24AM +0000, brian m. carlson wrote:
> 
> I'll just note that we don't make any guarantees that `git archive`
> produces identical output across versions.  Incorrectly making that
> assumption broke kernel.org when we changed the format in the past.
> 
> Also, if you use `export-subst`, then it's possible to emit short object
> IDs, which can differ in length depending on how many objects are in the
> repository.  It's also possible to use zlib or pigz instead of gzip to
> produce tarballs, in which case the compressed data will also differ.

This is what I've been using to try get reproducible tarballs for
e2fprogs:

git archive --prefix=e2fsprogs-${ver}/ ${commit} | gzip -9n > $fn

,,, where $commit is a signed git tag.

I know that in the past, using --format=tgz has broken based on
different compression parameters used by git (and whether it used an
external or internal compressor).  I also know that if $commit is a
tree-id, this can result in the timestamps being not reproduible.  I
also don't use export-subst.

There is also the difference in the prefix used by github and gitlab,
but that's arguably not git's fault.

What other gotchas are there?  How is this likely to be inconsistent
in the future?  How much work is there to provide that guarantee in
the future?

   	    	    	 	      	  - Ted

P.S.  Although I use pristine-tar in Debian because I didn't want to
count on git-archive being reproducible.  But it would be lovely if I
could make that guarantee starting on a particular git version.
