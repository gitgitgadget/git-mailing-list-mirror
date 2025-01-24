Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC71DA636
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705709; cv=none; b=A/qqI0fD8ZKGm0+5Mku17E/hbvvfDj0uMFNYhs0+EpSqFGryQsTpJWOVRjf9BPiWmtCpEnXqSQIGbYaBWCUCHtmzYurRZypEon+bZGzX+JQix19heGHg8bg75VB5+nWrMOyaIsVfdPJ9a3w9vVSCwaTBe7H4spTLl/53i4ZUUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705709; c=relaxed/simple;
	bh=3ky1VO84rj5megk4ubA4MaPTUV2Mq3+vlCPpUm/XDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwblWOEIDTma7Vj54wDYe4TH90wVOEx/i3fWZDCp5wLBcwfA7xOz42RJozIQIjIFrkJafHQ0fZUK8urTHD0mRqFogbjiQhe5NYmtiClZZ2ORF1z2ruajgHkUj6Di42nyFEPoKtkFpJ2mi31gEFPfaTzqzaa7ccqmRDLN36gMM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BjVRfZGh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3PpbxTh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BjVRfZGh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3PpbxTh"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A99325400A4;
	Fri, 24 Jan 2025 03:01:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 24 Jan 2025 03:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737705706; x=1737792106; bh=pqAStWgHla
	piTPcUGbpYn0G9TUr/TvZg/bTAhnG255k=; b=BjVRfZGhIv7vEqRY/MNtDHM0NS
	4n31VAXp1u3n9ABElKgGiJ1xhjKEaCEzTrgK68DKsDsWAXYih0CQ57J2IETOZziQ
	nMreG5Ecmv2gsHPFyXbzQY+RCzOGjJrBJGy6E/ElY6+DH/uMxJI+LxQlxbF8pTAc
	7osTCgtHxWnDvxmg32rKSDksTmUKBXbFMnH3yYVSgAB7Bee48fQQcEgL0Nn2Bbic
	tYNrrbwYrsdV3M1Kov36kd7tX4BIoaN7RBKNo3OD8PM1UAfuWyWNrDjvJQlI7XEO
	LKmOgenEZIeVt/ipPGzib0ows1cpOcz7uwUkZrXmVvNYHpuYbW1DBhHth+KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737705706; x=1737792106; bh=pqAStWgHlapiTPcUGbpYn0G9TUr/TvZg/bT
	AhnG255k=; b=I3PpbxThqH9jGwHlKwlBzJpGWkmd517wZuYtaQZhIe/wmdXeL7T
	+7ZkeGm7kOvgXdTYiNLURQUjITWNT/WALYTuzZTOHCg85AOepqAPR5nr2xCuDycK
	93c3ngCmAJZpot/nK/RL/lv4fZIQK4Us3eKdd1Xkyn7b3BOmPmENwEgvhRvAFiqk
	dClStKO5HfrVLPfHUbc9gSaQ3caHksFv3Oxnrsm/S7D/Se22LEx4+q7WrqvDVxzH
	sOU03pbJ4UloD1AkITt6UW5KnPR8B+RClApltLpsY1VfPK5NBTgI1vf1P8zhNUZU
	SUX9vf4Ej7+iuSr7yiPcwzLisi2YPhmcNow==
X-ME-Sender: <xms:6kiTZ8_LMyRhGAyI8XJExs2UomgNtTwE3QSaq17hNngdYEeZi2xXrg>
    <xme:6kiTZ0vd859mgrWznHgjpmcAKzZknKbK7Eo35YFnE-BBlqVP1LS5o66XveZK_xmlL
    XpglFL7QvSNPzGU7A>
X-ME-Received: <xmr:6kiTZyDzKja_fhmKtZte-fKkzq-ef2HKFEfumEHtJv0Zre9XD8jLe0xRPtrnhHOvK_8wbnGQ1gnWA1P4KQSS4o7DUxyMQ3JfkR6ZqJhjMWyyvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshhhuhgshhgrmhdrkhgrnhhoughirgdutdesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehprghvvghlrdhrrghpphhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:6kiTZ8ewG81RF-__mqka2na_i8SRz4eGeLAI4ugS3uAPkCsIqbElOw>
    <xmx:6kiTZxPTVPu0YevfXTS5cMAL9pgsmgkmT58XR4ZxvQwccvJdBaLy8g>
    <xmx:6kiTZ2mNK8kcaThrkdex0_uepjiaRZhp9SJNoqOOX3qTusXFriYFDA>
    <xmx:6kiTZzsdAaai0KHGpwxhRm3R7mN01u1DTAikPA6bWkVKEP9tKbwQBA>
    <xmx:6kiTZ6jj_HiGgiG7mEPnReFMNLNtRVFfI8_GnsHSwnwvw56hzzSX0I48>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 03:01:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 31f5a92e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 08:01:43 +0000 (UTC)
Date: Fri, 24 Jan 2025 09:01:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com,
	Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pavel Rappo <pavel.rappo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/3] refspec: relocate omit_name_by_refspec and
 related functions
Message-ID: <Z5NI5jVxcNtPQmi8@pks.im>
References: <20250122075154.5697-1-meetsoni3017@gmail.com>
 <20250122075154.5697-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122075154.5697-2-meetsoni3017@gmail.com>

On Wed, Jan 22, 2025 at 01:21:52PM +0530, Meet Soni wrote:
> diff --git a/refspec.h b/refspec.h
> index 69d693c87d..9556d08bd5 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -71,4 +71,12 @@ struct strvec;
>  void refspec_ref_prefixes(const struct refspec *rs,
>  			  struct strvec *ref_prefixes);
>  
> +/*
> + * Check whether a name matches any negative refspec in rs. Returns 1 if the
> + * name matches at least one negative refspec, and 0 otherwise.
> + */
> +int omit_name_by_refspec(const char *name, struct refspec *rs);
> +int match_name_with_pattern(const char *key, const char *name,
> +				   const char *value, char **result);

Reading the signature of `match_name_with_pattern()` I wouldn't have any
clue how to use it. Could we maybe add some documentation to it now that
we expose it?

>  #endif /* REFSPEC_H */
> diff --git a/remote.c b/remote.c
> index 0f6fba8562..40c2418065 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -907,54 +907,6 @@ void ref_push_report_free(struct ref_push_report *report)
>  	}
>  }
>  
> -static int match_name_with_pattern(const char *key, const char *name,
> -				   const char *value, char **result)
> -{

It's a bit unfortunate that we have to convert this static function to a
non-static one, but I guess it makes sense in the bigger picture of what
this series wants to achieve.

Patrick
