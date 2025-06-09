Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADA18DB1E
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494014; cv=none; b=jxi/ik/+SMaIQW2IA4U1rxrz8mdCS1cNrHn7RfnDPzI7VWDrEAV8C1D13ipGCD7/JgSRGmK58F434Iu5kwOWWZLDZrh7TiHfrQMJHboz3Ycvrc9+CYvPfBiXIaoz8fTu7JxOi59jxkC480CQZz+nWAJ2MgiEICVJ8wPMrCB782s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494014; c=relaxed/simple;
	bh=RBLSjT5SgHPj3KfqA5FNQD2PdaAVrlwStx6P4zGPo94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b8e5u0H5Tts7oja8D92Nx7dHeyjmgxYRpd6d6jckPGyhRwz0GEshJt3Xc+KEPdeLornL+TuDFDpaobrXqcQt+zyH0JUenh/MettPYpjqwCHmO3L+GTWMKUE/4jL39igfPvAG5Rgw/trw7rezwpVaf4qx9jLUzHbm6wwNeWPlyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ze6VnlLy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A97K77UQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ze6VnlLy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A97K77UQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FBC2114012F;
	Mon,  9 Jun 2025 14:33:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Jun 2025 14:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749494011; x=1749580411; bh=S1FGmjoH4W
	Xn8WYwe+qlGljshs2aanFP//SHFgkIMAg=; b=Ze6VnlLy7xTqxLve+jdhlW3KKl
	Br/4xsKwU+rceFwtUbD8+VkFz9iSTp+7I/sFeDaYEYreGH6BlrsGUfSafQD+CkN5
	cpVAwp69N6LpV4faY8IdOqbBKpXzQQ5F2BZCl/dcy71Y/tKLDAXzvGCz4sraXkBI
	oDWH4akkiF5AEREJXfb8xhk/83v8EIvMyKB3DtMCbtiMZsp5NgkoClS+Ssgrbr+1
	mMNFzqc15o2rcA7VAh5HE7C5L33umFWjJnG2U4wJWtcX3h410aNoWBIGSR9Rxace
	AasROqOosSdeMcCvK6LJw2L3/0zrOqgVV8ltTWXk+iecsmfbjOZnTtpn72+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749494011; x=1749580411; bh=S1FGmjoH4WXn8WYwe+qlGljshs2aanFP//S
	HFgkIMAg=; b=A97K77UQTm/jY0sEpqUWTb109gD+DVK4DmMtI1Ap5jUYumu2dNI
	fuvepBmiIAib5YmsfGAvYwQV16HrVKcZGxiSW+N5W1wmb7e1uU+MuwHJeOLDH/vg
	Gt+rgG5T47sdYlc4ifiAsEoZrde4w8pJdt3v4afQwtRGlgJ5ZqlkSHjjn2ammh5v
	oPYewf8beKxhzfaPRZMx+Sltl3IcKwQgZBkPr2c5HzNECtY9wF5lUeSxC0G6MNKq
	d4zXPNAcCm3hcHcWnLnp1LjNqdVYbNaGufojb/jnh7uYm73pbRpkjY1F7VIIaWuD
	9oB4tG+1cmq0e5G7RQYBWitF/aQBo7VuCVQ==
X-ME-Sender: <xms:-ihHaD3OaZYe65XqWCy8_vnuqWutIhueyEkbGnC0KivpTNkLR7pyGQ>
    <xme:-ihHaCG6iWh4thDT8X8CV1uFTJJcK9vQ9V177W2fWvMEpRXSklmgTCcZ0NRoXrEVf
    u-d3dbQsUghiyxeNA>
X-ME-Received: <xmr:-ihHaD4-qmtD8xQxTwXkv7Em9_vJHOOMASwDTs1WLEiMtlbmGSjwYp91WHDgRNABZEzNSJKW9ePiExuSFVjSuDyryw3gezjDIAtK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-ihHaI2gczVy9gEz53q1d44ZieGMVhm1X1Ie3yj9amQ3CPTGIrqG_g>
    <xmx:-ihHaGHOuSitis0mvQWrbhtbxzO5MheUKIuNzQ5rBse6ut8g7Pch9A>
    <xmx:-ihHaJ-h2iamir-wFQGoKguGf5Dd3ytUuUrwOGT1nuC1QFn49S_knQ>
    <xmx:-ihHaDk8fUug8VM0bdFujQCIgcYOZwprWeM3cy5nGzLMsu6DpkEijw>
    <xmx:-yhHaCDm7ItkogGNHvNnd46hjUGOn5ywr7IRb9ZRknkxa60NSjRtyRrG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:33:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 06/10] imap-send: enable specifying the folder using
 the command line
In-Reply-To: <PN3PR01MB9597AA90D615E2DEBF62220DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 9 Jun 2025 07:20:37 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597AA90D615E2DEBF62220DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 09 Jun 2025 11:33:28 -0700
Message-ID: <xmqqwm9krchz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Some users may very often want to imap-send messages to a folder
> other than the default set in the config. Add a command line
> argument for the same.
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  Documentation/config/imap.adoc   |  6 ++++--
>  Documentation/git-imap-send.adoc | 15 +++++++++++----
>  imap-send.c                      |  9 ++++++++-
>  3 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
> index 7c8b2dcce4..4682a6bd03 100644
> --- a/Documentation/config/imap.adoc
> +++ b/Documentation/config/imap.adoc
> @@ -1,7 +1,9 @@
>  imap.folder::
>  	The folder to drop the mails into, which is typically the Drafts
> -	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
> -	"[Gmail]/Drafts". Required.
> +	folder. For example: `INBOX.Drafts`, `INBOX/Drafts` or
> +	`[Gmail]/Drafts`. The IMAP folder to interact with MUST be specified;
> +	the value of this configuration variable is used as the fallback
> +	default value when the `--folder` option is not given.
>  
>  imap.tunnel::
>  	Command used to set up a tunnel to the IMAP server through which
> diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
> index 8adf0e5aac..4a0487b66e 100644
> --- a/Documentation/git-imap-send.adoc
> +++ b/Documentation/git-imap-send.adoc
> @@ -9,21 +9,23 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
>  SYNOPSIS
>  --------
>  [verse]
> -'git imap-send' [-v] [-q] [--[no-]curl]
> +'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]

This matches the _usage[] string.  Excellent.

>  DESCRIPTION
>  -----------
> -This command uploads a mailbox generated with 'git format-patch'
> +This command uploads a mailbox generated with `git format-patch`
>  into an IMAP drafts folder.  This allows patches to be sent as
>  other email is when using mail clients that cannot read mailbox
>  files directly. The command also works with any general mailbox
> -in which emails have the fields "From", "Date", and "Subject" in
> +in which emails have the fields `From`, `Date`, and `Subject` in
>  that order.
>  
>  Typical usage is something like:
>  
> -git format-patch --signoff --stdout --attach origin | git imap-send
> +------
> +$ git format-patch --signoff --stdout --attach origin | git imap-send
> +------

The above is small enough that it is OK to make the change
while-at-it, but it deserves a brief mention in the proposed log
message (e.g. "While at it, fix minor mark-up inconsistencies in the
existing documentation text").

> @@ -37,6 +39,11 @@ OPTIONS
>  --quiet::
>  	Be quiet.
>  
> +-f <folder>::
> +--folder=<folder>::
> +	Specify the folder in which the emails have to saved.
> +	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.

Good.

> diff --git a/imap-send.c b/imap-send.c
> index c6e47ddc42..a4cccb9110 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -46,12 +46,14 @@
>  
>  static int verbosity;
>  static int use_curl = USE_CURL_DEFAULT;
> +static char *opt_folder = NULL;

Let's lose "= NULL" here.

Do not explicitly initialize globals to 0 or NULL; let BSS take care
of the zero initialization, instead.

> -static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
> +static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
>  
>  static struct option imap_send_options[] = {
>  	OPT__VERBOSITY(&verbosity),
>  	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
> +	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
>  	OPT_END()
>  };
>  
> @@ -1729,6 +1731,11 @@ int cmd_main(int argc, const char **argv)
>  
>  	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
>  
> +	if (opt_folder) {
> +		free(server.folder);
> +		server.folder = xstrdup(opt_folder);
> +	}

Good.  This matches the same care taken on the configuration side
that avoids leaking the value previously given.

