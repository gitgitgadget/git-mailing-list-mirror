Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017A333436
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769947477; cv=none; b=FvQvCOD+7etnQ30W9V8E6YfNgdkus7fjHNnRAzt0tGCF8MwqIioL7WCBs7xN7yehwmAbFOpHpG1vjdep0xXyH40YdkMerBgJZl6VFN0S+W7lbFUCNgtGt059x/+KV1TpoNY1tA/nr8ljH/GtNNd9z+LJI8ULCoX0BcrTqUbTU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769947477; c=relaxed/simple;
	bh=FMTG3UZXZXMmnkM1GwZjgGJGSNbl0ZStg22MIEL0cU0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fRKVmBBFcNVlA3yiKGmdgNkKIXs44gq+rT0k6yjtbcM/sJnKSh8AD2GI0HzObTFevVYmBc9ae8JOcCGapUGBZ10C5beFxGMrso4qVaNfd9WTbRDXLIHtSyRXttKVszMgUUlgvE77D+kAMDNgOg/6dDm3XhjooSujOXFQ9eMwz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SxrzIWkq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dK3Yj6kH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SxrzIWkq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dK3Yj6kH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85FA3140003C;
	Sun,  1 Feb 2026 07:04:34 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 01 Feb 2026 07:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769947474;
	 x=1770033874; bh=h9lqTgeFUIvBTffJDkHHE5dbfzvPUAvIq30BbdzAbQI=; b=
	SxrzIWkqJ4uF5421MptldadPhIC9/CBbGkFXm9PmG/MNdqDGpFBizq0YR4rYNtf2
	D8xaXYXAQyQxBXSEky4ZTkQ3gs3eCnUHqPxQIm1e0SEDKj0r/RrDIh6ZTz3uvJKO
	4801iQxMIUz69bGb+L0idHAQaTxjw52M38UtrbOYOY5FoICk/STfcVjkaAQ59LZb
	Tel/OIeZmKrOLao0KlseL6W9S9yhagTn3b2n4M3+vGWJU30m8G2CiWyfUl5fApl5
	Uv5kkwpWLAT4JgX8moOBpMlPMTS22x//atd7jlGTiufisXgBpUYmdtntgiBCQXAQ
	Q1ULcJ2xA9wKQM2FgiWIKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769947474; x=
	1770033874; bh=h9lqTgeFUIvBTffJDkHHE5dbfzvPUAvIq30BbdzAbQI=; b=d
	K3Yj6kHjvbpLw/rLlAECc29Yrz6b6NF+x6H5mTSPKKbjhHYzktATaCr3Sr6tW6KW
	+xtuLI8gnlzFbsk1VpOROLDJFQcTsV8ZCm151QD4IXsfDGUpy2vX3e19VoCAN4tN
	x3iynd2QeDx3gKjtF7xgGTKD4cXUbLsTMujeAm/lYRXgUP/P2oqrirneNuJIrFiv
	P1/lF6hmDkoQmE2WJcyVzmBj0uUQiSlCSZhrHNKsJFhd+63yzkoLAeM7WkhnWzPQ
	t6GX6/TFP2jbhBta/I0W5aYG/DhqT9+thS6hdMOQi7NsI9qj50Vu3ZHUWGDnABh8
	Y27dDHt0GMxVYwXXBQl9g==
X-ME-Sender: <xms:UkF_adqnDuVGgJFvqY95yMSw-fvskF17y9zY8P9s6oWXm4FaZ1qPQr4>
    <xme:UkF_aacnklZE96XZotsAjd6VyOzole2GVffYGydaOS-52WDRft4X4UIY-pNH6Afna
    kpn2CgTqgYXRfa0Fcz_rB6VdjoY-cF8Os3p7juaLQIxFUYXXJIR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UkF_aeE8Z_-f0q9cuM0hcpCxnRrY25MPqQq-9j5L5vsBO2CtAiRs_g>
    <xmx:UkF_aXGV3aXYdgpATndXHb1XvQDkKeXaVUD4ZbIlfGD14M5aotBmEQ>
    <xmx:UkF_abOiKeCckD_lHmdF3911q5aZhASw12kI1zrDYjsENHz2e3NDQQ>
    <xmx:UkF_aWGZfBurN9NbOU47WCGDK2CuvccpMRbUjKVUN4sGR9WRGPTJcQ>
    <xmx:UkF_abh5IRgN4z2eqKTt-uSwzRPRTcR0HfkD-wEVNjT0KMvfoTG_XMn5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 63B751EA006B; Sun,  1 Feb 2026 07:04:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-_DlS5lSLTB
Date: Sun, 01 Feb 2026 13:04:13 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <6f7d027e-088a-4d66-92af-b8d1c32d730c@app.fastmail.com>
In-Reply-To: 
 <3a5b642d05b9fcafb684631a0026959bfc362d2b.1769202903.git.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <3a5b642d05b9fcafb684631a0026959bfc362d2b.1769202903.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 2/4] doc: finalize git-clone documentation conversion to synopsis
 style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026, at 22:15, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Use backticks where appropriate for command-line options
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/git-clone.adoc | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.ad=
oc
> index 57cdfb7620..7a0e147384 100644
> --- a/Documentation/git-clone.adoc
> +++ b/Documentation/git-clone.adoc
> @@ -152,7 +152,7 @@ objects from the source repository into a pack in
> the cloned repository.
>  	unknown ones, is server-specific.
>  	When multiple `--server-option=3D<option>` are given, they are all
>  	sent to the other side in the order listed on the command line.
> -	When no ++--server-option=3D++__<option>__ is given from the command
> +	When no `--server-option=3D<option>` is given from the command

Just using backticks now that `synopsis` style handles placeholder
rendering. Makes sense.

>  	line, the values of configuration variable
> `remote.<name>.serverOption`
>  	are used instead.
>
> @@ -206,14 +206,14 @@ objects from the source repository into a pack in
> the cloned repository.
>  	that all these refs are overwritten by a `git remote update` in the
>  	target repository.
>
> -`-o` _<name>_::
> -`--origin` _<name>_::
> +`-o <name>`::
> +`--origin <name>`::
>  	Instead of using the remote name `origin` to keep track of the upstr=
eam
>  	repository, use _<name>_.  Overrides `clone.defaultRemoteName` from =
the
>  	config.

Doesn=E2=80=99t need to be done now in this series, but the =E2=80=9Cstu=
ck form=E2=80=9D of
`--origin=3D<name>` is recommended by gitcli(7) for long optoins. This d=
oc
uses a mix of unstuck form (no `=3D`) and stuck form.

>
> -`-b` _<name>_::
> -`--branch` _<name>_::
> +`-b <name>`::
> +`--branch <name>`::
>  	Instead of pointing the newly created `HEAD` to the branch pointed
>  	to by the cloned repository's `HEAD`, point to _<name>_ branch
>  	instead. In a non-bare repository, this is the branch that will
> @@ -230,8 +230,8 @@ objects from the source repository into a pack in
> the cloned repository.
>  	name.
>  	This option is incompatible with `--branch` and `--mirror`.
>
> -`-u` _<upload-pack>_::
> -`--upload-pack` _<upload-pack>_::
> +`-u <upload-pack>`::
> +`--upload-pack <upload-pack>`::
>  	When given, and the repository to clone from is accessed
>  	via ssh, this specifies a non-default path for the command
>  	run on the other end.
> @@ -240,8 +240,8 @@ objects from the source repository into a pack in
> the cloned repository.
>  	Specify the directory from which templates will be used;
>  	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)

Looks good. Just same comments.

>
> -`-c` `<key>=3D<value>`::
> -`--config` `<key>=3D<value>`::
> +`-c <key>=3D<value>`::
> +`--config <key>=3D<value>`::
>  	Set a configuration variable in the newly-created repository;
>  	this takes effect immediately after the repository is
>  	initialized, but before the remote history is fetched or any

I was curious if you can use `--config=3D<key>=3D<value>` without trippi=
ng
up the option parser. And you can:

    git clone --config=3Dcore.editor=3Dsomething ...

> @@ -339,8 +339,8 @@ Specify the given ref storage format for the
> repository. The valid values are:
>  +
>  include::ref-storage-format.adoc[]
>
> -`-j` _<n>_::
> -`--jobs` _<n>_::
> +`-j <n>`::
> +`--jobs <n>`::
>  	The number of submodules fetched at the same time.
>  	Defaults to the `submodule.fetchJobs` option.
>

Good.

> --
> gitgitgadget
