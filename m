Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC228153A
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416171; cv=none; b=X21IwSnFKA2ecx/2BZ8R4jvdxpsKvHePYKorPSfGgGot5WFYVGvxKPHMnmLIwpwZuHy/k/uYi6c5aba5eM7Dhm2gAoxCLhtBNQ2RJdSQxhJzUBnepwYinawFUdIDPp0tUfUEClDZZlBN/WLcvPtbMB1EGNdnxmopZTnRsfCup+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416171; c=relaxed/simple;
	bh=80O+oQ88aooNJ3HeukUg52sKU+NPA/KlKdwHvYrOvfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tlk7oLJoP/h24N5W0S/t1+FzaKV5A3jdDbo7Dds/U4kLYlIQrOxBneiXmLHef0IlYOqOkxy4cbEpYZyZCRjRzKg+ES18imfRWu7RFPHaajMUg3Y74MtN2atFhfjTl3tELUsPaetzjS7sOCf7SSS0jd5uMdW5EsC1UmPlDPQBA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3YKkaBmF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBGRvpgQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3YKkaBmF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBGRvpgQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AC787A01AD;
	Thu, 28 Aug 2025 17:22:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 28 Aug 2025 17:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756416168; x=1756502568; bh=5K2n2yMoAy
	pWjq633AB+JNGwqaIhBzIOEX/+ErOlGO0=; b=3YKkaBmFXuS7s/3hMcJO7+PaGQ
	4vIwMEL7OGOrM2/49o2dZbOLSlb/i5Uu0crvkCbmBolUW//BU0LnydN3fNPxe1Me
	AD8wHoLicX6bJCS648UeeIfDPFbvsEt9EJovO7a+a+yIQVHOV6hgtgS+tw50CqJH
	65bXfJbF2Zusf1X9sfJhXMoj1I436idutLfp4nkwMsel+KapCghwMPS3xjY7w2jP
	dh6PN8DME96Q7WNoWB8jP5naM5D6MEjfBIQEPGdSBoCuUgjX3zYBraO0vInCL3Nm
	YnCCE+8wVWFsxQDYgwTaD/I0FGLl1V3m8RhaRxy2aPVBWsxUF0w2Q3Ub7lWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756416168; x=1756502568; bh=5K2n2yMoAypWjq633AB+JNGwqaIhBzIOEX/
	+ErOlGO0=; b=kBGRvpgQn0pc9MdJiTkJgRqezFQOLunOyY+x+eyihbs5U+jn8Jg
	XaWg1Gp/bduiz/A1zC5tKBZMATGHrP8KRI9WTzctCmBoiFqPpGnUuc3V0Hv0GQhW
	0Sc8sHUEqTCzkI9VDJopEf/+PeU8rSUm+hus+VWcQVAeBxLxHaI29VDX0xL48PHd
	fbnNRt3D7XlyRRnoe+Hho6aseEeWEUMg6gH8uzwYuL4cma9HnL8ds9av5N0y/tQe
	/omkZpQv49PYRvnhoyZIFMgyAbCNrObOXGQ/bFMHIERNJ9IUE0byUcT0zOgmySpg
	G+iKxKpg6aPWskMK/8un/jgxDrSH8GNli/Q==
X-ME-Sender: <xms:p8iwaAIthPllGhpKaBm3wF3lSV_wvGdeVgdyqZn4_1xQRBDtyyEbHw>
    <xme:p8iwaIlQUoChPfB5aVgVkY-X7e16eyKpnzrF6M02MPOZ89PWj_7Zo30QdM1pVbkBt
    jUkAvWuUMYOFSOb6g>
X-ME-Received: <xmr:p8iwaBLQoIe-zsFDf2Bs8e7YmSEOImC57OcALVXSotqTVzO8tXulC2yqfmEkfv2INazbz7SoMood4tcKXUz-pV45pqtP-B8BnrVG5ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgtrghsrghrvghtthhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgruhhlohdrtggrshgrrhgvthhtohesshhhohhpihhfhidrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p8iwaN6Sdg16TmTNNvAZ3GlLNPF66OKESVqqdJDvWjOo5x2-zTNsXw>
    <xmx:p8iwaF0bSLt9qe-uqWkDBHmkhi7zseSzurDKHWk1zox6p4OGC1ITtw>
    <xmx:p8iwaDerDXRCsJIfWVRP9uNk4vs1E9TDVwi5SyDr86Xs6vxjskmQLA>
    <xmx:p8iwaLdUJznAk4eF3gaAT_pAkRScLGO4esv15C8YbtiOTNoyw4f2cA>
    <xmx:qMiwaEhPGX-0MD-C_kO6sct-b1u6uB4Qa-agdBarWeNqE3ax0heLlPpX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 17:22:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: pcasaretto via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Paulo Casaretto <pcasaretto@gmail.com>,  pcasaretto
 <paulo.casaretto@shopify.com>
Subject: Re: [PATCH v2 2/2] range-diff: add configurable memory limit for
 cost matrix
In-Reply-To: <CABPp-BEDje5dYZHEyYMN6j_LdR5CqRN1cxc0riRK06qK-OxiTA@mail.gmail.com>
	(Elijah Newren's message of "Thu, 28 Aug 2025 10:04:53 -0700")
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
	<pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
	<c81f920fee0ed8672783728fae70b6435e800f82.1756370289.git.gitgitgadget@gmail.com>
	<CABPp-BEDje5dYZHEyYMN6j_LdR5CqRN1cxc0riRK06qK-OxiTA@mail.gmail.com>
Date: Thu, 28 Aug 2025 14:22:45 -0700
Message-ID: <xmqqiki7ta3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> <gitgitgadget@gmail.com> wrote:
>>
>> From: pcasaretto <paulo.casaretto@shopify.com>
>> Signed-off-by: Paulo Casaretto <paulo.casaretto@shopify.com>
>
> The names (and emails) in these should match; I believe the name in
> the From field is set by Gitgitgadget based on your profile settings;
> see https://github.com/settings/profile and set your name there.
>
>>  static void get_correspondences(struct string_list *a, struct string_list *b,
>> -                               int creation_factor)
>> +                               int creation_factor, size_t max_memory)
>>  {
>>         int n = a->nr + b->nr;
>>         int *cost, c, *a2b, *b2a;
>>         int i, j;
>> -
>> -       ALLOC_ARRAY(cost, st_mult(n, n));
>> +       size_t cost_size = st_mult(n, n);
>> +       size_t cost_bytes = st_mult(sizeof(int), cost_size);
>> +       if (cost_bytes >= max_memory) {
>> +               struct strbuf cost_str = STRBUF_INIT;
>> +               struct strbuf max_str = STRBUF_INIT;
>> +               strbuf_humanise_bytes(&cost_str, cost_bytes);
>> +               strbuf_humanise_bytes(&max_str, max_memory);
>> +               die(_("range-diff: unable to compute the range-diff, since it "
>> +                     "exceeds the maximum memory for the cost matrix: %s "
>> +                     "(%"PRIuMAX" bytes) needed, %s (%"PRIuMAX" bytes) available"),
>
> available?  I'm worried the error message will report in users
> checking system memory, claiming they have 14GB available on their
> system, and then reporting a "bug".
>
> Perhaps something like:
>
> +                     "(%"PRIuMAX" bytes) needed, limited to %s
> (%"PRIuMAX" bytes)"),

Sounds like a good idea.

I am not a huge fan of configuration variables that do not have a
command line option.  Assuming that it is not like you'd be doing
overly huge range-diff that would not fit your memory every day,
shouldn't we start this with a command line option without a
configuration variable to gauge how useful it would be for users
with such a need, and then after it proves useful and we identify a
workflow where a user would be passing this option all the time, add
a configuration to allow it always be in effect (with command line
override still available)?


