Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978321E571A
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743544086; cv=none; b=Rv0hqCHedNW6ovDN/kWPGt5IylSSjWSRWSEODoBzrQ21++S1YREsN5yQzYdxWDyjIXfDFcBJ1lwEL0Su8IafP04YeU16BIZzfGrjk9rLfxTG91foophSKZLIuM74v6DEfGr9WefBwuJK0cHY9yU8vlWSaQordEMXfzSTqFxsSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743544086; c=relaxed/simple;
	bh=u66dIZjH2o1vZepU1By+RfYHI97Jf49ghu8hv7Cae4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=unJDPooF2a5CdgX2iGn2150rLYW76oaDb7+FzEHe0HfwWcFohhx8DKAvlpb5ii8Yu+aLTpOtLk/l7niegwl8RH9OhHSZnBqF1UYhwY4BKu4xXV/QusqFq2z1+Kg+XFuB4+x/fko3m5mH42AdcyeYIHO9lONzP3YrcyUfjxwCAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o+WORyaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=saGMGnNm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o+WORyaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="saGMGnNm"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A2E111383DD0;
	Tue,  1 Apr 2025 17:48:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 01 Apr 2025 17:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743544082;
	 x=1743630482; bh=3+aZIp0EezwOtwtNkSYCm1evQalrlEK+sUTP5pdELYk=; b=
	o+WORyaLXYYF0sZrZUPA2e9o2kjJ3vYDjurJd/VdztEaD0nlQJiQujS0SXZU0Cln
	p1L1Ur2e+6/sCnQ3B7X40TsgHx9VkVC+nm8mnwcFS2vQ2qR1nu4s36tEpfkargI0
	PUF2PSw8gR4WvEJwnLdkT0y/9x0XeL0iyGCgC2079WROWM54E3li6njWlcYidI7W
	Apc50DiYsaOY2C2Oi8KgJSiCmv72ikvBa/1Fm9K6IQVOMlnFLMoOczuNUtBSL/Wr
	ebFYiCU0z76LtyS6V1HRxHhrhLYFvu4cV42m/slqz8PEF0OHzGNDAD7dt+WDZa++
	kUx8Jfzq7ehtBjkrdTmQww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743544082; x=
	1743630482; bh=3+aZIp0EezwOtwtNkSYCm1evQalrlEK+sUTP5pdELYk=; b=s
	aGMGnNmKkTxhYg4OwqYvbqHMAk4ffhCXwfs7lE7tP8PEqlGUkl3nKBVmksL+SfO9
	kRMOn2VHQ/uiVtfPCQsxSRtJiNOfGT5RZH3ok1SPemkgns2rHaF8rsIdjmD792dL
	o6i97kKiHHRoLjIcHT1B5Ym9aq1k+88ySFIfKSzXJGkYhcqFMh+zCDMtRLbdmhK8
	OGf55V8usqIuQPPOacAZsFyZUoeUSlmN/ifn9NwvvHIJ3NnMFw0IxT77B1OLTbvN
	7sms9UV79IMcmW9EIrOw0OHFvnAqXJHdrVOY6/fjcD67JHzDgSOOmjd+y62k5JJb
	vc9HOufrjN5N7jxWtrT3Q==
X-ME-Sender: <xms:El_sZwsJEOjnmGona4Z-FdjaZokNuJzh4403O0aTqbM4wAh07rzpEg>
    <xme:El_sZ9fXDV9Oj92-Wqkfz63VyopAEvJldCrT7Rt6BIvrmk2bGNsRMdeZt10IdQfxv
    U536lRvmO06NYu9VQ>
X-ME-Received: <xmr:El_sZ7xoZEzQWHNDuINdYI7E2psicNFO-o0lte4xkqKjAJUtvme_MTyvczTpcLAg3atBTxNvN8mq80khgEk_Y3qfOCC6VwpaVwnAzRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetleejuefghedvheejjeefvdektdfg
    tedtffeiueetudeuheehffetgfehudffheenucffohhmrghinheprhgsrdhinhdplhhinh
    gvshdrmhgrphenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:El_sZzPsDJfIzM5WXvnF7NHOyEx2lNcNN7DOkMEulFCgrB-NEiPtSA>
    <xmx:El_sZw8o_iGfwmctF3KOT1bmHmflHHm7CzqWcXakGI-odHb9ovpwuw>
    <xmx:El_sZ7Uk70HYFkZxv2hd3YOMXjedG5AizCgMylHfEsCADCvTwMVCQQ>
    <xmx:El_sZ5fQRi2MOmVQfF77gLslnKLIUJT5j_WXjm2MCmVdXl06FIs9eQ>
    <xmx:El_sZwzHjfBV2Cbb343aKzAxO5ZuuDz3wDAnIoX5-qXm3Zh4bKccSck4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 17:48:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,
  Johannes Sixt <j6t@kdbg.org>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: fix asciidoctor synopsis processing of triple-dots
In-Reply-To: <20250401110811.117851-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean?=
 =?utf-8?Q?-No=C3=ABl?= Avila"'s
	message of "Tue, 1 Apr 2025 13:08:11 +0200")
References: <Z+rUsCW0zEb8kAK8@szeder.dev>
	<20250401110811.117851-1-jn.avila@free.fr>
Date: Tue, 01 Apr 2025 14:48:00 -0700
Message-ID: <xmqqecyba6zz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

> The processing of triple dot notation is tricky because it can be
> mis-interpreted as an ellipsis.
>
> Another issue is that the formatting of synopsis paragraph in
> Asciidoctor spits out another asciidoc formatted text where verbatim
> text formatted with backquotes must have surrounding separators in
> order to be properly detected, even if they are sticking to another
> text.
>
> The special processing of the ellipsis is now complete and takes into
> account the case of `git-mv <source>... <dest>`
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/asciidoctor-extensions.rb.in | 8 +++++---
>  Documentation/diff-generate-patch.adoc     | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)

The .gsub() changes seem to interact with your "doc: fix synopsis
analysis logic" in the series that updates reset/mv/rm documentation
mark-up.



> diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
> index 2494f17a51..0ded90c28b 100644
> --- a/Documentation/asciidoctor-extensions.rb.in
> +++ b/Documentation/asciidoctor-extensions.rb.in
> @@ -49,7 +49,7 @@ module Git
>  
>        def process parent, reader, attrs
>          outlines = reader.lines.map do |l|
> -          l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
> +          l.gsub(/(\.\.\.?)([^\]$\. ])/, '{empty}`\1`{empty}\2')
>             .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$]+)}, '\1{empty}`\2`{empty}')
>             .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
>             .gsub(']', ']{empty}')
> @@ -72,6 +72,7 @@ module Git
>            %(<inlineequation><alt><![CDATA[#{equation = node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
>          elsif type == :monospaced
>            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2')
> +              .gsub(/^\.\.\.?$/, '<literal>\0</literal>\2')
>                .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
>                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
>          else
> @@ -100,8 +101,9 @@ module Git
>        def convert_inline_quoted node
>          if node.type == :monospaced
>            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
> -              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
> -              .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
> +            .gsub(/^\.\.\.?$/, '<code>\0</code>')
> +            .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
> +            .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
>  
>          else
>            open, close, tag = QUOTE_TAGS[node.type]
> diff --git a/Documentation/diff-generate-patch.adoc b/Documentation/diff-generate-patch.adoc
> index e5c813c96f..7b6cdd1980 100644
> --- a/Documentation/diff-generate-patch.adoc
> +++ b/Documentation/diff-generate-patch.adoc
> @@ -138,7 +138,7 @@ or like this (when the `--cc` option is used):
>  +
>  [synopsis]
>  index <hash>,<hash>..<hash>
> -mode <mode>,<mode>`..`<mode>
> +mode <mode>,<mode>..<mode>
>  new file mode <mode>
>  deleted file mode <mode>,<mode>
>  +
