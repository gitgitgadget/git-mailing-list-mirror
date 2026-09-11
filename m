Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486B4BEE3C
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164591; cv=none; b=D2vGZz1KD+znHrGEnOwHiEIaviP+QY8XRkwUhhsCv+olPETj4Jvsnmiy3RE0FfnkLbIH38bHg3LNxHi1vsLtbDWYh1X9UwI6j/t25g1/BpJgieAFGAR3jSKi/P73WMvLq/y3d3uBrwp2L+2jFNpqE8NJRknOeMDEqqj9JesFzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164591; c=relaxed/simple;
	bh=kjQtnHxteuaIiLZ1zHqsTNpUgA15a6wGTrzjMzWdYYc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lEPy6SP6raaptCIdJiAYEl63W68kAzrxC2QFf9MvXpTysg7CGypp7nJ+YPtfGfxJKvXYGkWt/T5Mny9wMSxqflECLZE2rTlkjS3CZb+xOWX4i3q7ZvtzdfZ4uCgRk4KiyG1RF/1Aid215NM95mr+Ecljdc6VITFyLGZqfMpYndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l7CxAlq+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ci1LPWWA; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l7CxAlq+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ci1LPWWA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 27EDE1D000C8;
	Fri, 11 Sep 2026 18:09:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 11 Sep 2026 18:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1789164589; x=1789250989; bh=FHt/0fDQKh7ayoS5Pn3pdEOcOKQkfuri
	7HtHVZZOoHM=; b=l7CxAlq+LvQO3lHp9e8EQPafXM7g1sANUB4DmbGAkIGXiaw2
	+sXjz5BugvUtzJHHHWaH28l+D24yZgDtCUvvEXEEBuQA023PRhR42Cf+lmNvA2Ss
	ngbpAb4WvAEBnrLuGlWO63Gd9sDjqi8AzMsBmefSO+41YvKozujhq6gYwcjmvhCD
	ziKtXvouuWk7QGbBLkkYWykDObCfPFjKylixavrfgo/OsTUkD7IfCN9bAXm0GGDo
	P3kgL9ak0i1SPRREgLe2dDbS/jgccInhha0jdeo0hZtoPGR6FTJwiWVoyLs8+6P6
	NUOGmt/Yz2UT3GDEe7ImfNKN4dX+bQfgPgHBWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789164589; x=
	1789250989; bh=FHt/0fDQKh7ayoS5Pn3pdEOcOKQkfuri7HtHVZZOoHM=; b=c
	i1LPWWAlfiw25ei9Rem+qf2axOQsTfYmhJYzRZBStFBxLCKvQwOY2U1rbchXDM0M
	flnwIcnrqgAfYdRpopdBd0UEvD45BYGiLxhRMRflx2mMiampVl+/Po4ClJNjB7rU
	SiZ9YcTC325jIMVFsmp6QZgLkMHsRyQauNxNU7KEmq7N4Lps06+73FCzw7/g0T5X
	IxjVT872xK8gkYpb3wncka8+c9rOV5CWdWAq0mwEVXNgPIwBS021LdXrqe0UkKT/
	7gESNiY8DjXbzHXRRI+OEZQ1fiE+Zb/+3GAGp7Kxf42hrYrYuvAu2S0dT9JzffpQ
	OtUvw9Xpf6zsU0Fzvf5aA==
X-ME-Sender: <xms:LHykakT6_HbTfKB9ewy2YRJGjd24Ytt4yEGf5gXAWtF7MvDLvno2Dw>
    <xme:LHykanxG03nIczBuQJsE6S8XykPBQ6UZUUWZCaNGQqJjLL6Uc1B9jqO-S1nMBBLEp
    J4QIGKRRb12yQ-3eOwrdUqxEHMj7fQIK3X6S1Gz88tHqOwEFZ9mEQ>
X-ME-Received: <xmr:LHykavdg4WasH5EM63G0jQ5xtQtiuYzex-hGIC6yihAodzK-Ae4P5whRF64M3eaJ2YwFrcyGrnoNVcYk_qvZU8Ayy1it7be3i0mp>
X-ME-Proxy-Cause: dmFkZTGaR7Rpy2hRVB57opursSLqbesEswGVBItZ00o7ZvkO5TIUFz3yxjBIn0w6mIGJgw
    ReXlhJTjS+1jGtpJlyDySKlhVGQpeTEayjeaZvPmUbEXydiwNz1P3g+9dsCdQwc8e6pKrV
    vIMAsLPK0X1LdY0R0sYmRFrwsVzsGlbN2bdmBamFuik76JEOTHQyQrUmEWFFFR6jOxLzfW
    KpPgQFcJpkqqaFKChiX2rosiOX504QmiYF6hCIzfp0d0M7meZ4Iu2elKijAmVtDQnUK5Dx
    i66lQzrRlgEuLy27buoTzFQVk5A2VvUp95eHUuXtzb2HJ3OQnuZCJJDl1zPZM1jJFB5Iln
    2OR8OiLXT4+56lX0HN84H7cb7X9JDgcPZE5RkyJUgZAQ/BjrRUN5oMP/TrMKVp89Ep336Z
    lY9Yasi8uji7oSYphiRVOcvAYRgbeH3cvvXw+U+J+Yc521D9oA7tM/ooR2lRpBzbAZZNp6
    9YVenERojyIOrzQb7tXpXhTB/PZI6l7jJL2TQ4kWmU7z3txd/StzIv5/CaHK8iErtG5Zzq
    KNmK2WvAfT6o77NiDB7Dj2jzm+5YKBlAZsvPj6ltZS2oMZKQjpZFSBuiPw+jsravBNqlne
    G3s+Vru+WRJ2HZgEbrohfn29TZj6Vpb2TT90+HOApgiX/dImXj2mi72fIocQ
X-ME-Proxy: <xmx:LHykajJ8oghk4tWsxZ0h21hxfkOMQpVAheDK9SA2AAWggc69KKMuow>
    <xmx:LHykagFLomzsfrCFADjoj65eirGaxopTuR7ZWoEaQASce2oyp5K20A>
    <xmx:LHykatrAALF-lmGXpKCStoMreAzcc4DXefgAwlUZ_Oqh_qPV8GRLHw>
    <xmx:LHykapSrIrsTk0f4RbBWh8VXye7q01yJaks2GjwrkDbNcGqZhC5ptA>
    <xmx:LXykanp6ULjji-V_1doztLx17V7JlcpPeiNe3eneMJRGPkwQwHAPaiS8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 18:09:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] cocci: remove risky "if (!E) free(E)" conversion
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 11 Sep 2026 15:09:47 -0700
Message-ID: <xmqqld978mok.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The current cocci patches try to convert

	if (!E)
		free(E);

into an unconditional call to free(E), with the rationale

    cocci: detect useless free(3) calls

    Add a semantic patch for removing checks that cause free(3) to only be
    called with a NULL pointer, as that must be a programming mistake.

which came from ec6cd14c7a (cocci: detect useless free(3) calls,
2017-02-11).

Leaving _something_ in ALL.patch output to draw programmers'
attention is a good thing, but this changes a piece of code that is
originally a no-op to do something else, which may be even worse.

We could change it to

	if (!E)
		BUG("free(E) is certainly not what we meant to write");

to force programmers to think.  But it probably is safer to just
rewrite one form of no-op into a simpler form of no-op.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 tools/coccinelle/free.cocci | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/coccinelle/free.cocci b/tools/coccinelle/free.cocci
index 03799e1908..3dfaae9dd8 100644
--- a/tools/coccinelle/free.cocci
+++ b/tools/coccinelle/free.cocci
@@ -8,16 +8,6 @@ expression E;
   commit_list_free(E);
 )
 
-@@
-expression E;
-@@
-- if (!E)
-(
-  free(E);
-|
-  commit_list_free(E);
-)
-
 @@
 expression E;
 @@
-- 
2.56.0-rc0-143-g1fea62d0ca

