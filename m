Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38582DE6EC
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487754; cv=none; b=TqtdwowVg4b4NpRF2GFcraQdaRmxIVN2wWBC1KpcKE7TnltUKWGp8whRnqvcKojG5h+qXF4i7AukKmb/Qzg7uZ44Io9OfrwebL+saSsjc6xITARlM0ZTYEBLfQ/RdVnCmR2dXovnKSq5tYvTisRElhsFpb1u4JwUe/fsKG1j6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487754; c=relaxed/simple;
	bh=W7n3XOiv/d11rOSSzs2VLDk3eW1K0oGwyK9L3dMJ+BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huy35QdALrUZ3u7LoamLUwVvIFDbAJ1heCvk9+/a1TuYlu37sGy/D3rG2lo0aks0a2vtloxa050W6v78yJl/1H4AOshyAl/Z14ZCjLaS2DNk7UjWigdYEhw4jWDzOWG/A3W0Amy/D+2HyYAvyz1CXSL4zgnhId73f9dSdmDRnzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt7nNYH7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt7nNYH7"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b321bd36a41so4334716a12.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 13:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487751; x=1752092551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YKiBSKTrVmFF5nSEoIVyq9BiHccCOXfthEZlKq/4wBk=;
        b=Bt7nNYH7J5+z84PI/mQGE1YauuHeB5/tXG6iY1NNVS5R3Pq8ABKNry/1HTCdBfZQ0G
         r2SMoBCSEFnC+vfT4/P+M15CDZmgQ2RTKpxiUkXknrVNT4wQKc9TXSAQaFukwCniCAHR
         ybKIQQJRmcLOrkhBOO5NfpxNjlye3lVQsg09kE7QK1z4s1zkiUIW67WvUpqb4zNJi78O
         +d6pbp1w/Bglo4kE1gglCNPOgEYOrZr16/at0ZabRzCmSew0Nbk6QrChtd5wTsHk1HSM
         +4V8qV3B3rIIvfZsP3EnVxoxzWYo/LjhjivHYHQThH98QiRX3xqgF1l6JkBKYw8dAKKK
         92RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487751; x=1752092551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKiBSKTrVmFF5nSEoIVyq9BiHccCOXfthEZlKq/4wBk=;
        b=XdpZsSn/GwrniWhGiHGHux4RNVW5k0Vz9XgafExydmEzPJNjD2imat6X0UwC3LEOXf
         /iw3eDR4yYvgHdzYzTBxpP72dN1H2uoy7W2mX5il8yl0yVNZRwTS/Zpc1m12I9Kofi2l
         Ywx0MoC4p/oe3FyTvq6Y/T6Rffi7tSvM+p4XCdRAq5LjBmom/afVQWbbqJAPWm63UiFu
         Qm8glFo+H8vP0ab3K+yQpjD30hjiaY3I50P1TrM0lWtM0wBpAA3wtAWOAbQDeOvETfBc
         NmuBGpjNwHNWQq2SUu+mzWtgv4KctNEQlID8rvabz7jeLZXvd5+UVFXPOSTdu4y4dFuB
         Cfbw==
X-Gm-Message-State: AOJu0Yxb4X95QuvVAtkZ79IznqRqYQaKYfHfzngMPk05HwlLHubR27sN
	6bXmC18clhKyU19RR89f5hDES/TzQUlyDqxOu7W36nbH5PBxttFkx9Pj
X-Gm-Gg: ASbGncuTzK3pVcPs31N5UBDxe2bi4iP36qUvI2W0NqDlWZNLLIBL7T547pIzu6IdOuq
	dp2e2YpDtYLTAN4AstNKg5LkS2CFcYiPyvs6hwn0DEn0m6CO3HsGCWqOKCRcluzZ2DaLduJSWlB
	BlFRzmRvagW7flYeFYeOWvY7exN8V3SYyEJrx2h3jE5TM1zpWFB+ydFjWfOD705x/PyPAnzjnqa
	3aRYRhnSR6YjOwlWWCimpcyHkQXonVItwQaTKS+0BQSaLBWKot5n/WVEny6goA0Dsyrwrk/NX5S
	7+40pdnxN9bOPe8PJl/MGWjgIWVUDU96YXKxuKMkY0i9CRLuPcVELL5EWLonCsn0u5JY0EazbyX
	lQePNzflxE2yph+/hMV4/68k=
X-Google-Smtp-Source: AGHT+IEHe67UxHDja6J1sOt338M89V5ouPiYjrbkAzc2E3PCji3X8Ogo+EyIBFrIk0NA3hZI/M/w9g==
X-Received: by 2002:a17:90a:c2cb:b0:312:1143:cf8c with SMTP id 98e67ed59e1d1-31a90bdb56cmr7225658a91.16.1751487750878;
        Wed, 02 Jul 2025 13:22:30 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc5204bsm541959a91.8.2025.07.02.13.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:22:30 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:22:29 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, brad@comstyle.com, 
	collin.funk1@gmail.com
Subject: Re: [PATCH v2] builtin/gc: protect against sysctl() failure in
 total_ram
Message-ID: <4vz7mwsyckx4ie74qdlitcmhg4vyuoiuwzufd4nktgzu5ppzfx@cqmznirthjcp>
References: <20250702144244.43858-1-carenas@gmail.com>
 <20250702154649.44210-1-carenas@gmail.com>
 <xmqqikkacu30.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqikkacu30.fsf@gitster.g>

On Wed, Jul 02, 2025 at 11:42:59AM -0800, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > In the unlikely scenario that sysctl() fails, and uninitialized
> > value could be returned.
> >
> > Initialize the variable used and make sure its expected size
> > was correct before using it.
> 
> Oh, that's interesting.  I wonder if the system returns physical
> memory in 32 bits, we would want fall back doing something silly
> like

Yes, a FreeBSD 32bit x86 system will report at most 4294963200 from
this call, even if using PAE and more memory is available. 

Eitherway, since the caller for this is ok with a smaller size than
real, shouldn't be that big of an issue IMHO.

> 	if (!sysctl(mib, 2, &i64_tmp, &length, NULL, 0)) {
> 		if (length == sizeof(i64_tmp))
> 			return i64_tmp;
> 		else if (length == 4 &&
>                 	 !sysctl(mib, 2, &i32_tmp, &length, NULL, 0) &&
> 			length == 4)
> 			return i32_tmp;
> 	}

probably a little bit less silly in 20250702202118.48742-1-carenas@gmail.com

> > While at it, add a cast for consistency.
> 
> OK, I do not mind being more explicit than necessary, but wouldn't
> "return X" take care of casting X to the expected return type of
> that function?

yes it does, but the "implicit" sign conversion will trigger a warning
eitherway, I had removed the cast in v3.

Carlo
