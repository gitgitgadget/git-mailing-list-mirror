Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995023BE155
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995088; cv=none; b=edfOubBvOLxmqqHDD34NDlZu+nl9CSBVZImGrO5RuXAghV6GCevz/vpRvr20ho6f4U1bSPkR4jAcxUtrQXE1OCWjJ3GWgyqckK8aY5bvyMpaGF31dG13wtFXaHKT/1w9tWkGf9boSNM6CZmhw54bpXsnMns4o+daqASnpXxk8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995088; c=relaxed/simple;
	bh=ynpzxLT7i7iWe2Py50pTDpW9FTFQJxnb6fD+ywDkYuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bB3K/UOazVkViME9uWPtC+Ofcw/wIul3CLHE15Bd/NtwDAiIgZyMKKb1nk1zu5ZkbD+5kloV+6YtEVJ/CMKQlz82vsSRDYYy1bNxMCiQEa+zMjHposPDfmBNEL5hhD/CwMeJLk0vi4uTrOgaY5mNmSh2aSwLL2G5CP7hCeNIoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aejdY7LT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fU8nO11g; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aejdY7LT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fU8nO11g"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6AC37A00E7;
	Tue, 31 Mar 2026 18:11:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 18:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774995086; x=1775081486; bh=r/OMFpZMwY
	kmS97X4x/v3ueS2r2Y7I+n5wHV2Hx0+eA=; b=aejdY7LTQHK8m0QEnM3Cb48OtB
	0LydtVgikUWsxuFg3DpSiJukBOU5z/IQxUBrYeUeeSa2ui1iw+mvvZITT8mO2pwB
	8PjF++UWs3LkoTA0kuVX4MZiLXwS054RvAJJt1SGIqJw2s0Giwna7LErx+/HYez+
	xskN7AJbFqvwJQyavEJ0m8HT1MdpuJAuqVmI0m3mEtnSTnFu961QsTUkPMpybxjI
	ccY4Vdb/MYP7dAqBDOzBJvP9ASOVhpHbKjOlXDTG4AD518RSNBjMPuTps/IFvw9l
	rFpcuRycOofxAU3kJMSruhExTqmNmcJeIiG1rV6iHblSx/K6UEnvBhZfM3Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774995086; x=1775081486; bh=r/OMFpZMwYkmS97X4x/v3ueS2r2Y7I+n5wH
	V2Hx0+eA=; b=fU8nO11gPS9veu5Os9Xb/vQ2P3qgWzoz0F6rk2MEzo8RI+9VpQq
	iNsQrWI4i/GMY7dy++OM3GAQpGSkoTYLP9RaS07gBjPnfleMADgE7dgQEEL/e6bL
	TQaQl0TIyNVTEs12P+jHmWDmhx/0JWzB3xELCVr8Iv90jM5CXvm6vfWBvpGuMzIE
	71Q9641BjQcsKAawFET3T39WmbJxuCVMyTdAIdAme7/m/SBZgs4FMd/Km/qcxVVm
	00IfmBjQ+u+IvisEH0CeShlIspUChJrH41IALAklfNx8DthGGqFahBH6PsckUKbr
	yH9tB5174WmreOXGdcHjJ9EJhkAP+zttpdw==
X-ME-Sender: <xms:jkbMaQJy991tMm6Fx9zSJCLnX8F1p3ZroHERTzsVirG3i7WNqimBxQ>
    <xme:jkbMaXIX0As9smF9myAjriQk9xcHGLme_c8-lL7HBM_kOickC94B8l1ztuPyk7g74
    wyldczkunxB7gEVOK7D8nZA36Z-VbwnU7zSRj28dW7hu2mef5xRRw>
X-ME-Received: <xmr:jkbMaVt1rOPA5AkYe15jum_KtSixqUfUr8dNwxUi7oO3FNnPIDPZJvJV_H_gMhXB0JvEiHP9dRZZuoQD8SrKlGxAcUHCtm1GBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepgfetjeegudevueetieduhffhgedutdejhfejvdffleetlefhtdevjeeuheduffeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jkbMacTH4dQli0tIvQEB6E2uD551BqicD397Vlwgia5rLSJxNKkoqw>
    <xmx:jkbMaTNcjUuF0LdF-Edl6OAuMPfwLHad6Pk8Yq9OKIJPmidKlp25gQ>
    <xmx:jkbMaZZhoLNATWt175H7KPwVBMBPbOhbkjkDrN1lVKxF8Lu4K1xelw>
    <xmx:jkbMaVxkKSVS6Q_QsVbbntIiyIUpEWB3W1k7HZ1pwzGqxAX_2Lz7Zg>
    <xmx:jkbMaVO7OkL5NXXzB5jCImLVqKYE69VaXmhMC3bzfRnzWMUSoLxst4h7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 18:11:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] fast-import: extend signed object handling modes
In-Reply-To: <20260326191414.3783974-1-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 26 Mar 2026 14:14:09 -0500")
References: <20260326191414.3783974-1-jltobler@gmail.com>
Date: Tue, 31 Mar 2026 15:11:25 -0700
Message-ID: <xmqqtstvwsxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Changes since V1:
> - Added a prepatory patch which unifies how unsupported signing modes
>   are handled for git-fast-export(1). Now they are treated like any
>   other unknown signing mode. Unsupported signing modes for
>   '--signed-tags' in git-fast-import(1) are left alone because this
>   series progressively adds support for all these currently unsupported
>   modes.

Even though you have this inter-iteration change log (which is very
good), as the cover letter is not sent as a reply to the cover
letter of the previous iteration, the mailing list archive

  https://lore.kernel.org/git/20260326191414.3783974-1-jltobler@gmail.com/

does not help us navigate to the previous iteration

  https://lore.kernel.org/git/20260324215513.764739-1-jltobler@gmail.com/

very easily (I found the above URL by cheating---I looked at notes/amlog
for a commit from previous iteration jt/fast-import-signed-modes@{1}---but
that is not for everybody).

Looks like I was the only one who was interested enough to comment
on the patches over these two iterations, which is a bit sad, but I
think the patches are fairly cleanly done and are ready for 'next'.

Let me mark the topic as such in the "What's cooking" report.

Thanks.
