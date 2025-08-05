Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F530215062
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754368746; cv=none; b=A20CV1FxwnJ1M8hIeoI+8p/KMw3ONITMeQ0oVG8DLPljoBouRkmluxVJLL18GJ1d5m5XZVe35GBHJrNTh+CMjSDRV5UcGFH1BX2KumlNuavKUOEctKPePnBN5rlJ0cvj5auCmGc+t3H8medez0Q8IodLzEF/agzbEF6MsLwui9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754368746; c=relaxed/simple;
	bh=sTcm15KqqUOBXZ/B25jQ7JWhBZEe8pUy/VlVsPFumrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk7Ve7IxJwzq+bvEre6WDlP9GC2IZVDayOHzTxgKur41Ef8isFJvxrPdOg1xdqrmoDwpMaInih/7goE0TKorkd5eferRGteK488O6ces0lu0cbUPOGTfTTkMN/a/VhaiZ4q6IARFow6aWEHVgCntP5K63wcufeADBtBuRVfh5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j9Wqwiml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q0PEItwr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j9Wqwiml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q0PEItwr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 63477EC02DE;
	Tue,  5 Aug 2025 00:39:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 00:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754368743;
	 x=1754455143; bh=1nKGGrwF9FLb7N9Tb4rOEp5GHShrgVXE/vzF53q9yAI=; b=
	j9Wqwiml31JVxXHroMjU4hTf70UKVVMNs+qMR19wz5IS3zclmukn37aKTd2l1tSW
	d9PY/4vkGejL2Z9DrQuquEKORh0iSi6pzRI6FGCpIqwj4ox6Dd7QpO68FHsjzAY8
	E64LNQh1cuUWUaBY1T9htVahbHVqcYq8LaH/WqlLXVBrYLFUOBVficSp21W7eXhD
	1WFVyQIeBNgStlUkPVYCneTbRFMoZx1glHhsUwRZ5Y0+9xKAvsI4Sna9QsVeilW8
	Q6QhrI1l4izp95issQlPZ2N/W5nTTsvfagECysUwEGWBPCY84D6jqHNtZsWf5isJ
	Y2SkY7hAkBwwonlFHdDyRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754368743; x=
	1754455143; bh=1nKGGrwF9FLb7N9Tb4rOEp5GHShrgVXE/vzF53q9yAI=; b=Q
	0PEItwrHNfJJbKZWbVrGO22FIP3p4s25iLJrUes+2+4My1OjtLrc3T6pcqrlMRna
	MJZY7tlC9qNaIpui/gEqfHiQ29izhm9KJagOpmhwGs3/wzuPq50wB9AGveYx21hZ
	/TI31c8dTUR+uJF3p4vOhUmtCJ53x3S5wOp7Ekk8Y52DLQ9rU8FVs7gXjxw1sDdY
	de+wyfYDD96Bdv+979XzwSotCYAXgiLuSQQzPvarajAxB86TmLoK8Se9CZFed92n
	LnzPGI0ecpZxVr4vaoD5tPO4Xd6P9sgUwNbA2g3e8dAFr4WxpPk3fX4Z4YOvok4F
	mPDOaTTb60j53NmdUplwg==
X-ME-Sender: <xms:54qRaEC_ilrfBg-9f-L3TMiIcnsd07zE-OP4K3lMDO7A5Ib13O3z-g>
    <xme:54qRaJz2ZDiyH0_CWMWomwFFeSIrCaetEua13ngV_58PfTrD0tFp8dQyI47DKqTZE
    UiQ0aRHDV3xQJU81g>
X-ME-Received: <xmr:54qRaBCsJ0EDMjw9Gu9fY0yc5TOKy96qckh2XdiqAJU1x35MsiToOOi4eRZixqOUXssf53fIJvLa3jIXWQ6pqBtZgpQIfZ3RkyuVxU4YeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:54qRaGYenEvOlk7VCam0qcxWHoNxrv7jKT5-sefeLkiK-71NDvssxw>
    <xmx:54qRaJgWYvnHt9b2PHIth9NkUbdXzRk1tboigagzgOpL6zrbenBlYA>
    <xmx:54qRaI44A2FTFJln0EmRYBPXm3NIUGsGZnU9G_YmDKrgsnri0oCNTg>
    <xmx:54qRaA5pRd0p_JLydxt01wQiLLAoIFSNsjZ95W-jMPq2TorZuAfkug>
    <xmx:54qRaFAOaRehlxZO_ixKvk83F5PG27h9bz_1qh3ytpMW60obtooqrLbc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 00:39:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9125a7fa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 04:39:02 +0000 (UTC)
Date: Tue, 5 Aug 2025 06:38:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 4/6] t6423: fix missed staging of file in testcases
 12i,12j,12k
Message-ID: <aJGK4tSCkWgBK32Q@pks.im>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <3b3b258cec5f0080beb64501f7510f7acbc3a91b.1753197791.git.gitgitgadget@gmail.com>
 <aIx7Qp_epPOpk8OF@pks.im>
 <CABPp-BF36TtAaqbV01m82Cj_7Mr23P1DEuSTR7oM9odLbD9q5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BF36TtAaqbV01m82Cj_7Mr23P1DEuSTR7oM9odLbD9q5g@mail.gmail.com>

On Mon, Aug 04, 2025 at 12:23:49PM -0700, Elijah Newren wrote:
> On Fri, Aug 1, 2025 at 1:31 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Jul 22, 2025 at 03:23:09PM +0000, Elijah Newren via GitGitGadget wrote:
> > > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> > > index 69de7a3b84af..c2032eb6cfa1 100755
> > > --- a/t/t6423-merge-rename-directories.sh
> > > +++ b/t/t6423-merge-rename-directories.sh
> > > @@ -5114,7 +5117,7 @@ test_expect_failure '12n: Directory rename transitively makes rename back to sel
> > >               grep "CONFLICT (file location).*should perhaps be moved" out &&
> > >
> > >               # Should have 1 entry for hello, and 1 for world
> > > -             test_stdout_line_count = 2 git ls-files -s &&
> > > +             test_stdout_line_count = 3 git ls-files -s &&
> > >               test_stdout_line_count = 1 git ls-files -s hello &&
> > >               test_stdout_line_count = 2 git ls-files -s world
> > >       )
> >
> > Should we also explicitly check `git ls-files -s baz`?
> 
> Why?  There was no baz in this testcase -- not only did it not appear
> in the final commit, it didn't appear in either branch being merged
> nor anywhere in the entire history of the repository.  Testcases
> 12{i,j,k} all had such a file, but testcase 12n does not.

Mostly because the line count was adjusted, so it seems clear to me that
"baz" at least plays a role here. Otherwise there's a mismatch between
the number of lines we see and the state of files we verify.

Patrick
