Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AA36AF5
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661682; cv=none; b=NqtFlqULB5SPsC6HJLdWgKxUp7IpKAO/VmDfioE6CCZ45c1oFE9LHDJZKGzW5iVtu/SwtSeEbFqqJ1nJlVrgLBS7tHDgeVZTgz27tA4RFC5+PheOhNmB9XjjqcnkACraIn6ygEHWo/ZEKbzhjAsSQjpPx/EScKWCEiFAA74Iae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661682; c=relaxed/simple;
	bh=BusWi9H5RvzuoMYpzUpcfW937NPb+tE4tMjxU1TtGqo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nGv2hO4Slm3fCa3FUrnY0W9/lEDvYi4ayNdNidWDlYoja1wj4on1kbvlsPaYM+GF6mCny+075kwZ3FDwHFJrozM6NS57Fl+R3DParSxjK004+jo/5Q+vKsuRvJkCSvGaKRiuJSPZtIYALVKqJ5s9MCFYMVdmKbAgKblgbNiDKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c2fZg5Jq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c2fZg5Jq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A415C433C7;
	Thu, 28 Mar 2024 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711661682;
	bh=BusWi9H5RvzuoMYpzUpcfW937NPb+tE4tMjxU1TtGqo=;
	h=Date:From:To:Subject:From;
	b=c2fZg5JqV7VC3ZtxZmGH9pwAtQ8nqSHBWstDOBsddSytqra+Y+tUMwsIRnmhoVv3p
	 Vi6A9BsNZ7/+HvpSdsvWDL0Puwennw9jcg9jNr++TCuFfGWkBo0yJ178Zk3hYmvsFu
	 QrhngIP+h6yx89To2qr4Up8Y1eI4BPEem9hTpXwU=
Date: Thu, 28 Mar 2024 17:34:41 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: git@vger.kernel.org
Subject: base-commit when prerequisite-patch-id is specified
Message-ID: <20240328-vehement-fine-tarantula-2b864a@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello:

I'm working on automatically supporting dependencies with b4, and I'm curious
if "base-commit" should be used to indicate where to start applying
dependencies, or if that's purely for the patch series itself.

E.g.:

    base-commit: [commit-ish]
    prerequisite-patch-id: abcd...1234
    prerequisite-patch-id: cdef...3456

In this situation, does base-commit mean:
1. where to apply abcd...1234
2. the sha we should find when we apply both prerequisite patches

In theory, #2 makes no sense, because we don't know where to apply
prerequisite-patch-id's and therefore can't reasonably arrive at whatever is
specified as "base-commit".

I expect the answer is "it's whatever you think it should be," because
prerequisite-patch-id's aren't really widely used, but I'll be happy to learn
that there's an established practice.

-K
