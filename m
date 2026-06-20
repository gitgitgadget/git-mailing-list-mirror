Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C623BCED
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781998986; cv=none; b=nm/DAQOdtB0iyyberuOU8mtuukTipv2+svezU+ZiNQDDwyyw4JO7Dnv+sytSf1UkY70tcwqdzRGOSqDjqWUi+9n+/m+Prw6cOzOMJhjbc+lxvoFW/86TFfARPuTt+gLMuwGl9lsDV4pYne+M6Nbcarm1gFGlQAJyNJnMpZlxSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781998986; c=relaxed/simple;
	bh=bKqx0YP06cB0HqfZ4KF/mGDGNsd2pQWUgc00rXJgzko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aIEah2CEFlSk5TZgTSaGgnRNkpLRQbDFGZ2hjynDzQJwAfQfq5FWK3+1c10V4OdIlw7NHcaYYMkAVMmfQfZf1M3BX8XMrlL3Gw6NBc6FeWhxH1XUCCVW0PYBB8RyBuEpJvfzeQQsdVPCGqB7AZqA4SpOYvZAqT8IvVa2Y7hAxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BF16UuHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D7sk/CkR; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BF16UuHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D7sk/CkR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D97A1D0004D;
	Sat, 20 Jun 2026 19:43:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 20 Jun 2026 19:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781998982; x=1782085382; bh=1Srmbf34xb
	H9w/F45oWpOj2Uzs6Z6bK3t/HSzhpxtPE=; b=BF16UuHlTcThhlFlNWDZTZ0bmh
	r+c3/esNYorYzv0qMIcfxUWf9A4arzzXIzuw7lfAeXmyp6tOKoHaeT1+noGp2IVH
	7Uj4VqHYZ1YDWHERh5QHxQoFCGWIcITARH0GdItAki/4vFzWfNil4LH8rYYxBXvl
	D9pu3UEpzfIXSwtUTrHbLBo162AcQxryGDuMwEPIMnnTWQIeJRYvsjYUKMy7JH56
	13CKmL7YgmCgWzU+Vkr3l6s6zrPHopEvDUblb6GXosDIoJ8rDyjFd1xncrDmlCC3
	0kmySd17LQ4ES2l/QuRwCvkmp6ccIzZ22yM7tJzOi4kOiIw6wuQ+gyUS6ztA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781998982; x=1782085382; bh=1Srmbf34xbH9w/F45oWpOj2Uzs6Z6bK3t/H
	SzhpxtPE=; b=D7sk/CkR2UFhPus/7x0G8py/XMruUSgEV2WFkRTxjZtmbw8uED0
	nF/NyevNhxlkwaJD/q4Zn6f0uNY0Xj2R1IVgThvO9m1tueiZixTR/bNiJeSKzmPk
	m15yuheNQ4W+7ZIheGlPfchH0V4Bz71OpZDyWFJeA9P3RGnpAUOMFmWaI/wgqkb9
	7hitpSCDBz8jTWGh1JZf7Yv1PDzpjmFRPzztaYtUsfkMgQm8pFWEMoTaARt8GGCR
	p3DCoPh1BNCIZqloxsincCOFwSfprNspYLU4Ttm40KVSYOayjKxzmDgSAWUxLF9U
	olIXyVxzLDu8OvfyTtuGurElB256bbT153w==
X-ME-Sender: <xms:hiU3amt08FmcEXyjFnSk1rg45KUCiN-DTcUWadXh0IRxdtOAwg0VhA>
    <xme:hiU3aid0zNPqXif1-Teb3vdVlhTP99M8zRCW-Xib0rU8WjKR0lD-GsQMR94vOmcDM
    cz2yV6MuRi4BAuDtmIN4hb_pQb0M31d-bE5kHBg2lF2xKUPLOsI-A>
X-ME-Received: <xmr:hiU3amyMRjIRWP0Ng4a8XiEebUpQ9L_cz0iD72cChgLQN9oApvriP9nCs1PViXl_IqjtHZ2g8vDKxMoJAd8NLy7hxC_pez1sjq6sYaY>
X-ME-Proxy-Cause: dmFkZTF4hxdCVjhgWnsQ7U844QUwcCl8MlDWFOLIt0WGA8WHt7lbYrWIdOPJ0FVz9WaKOs
    dzGhUMJfBecHmrEkvWiOSjmkbBI5bTc18vVkcmYy3U4vJoeKilJ96MX2j4vKw8neSRGk9t
    9am0v+VHdvth6SKo5XmstS2MlhnTQ3wUA4x6ci11tN3hE4jPE59Fzxau9NxtxkBg47tn5P
    uzbFfrjdCLk1ydOOoroGV61WEzkRKY2tbzY+Wvs2dH655eB4yTmpxNizmAo94UV/9A3cKa
    9Epy4hE/1GyiJeO0iIAxDixLR4r1FI21ziWteogbBd5BDNquHmpHYoQ3Fja4GSli8bRvK6
    oOnZDeuskMtv7l5WGRfTAid6SfJdl6PsM6N79ER7goB2Eci6zOlLgVLN29dM1zwNrHYRYn
    2tKWTOhcC3rR25yVuVIOuRW/LYVvr+V/EMli1TMmr6GjrVJzymhB5yPEGUo1fMmzVzeimY
    F4sg9WcpUE/Cp2xi1nbP9SidUa/oLcTGoVx9W/9pPs4KOa3u1NZJIi5JJ3r8OjZssKBfC/
    84DsxDNtQdAQMrYad6w64VZnZ+8v4W20fidUJVAdwAtJVm1svrsktd10VqeMDQr6WyZkP7
    BR6YCDwDlGgyhS5B3CfYtOrpTD6aDH1Gze6Oei3jRPR3ecWEDuiiVlEeInxQ
X-ME-Proxy: <xmx:hiU3agHg4r5nC9PJf8y4v8My2Shh4Zlf27-_5XeBPzXKagjkp8awoQ>
    <xmx:hiU3aix8Byj13-Ql9EOmIfJuTgW6VSJeao1kb4cWLPgIkd87Ic5QQA>
    <xmx:hiU3apu05bPtR2vcza_el4YRAHVFr3i3EHPXRm0MGhlItB35RNfmvA>
    <xmx:hiU3an074Gk8-tVaahNups_8M3MpE5blSXa_wFXYm_5k_TdePtp8gw>
    <xmx:hiU3aqTxAAr2zQcOGZqHTEpr1GReSpAmoveqocS56Q0Dqp40-J3byfGE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 19:43:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Michael Montalbo <mmontalbo@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: [PATCH v4] SubmittingPatches: address design critiques
In-Reply-To: <xmqqik7eld2g.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Fri, 19 Jun 2026 09:17:27 -0700")
References: <xmqqv7bhxiby.fsf@gitster.g> <xmqqpl1oteoi.fsf@gitster.g>
	<xmqqik7eld2g.fsf_-_@gitster.g>
Date: Sat, 20 Jun 2026 16:43:00 -0700
Message-ID: <xmqqeci0g4mz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Contributors sometimes fail to answer fundamental design or
viability comments from reviewers and submit subsequent rounds
without addressing them.  When design decisions are resolved on the
mailing list, the final justification should be recorded in the
commit messages.

Instruct authors to be particularly mindful of critiques regarding
high-level design or viability, to defend their choices on the list,
and to accompany new iterations with clearer explanations in the cover
letter, responses, and revised commit messages. Also instruct them to
explicitly document the resolution of these concerns in the commit
message body to keep the historical record complete.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Hopefully this will be the last iteration.

 Documentation/SubmittingPatches | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f042bb5aaf..28b4f2f795 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -51,6 +51,22 @@ area.
   respond to them with "Reply-All" on the mailing list, while taking
   them into account while preparing an updated set of patches.
 +
+Be particularly mindful of critiques regarding the high-level design
+or viability of your proposal (e.g., questioning if the feature is
+worth implementing, or if the chosen approach is appropriate).  Defend
+your design decisions on the list first and work with reviewers and
+other members to improve the design before revising the implementation.
+This will avoid wasting effort on an implementation before its design is
+solid.
++
+Make sure that any new version explains and justifies those design
+decisions more clearly, in the cover letter and in the revised commit
+messages.  Aim to make the reviewers say "it is now clear why we may
+want to do this with the updated version".
++
+Topics with unresolved fundamental design critiques will not be
+considered ready for merging.
++
 It is often beneficial to allow some time for reviewers to provide
 feedback before sending a new version, rather than sending an updated
 series immediately after receiving a review. This helps collect broader
@@ -323,6 +339,10 @@ The body should provide a meaningful commit message, which:
 
 . alternate solutions considered but discarded, if any.
 
+. records the resolution of design or viability concerns raised by the
+  community during the review, if any, ensuring the historical record
+  explains why the chosen approach was accepted over alternatives.
+
 [[present-tense]]
 The problem statement that describes the status quo is written in the
 present tense.  Write "The code does X when it is given input Y",

Interdiff against v2:
  diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
  index a9789e5303..28b4f2f795 100644
  --- a/Documentation/SubmittingPatches
  +++ b/Documentation/SubmittingPatches
  @@ -54,9 +54,10 @@ area.
   Be particularly mindful of critiques regarding the high-level design
   or viability of your proposal (e.g., questioning if the feature is
   worth implementing, or if the chosen approach is appropriate).  Defend
  -your design decisions on the list first, work with reviewers and other
  -members to improve the design before revising the implementation, to
  -avoid wasting effort on an implementation before its design is solid.
  +your design decisions on the list first and work with reviewers and
  +other members to improve the design before revising the implementation.
  +This will avoid wasting effort on an implementation before its design is
  +solid.
   +
   Make sure that any new version explains and justifies those design
   decisions more clearly, in the cover letter and in the revised commit
-- 
2.55.0-rc1-134-gb7e3543e07

