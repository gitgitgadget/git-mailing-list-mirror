Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C871AD3E0
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742767692; cv=none; b=calIRxupP2QV0ql1yPzvB+SJURV2p7V9WcMMMMQ0yl9SmwKxPNHpeiZBZW5yP9I65pEOHb24FttKjNM9JCZqJAslmvxUQ2+EH8pZDokk9wnnyste7ln51mq4Yx79vGqap137Bca4slc5b0EuZ1ppI4i9cG6hUYEUa04Eu7TyXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742767692; c=relaxed/simple;
	bh=Z6y6ho0v63qanTnz7QelsmifVT/gMvTGBCwIVpMUiWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kuCyD8e35NiUm7UL4xQfOp9nVuvnRKTm5PuizYdDGTIO6TzsKycYZDPNsQnsOhAY1ci87/iBHAtRXwrME1D4WHbZbNnsOuJJQRXfrNttX+Qkc/sIW1SDsfO2n1fkfokldXj2EI2r5TESg2Hm6IJoCEsuTmQgxosS0e5+YIZ1ShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DK9yXxzT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZKYoTBUz; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DK9yXxzT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZKYoTBUz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CB20114008C;
	Sun, 23 Mar 2025 18:08:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 23 Mar 2025 18:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742767689; x=1742854089; bh=lNZ5QtpsfM
	bQzJSrW5bNpgQYZKx5Se9gCO44kX6nx7k=; b=DK9yXxzTV2hxBe2m7w7VanrvAh
	ftgIdVPzxlOcvX9yuhme+KTqqTAQSv0GT2o0qo837Pxrw4CrbI3D31KaVEfIKpyS
	1yt0l29vu1oulTg+C4GBbfPIphaHBIu7LclIbo8r6SUaYYGtjqIik+5F0mOoNUOw
	1NLMY4llqa/aYBrafjoJ3wVNjtEVPoTS7X/0VhwXJNtsRHvO+1zFCScmIDRMY5Bd
	8dTnjSHkGvjMTb7cpGIyUMqpzV9rM7NY0pGIZbQh1nRKT0aDh5RWRTXjeEINcdJ9
	PJ3Le67B7Rc5ox7KJ1Q24JK4dNUHkZpKDnmq/nGd9lh60rzOYU7hNJcOUHgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742767689; x=1742854089; bh=lNZ5QtpsfMbQzJSrW5bNpgQYZKx5Se9gCO4
	4kX6nx7k=; b=ZKYoTBUz5ADENb7/GNmMG0Ibm+9vv/vNltNX6rwk1/YzHx/ZvXP
	3L6vVaQ0j65x53ckZidLbVVgs13jWcMXQn4e3pbNBafTTqbMRXVxYNegA5Y6qQGM
	sUTwb/1e3Mk3GqT3zJKoDe+Lnnp2zdCYlqy8xJ4aev5Em3lrEUgL+L4964QtrS6J
	8+nOQOFG9FsrQo6vGFmhyoxAfbKuzZ9H9kzkFtVCWYqSQe9JqsPyUAFPxqem8cZO
	OyFaBWm8TACFFXbq5KBv/38sBHBPJNpHpPH/MKQnoYgUV8SU5lTfasZkzbiajUrH
	cf4oTc7npmpGCKhFA8zsiPaeta3+AoGO7zQ==
X-ME-Sender: <xms:SYbgZ9pndji2Kagv5Fg_QbZJQpglqXRxWkIuOw7Cv1rEnV0yG2vcoA>
    <xme:SYbgZ_ovpnwDkZE8yfOHJvpkVm6DlhKFQl8vaDaa83o2ka-H-0Smkx73j6wL9CXwe
    P_rCHN_kjKfZW48SQ>
X-ME-Received: <xmr:SYbgZ6NhtV8PDrZB1ZMpa8M-cjwRTbMpOUr7v5fNmmdUI7Jk9RdUPrcRVDmX3kxwv_znjfUcgq_gmge5kUmqfdRURzdUoU7XbOnImlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:SYbgZ45wGldaZTL5zncpGf3UE0krFvmYw-wcVUo6Qm9vzpqQ-fLwxQ>
    <xmx:SYbgZ85EjfpzKn4GY-E_1hI9BnZi_xvmiTsb4LSROhJFziRihcuvIQ>
    <xmx:SYbgZwj8xSxo0SnHAfWj3J5FxWd6e9-qPNVoIeuRP9YifEltjdz2Vg>
    <xmx:SYbgZ-4Quar9jB2UgmX3zJnSVzsDFWAvm1iXwifixyfmXQK0DHsSZQ>
    <xmx:SYbgZ32PtoyZ9X-o3y1gAZ3NMoRns3vYpEnpg-q-JSwK06HqbaaMJRjV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 18:08:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com
Subject: Re: [[GSOC][PATCH v3] 2/3] docs: update function signature, add
 UNUSED macro
In-Reply-To: <20250321143022.5406-2-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 21 Mar 2025 20:00:21 +0530")
References: <xmqqa59evffd.fsf@gitster.g>
	<20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
	<20250321143022.5406-2-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 23 Mar 2025 15:08:08 -0700
Message-ID: <xmqqcye7qu2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Modify function signatures to include struct repository
> for better compatibility. Also update builtin.h
> accordingly and use UNUSED to prevent warnings.

You want to be a bit stronger than "better compatibility" here
(besides, it is unclear what you are trying to be compatible).


    Since 9b1cb507 (builtin: add a repository parameter for builtin
    functions, 2024-09-13), a built-in implementation like cmd_psuh
    is called with a pointer to a "struct repository"; adjust the
    examples to match the current practice.

or something, perhaps?

> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 7b856be41e..45efe117ab 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -142,9 +142,13 @@ followed by the name of the subcommand, in a source file named after the
>  subcommand and contained within `builtin/`. So it makes sense to implement your
>  command in `builtin/psuh.c`. Create that file, and within it, write the entry
>  point for your command in a function matching the style and signature:
> -
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix)
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
> +----
> +Before proceeding further, we should use the UNUSED macro to suppress warnings about unused parameters in the function.
> +This prevents the compiler from generating warnings when certain parameters are not used within the function body:
> +----
> +int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
>  ----
>  
>  We'll also need to add the declaration of psuh; open up `builtin.h`, find the
> @@ -152,7 +156,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
>  in order to keep the declarations alphabetically sorted:
>  
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix);
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
>  ----
>  
>  Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
> @@ -168,7 +172,7 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
>  should also do so when writing your user-facing commands in the future.
>  
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix)
> +int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
>  {
>  	printf(_("Pony saying hello goes here.\n"));
>  	return 0;
> @@ -199,6 +203,9 @@ with the command name, a function pointer to the command implementation, and a
>  setup option flag. For now, let's keep mimicking `push`. Find the line where
>  `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
>  line in alphabetical order (immediately before `cmd_pull`).
> +----
> +{ "psuh", cmd_psuh, RUN_SETUP}
> +----
>  
>  The options are documented in `builtin.h` under "Adding a new built-in." Since
>  we hope to print some data about the user's current workspace context later,
> @@ -285,6 +292,8 @@ Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
>  existing `printf()` calls in place:
>  
>  ----
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
> +{
>  	int i;
>  
>  	...
> @@ -298,7 +307,8 @@ existing `printf()` calls in place:
>  
>  	printf(_("Your current working directory:\n<top-level>%s%s\n"),
>  	       prefix ? "/" : "", prefix ? prefix : "");
> -
> +	...
> +}
>  ----
>  
>  Build and try it. As you may expect, there's pretty much just whatever we give
