Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C926A0C7
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839136; cv=none; b=gil84L7+bj0CnmQupr7TvYS44ymRhZEGcWY+pqplA+sAcXJrPcevTY4jKydkkCwwTdk1ae8WZURpS62x2T/b0sQv42BrqojXzMF9MitGstIRHvXlpZcHmezKVqq7SgwC5AcJDlFZQsItvNkinwjPOpQMWBryZ9bkN/o2F8AnT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839136; c=relaxed/simple;
	bh=IXtRiN0m3n4p6GbQppdBpwVh2ZR8E9a4KOMjSpvOoaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gf47viK6z7BvqtWl5eUHQXLyPhS1u4MX6rwfEKW6VbMOwNsu9tK7T3Y40yTxU5ZHGPMgZrqcmbY+scWb6FhJ8lk5GUlAa0VdSGo/xRuIoItAsjaLJQQfRGB1t7YaWziVUkN6mxYrcs8oTwu7e08RK/RyeFeM4JK11w0FacaFr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NLzL8BWS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J1gZ5dgi; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NLzL8BWS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J1gZ5dgi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DF107EC0AFB;
	Fri,  6 Mar 2026 18:18:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 18:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772839134; x=1772925534; bh=7CNqE5Hxw7
	lWZnxwJZHuVFSbI5Ho5G5SyOfDCOjiM+E=; b=NLzL8BWSXAUbBJ6N812Sg9H1HE
	4mkKWA6IIRnq0KrEXZspcWMC8e3sST6P8F6gNp5Gd9WLm+btaDjAjJ83ackziDmO
	bujLeqUeRJtBKzxF3W6rVR8Lf+Dv3pXlNa38kQSzTWOY3OQnzFj6Svj5IqNVBBal
	lrlq3tEM76VPxtCzirlf+HfnTjrrlwnD2jVr/Rd1ZtR5/J8gqDyPgdgrCD4Qxii2
	rBPgRaEmzjEp4yFapoLwZP1ZNc+367LfcvSD9fz6o0T60FhATMrVZuHqAT5BuBYB
	vkRnreDQJI+QNoaOG83sS+kG//5RHsNZk7oKf5imuKn5PQB077Ad2+B1n4EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772839134; x=1772925534; bh=7CNqE5Hxw7lWZnxwJZHuVFSbI5Ho5G5SyOf
	DCOjiM+E=; b=J1gZ5dgilhL7XmUwIfs0peSKeh/ltkuPE1FaS5NgZCDkHXe6kR3
	VxNU1F4kb7HAaTn7UDCBW3dO2iBcznEONiyu6bcedevJJXGBC8l7VfEjOunaqWgp
	olc4YNmzDE8eDjsODGwnLYUsyRsMEew92ywjKQ6QHg4H0wqIT4MRsMeCloTBPV/Z
	d20yGfI8w0kaY5BhOHbwIKo35FivifLdKRltA6y0NAkIZmxcvzopz7y5vCICYC1E
	GFtFDAbJKC9s5ZY3YtQ/tsEXcihUlZBhB2ld7E2a9zaL1BZfVl9KlP3iywhxKSoq
	FrNQfkJh6CCFCJXS0+zpCcKe6VTxGw9vIGg==
X-ME-Sender: <xms:3mCraX_NT9xfvKnlpEMTOO3WfT9XXCrcI-_XzYX5cgKSsaIvZwXUaw>
    <xme:3mCraatZ3Xa5YdkCMqTujZBxFdTrlTAx1-L0mtDptWIPPuxcKUS38QoD89C7dZyXa
    csrEgxBqvjlvGKxHdwibp5eikaieOkIo5-WpP1JaT7fdbshy_jZ5w>
X-ME-Received: <xmr:3mCraaDdXNzA9d4ul1XyYVmzdKseZI0e-7OH7Z1ZHB9atfuvrox-jYaD1LWxS6npnfNmclGzdcMmJsI8TqDWyr3_GS0XFqRJpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3mCraSUrSCvDy84fMSqRnTFBhGNMjEdemCKV2sq8JtM1eGLr3fxCJw>
    <xmx:3mCraYDS2s3wKs0jEZyGR_psJv3U0QU12a7rKDc5-C0ciN3PDW6VZA>
    <xmx:3mCraV_u4JuE7Ah4SkAAeYc3-PE9XYZh4SXiu67jsB68WhyjKgr1Lg>
    <xmx:3mCrafHrbR6-YU5W5ia0Cg1Xo_pHb5Dy12OBdmk4Llh_HB2ZNTM4oA>
    <xmx:3mCraRAw92qHWYxMpFV4eOr6G7LbuCyp50sfYsUOCU0tO1yfmWtdPK1d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 18:18:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 5/5] docs: add usage for the cover-letter fmt feature
In-Reply-To: <1a4ba6dc338e82df1d58c277031d3ec2ec2ccf83.1772837832.git.mroik@delayed.space>
	(Mirko Faina's message of "Fri, 6 Mar 2026 23:58:48 +0100")
References: <cover.1772232373.git.mroik@delayed.space>
	<cover.1772837832.git.mroik@delayed.space>
	<1a4ba6dc338e82df1d58c277031d3ec2ec2ccf83.1772837832.git.mroik@delayed.space>
Date: Fri, 06 Mar 2026 15:18:53 -0800
Message-ID: <xmqq8qc4wnqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Document the new "--cover-letter-format" option in format-patch and its
> related config variable "format.commitListFormat".
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  Documentation/config/format.adoc    |  6 ++++++
>  Documentation/git-format-patch.adoc | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
> index ab0710e86a..151e574052 100644
> --- a/Documentation/config/format.adoc
> +++ b/Documentation/config/format.adoc
> @@ -101,6 +101,12 @@ format.coverLetter::
>  	generate a cover-letter only when there's more than one patch.
>  	Default is false.
>  
> +format.commitListFormat::
> +	A format string that specifies how to generate the commit list of a
> +	cover-letter when format-patch is invoked. This config is coupled with
> +	the `--cover-letter-format` format-patch option command and they both
> +	accept the same values. Default is `shortlog`.

Let's not call "configuration variable" a "config".  When a variable
gives the default value for a command line option, we usually do not
say "coupled with".

    When the `--cover-letter-format` option is not given,
    `format-patch` uses the value of this variable to decide how to
    format the title of each commit.  Default to `shortlog`.

perhaps?

> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
> index 9a7807ca71..42d2633860 100644
> --- a/Documentation/git-format-patch.adoc
> +++ b/Documentation/git-format-patch.adoc
> @@ -24,6 +24,7 @@ SYNOPSIS
>  		   [(--reroll-count|-v) <n>]
>  		   [--to=<email>] [--cc=<email>]
>  		   [--[no-]cover-letter] [--quiet]
> +		   [--cover-letter-format=<format-spec>]
>  		   [--[no-]encode-email-headers]
>  		   [--no-notes | --notes[=<ref>]]
>  		   [--interdiff=<previous>]
> @@ -321,6 +322,15 @@ feeding the result to `git send-email`.
>  	containing the branch description, shortlog and the overall diffstat.  You can
>  	fill in a description in the file before sending it out.
>  
> +--cover-letter-format=<format-spec>::
> +	Specify the format in which to generate the commit list of the
> +	patch series. This option is available if the user wants to use
> +	an alternative to the default `shortlog` format. The accepted
> +	values for format-spec are "shortlog" or a format string
> +	prefixed with `log:`.
> +	e.g. `log: %s (%an)`
> +	This option is relevant only if a cover letter is generated.

Somewhere in this paragraph, it must mention that format.commitListFormat
gives the default value when this command line option is not given.

Everything else in the changes since the previous iteration,
including the parameter list to generate_commit_list_cover() that
shows the level of attention to details, looked great to me.

Thanks.
