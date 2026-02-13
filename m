Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674672DB79C
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005603; cv=none; b=hsdXDksEmps4Rpic28M6pLCLxlA88V1P6QV76XYfBWzjyxWbfJaUC6cdH7zen/1dod5MNw/fJdn6otQF2HsQyxUJB3NTNkJSRgsXpGmES6VWZV6N6AffzRyT3XANsHbd1GEe3hF5FjwKGsWsiEq8p/dcG/VfGb74Pw7tPZHEDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005603; c=relaxed/simple;
	bh=5JP7UkxcSdPqovzTuCzWteU+b0RmnqZYtlPqRN+SYUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o/iccyvMdbAEH1GwSZJtOzBeADsle6RFpIg2s67Nz3TH3gbpTtWMbuVvhk5QBRUL8tKIqetTRnJHqxxprYew1a9yobFQFE75sl4M4VdJUCydDb4nINdDWlbDmM5gAD0Uhdx2idC08m/STik5K6ZWyYW6rUYf9rAs+0I7MYywJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KU6oaW8/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgnhSXhA; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KU6oaW8/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgnhSXhA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 136DF7A00F7;
	Fri, 13 Feb 2026 13:00:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 13 Feb 2026 13:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771005599; x=1771091999; bh=JwN9e6iD/T
	CF58VysJV6DZx2siHSAHUd1IdPpBEI+kQ=; b=KU6oaW8/e4NW5nrNeVd+kNjKd+
	KbmQGMHZ4FzdRamNfsmyyynlTyHoCam0ZTpg+TjVhBUFk1YjUqurKjTBYkixIvPJ
	0bQfOGX4h3ifdOSKlOt6FfxrhFdSp4GAcHTgOmFH3bj4pRYNx/KGkls09NMrwinj
	Efu1JllltF2nDiJTxbIyJ6wJrMvt9eQvyU0va6gSqhk4WyHNGxX0TbVo2cRSKH4J
	txOfX13x7+HfDxcwovYX5Z1uUnNvb6dzDdlhwacsM+683UrblNKZOdv8kWilre7z
	jJNeWWd0B3n2zbMuOXJbk92nqjTLIREBMaEaFziGHDGiMwp59GYIu40ltGzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771005599; x=1771091999; bh=JwN9e6iD/TCF58VysJV6DZx2siHSAHUd1Id
	PpBEI+kQ=; b=FgnhSXhAsDrSf0M6req9Um+Xja+jdgsywMqckO0vuGLlNIOn2R6
	/kRPK3JiK9oAVMoszXwx0jkJMr7efTXeBKmX/zv9fIVQ/50ODBhTLCx2fIbZFGXD
	xyKmx97NQdi7cAYzUf06eGguuWFwqVDKbgq+cLUDSqmjkOx8J4bQOAPu/8N3faq1
	le8yvst8XayAeOcFyPPHgu9MKzmP6WzpEpuoPazmPesJ9Z2lzosp0F5PhW0OH7UD
	t799E9YtirRxduuCvVgs+B6t3UKIyMrL8dv5cAf+M8fs7GBF6127uK2yfokoTfSE
	T8p2e7OEsIWrFjchS09OH5/WUJR8TxUxtdg==
X-ME-Sender: <xms:n2aPaXIMTe-hq4H6_5FNmMSl-0HjSEoA_5oiJ77ucdceucQmmEICOw>
    <xme:n2aPada84nA2vJi6SuzKsVRnt5VHuJx3XZZL18jTNAXSr93vyaUHT19vHBFy628ud
    BM_bpO2vFADn5ZyH_gfrIjIqWZD5tqIjqGFR2_Anc_OpTlEV7ffiA>
X-ME-Received: <xmr:n2aPaR-HvlqFeGIJB6HlFTejKS4xkFBNXKhQvtEEUWraDcqoBo00ULnchhNKZ6N6HXwaE26VZSy0hOy1vCNAM6BmyoMkNxqq5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphht
    thhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphi
    hokhgrghgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:n2aPaWbQyNGQjwXgyq-Ipfx13KnhL-8qCkeuUkuZw8FPkn9LHqlBJA>
    <xmx:n2aPadMzeZf6xRTQpNo8l0O7NNl6hS8Drscf9y4PwtNawq752XZ3bQ>
    <xmx:n2aPaaAC_HWKOrdc3_-wXiFxmnRKxGumut1rdz-Z0qbwbr0yR9T2nw>
    <xmx:n2aPacI5A0bId5kLxDXOBn-SQt5K2W5jdjFCnBTSf5kfHap2xvqG6A>
    <xmx:n2aPaTTAgNqQIKDeWreGu10BI6Afr9KKJ5Jm5diZtnfjPQ4sNOEPaBlL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 12:59:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Matthias Beyer
 <mail@beyermatthias.de>,  Jacob Keller <jacob.keller@gmail.com>,
  pyokagan@gmail.com
Subject: Re: [PATCH v2 2/2] templates: detect commit messages containing diffs
In-Reply-To: <494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 13 Feb 2026 14:34:49 +0000")
References: <20260206090358.GA2761602@coredump.intra.peff.net>
	<cover.1770993281.git.phillip.wood@dunelm.org.uk>
	<494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
Date: Fri, 13 Feb 2026 09:59:58 -0800
Message-ID: <xmqqfr74msm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the body of a commit message contains a diff that is not indented
> then "git am" will treat that diff as part of the patch rather than
> as part of the commit message. This allows it to apply email messages
> that were created by adding a commit message in front of a regular diff
> without adding the "---" separator used by "git format-patch". This
> often surprises users [1-4] so add a check to the sample "commit-msg"
> hook to reject messages that would confuse "git am". Even if a project
> does not use an email based workflow it is not uncommon for people
> to generate patches from it and apply them with "git am". Therefore
> it is still worth discouraging the creation of commit messages that
> would not be applied correctly.
>
> A further source of confusion when applying patches with "git am" is
> the "---" separator that is added by "git format patch". If a commit
> message body contains that line then it will be truncated by "git am".
> As this is often used by patch authors to add some commentary that
> they do not want to end up in the commit message when the patch is
> applied, the hook does not complain about the presence of "---" lines
> in the message.

"git format match" -> "git format-patch".

> Detecting if the message contains a diff is complicated by the
> hook being passed the message before it is cleaned up so we need to
> ignore any diffs below the scissors line.

Sorry, but I do not quite understand the logic here.  In e-mailed
messages, the way the scissors line is most commonly used is to have
something like this.

	Hi, I read your problem report, and I think what is going on
	is ... (lengthy discussion here).

	Can you try this patch?

	--- >8 ---
	Subject: frotz: try working around nitfol

	As we cannot easily tell if the gostak will distim these
	patciular doshes, let's be careful to see ...

	diff - will be used to confuse the mailinfo

	Signed-off-by: a.u.thour
	---
	(diffstat here)
	(patch here)

and "diff - will be used to confuse" is something we would want to
notice.  But I am not sure if the use case of committing a scissors
line.  You help those who write a three-dash line and materials
meant to be kept outside of the final commit at the end, so if is
this an attempt to help those who write a scissors line and
materials meant to be kept outside of the final commit at the
beginning, I can understand, but then don't you want to notice "diff
-" that appears after the scissors line?  I do not offhand remember
what happens to a "diff -" that appears before the scissors (i.e.,
if you write "diff -" before "Can you try this patch?"), but I
wouldn't be surprised if mailinfo stopped there long before it sees
the scissors.

> There are also two possible
> config keys to check to find the comment character at the start of
> the scissors line.

Also I do not think scissors requires to be a comment.

So, I am a bit confused.

> The first paragraph of the commit message becomes
> the email subject header which beings "Subject: " and so does not
> need to be checked.

Great.

> The trailing ".*" when matching commented lines
> ensures that if the comment string ends with a "$" it is not treated
> as an anchor.

I am not sure what this means.  Wouldn't these three

	sed -e '/^#/d'
	sed -e '/^#.*/d'
	sed -e '/^#.*$/d'

work exactly the same way?

Thanks.

> [1] https://lore.kernel.org/git/bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm
> [2] https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
> [3] https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
> [4] https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  templates/hooks/commit-msg.sample | 54 +++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/templates/hooks/commit-msg.sample b/templates/hooks/commit-msg.sample
> index b58d1184a9d..f7458efe62f 100755
> --- a/templates/hooks/commit-msg.sample
> +++ b/templates/hooks/commit-msg.sample
> @@ -15,10 +15,60 @@
>  # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
>  # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
>  
> -# This example catches duplicate Signed-off-by lines.
> +# This example catches duplicate Signed-off-by lines and messages that
> +# would confuse 'git am'.
> +
> +ret=0
>  
>  test "" = "$(grep '^Signed-off-by: ' "$1" |
>  	 sort | uniq -c | sed -e '/^[ 	]*1[ 	]/d')" || {
>  	echo >&2 Duplicate Signed-off-by lines.
> -	exit 1
> +	ret=1
>  }
> +
> +comment_re="$(
> +	{
> +		git config --get-regexp "^core\.comment(char|string)\$" ||
> +			echo '#'
> +	} | sed -n -e '
> +		${
> +			s/^[^ ]* //
> +			s|[][*./\]|\\&|g
> +			s/^auto$/[#;@!$%^&|:]/
> +			p
> +		}'
> +)"
> +scissors_line="^${comment_re} -\{8,\} >8 -\{8,\}\$"
> +comment_line="^${comment_re}.*"
> +blank_line='^[ 	]*$'
> +# Disallow lines starting with "diff -" or "Index: " in the body of the
> +# message. Stop looking if we see a scissors line.
> +line="$(sed -n -e "
> +	# Skip comments and blank lines at the start of the file.
> +	/${scissors_line}/q
> +	/${comment_line}/d
> +	/${blank_line}/d
> +	# The first paragraph will become the subject header so
> +	# does not need to be checked.
> +	: subject
> +	n
> +	/${scissors_line}/q
> +	/${blank_line}/!b subject
> +	# Check the body of the message for problematic
> +	# prefixes.
> +	: body
> +	n
> +	/${scissors_line}/q
> +	/${comment_line}/b body
> +	/^diff -/{p;q;}
> +	/^Index: /{p;q;}
> +	b body
> +	" "$1")"
> +if test -n "$line"
> +then
> +	echo >&2 "Message contains a diff that will confuse 'git am'."
> +	echo >&2 "To fix this indent the diff."
> +	ret=1
> +fi
> +
> +exit $ret
