Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C982D8DBC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580754; cv=none; b=GyKL6FyaHaMWOLHRh7V2iZXd7qQU2oMpJcJ7rQBj9V5BEaxFRuadcVjfbuIG1wVExKqyXhuwL1wO16RYPOnw5JWEE4USAGzNTxBPOOyL+z+Rnql15zWXaLTrpV/Rko/xClTZdnwydory5hakgpJ5Prre0UfTxDVlrRKrUpDvjFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580754; c=relaxed/simple;
	bh=U6fA0GuHlHzbHwVMXoynorvS/rrk6pKidzxeGsZNfig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcBb135D0hdzgenZs3F/oXTj/heI2HGq8dwB+iU2/8s53zirJ40R5iVGpRhzODJa/yLp40K9eHfPKUhqX+1b+hVJ7OB8cpYRBxtKYP1l6Jn7aYD39N3xho8omlBnke4ElglBI0MgeUXyHJy7FXxgzBDIqAuIOxqZL64usp5tK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jc6md5sf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aynxGaJj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jc6md5sf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aynxGaJj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 10C4BEC0BA2;
	Tue, 15 Jul 2025 07:59:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Jul 2025 07:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752580752; x=1752667152; bh=QKZvHIg4i9
	N/FDbuYPwuoSUOJWfEr7YJAezlLfua1ns=; b=jc6md5sfrLZMeEZGpcwwD2EfDb
	aYWdDq15z3PFx9SioPNRrUgkhNClSMC6ku3L/CMLZGcw9SKiEvg8hk7V8wOv9YyN
	8K6CZSR68mjnOyxghSar/eLeOVxKMdte9wttlznu6VpXv5MmSR7lZD97SFwVV/JL
	4MvDsH2RVaaGpbpoaM8FYyFEOC/ZXfGcmxTY9MO1GFqT593Hu/HdeJe9zEmEoRl5
	ZlKotSMUT3s0qAlPk5BvQ8eVBztv3eh7kJX59UFr167dQzkZZAXhcOUg2a00rJWt
	f+DfoYsJCbelHsmqHwi/ATYopwRxpnVf9WsoRKKi9fKzzhvdaTvYfY6kNUvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752580752; x=1752667152; bh=QKZvHIg4i9N/FDbuYPwuoSUOJWfEr7YJAez
	lLfua1ns=; b=aynxGaJjA8YyQC9Wz02LCnxzUKe5teM7nSz6vpJEEflzyc7V7uA
	syDuhkYYsaxz/8S6LBmt3dNNgn++ZTsd1pI3q9jFTEPVVJV//+pawHAylSYRxDhf
	0d9u6Xl3ChjbXajmNyeiZFpJcnGdkcFg+HE9XAHTSs5/RAJtqtI1DbvXS+fCyuwQ
	S9ozJxIlZun/CBbCrjbNQYI0A+ke1N5ArwTBTRWFGqJ6brh7QXGTTRQEGT8AhFOK
	/ZEAe1pml0mZz6txpiKeVhlFvvvFVPpQ5FN80Not+AU6pXze448FovkSLLWfbOVZ
	+uvkaeAF3w8nZVgJ5aC6BHlBd70ahHMPHNw==
X-ME-Sender: <xms:j0J2aG--V-rlL6tALe0z0qy3Tk7ud_FPZ1VK0rqpRbMLeCYD8OHbXQ>
    <xme:j0J2aKijfLQCuxC5S_pi4eFiw6usPICfSV2_HtkLi20ko3V44ytlEAq56JSyus-u7
    kgLnw8kuKFEWohbFQ>
X-ME-Received: <xmr:j0J2aFH-R7XX34IjDl-3GxI7lNH6Jq-O_q4aRCUhlGbHXGu5-xJbI9s8zs1bhA2wWit-QhEEJqZd3OlskuewghgR8EDdhoGtNR3eARDflWTSHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrsh
    hsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:j0J2aB9qqgJ-zgiGYztgaWnohsGvTX8li4JHJP4yz5dL242YzUDpFA>
    <xmx:j0J2aEwE5ILOX39NunnNN5DvQ8gYYqSVZAdwq-F9cRNJEj0_fg6fJw>
    <xmx:j0J2aFPajggNurJqoHEIiXSbeFQfWA7wHWhWh37KLmMjlE2E19VQCQ>
    <xmx:j0J2aB-lZrAYwN_8ZLC8gEN9p6LIG6Vu4S9CRYAZKrKiW4pAPJ72xA>
    <xmx:kEJ2aDRyNmLtYff_y4eRU3vyx0rvefrqfC0QE8aTSQsM0fitwB7lrS0L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:59:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4592c5df (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:59:10 +0000 (UTC)
Date: Tue, 15 Jul 2025 13:59:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
Message-ID: <aHZCipKCPIu8mPly@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714235231.10137-3-lucasseikioshiro@gmail.com>

On Mon, Jul 14, 2025 at 08:52:29PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index a1787a3cc5..dcda0d6d61 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,11 +1,95 @@
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "strbuf.h"
> +#include "refs.h"
>  
> -static int repo_info(int argc UNUSED,
> -		     const char **argv UNUSED,
> +typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
> +
> +struct field {
> +	const char *key;
> +	add_field_fn *add_field_callback;
> +};
> +
> +static void add_string(struct strbuf *buf,
> +		       const char *key, const char *value)
> +{
> +	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
> +}
> +
> +static void add_references_format(struct strbuf *buf,
> +				  struct repository *repo)
> +{
> +	add_string(buf, "references.format",
> +		   ref_storage_format_to_name(repo->ref_storage_format));
> +}
> +
> +// repo_info_fields keys should be in lexicographical order

Style: we don't use '//' comments.

> +static const struct field repo_info_fields[] = {
> +	{"references.format", add_references_format},

Style: we tend to have a space between curly braces and their inner
content.

> +static void print_fields(int argc, const char **argv, struct repository *repo) {

Style: the opening brace for functions should be on their own line.

> +	const char *last = "";
> +	struct strbuf buf;
> +	strbuf_init(&buf, 256);
> +
> +	QSORT(argv, argc, qsort_strcmp);
> +
> +	for (int i = 0; i < argc; i++) {
> +		add_field_fn *callback;
> +		const char *key = argv[i];
> +
> +		if (!strcmp(key, last))
> +			continue;
> +
> +		callback = get_append_callback(key);
> +
> +		if (!callback) {
> +			error("key %s not found", key);
> +			strbuf_release(&buf);
> +			exit(1);
> +		}
> +
> +		callback(&buf, repo);
> +		last = key;
> +	}
> +
> +	fwrite(buf.buf, 1, buf.len, stdout);
> +	strbuf_release(&buf);

Is there any reason why the callback appends to a buffer instead of
printing the data immediately?

Patrick
