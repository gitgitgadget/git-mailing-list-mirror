Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237729B20D
	for <git@vger.kernel.org>; Sun, 21 Dec 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766337203; cv=none; b=jBmDxoIX+wugKzzTa5ZzKMVb44DsyfMz1Y3mhphwwcEbdiJaQUbTwH76b3TOSbc+9VH8TvoLFXGXC7FjS1F6y9eEhCODQp3swUYT12NAAkwXHMLWIpKHLJygVgLDykgL4JxMVZBuOC9egixIXv69o9AEfuhUGNynFZwaTUZnnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766337203; c=relaxed/simple;
	bh=hpu7zKnv176sizdD5LB7JXCKABvvlEAk8T3OaKdUXwg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OrdP2yMJQP9TQThpZjeCMlOPvtmwIHFibr+1aPNsiilx+9qwhPinqyouYsEx6LKnspf3sinYVQjy1OrfjhGS2vTQO6G49qgyBqIuZr1T4KTk7lNkxCKBupoIy3ERU0iASbUqdnYHqJoqlmBDH7IghcRt7TYs4L6PucM57HEsdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jatIHRYT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lu3TrjTw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jatIHRYT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lu3TrjTw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D7731D0003F;
	Sun, 21 Dec 2025 12:13:20 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 21 Dec 2025 12:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766337200;
	 x=1766423600; bh=ROYGIF2U6FqXAQAKyES2U+LwS0mTDhrYqYCnqDDlqnw=; b=
	jatIHRYTIn7qmlGcT6n4iipBNtzKv8JW5xT/h2fI6NzuyPL4lnR9K4Y7E6t07qbe
	j4koOQMZ9PtgPbos6Vh4y2vGgbGJuYHpzoGh5+yK4xIiKbppLWJn2Cx12mw0dEln
	75G0X/CTWLYSpC/ldw4h3W7b3vNUFS0dw05INGOoWz/c8rPeDF6X78JHYSasqRLF
	s9I9ovfPruEi9W0Q3KX7tykjsVTjy8TR0UdrfNbPT95BakHAQ10ipC1TlWtEDqgz
	KNMH7uyg2f/5EHz4zH6TIpc/2HDUiFPUfR7z3Am2Xu3sI4e7YxWVIxLUqr+fsSOP
	zinuo3hw4T9Z4yXsvGrfXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766337200; x=
	1766423600; bh=ROYGIF2U6FqXAQAKyES2U+LwS0mTDhrYqYCnqDDlqnw=; b=L
	u3TrjTwJatar2hJd0ODHwLF+vvr+ZNWFyAxPbdoyaJMBCRt7HzmPxdi97v+I7OfX
	M0s8B5bcuhaszplVTW23CjJ4bJ39EjcmuZqKzxoHd+Ig3pqiDbTCsMMhWE+1JCbi
	PE0Tj7EHLryrWoHPRTYeW9ALxwfyXX58CLi9pPQhzl4l+MXbclwimPoKFiPyBgqV
	Fq5pM6XHcIwAXx0binGh8Av60aV0y3Oc6BGXxk5c0idGJmMXfcv5L/Kf3lFKejky
	uOYZwIKDysdz467gllB8SDluddCIJCHYFKgKwWzaISkJFbR5YAK1i2ieHPEv4FnN
	7BnW0aXN2fzjmU6a7EvUg==
X-ME-Sender: <xms:sCpIaYrtKpbRR5_3c1hXH7F7T5YhDa507Y1W3MtnpVXpargU9v4SzN4>
    <xme:sCpIaZfzdwQYX7M9dGtBWjxABsozIuJjIQL3Hh3Ij9FRit0Wn6wD_mjLjkmmNfqdD
    bF0EjIYrNBpKKi87mUlsF70rQXL3y2lZyWc1DrpzbGSgDb8hLHjkrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeetgfevtefgleeh
    hffhfedvueehudefueefjeffkeffgfeutddtgedugeffgefggeenucffohhmrghinhepih
    gvthhfrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:sCpIaRFB4-7FNVeIxjMcDXWYc0i5HvqOurTAaUxXqLzGHBzr2ZcrNA>
    <xmx:sCpIaeF9roWK-z5gnGvaoU4RIWcNzm3SeVcWJKAmg_CHAG0pbEfQXA>
    <xmx:sCpIaWM6MUTRqAv5l7jd1133KRjpW4srNeFYRoVuHNBF2HrVosyrqA>
    <xmx:sCpIaVFPQPtO_SRPgac1eHYD9rtt_qF3m3Jtp_YvzENEiI3hpQelSQ>
    <xmx:sCpIaWiyhIzYGIauBUmrwc2FO_WG8mcyLjEsj-zb0BzQzNIHvDGDE0Z->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A4F21EA0066; Sun, 21 Dec 2025 12:13:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7cBr0QabPqZ
Date: Sun, 21 Dec 2025 18:12:59 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <2e6759b7-73b3-4098-a0d8-2dfa1b7a3c44@app.fastmail.com>
In-Reply-To: <pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
 <pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/2] doc: flock of small fixes to various documentation files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025, at 19:54, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> This second version only splits the changes in two commits, one addres=
sing
> asciidoc markup, the other fixing basic style issues.
>[snip]
> Range-diff vs v1:
>
>  -:  ---------- > 1:  31694ab9d3 doc: fix asciidoc markup issues in=20
> several files
>  1:  b88126ef60 ! 2:  a3a76d448a doc: flock of small fixes to various=20
> documentation files
>      @@ Metadata
>       Author: Jean-No=C3=ABl Avila <jn.avila@free.fr>
>     =20
>        ## Commit message ##
>      -    doc: flock of small fixes to various documentation files
>      +    doc: correct minor wording issues
>     =20
>      -    While translating the Git documentation into French, I=20
> noticed several small
>      -    issues in various files. This commit addresses these issues=20
> to improve the
>      -    overall quality and consistency of the documentation.
>      -
>      -     * enforce consistent imperative mood in option descriptions
>      -     * lighten wording in several places for clarity
>      -     * add missing parameters
>      -     * fix minor asciidoc markup issues
>      +    * use imperative mood for consistency in options descriptions
>      +    * add missing parenthesis
>      +    * reword verbose phrase in git-repack.adoc
>     =20
>           Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
>     =20
>      - ## Documentation/git-checkout.adoc ##
>      -@@ Documentation/git-checkout.adoc: ARGUMENT DISAMBIGUATION
>      - -----------------------
>      -=20
>      - When you run `git checkout <something>`, Git tries to guess=20
> whether
>      --`<something>` is intended to be a branch, a commit, or a set of=20
> file(s),
>      -+_<something>_ is intended to be a branch, a commit, or a set of=20
> file(s),
>      - and then either switches to that branch or commit, or restores=20
> the
>      - specified files.
>      -=20
>      -
>        ## Documentation/git-rebase.adoc ##
>       @@ Documentation/git-rebase.adoc: of the to-be-rebased branch.=20
> However, `ORIG_HEAD` is not guaranteed to still
>        point to that commit at the end of the rebase if other commands=20
> that change
>      @@ Documentation/git-send-email.adoc: instead.
>        	Default value can be specified by the=20
> `sendemail.smtpServerOption`
>        	configuration option.
>        +
>      -@@ Documentation/git-send-email.adoc: must be used for each=20
> option.
>      - --smtp-ssl::
>      - 	Legacy alias for `--smtp-encryption ssl`.
>      -=20
>      ----smtp-ssl-cert-path::
>      -+--smtp-ssl-cert-path <path>::
>      - 	Path to a store of trusted CA certificates for SMTP SSL/TLS
>      - 	certificate validation (either a directory that has been=20
> processed
>      - 	by `c_rehash`, or a single file containing one or more PEM=20
> format
>       @@ Documentation/git-send-email.adoc: Automating
>        --no-to::
>        --no-cc::
>      @@ Documentation/git-send-email.adoc: Automating
>        	via config, if any.
>      =20
>        --to-cmd=3D<command>::
>      -@@ Documentation/git-send-email.adoc: have been specified, in=20
> which case default to `compose`.
>      - 	Currently, validation means the following:
>      - +
>      - --
>      --		*	Invoke the sendemail-validate hook if present (see=20
> linkgit:githooks[5]).
>      --		*	Warn of patches that contain lines longer than
>      --			998 characters unless a suitable transfer encoding
>      --			(`auto`, `base64`, or `quoted-printable`) is used;
>      --			this is due to SMTP limits as described by
>      --			https://www.ietf.org/rfc/rfc5322.txt.
>      -+* Invoke the sendemail-validate hook if present (see=20
> linkgit:githooks[5]).
>      -+* Warn of patches that contain lines longer than
>      -+  998 characters unless a suitable transfer encoding
>      -+  (`auto`, `base64`, or `quoted-printable`) is used;
>      -+  this is due to SMTP limits as described by
>      -+  https://www.ietf.org/rfc/rfc5322.txt.
>      - --
>      - +
>      - Default is the value of `sendemail.validate`; if this is not se=
t,
>      -
>      - ## Documentation/git-worktree.adoc ##
>      -@@ Documentation/git-worktree.adoc: associated with a new unborn=20
> branch named _<branch>_ (after
>      - passed to the command. In the event the repository has a remote=20
> and
>      - `--guess-remote` is used, but no remote or local branches exist=
,=20
> then the
>      - command fails with a warning reminding the user to fetch from=20
> their remote
>      --first (or override by using `-f/--force`).
>      -+first (or override by using `-f`/`--force`).
>      -=20
>      - `list`::
>      -=20
>
> --=20
> gitgitgadget

Naturally a misleading range-diff. It=E2=80=99s the same change as last
round but split up into two commits.

This looks good to me. Thanks!
