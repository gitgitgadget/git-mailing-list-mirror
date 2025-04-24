Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553718DF8D
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529598; cv=none; b=jNvgKfUMuVrWj+qT0f8C4UHLqUAE/nClsR70ZNKCRYkIC2PI1eLshpjgriSlbGiQNsAwut/IDWztCjEszjH7IdRk9htL8wyELD0Q3SvPHVL2G8ACukEO4JeYNDe0IwbIlsxMTay37GZvKul8FJGY16LlVaGPL/0h8TOcNNPtUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529598; c=relaxed/simple;
	bh=pSzCx5N0nph3s0x7XuP7mYhFNPqGF6itw9yd5szsbgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6/VZH8TzXQ2pHbvZd1g3fIHHEVRI2mn8vRPoray039//C2TfI8n9kAhlBDsGGTF5670ViU5sCRE/WoysFHsNIsYTce4iUNS7BlpKZMeG/acRjwGlHPQ0jebFJDGQWWNcdS1BUIF2GDvkfdb/TS5CFdTHikN9tRFclpCed0hVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WREcLLa/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCfDMJ/r; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WREcLLa/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCfDMJ/r"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E1781140200;
	Thu, 24 Apr 2025 17:19:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 24 Apr 2025 17:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745529595; x=1745615995; bh=D6BmDuLg3Y
	7R3mICtz78u/KWVOxq2SdloCKuiITYJTY=; b=WREcLLa/YetxKd883VFcov4gjA
	uzvU6cqYas/L5XMFsbHH5SrxiAAQyiKfjHhlKwELzkk6fhmYvV301628yl5eNqKC
	aPqF+iNJNrGvvcRMW3cStnv34iv/sBxauBP3dbCJ5oPfztO1/aYgK1T5VN/pTdFj
	1GA9PF97gWtv4NcxTOnKNck9c5auNaRaQv+Xb4uW6SKe83x29eyXOZrWiyIAuFAW
	4KFgjrFwtBzBX18f8Qy0DK5YymPe5hYUvLiVOIm7MXxjhFC37hPorEqlbJgoH82i
	tksW7puqv2/Z9tr0VZZjnBvi+rkLOl5md92oHScaBqFvMaJXz3iKWpISa0cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745529595; x=1745615995; bh=D6BmDuLg3Y7R3mICtz78u/KWVOxq2SdloCK
	uiITYJTY=; b=LCfDMJ/rAcTNkEyZJefYnoEJDIADlNaR6MG3VDjSORW54wOZ8yG
	ROv1HbF/eNHU66L1u+5dx5MFAB//9psnHreFDs0P4pReYhdmV0DlxRSBrlZW30QH
	5d64cJMh949rsSCMmxxfJFGKaWkecUbHUTS8EETnxemkVTXO9yct0qgSEIs003yj
	6t6aJ/y/JZYA8R380oDuOU8p9dGXzTGBFm1Ybiq5nk3wYFkrdNZ4twG3uVb79Fom
	urNsiCwgiCW4zymj8hDDEQUYUg4XqfmlkL9d6l/MAMOSuKDv5llFrKzAJ8ZBON1Q
	FVommYPPNFd7I7yeep7KTknmK9Bx8lQEm+Q==
X-ME-Sender: <xms:-qoKaAKSFTdWkcynJw_z5OcSWFpMKsIFdJdhOaH65hRjCsIcNC0F2w>
    <xme:-qoKaAITK3NtAKwLoVQMI4zdBZLWbhiY1dNBgRKdZSuePctnwpxvZpjxYj7zaFpTN
    XFmTthfAgEJhWG-vA>
X-ME-Received: <xmr:-qoKaAs8o_Xxd7EuduU-x2HLFAsIiHLaOhD-kxa-SuejK2hLYuGqaAYbcPetlNak_9RRUxZxa3LW3973vzLIr9u9b5R_isW19EiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdetkedtteduveeludekheffudehvdeu
    udffvdethfeileetgfduheffhfegtdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-qoKaNbeeWd4504HwtwxL8zXqgF2p9dDmEOCnyxH1tjRk89Eoi9RAg>
    <xmx:-qoKaHbpo8r2NXJ82PxjyGwnshgzXM8kw-sJCjasKQjLtQKRcvatug>
    <xmx:-qoKaJAHOZn2KhcMfgtvHZR0M7sRaXSERDB22yiAb4via0vJAQ6yCQ>
    <xmx:-qoKaNYpccWvywS6tZI_m5FimJ_HGy5slj1pMLdWP28cqdQ89TTI6w>
    <xmx:-6oKaHpgOSEQAkRy8SPT4o-XMP0ZZF-91cIeneC0RDPKSCll4yEJLBpo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 17:19:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature
 algorithm name
In-Reply-To: <20250424203904.909777-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 24 Apr 2025 22:39:04 +0200")
References: <20250424203904.909777-1-christian.couder@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 24 Apr 2025 14:19:52 -0700
Message-ID: <xmqqselxtfyf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
> signed-commits, 2025-03-10), added support for signed commits.
>
> However, when processing signatures `git fast-export` outputs "gpgsig
> sha1" not just when it encounters an OpenPGP SHA-1 signature, but also
> when it encounters an SSH or X.509 signature. This is not very
> informative to say the least, and this might prevent tools that process
> the output from easily and properly handling signatures.
>
> Let's improve on that by reusing the existing code from
> "gpg-interface.{c,h}" to detect the signature algorithm, and then put
> the signature algorithm name (like "openpgp", "x509" or "ssh") instead
> of "sha1" in the output. If we can't detect the signature algorithm we
> will use "unknown". It might be a signature added by an external tool
> and we should likely keep it.
>
> Similarly on the `git fast-import` side, let's use the existing code
> from "gpg-interface.{c,h}" to check if a signature algorithm name is
> valid. In case of an "unknown" signature algorithm name, we will warn
> but still keep it. Future work might implement several options to let
> users deal with it in different ways, and might implement checking
> known signatures too.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> This is a follow up from cc/signed-fast-export-import that was merged
> by 01d17c0530 (Merge branch 'cc/signed-fast-export-import', 2025-03-29)
> and introduced the support for signed commits.
>
> The format that this series implemented was lacking a bit, so the goal
> with this patch is to improve it and handle signed commits a bit more
> consistently in the code base. It also shows in the tests and in our
> documentation that SSH and X.509 signatures are supported.

Thanks.

It is a bit surprising and slightly sad that nobody bothered to
report/complain about the brokenness until the original author
follows up one month later X-<.  Nobody but the original author is
using this feature?  I would have expected that use of signed
commits were of high demand and many more people were actively
interested in the topic.

>  '--signed-commits', you may set the environment variable
>  'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' in order to change the default
>  from 'abort' to 'warn-strip'.
> ++
> +When exported, signature starts with "gpgsig <alg>" where <alg> is the
> +signature algorithm name as identified by Git (e.g. "openpgp", "x509",
> +"ssh", or "sha256" for SHA-256 OpenPGP signatures), or "unknown" for
> +signatures that can't be identified.

Nice to see these enumerated.  As we are not opening the choices of
"algorithms" up to end-users by allowing custom signature routines
to be plugged in, configured, or hooked into the system, it may make
sense to make it clear that we will keep a canonical and exhausitve
list here, by saying "one of these:" followed by a bulleted list, 
instead of a parenthesized examples (e.g.), like you did in the
other documentation below.  Or perhaps refer to the other document
from here so that we do not have to keep two lists in sync?

> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index 7b107f5e8e..50b6d2cc1d 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -521,7 +521,20 @@ The optional `gpgsig` command is used to include a PGP/GPG signature
>  that signs the commit data.
>  
>  Here <alg> specifies which hashing algorithm is used for this
> -signature, either `sha1` or `sha256`.
> +signature. Current valid values are:
> +
> +* "openpgp" for SHA-1 OpenPGP signatures,
> +
> +* "sha256" for SHA-256 OpenPGP signatures,
> +
> +* "x509" for X.509 (GPGSM) signatures,
> +
> +* "ssh", for SSH signatures,
> +
> +* "unknown" for signatures that can't be identified (a warning is
> +  emitted).
> +
> +Signatures are not yet checked in the current implementation though.

Excellent.

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 170126d41a..d00f02dc74 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -29,6 +29,7 @@
>  #include "quote.h"
>  #include "remote.h"
>  #include "blob.h"
> +#include "gpg-interface.h"
>  
>  static const char *fast_export_usage[] = {
>  	N_("git fast-export [<rev-list-opts>]"),
> @@ -700,9 +701,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  	}
>  
>  	if (*commit_buffer_cursor == '\n') {
> -		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
> -			signature_alg = "sha1";
> -		else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
> +		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor))) {
> +			const char *name = get_signature_name(signature);
> +			signature_alg = name ? name : "unknown";
> +		} else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
>  			signature_alg = "sha256";

The original is bad enough but can we do something to these overly
long lines?

>  	}
>  
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 63880b595c..59e991a03c 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -29,6 +29,7 @@
>  #include "commit-reach.h"
>  #include "khash.h"
>  #include "date.h"
> +#include "gpg-interface.h"
>  
>  #define PACK_ID_BITS 16
>  #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
> @@ -2830,12 +2831,15 @@ static void parse_new_commit(const char *arg)
>  			"encoding %s\n",
>  			encoding);
>  	if (sig_alg) {
> -		if (!strcmp(sig_alg, "sha1"))
> -			strbuf_addstr(&new_data, "gpgsig ");
> -		else if (!strcmp(sig_alg, "sha256"))
> +		if (!strcmp(sig_alg, "sha256"))
>  			strbuf_addstr(&new_data, "gpgsig-sha256 ");
> -		else
> -			die("Expected gpgsig algorithm sha1 or sha256, got %s", sig_alg);
> +		else if (valid_signature_name(sig_alg))
> +			strbuf_addstr(&new_data, "gpgsig ");
> +		else if (!strcmp(sig_alg, "unknown")) {
> +			warning("Unknown gpgsig algorithm name!");
> +			strbuf_addstr(&new_data, "gpgsig ");
> +		} else
> +			die("Invalid gpgsig algorithm name, got '%s'", sig_alg);

Hmph, we used to have special cases for sha1 and sha256 but now we
can handle sha1 with a more generic "valid_signature_name()" logic?
And yet we need to still special case sha256?  Not that I trust the
old code all that much and take deviations from the patterns in the
old code as a sign of something not right...

The fast-export stream produced by the code with d9cb0e6f
(fast-export, fast-import: add support for signed-commits,
2025-03-10) used to identify a signature algorithm "sha1", but this
new version of fast-import lost the support for it, and will barf
when seeing such an existing fast-export stream?  I am not sure what
is going on around this code.

I am not so worried about the other case, where the stream produced
by fast-export contained in this version may or may not be readable
by an older version of fast-import.

I am puzzled enough, so I'll stop here for now.

Thanks.
