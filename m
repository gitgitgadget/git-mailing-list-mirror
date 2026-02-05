Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35B2F3601
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323754; cv=none; b=cl+F8xiA4H0wABCpr8D/ojXAgebEUQ7io9meCvHoUXuvS5vqAx2F4+ZJY7ZNVY5WoEbjgfOBedzv4YAA2rTiIqKf4dcg/Ks3ch9g/EwMSiodBu+7MtOPkp0Dizt3Prz62KV2AcOgb3hSAs8RXtpLNjPg9ski5mDtpcHmY6WiUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323754; c=relaxed/simple;
	bh=x5mzsi2guqC+9waiOpLQk7gVOQrQnBavoxPYOvBRkWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PtEDFsVTdyWYPjphmBNVgjXBgPYTIeWtXc4/eM8z5jR+PAqSUVFQkeNOGj49Kjo/3XFJuWLCT8yAcH546QknaFIyt/r38c+LhRaOR7mwfIvDhJmIzBWvXTgGC3KMVtzVAUnJSifsTT0+m8DcX39QMoHjI9XJGfGZYJZ1a71JJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z16G/zdz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VONcIx0O; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z16G/zdz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VONcIx0O"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 822681400142;
	Thu,  5 Feb 2026 15:35:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 05 Feb 2026 15:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770323753; x=1770410153; bh=N+KJPOwL2l
	MrI4yBBVL79K4i22SJA83Ivk4ULcrj4/s=; b=Z16G/zdzUtGSqTFFDTdGlClqXX
	jiB89Y6+OJBp4DFyc716YrK82eBaWbErDlk0OOW4SHGU+8jNHMlV6FMoiC8vyJ13
	RHxZ4+4TRYoUDcLl6k+9lq1YUtru5+zQQB59/KOmxCwNAg7cqpOd23ltvyBb9aV7
	gMb71d0Efo2VlKexyoWPSh9gbGJVvDqx7AEQM50QJWuq0NqxOu/NUS5Of1n/Xxqz
	gsQCfxrAUaimJCC6W5YFCRCAhvOOTwl0Z9yb4IuF+7TMTIU+VljFw/gRT55k4qzJ
	Ssk0ZFEBTcjBrBIjajjlRK0/X75i59wDOzXwKZSl3XtMRSpsV2IDQtqU+ztQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770323753; x=1770410153; bh=N+KJPOwL2lMrI4yBBVL79K4i22SJA83Ivk4
	ULcrj4/s=; b=VONcIx0OGecd0LjnUb+2ARaG+GNtIZAnEXGFGmHSZ0EcvhYYVTa
	SFQIoR/FJvIEBNefgzQVcOULGeixpnGCSMDdqXvP+BH5EBsxrPhZ+b7ysnh/rwZE
	vZa3bakE+aJZq488gqkZ2k12ZjRe//JEEX9NmPyLvhvsXlICVlpLrEdRa6ppopnu
	J1EpytMLslGEY4BJJL/8G+LChAiblJvuqPcNVwntdTv6rZC57DphamGaNaGBgziY
	qLs8CiRlfbzCxJZvTcoqhwKLobA0tXivT4YOqRqD2Rn2TZrFWZdNncVVwz9R3E9+
	JlIsUvQAW1QH0KtajeW3lTy67qbq9ToajqA==
X-ME-Sender: <xms:Kf-EaRWF1c3ft7Kkz-b4M1fO-3WJY_KI-IqmRgF02Sf9pX2bGfdBIg>
    <xme:Kf-EaZB_qBDGKauaFWPHswCGWQDogRC50Wt9jDx9kGT91rKHlpO8MWf6dKh1vsSEV
    gMx5ztd6VWysq62VTiZbaIFM_luWWa43GIeDr63rJ2zoUvKFNSP0q0>
X-ME-Received: <xmr:Kf-Eaay4lydoH6tyeb6Wl84r7ZJ-znCqW4lUzbBofSRhRrc4yPtO47P6hf0j74r9WPp4v15CC9VWmlHPyCPdtPtlwGzwWZfpgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeivdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Kf-EaeCs3npVBgXqoHzrTu5ruC9JcTLR_cVUk8AuKg6fHq27zS4Rtg>
    <xmx:Kf-EafZWAmnegXOBwPCBqPxnJMDax-Ur-dCPQPxUrXOAYYOrBch9wQ>
    <xmx:Kf-EaeiLeVlVwOF9QnjUAskenmE-G_HuejdAL6uhJ06o1RElQMsG4g>
    <xmx:Kf-EaZ4LJuTy_A9Q5CChQB2nkFJKEKWwG4G0n1lwIPffrFT5xOy12A>
    <xmx:Kf-EadA9C8FrN4EbEa2hKVpdIynuRKnwz6G9HCtxFU968dtJFvRbHZQF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 15:35:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] l10n: README: document AI assistant guidelines
In-Reply-To: <71bfd9231e339cf43af86cfbffbbdde753d3fb82.1770296405.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Thu, 5 Feb 2026 21:00:28 +0800")
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
	<71bfd9231e339cf43af86cfbffbbdde753d3fb82.1770296405.git.worldhello.net@gmail.com>
Date: Thu, 05 Feb 2026 12:35:51 -0800
Message-ID: <xmqqfr7fkjx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> Add guidelines for using AI tools as optional assistants in Git
> localization work, while emphasizing human translators remain in
> control.
>
> Also update `git-po-helper` command examples to include the
> `--pot-file=build` option.
>
> Example usage in prompts to AI assistants:
>
>   - "Update translations in `po/XX.po` following the guidelines
>     in @po/README.md"
>   - "Review all translations in `po/XX.po` following the guidelines
>     in @po/README.md"
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  po/README.md | 294 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 291 insertions(+), 3 deletions(-)
>
> diff --git a/po/README.md b/po/README.md
> index ad7f72ba83..6ba082376a 100644
> --- a/po/README.md
> +++ b/po/README.md
> @@ -227,8 +227,8 @@ L10n coordinator will check your contributions using a helper program
>  (see "PO helper" section below):
>  
>  ```shell
> -git-po-helper check-po po/XX.po
> -git-po-helper check-commits <rev-list-opts>
> +git-po-helper check-po --pot-file=build po/XX.po
> +git-po-helper check-commits --pot-file=build <rev-list-opts>
>  ```
>  
>  
> @@ -430,7 +430,7 @@ There are some conventions that l10n contributors must follow:
>    your commit:
>  
>    ```shell
> -  git-po-helper check-po <XX.po>
> +  git-po-helper check-po --pot-file=build <XX.po>
>    ```
>  
>  - Squash trivial commits to make history clear.

Is everything above specific to using AI assistants to help your
translation process, or do people who do not (yet) use them also
benefit from these updated examples?  If the latter, it probably
should belong to a separate patch.



> +AI tools, if used, serve only to accelerate routine tasks. They do not make
> +decisions, do not replace human judgment, and do not understand cultural
> +nuances or community needs.

They may very well do any of the above.  It is your responsibility
as humans to monitor their decisions, judgement, and understanding,
and countermand them as needed.

> +### Preparing your translation environment for effective AI use
> +
> +If you choose to use AI assistance, investing time in preparation will
> +significantly improve the quality of AI-generated suggestions:
> +
> +1. **Maintain a glossary**: Add a "Git glossary for XX translators" section in
> +   the header comments of your `po/XX.po` file (before the first `msgid`). List
> +   key Git terms with their approved translations. AI tools can read and follow
> +   this glossary.

A few random sampling of po/XX.po files seems to tell me that this
is already the case for some languages but no all of them.  Perhaps
refer translators for other languages an existing example to help
them start their glossary in their po/XX.po file?

> +2. **Keep translations up-to-date**: Regularly sync your `po/XX.po` with
> +   upstream. AI learns from existing translations. The more complete and
> +   consistent your PO file, the better AI suggestions will be.

I am not sure what this means.  When you are working on updating
translations for your language, you'd want to be working from or
near the tip anyway, regardless of what tools you would use, no?

> +3. **Document style guidelines**: If your language team has specific formatting
> +   or style preferences, document them in your `po/XX.po` header. AI can
> +   incorporate these guidelines into its output.

If we have an example in po/XY.po that translators to other
languages can learn from?

> +4. **Choose appropriate AI coding tools**: Evaluate and use models and tools
> +   that work best for your target language. Different AI models have varying
> +   levels of proficiency across languages. Test multiple tools to find which
> +   produces the most natural and accurate translations for your language.
> +
> +
> +### Technical guidelines for AI tools
> +
> +The following sections provide technical specifications for AI tools that
> +assist with Git translation. These guidelines ensure AI-generated suggestions
> +are technically correct and follow Git l10n conventions. Human translators
> +should be familiar with these requirements to effectively review AI output.

Are the subsections of this section meant to be fed as part of
prompt to the tools?  Otherwise they look mostly repetitions of what
human translators already have learned elsewhere in the document.


> +#### Scope and context
> +
> +- Primary files: `po/XX.po` for translations, `po/git.pot` for the source
> +  template (generated on demand; see "Dynamically generated POT files").
> +- Source language: English. Target language: derived from the language code in
> +  the `po/XX.po` filename based on ISO 639 and ISO 3166.
> +- Glossary: Git l10n teams may add glossary sections (e.g. "Git glossary for
> +  Chinese translators") in the header comments of `po/XX.po` immediately before
> +  the first `msgid` entry. If a glossary exists, read it and keep terminology
> +  consistent.

This overlaps "Preparing #1"; do you want to cover "Preparing #4" as well?

> +#### Quality checklist
> +
> +- Accuracy: faithfully conveys the original meaning; no omissions or distortions.
> +- Terminology: uses correct, consistent terms per glossary or domain standards.
> +- Grammar and fluency: grammatically correct and reads naturally.
> +- Placeholders: preserves variables (e.g. `%s`, `{name}`, `$1`) exactly. If
> +  reordering is needed for the target language, use positional parameters as
> +  described below.
> +- Plurals and gender: handles plural forms, gender, and agreement correctly.
> +- Context fit: suitable for UI space, tone, and usage (e.g. error vs. tooltip).
> +- Cultural appropriateness: avoids offensive or ambiguous content.
> +- Consistency: matches prior translations of the same source string.
> +- Technical integrity: do not translate code, paths, commands, brand names, or
> +  proper nouns.
> +- Readability: clear, concise, and user-friendly.

The fact that these are important does not change if you use AI
tools or not, no?  As I am not sure the purpose of these repeated
instructions in the "Tech guidelines for AI tools" section, I've
trimmed most of the contents in it here.


> +### Integrating AI tools into your workflow
> +
> +If you decide to use AI assistance, here's how to integrate it responsibly:
> +
> +
> +#### For AI tool developers and users
> +
> +When building or configuring AI-assisted translation tools:
> +
> +- Use the quality checklist (above) to score or filter draft suggestions
> +- Apply the `msgattrib` + `sed` commands to extract relevant entries for processing

Referring to the section (e.g., "commands listed in the 'Locating
untranslated, fuzzy, and obsolete entries' section") would be
clearer.  You have necessary commands ready to be cut-and-pasted
there.

