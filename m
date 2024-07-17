Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70824205
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249132; cv=none; b=hoKlmdnMr1+5L288ugLA0vK25y9ArUhVejBS1W72WtvWSpTMDz+HA/zjZXqQM4EJ/jg25/YCWS/gyS6LVZtQ+ZkXmGnIzV6j6kbidg3eBY3dSSD8LlKiKBM6G+1jzsbtd1smM9V0kmNgTTA82hwz6V4DxneiK9ZiKAaDA9rCEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249132; c=relaxed/simple;
	bh=L3/9auhaKtHwNf5dtwf8CayoGRYFEK4xIMxvQ9n14FU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9Rvy6v5dGwJViLb5ldGAr6mUIV9XCQYK+eD3GA2xaOBXDvyzDdRGExgK9lIVtiUdsswMMwXrn6HULVzuiUxtCVU6A4h0UP2O7AOj9AfXfDhNNb9RxJCXHPx9EjMHDtyaEizbv0z+CQFQEiE+CIWYpr3d5umgYBBkyxJJsUkpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ceONPGIE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ceONPGIE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1958B197BC;
	Wed, 17 Jul 2024 16:45:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L3/9auhaKtHw
	Nf5dtwf8CayoGRYFEK4xIMxvQ9n14FU=; b=ceONPGIEFh22hwEXqDtNwGc2pDyY
	2ODJB8RkriMDgM9V0aXoAz/bo895zg+AxMZkrH77O0jt8anfVQ8osiqlFXBcaoP/
	EZjeBLxN3U8NyLAETJ9CpuM2xLrs+yRV0B0XDqdPbtV297D0ZrdPj68ij41faQuk
	c3hkmAuK9voJLvY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 11567197B8;
	Wed, 17 Jul 2024 16:45:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73E32197B7;
	Wed, 17 Jul 2024 16:45:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alex Galvin <agalvin@comqi.com>
Subject: Re: [PATCH 0/2] git-svn: use svn:global-ignores when creating
 .gitignores
In-Reply-To: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com> (Alex
	Galvin via GitGitGadget's message of "Wed, 17 Jul 2024 19:57:43
	+0000")
References: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
Date: Wed, 17 Jul 2024 13:45:28 -0700
Message-ID: <xmqqed7r3fyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 80D6A08C-447D-11EF-9E80-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Git-SVN does not currently use the svn:global-ignores property added in
> Subversion 1.8 when showing or creating .gitignore files. This causes
> Git-SVN to track files that are ignored by this directive in Subversion=
.

That is a well written explanation of what issue the patches want to
address.

> The following patches add svn:global-ignores to the list of public svn
> properties, and update git svn show-ignore and git svn create-ignore to=
 use
> this attribute (as well as svn:ignore).

Paying attention to the new property and get it reflected to
.gitignore on Git side may be a reasonable solution, especially if
we ignore older version of Subversion.  But I have a na=C3=AFve question.
If a new version of git-svn starts to rely on the new property that
is only available in SVN 1.8, would it create problems with folks
whose SVN installation does not understand it?  Would it cause
problems to them?

Anyway, in this project, explanation of the problem the patches
address, with the outline of the solution, should be in the proposed
commit log message of the patches themselves, not just written in
the cover letter.  Can you redo the proposed log messages of these
two patches, where you have none in this iteration?

Thanks.

> Alex Galvin (2):
>   git-svn: add public property `svn:global-ignores`
>   git-svn: use `svn:global-ignores` to create .gitignore
>
>  git-svn.perl    | 45 +++++++++++++++++++++++++++++++--------------
>  perl/Git/SVN.pm |  2 +-
>  2 files changed, 32 insertions(+), 15 deletions(-)
>
>
> base-commit: c2b3f2b3cdbf5ad9feb978dd367d77561a1271f7
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
747%2Fav-gal%2Fgit-svn-global-ignores-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1747=
/av-gal/git-svn-global-ignores-v1
> Pull-Request: https://github.com/git/git/pull/1747
