Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4151B960
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750936; cv=none; b=MmxSvgGEHOadwTK7zVnF1mKf4/Orl7moJnV4bsiY8Ir3GQ7454i1UsK/cFGQvI1UM65zG8aT1FJgeLaZhRva0Ns89R7qgk3WsY7czlSanx7iW6Yj141zrAlIjz5/7ruQgf5QvF0bJkSTUs3igMpoJDtyPwcRW4uN3KV5tCJSbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750936; c=relaxed/simple;
	bh=w3Jo3InzEdIYat/7oJAnPM+3DqtVWZD29GM8Tu4pW7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fj4XiYyhs1xnzZlLwXMsYys/3UE6IQDZaHmbv0hSkiD5/kRSFFu/i8NXpiULluwYGCNJwGQmzA+0xidRwmr7OcWkESzQviuoa808Qtm+wGcinpwtoQycj4pYtxnJdVxSsoMxijZbi+mqYgJQGrodqKpAYBVCCRibasVmXj6jSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XeJp2Nbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mdz1Grxx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XeJp2Nbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mdz1Grxx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA9E71140402;
	Fri, 28 Feb 2025 08:55:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 28 Feb 2025 08:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740750933; x=1740837333; bh=Pxz+F4UM5a
	eyuUYK/OvHoioTmFpb34yUJ2GwIc9ADTU=; b=XeJp2NbdEUQOxUb7+da/XLAhUm
	YKV5nl5X69udCDuPcmsP/bs3L6bUfiQvMylcdmuHEmnIBWYAb0zOhKmsI4xFS4qE
	ZNEZ1sFvYGMAxiUHdyS+2GgB/7Jq/Q6K93d4iVMyrowzJZmiIk1etHA6gH6xpYdP
	HorPoeXnonMXur81fVRyL62+Lj5u78yvvj1NBIrkR60Ngep4IznN81G4qdD/hsa8
	cS05H9JtIhSaQuQp11qVd3mhaoQ1gjXMfrRBr+O6fHeMC9eOkR4hwbs9ud5VcgKj
	rnIBwtl0VDz+AfHaEEr69VXAsLuK+hKdNXQ5p0xt/C8XS8tx7aLfKK/LsWHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740750933; x=1740837333; bh=Pxz+F4UM5aeyuUYK/OvHoioTmFpb34yUJ2G
	wIc9ADTU=; b=Mdz1GrxxR/Tyk6kDfUgBgaD4VZdorqu0S4/2lsiAqJ12yW7N9i0
	H25NA73o8SqxqO1mgiMV9285gGkusQCSfUMvlT8LSURjkjLHUXrsO65kedd24k5z
	I8u74F0GFunnTEP+nH7uz+3yjHzfGv5g9odtS79C0Q5V2Afl3Ji1cyn9+uN2OynR
	KgBz9SlWEkqIYntC/U5LE+8UhDLou4UyE/BU2WzjziKx+hgt7EfKQagum6U/lymB
	js2SaObWvPJG1KI4FbMDMvZ10u8xp8rq1sl6rv2o7kI7W80g5v2ohyD9p6mLj5mD
	rqD7RAp1dlNOdLCowiyJnDRBEW7NV9gxARQ==
X-ME-Sender: <xms:VcDBZ4Ut-jxl2rJw7oRWD4giO_Ei1mGgHDnOMOSGNoxTQtqyFplN3w>
    <xme:VcDBZ8n7_E8JbQpyPro1jyxuqhVmkYgCVmVEM8JZucqxrJVLXmMBhwsHxr39lQrA2
    57lAEMx-qTn-8BK_A>
X-ME-Received: <xmr:VcDBZ8YimrtGacm3uiSFDDggBupZiBxUmIsKpaxW4RBEsP3WJtwOFNsU0CF_WigbVqKVTDrlk9gR8j1klIoX6-5oJ8ksDkfjDI8b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:VcDBZ3UeSmPdwmPPfykzvtw7Un7I5_PCfX3J-N-ctd8eyft7c8JLew>
    <xmx:VcDBZynaC6TghwWT7H58H2yYfCxbutSSjD764mMpAhar3IpMmdJO2A>
    <xmx:VcDBZ8dVv6ubSMXxSbRoiWNx4J4wLgLAQww4KXTzhq0UECfLtB_9hw>
    <xmx:VcDBZ0HhmR99SeLH4Im_PmASP6IA2mGvcIF5cfhKnjoFDmjWbv_5pQ>
    <xmx:VcDBZ5tVHnXvEgkdm7OBlUDl5iaKEraGCrElnuL2kpMqe1RlQOyFzmLf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 08:55:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/3] doc: update howto-index.sh for .adoc extensions
In-Reply-To: <20250228034713.203461-2-tmz@pobox.com> (Todd Zullinger's message
	of "Thu, 27 Feb 2025 22:47:04 -0500")
References: <20250228034713.203461-1-tmz@pobox.com>
	<20250228034713.203461-2-tmz@pobox.com>
Date: Fri, 28 Feb 2025 05:55:31 -0800
Message-ID: <xmqqy0xq41ik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
> extension for AsciiDoc files, 2025-01-20).  This left broken links in
> the generated howto-index.html.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/howto/howto-index.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/howto/howto-index.sh b/Documentation/howto/howto-index.sh
> index eecd123a93..ace49830a8 100755
> --- a/Documentation/howto/howto-index.sh
> +++ b/Documentation/howto/howto-index.sh
> @@ -9,9 +9,9 @@ people describing how they use Git in their workflow.
>  
>  EOF
>  
> -for txt
> +for adoc
>  do
> -	title=$(expr "$txt" : '.*/\(.*\)\.txt$')
> +	title=$(expr "$adoc" : '.*/\(.*\)\.adoc$')
>  	from=$(sed -ne '
>  	/^$/q
>  	/^From:[ 	]/{
> @@ -21,7 +21,7 @@ do
>  		s/^/by /
>  		p
>  	}
> -	' "$txt")
> +	' "$adoc")
>  
>  	abstract=$(sed -ne '
>  	/^Abstract:[ 	]/{
> @@ -39,13 +39,13 @@ do
>  		x
>  		p
>  		q
> -	}' "$txt")
> +	}' "$adoc")
>  
> -	if grep 'Content-type: text/asciidoc' >/dev/null $txt
> +	if grep 'Content-type: text/asciidoc' >/dev/null $adoc

This is an existing "Huh?" and should not be touched in this patch
but it is somewhat inconsistent that everywhere else "$adoc" is
prepared to have $IFS whitespaces in it (even though none of our
files do), but this single reference is not.  We may #leftoverbit
want to make it consistent after the dust settles.

>  	then
> -		file=$(expr "$txt" : '\(.*\)\.txt$').html
> +		file=$(expr "$adoc" : '\(.*\)\.adoc$').html
>  	else
> -		file="$txt"
> +		file="$adoc"
>  	fi
>  
>  	echo "* link:howto/$(basename "$file")[$title] $from

Looks quite sane.  Thanks.
