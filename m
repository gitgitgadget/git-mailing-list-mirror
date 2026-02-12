Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0024DD1F
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931380; cv=none; b=rn2TYTDrAg1LfDSL/5qTeutd5zmkpR1HC8HtawuwcvNuo6OaPCY0xatqSfGqMyaBhDXb5kP5s4/tk5QPMTANTtgTTFATqu4KpR+dDVJQ0PvuKdJdi+39/YLhDQavA4nmzxZiRzCSnBldEEhyf2ZpFmjTCSHFUHZpJgeGf1FKkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931380; c=relaxed/simple;
	bh=iY7neEMfJRa0UgqN+hrUBrOPUoQuXEU6uClUgaTNVXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ruZcTy/6+I+9dyHM3Abqh4kS4o0tVtiWd5oMTJ78PYFpm+gXu2Idm2Ifkg9+F6TVBR4tiCEO7UOBjD7ds2Al/mucJImMQHIWlPLkHXuU5xkGgcZaqVERy4cKJ9w34fieqeZH4/IV2+JHw0umegBfBGEfduuMsGf5JUiIJpfZkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dJaEnYk9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4KL5GjS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJaEnYk9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4KL5GjS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D1241D000B7;
	Thu, 12 Feb 2026 16:22:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 12 Feb 2026 16:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770931378; x=1771017778; bh=Ljq1fPMW2J
	WolLX8yHr4iI5+IANLqvUhE+GwUZeS498=; b=dJaEnYk9DwzumrXG1NDEWnruDn
	7r7fk2GTMbGon/zJR4Zr5ZyDYSq2CvRXzUV4Y3qTw35U7qDh4G/ninBarRJEFrvk
	bD5idJWtgWOsA805m+o0ye2JKVVf1jxSHMXmPVUUmuLn8Fe/xU2AK5ZbBWWt5o3Q
	kkXGf9lVGxtS+JJ3AREEDvo2j9ftI6cWe4O0Eo29j8OXZiWLsphd/4wNgde4oo2t
	4WhZCqcAQg1W3rEIYZx/o72OdwFdrK7A19IW4YU1aAGR7CB9snUySPYkOq9sJ1xN
	QN1wSh6YctzMBBficVNACgHuR3yswikjZg0S9YDcpW9zez/d3W53uepX0LkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770931378; x=1771017778; bh=Ljq1fPMW2JWolLX8yHr4iI5+IANLqvUhE+G
	wUZeS498=; b=q4KL5GjSPDELWplboMBkdKprEs+Np/FDn9vJql03PilrItqRv6J
	peBYo1JF8Rvsr3LTd7jJCCkDnRNcNnZY9tTAIUMiPlHjF21eD1XiyCu02JEdoRnR
	/X7I2Kqj8itbJVD8/voN5KlE47x2NYtgjTPcP3hRgLmxJ3Dr6wrEJSOUtDL6r3tF
	dPRKfFnge5JL1B8knfT8utCl0/ugCDN74dw+wUYQjMtbCCZiUHTl+dpPWTXOrebF
	RghRv0ICVFsjYRwkGdUnMtH+yNyLrJH1KSnP5PSg34RY/V3yGEoN+h5G7hUrlgBh
	3d6j5B80yCx/dfLQhV5p2PqdJhJAqBTrtGw==
X-ME-Sender: <xms:skSOad7y4nyQ6L8d739A2nihOVG3jTX4jnMEp67P8tfaE4U3fbYSLg>
    <xme:skSOaSXUTi1GZvlNJmPw0AO33kNHkxIe3AY1RwXct-PY_FJxz9SNR9vIhdRQobl2Z
    Z2fhbTLvt-Ec-opSmh_Y3RwuTvK4Nw_ei-PCOruVrKzB6BRtA2jIcY>
X-ME-Received: <xmr:skSOaR2aw_mtAzH7_63lJhnRxB-GgTmCti_PDXcf6STPwWa8B2sobc3sT7p7n27eKCJHfJu78oqGfS824rhyAPT5X27fZo4BuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeigeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:skSOaf0vRTZZi8cB2Gl33ZIJNeap0UajDKvN4eJQUwUfR9KRVniXjw>
    <xmx:skSOaU84MFJEWDHRjsdGiu8aM13cIsfTf3wDeBt2pXtXVWJr_I_Kag>
    <xmx:skSOac10hMasuMVSV7OzmzvpHXkMxKdn080dBZKwqegRQHWHGQ7esQ>
    <xmx:skSOaR_zJGglaMo4x-FZC8eYPvRm543abrPlWbfkeNM7MX6-8FW2vw>
    <xmx:skSOaac4yDnyNDvRw7W6iKz-rD1FpaZiWsokCsJ8uEZ9PZGaaibGgidq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 16:22:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] CodingGuidelines: document NEEDSWORK comments
In-Reply-To: <xmqqms1ft7il.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	11 Feb 2026 11:17:06 -0800")
References: <xmqqms1ft7il.fsf@gitster.g>
Date: Thu, 12 Feb 2026 13:22:56 -0800
Message-ID: <xmqqldgxmzbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We often say things like /* NEEDSWORK: further _do_ _this_ */ in
comments, but it is a short-hand to say "We might later want to do
this.  We might not.  We do not have to decide it right now at this
moment in the commit this comment was added.  If somebody is
inclined to work in this area further, the first thing they need to
do is to figure out if it truly makes sense to do so, before blindly
doing it.

This seems to have never been documented.  Do so now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * reworded with a bit more stress on the possibility that the
   rationale behind NEEDSWORK comment may have gotten stale.

 Documentation/CodingGuidelines | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index df72fe0177..318829d4e4 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -33,6 +33,16 @@ Git in general, a few rough rules are:
    achieve and why the changes were necessary (more on this in the
    accompanying SubmittingPatches document).
 
+ - A label "NEEDSWORK:" followed by description of the things to be
+   done is a way to leave in-code comments to document design
+   decisions yet to be made. 80% of the work to resolve a NEEDSWORK
+   comment is to decide if it still makes sense to do so, since the
+   situation around the codebase may have changed since the comment
+   was written.  It can be a very valid change to remove an existing
+   NEEDSWORK comment without doing anything else, with the commit log
+   message describing a good argument why it does not make sense to do
+   the thing the NEEDSWORK comment mentioned.
+
 Make your code readable and sensible, and don't try to be clever.
 
 As for more concrete guidelines, just imitate the existing code

Interdiff against v1:
  diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
  index b358d6bfb8..318829d4e4 100644
  --- a/Documentation/CodingGuidelines
  +++ b/Documentation/CodingGuidelines
  @@ -36,11 +36,12 @@ Git in general, a few rough rules are:
    - A label "NEEDSWORK:" followed by description of the things to be
      done is a way to leave in-code comments to document design
      decisions yet to be made. 80% of the work to resolve a NEEDSWORK
  -   comment is to decide if it makes sense to do so.  It can be a very
  -   valid change to remove an existing NEEDSWORK comment without doing
  -   anything else, with the commit log message describing a good
  -   argument why it does not make sense to do the thing the NEEDSWORK
  -   comment mentioned.
  +   comment is to decide if it still makes sense to do so, since the
  +   situation around the codebase may have changed since the comment
  +   was written.  It can be a very valid change to remove an existing
  +   NEEDSWORK comment without doing anything else, with the commit log
  +   message describing a good argument why it does not make sense to do
  +   the thing the NEEDSWORK comment mentioned.
   
   Make your code readable and sensible, and don't try to be clever.
   
-- 
2.53.0-248-g282ed54c8f


