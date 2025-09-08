Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F730504F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350097; cv=none; b=uerJyj3d85BL2OETuZZDZNLIwa4U2g/P8q83paB9xdlahwOX/4YrPhZcgzDzzP4O4HjEw/dnl6bmnpKmLflVhpr8sPd5ttuddF/jA2yhR6kPwS59n8FoTemi+65yQf2l/9i8tqy5xhDHiQ6VlSsDnC7dw16Z9ylsKoPekY7ttfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350097; c=relaxed/simple;
	bh=fyYRepfCAxoUx2zKCcszgsExp6FEyk6/0IRusqed9+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5GHAedoxjQIHYs43yVILkc0nf7Rrrz77uXyPp2eZeuCEw0J4WtkyWZSvZszqHjwJfpkKK/XG1UXJn3oJefqFVKG2Ni6lSvLksjErzIB7vSxPTfG8C4WRdxi+AfLR/uwvPFPiZ8OMmYMu/NxVqFOnglFvM7pLNwbkAHCwYRp+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R/F7iSMT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UzEBpufG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/F7iSMT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UzEBpufG"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7295A1D00151;
	Mon,  8 Sep 2025 12:48:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 08 Sep 2025 12:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757350094; x=1757436494; bh=zC4lLkSbS6
	aofLgnOYqYJIhPKXD6aEEQmQrs0vdUMcQ=; b=R/F7iSMTMX1ZVKmro4rbQRIDjO
	4J87dNtqJQChU9DJqmydOTs8H/iiJvRtBzWcqe7B7zB1iMOhK+tM72xv7ceJliuz
	XHtUUNv7OUNCcuhfTr5J3vs6UmgE5eLxRJwdBTxdvAEJHndihKG3moX8oxPYmApu
	FfKBMT98ckljw5Rtd8MIDGmpGL9zwMRx6qJyamRjLA+Nc9nCbHlTmwDN+0DKOWUt
	VTo8EhH2AQVGdj1nNXgIu+mg/f9EzaSpbmelikQUHIU1pwVP5D1sK+Q9V1fG5dpK
	uwJrLrOE8zxOZJby7T9LNXfJA6C8hUfgTsZtvikpi5EfpaGRwQUrlGm1f3zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757350094; x=1757436494; bh=zC4lLkSbS6aofLgnOYqYJIhPKXD6aEEQmQr
	s0vdUMcQ=; b=UzEBpufG8SjcG1fGOUQaN4kJ6WwtSME7P0nxNUtPCqNyu8akHq6
	tnc8ECaplabd/dGF+O1WR9K8Av66Gmn0y6vkUgz7Xafb19QreIFxqnJa2v1+S9Yb
	zYKUgjuiSiF0kl2KSbDRh2weRa/nOP37nVV9OyhLXJ1iR+A4vmZXbEB0HI8vfhpE
	4qSHGjANgdcQiMmO0yKR+YpGRTmtMqDxsVmimo+h3CVpwpfFIK/f6vtL3rtQ9ORL
	4ZExANRqRraRgV+1urWO7SdWx10qVkKWZOz9h3jhkuvcG+S/o7V0jozTUfngacv4
	jVAlR2rxBnX01vKMJy/dGELzXwatjeZmnTg==
X-ME-Sender: <xms:zgi_aF6UsJjtc7IkU1vXhTpR0mdtFFwS2GqlP0XHIDQTI0twaydz3Q>
    <xme:zgi_aGKooSd0yqTCOy4-0a33Rd3IMghZudVvm0SjboVTLrJkQ45FdppxORNvbdncJ
    1Kc-5dlF3C5xjT4AA>
X-ME-Received: <xmr:zgi_aF5BPzzjqhKstJmaj4wScyLsfU7k_UC6M2X3l5iBav3uIhnTow7vSA-zTuZzJa6w6JucgglLCX6YrtzdD8RC93y4Qo0HHGwJa8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgr
    lhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zgi_aJzEsqyJnd5X3u1UxaVwkwbmxKTR8p8AAPLDWFCBD4_iuLaGJw>
    <xmx:zgi_aJZfI7fUvl9cp21CqaDk1slfzFdQmuK19X9zCrFRMma1fO9gaQ>
    <xmx:zgi_aLSAC2KSgSO4bKK_CreKwtIPF2HMwkPTgESvxp0V2bAX0goNeg>
    <xmx:zgi_aDxFpjXhYluyAHbfncE-7GLSrS2O_qesOaRScKurxEtRgNFTEA>
    <xmx:zgi_aGyrNQo28z4CwPDExoWrfPlJCgfpoPx5QnKqnMpf1zq3WNxdcfMF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 12:48:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] string-list: allow passing NULL for `get_entry_index`
In-Reply-To: <aL21eowK8MwmDX11@ArchLinux> (shejialuo@gmail.com's message of
	"Mon, 8 Sep 2025 00:40:26 +0800")
References: <aL21eowK8MwmDX11@ArchLinux>
Date: Mon, 08 Sep 2025 09:48:12 -0700
Message-ID: <xmqq5xdsyjoz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> Callers of `get_entry_index()` are required to pass a non-NULL
> `exact_match` parameter to receive information about whether an exact
> match is found. However, in some cases, callers only need the index
> position.
>
> Let's allow callers to pass NULL for the `exact_match` parameter
> when they don't need this information, reducing unnecessary variable
> declarations in calling code.
>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  string-list.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I do not quite see the point of adding these conditional assignments
to clutter the control flow.  What benefit do these callers gain by
not having to have a throw-away int variable on the stack and
passing its address to the call chain?

> diff --git a/string-list.c b/string-list.c
> index 343cf1ca90..bf358d1a5c 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -29,12 +29,14 @@ static size_t get_entry_index(const struct string_list *list, const char *string
>  		else if (compare > 0)
>  			left = middle + 1;
>  		else {
> -			*exact_match = 1;
> +			if (exact_match)
> +				*exact_match = 1;
>  			return middle;
>  		}
>  	}
>  
> -	*exact_match = 0;
> +	if (exact_match)
> +		*exact_match = 0;
>  	return right;
>  }
