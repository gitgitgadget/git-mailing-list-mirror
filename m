Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F741F5DA
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536900; cv=none; b=qqvU6UIdkURCL3B/1A0AqSOvfEZuEXwk3uB/yCwbOgVtEOEBEx2xMfrUljGizH2CvsgIRHFgxtR2/JnHjdcVin9XGinBysx2Wbf82H8cWk+MSnY8FmpTRfJVfdf7qyc3HtT15EIZaUfDkunGgDL8c8xCrcZzGNWYKglRoKJnEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536900; c=relaxed/simple;
	bh=jafRFXel3iMWcFO3uUmhy8f7aAFzKEsi5daLM+96E3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l3s9iwBrQ2ajFt4YQcPVhd085k+tDdk53ML6kZiJpc0BSkfw2SjysvL2mUE0qvu+5ix9Qw0XuhQAYxcbL9dA9kw/ryF1x3v6Dp5Wm3oxCy7J0wyLP/8onYsrviM28C7lq6I+4dJk6vpkMudblbLd/5lMmJlJczhAFGwyH9QoeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aU4YrbSY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgnSecWe; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aU4YrbSY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgnSecWe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 569A3EC00A2;
	Sun, 27 Sep 2026 15:21:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 27 Sep 2026 15:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790536898; x=1790623298; bh=IBVikBrKFA
	OBhrK8lXQ4FGkZRRoAFiMo/wdsNVdx5Bo=; b=aU4YrbSYbg3AfGP4D2ntSZH6Lc
	T5/0be1M11/Td/8M4pX3dl9XIAKPs7V8xrd4q9jIfrL27UrMans/hs6OekwF3WPl
	WgFAkkOjiVSp/6hQw9xX6WL5Jp/yOrMOzrc9yEOa188v4ZyMmr2pl0u+B4dTVKrF
	/giFRwQjKjSTS/CudlR1VaKMQ3wGxWpozQr1VCUS1cKAZimrsXrY+UMX5lMj706O
	BaWcdi655Uw23Z+Fl+HpvEPVPbbQSfBhm0xZHn0TkgS4f0N6AsNoY2XbmjkuPequ
	iRp0yLu15pfyzCDocq5TgosU/q9VGC4aJWwXr0gJMEbSvVlneyN7PwMbBTuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790536898; x=1790623298; bh=IBVikBrKFAOBhrK8lXQ4FGkZRRoAFiMo/wd
	sNVdx5Bo=; b=FgnSecWeNBwBKU33C1K3uIyaO+6hg0EhY3HtwQsJHjCbDK9IYJo
	LjB5TdCVfOBniJi9oosKHDof4u5C3Gh0gqDd50OQWnXdU30XV5MqRrm31RJ81g71
	M9LFj6/gCIBcwg4dmTNaFQ7beqq/7B26Bls0AybSOK44ILnrSQlJV5Mwg+iQJ3fe
	3dNqWCyCOHDkgVyvYC407qq8F5TLbLHlygTuUU95mjaH3ONlGTX/6wGdTYunh5n/
	bEtq8oOAkC6s5pzfr7XN9tQnFUmVpLCFy6iEVa3yNd8idh4dye8C5gb5nvqLyT9c
	t9GiIQEUraDjX0j0ksaApnayhInVONJFDvQ==
X-ME-Sender: <xms:wWy5av2hcik2687SExdMZSIc2OWd_jmlKfGMaZHGWv47EOyrbizx1g>
    <xme:wWy5avlwNeRLJDKc3jbuKlT0hVY_PHTpPdK3WlXUr_a6okjGwxrncr3LpVIka5C8P
    f9K6Aztr_xVNRKx5pzAVsPI6jkWfKWtIX43_QqW5fOJaqvlvBqTFC4>
X-ME-Received: <xmr:wWy5av-M4nZkZ6MTGqrCNmClKbaWNY7JVpKvoV6sNxNxIEzwJ7EMe_VhIyPol7hY4jqaRMPOxHM35tBYO9xtNu7x0dmsMSe1zvJ1>
X-ME-Proxy-Cause: dmFkZTGU54CFB8rz2tnYq1MeF6ejmqj+vtBCWahwNzW49JhXT90VV5lLQvV16g/0PWd7wx
    ebU36vUf13Z3bYNq/KL7LDWxQSOiMA4iOGXl+CPWg8w/nYoJi3XiaX0B78uAmsXLrFK8np
    FiKVgPBi1U/x/reJiEZ3BoFLGJw1IzdZBVGHifVezX5q/vQ+Qt+avcWBbQ6uDgp5mX9OAQ
    cRgc6ZFXqvYzXtYEl6vGbMCBApoOgNz+LxucGZ7X89ab65UKRxxNjQfjlwWQOxuQhkttO5
    4S8w7haKUBwJuQHD4C4nXfUgn+tb+vQoOgrHj/nVrVjH+fYoUozUNObBFl5qpl3/3tb8jA
    70pHNvfkH1iNCAbqyPlVrUeyGlX7VoMHxswEbysTeLiIj0qE5uNMpYW+R4u7QFBY9Trvz2
    JJyA7Q7dza/eCXMCpNjPHDCRvbCH/2wcdGHeMO+UqkC8EyrgWcrAxYWY8GZBroQy9O80iQ
    JcLwvWGYCsVkiP4OspmOdBfbz62uBO0K4EsOgWPAIknpb//3L5W7rokPBltgoGXxUoW0e+
    w4YXq+BYxvDTr2Qau7P68UssR2hzFX/goRq/s8LGIO02tF6NQjKN6TXb3V1RQGYbHK+iP9
    nG7SHvcpEmxBj2fQiOJYzwbNgDGNySBVnxsM97uoS3URjRE9PtarAFeFcJsg
X-ME-Proxy: <xmx:wWy5akp8M0oSfjOvbznPsWQccOOoXIsRdYSR7SFxxYSsoykMJ0a5_g>
    <xmx:wWy5aomvB_B7KHeOaAmAwXQrR2e1mEN0G1ZNidSpxi8u_EkDGpRn9Q>
    <xmx:wWy5argUuLJk2YpmFVe2sYrkjHjcOCsxu4sqFrFN5AbCGYRqRjuOmA>
    <xmx:wWy5agd9YW1PkLaew0ef5aiQv-74zMiIKwCr2dRU8AWVvFhAZvX6Og>
    <xmx:wmy5at14bnhir8hCHUirGZdGJW6BAwKixwiomvxPVf-769SMYArkrrGx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 15:21:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
In-Reply-To: <cover.1790425008.git.ben.knoble@gmail.com> (D. Ben Knoble's
	message of "Sat, 26 Sep 2026 08:16:43 -0400")
References: <cover.1790168285.git.ben.knoble@gmail.com>
	<cover.1790425008.git.ben.knoble@gmail.com>
Date: Sun, 27 Sep 2026 12:21:36 -0700
Message-ID: <xmqqjyo6qz3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Hi all,
>
> This small patch series fixes a bug reported by Eli Barzilay in the
> interaction between autostashing, staged index entries, and
> stash.index=true.
>
> The first patch is an incidental cleanup, and the second re-arranges one
> line to make the change easier. The third and fourth add missing test
> coverage (which catch breakages from prior incorrect rounds of this
> series), while the last holds the interesting bits.

I may have reported this on the previous round, too, but 'seen'
seems to break t5520 when this topic is merged.  I'll eject the
topic from my tree for now in the meantime.


