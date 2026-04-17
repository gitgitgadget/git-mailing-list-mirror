Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45022B8C5
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439159; cv=none; b=iFTGvw6H4kKRQcKEJk5S5Cuh7Y45xxVuqA9YKe7rUatAh1QfOuFr9vqBj3Rd+RM8c4mRNknBTqdTfXtCYdlHIz0mJ8mUeUeEKoSUo7dPdW15OC8p65qcuKEnzKuwGEHxaSMAGTh6gU93ptw/7EOJqa+q3GA6FC7xIr25zu8wL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439159; c=relaxed/simple;
	bh=zTkY61GIl6B4Or3SucQ+oQ/eBmzFtUgKpozfCIzLm5w=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kv7bUKJK7J9kWtu2QhOvVBaqaCxG1PtJAdxoajKhYWu/iNA4JRzq3tzNUvb47oIF7TW8+W/ToAjfOlUc5MQB1LXd/KgVMWsXdADonNuniWVksMI20ANi53pfyDPHbaJ6eaTOA2lOzRXBDl1RCbWMKrng0njVABTmzz507dj3wFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UsdYKTnA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v92rTX0i; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UsdYKTnA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v92rTX0i"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D7261D0011D;
	Fri, 17 Apr 2026 11:19:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 17 Apr 2026 11:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776439156; x=1776525556; bh=3/RbpfCNf4
	xz+neZ5EKOHWoUmH5j5A3WIfvSep91w7U=; b=UsdYKTnAF3DFhKHbg2hU8ctnv3
	89V7NoEITF9Y0phzniezH06FwLuQMv0DtuKOxwmRXe7+e8UycqaVEbHxAnFgcuSE
	TgXKPz/CRzLiCdRY5mBJRDD4Pq60uLZErnhdGYA60cCZMp2zdikexvfNiq8sTdej
	hgAztAp6LEii5AfmJ/0gV8ULBJDrf3m3F5SAupSJe6/fT/nN7m5IazyBIhzYjsll
	3PzKOq5paDsCfRqmqfXz8G4XfGWkD1xEQuxNXymmBxhtdFovcMk31MraljwpbRN6
	3FdobOv2koolcPDdstk/TMVCpj2rIwr01+aptnqjGtpjsS/lEUyHhEN3ccYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776439156; x=1776525556; bh=3/RbpfCNf4xz+neZ5EKOHWoUmH5j5A3WIfv
	Sep91w7U=; b=v92rTX0ifki406/Phu6TkFaUFPpGj57FL2Nfuj2esiRFjDnF3Hb
	S6EzdJIsykuOLazkzqoh3S6OmCb7mgYv4wEtbdU8DsLt0jbx0lCQUAdNf8iOeOGz
	rDCv9cG0fb1e9mk7dnfEu4FxSkcj1wewgWZ33HpR+vWO/kegu/aut1I0RpmbT1hN
	CzU6Nr9ZhZOMX7PayAiLp6eV3CenTBbBiM7znhhTK4ABHIAvBRyYurfe7HsjUKJA
	vIXGNoNZkbo83s2+LWpQhTUlDHxIperYB1UCHNtnH1IM88tt6LL8r4JLcm6FnT9O
	dNlR/8q8UQgbTAtGcziIIRQygTj2/dj6dqw==
X-ME-Sender: <xms:dE_iaZQ6Ok7uEBuu9JLAZ1gmq4HpN5hRkCwt2Sco4coIRZl1qGZVeA>
    <xme:dE_iaYyIb9DqcJYwrihUXDTsjNK5nFOjjD-rJOCQ_-tJ_iIC-w8O2s4QKOCjqCKh5
    2fI9ULoKJPM9EQlQOXIXcdprPIQEqaAw131_uVeClJ4x3L8RfQ>
X-ME-Received: <xmr:dE_iacfhg3FAz31cu4K4vCw2Cv_0Z4E45Guwvg9J5-uKfissbbOJXTYs_lLSgmPgUZPTRPmyDvy-AMwkOHNrvCg8JM2AMif3bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfeuudetkefgtdeugedvgfeuieeuvd
    elgffgfeekvdffuddvvdekuefhieefjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:dE_iacI0Tq-oXi4Ljx52bkri11P561NHLD8tzivm6qfRahpRjUt20Q>
    <xmx:dE_iaVFAUbBvq9AT_MieWSBgoXr3C4Bnv59jmRFDbbO-tBizByvUPA>
    <xmx:dE_iaeoTpTgUK3mRmEls969SwC9J04HhxCdIXYFTNANPTgJlh7r2oQ>
    <xmx:dE_iaWRpepFCNhn3GYqBJS47P4INYZnddFwRCzsCxIHF98FdEsCVJQ>
    <xmx:dE_iacoiRKGdvh9tVxyWslI78bNePPPDfG5qnIkZIudUEdbrN1rNqBh8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 11:19:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <xmqqqzohd0sh.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	14 Apr 2026 08:22:38 -0700")
References: <xmqqqzohd0sh.fsf@gitster.g>
Date: Fri, 17 Apr 2026 08:19:14 -0700
Message-ID: <xmqq5x5py5ql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

An update to 'master' has been pushed out, which contains
work by Elijah Newren, Jeff King, and Johannes Schindelin,
on these issues:

 * documentation fixes (typoes, grammos, phrasos)
 * fix to MIDX that wrote version2 file unnecessarily
 * update for Coverity CI job.

Git 2.54 final will be tagged at 10:00 US/Pacific (17:00 UTC) on
Monday, Apri 20th, and I plan to go offline for a week or two
immediately after that, so this pushout will pretty much be the
final shape of what should be in Git 2.54 final (modulo l10n),
although I might have another update later today.

Changes since v2.54.0-rc2 are as follows:

Elijah Newren (6):
      RelNotes/2.54.0: fix typos and grammar
      CodingGuidelines: fix subject-verb agreement
      doc: fix self-referential config in sendemail.smtpSSLClientKey
      doc: fix plural agreement in pack.preferBitmapTips
      doc: fix singular/plural mismatch in git-rerere
      doc: fix grammar errors in submodule description

Jeff King (1):
      MIDX: revert the default version to v1

Johannes Schindelin (1):
      codeql: bump actions/cache from 4 to 5

