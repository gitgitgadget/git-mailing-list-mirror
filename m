Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E182F49F8
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269307; cv=none; b=Hv4vhIrY8hgQOzLDmxKGLcjqxkYZ/RT7bG3P5/1HS4q/V9wkEwsim7WgOm+kyXDUnyy01E981x0p1Oz+QiFRkCZqH4fUhhkho8d9DGfUEknAkEh7E1GBxlCGkvFijji5tnaSd1DHzPUFWcITbA4uLFKy3CCrX0vSMx6eYiZr1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269307; c=relaxed/simple;
	bh=MHKnI1n84rRYOEDu/0lIt0y1jSUDboK+eAsBkap28+E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgT9eQiIdXWLQ5jWOCeTK14fFQWKiN4Vesu6qS0C4rOXMm3yRMJMa7VKtybWDekpt+2g3pOhVAZ2qQgi0RVWBzpkI7PVQ4KzgdZUupGdKK0/+tiMdohtxB3kYGQixXjkwFPZ8IklynazLrf2OACvsp/ZpQ5h4e0vwqL8vDkEDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UdOnUinJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=meg2lD8U; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UdOnUinJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="meg2lD8U"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 11983254022A;
	Wed, 18 Jun 2025 13:55:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 18 Jun 2025 13:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1750269303; x=1750355703; bh=lHHuv6A+MTmEmhVuf1kvYf1uh5EiJGBi
	kalZyWsSmw0=; b=UdOnUinJc8bEdOmNieCs3ahN+Drn6zn5HtzmqThMUMUabi16
	ynt9DI9QolLv+HmdJzbKRAbri3dOeiA1rJL6BkzENFH2it2yhotGc2GstusdyacA
	jtxb9tFY8p0dv3VRiHxz1GVTmpwWAk2QAaqYRnZ+TKDJ159Md1BsAmpniqVGswrJ
	pGfFJv0eMVKOAaB3gCRbTD+kDHMvax0dwjLp9w58y42fTd6oZxQedu/rCEDdyaGt
	jqYS9ocqOf7Z8pNB+rpqc7KlkB65eYAW++i2acp1Qh+iTZY3XZjWf3HQXF+wGltp
	IhYpNlN6x2Rp9n8OHKmMY3hYeWpVEfvVfDvO3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750269303; x=
	1750355703; bh=lHHuv6A+MTmEmhVuf1kvYf1uh5EiJGBikalZyWsSmw0=; b=m
	eg2lD8UFrzIjYVD6wxvkET8KabWYj2G1oTqNS4U6TdoyDdU4c25I5iPlY5xWaMpR
	MXzyi/934DckitsjnC+bjswoMaCxf97MEdS6g9iTbRm+2WXr6PGMLBPq2WRCIQA/
	qKE6IY03BH34d/afMu3upxDugm8JzW/x1BF0ZckOx8/d+lKJ6+dkBuXeJYeCTglK
	Y5u73dEydYMPZpeCXdG+iqLMfDxUehlr4XHx1Lyn6TNgAhflbXkm1z/Yoq2JfUvv
	uixjNAH8qK8XqwfO1Y5r9XO/9olTXNDKUBmN2BLq4F0ebewX1ex93jtk/NhIADub
	y94Z8wrInPAnX91XmYN2g==
X-ME-Sender: <xms:d_1SaMTK95LOr0ndltLzW4180P86KrglTrGciVHGvxtKsba6vMQCow>
    <xme:d_1SaJyJU2A_WFPVUbg3-Hlc5KUVcp5Iu0gJBjSzuBLLZ9ZHyOgU1CCjSTEHniLbd
    XxOzt0se_pgCjijjw>
X-ME-Received: <xmr:d_1SaJ0XZCwY8m6nbhKb4UeO3IRRTDE71t5L-LYUIJegBOp2cS0OpM-hSltn-1IWo__OVzl7cD216HB9vkT0RQ5LevZS7Fb2yOps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieegieekfe
    evkeejudeggefgveettddulefhudduffdvuedutdeffefghfehleetnecuffhomhgrihhn
    pehotggrmhhlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d_1SaACIdAOuWwAvsykHsNz0hpF2JEfhBG4jTrdGbCeHhZA6X8XOqA>
    <xmx:d_1SaFisEcc5BjyOV6-cAx9XIfgV4896Q5y2UC1vjVVnVcocTMsAHQ>
    <xmx:d_1SaMoNZFUfoz97A6qpq_nRUKAdD8g0zyTIMOjZiwj9rboKxSunUg>
    <xmx:d_1SaIjs0pQkAj3ODlQJhqdXEQjiSeeEa0mFxOJ-G1cz5B9ZePl3GA>
    <xmx:d_1SaASXHVYWT9Z4ZBEMmZ1bMTbZPS3H4DqoFU4zDng4lDHCYf4WjQGL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 13:55:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] cocci: matching (multiple) identifiers
Date: Wed, 18 Jun 2025 10:55:02 -0700
Message-ID: <xmqqbjqlexzd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"make coccicheck" seems to work OK at GitHub CI using

    $ spatch --version
    spatch version 1.1.1 compiled with OCaml version 4.13.1
    OCaml scripting support: yes
    Python scripting support: yes
    Syntax of regular expressions: PCRE

but not with 

    $ spatch --version
    spatch version 1.3 compiled with OCaml version 5.3.0
    OCaml scripting support: yes
    Python scripting support: yes
    Syntax of regular expressions: Str

Judging from https://ocaml.org/manual/5.3/api/Str.html, I suspect
that this probably is caused by the distinction between BRE vs PCRE.
As there is no reasonably clean way to write the multiple choice
matches portably between these two pattern languages, let's stop
using regexp_constraint and use compare_constraint instead when
listing the function names to exclude.

There are other uses of "!~" but they all want to match a single
simple token, that should work fine either with BRE or PCRE.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/commit.cocci | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/contrib/coccinelle/commit.cocci w/contrib/coccinelle/commit.cocci
index af6dd4c20c..c5284604c5 100644
--- c/contrib/coccinelle/commit.cocci
+++ w/contrib/coccinelle/commit.cocci
@@ -25,7 +25,8 @@ expression s;
 // functions, then the recommended transformation will be bogus with
 // repo_get_commit_tree() on the LHS.
 @@
-identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|set_commit_tree)$";
+identifier f != { repo_get_commit_tree, get_commit_tree_in_graph_one,
+		  load_tree_for_commit, set_commit_tree };
 expression c;
 @@
   f(...) {<...
