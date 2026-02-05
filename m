Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F67281376
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770322080; cv=none; b=PihBl5dAGVUmNGf2Y9s3SAPl6U3O9/Sug8zfwQ0i5E7DBHKdFhSOwDSflVipJHJpMFLw1eLDiZ3eidMYQlK8CNFu5T4GyFblS1Iuc98yE01u/dXOjDcgc+cPRqaKeuKumk4XOM3kH9kXcV5L9kB63KLzlXKzrhJgcCKs8HDI9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770322080; c=relaxed/simple;
	bh=9+WqyWDA3e+5G6xHFQKtRAOVvLaA7Ld6OBbZeV3t4wg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mt+UaZk8+8z6iMu1o4o6XWHt3Hc14yWo5EYxitxrDRl+vNbFIHTG370hB/YIQdW75jjFmb88ltbTXEK7I2hcpfTXqVZTodhsOmlcs1TXXNvS6ztHXoWioPvlhTzx2Y19h8Fdv01NlEXaZ3VXxOmxp2dU74IWyySUjW4nLys6m8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wbispIpd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JKgzqk8q; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wbispIpd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKgzqk8q"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CC49EC009B;
	Thu,  5 Feb 2026 15:07:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 15:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770322079; x=1770408479; bh=LGfgfLdlxi
	9DLmNoj4qkkTlgKhoGHiPfmcAIhRpK1LM=; b=wbispIpd/xwpUdJEq7sRHsyUuo
	6d448BuTopZ5BhadgrCLJRxgi8Ot2QF2OgVNPTJsUHn5oyyz+iaPttjHwbMYQvGU
	WR86f4PgBHA6j4zDGJyl5EJdsPEpVgMU04uBCpk4DdAsnplzqP+FYBGs2jJLOSKW
	axXdkTzjRn3kj8a00Sg1dSZXiYIj/o1GwsH8nhhjtsNWwDFXlVVZVxAKyvxsp35k
	o8gFoxM8aQVKPvW6UBVxH/PrM5zWBm62iJLnkHlLVAEG/EFexQ26FVQoEQAWv5LL
	dorKTJwu/L+oYEBvHegUT9ODJX61ucYSvZqsMHqBns4lmRkHGfvdNRq4TTZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770322079; x=1770408479; bh=LGfgfLdlxi9DLmNoj4qkkTlgKhoGHiPfmcA
	IhRpK1LM=; b=JKgzqk8qq8jp/46ef3K2/H7i/Y3Jx54qhQPclsa6YMEphiVUwGm
	Ux7cpS0aYpV+tsb/nv8+JKPzYa78vPMsIAELsiARLlwCuFwc4F9XuLWHMYO42VEN
	ysUkKDpIbDOl1lpFoPVwL07c68jegV6RDSSB6KzIRPhMiDYEjdr7i8oXoaYoDdQY
	xBYx6JfoD7Sj1DLDB11wKhUBXR+iZPBbC3QHX5hE3rwFRGF1kzAeQpoz3bOXMpR6
	Ol7snJR2LR+9dDnVcKHm9AZGScz9KO/3QWluqc9shdh0vUTwIYiYt0voR5o32wQh
	t4XkYtnSQStgLUBjtSbLMvWfy1rKb2+B46Q==
X-ME-Sender: <xms:n_iEadK9ZniOrxIs1NW_lWCYKoxD5jbRyMzGfCEEqjyZMIRphA_f3g>
    <xme:n_iEaQl2s10Loni_ErSAbgQgUPYT3rYd-ECvsVe1Ca-oIIdpFu9Cd3xmYxE-FLLk1
    TpEFDbrU60WmOl-bVHhxgX0hXYaxtcNxRjPXZvuL6T1ToQlZBvGRyI>
X-ME-Received: <xmr:n_iEaTFgP_SEHsTZO9ZU85VdrgXctEupz21IhWTwjTaOeVlPzd6BPLaDLrpuiloKJW_VqsFlbr75TrCbh2JCrzRa4uNXMvOCQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeivddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifohhrlhgu
    hhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:n_iEaYF-XgP0S_zFQA38UFfd9fpMcRal-3S3VXFbnFf2J7QEN3sitg>
    <xmx:n_iEaYM-MTxh-v-aQbYxZByddg1Xg0T9D9YdyHO4NUJeh5CLBuBuJQ>
    <xmx:n_iEafHQdiQaME4FeLUgMdjXlsPfQOGqBUnwmHuUtaj586CYUzJJEw>
    <xmx:n_iEaXOGTlA3RfeWgzawFseZLCHK5KbNfE2mXar__ayqoUX1cSaksw>
    <xmx:n_iEaYml5FhPA8EJbT83HQrDHUWyQ_fG0t6pXRmWMatkhJjXS6wqqaX6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 15:07:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] l10n: add .gitattributes to simplify location
 filtering
In-Reply-To: <00d6cbf44f88fbd402375a2d41d7f9059d339e5d.1770296405.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Thu, 5 Feb 2026 21:00:27 +0800")
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
	<00d6cbf44f88fbd402375a2d41d7f9059d339e5d.1770296405.git.worldhello.net@gmail.com>
Date: Thu, 05 Feb 2026 12:07:57 -0800
Message-ID: <xmqqtsvvkl7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> To simplify the location filtering process for l10n contributors when
> committing po/XX.po files, add the filter attributes for .po files to
> the repository. This ensures all contributors automatically get the
> same filter configuration without manual setup in .git/info/attributes.
>
> Contributors still need to manually define the filter drivers using
> git-config as documented in po/README.md.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  po/.gitattributes | 37 +++++++++++++++++++++++++++++++++++++
>  po/README.md      | 19 +++++++++++--------
>  2 files changed, 48 insertions(+), 8 deletions(-)
>  create mode 100644 po/.gitattributes

OK.  It is slightly sad that two camps cannot agree on a single
filter, which may allow us to just do

	*.po	filter=one-single-filter-agreed-upon

but I guess this is a good start.  And having sample configuration
lines that can readily be cut-and-pasted to help the contributors is
very good.

> +The filter configuration is defined in the "po/.gitattributes" file.
> +
> +Then define the driver for the filter. Most languages use the
> +"gettext-no-file-no-location" clean filter, which strips out both filenames and
> +locations from the comments. To set this up, run the following command:
>  
>  ```shell
> -git config --global filter.gettext-no-location.clean \
> +git config --global filter.gettext-no-file-no-location.clean \
>             "msgcat --no-location -"
>  ```
>  
> -For users who have gettext version 0.20 or higher, it is also possible
> -to define a clean filter to preserve filenames but not locations:
> +Some languages use the "gettext-no-location" clean filter, which preserves
> +filenames but not locations. For these, install gettext version 0.20 or higher
> +and setup the driver as below:
>  
>  ```shell
>  git config --global filter.gettext-no-location.clean \
