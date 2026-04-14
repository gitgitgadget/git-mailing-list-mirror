Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE625B2F4
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128953; cv=none; b=rKU0s6RKwukwQeaz868woKKzuR01ScGIfcsF+dkvivBzMks0sZyMhXIGqiDM3FnqD1mupu4D0FgTsPdiYwLQM+Hga35GgkRe7dPMKir/v+RUR7JfeZdS/K0jMK9ol5eJiyt1O0e/kdPy4DgN2zvWzfqRxVu2hbx92oU0Yu4e0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128953; c=relaxed/simple;
	bh=11RS6as/7Mfp4SVMhvYnqB5WVmzLKrO6XtsfRDjTBWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HfzXKe7w5uKFrJKtn7Svyzg+L0m+pe9Gi8bWnnSiPbARvbq2nFUhCS7O+jnTDJGviMocAwMjSrvhY2+M0bXstjLoqTV0w+xPvzgrAKGvj7LXrOE7QxSKysxnxRybcN/p00hnd/GeODwC1Ix40eQzL2J2NWgdYXltvPbPEJ6uX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uxbp3l70; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYhRjruy; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uxbp3l70";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYhRjruy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 303F71D0006C;
	Mon, 13 Apr 2026 21:09:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 13 Apr 2026 21:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776128950; x=1776215350; bh=3TxOOyU9BB
	G+KZA0BVFGW6BQKMkHgaX5lrFUz+6/QVU=; b=Uxbp3l7087V2jOCn33zvw4veqZ
	wEGoD+KopYKAI5F5unF5FsFulcVSuL69VcW/q0KksmE42EOh7Auz9ebLwA7p5pIn
	79e+NVX9f024BJyC0KudwIoHXwskqTbgtfFzxGRwJQdqOYGs14zbDHPbgdjsP715
	r5bWlSF1sYjJsndlfJDaIEWw+k5ErqORGosqYigHpSqMDBOf/88PANMMeyfYKM+Q
	eUJ8LYHuP6rvLcX2acazaexVwWwHKaqsSAiyBqNS8UCE4ywXtfjXtZZDbw652YAS
	/79Agewl43vkEsrxC9V6W4GgjOKl2SGGwbKLJF2O8c45G2VgSOsT9zHi2/Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776128950; x=1776215350; bh=3TxOOyU9BBG+KZA0BVFGW6BQKMkHgaX5lrF
	Uz+6/QVU=; b=LYhRjruyJY2nX3upZoNdODHuGVuOeIvL3QE9JVZ7CX6X9pyELDJ
	KNu/0Eqv19eqWMvRfiA2HqZ99HMsEValJ2TiNq16YxjpPa7LiV+wuYJLdimDFrIA
	tO7xeHCJj0FF04rVYmd8dets7KQfD/NbK0FcKsntxY5ckd6eglR8WGF5q145auKh
	J0A6kDdLx7XsveE0RR+TjuNO7R/CfYBSj51aoS1vFMBWLJVkbBVlw4f2Hxp7GLOT
	2ERt3zMyUu5E2BNFokj4wYSIR+bqJeCqbor8lzwD9vrcHgDCf65E90PsKRm2CbSs
	PC19GI5CE/LEjFV99cRhSIkQdxK3lhN3wEQ==
X-ME-Sender: <xms:tpPdaUZCsaj2Yc5SEMiWBVo2VU1QUgtGBLhbWlDCPWMfab9UVkcKKw>
    <xme:tpPdaW0TXpPbq0kpJt16DV-3A83OVeJZW_SiBD8L3QgEeu9xMWOhoqdyAgSRrnBZu
    -Z0VAG2gCVY3LyEaUAWhTFtrbXYpStIUJZzL_BWIkW1kFl_0ZKeu0Y>
X-ME-Received: <xmr:tpPdacU7fOf_v5ACtflYO7msM43R-Xl1Ju3HSpkLNlIMq6A9Z2U2cfl6LYWNxGrOM7oP2JrmaeffNA4Kw_yM41Z1rASfP8GdHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeghffgffefudehueelfefhveetvddvffetffegieehheefudeigeefgfetieet
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhhthhtphgurdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tpPdaYX0_gWqAPGnkBWa5PAJrofWQYiNo0N-MczE46RUXGDDhiizEg>
    <xmx:tpPdaTcWO8hcQbMsHAIl8j_5IMA6yrMS2oYROy2G5LoZj5-qv4AYbQ>
    <xmx:tpPdaZVgY45H_Y0HfMLU0rG32cKDUPpO5YooYJVFv7JonL_kYXfIRQ>
    <xmx:tpPdaUcHRZaranwlQq0ljegefStDZwjLX1BnKfZk_yP8Q2pgQ9dGGA>
    <xmx:tpPdae-7ED4iZnZbkzpEzbfmSrPtF32L43bhdSSBzBwK05mJIBHTnnL1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 21:09:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
In-Reply-To: <xmqqeckifq59.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 Apr 2026 15:32:02 -0700")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
	<xmqqeckifq59.fsf@gitster.g>
Date: Mon, 13 Apr 2026 18:09:08 -0700
Message-ID: <xmqq340yfivf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I think I know what is lacking in this patch.  Following the above
> section (which is a good conversion), there is this bit that needs a
> similar handling.
>
>  t/lib-git-svn.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git c/t/lib-git-svn.sh w/t/lib-git-svn.sh
> index 2fde2353fd..24c15d17eb 100644
> --- c/t/lib-git-svn.sh
> +++ w/t/lib-git-svn.sh
> @@ -27,13 +27,13 @@ export svnrepo
>  svnconf=$PWD/svnconf
>  export svnconf
>  
> +x=0
>  perl -w -e "
>  use SVN::Core;
>  use SVN::Repos;
>  \$SVN::Core::VERSION gt '1.1.0' or exit(42);
>  system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
> -" >&3 2>&4
> -x=$?
> +" >&3 2>&4 || x=$?
>  if test $x -ne 0
>  then
>  	if test $x -eq 42; then

The above is queued as a squash fix-up on top of the topic, but with
the topic merged to 'seen', we seem to be getting a CI failure that
appears specific to macOS.  Compare the failing

  https://github.com/git/git/actions/runs/24371204585 (aa13593)

with the same tree without the topic

  https://github.com/git/git/actions/runs/24369661492 (ad8b884)

The only differences between the commits are

$ git diff --compact-summary ad8b884 aa13593
 t/lib-git-daemon.sh                | 13 ++++++++++---
 t/lib-git-svn.sh                   |  7 +++----
 t/lib-httpd.sh                     |  3 +--
 t/t0005-signals.sh                 |  4 ++--
 t/t0008-ignores.sh                 |  4 ++--
 t/t1301-shared-repo.sh             |  2 +-
 t/t3600-rm.sh                      |  2 +-
 t/t4032-diff-inter-hunk-context.sh | 14 ++++++++------
 t/t6002-rev-list-bisect.sh         | 17 ++++++++++-------
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 t/t7508-status.sh                  |  4 ++--
 t/t9138-git-svn-authors-prog.sh    |  4 ++--
 t/t9200-git-cvsexportcommit.sh     |  3 +--
 t/t9400-git-cvsserver-server.sh    |  5 +++--
 t/t9401-git-cvsserver-crlf.sh      |  4 ++--
 t/t9402-git-cvsserver-refs.sh      |  4 ++--
 t/t9902-completion.sh              |  2 +-
 t/test-lib-functions.sh            | 12 ++++++++----
 t/test-lib.sh                      |  8 ++++++--
 19 files changed, 78 insertions(+), 58 deletions(-)

which does match what is contained in this topic.


