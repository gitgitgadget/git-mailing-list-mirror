Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851661CAA92
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535609; cv=none; b=G6xaHtFo1+PmESVibgkeCdaG509vbbgtze9ozWdAuvIDzG6VxbvB/mbPDLSG1VXJENWmQLjHEbmW/UCxSn5Qjy2iLJKiL//KRXJXYfcMKmbRv8yVtDleKHCSTPMMZ6fFgynez5iAO0ZsExB8SNvxc65m7fBh9flRI3vMaNVXLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535609; c=relaxed/simple;
	bh=j7GWX/fMXoMvZ8YoeyVc7TbuBk5S1lh0JEFuWd76vmY=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=P8b7nUeSfoYFsx9Ub3mdCALdZREQY9RehCl9+XaeN111oIeXkgDk7pUZzKVLMAFHAJZeX5DmYU2ZcOq7wxMvHLTaltM2O6pDHKa7EFhSJ+2rxnxiuL1y8CFSmAYBys7hyuqGJb0nDoS/M+4xzaPfM1gek4hAO9ZAPYvHQs1OIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc; spf=pass smtp.mailfrom=calamity.inc; dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b=GN9FDX5R; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calamity.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b="GN9FDX5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calamity.inc;
	s=protonmail3; t=1758535598; x=1758794798;
	bh=j7GWX/fMXoMvZ8YoeyVc7TbuBk5S1lh0JEFuWd76vmY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GN9FDX5RzcmcN6dwxroeXrrW1jcy/wvi1J9yuFnp1jXhazHnRlgQU81/QQTZTEABc
	 6e/3kcoBD+LOa++PF52Zf/rMv+uEX9PZ8QgwaLOiCTyN59AU7TuEHwHNXUiYlHp+kq
	 Qc3pJgcvXjg6V3167FNFM/SUiaQGOs4eEogYj61lTXwTCJybr9McfojUFZx/63TKbp
	 /p9EskvDBNKDcGHG1nCWOw1Z7TbPBDIofc69D5S8w/o/W+zzFLv2yFRBF5d8V0Ojyy
	 +KiuedGw2kgXJ82p6Zxy0ITmJSErtUvtiNPPeOsxoWerfuyjq43nqTFfjsa/7nblR0
	 5pwIS8eFq20Iw==
Date: Mon, 22 Sep 2025 10:06:31 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Sainan <sainan@calamity.inc>
Subject: Could Git be smarter about object reuse?
Message-ID: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc>
Feedback-ID: 116374642:user:proton
X-Pm-Message-ID: 1d62b09ffb991e21d65cb0b273e900a42cee5f3f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello, I'm not entirely sure about the details of pushing, but I've noticed=
 that basically it just uploads every object the server might need in relat=
ionship to that commit which can be a huge amount of data and sometimes eve=
n exceed the server-defined request timeout, causing the push to fail.

It's especially annoying because I know the server already has basically al=
l the blobs needed and hence would only need to receive the commit and tree=
 objects.

Are there any hidden flags or future cosiderations that could be made to re=
duce the bandwidth needed for such pushes?

--=C2=A0Sainan
