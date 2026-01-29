Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A294328B6F
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715689; cv=none; b=gih7ij3MsBMydw9zzXhe6TXg/dKSzp5p8Za2bnVXwG6Zoh59J66f6TMkp+PgZ9CnRO1a6yF+2lN5HBDfiBmV/ZiDoCB/3A+vD0oN34pB9fqk7aLZ30bb6AtFAFok4YOwqrQUC4BbsGDnV+nNH/6uVdDH4o8CVRc8K3kEN53UfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715689; c=relaxed/simple;
	bh=WtCK1fR08LsNA9KjKz0j7WwA5DvCynz6XH29n04NMAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra7HWiChJRm68qSsBk8nbat7QVeH1KIikc/OJuAKcuJ2nd3aIcfu9Rmlc3tPwzuVAhatmNtbHR9B+9kyqZIOJ3R1j7cze7XqYZOPHjTsGHuDy6n139gihq4uHKIMJRwChBNelVxkoZb5+pnym5t40DUFOn6TfDe0YNv3U+TxGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A76oV3ZW; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A76oV3ZW"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d19d3c7208so558580a34.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769715687; x=1770320487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/ZBkT5QnSuE4DmC/V4oXhcNysq55hG87m01EpgCqCE=;
        b=A76oV3ZWxKHxD4Zgbz+/QBi09J7wXcjISaCY+UVElxVyK/qS2XObXCZP5w1NsJYlvr
         Se0k3u80GqbslulX2OFFsp8CLRmr1HRZ7upPctjMKdNkS07HP43mh1MJHuvUsFGDxlY5
         5Xz72/9nNnbVt3qV0gHmW1aMPLR2DhqnpkZAD3yEinX1heAa9duw/FLYY3fMvu6nx+y5
         tk7DNV/NUOwC9L+cwcM+RwEwfFqZfHYJK5Q6QhCNpGnKRFRTVZWUvUpvQAaRSV+ZXie1
         QxbGQ609yVu7nElDcZ7HwANkQF9Mart/hDgTj2nmeN2xXAineZr1Y+6GtqLunZ2DiTxR
         tSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715687; x=1770320487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/ZBkT5QnSuE4DmC/V4oXhcNysq55hG87m01EpgCqCE=;
        b=AVYWaVXLRfDQC/YHdhholBetQI93cI91FNPkL41BItvnjGhe0ykSlyfwzyo/mZevLE
         GFYBnjfffDKy4IdfQzHXMyB5XGsYHKa2ORxSgDvfKjJUEewkb9U2WddPuS4jemLTB0w9
         4a9l5MTiaY/t3weIefoEQIf0Bt9Ekvu9hfxG2/roptap7+7Zc2pwEHtxqI2Wp3wbrjOA
         HmJrdXKlkKPqoJJxzrfF7Tz+R8zX/1PMSnb2ZEftzm+RW935+LsBawVv21VPHIT6EX9w
         7rLE7EWVodBjyc7cLPN6f2cfHEclToITZjsFm4V8MKqyPxBok/tjr7rsX/wY6Kh+DfCn
         ypKA==
X-Gm-Message-State: AOJu0YzI9al+R0qfuh7uWCtBKMyk7HMUbEy2FR87RnpmvtnEj7qqdkxz
	9Z/GGRXMlBJtUVsVGmYAguotHf+a9etUq8ZGLSrUd2ebUdFUS0xMpMBSrMtLxQ==
X-Gm-Gg: AZuq6aJKl2vHBARAZJJ6OYBF1Y3r9g/GtgLjfBHVxAfAI/u6mxcUPru6jHpQrItSFp/
	gpzcgjXMB9KQ8hLmBkgpeDptcawRrbcJSZrqVslIOkfabLskhuGqnrHi9D3BLG2vHlqo+XNnxWI
	yevWrfNkSruuOlN2ghiyxPNICc5gFcBft2Ycau3Eu99JhtsQo4QUk4QZtEUwiuPdZPVCTw6phRu
	R4Htr3rWZaOcy/qsrfPuBIQwTHUuLQlQaieoHX+VAM/qnnpeS92I1DOsG5V5E8rdc+EW1m6eToB
	9tGM2/dGWsAH3Px2pgKr4h3U06ktVGGSciYFXTai09KEd9U8Gnl6qwRUI8VRDYcGYu2R59F6TYJ
	QALI8UsSOGyIPgBUdj45/E+FAI/PLf1015KbEpJNycqYIE/VSjfNNsZTDqT9tgxTv4eW3ie1jgm
	1A7ls+
X-Received: by 2002:a05:6830:1259:b0:7cf:da7d:6080 with SMTP id 46e09a7af769-7d1a5336016mr312540a34.32.1769715687016;
        Thu, 29 Jan 2026 11:41:27 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c4f08b7sm4369640a34.0.2026.01.29.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 11:41:26 -0800 (PST)
Date: Thu, 29 Jan 2026 13:41:23 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] odb: prepare `struct odb_transaction` to support
 more sources
Message-ID: <aXu1fWWdP3dYKdHf@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260128234519.2721179-4-jltobler@gmail.com>
 <aXtDZyFoSQahkxBa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXtDZyFoSQahkxBa@pks.im>

On 26/01/29 12:24PM, Patrick Steinhardt wrote:
> On Wed, Jan 28, 2026 at 05:45:18PM -0600, Justin Tobler wrote:
> 
> The bit about supporting "more sources" in the subject reads a bit weird
> to me. We still only handle a single source in a transaction, not
> multiple ones. I guess what you rather want to say is that we handle
> "generic" sources? How about:
> 
>     odb: prepare `struct odb_source` to become generic

The intent was that with generic transactions we it becomes possible to
support additional ODB sources each with their own transaction
implementation, but I agree the current wording is not great. I'll
update in the next version.

> > Each ODB transaction should be specific to the ODB source it pertains
> > to.
> 
> This is a claim that should probably be backed up a bit. I myself
> obviously agree with it, but I think it should be noted _why_ we want to
> have this in the first place.

Ya that's fair. I'll update the commit message in the next version to
properly explain the intent here.

> The patch itself looks as expected to me, as we split up `struct
> odb_transaction` into two structures:
> 
>   - `struct odb_transaction` continues to exist, but is now the generic
>     part that simply contains the source and a function pointer.
> 
>   - `struct odb_transaction_loose` is the backend-specific
>     implementation.
> 
> One question though: is this tansaction really specific to loose
> objects? We also seem to be handling packfiles there in
> `prepare_packfile_transaction()`, so it rather feels like this is
> specific to the whole "files" backend. I might be misunderstanding
> though.

The current transaction backend is primarily used to facilitate bulk
writing of what would otherwise be loose objects into a packfile. I
would like to eventually expand the use of ODB transactions though to
cover areas like git-recieve-pack(1) which currently uses tmp-objdir
directly. So it probably makes sense to call this odb_transaction_files.
Will update in the next version.

-Justin
