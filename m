Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA41CB321
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807818; cv=none; b=Vn2ZORAxznD6hKA+6/kid0Q8qGzzPmH2i+kEgQYs13R2GGAG2m8rtsbOiVnO9/Y6rnRTTAoBqtpwuYgo8jsE1FJ9FTbtJhzQD9GqLAEEn/pgmqtHuHiaW69S3fzKzP/QdowI9sxiS0T3BbnO+jrffVKleeyrAcxmk0oXXxcEB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807818; c=relaxed/simple;
	bh=hnjFEU8pjMEVYQNhGo1AMScQJHS4NOYkep1BCOV8Oy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/HaYfoBd6S6CEvw2Y2IL0dXUBG9it/1efE4T0pA9PkMle/Eynus+5mnIl9LmIgwu8GSlXol0FKXZhJWWlD36cpFyy+t7x2xiT3Lgl9z4aRQDvwcyOCYmoPd6+j6hfxMyQdeC+hBty6xmUijnwFEkumGSqCbWSWztQ9tJe7H1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q3yej293; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F89hbic9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q3yej293";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F89hbic9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D077C1140BB9;
	Tue,  1 Oct 2024 14:36:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 01 Oct 2024 14:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727807814;
	 x=1727894214; bh=WkvF6AJQiNaG39Gnd5xydUoR9coRd4PAjKUrNx3ol/Q=; b=
	Q3yej293WXaAbPAexFyuLUfUVCEOhqMgUy3H0x8eAvrcpWpbsIlKyeO9F3r0JBTL
	0cNCtCx6y+iDp6eOACFmHr7HJcn3ZLhB3vc6lCpHWlpF69Paq6/L3x8ySgZr6iAN
	hnLvSFj7gk0LFRkldbhlyrgze+9bDod7xtgWWvB2J2VMzqJiGZMVgyBQWH2MIcHX
	khQ3Z02xEU1JAVcEOGJFPBrBLtFN01vRftWd8ynLD6aXpKHBA7PVruMzT4SX8+q2
	pL4/GPBciBA3YHXYCrP5Vol2B9+Fz9a48QwtyQB1H7VGiabd09ce6cgs5lWyOfY6
	9n9EuDafAM4cKHYst/PUXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727807814; x=
	1727894214; bh=WkvF6AJQiNaG39Gnd5xydUoR9coRd4PAjKUrNx3ol/Q=; b=F
	89hbic98Nr6eGhngWGD0qE4D596vuQ75GTdGn/sL/UocBWaa2TQxjXkS+PDeNKRx
	1fVOS210ig0JHizu/MyBniSHFtz4Pq6qFdxuVsmUg/flNL/or3PfDqWXgyr1ud+T
	jRWU8HNets/JGe5FeSOXIPTr5bAPtaf98F4uGzKLTsiDwBhqCnJjlE+DGn45MrOH
	9YQmnNkdIH5mGbQadgOSVBAViXOE3+jSAj8/D/1hxYc7xixAlBMP/jNkWXhgg0CS
	JL3Z04okr7g1gdo0zxxhQENOfIi97pb1R5tnFMcwaOC7PL5dSKyJa8EbYimvZAJA
	tR5597vOXhO5GtIharFEw==
X-ME-Sender: <xms:RkH8ZiAo-tt7297OU955OJ3KRf-Jx9pJ5akzZ5CDlE2BYoyLvw4mtA>
    <xme:RkH8ZsjxBW_C2Hdr9KjA1U7XhsFagGHYvHLYPrlhqp8yDDpjPCbwt59c9YbjGsn1G
    OcS3aU-94CmcaBuYA>
X-ME-Received: <xmr:RkH8Zln6gejKIQPhMTd6c59_6_pic34HCAZGh669dwXSrI5_peGUSc54WRQ0noCG1LsYWXhec4ZxQIlhhRosNPzrpVKHggA2pnM4K0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmohhnihhkrgeskhhisghithdrlhhtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RkH8Zgz6MgMv3Ir3Ug6-on-4u06tpyofK5knSROK6kHQVuMUgIh5ow>
    <xmx:RkH8ZnQDr1AU1yK6dl2w8_Y4z7wK4RWr6MkRLgW3EGoQygADICMqSA>
    <xmx:RkH8ZrZMdd_2Dc8oELOTc8pfkqizxRqIKZP9cKcKuSYelRX3KB3Wnw>
    <xmx:RkH8ZgS_QoZTXBzw0YV6E6SdWvdBl8gNL0RPLRHbwMYqVe9TuAEaVA>
    <xmx:RkH8ZlOqwy_ojenyh3MHvWQW9w-w2LulpmBceOr4ATNzODcXPOSjlyMO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 14:36:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Monika_Kairaityt=C4=97_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Monika =?utf-8?Q?Kairaityt=C4=97?=
 <monika@kibit.lt>
Subject: Re: [PATCH] documentation: add missing word "ref"
In-Reply-To: <pull.1803.git.1727623027242.gitgitgadget@gmail.com> ("Monika
	=?utf-8?Q?Kairaityt=C4=97?= via GitGitGadget"'s message of "Sun, 29 Sep
 2024 15:17:07
	+0000")
References: <pull.1803.git.1727623027242.gitgitgadget@gmail.com>
Date: Tue, 01 Oct 2024 11:36:52 -0700
Message-ID: <xmqqy137wtyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Monika Kairaitytė via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> When explaining about "the destination ref <dst>", word
> "ref" is included. Logically, it should be the same in the explanation
> of "the source <src>".

"Logically", if <src> and <dst> followed the same rules, but
otherwise, it is not a logical conclusion.

What makes me hesitate with this change is the following.

 - In "+refs/heads/*:refs/remotes/origin/*", <src> is "refs/heads/*"
   and <dst> is "refs/tags/*".  Neither is a ref.  So it could be
   argued that saying "ref" before <dst> is what is wrong in the
   current text, and adding "ref" before <src> makes it doubly
   wrong.

 - In addition, <src> can be a fully spelled object name, to fetch
   just a single object.  In such a case, it does not even remotely
   resemble a ref.

How about this text instead?  Would it solve the problem, i.e. 

> In the git-fetch documentation, description of <refspec> syntax is not
> entirely clear.

Thanks.

------- >8 -------
Subject: doc: clarify <src> in refspec syntax

We explicitly avoid saying "ref <src>" when introducing the source
side of a refspec, because it can be a fully-spelled hexadecimal
object name, and it also can be a pattern that is not quite a "ref".

But we are loose when we introduce <dst> and say "ref <dst>", even
though it can also be a pattern.  Let's omit "ref" also from the
destination side.

Clarify that <src> can be a ref, a (limited glob) pattern, or an
object name.

Even though the very original design of refspec expected that '*'
was used only at the end (e.g., "refs/heads/*" was expected, but not
"refs/heads/*-wip"), the code and its use evolved to handle a single
'*' anywhere in the pattern.  Update the text to remove the mention
of "the same prefix".  Anything that matches the pattern are named
by such a (limited glob) pattern in <src>.

Also put a bit more stress on the fact that we accept only one '*'
in the pattern by saying "one and only one `*`".

Helped-by: Monika Kairaitytė <monika@kibit.lt>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git c/Documentation/pull-fetch-param.txt w/Documentation/pull-fetch-param.txt
index c718f7946f..d79d2f6065 100644
--- c/Documentation/pull-fetch-param.txt
+++ w/Documentation/pull-fetch-param.txt
@@ -25,14 +25,15 @@ endif::git-pull[]
 +
 The format of a <refspec> parameter is an optional plus
 `+`, followed by the source <src>, followed
-by a colon `:`, followed by the destination ref <dst>.
+by a colon `:`, followed by the destination <dst>.
 The colon can be omitted when <dst> is empty.  <src> is
-typically a ref, but it can also be a fully spelled hex object
+typically a ref, or a glob pattern with a single `*` that is used
+to match a set of refs, but it can also be a fully spelled hex object
 name.
 +
 A <refspec> may contain a `*` in its <src> to indicate a simple pattern
 match. Such a refspec functions like a glob that matches any ref with the
-same prefix. A pattern <refspec> must have a `*` in both the <src> and
+pattern. A pattern <refspec> must have one and only one `*` in both the <src> and
 <dst>. It will map refs to the destination by replacing the `*` with the
 contents matched from the source.
 +
