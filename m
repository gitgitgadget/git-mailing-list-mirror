Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973709474
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735404946; cv=none; b=goBrIEUYEb8KR4/GUx/KWCba5M50lWF9MLTKYw5mfvUWkmjeH5imBn17iNgjEtZCPCiwp9AgrzzBZG5syi4zEqEZPcCESUxB7gWLWFugZ7nzmvDh6S+m9DhR4mKlRoblc+nECHToVlJwyUVBCGHOYqYXMM7WlH7Wy6STzxRR+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735404946; c=relaxed/simple;
	bh=BgV90uHXIzVD1YZv/lO2Q+vZIBXAvhpnC7dcSzZLrD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfN2+VbINZS9CEw7WN3Axadweb2157AVZ/ytWE4OWoJaZk90X97WlRuNMWfOpC0PIK+wsUnEyvDD960BPQAqg9TPcU4E+ZxAFJQn3TMyaZUie4Emmb/elc5Te0sALien7/JaFznEldn3JK7L2ShCkSGyocID6Vh6ZqE0MieFtvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cWjtoBus; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QqZ3jv6H; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWjtoBus";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QqZ3jv6H"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A114113801E3;
	Sat, 28 Dec 2024 11:55:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 28 Dec 2024 11:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735404942; x=1735491342; bh=6cKT94bxH7
	yPKXshgwtY83uycdtUL3xR94xrYaenRG4=; b=cWjtoBusN036UIVWNwdavqvyQG
	KvJ8kTHqKDjp33R+/L2N9+UnKTPEZKHvkjdOrcyaCjJzJAgJpkBAPfl0ouuas+VR
	iIfwox/r4W69H0mY8yGyUVRXO3wO8k7OHdyq8RKpu2DEMBYtGPbea5UiDOLDn8w1
	SCyLg1yXFkd3Qg99Icl2+OIf8rSJ3f9usz1V2JFmYQ31V8KcgujhlC8smD5h4hKa
	cQKkzDWSNiejBQ9yLaTgI34ewM38quKp3Wp9wdFejr85h/vD6naStwqtGNdZvoAt
	A7m6fA0LTbVdq9g3U9FllLg6mOtrC0/Mvv+2L5AgxxpNZT2EI05reCTrGmDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735404942; x=1735491342; bh=6cKT94bxH7yPKXshgwtY83uycdtUL3xR94x
	rYaenRG4=; b=QqZ3jv6Hsr69vhwFyVRVsdLZZyZvGqZbk6yIrhjkFiE/Ne5axB2
	ijIPg0Tqec5q4s8E9Hb2Vp9GGcb3YpXSO/sxM2jNuMiKa6lXlp4ToQZSzrQMv5ej
	3f1T8oCMHsdtFYcNQo2Yu8R9xvKeB40fXYnunSEcrHMj3nnKN3OF64sqAdQrygx5
	1Q5jRsDKeE7Pm9kC3D1s+mB5YSFiTbBZLW5xdl56gR2H13/cUopTy5ejL36pNSV2
	r995lYjHhodqbh3asIYTAS25enFllGqsBHRvaQ+Us2NTj/bYU+XT03v3PnzR0im8
	aqCG7t1b+CYmQJJ0eeNIT+zM+kfwhxcIl6w==
X-ME-Sender: <xms:ji1wZ-VRAinIL6dRpMpnub9lfRkjugZJuOUYz-4jt-GTNtE3seH0-g>
    <xme:ji1wZ6m4ouhyDQWcyedZHDtF0QXmiICcLhP8ZFICTFERSbjZ2x8kY-GFr3rxdDc9T
    JGuI57pfRUNmPAmGg>
X-ME-Received: <xmr:ji1wZybOXADxYMbG9z9dE6CyOl3U4R_xBuR1eWP7jRi70WVie58Hy9to7wZpWUee8aVJuyQLA2IZmNbfV102zczug03-QQxNHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepteefvdeihfdvudekgeetleetgfeileejhfev
    gefhfeduudetkeegieegheeuhfevnecuffhomhgrihhnpehprghrshgvqdhophhtihhonh
    hsrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegrshhhsehkrghmsggrnhgrrhhirgdrohhrghdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfi
    horhhlughhvghllhhordhnvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ji1wZ1VWpcxEhfOuOmf6ADbY9kaMpK01PHeYn2k8xHublF1haHJ7jA>
    <xmx:ji1wZ4nklTZzonaRy71LYHCMk7u1s1nwctbeN8jtb3QSfX5KboYUYw>
    <xmx:ji1wZ6cAWOZOnqpOF8e49PIPjkRJy6ujm5KIwWdGqb-1sz1gFAeL2g>
    <xmx:ji1wZ6HinwIbKOIj8K2MvRp_yifUrMNTru9yo-OjUtSTWgR6KJNWJA>
    <xmx:ji1wZ5DElLn7f3OJHC_qleWLsRBsqHX7tqSetoRoTKaHRACT7Yn9sbI5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 11:55:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org,  worldhello.net@gmail.com
Subject: Re: [PATCH 4 1/1] parse-options: localize mark-up of placeholder
 text in the short help
In-Reply-To: <20241228114221.10351-4-ash@kambanaria.org> (Alexander Shopov's
	message of "Sat, 28 Dec 2024 12:42:18 +0100")
References: <xmqqjzhm7jgl.fsf@gitster.g>
	<20241228114221.10351-4-ash@kambanaria.org>
Date: Sat, 28 Dec 2024 08:55:40 -0800
Message-ID: <xmqqy0zz3fxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Shopov <ash@kambanaria.org> writes:

> Subject: Re: [PATCH 4 1/1] parse-options: localize mark-up of placeholder text in the short help

It is more common to see "[PATCH v4 1/1]" around here.  In fact, I
suspect that you have to fight the tool to have them produce "[PATCH
4 1/1]".

Not that it matters to me personally (as "git am" on the receiving
end will strip it), but when looking for a specific version of your
patch from the mailing list archive, people may find it harder than
necessary because of the subtle difference.

> i18n: expose substitution hint chars in functions and macros to
> translators
> ...
> In case the translator's writing system is sufficiently different than
> Latin the "<>" characters can be substituted by an empty string thus
> effectively skipping them in the output.  For example languages with
> uppercase versions of characters can use that to deliniate
> replaceability.
>
> Alternatively a translator can decide to use characters that are
> visually close to "<>" but are not interpreted by the shell.

Very well written.

> diff --git a/parse-options.c b/parse-options.c
> index 33bfba0ed4..8904345c07 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1076,11 +1076,23 @@ static int usage_argh(const struct option *opts, FILE *outfile)
>  		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
>  	if (opts->flags & PARSE_OPT_OPTARG)
>  		if (opts->long_name)
> -			s = literal ? "[=%s]" : "[=<%s>]";
> +			s = literal ? "[=%s]" :
> +			  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
> +			     Change only the `<>' characters to something else if you use another convention for this.
> +			     Most translations leave this message as is. */
> +			  _("[=<%s>]");

This is way too wide.  Documentation/CodingGuidelines should have
something to say on this, but in case it does not, we try to allow
those with 80-column terminals to read our code comfortably, and it
is even better to allow us to do so after a patch is quoted a few
times (i.e. adding a few columns on the left edge), so a practical
limit may be around 70-columns.

Also, our multi-line comments have opening slash-asterisk and closing
asterisk-slash on their own line.

This part is giving a help for the option value argument for a long
option, i.e. for "git subcommand --option[=<value>]", we are talking about
the "[=<value>]" part.  It is not clear "command line argument name"
conveys that.  Something along this line, perhaps?

    The "<%s>" part of this string stands for an optional value given to a
    command line option in the long form, and "<>" is there as a
    convention to signal that it is a placeholder (i.e. the user should
    substitute it with the real value).  If your language uses a different
    convention, you can change "<%s>" part to match yours, e.g. it might
    use "|%s|" instead, or if the alphabet is different enough it may use
    "%s" without any placeholder signal.  Most translations leave this
    message as is.

> +			  _("[=<%s>]");
>  		else
> -			s = literal ? "[%s]" : "[<%s>]";
> +			s = literal ? "[%s]" :
> +			  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
> +			     Change only the `<>' characters to something else if you use another convention for this.
> +			     Most translations leave this message as is. */
> +			  _("[<%s>]");

Ditto, except that this is for "the short form".

>  	else
> -		s = literal ? " %s" : " <%s>";
> +		s = literal ? " %s" :
> +		  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
> +		     Change only the `<>' characters to something else if you use another convention for this.
> +		     Most translations leave this message as is. */
> +		  _(" <%s>");

Ditto, except that this is for "a value given to a command line option",
not specific to either long or short form.

>  	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
>  }


I'll queue with the following change on top.
Thanks.


 parse-options.c | 55 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git c/parse-options.c w/parse-options.c
index 8904345c07..3ff6a5d1fa 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -1076,23 +1076,48 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
-			s = literal ? "[=%s]" :
-			  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
-			     Change only the `<>' characters to something else if you use another convention for this.
-			     Most translations leave this message as is. */
-			  _("[=<%s>]");
+			/*
+			 * TRANSLATORS: The "<%s>" part of this string
+			 * stands for an optional value given to a command
+			 * line option in the long form, and "<>" is there
+			 * as a convention to signal that it is a
+			 * placeholder (i.e. the user should substitute it
+			 * with the real value).  If your language uses a
+			 * different convention, you can change "<%s>" part
+			 * to match yours, e.g. it might use "|%s|" instead,
+			 * or if the alphabet is different enough it may use
+			 * "%s" without any placeholder signal.  Most
+			 * translations leave this message as is.
+			 */
+			s = literal ? "[=%s]" : _("[=<%s>]");
 		else
-			s = literal ? "[%s]" :
-			  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
-			     Change only the `<>' characters to something else if you use another convention for this.
-			     Most translations leave this message as is. */
-			  _("[<%s>]");
+			/*
+			 * TRANSLATORS: The "<%s>" part of this string
+			 * stands for an optional value given to a command
+			 * line option in the short form, and "<>" is there
+			 * as a convention to signal that it is a
+			 * placeholder (i.e. the user should substitute it
+			 * with the real value).  If your language uses a
+			 * different convention, you can change "<%s>" part
+			 * to match yours, e.g. it might use "|%s|" instead,
+			 * or if the alphabet is different enough it may use
+			 * "%s" without any placeholder signal.  Most
+			 * translations leave this message as is.
+			 */
+			s = literal ? "[%s]" : _("[<%s>]");
 	else
-		s = literal ? " %s" :
-		  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
-		     Change only the `<>' characters to something else if you use another convention for this.
-		     Most translations leave this message as is. */
-		  _(" <%s>");
+		/*
+		 * TRANSLATORS: The "<%s>" part of this string stands for a
+		 * value given to a command line option, and "<>" is there
+		 * as a convention to signal that it is a placeholder
+		 * (i.e. the user should substitute it with the real value).
+		 * If your language uses a different convention, you can
+		 * change "<%s>" part to match yours, e.g. it might use
+		 * "|%s|" instead, or if the alphabet is different enough it
+		 * may use "%s" without any placeholder signal.  Most
+		 * translations leave this message as is.
+		 */
+		s = literal ? " %s" : _(" <%s>");
 	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
 }
 
