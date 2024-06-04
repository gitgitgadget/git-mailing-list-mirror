Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7B146591
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506743; cv=none; b=i9dF1iRL9IlmNO/pOeSHwpvwWjgtuHqzNb6UUHFYd6jc+gayIIlXcYOh8xnd7ZYZVQ1MG40tYWYgOlgwl/SX/t2COKLb4Tszyo+/JHy10PjwJJEWdsaRpPRem52rdvXaS/QeqIU8QSkFa6Nq35+3Ucs+Cb3KlOCn1XUb4VRBX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506743; c=relaxed/simple;
	bh=MZW0blWjYo38gTuLv6nPE/jet6OcEc5B99iirXaLC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH3XTMSYXJZX++trVhM7ckSPGlL0jqUT1caMUYSRGDBhmk+IsgwgkgSAEV5lfviW1RbVGhoK2mA59FqDNN6Pp4F2QHsfNC6Lff9YJ78Kxs1vTtm/TILZ2OkazNutFobe4AQnnaaafdQ2DbaAlrKtUk4O0N29l/NBLp7pxXl3sZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXASxjSB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXASxjSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C0AC2BBFC;
	Tue,  4 Jun 2024 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717506743;
	bh=MZW0blWjYo38gTuLv6nPE/jet6OcEc5B99iirXaLC9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXASxjSBJBzk5dMzaasmYXBeGPfVTQrgcxAAWhKPlVcGTHrkciUXhM41QlLoBUH6z
	 zzlWRy4dP8Mur0mWvGyJFVMNpFiulNMBtTnMEYOOifHe1XCg+BQT/xdH3B6LxIAG/N
	 pOPONP5s22/6wq4VapsoSSiTy6hDf95MxK3XFUwY=
Date: Tue, 4 Jun 2024 09:12:19 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Dimitri Sabadie <hadronized@strongly-typed-thoughts.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Author signature
Message-ID: <20240604-omniscient-skinny-dormouse-bfae0a@lemur>
References: <D19KZ1CBA7JF.27PYPL5X68543@strongly-typed-thoughts.net>
 <ZkPA2Pmz2EB6SOzL@tapette.crustytoothpaste.net>
 <20240514-lively-potoo-of-sorcery-0028de@lemur>
 <20240514-demonic-quartz-hog-be2bd2@lemur>
 <D1R8VB91BRR6.3M3651RXOQM5Q@strongly-typed-thoughts.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D1R8VB91BRR6.3M3651RXOQM5Q@strongly-typed-thoughts.net>

On Tue, Jun 04, 2024 at 02:50:49PM GMT, Dimitri Sabadie wrote:
> On the other side, I just had another idea. What would be best to me
> is to actually provide a _proof_ that at least the author acknowledges
> the patch — whether he wrote it or not is another story and I don’t
> think we can enforce that completely. The goal I want to achieve is that
> if I send a patch via email, if the patch ends up committed by someone
> else, I still want to be able to have a proof that “I wrote the patch.”

On the kernel side of things, we're using patatt for this purpose:
https://github.com/mricon/patatt

> So assuming the committer is not of bad faith and doesn’t truncate my
> git commit message… why not simply adding a “sign-off” like line at the
> end of the commit, but instead of just putting a clear text that anyone
> could tamper with, we would sign the date at which the commit was made?
> 
> For instance, I could have a git message like:
> 
>     Fix typo. 
> 
>   	-----BEGIN PGP SIGNED MESSAGE-----
>     Hash: SHA512
> 
>     Tue Jun  4 02:49:26 PM CEST 2024
>     -----BEGIN PGP SIGNATURE-----
> 
>     iHUEARYKAB0WIQRsmRqgbXp8KFc3mc6pQ4aopiUuywUCZl8NVgAKCRCpQ4aopiUu
>     yyhWAQCScfP28Py0QbHuqzzOFyjAMwdK0LfwiGfYrfzfv0evlAD9Hd+x8NgvPq2p
>     nnnG5tQaHeIS/v8PMP0suy3QiWV8WQc=
>     =Ru+m
>     -----END PGP SIGNATURE-----
> 
> If a create another commit later with "Fix typo." as content, then the
> date will be different and the signature won’t be the same.
> 
> What do you think?

No, this is not a good solution, if only because the date of the commit can be
freely edited to match whatever is in the signature, and then it can be reused
for any commit at all.

-K

