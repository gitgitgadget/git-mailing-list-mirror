Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F51D63F6
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064454; cv=none; b=IZHe8Z9jZ8c9ZtKkmseD+WwfPpZ6t7YMPqr70XUim/WY+sHeyKtGEIbQJ5JHp/ojpCS84EzwBcNYqjN4rRnNRiE8pZFjWPrx33avafRccC8wHN2aHEsKhRg0mg01VGjE5ZdU3z0NX/pefiGI3GF3cABV5IalUpailqz4ZB7yIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064454; c=relaxed/simple;
	bh=pG36Zb+aq0fK6NmLMYIFzBSSv3gh2Y61tVV3s07DetU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y500zoJxYZqrXkn5JuwHpmk1CpT4VgRynk/RjzH9kTjJHDeJ6KFQCtk9YqPWQz9AQXrB8yBArCTfCCGQc+UEhnWpjDdBPL5sAex4KJ0InfruY/xslvDXKu0hZ7QmnTKHRtuuTeVKMxoScsHcFfbs21YMhNjk3blyv6gyyp3YtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mqALF+J6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bOxRhJJR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mqALF+J6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bOxRhJJR"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C200C138097C;
	Thu, 20 Feb 2025 10:14:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 20 Feb 2025 10:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740064450; x=1740150850; bh=lkNx5a+CYT
	xjn4/A2DLX3dajZBowuv0h8P8rqT+ofG0=; b=mqALF+J6BeVDa1a6SHWyUV4xzu
	FKG72VoVD0jkLMvcaSwNAtavtlq1ijyA1GnxmIxhgWRMn3OryeraNDF95N/81WPM
	qO1lrTwjsQcov7fRnpCzq8rjsnDbL7kZxyh5uzytKd4eeKUiZBNF/P+ZH4g/4B0Y
	g2TJKqdmZsXwF3frmF+MNaaNExZC7I1vL9n1Ser0cV2kXc8+Q7npywhS+OZ2Uqr9
	6C13+KWPJtvVj+mN875xYFv4QEDizjdB9ymacEGDxI845oUZ0ti9pOXSFZboBZJd
	2ZO1BQ4Od05zGRr6aceVgxk355oiws8saWmh3GXI2+fpnn6wPgsdTdW5pIwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740064450; x=1740150850; bh=lkNx5a+CYTxjn4/A2DLX3dajZBowuv0h8P8
	rqT+ofG0=; b=bOxRhJJRxAj0Jn0cKw6o9wUqdawm59yLzTPXXRq5GiIEgxQZ2MG
	/Bk2aYnxSk7zF64wJj1hF+dWfT2tpVjEIvJo+4qfh3VvfGBpYpk+ANCIlR2W9oze
	FI5L4HsGLJp1Q4OLjTFLWtagD5YJe51sVLO9HJ7/q1QopZMg3wcvjL8GEyGV1I3S
	WFkrlbMqPyDoDfkQIB0UcuEpcDsdnjFEaudqhl1MiRf1zyVawwDfjQV0vAnr3L2Z
	E/TnyyY7wRgYoZ3mmVXT+h00lNTZyZUC//EKZc6A8XGHl+CBVqYhflvaNPClMRtZ
	jvWLN5TSm4JKkxqmzjb2bNJAzoI/Ngd9l7w==
X-ME-Sender: <xms:wUa3Z0F-uxEj2U-cyjfl_unp-DQv15fq15oDfD7nbqjHZtvXcH9_Bw>
    <xme:wUa3Z9VDJQq_LKH-IT4YUvPed6fuBfxN4oPNnQh4jNwgm_Yi3e46DbeWRnkfPt8S9
    cHx7rY8FkshSOvkHQ>
X-ME-Received: <xmr:wUa3Z-KXiwKm4RdARTZoEN8IfzqHVNS4YWGKA_Sb_0thQmr3KfiOOKtGaDLrltNkbpKXL3wpgI-7_nKxR1xE2B5kAqVjsZ4ZsEBhXFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wUa3Z2EjIMU4jgc7gDdmZqvx0eEmdqnA8hOX7tY6WVCY4WqjuvIpvQ>
    <xmx:wUa3Z6X6J8YtwpzvCdj_YkcvN5IfMaX9pLbW-mLXO9Bm7pXJSVna0Q>
    <xmx:wUa3Z5OSOPHGxkjumcq1ekoEN72xA_h11BKwstj8f_iuCjIYPbdvxg>
    <xmx:wUa3Zx0M6JQ6RiNtwiZ_hoJ6C9OsaDhm2D-SYbFCSgZqTs6jk1OvDQ>
    <xmx:wka3Z8cGtcYRTUjc4a-AU97AflwfRV1rS2IaoJDIuOz3Xg-FVNhNxP9L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 10:14:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v4] builtin/refs: add '--no-reflog' flag to drop reflogs
In-Reply-To: <20250220095614.62042-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 20 Feb 2025 10:56:14 +0100")
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
	<20250220095614.62042-1-karthik.188@gmail.com>
Date: Thu, 20 Feb 2025 07:14:07 -0800
Message-ID: <xmqqikp4eji8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'git-refs(1)' migrate subcommand, which transfers repositories
> between reference backends, currently migrates reflogs by default as of
> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).

"transfer" is a curious verb to use here, as it almost exclusively
is used in the context of fetch-and-push object transfer over the
wire.  

	The "git refs migrate" subcommand converts the backend used
	for ref storage.  It always migrates reflog data as well as
	refs.  Allow it to optionally discard reflog data.  This is
	useful because ...

or something?

>  builtin/refs.c          |  3 +++
>  refs.c                  |  8 +++++---
>  refs.h                  |  5 ++++-
>  t/t1460-refs-migrate.sh | 28 ++++++++++++++++++++++++----
>  4 files changed, 36 insertions(+), 8 deletions(-)

I notice there is something missing.

> diff --git a/builtin/refs.c b/builtin/refs.c
> index a29f195834..c459507d51 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> ...
> +		OPT_BIT(0, "no-reflog", &flags,
> +			N_("drop reflogs entirely during the migration"),
> +			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),

This is somewhat ugly, but parseopt API is nice enough to hide the
"--no-no-reflog" nonsense from the end users, so this is OK.

I think we are almost there but lack documentation updates?

 Documentation/git-refs.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git c/Documentation/git-refs.txt w/Documentation/git-refs.txt
index 9829984b0a..bb50d6f888 100644
--- c/Documentation/git-refs.txt
+++ w/Documentation/git-refs.txt
@@ -8,9 +8,9 @@ git-refs - Low-level access to refs
 
 SYNOPSIS
 --------
-[verse]
-'git refs migrate' --ref-format=<format> [--dry-run]
-'git refs verify' [--strict] [--verbose]
+[synopsis]
+git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
+git refs verify [--strict] [--verbose]
 
 DESCRIPTION
 -----------
@@ -43,6 +43,11 @@ include::ref-storage-format.txt[]
 	can be used to double check that the migration works as expected before
 	performing the actual migration.
 
+--reflog::
+--no-reflog::
+	Choose between migrating the reflog data to the new backend,
+	and discarding them.  The default is "--reflog" to migrate.
+
 The following options are specific to 'git refs verify':
 
 --strict::
