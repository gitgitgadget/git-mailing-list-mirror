Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626A302752
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763228463; cv=none; b=Nn3QO7lC+4QQpCgRQo8tr7Bijsd6JxNz641k3qxKic88L/+m+m1E7k9jG2qwDSXeG45U4H4e0mm/xLFQkdIV5ttMY/oIPXc2/siIuv7xZeS1ClsoWbIS9JeqtQ7eI+3eQGTCaiKeewuzeBvXdWld8LnIjLowxhSTr5bqzrgaLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763228463; c=relaxed/simple;
	bh=vcEBkKEyObcUFbnbX3LhvI8DOWy95RRpY/IiQUb9rew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZIFtwIb+HEZzLwatmnduIrtci96OrK6OHCw5wUK6OvbCmLRa7jL67m/RzNKg2CCBVftqgbIFXgO0l3zGgiWqiceMtRw8g6tIKjgOwlmtVgUyAjQx69v8Fq+Rj0q6opXeCfdTzvTY6UlylEz8XUjpYZEtZKTr/l0mxPhWoEJ4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4d80mG5qT4z7QYY2
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 18:06:54 +0100 (CET)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4d80m54KyQzRpKY;
	Sat, 15 Nov 2025 18:06:45 +0100 (CET)
Message-ID: <773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org>
Date: Sat, 15 Nov 2025 18:06:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff: "lisp" userdiff_driver
Content-Language: en-US
To: "Scott L. Burson" <Scott@sympoiesis.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jaydeep P Das <jaydeepjd.8914@gmail.com>,
 Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org,
 "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[Cc the author of the Scheme driver]

Am 15.11.25 um 11:17 schrieb Scott L. Burson via GitGitGadget:
> From: "Scott L. Burson" <Scott@sympoiesis.com>
> 
> The "scheme" driver doesn't quite work for Common Lisp.  This driver
> is very generic and should work for almost any dialect of Lisp,
> including Common Lisp.

"Doesn't quite work" is unfortunately a description of the problem that
does not help a reviewer decide whether this change is justified. Please
add a lot more details why the Scheme driver is unsuitable for Lisp and
why a new driver is needed.

It is customary to mark changes to the drivers in the subject line with
"userdiff:". Have a look at `git log userdiff.c`. It would be
appreciated to stay away from nerdy tokens like "userdiff_driver" when
the change can be summarized in plain English language.

> 
> Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
> ---
>     diff: "lisp" userdiff_driver
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2000%2Fslburson%2Flisp-userdiff_driver-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2000/slburson/lisp-userdiff_driver-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2000
> 
>  userdiff.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/userdiff.c b/userdiff.c
> index fe710a68bf..e127b4a1f1 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -249,6 +249,14 @@ PATTERNS("kotlin",
>  	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
>  	 /* unary and binary operators */
>  	 "|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|[?:.][.:]"),
> +PATTERNS("lisp",
> +	 /* Either an unindented left paren, or a slightly indented line
> +	  * starting with "(def" */
> +	 "^((\\(|:space:{1,2}\\(def).*)$",

Compared to the Scheme driver, this regular expression is

- more restrictive because it does not permit arbitrary indentation;

- less restrictive because it permits everything that begins with "(def".

What would happen if this regular expression were added to the Scheme
driver? Would it pick up additional and unwanted hunk headers is typical
Scheme code?

Just so you know: The string literal for hunk headers can contain "\n"
to separate regular expressions. For a given line, they are attempted to
match in order until the first match is found.

> +	 /* Common Lisp symbol syntax allows arbitrary strings between vertical bars */
> +	 "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"

The Scheme driver has an similar description of this word token, but it
has only half as many backslashes. Is the difference necessary? Isn't
actually one or the other incorrect? (I did not try to understand what
this version here does.)

> +	 /* All other words are delimited by spaces or parentheses/brackets/braces */
> +	 "|([^][(){} \t])+"),

This one looks identical to the same line in Scheme with a slightly
altered comment.

In summary, I feel like this could be unified with the Scheme driver,
except when awkward false positive hunk headers in existing Scheme code
are to be expected. That's a question that I cannot answer.

-- Hannes

