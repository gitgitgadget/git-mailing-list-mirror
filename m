Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF135E926
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790397421; cv=none; b=nbYpD4flrU4rgaQTuVUiEUHBx6JjCUPiBFwQhW0j3TkMyaCV4wyKiMRawig9fqEPRv7HiUPGCY12dN+4lfle7W8pWHp6WWWTCeQ0ZCLP/dxf1SqvFKvJ3Meq0NFXVitL3k7kG0mo5++UjOD9eRcacr4iMVOZZi4lI0aCWrBtwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790397421; c=relaxed/simple;
	bh=QsxtRqu8NFkl55sTXGfvcTgQOmE4qpEKz4qQqou1uCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jy4TIZl2bYoslI2klydq1GYcG6smTe91CwvlTjL5jVSINy3d2ly0pJArpZO7UWq7MWz5yqDOBq+bMJwocjer5fO917M0tRxT6Xfd1B9zzDCbph7aeFYfjft9yfZXH2PU3XtxmFh9jtixpxJFeUFfdn8rPWZmUj53yxwBCtp6ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A9Ro7nHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w/cAnZNe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A9Ro7nHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w/cAnZNe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 52398EC0180;
	Sat, 26 Sep 2026 00:36:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 26 Sep 2026 00:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790397418; x=1790483818; bh=prHCa6y4Id
	lYERMMs4CTOhv9mjYbHKdKmbZIDYbQtH0=; b=A9Ro7nHpXk4iC8rmFXcSJS2tUB
	fhJ5/LMDqitwBinsXHH6wAu19aQoVhF+i9rymTsWmOP/2VXbOaVSkyEpp+n/7ghq
	o7w2Aov80GlIABqcuFor1NaPv3wPfMiGZ+WTVRUaYsI5N2isEZFTCKCiKZcDWA8H
	PpSWlLkKLmYVdhYOmtaWFc345ZEpnlhZqBiv1YJ1LjljOadNUsuzj8bD4BScsqOW
	SzsjA6idmLY18r4qVbrHD6L6i36L1JI2G2rsa/anTufyXrif1Ti96ZPO57EaKYfg
	03tvGwltGW+eNPRSo+HTNwbgwXxv1acDULFKNEQpwr7yyijsXfd/5LiiJ3dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790397418; x=1790483818; bh=prHCa6y4IdlYERMMs4CTOhv9mjYbHKdKmbZ
	IDYbQtH0=; b=w/cAnZNeRBHABT4AOUoCaYlHQkMh6LXjBJb51DNFhsB36HMg/bs
	7jEI8GvJBB6MpzkBS4xAutz70GChbKvzvJ1MG0MBc3MkJ7LS0bL0K2aNzqw6AokW
	PpGNtpDOctKxhWsYPVSpC8D9jsOUI6DsviMUhx7pZcElwS84Z9j4VqbHGkxLsUUN
	4BU3+ZIVVdBZ832QB1BABmQwg0ulWlVqxUi2Yhw2dSsxuGGSRZ0ntHVoxZJs063P
	o2byoZEtb9LxAJa6NFl1ZaIjBOYav+EGRi3Y7AFR1/kUqoJb/tGBTUCU1mEyn8i1
	MBowVzFl3Pv8Cc0TFar9eQkslJ3oVYDMLlw==
X-ME-Sender: <xms:6ku3auHB9ybVJLvEJzfwrlRehVbHsdOuV3copvah3vHlJ_pFVIikeg>
    <xme:6ku3amVzSGwvoMe2sQDCeoDfEKNDXlg5ykxViis787bN_x_KPZFp-s-GTsMV6IC9a
    N6kfeVEnxTBFGSFN_LLbmsfucUsO5NLHhWCxQBITTzNoFRK7IyR_oA>
X-ME-Received: <xmr:6ku3atLti5dPW4H4C0iTz7QcHeuwcDfqByKAfa1cIuV65vV3VfJx0yWn3VBg5-Gv9zhktdolO2RicLYkp8yCvm8MYBOACUh8IpEi>
X-ME-Proxy-Cause: dmFkZTF2SNH91gl0eVhP7amt4TmeMMgZuBkgMHXnQiKLl3xsCMdzSak1MHcfwlz9pzB2Vj
    gcGm0FyWqsph2HRw01sqI4wDNwb02ZAv52lVPLe+MY+jNI9Uka9YALW70zLyNOn/fj6f5S
    zI7icnv/p4Z7H26IQMqNePD4zqKwHYB1+4tlhpce5thRyMMQKbc8nZgTnZo35JekrS7QsC
    skSXXHg+DiXZCD3uBQsKoNViDEWs9mOZqYFMDBhNPOpoxeT0hJlqBgslX85rrgqYNthbaI
    4mhmteIqVSq997KxyD4FkF4lqeUL0KyALy+En0imqBOfY6wXQ1fVomLlCGwnCcUbvMG5KR
    YqfLyolzw9KqmiIs64jRrykzyoQlSc5RvzEjxXGKxtI1X2/1a8alg865JlMBAp0rwYQVsU
    yXUgGPw2Uj8YVn/u1YHoD1LF/Qt5JVN9t8WhNSQR8CsK2JLuvpPbkjQ1kReKvr1ovQca6u
    nnU1mG8X3UsivWm4wXQjNRV3mlhQ216Nnlsjli2psm0tjS/7TGRhiJXSOqYsqWKI5s9AIC
    t1HDVCvgjOC+8tueibldHZFAnNp3cHyEbf336JSyWc7bELFlaru0FdrczDtdD4MWrTFklT
    lCsHqCR1S9a58BrWoOxvoLn7LC4EC/s677P7HuuP/Vs1s0cuphHDVs2/2XUQ
X-ME-Proxy: <xmx:6ku3am_89nDX13_ocbxIRDPhYKN9mrwlY3u-50Y--2eYrkBaG9MMSA>
    <xmx:6ku3agJriqV32AL0N5Hv4ZOnceBW8Z9xjoW9BvKywRx5ZNpbBrcx2g>
    <xmx:6ku3armpgYiZQQZXFWJugZ8H7y1tFChC373WfIPTDNiHbwkW323GqA>
    <xmx:6ku3akONKApASmwvpUXDSrXLL13dtHj7ijJXxLvAF1I92i89516hSQ>
    <xmx:6ku3aorOIWqQv0DlpYazGNbVPlJTM8XfET-NEWQnhVfK27Qr1KDq4KUc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 00:36:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] ci: drop no-op gettext link on macOS
In-Reply-To: <pull.2402.v2.git.git.1789369749450.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 14 Sep 2026
	07:09:09 +0000")
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
	<pull.2402.v2.git.git.1789369749450.gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 21:36:56 -0700
Message-ID: <xmqqik3ssk5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Homebrew's gettext formula used to be keg-only, meaning brew would
> install it into the Cellar without linking its headers, libraries, or
> utilities like msgfmt anywhere on the default search paths, to avoid
> clashing with software that already ships its own gettext. `brew link
> --force gettext` overrode that restriction so the keg-only install
> became visible on the paths git's build and tests rely on.
>
> Homebrew dropped gettext's keg-only status in 2020
> (https://github.com/Homebrew/homebrew-core/pull/53489), so a fresh
> install now links into the prefix by itself. `brew link --force`
> against an already-linked keg has nothing left to override, and only
> produces a spurious "Already linked" warning in every macOS job's
> log.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

Sorry, but I lost track.  There were review exchanges on the
previous round, which crossed with this new iteration.  Is this
patch still relevant and do folks on macOS need this?

Thanks.
