Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F33203B4
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603825; cv=none; b=YrOfoKk2+9dj3XPNHrWN8WJhDEqUOvHGPPmYjxxKT3CcCzECxX0dbayghuocznpxehxynAtsUJHruSh1kxEUzXExJGTpEP15SMbz/PU4N90fFnNdNCmQ2tiVRvTz0HwSUtP7AdtxmEUzWSobo8ltqIKq/rGiBlKXKCEJ5JybOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603825; c=relaxed/simple;
	bh=zK7aWtjZmLhzRpxGkz1Pn4utmr63nsnm80zgRwBQ+Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2oEBW1awEnQEz20Rv1cbqb+lLP7HtyUPQds+QxF77MvaY+N1/T4YPwHiNjgoPT8+BTjzOcVLAJJRMg5uMpZdhogsGgxNufiIOMABl+JUSWep6mrjWmZTP3XhJHZX/DIaI8NJ7z+fVVm/3kmb0dHyIt8NpYSkjMEiy+n+uXvbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkIPJV0E; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkIPJV0E"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-43b40cc73f3so483133b6e.0
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757603823; x=1758208623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNO5o+WpcvcDKIqA1k+F+RTLyi6YjqeWQGkpCW9nBic=;
        b=YkIPJV0Evq+mYrF/J7qcT8G55BRyejLmx/HFmi7wtNE6+Z96aKVXRocEuF2xOV6Tyk
         MHCRgWNsYOVti0rbYqKTOsqizHeW+gUZE8YDEgsGUi9aY0tk+98qHVbg/D4A2qKrRN+w
         Q2UvsqbwwW+dFWX4MNyXUNtvvx0omL9CVOaq2frFGOw3cNFPRWv4WmeX9AOv0k+vFiTk
         wKBtM7vy22ZVKtkM71PMazd2x0MrwGYdNxw8qHrN5MGJEUafxo3oy+R0JhMOgz68dG/w
         mcNAPfTXB6nDMmSuHp0W6o0OOatvbr9JUWMIk6XF1WzP1d1Q0lAFi4JrLDYpILMe2/8a
         1g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757603823; x=1758208623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNO5o+WpcvcDKIqA1k+F+RTLyi6YjqeWQGkpCW9nBic=;
        b=e2s1wLsnKzxGA5q4lGHIJqvzvOFcwMJ3ubkT2EZPLdiJ3f3uV/5tXd5ZykdK95iHUU
         EnmSb3pgeWYyZADRPY0f5xkQkfqLio0sIY7fTKDjIuxv1qtYG0t2H19qiY3/NsAKbAOO
         lF7Fid+OxQGn0tekyJokS1OmGJCp344Efk7eyyrnEXxpk19fZopl0G33bEmJvN+9AUcg
         eor+e36QihaU39AhCX6cosaOI428opl9mQCCpWUn2tsDPkfH2vG86JBHSaQZzu9t/utP
         xqCmi+LbxN4u3JqtxxlWYjK066N+r+0Z3FHFY0e03CzPNakHqM+NBzEdQgS6E5WP2Lih
         9KaA==
X-Gm-Message-State: AOJu0YzqAbovgeCynp0VhbAD4cWvp4bhuWCOhGyHw4I+0I2/Uek8m6+n
	9z5WN37uudHDEaThFA9eED/MM52ZmMRhGNo9fKHtr7QmThBu6VBsHlowVxGjLQ==
X-Gm-Gg: ASbGncvnQG0/fBuTR51gUW5/g/qOQVR0LNUNxpbFF94T6SGFnDwUH6qXytXMJnnVx4C
	jyIlqOYUQbuEE0z3WaQnj0AkqHbuJnmtLP+gfSfPvAgfSQMgWynyOzYrE/eu4u/DS9nKXLOjjE1
	GEnrQEyewYPhxyCvsf7O0Jq48uydfhDfsld5k3WaSkHbGRdbwGIwPIMcLRmNDjaTRBmmfOQFPlx
	LSCXr4ki7rl7vjG8UsvKUszvlR9h2L2B3filpjzAP0NU/dSW0ipqQezp9mc7WHiDb1FNFdZP43O
	usDPuRi/RCiw7BPvHg+4yxFyR5mrDOnyrMbXTk1tpBDqP0tnbPqx4n+dj6BYbQP5qq6Pp4kc7yx
	YH4i+wlFmB3mQPSFe3+N7oUXmylA=
X-Google-Smtp-Source: AGHT+IEoQi/UL3dRDYNuI8uYqSm1fy0rk5JdFHMZ0BgHSOPBt5ItDjGyURhTnWyeDh6XMOrPBvcd1g==
X-Received: by 2002:a05:6808:1a2a:b0:43b:553d:e86a with SMTP id 5614622812f47-43b7bc19750mr1597441b6e.22.1757603823295;
        Thu, 11 Sep 2025 08:17:03 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43b82a72a53sm274460b6e.16.2025.09.11.08.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:17:02 -0700 (PDT)
Date: Thu, 11 Sep 2025 10:17:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] bulk-checkin: remove ODB transaction nesting
Message-ID: <szzrjygrae6fzlzadsjftqf73pphpmzic5ljkwmddxx6o7y5et@vmxbedandc2a>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-2-jltobler@gmail.com>
 <aMJu4yoO5-Xp52oJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMJu4yoO5-Xp52oJ@pks.im>

On 25/09/11 08:40AM, Patrick Steinhardt wrote:
> On Tue, Sep 09, 2025 at 02:11:29PM -0500, Justin Tobler wrote:
> > ODB transactions support being nested. Only the outermost
> > {begin,end}_odb_transaction() start and finish a transaction. This is
> > done so that certain object write codepaths that occur internally can be
> > optimized via ODB transactions without having to worry if a transaction
> > has already been started or not. This can make the interface a bit
> > awkward to use, as calling {begin,end}_odb_transaction() does not
> > guarantee that a transaction is actually started or ended.
> > 
> > Instead, be more explicit and require callers who use ODB transactions
> > internally to ensure there is not already a pending transaction before
> > beginning or ending a transaction.
> 
> I think one bit missing in the commit message is to explain what this
> buys us. Does it for example enable subsequent changes? Or is this
> really only done to have clean ownership semantics for the transaction?

This change does help with the subsequent patches which drop
flush_odb_transaction() by removing reasons for this explicit operation
to exist. Now it is guaranteed that calling end_odb_transaction() also
writes the changes. The change is largely just to clarify ownership
sematics for the transaction though. I'll try to clarify this in the
commit message in the next version.

> > @@ -389,14 +387,6 @@ void flush_odb_transaction(struct odb_transaction *transaction)
> >  
> >  void end_odb_transaction(struct odb_transaction *transaction)
> >  {
> > -	if (!transaction || transaction->nesting == 0)
> > -		BUG("Unbalanced ODB transaction nesting");
> > -
> > -	transaction->nesting -= 1;
> > -
> > -	if (transaction->nesting)
> > -		return;
> > -
> >  	flush_odb_transaction(transaction);
> >  	transaction->odb->transaction = NULL;
> >  	free(transaction);
> 
> But I wonder whether we also want to make this function here a bit more
> robust:
> 
>   - I think we should handle `NULL` pointers here and convert them into
>     a no-op. This allows us to skip the `if (transaction)` checks in
>     many places.

This sounds reasonable. Will do.

>   - We probably should have an assert that if a pointer is given, then
>     `transaction->odb->transaction == transaction`.

Good idea. I'll also add this in the next version.

-Justin
