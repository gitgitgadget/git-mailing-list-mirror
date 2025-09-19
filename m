Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524C284B4C
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309219; cv=none; b=ZPvtLu8LRwxWiVlFFgVgQD5k/mRzqfv1FywB9kH0VfeRXH1WeNWPWhzC5YvH+FdvVmRyJfTCQbpX24rIsL6HltYhNxBx1X709N01KiKN+D+5mPV+xve5OyMQFTtKKrBJmWmbz/V5n5choA6dQwdx8zHMeVGQUgj85JCv7QGLgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309219; c=relaxed/simple;
	bh=hsRcEYoGEZpRGs3KlFLL9bq3c/UT7nVCQUQCVoXxUck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MTDCQJ3K+Gn3d5wa3Ct74sL1vd2cIffaokY+DcjOS2Zdgggl07HtcPLw0VsseZ3oxXcMbYoGFWt+LAn8IeSO/owRyRHUUFHjcPFqXKQcDJ/E3Yhz0d/z8HuY7pXmsH3iMA5Su/eWXK5048uxg5X70XCYT6TdU0BmQlndNeuKGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E5WV9+4x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ow/MXf1j; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E5WV9+4x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ow/MXf1j"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4762C7A013E;
	Fri, 19 Sep 2025 15:13:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 19 Sep 2025 15:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758309216; x=1758395616; bh=7nsHqTSUqG
	RhqwF4sLAEPvHbTR9VhvB12NpuvA0tUhU=; b=E5WV9+4xTR8zs691JTefNC6Vmq
	75NYszstZaAOQ4W9iZaazlR70vXleTZ5sRP8rv167fif1jhAwz/wL1MbS35mIWM0
	E5U51pO6IGcwmogZe1knhLCJEBDxri/IeVLs1VWZlwb4p6QYu2Y5UFp3tL2PTlBO
	porphj8QGmynJLkYbPTAjcgqH04AHPsPS+oEhKrzq4GGZrIwCUJbnvT/+BbveeDl
	DSfUItpoxJkP5jrior9JkOBYLdl67qOxLlLNoperA/q+TB/dAQLFe4cNEF7jSS5w
	aYl+2aR0ghkLUm9M+Y4W/1pl6G4ecTaLfsKQNid5s1XBeOtXonsm/1VPOLzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758309216; x=1758395616; bh=7nsHqTSUqGRhqwF4sLAEPvHbTR9VhvB12Np
	uvA0tUhU=; b=Ow/MXf1jgFMELdpd1GlnJPoCj2YlletleMRvhsG2Eca5nUe6oQx
	DOJZeFgT5hDUwAfsfkWBt/zzoAWJrZKGbKfkW7HMuvnijRP6PDG/SdzVRgd9sIsS
	glwul51tArL0vd9kQPnNUNf6mNGVccsssPGJRB6q6IfJSWWkohPFkZxhTcFy3Yqu
	PmVkZTYoCvR98FR/sgP3Q88S6OkAP/yKklg2nI7tXxnDCaY7LCN0OUOI/5WjqLgU
	4ToSFmaKc7CvhYXLgTR8hrBKIfEOTDj1WupsuiPnz7sjcVwlXDjEadgh15mxzkrQ
	CQ/XKSZyORbxGq4FJ29rVChY8I3TPe5TnPQ==
X-ME-Sender: <xms:X6vNaFl5TzNf3XfjHujfHENQmRo5a3sGA3gidD0vbGqBcW21YUUXHg>
    <xme:X6vNaMUz--5OJsQJMe8uwnMnPkSUtXoak9Hzm0kLUqBo9IdN84UFMm04uG1AjctJB
    VYq99351yScKFYhvQ>
X-ME-Received: <xmr:X6vNaCEztYZ03ZARyY3vvhG2at2ysZri9nqyLPKlAts1VxlPunUCg2v4h-PqZK1d4rYOCXII4FBv2gXmYWA_GGf6Bl4a5S8361rdJok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X6vNaAcomBwgC40uSagJqzoArCresQNLNO4QBlod6pleduyYQWAQ6w>
    <xmx:X6vNaLKuL91mYyCqcEFowmh6BHAXSAw73JqZH8aCeQekaewWPvMHhQ>
    <xmx:X6vNaNGVksKOzMDXeA6JzHOHH5Ssho_H71X_myBQwczt9MKfdSqX0A>
    <xmx:X6vNaGDRIN3s3an4Sr_XzTtZDR3MXUEkc92yRNqGpQWeDg2-4YyykQ>
    <xmx:YKvNaHrWL14DohtvTsbIPx5mrkNFxZy7eTy2fWo4T5I1jgL6EGv7uYod>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 15:13:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
In-Reply-To: <xmqqv7le45t3.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	19 Sep 2025 12:10:16 -0700")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-6-sandals@crustytoothpaste.net>
	<xmqqv7le45t3.fsf@gitster.g>
Date: Fri, 19 Sep 2025 12:13:34 -0700
Message-ID: <xmqqms6q45nl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> We currently have no documentation for how loose objects are stored.
>> Let's add some here so its easy for people to understand how they
>> work.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>>  Documentation/gitformat-loose.adoc | 49 ++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 Documentation/gitformat-loose.adoc
>
> Fails a build, unfortunately.
>
>     ...
>     LINT DOCSTYLE includes/cmd-config-section-rest.adoc
>     GEN lint-docs-manpages
>     LINT DOCSTYLE includes/cmd-config-section-all.adoc
> tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc differ: char 3297, line 176
> Meson man pages differ from actual man pages:
> --- tmp-meson-diff/meson.adoc   2025-09-19 12:04:55.145229743 -0700
> +++ tmp-meson-diff/actual.adoc  2025-09-19 12:04:55.149229734 -0700
> @@ -173,6 +173,7 @@
>  gitformat-chunk.adoc
>  gitformat-commit-graph.adoc
>  gitformat-index.adoc
> +gitformat-loose.adoc
>  gitformat-pack.adoc
>  gitformat-signature.adoc
>  gitglossary.adoc
>
> Thanks.

Probably this should be sufficient?  Not tested (yet).



diff --git a/Documentation/meson.build b/Documentation/meson.build
index 4404c623f0..93fa3dee8b 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -171,6 +171,7 @@ manpages = {
   'gitformat-chunk.adoc' : 5,
   'gitformat-commit-graph.adoc' : 5,
   'gitformat-index.adoc' : 5,
+  'gitformat-loose.adoc' : 5,
   'gitformat-pack.adoc' : 5,
   'gitformat-signature.adoc' : 5,
   'githooks.adoc' : 5,
-- 
2.51.0-409-gb2b0f57e0f

