Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE21D63EC
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965806; cv=none; b=gH+xNAtQm5KGPFq6xfchQahcyyQiMdHJWBvi3dvUfZa26hkgWwlucrVogT8kn1jpR49bOy51vYAtGv83FlXb0SqgHVs0/hUwdGQ7CqkjQe2Fu5MDmlmZXxqASJMZNRIxAKfyutmF7PpL5CU/sMsc7fjzNvHrmz5XD0qVTrQB5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965806; c=relaxed/simple;
	bh=wBULRedem7TGSs4qeWUkdXFjE9QnvmB2sn5NB/TyGmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5NJp8ju8f5nzVr72o7TyIvIUhhItBChJpIgL4v79tK2Iq59sLz/piDijFKBxNjnQQqpuTnCbKPdBTMdt/Qot+HLFzJQ5IHP9uvZIvl71B4GocVKZOeb4A345S44cRbFFphw+nrcWG4rWR9oLaQyZC9ozh5D4ZhH/beW9WzrQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yvWi91vy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MlhEU1vr; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yvWi91vy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MlhEU1vr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 308A3114013F;
	Wed, 15 Jan 2025 13:30:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jan 2025 13:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736965803; x=1737052203; bh=s3T0AtYrAi
	fLx+gUjgo8UrUP+1wpakzrx903OGf0ykY=; b=yvWi91vyKYk8PC4O76QMuOw8gM
	rpxXV9HnuvF8efe5DT75FAZ/Ziufy1F+aaE34Os0U1+J08u3ylb8/47JGRuBNDjp
	v1hJmjzZnlkAwwAixJah9LW3Dk9+Cx8Vqn0kENoU3vYYVl/1dy4lNrpB83hYenBK
	aBQd5IHZKb0vej+PQvWZgr5YNjjNWG3rOSbXN/AQmguFwchxNMn3/4AX2oGeiisz
	8JsYMbZfUXP1IZOkClOikc6jylnuYwJjZwENDqwdO3/BrjKdNwzSHkYtATSjDLme
	CMA/LFTScZfc66PTz1Zj749DFb+IWIQ361Yb/ZR8VmRAn92McDKR4wJrtskg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736965803; x=1737052203; bh=s3T0AtYrAifLx+gUjgo8UrUP+1wpakzrx90
	3OGf0ykY=; b=MlhEU1vrv5lgOYGE3hhg0LWqm5NZ549f0zGgTws5ZnLtPpHxAEM
	L2YP+73DUxkpAlrYFYp5Xu0deko0jrRrwWul1cz39nWBX3IsKjbT0Rtp+5gGP87q
	z/jkgevqt4g/NJ4tqiP28Z3QIHBz8q0r9ZJPo6OgtW+ThWCbw4WcCBhaGYFalNtq
	+ZN4Kc9OINTMi3WqtFi/ycYKEIUd6m5f/QBo7+hHYpWZMkuHEjIrKHpnMQhmJVKJ
	Iq0+IfToNUeau/s7jqj8QLFeGYJZK1tAa7uZ0lEGJfu9KEM9sfiaD+krIBQudHSP
	5AMY3FITli1hQpOo8vOhnDOxQG1VgTtd5+g==
X-ME-Sender: <xms:qv6HZ7h-B1Z6GfTfQn91Nh0LgA5chDGYeD0cnJg2yNjXVhLZtp2H3w>
    <xme:qv6HZ4BgoAb-IrTLnmdJ4gZoOkepKNzJ1DHEezHS9bvq3GF4OwCp9nymJwKpOuw2d
    qxr1FYTU7ynzn-k4Q>
X-ME-Received: <xmr:qv6HZ7FuXNb4RNhohlpVA7EY8v1N6kL9tin9k4YGn9W0LnDgdzyom2NOjWAx55zPzCvZjqwF_tibO8_FCcGk-XYS6pUUPKtK__DJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehmtggvphhlsegtvghplhdrvghupdhrtghpth
    htohepjhhonhgrshdrkhhonhhrrggusehunhhiqdhmuhgvnhhsthgvrhdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qv6HZ4ST3R7jM61SgOZ5roXy067DddK659YzJVQs2ePJy0--cU_kpg>
    <xmx:qv6HZ4wr1OhhP-7BEN3O9JA8y62KsJ_OMF92x6CxcmVaioFdwIkFhQ>
    <xmx:qv6HZ-7ubM-DEyPvP6O5bMvYXBHgLPyZWAVVmXfDd6RvLLjlzjyDzg>
    <xmx:qv6HZ9wgEUpUkM0L7QswVUHhgmaMlWlVIimoOcR4Zn_ZyDIfZZX7uA>
    <xmx:q_6HZ_kBsv14pxnjBmDCAiuK6VjWAC_M9wWrRxchRLCP6Vsbj8oPWyzA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 13:30:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <xmqqmsfsx8oo.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	15 Jan 2025 09:56:23 -0800")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
	<xmqqmsfsx8oo.fsf@gitster.g>
Date: Wed, 15 Jan 2025 10:29:59 -0800
Message-ID: <xmqqikqgx74o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> use that everywhere. Possibly it could even do the argc/argv check, too,
>> since every call site is going to be doing that itself.
>
> It would look something like this; I am not sure if I like the "this
> may show help and exit if the user requested, but otherwise it is a
> no-op" semantics, though.

After thinking about it a bit more, I am starting to like it, not
because it reduces a few more lines from the calling site, but
because it makes it almost impossible to use for a careless and
incorrect conversion from usage_with_options().  Any existing
callsite of usage_with_options() MUST be inspected to make sure it
is responding to an end-user request to give "-h"(elp) text before
being replaced with the call to a new helper, and if I made
show_usage_help() without argc/argv, a careless developer can easily
and blindly do string replacement to send a ton of patch that
reviewers need to waste time to do the inspection for them.

But with your "argc and argv checking included" approach, it is
harder to do the blind replacement.

--- >8 ---
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 15 Jan 2025 09:56:23 -0800
Subject: [PATCH] parse-options: add show_usage_help()

Many commands call usage_with_options() when they are asked to give
the help message, but it incorrectly sends the help text to the
standard error stream.  When the user asked for it with "git cmd -h",
the help message is the primary output from the command, hence we
should send it to the standard output stream.

Introduce a helper function that captures the common pattern

	if (argc == 2 && !strcmp(argv[1], "-h"))
		usage_with_options(usage, options);

and replaces it with

	show_usage_help(argc, argv, usage, options);

to help correct code paths (there are 40 or so of them).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 10 ++++++++++
 parse-options.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 33bfba0ed4..4b00065692 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1282,6 +1282,16 @@ void NORETURN usage_with_options(const char * const *usagestr,
 	exit(129);
 }
 
+void show_usage_help(int ac, const char **av,
+		     const char * const *usagestr,
+		     const struct option *opts)
+{
+	if (ac == 2 && !strcmp(av[1], "-h")) {
+		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+		exit(0);
+	}
+}
+
 void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
diff --git a/parse-options.h b/parse-options.h
index d01361ca97..f93f13434c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -402,6 +402,10 @@ int parse_options(int argc, const char **argv, const char *prefix,
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
+void show_usage_help(int, const char **,
+		     const char * const *usagestr,
+		     const struct option *options);
+
 NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
-- 
2.48.1-187-gd93ffc6ef3

