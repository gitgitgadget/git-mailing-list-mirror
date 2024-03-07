Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492547484
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777505; cv=none; b=AeDr46kP5AnA6h0Mhc2SqSArIcmkqvhBwDbF6xVyKAsZI/ukH7HL04G1UwMQygWnY53vzCN/oaMJxOVNYKnyovUyPQEm8rKE4NBDy/n9gPAv38cG8S0rFhHzKR6NCEq6J0xQDURwTgtB+6oHxDblezwo+cCR+rMgwD2GIyXFlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777505; c=relaxed/simple;
	bh=igd4ubkf4LGqzJeua54MS+pC7pWkFCtVJONoYosg/b4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7d2X4dhu2tgPYicZiu7N9fn54Fqo1DPA2TCFA2AiWcZ6dNLPPEHUecFcXLJrHhGYF1WaL6jj1R3AyXttizNYoTJzzRaoXV62JbQoQwSl24+AZWxqpNeyG6uA7xpQpeNnLrZMtPQ6FArI4QiQp/2bgbWXgRmAw+crbc/QOzbl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fB9bbcwR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fB9bbcwR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1265922561;
	Wed,  6 Mar 2024 21:11:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=igd4ubkf4LGqzJeua54MS+pC7pWkFCtVJONoYo
	sg/b4=; b=fB9bbcwRf93WQDB10E12C2JDWv9dzomMCxRJe3LRFKa++QRhUBq5SW
	9jmAesJyF7k4JEzo/6LfC8Ug8k8ScxqBNvo3wWcq/4hwE2GAZ+gcg2Zk6lWqWGUo
	NWQ2eJxTQvoxSvi9bit417b4I86Iw36yoP04Y8c/t/kw8PN939Fgk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AD2C22560;
	Wed,  6 Mar 2024 21:11:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8834D2255D;
	Wed,  6 Mar 2024 21:11:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Jeff
 King <peff@peff.net>,  Steven Jeuris <steven.jeuris@gmail.com>,  Steven
 Jeuris <steven.jeuris@3shape.com>
Subject: Re: [PATCH v2] userdiff: better method/property matching for C#
In-Reply-To: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
	(Steven Jeuris via GitGitGadget's message of "Wed, 06 Mar 2024
	20:21:33 +0000")
References: <pull.1682.git.git.1708882423691.gitgitgadget@gmail.com>
	<pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
Date: Wed, 06 Mar 2024 18:11:31 -0800
Message-ID: <xmqqv85yokoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 05988538-DC28-11EE-9181-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Steven Jeuris <steven.jeuris@3shape.com>
>
> - Support multi-line methods by not requiring closing parenthesis.
> - Support multiple generics (comma was missing before).
> - Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
> - Remove `instanceof` keyword, which isn't C#.
> - Also detect non-method keywords not positioned at the start of a line.
> - Added tests; none existed before.
>
> The overall strategy is to focus more on what isn't expected for
> method/property definitions, instead of what is, but is fully optional.
>

Roughly in other words, we assume that any file the end user throws
at us is a well formed program, so instead of enumerating all valid
keywords and limit the match exactly to them, use a pattern that
would match valid keywords (both currently known ones, and anything
the language might add in the future that we do not know about), to
match with anything syntactically plausible to be a definition?

It does make sense to start by assuming that the end user data is a
valid C# program.

> Signed-off-by: Steven Jeuris <steven.jeuris@gmail.com>
> ---

> diff --git a/userdiff.c b/userdiff.c
> index e399543823b..5a9e8a0ef55 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -89,12 +89,18 @@ PATTERNS("cpp",
>  	 "|\\.[0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
>  PATTERNS("csharp",
> -	 /* Keywords */
> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
> -	 /* Methods and constructors */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
> +	 /*
> +	  * Jump over keywords not used by methods which can be followed by parentheses without special characters in between,
> +	  * making them look like methods.
> +	  */

Overly long comments (I'll wrap them while queuing).

> +	 "!(^|[ \t]+)(do|while|for|foreach|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
> +	 /* Methods/constructors:
> +	  * the strategy is to identify a minimum of two groups (any combination of keywords/type/name),
> +	  * without intermediate or final characters which can't be part of method definitions before the opening parenthesis.
> +	  */
> +	 "^[ \t]*(([][[:alnum:]@_<>.,]*[^=:{ \t][ \t]+[][[:alnum:]@_<>.,]*)+\\([^;]*)$\n"
>  	 /* Properties */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
> +	 "^[ \t]*((([][[:alnum:]@_<>.,]+)[ \t]+[][[:alnum:]@_]*)+[^=:;,()]*)$\n"
>  	 /* Type definitions */
>  	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
>  	 /* Namespace */
>
> base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
