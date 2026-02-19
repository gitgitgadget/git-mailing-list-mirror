Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2003352F90
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524662; cv=none; b=GY2ft04+uBEkfdKUyZ4lCy6turLvu+CMHSp96KV9baYnUF6Hu5b7TJCZUxZ45r6HmHoHnTFIXTb5FZpCFwG34D+3fP+KhfQokXXS+WXOaiOsyssXuw8+LXRnpfNiCyFoETxoNHPCNHri218fBa3KbAdKGjwF9KA27iUhmsoqkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524662; c=relaxed/simple;
	bh=asajYWu2HVdqwaoIbkIla5ZVwPUkLAGGojZPwvi0Wx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KEh/x3gYQg5V1kUrVxCFRgRAjHKXjTCv4YTGRjkeG1uVWembW3ZorvKBZllK9wo2pMnqAkSgnfx9AWTjjIHuapbzOlT8/j7ibqZTXwJ+HxWqswVUwDdXIF+dqsprw7jRI0B7CE/7ZmyITp483zzfBsQhtGlj7LhMP7aTecKbjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TYMi9T4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SCeyEfUX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TYMi9T4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SCeyEfUX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 06DD6EC054C;
	Thu, 19 Feb 2026 13:11:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 13:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771524660;
	 x=1771611060; bh=UPKPsg6hyNJmUdAixK3NvvF9UyjLBpg0Re+efjmRASU=; b=
	TYMi9T4UiuGMYTqw9WlnWMBn9WesIqmuchBGiqOaiH6AYmIsMO+otUE0NJCNZ2PB
	8FbtuKN+hK1p1cWmtnQQ/FKmZ3Xa25ZBL1xBLqFCHcnBJnP54IoWWmEYjmUryEsb
	l7oxKU8cbKjG6ybc9u8WsWuzXj/NkDc9XZM0TEvghoam3YwkLpLt2OOxcqHDeYru
	gErtzUAdwTx51z7RCXHeANZ2kCC0h/8gTB7VASAlpJyOmP69QIzd5hVQgxM4fwvm
	2v8IJend2TXE1B5BoZcroq018z9EF9NZMHCN0V8GUHDzb9IJ4kcP8I7CP9mLIxts
	xQoCMLJseRMRd/xePlAMng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771524660; x=
	1771611060; bh=UPKPsg6hyNJmUdAixK3NvvF9UyjLBpg0Re+efjmRASU=; b=S
	CeyEfUXa+f/LJGL66OBbW0lhANVQunhOvWCfh/JJVTNtq+grbQ99Vxr9F+pjYrDx
	roJYMjuk8cStXuoiMaLqQibIrt5fUU2zcfwEbROHm8s0wNeY961/FOY2P9ch81PB
	5g9BcjS3U0hrRVcbF8UsOagVAIhcpzjBZImlgtvhoHTvm48MDzp+O4R3ViUNj2el
	bqRSs+0v/qftOxi+02EDwO2X1U7xeNxeJQxtWcz6MiSChAjx8D0fxPs7Oqlwgsry
	PmRL49fIKbYGIRGwc1ncgfMw9U4pj7ml0ickScRjlPtEnWh+eHo36eJ0mJFstDsL
	Yw2f/XRoAZnkHFbv/WVFg==
X-ME-Sender: <xms:M1KXaYwEfnTKn7YD98KNw0In1n3HoWvK40tx8LS6s2O4B48N9OgOKQ>
    <xme:M1KXaTKe-oXpEZWPETLAH3TLSEi0xsjf_nRIYNVedCOAJRWpHBjtL-pMziktee2pM
    tHmt1EEIlvt6_xxKdEzli2ITbpoTo1MRkBzps2zNaMNtnGQsaMMhQ>
X-ME-Received: <xmr:M1KXaSraAAtM_JByqI_iloggSafYcU2Nk9Q4AojkETEXtK9WeOAPteaIcoAwoBV9FNbXFmHkQZuOZxkmw6CLA8gm_DNzMh38Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeivddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:M1KXaSLKt4MX_rHvJobVu40U3gmKk6dwcS-L2xR38qKEydUWJAJ_JA>
    <xmx:M1KXaXRZST2CqckyR75usGHrUIBUuFrf8_PJdwEeSH9hVFfG-ebsrA>
    <xmx:M1KXaRuohRF1LpNH1FsTM8WHkQo-3LI_VFLppP32aug134W8EFqTpQ>
    <xmx:M1KXaYYdDkQef6adMVbuYrngHNmrOfNNmWj8aQrW6v5o7nf7rWmrFQ>
    <xmx:NFKXaaxWZoFwpUHdD5x_r7WFIJ-MBkSED0C5Xt_lF6A_Z5eHK6AcLJuz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 13:10:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  peff@peff.net
Subject: Re: [PATCH 2/2] doc: diff-options.adoc: show format.noprefix for
 format-patch
In-Reply-To: <format.noprefix_and_--default-prefix.39e@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 18 Feb 2026
	21:26:18 +0100")
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
	<format.noprefix_and_--default-prefix.39e@msgid.xyz>
Date: Thu, 19 Feb 2026 10:10:57 -0800
Message-ID: <xmqqtsvc61u6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> git-format-patch(1) uses `format.noprefix` and ignores `diff.noprefix`.
>
> The configuration variable `format.prefix` was added as an “escape
> hatch” because “it’s unlikely that anybody really wants format.
> noprefix=true in the first place.”[1] Based on that there doesn’t
> seem to be a need to widely advertise this configuration variable.
>
> But in any case: the documentation for this option should not claim
> that it overrides a config that is always ignored.
>
> † 1: 8d5213de (format-patch: add format.noprefix option, 2023-03-09)
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     `--default-prefix` does override `format.noprefix`. See test `format-patch
>     --default-prefix overrides format.noprefix`.
>
>  Documentation/diff-options.adoc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
> index 9cdad6f72a0..8f632d5fe1a 100644
> --- a/Documentation/diff-options.adoc
> +++ b/Documentation/diff-options.adoc
> @@ -860,7 +860,9 @@ endif::git-format-patch[]
>  
>  `--default-prefix`::
>  	Use the default source and destination prefixes ("a/" and "b/").
> -	This overrides configuration variables such as `diff.noprefix`,
> +	This overrides configuration variables such as
> +ifndef::git-format-patch[`diff.noprefix`,]
> +ifdef::git-format-patch[`format.noprefix`,]
>  	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
>  	(see linkgit:git-config[1]).

The reasoning makes sense.  The ifn?def::*[<something>] syntax is
new to our documentation set, but we'll see soon enough how AsciiDoc
and Asciidoctor renders them.

Queued.  Thanks.
