Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE835CBCB
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729645; cv=none; b=CyIyXNmnPlSSZiCCqZQOUJL0P1nfJboaHYr4gBFlBKYktQUxL3D7JfxnjnC1NPEPGaKOoGpMdW+BWnj7Ilt2T8ppvIH8OpbFodClNnh1Hli0bndbKJdGzVtb+zBXu1o05PQDXH+ZtHYvGjp8ikJijQqTS62rJkEHsWuwYxqbtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729645; c=relaxed/simple;
	bh=2OxKj2JQFZACJVQClonmoCHbyclIrPKNu6H2hCcUS24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqCjUO7dniYT1JC2zSjezWdbtr4YvPaQfCzvS/8YLMjKK1p0KFXploli3wJ2rngw5OvBpfLXLeZBR/oJKm9nliwUGLDJBJ/EpC+nii1j2gW1W4uBakWe0HLUFJ812NAx2a3TeZLAXO9bxdNLnobLVotTO4qk5Kd+Y0O52f7IgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=p+B+03ky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUFPxPPR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="p+B+03ky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUFPxPPR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 66F111D000E3;
	Wed, 17 Jun 2026 16:54:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 16:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781729643;
	 x=1781816043; bh=L4gBB8g161faebWF/GHcOTRWHHvmSwCkvBPZdFDCnyw=; b=
	p+B+03ky/yY3esL9wl6L36zeJU0QWl4KE4XFXejgumYJuaaPJC+WYW4eUv8g0/mZ
	lLi6gcB4DRG0UOPThPRyQN0lonnbKiUP4e5FnerA0nz+DqMDRLpncAxLu3ERy1OS
	hHi/is08UPG0e768dXnH2tfgdYnBhnF0MALz7aW6IKQmeML1J9yY3SeQX/OoHgBO
	K339a5+ekHwYbxiWT8LTzKoikhC/Jrgn2PrOdpBlF9+EPiqyQlAVhaHXj4hHpkhH
	FTMMRqlwr4CxFeWBWLG0NmHUb95/xggyf3Af3kp6DiTefHzPjZBnb9GEA2hZTylP
	24NgXUFOwyVxXJzTsPzLKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781729643; x=
	1781816043; bh=L4gBB8g161faebWF/GHcOTRWHHvmSwCkvBPZdFDCnyw=; b=i
	UFPxPPRHpp7O84f77qDPVP0tVcqkZN9VIa8Et0AEPHtEqOiL8l9G070lqxjJ2D8u
	UtatjigxkEB+rby4O0Rlff+LSDkmMtfOvOv8RN1hlXPTSbdQwt99WZfBw823Yhmm
	1Dwk58Rd2zbxjFLFbVbMCg2l2oaOCqcvjDmdXsk3opVfW4aXOJjCXbfuD5IhEHue
	2EdxbsyWWt8idQdA36q4IkuMjEge++SeVzQLI1Nq69vEuRzn4RNEVoaXKQKoGPpK
	uAIAMbw2wPSEoomfYi4R3qmsEc/bNpfs6RdwFIC3ek9QJxeeZC2a5gyB47iwTaCC
	2rfWBqciDbaxGI5a6xobw==
X-ME-Sender: <xms:awkzauznYUR9EvLb45CAf5YZdbvuY-Bl6wATqboryykJUNTZxsDWbvw>
    <xme:awkzahSIzOyN6t5eML4hKa6irZVJF6c8sLjHvc2a1DLIruLORR9dWHvJ-NdeoG-cN
    OqSch6MnFvu0xPhXJoaXCilxpbV3BwBmYiCSvMzLl7giS5xAecM>
X-ME-Received: <xmr:awkzalX2sc1GlGolvZ9mcFUoc91te4Snv2WawN17gbd-OedDb_vusigkhKDvCX78dCS5kqHM0Bd4GaBqFrwagVKP-WPSr2RIlol1d4Y-ddp0UK_Rhfp7P6wP7A>
X-ME-Proxy-Cause: dmFkZTEAjnDpsbzRqsIgqUIzTdGUdXEO+h9xpm0hY1dN4LwFENS4EJFVcwuriADNcp6bdK
    ReECXoThdiibEO4PfBlP4EZnXskCCGlFVljs+QWTGWdugrTxDeB0xglwngo+ifMTgYfarg
    dA8ezCyO/zUBY+ncNIiaTrvZsXuM+ybLIYaakNkHhC/Z+8BimpUvZkc83uOptf8kqduXAo
    zEHyViJ/quLL4Bz5PgqgYjvPd7TVfYmOWXM5XYT1NuQBsa70xgL3e1SfTupjlqKq4l895F
    w6XoysdE1Mac2nkUaozitwcXWPgBF6JBEm+nS22v5pUf890ittmxrHoz6cS54+jIjKWiYJ
    S4+gE4yPScCSuNoCuRDWGYFGhdLbrj1O/mrSyccAtwxwk5klAPhPMbFQlFMV62ot8IEIDg
    SbtJ1dsONM9gIjFjcoVkdY/dH3dy6RuIYWl3XAMT87A0dzbhwo2/FIQZH/drjC9frPTPLj
    z5Xlb5yca0W8WWvk7U4q0KDp3MuToF9AtuhOfVnUy3QYhvwa2FFfORs+QIbBMRYg26FYnM
    xdNHlJ0YaEvsRhCQUHtZuw4o8FV3PLKpKydb9Namk5giftxcKcBB6Dx9+AuXPjqOey8D66
    jpEP3QSrLQqi9v0ylCObg2WC6J3hB7CYJOMcXbxGfxix312v7R9mnQTY5bDg
X-ME-Proxy: <xmx:awkzajZOkh0JkLlp8gjJCpE6VHEzf0PEe-ebJwUQTBwp9zM-uT-vTQ>
    <xmx:awkzar0GmaRaQwFh1OdnG67hPmUnZAbtwGUqh--AQKWel4trMn1A2w>
    <xmx:awkzalj6B_zXECIBTPxhM9_IY-rVeLXumuIhC8pr63feQWPOH1p1Zg>
    <xmx:awkzava6WxtxnoWWuIeuT2FK8UquHT24W4wYzoRbma1ssoSKbx7IXg>
    <xmx:awkzaj85ekpZ9VUSVDrf5RYXFm-qI32zmuBDyNcrSmoS3RxpY8rW9N43>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 16:54:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] SubmittingPatches: note that trailer order matters
Date: Wed, 17 Jun 2026 22:52:19 +0200
Message-ID: <V2_trailer_order_matters.9bb@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_SubPatches_trailers.9b6@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz> <V2_CV_SubPatches_trailers.9b6@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

It matters where you put new trailers: they should be added in
chronological order, and each person who passes on a patch should add
their s-o-b last. You are signing off on the patch as well as the whole
message up to that point.

This also makes it clear who added what:

    Acked-by: The Reviewer <r@example.org>
    Signed-off-by: The Contributor <c@example.org>
    Acked-by: The (Late) Reviewer <late@example.org>
    Signed-off-by: The Maintainer <m@example.org>

The first ack was added by the contributor and the second one was added
by the maintainer.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Mention this in both the DCO section (new) as well as the trailers
      section
    • Emphasize and lead with chronological order and let everything
      fall in place according to that
        • https://lore.kernel.org/git/xmqq8q8mt4eo.fsf@gitster.g/
    • Msg: Drop “the the”; one is enough

 Documentation/SubmittingPatches | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index cb2df3cfff6..dceeb5a1817 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -427,6 +427,10 @@ D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
 
+Place this `Signed-off-by:` trailer at the end, after trailers added by
+others and after other trailers added by you; see
+<<commit-trailers,Commit trailers>> below ("chronological order").
+
 This procedure originally came from the Linux kernel project, so our
 rule is quite similar to theirs, but what exactly it means to sign-off
 your patch differs from project to project, so it may be different
@@ -487,6 +491,12 @@ particular are not used in this project.
 Only capitalize the very first letter of the trailer, i.e. favor
 `Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
 
+As mentioned under <<dco,DCO>> above, trailers are added in
+chronological order; one person might sign-off on a patch and send it to
+someone else, who then in turn adds her own sign-off. Further, any
+trailers that you add beyond your sign-off should come before that
+sign-off. That makes it clear what trailers which person added.
+
 [[ai]]
 === Use of Artificial Intelligence (AI)
 
-- 
2.54.0.22.g9e26862b904

