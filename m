Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F58EAC7
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766016007; cv=none; b=CeQCuugBzXhpbgVShQ3jeKU3q6dXfKA8UEYLyanXw7421fNCTRSiBY6tM3UxfFQe5gq2W0D/3FHjVNxUueHwWwkw1Kj/qiHCN8wQGEF1WSYpzUM9JJS0QnVQ00k/5kAJboe2XAVOItlIoBRVAQ9NQDXVIg4bSGiYv0qCnBbm3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766016007; c=relaxed/simple;
	bh=dtyvo9gd8K8670rAOIAuG5KxTvSBbX0cw+zQBwiWU04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aw8jT3+wkmOOEG40Fxhc2IjzY98aq28GDRVi0k4BZfRaIFww3lI5bkWcyPq44klnYzTpj1AD+gdg/adE+6Bu+HJAheEPlIVVnEGKP2pCWvYhbl9fDMUbO2Atp03OYhgoay80u5F5rDO9ZpNZf4M+l+bsudTtjxxvJrg0NGz2Tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R0lRMd5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPALtJi6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R0lRMd5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPALtJi6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B5A714001BB;
	Wed, 17 Dec 2025 19:00:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 17 Dec 2025 19:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766016004; x=1766102404; bh=F/QHOjX+3Y
	LegIXt8JOCZme5ioni2GrMxTilTjn9FsQ=; b=R0lRMd5CZ1tj00q8d70vvmrTPi
	+p0iVRqMn/wd29qOB2opRfou7AsiCcswXDT7A+aPHUwWR++Swi+EY/l/r80CJwkc
	dKwFiP4gEGUivarnTlmHMriBRrSDt5nPi9eHEymTm7v0VY2tafbI+3G0adgcAxri
	uYEkOlz/kATCTNEcc9IG4PK+x4fvj8hASrieI/vjy1aL9oDwbrZHJGXmuvETxEHI
	jqOzP7mHWHL+sg4mmjX300t666iwNGdvw51rzhlBYnUZplD7g/KDQvmd1V4zlG6i
	+3VLYlvEPljwWl4mRqAmNemljlEzIkXNeUnq/v0BLqb2A2e0zGKY6OZ0nQbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766016004; x=1766102404; bh=F/QHOjX+3YLegIXt8JOCZme5ioni2GrMxTi
	lTjn9FsQ=; b=LPALtJi6/pXBmLii8QMHivMOi/w6ZSrwEArrV+SvmTaZLNHPgSY
	1N4Ry2GhWEfK5GH1YCj5MF+aqHQr/Lj6xVsCDB5EvyDTnLeskvm5QyorBNV5jgjc
	94DSLPKQOJnfEqKo69JCFDpeCJE62rSmol+6onQNwOdlcyqCWBBrlNDfoauajNrh
	2KGdQvnBX+oAXejO4RLLTDqiDjztmF7mHCurUeDSahLOgzRMKhA5Y6+3ahOhfNl/
	dLS80P6PEgfQNkJf+U9Z0dLyPObb+kT2jr6Q2jhG2GP9u6B+uF70umy3R9DgNXuM
	SxlFIvqkw/53a+4FgR1xWIT7MBmYQb28XUQ==
X-ME-Sender: <xms:BERDadzGBPeC02hV9Tr3gT6MKAQI4oA_qtAU6aAuE2Vl1zoxw9B37w>
    <xme:BERDaUQUsfUgvx1eB6jAE1B2SokhYNG8S5TvqRrYuLi_mXGxqPCVJqn39ngD1HtGP
    9g5tl6A0xPcKgZMXc7etdTg4l-F98TcsvVW9Cwn_7ty02Ngnd8u1g>
X-ME-Received: <xmr:BERDacXGNMmhrbnx3GgkpVxhz4I_mJsjXYy7Z_qLUggsPSmHDbtCIYe558m-jG1DxkIybgT44D-Yj_NUeV4toQTwpW0xVYCiRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BERDaeatyQJtWNw8TEh-oFFbth9u78nZNhvWkPn8O_ymdJ41Fp2S2g>
    <xmx:BERDaa3kZNPN6zSaERzP3xdpubOl1QlPYIcxei3j939VYCY8T2b6lA>
    <xmx:BERDaYgZe8vx9w3LHj-O-4hkY7te3jWXvpva2zb53K50eK2i4zyJlg>
    <xmx:BERDaWYipT3ElK2eZl9FfKb9-BE-onTTXS387ZUOXbh136SZpzj8QA>
    <xmx:BERDaRuZSZ4adRzYP7mOIi3aP1vJti9Pt6TKjsvYibV4xhGL89QUpGBi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 19:00:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/18] Support symbolic links on Windows
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 17 Dec 2025 14:08:37
	+0000")
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 09:00:01 +0900
Message-ID: <xmqqpl8czmke.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This finally upstreams Git for Windows' support for Windows' branch of
> symbolic links, which has been maturing since 2015. It is based off of
> js/prep-symlink-windows.

The three topics taken together touch 19 paths in total, about a
half of which are t/ test files.

I've read the changes to generic parts (i.e., outside compat/) and
saw nothing questionable.  Very nicely done.

Thanks.

 apply.c                             |   2 +-
 compat/mingw-posix.h                |   6 +-
 compat/mingw.c                      | 667 +++++++++++++++++++++++++++---------
 compat/win32.h                      |   6 +-
 compat/win32/dirent.c               |   5 +-
 environment.c                       |   4 +-
 environment.h                       |   2 +
 lockfile.c                          |   4 +-
 read-cache.c                        |  11 +
 setup.c                             |   2 +-
 strbuf.c                            |  10 +-
 t/t0001-init.sh                     |   6 +-
 t/t0301-credential-cache.sh         |   3 +-
 t/t0600-reffiles-backend.sh         |   2 +-
 t/t1006-cat-file.sh                 |  24 +-
 t/t1305-config-include.sh           |   4 +-
 t/t6423-merge-rename-directories.sh |   9 +-
 t/t7800-difftool.sh                 |   8 +-
 t/t9700/test.pl                     |   9 +-
 19 files changed, 585 insertions(+), 199 deletions(-)
