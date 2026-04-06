Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CA3033E3
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507888; cv=none; b=aByR3udAmS/NsFCqJde/DOlZVCaJpkX5UkrhxDY8Udrtw1/ErV++FTJbal4/gbVfMQ4V9BBsKMuZmPyjhQ5E4xjTI1/xtRtCjmJOc75NcpJQq5AZXFJE+2XZieVn5kdh5CPoq4yP1Hcl7+YhcQNkl7RIXMOEe0BwH02Dt0i/uk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507888; c=relaxed/simple;
	bh=mC8d84fM94Ali62bOEUVPJC6ZZMJwQps1M74vo7GAI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CihRkcwQDBWPKOnmZIfccMCKGJBA8o53LQ3gBpNFizKLzASpAXorn88jM9kpdFWAJRqQSdU2ffRy88ofQI6/Z556by+4KOfTRMxdxe1R6qprZVMTrDnZYnwToyQcAmfytbCgC+86TFnKst0y8ScYIjrboR7+zXojt6w4VWgLjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvz/Flp8; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvz/Flp8"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7f09aa39fso5380659a34.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775507886; x=1776112686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAB7ir6vnXh6x5rqMrTtGEc24zLjTVUlux6jjOH61jk=;
        b=mvz/Flp8/QeSkXZPIVtzY28ciA9SabUIjH3dQ+Tz8CURobhtyCv+3ln+EB2MjYS46p
         3/pkHpd/wmWCPOpeunQND3pmXdEvBBS10pt1Mg0FiLaF6m1rBpgD5KLUxYYXJUw5GTgP
         yPT0tATOfbJYeiYv1kptfyZQyIUWBQGNzw8vWOSyToUc75FjqvITpcRvfdMRGEBs6Co8
         RKHGBWgdv2qRnO34N58PDoitCfVEYEJtAvzjz1fWHjykFuzOoW7L7zi/9uL5gYYcrxoE
         MuRKw5vdtITDENiqqjGoTKlMdUQlzXTvYRsaJhjhjJmSlqTnbP9YOWKw9Y3uKowxoFNO
         EhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775507886; x=1776112686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAB7ir6vnXh6x5rqMrTtGEc24zLjTVUlux6jjOH61jk=;
        b=o0gJTCoM8HN7qQmf49TDgyxZNzqpnGN+U+KwpEmEbX12EDEAE5026s+G/2L2uZrBft
         6DiW07kPE310Vahqy7iGLNH27awxUiKbYWhG/gbZj0faRi308iI9AgZSXsmy9RB05M4a
         P/ZOdu/CsN/ScNfG0I7aB9CEZJG5KhpP7cbRwPclMGSw9b3uOSSK4rSe6xFACd8nGP3a
         dab2JVmbfP7vh+Oukda5vLs19PdWUBXcnjdoVLRuipyIoIhUKg4gvpoeWl0O9CpitcfI
         kgBwa7SEVJm22D4jNM+XK200oEuGalQetbha1AoYI5kXxSYBOj7pJwzgFKPycjoBb+Sz
         O+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWxS1QBuNdsQRFw3rOPS/2+vm2Obbu9BwS6J6xrMVhkw5sKvuFqc3tOGINtiZBP7stgJ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyixijczSEhrZbEffyv98NdkkQfJ4cKgFIHz9dWdHCiq5KZk+OY
	KwAJ+cjtYCdAneB+Cr/+JPjit23PnptWJWriVza5OJ60G9+3DXbPLKulGIY+DA==
X-Gm-Gg: AeBDiesWgi7l+4WIb4Jj+MtdOmdVTlpZImwYo8xk77B3SE7XBm3ZHvL+rLGCktr3qwj
	rnqOSIGn8MXK71wcBNPJRehh5EyheFYZ5GPrSX0tcrDEsfGL7HxO2wAm1T8MPY3LW7Tk1GDvneu
	ViGq1ToYY+V+w25eAuFh9rE7csvzq1Bxosc+7JpIy6pa0b9eZlUu8N5ZvGPWchpbm95ZpB5b5w3
	mKjAtnIp1a0jyoKt/xExx0Sw91CeMp78mDi6apC1hTPCObzCO/gCa1yE53qFEvELUYn6/seOoBU
	+6Gg36AIpd3DKVlmYO6E81E0RLrdv8kU/hg741/GmaRIDmONktrOrF2yngpiDMV2s+XOxy+KzPA
	jKuSHPBduLvCW1V9WY5s7Y6pkMSoEi9hBdfCr3gTxg1Xsyzk1Qow0eM9sAFXpKnIh/gm6zAUg3O
	2apOmj495ykoSTvy4JpI41xscv0hM=
X-Received: by 2002:a05:6820:81c4:b0:67e:2dcd:e847 with SMTP id 006d021491bc7-68220941f51mr7545220eaf.61.1775507885975;
        Mon, 06 Apr 2026 13:38:05 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4232eb3d0e4sm7614625fac.6.2026.04.06.13.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:38:05 -0700 (PDT)
Date: Mon, 6 Apr 2026 15:38:05 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, git@vger.kernel.org, 
	cat@malon.dev
Subject: Re: [PATCH] object-file: don't use object database without a
 repository
Message-ID: <adQYS_ThpOzxCLTi@denethor>
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
 <20260405064651.GA1452907@coredump.intra.peff.net>
 <145b6c7f-c037-4a87-b561-d2b4d8c5a0cd@gmail.com>
 <20260405191750.GA1525850@coredump.intra.peff.net>
 <adP0hnV7Gl08qqqf@denethor>
 <20260406200651.GA26091@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406200651.GA26091@coredump.intra.peff.net>

On 26/04/06 04:06PM, Jeff King wrote:
> On Mon, Apr 06, 2026 at 01:17:17PM -0500, Justin Tobler wrote:
> 
> > I agree with Peff here that the correct fix should continue to use the
> > object streaming mechanisms. To avoid this segfault, we really should
> > avoid using ODB transactions when there isn't an ODB in the first place.
> > 
> > I replied in another thread[1] with how we could go about fixing. To
> > summarize, it just so happens that I already have a patch[2] out on the
> > list that appears to resolve this issue.
> > 
> > For the use case here, git-diff(1) is only interested in generating the
> > hash for the "large" blobs and not actually writing anything to the ODB.
> > This patch introduces a separate "hash-only" variant of
> > `index_blob_packfile_transaction()` and is used to bypass creating an
> > ODB transaction when object writes are not needed.
> > 
> > If this is the route we want to go down, I can extract this patch from
> > the current series and send it as a separate fix. :)
> 
> Yeah, I think this is a good path forward. I took a look at making the
> transaction begin/end conditional, but that's not nearly enough anymore.
> The transaction object stores state which is used under the hood by
> index_blob_packfile_transaction(). So we'd really need some kind of fake
> noop transaction that understands how to stream.
> 
> Just having the caller divert to a "hash this without having an odb"
> interface is way simpler (especially since this is the only spot that
> needs it, so we are only paying the price once either way).
> 
> I gave a cursory look at the patch you linked. For a maint fix like this
> I think we could probably slim it down a bit: introduce the new
> hash-only helper but _don't_ actually rip flag support out of
> index_blob_packfile_transaction(), so we know that we can't accidentally
> break it. Though maybe that is being overly cautious; it only has one
> caller, and that caller would no longer be passing in any meaningful
> flags.

Ya, I think slimming down the patch probably makes sense. I'll start
working on it and make sure to include some tests too. :)

Thanks,
-Justin
