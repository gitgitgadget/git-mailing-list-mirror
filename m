Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DF3EFFC8
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270865; cv=none; b=XitYvzdpavQXITH0egQ0xc7ZJpNaHh4r9JIkPnNK5ulV9rtYcquMGnw97TTv9R27c57kN6TynqAClEjaCg9n38xUhoC6pXzQ/2M+RDK2XCMHyQ5Pw2v4F4WxxM48B9Qo/ca0K70eO5ygoJUvuQ6tmAKrp4RSgZEqpItzM/W2Gbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270865; c=relaxed/simple;
	bh=tauZb0AvoD3H/Wnd9R8OuYpbbNjLIBTYKdrDTYO3K64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZSmWKhh96+IiqGrGk0fLjikd3H01bbUue/FN7xFOuLorqn2pOM8qBTcQ76Dh5UsnYocWCjyzj5XUXte/nVptEYSmlfjcrsS6mb/XyKcgNJp7ZmALlDPcTINyS0SRrdPJbRHiiWk4xsg3KpPE8+uIfgryWq871z0aWF3r09JaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PeCs9oXO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaY+yD2i; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PeCs9oXO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaY+yD2i"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 444D6EC01ED;
	Fri, 12 Jun 2026 09:27:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 12 Jun 2026 09:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781270863; x=1781357263; bh=YSnO2eLgvQ
	5mmAF0ehuLKv9l/B564osGKSGC9V8NMBk=; b=PeCs9oXOIoa3HJBm6zFvHpmwps
	7E2IEX5jhbf1GwPpMzwyNBoZf2+1WHZ1U9jQOmCI5zG4ShVeVVxXLaHD7dYTJ+Ex
	dEz61YVjaN7HvwKyDxce8qQJV+yubxTIJjqQIlJgALy31wx1Fagj/hr4bSjyttGI
	pO5FpTbKU76beQtJvVMUdSYeFFc5DcaoFcWqRMZNN0dyjbwCImg50Cuhl964w4YK
	0UvL2DVAD+WORqHSaos9Lo+j2l6H+2U1i6U2CMj0LCfEiJFPRtXwpsxHsCpy/BUd
	E7+CoFbHi5CWaUmz1iF9cUQvXGp8//7eV70KGw1SkjSaOgpLwsGo14/rowQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781270863; x=1781357263; bh=YSnO2eLgvQ5mmAF0ehuLKv9l/B564osGKSG
	C9V8NMBk=; b=HaY+yD2iMuhlhqPq4b+hyaCkS9hI7zxO7JPpV4VVeqSO0NpLmnU
	I+d4uTntTa2uxGb0Wn4zj4Y4D5FK1AHSjMHbvTomaslgJjTuLSNHbbsFo45vc9My
	7o5uOIU2FOCLakb8blXV69zYMnNqcWOdfz37BQHnqQEHTeu2lJ/PrcAjfS28xX0G
	VDmZGsOm/yFI29MCWTQNLj+c24/y4FQftLj8Sm7M9Jx5xHCAFlY1xcR3hazexNEL
	s3n8fuRZJE14c166i4G8eAkeYp8cWXvjZUjruE/71pgA2KMFFA6OdHt71sdzyr4c
	tFvN6dCnF85ECwI4B95Lxe0TdN7JASesD9w==
X-ME-Sender: <xms:TgksakqamQj2XPxTn-vCeBYYyxQLSZb_dtym6IAUN23LKMyiy6HgEw>
    <xme:Tgksaj-dKvYBCZPvUsmINWioJ088Y4njVtre295AJKaAWf3u06djO_9WED-ck-jQ1
    v-VHpUu4FZE4KoiuB5nyJ-9TyBOTwDC5Sz2LGGDkusInm84JjA-fw>
X-ME-Received: <xmr:Tgksagdd9RdzP5isva_QLuAxHVLh3ko7Jbws_vhCbn_9H3Qqg5CpUjqLtzU51M_ByvyTUbVW3PNhw0AgqMQmjVSiQ-R1urtpyyhlf_NzzcY>
X-ME-Proxy-Cause: dmFkZTFXRDenXycenKuuHtCaTs4PLp3GaktHRR0HO6TYGmoXk7oeRPhAqY6wEoTZKg9X1n
    oLh03DjLHnmPnP+dBEiqIZSWA67wp4Ht10L5PQlCUnnVwq73rFEKQ60P+/1HmdzRQjvK0p
    VJHB7hSTGIEkjLXDJbrqIqRJ/a/cUU1mvF459F7XsQw10PkNXZbteE4pZFhsq4XM/JoGmp
    F4UBW+k+lM4RNbQTY3PEi0eFECOlt0HEPW+q5/omsAHt6wMsAkB4a36guG0w/OzYpSb5k2
    br8g3cvU0T51NgmJwCCA7cmwKScusjKi+DhqkFA+Hk0KhmJTp6wbyOfqAm5SpBF+EPMkjM
    7c2asoKLDNqignX78ESFIqzA2Rhd119pVw8XX8S9s1Jbi3P7SRyEGfUgeveWsiuwUL8q8/
    u1xdsjxyYkVU6JxQXgrd6csSswRJCAp9g9bYgI+Aa8LZomX8vkLiZKlBKMzgc2ZLoitRMx
    cWSeLZ2dKsdMvU++RegDvUpVOSbBbXF73rWlkNGobSFMyH//rJoqUjloDMNv2SlzLANvyM
    6f4lunGkxiFuCls8TR3qMN9ir6qRu8zU0ggRJs6ktErZevOjzwL10+fL94Dn7xCfBXllZq
    ZjCtY6S1BfLHHvddS/VHMbEnwiXJr2It+EPULM9Ug1DTcqx70hqvM40dMAcQ
X-ME-Proxy: <xmx:TgksatIEsQj9mCRfKbAdUHosRAolLxi6yQYwix6yER8_yQRxVWmMQw>
    <xmx:TgksaggwVFk3V7nVWWybaO4DGN43CYPXGTJiM1Bn1BjoAv8Ia9TlOg>
    <xmx:TgksarSnLeIaSKw_jttt9QpjEc4S08ERhjBYDdMHYzy4acdSOukQLQ>
    <xmx:TgksaqX7T-_zCLN6nia_GKqB90ERI83_AEoLSO1D42cCEKnGU2ik1w>
    <xmx:Twksar_A_Kgl1XzgNOfIFmqAG-4Ot0llm8xH-7wKCBcFsYIXaoSWk5Qa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 09:27:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e95014d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 13:27:39 +0000 (UTC)
Date: Fri, 12 Jun 2026 15:27:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Dominik Loidolt <dominik.loidolt@univie.ac.at>
Cc: git@vger.kernel.org, gitster@pobox.com, asedeno@MIT.EDU,
	asedeno@google.com, avarab@gmail.com
Subject: Re: [PATCH v3 2/2] compat/posix.h: simplify GIT_GNUC_PREREQ()
 comparison
Message-ID: <aiwJSBfRbUFZ70gP@pks.im>
References: <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
 <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
 <20260608124419.38905-2-dominik.loidolt@univie.ac.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608124419.38905-2-dominik.loidolt@univie.ac.at>

On Mon, Jun 08, 2026 at 02:44:19PM +0200, Dominik Loidolt wrote:
> Replace the glibc-style bit-shift version comparison with an explicit
> major/minor comparison. This is easier to read and is consistent with
> the format already used by GIT_CLANG_PREREQ() and many BSD

It's a bit funny to use `GIT_CLANG_PREREQ()` as an argument here as
we've just added it in the preceding commit.

> <sys/cdefs.h> headers.
> 
> This has no runtime impact, as the macro is evaluated at compile time.
> It is also more future-proof, as it no longer assumes that GCC version
> components stay below 65536.

I feel like all the message needs to say is "let's do it for
consistency, and it's easier to read". That would've been sufficient,
whereas this argument here feels a bit thin.

Doesn't matter much though, and I think ultimately the message is fine
as-is, even though the reasoning is a bit funny.

> diff --git a/compat/posix.h b/compat/posix.h
> index ffdfd91c7b..deefc43f28 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -4,22 +4,24 @@
>  #define _FILE_OFFSET_BITS 64
>  
>  /*
> - * Derived from Linux "Features Test Macro" header
> - * Convenience macros to test the versions of gcc (or
> - * a compatible compiler).
> + * Convenience macros to test the versions of GCC (or a compatible compiler).
>   * Use them like this:
>   *  #if GIT_GNUC_PREREQ (2,8)
> - *   ... code requiring gcc 2.8 or later ...
> + *   ... code requiring GCC 2.8 or later ...
>   *  #endif
>   *
> + * Note that Clang and other compilers define __GNUC__ for compatibility; use
> + * GIT_CLANG_PREREQ() to check for specific Clang versions.
> + *
>   * This macro of course is not part of POSIX, but we need it for the UNUSED
>   * macro which is used by some of our POSIX compatibility wrappers.
> -*/
> + */

It would've been nice to either move these changes into a preparatory
commit or at least mention them 

>  #if defined(__GNUC__) && defined(__GNUC_MINOR__)
>  # define GIT_GNUC_PREREQ(maj, min) \
> -	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
> +	((__GNUC__ > (maj)) || \
> +	 (__GNUC__ == (maj) && __GNUC_MINOR__ >= (min)))
>  #else
> - #define GIT_GNUC_PREREQ(maj, min) 0
> +# define GIT_GNUC_PREREQ(maj, min) 0
>  #endif

The change itself makes sense to me.

I'm not sure myself whether this could use another reroll. It's all just
nits, and the intent is clear enough.

Thanks!

Patrick
