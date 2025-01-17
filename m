Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33E16D4E6
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138396; cv=none; b=hmVZ5WmCW81wONgUU6bb3AX/CMvO0rhuHHci8LBMNdLKIazrZyXdOZija+YCtD+uTTiHfEUEOKdjt6NQkp3a5+HR2sW+0txRYhyYoEN87LAMuhkI0Sjri+6F+kCa9jPpAmBA+xjl2X2QV5+oH1IvWtw9GEDkzi58bT+r0pA22iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138396; c=relaxed/simple;
	bh=4GWoz1RB4q1KElaI+mox/sMoZmhQbA20O+MODuJyRO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lglJ1axvqfpZf55Hfts8gKJWCxK+miV/GiZ7D8ed1UkeJZcoN6T4tKCFMMFVPl/qGO6Ap4FNk24qwuzVv55ElDWEOiS2kSNGwDpzartVNSLVIXEzw9PQyaPb/php0MOAtuwqxyDfScAjmp9mLp524AZ/8OwmtoKSR5A108VVvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wx5gNWWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUUdP0Pw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wx5gNWWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUUdP0Pw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFE031140145;
	Fri, 17 Jan 2025 13:26:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jan 2025 13:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737138391; x=1737224791; bh=4P3xMSxH3j
	9orIk5CogGUpnyvpRqq+O83d5MauM3aJc=; b=wx5gNWWleL6Kx91NAGnYpiFxrd
	TZyis6FKJbYkfbjhTFmrjzwyCxY/TsDIeVp0tQar6b7ZHA7YSmLMrNOmAeNwZhPi
	IKLti1sbN41bzifAAKrMPqHIqvn8tX5AS6BdxNaSfiF0gwZ7I7x/+0Fczkk8q9rx
	gRyN8vH7gj9uDgVlN8S/+2frhIGy8XCNFmD9TUta7UUcS1XhxgUQv62rKJNrQdzh
	4l50Q16qVQJJuQ+V9/VfPXzIPcCX+jZE5giTZUBmi4gEIiqACJVS0y8un2RVkJOL
	eLgX5gASftucm2bLjw3V6UxM9YKNfSmD/vMa4dneeye1GPETHrRYhtwrKKWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737138391; x=1737224791; bh=4P3xMSxH3j9orIk5CogGUpnyvpRqq+O83d5
	MauM3aJc=; b=gUUdP0Pw0A7x01zSalarTQs9I5XLvdm90hUGE3xeIHnsVIzdhRk
	EyoFyWlEIthzN73UK4/MJBf2QmZcZCRca+K9H5IJ/jSi/TWSms8fyCYfOyNlFZBq
	FmpgdGGJIQseW/9f3vxTmhi3d5PGBGdLvcVNYGj7hGWUEXzznuk6LvuPcTTWhz71
	b1MeQriKjIC2NacfvhgpmRrkXWy2F53tmFo/f6NCiaxrPR11DedCVx8f/iJJs9O7
	NhLhRG5ZrvLrJshLWtsqJbpyVd2J3RxqEiCgcW2nxZPzRTp3A19oeU1l71avZ7/+
	OL9q/Zc1eO7qqYJLJItG4rH8mLHdUpn01lw==
X-ME-Sender: <xms:1qCKZ-M7HsnDeUR3mTQRylBHt9kJOEuUQH2z1l8-GWB-HDWBFQHhOQ>
    <xme:1qCKZ8-N5yJCKLxHQMd2SEcJUEtHDHj4GaWjxYL0L9UbsEmnmLsSIX8OI7tqgoKZJ
    eiHfTzK-bGU1_xheA>
X-ME-Received: <xmr:1qCKZ1SzMxqM9Y-qGizJBp1qL1WgbLotvhAAmBM8WbAuX8EmGa12qzug0SVmQwT7mzah5W_T-J3Mbg6QztFbrMmvWp9CYEx8ri5t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:1qCKZ-s-dAnhmGFKfA7-KWeepSxK2TjFik9eWtzp3Jh42JGdxvRSLQ>
    <xmx:1qCKZ2ew7X2-9-tuYSLB5vgq-6j-SOG8ITOBOTxi64GlomCPHrBz5Q>
    <xmx:1qCKZy1Ci5y6hiGBI7j5PvrRbTFE_k_z63sTk_DrTZQNbY02w6wnCA>
    <xmx:1qCKZ68s2T7Pe0p0469nySesUkhDdAg2bShe9dJFD9ZsJAqqTgXFCw>
    <xmx:16CKZ822dS0UjC6_vheJqKDXaju55u9I9Vjf-WclSvXtV1xPqM6Uy1fp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 13:26:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/6] version: refactor redact_non_printables()
In-Reply-To: <20250117104639.65608-2-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 17 Jan 2025 16:16:13 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-2-usmanakinyemi202@gmail.com>
Date: Fri, 17 Jan 2025 10:26:28 -0800
Message-ID: <xmqqfrlhl2jv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> The git_user_agent_sanitized() function performs some sanitizing to
> avoid special characters being sent over the line and possibly messing
> up with the protocol or with the parsing on the other side.
>
> Let's extract this sanitizing into a new redact_non_printables() function,
> as we will want to reuse it in a following patch.
>
> For now the new redact_non_printables() function is still static as
> it's only needed locally.
>
> While at it, let's use strbuf_detach() to explicitly detach the string
> contained by the 'buf' strbuf.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  version.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/version.c b/version.c
> index 4d763ab48d..78f025c808 100644
> --- a/version.c
> +++ b/version.c
> @@ -6,6 +6,20 @@
>  const char git_version_string[] = GIT_VERSION;
>  const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
>  
> +/*
> + * Trim and replace each character with ascii code below 32 or above
> + * 127 (included) using a dot '.' character.

/*
 * Trim and replace each byte outside ASCII printable
 * (33 to 127, inclusive) with a dot '.'.
 */

perhaps?

> + * TODO: ensure consecutive non-printable characters are only replaced once

I am not sure what your plans are for this change.  Has the list
reached the consensus to squish consecutive redaction dots into one
in the user-agent string?  If not, let's not mention it.  Making an
incompatible change to the user-agent string is not the primary aim
of this topic anyway.

> +*/

Funny indentation.  The asterisk should have a SP before it, just
like on the previous lines.

> +static void redact_non_printables(struct strbuf *buf)
> +{
> +	strbuf_trim(buf);
> +	for (size_t i = 0; i < buf->len; i++) {
> +		if (buf->buf[i] <= 32 || buf->buf[i] >= 127)

<sane-ctype.h> defines isprint() we can use here.

> +			buf->buf[i] = '.';
> +	}
> +}

Do we want to do anything special when the resulting buf->buf[]
becomes empty or just full of dots without anything else?  Should
the caller be told about such a condition, or is it callers'
responsibility to check if they care?  I am inclined to say that it
is the latter.

> @@ -27,12 +41,8 @@ const char *git_user_agent_sanitized(void)
>  		struct strbuf buf = STRBUF_INIT;
>  
>  		strbuf_addstr(&buf, git_user_agent());
> -		strbuf_trim(&buf);
> -		for (size_t i = 0; i < buf.len; i++) {
> -			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
> -				buf.buf[i] = '.';
> -		}
> -		agent = buf.buf;
> +		redact_non_printables(&buf);
> +		agent = strbuf_detach(&buf, NULL);
>  	}
>  
>  	return agent;
