Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8785298
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947545; cv=none; b=Nh3UvR2HlXHHnBTJSZelALZBIu1AamWb+vENKyT6J38eo1BzIJbaJwydkhR0YwrgC6XVEOl+Nhsag6c0RDxov+G/LkKFWXJQ5V9QXzclv2NLgoXRSoQdHFIuXDY6vL2yAn9B4coGTwSELFbam8L+T91XRwSVfGyXUnar4pfMo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947545; c=relaxed/simple;
	bh=xiyhEGTN8XHR8ADE8OVqAorVkzFbAQJorGAlgrCn1cI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQXzMjAtGQKU4Uch/Kx1yg2/kMf7vmDbTYxmM2q0fejgfoA538H++s6YFAYEBdPn1AScpFO9c3MbfSH9LqV8L29sk5MqZMTv85me8AtprUc5SxuQFMjcUY0QXIX5lxVz8FffXpXZqgN7tKR9ohn7kAvABWnUzrOvQ4wgLCW0gIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 462JCI2C2052383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 19:12:19 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Bruce Perry via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
Cc: "'Stefan Beller'" <stefanbeller@gmail.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Bruce Perry'" <bruce.a.perry@gmail.com>
References: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com>
In-Reply-To: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com>
Subject: RE: [PATCH 0/2] clone: shallow-submodules should be single-branch by default
Date: Tue, 2 Jul 2024 15:12:12 -0400
Organization: Nexbridge Inc.
Message-ID: <07d801daccb3$c1de13e0$459a3ba0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGX+KKwWdOtKoOFI1UgP9Cu4TL/a7Jpddag
Content-Language: en-ca

On Tuesday, July 2, 2024 3:08 PM, Bruce Perry wrote:
>I noticed a couple places where the behavior of recursive clones for =
shallow
>submodules does not match what is implied by the documentation. Shallow
>submodules should be, but aren't, single branch by default. It would =
also be useful
>to allow users to override the shallow specification in gitmodules on =
the command
>line for clones as they can for submodule update. The modification here =
for the
>former is a bit ugly, but hopefully at least gets the point across to =
start a discussion.
>First time submitting a patch here, hopefully I'm getting the process =
right.
>
>Bruce Perry (2):
>  clone: shallow-submodules should be single-branch by default
>  clone: no-shallow-submodules clone overrides option in gitmodules
>
> Documentation/git-clone.txt         |  3 ++
> Documentation/gitmodules.txt        |  4 +--
> builtin/clone.c                     | 10 ++++--
> t/t5614-clone-submodules-shallow.sh | 52 +++++++++++++++++++++++------
> 4 files changed, 53 insertions(+), 16 deletions(-)
>
>
>base-commit: daed0c68e94967bfbb3f87e15f7c9090dc1aa1e1
>Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-
>1740%2Fbaperry2%2Fsubmods-clone-bug-v1
>Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-
>1740/baperry2/submods-clone-bug-v1
>Pull-Request: https://github.com/git/git/pull/1740

I am concerned about this one. Many CI systems (including Jenkins =
GitSCM) assume a detached head for submodule clone/checkout. Adding a =
branch to the mix will change the expected semantics. Am I missing =
something?
--Randall

