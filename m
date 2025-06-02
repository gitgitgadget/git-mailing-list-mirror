Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6B19341F
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824797; cv=none; b=tUxmI4FAEzNrvnPG25qgfascgXsyB20T6D51y1Xn1G5sKNBzz/+FgREN4Fk2wn5wJST8PdQXoyw+/s9I6xpkdexnytQH0L3YFpWJTOWRlcbID7XJylae/MmMTV8cgUeDT6yUKtpFG8hsnd/d/Ba4QZf36RcdVGGjAEbrGF6UpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824797; c=relaxed/simple;
	bh=JmXu1ZtAis5Fjz2kfElGIq4wz0QJbgDqSnNL5CX292E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LAsMxmJB2kj//Esgif59EnwgD+g0/issK0Dab4rsnGMNoqrMhldDMO94Xr/d7NYDTNcOYO541UQpgprKaFAo89oKtlNpXPqFfG+MJqjKtXbs6AyC6DNgAwh0p2gupU0le/bmOCAXgjmWEmGnKj7jWeo7OrACyQYqkf0j5PE5qdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h8ua25un; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KXAX8Eq1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h8ua25un";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KXAX8Eq1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B895138029E;
	Sun,  1 Jun 2025 20:39:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 01 Jun 2025 20:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748824794; x=1748911194; bh=7HXYeEDCRj
	eLBY+41mhYdJwONFnDHxVebGgWKL9qJ4g=; b=h8ua25unG2E51XVRd/lYJft2gb
	pvDJ7GsuGdB+sfh1b26I5Uc8EP9p5b2rHq6FDv3tk0Wur+AgnQx5Ya5++1+rozUN
	cuRFD9FuUzGBQPixYtpdM56tLgJGL2QJuKhOZ3Ti/5pTRSh8SuW8mofsJD/njEjg
	jNQTq8bS6c16hedLd8SOtqPCDs7zL9+SggTism7RxjH2/7Tpo7oRS2Cu7597fYdp
	0zZJaZm4/G3aOdj0MooiK+IbvcdycuAjK1kbrm1Si2WODDC1NdtDO9JqMNdbJLLT
	WcXVOGuKCOqIgnJCGt/+nmMQq+Zdqk5eP4hM2HfapM/0+I/oLIlgzus7pbvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748824794; x=1748911194; bh=7HXYeEDCRjeLBY+41mhYdJwONFnDHxVebGg
	WKL9qJ4g=; b=KXAX8Eq1DgwLXBh1eKh2+4t/onzMOnN+j1rsEXnErQ0V88LOGfj
	NQi+tTDhelOZQenh8vu6q9ctQObRd076dWl0lTd2HlvqSbNkggdT2P6tuEBtl0sd
	0ldMNDBKqGoFtyaJpsbw+LGkrCHOzwu/66WJXjOUmb58HBmu5mzmSJxRs5Z0ZM+x
	NtpSiHnU5ZvQiS5ATF8qJWpZnZ9rjRbU5SsZQWBioE/kvhIX3c+78Hgitpip+dLA
	DETakkccpL6+Yo0Me8bPh/eNOdW6YQsZECXI/5SRCLSVTbNTjNts7diI3Gyn285P
	MB8/JkfW98oItboUl6GMxJItt0ivhbe4nAQ==
X-ME-Sender: <xms:2fI8aGPoGw3m4w9ZANbuKnuNYdib7aHFY6m7Qpyxs1IqBDmn3yqcZg>
    <xme:2fI8aE8A5QRpTm8e6t-vs3M8OiQ1PbaSSp4UZ3o3uYoUg03aauaPBYdyH-J6if7kb
    IqvilHHcbiEBCOxjA>
X-ME-Received: <xmr:2fI8aNRz_JVY6Jmn8DJ06qGEXkEWn4Hmhr1xsrUoO9ePujtkn7CPNUav0JD4mz54-iDOYWtXIr8brOHz3nEVvloxoJcvN7rB_FbC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefiedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepiihihigrohesughishhrohhothdr
    ohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvg
    drnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:2fI8aGs14ZBdY83WoGyyBSPTtsiizj7yhgOcXzLZm4DU90atIkG9tA>
    <xmx:2fI8aOekyUrWHEHG3gUEZcwkO7ukmlkXp3-HZ8oCEGKqoXGRpDPz1g>
    <xmx:2fI8aK1c3dmQjm35WUfiuvAZ9dUDCOYEfeJc4n_7HEBnb_fGJf208Q>
    <xmx:2fI8aC91nYyn1Dt00TsRoNlpHqkNic9CKeh1G8jk4_8eBcIOzGSHwg>
    <xmx:2vI8aB5l3tdlk6dH-rbvRc0sdVnQBH6NZSZzocHiX070a7QP9VzW1t1g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 20:39:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben
 Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v11 5/9] imap-send: enable specifying the folder using
 the command line
In-Reply-To: <20250601083821.2440110-6-gargaditya08@live.com> (Aditya Garg's
	message of "Sun, 1 Jun 2025 08:38:54 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250601083821.2440110-1-gargaditya08@live.com>
	<20250601083821.2440110-6-gargaditya08@live.com>
Date: Sun, 01 Jun 2025 17:39:51 -0700
Message-ID: <xmqqfrgjvuw8.fsf@gitster.g>
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
>  Documentation/config/imap.adoc   |  5 +++--
>  Documentation/git-imap-send.adoc | 15 +++++++++++----
>  imap-send.c                      |  9 ++++++++-
>  3 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
> index 24e88228d0..829d9e0bac 100644
> --- a/Documentation/config/imap.adoc
> +++ b/Documentation/config/imap.adoc
> @@ -1,7 +1,8 @@
>  imap.folder::
>  	The folder to drop the mails into, which is typically the Drafts
> -	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
> -	"[Gmail]/Drafts". Required.
> +	folder. For example: 'INBOX.Drafts', 'INBOX/Drafts' or
> +	'[Gmail]/Drafts'. Required if `--folder` argument is not used. If
> +	set and `--folder` is also used, `--folder` will be preferred.

Shouldn't these literals be `typeset like this` with backquotes?

More importantly, when we mention that the command line option
trumps the corresponding configuration variable, the more common
verb we use than "prefer" is "override".  Because it is a general
rule that the configuration variable is used as a back-up in case
there is no command line option is given, it is less confusing if
you omitted the last sentence.  Perhaps rewrite the last two
sentence with something like this?

	The IMAP folder to interact with MUST be specified; the
	value of this configuration variable is used as the fallback
	default value when the `--folder` option is not given.

I dunno.

> @@ -37,6 +39,11 @@ OPTIONS
>  --quiet::
>  	Be quiet.
>  
> +-f <folder>::
> +--folder=<folder>::
> +	Specify the folder in which the emails have to saved.
> +	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.
> +
>  --curl::
>  	Use libcurl to communicate with the IMAP server, unless tunneling
>  	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND

There are four existing options and this adds another.  I am
debating myself if this deserves a preliminary clean-up patch so
that the enumerated options are more like

	`-v`::
	`--verbose`::
		Be verbose.

If we did so, this patch can add

	`-f` _<folder>_::
	`--folder=<folder>`::
		Specify the folder to save the e-mails in.
		Required.  Defaults to the value of the `imap.folder`
		configuration variable

without worrying about it not following the prevailing (and stale)
style.

If we are not doing a preliminary clean-up patch, what you sent is
more in line.  We'll leave the clean-up to somebody else and adding
one new option in a stale style to 4 existing ones may not be too
bad.  At least such an intermediate state is locally consistent.

Thanks.


