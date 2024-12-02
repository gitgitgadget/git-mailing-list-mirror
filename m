Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376891F8AEA
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126058; cv=none; b=LBmZQBbhGGSyMRn8dqgF3cK3hcHHmMSwTiJS/On5aDl+l6PcBa4xSk4uemgqCSYwgAVRC8ueD4IcWnwofPJQzalAZegddpn9MKX162vdLVUGudPHmfiUA7xjg2VJvx8ir/X5pZA8FYiUMUlSCxewfwHao0TrMuFgPtCzhLXvv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126058; c=relaxed/simple;
	bh=W5v87O61mXZVdVk9LmW4N9IE0S+PHrJSl9Y69k64Oi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8OqIaf7Zkf8Tn+wrCMf0j2MFYYfWlkfOj8m+JYJiG0DoxNOxcgRq+RfIihSC1k6Qpb/I6Q1XB2neRsLSpT0wpnwK4MwqmvOb6YYKB5gMTIfsvHVnxgGg/LsMtcorRzKJMgYOlA2E8vFbzrffDPBqTGds4DXCe4m6v5/R9z4NzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1FNDMQjJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A49ebxl8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1FNDMQjJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A49ebxl8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BECA114014E;
	Mon,  2 Dec 2024 02:54:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Dec 2024 02:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733126055; x=1733212455; bh=boAUIeLEGh
	GofTu+xfKnrFPSZpZJRhkmwmU1fGF0HSM=; b=1FNDMQjJEC97W9b0JZeZbQkVuO
	jIE8H1EUoAH/HySZSZhgF6kE+yNtnyPLtTDDcPAbahi8PdEMowzJmuQzYGFmCkB1
	WH9vmn1lTfbkX5W03DsNlW8bmDiEtJeDa7Eb0YThR+JJ2yzO32X1cKh5wFks4OYx
	ICoKOOpkkuCGVAsTErGtPOyHs18m6NCraxm6H+GmVzXA8ugCibsel/EMTs+2TYw6
	iWT+W93aAvmsjXKeG4ClpgJPwgk1ZTst0zcC4WaIirC9x/1qBq89wkad3H7WNDSV
	9V+6+7B6CZyHqShZBOh8pu77LZHFzUlh9TUKpMPaFDtlOElCcf5YA5Q3GPpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733126055; x=1733212455; bh=boAUIeLEGhGofTu+xfKnrFPSZpZJRhkmwmU
	1fGF0HSM=; b=A49ebxl82AjD9UfxRYHuOEv9bfh+B7+aV8pvovJ08MEHZcm7V7Y
	1eUx4bDoRBAsWFXdjSvW8ho5rsUz5YW1UrpaJN9Uv/8yPQLcPYjBPlmwM+fNggme
	1JiW+q3Z8DseKMoYRcJ9/WUy098sPkRa2C9yLLMj3WFpxyT1oQ/vk5fmlAUnKzzI
	NqDi0fK+bVhOI+o90ihHELesRX1DM4wd2sWr/jAcixwGqYC6rJlO+LeQ9tKiGNKc
	paRhvP2DoGpSonj/ehfPzAVrPoP2EFfCDQbzEhwbD6rwqVGpQntnzHWSIEZuCH4j
	oC6KRwqQelBIWUliB6oST7FmUjB7kgKSJhA==
X-ME-Sender: <xms:pmdNZ16XfWurZr04DRnNjZWeRSmFCYPuhV413yzJkhYN6_e8KQyrWw>
    <xme:pmdNZy4DFvHEMqmD4lQPSauxwX_rwkx3NjmdLnu6HpQ4fsp9T5dzNx3H5ekxiX7Yn
    8SLqLmr3bfCbk9lpQ>
X-ME-Received: <xmr:pmdNZ8cGAze-yxxqQgsZ-Sy0fKdkrkC9OCyQueXXeRVbcMc9QIZum5w7Aso_TRdnDRnwIP_6_D6mkZVVRauv42Je11YYN87tBHKWiPJVLh3mKpyAgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:pmdNZ-IYuDpGEy1CyQz2e-dHHqpXeQ1lbmlPv0NtMou2CfwDtIoJKg>
    <xmx:pmdNZ5JoWY_LssrQc8_RKaw5g7fKLurwsE24Og1jJirg1PO4p0t_ZA>
    <xmx:pmdNZ3xOg-DXXcCo1qx0ldDaTW1cIGzGqan8iN8BFJWfw_F9pT8Wig>
    <xmx:pmdNZ1JkWeUMvUGSsHwhfiHc7bX09TzAeXmV3Hq1I90NN_WJFmxhVQ>
    <xmx:p2dNZwU2XorF962AGr1ITWo87_WI1awWnow4ANTLQXU73h-VsNkqLtGO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:54:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b2a58fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 07:52:58 +0000 (UTC)
Date: Mon, 2 Dec 2024 08:54:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] global: fix unsigned integer promotions in ternary
 statements
Message-ID: <Z01nmHnByrx_H1ZA@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-6-fc406b984bc9@pks.im>
 <Z0rsm8X0jkjtrjR8@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0rsm8X0jkjtrjR8@ArchLinux>

On Sat, Nov 30, 2024 at 06:44:43PM +0800, shejialuo wrote:
> On Fri, Nov 29, 2024 at 02:13:27PM +0100, Patrick Steinhardt wrote:
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index a67d80475bf9d8452de0c3ae9bb08ceeb4c11c4b..e1720361f17e8b3b3315f0a5d93a827e11b2b036 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -700,7 +700,7 @@ size_t parse_signed_buffer(const char *buf, size_t size)
> >  			match = len;
> >  
> >  		eol = memchr(buf + len, '\n', size - len);
> > -		len += eol ? eol - (buf + len) + 1 : size - len;
> > +		len += eol ? (size_t) (eol - (buf + len) + 1) : size - len;
> 
> When reading the code, I wonder what if "eol - (buf + len) + 1" is less
> than zero. If so, we would cause underflow. We have created a helper
> function "cast_size_t_to_int". Do we need to create a function to safely
> convert the potential signed integer to "size_t"?

In this case it can't be. I'll explode this commit into several commits
and explain things a bit more in-depth.

> > diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
> > index ea9b9b656307d32bdc1f2e15a91793b1dda9c463..31dbe7db4ac61639541f15d262cea64368fec78f 100644
> > --- a/t/helper/test-csprng.c
> > +++ b/t/helper/test-csprng.c
> > @@ -1,5 +1,3 @@
> > -#define DISABLE_SIGN_COMPARE_WARNINGS
> > -
> >  #include "test-tool.h"
> >  #include "git-compat-util.h"
> >  
> > @@ -14,7 +12,7 @@ int cmd__csprng(int argc, const char **argv)
> >  		return 2;
> >  	}
> >  
> > -	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
> > +	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : (unsigned long) -1L;
> 
> Here we use "-1" to represent the unlimited, and the type of `count` is
> unsigned long. So we need to explicitly case the type of "-1L". But this
> is strange, why not just use the "ULONG_MAX" directly?

Yup, good suggestion.

> >  
> >  	while (count) {
> >  		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);
> > diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
> > index 5b51e6648d8e698b09f400efcf67a0708c226e9d..efca20e7efff46bf66c2b8888ce88db02e545cd5 100644
> > --- a/t/helper/test-genrandom.c
> > +++ b/t/helper/test-genrandom.c
> > @@ -4,8 +4,6 @@
> >   * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
> >   */
> >  
> > -#define DISABLE_SIGN_COMPARE_WARNINGS
> > -
> >  #include "test-tool.h"
> >  #include "git-compat-util.h"
> >  
> > @@ -24,7 +22,7 @@ int cmd__genrandom(int argc, const char **argv)
> >  		next = next * 11 + *c;
> >  	} while (*c++);
> >  
> > -	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : -1L;
> > +	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : (unsigned long) -1L;
> >  
> 
> Similar with the above comment.

And this one, too.

Thanks!

Patrick
