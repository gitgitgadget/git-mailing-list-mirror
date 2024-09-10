Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2051136344
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956843; cv=none; b=TxyYkMbzAPPkjtpL5sOZSQCYWX2ezqgrI8eqPCmLUx+4mMwE6RKcGiwCFELrTLSdwFkLHFNzDVunbdabIHX0WlK8jyDJEa8ZHmxGaZgIIX7LS080pnvOuS2vmSP9hPDqtbITIL8kWT62P4pQvmZwbMh05WRIN1M/8vUjCn9pEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956843; c=relaxed/simple;
	bh=6fRO+DhJXs/1sqtbI40zD2DxZBKwJfKGDTokg2aOpCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCTM4dzJNSAksZWgnKCN8NpBnF6RYWpZPki8a8vZcJbtE6FwCmb0ILYT+D3x/Ngiy8pkDJLJHFODxt2pxi+0uSfdtbeDMaPipLrP5q6ARX+MUkLU4vjQbYOl11o7vTMAvngy3R7N7LmjSOd73DwnDz0DobjTtLqbJKCe0ie3Ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVDbNXIO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVDbNXIO"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so4140879a12.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725956841; x=1726561641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rqGHByFmsZ9RDh+3TNjUpZzOxcRJFiElTPq0hbuYdY=;
        b=dVDbNXIO7KMS4VC5qRL/TJLV86x0AGtMEaUkHtpQSrHompgPHwNhP1ICm8tk77JEtW
         HaETKt//0M7YgB4HjkWHEF0hLe1jHNrZtp2ShtB9uY/SEI3x6I0wUiA9dDukg3JFns2e
         uy4OR3gd6IIva19uOMNXhoEqZY8G8n5VteAo7I9o++3JZrf26xxcKpd9bXSl2DeNIP+T
         6ih9ACyBk1YDjFscyV8RZtonAxaDDGjRFA0EZZPz99Nto5sn9rjTrUeiC7DvUKBOZkks
         K+/ecWMRMdoSrBFiDATWpga1MrIpkTZM9k0oIgeKjAuFqgXkJjxgG4HlXgyXBxHFPl5F
         OcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725956841; x=1726561641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rqGHByFmsZ9RDh+3TNjUpZzOxcRJFiElTPq0hbuYdY=;
        b=Eq5aXEE1cQDNgsXRApGclSVKOaHYCINyjpcCc22PF3UpsVd+X585zrAKpBSpkspnWm
         GhygbedBqDkVcNG63dMool924w40fJRWmvTDfb9t8zTUGBlU8VlRcUyPLzHKP5f9yjUt
         852iSaP5QKllkFrpbQnpfoXSRUUGUZUohxgEJr5nWunAZohieuGo/q9XD/4UE/Kk64qz
         hhajFjJxrnrPCbsbKGwzS+a6Z9AI3zoOnJ2E+HmhUTrCXAmTxKGl5rv5G3TUtiejmAc9
         qG5T8ArpsQrBUqTYalLBX/EWIC6a7LDV0oeQ/utAeGNANNyLh57BjXOy7AZOK7ycBV/D
         NWcg==
X-Gm-Message-State: AOJu0Yw82F4ocfYZ5xBSRg6jgEqSkN1loHBeBXEKqj/pGGNzoZ2yj10t
	8Mv34HKG5nqvMNKz5nllw7cay3SwZn3et/Ji1ZmieUouIwlUFltK
X-Google-Smtp-Source: AGHT+IHtzqTxkuM2A6CFxSdFI+LKKkLfBhUIJgCVdmDX3bagHASLVa8z0oNSd3e95Nt7f6oMVY1UIA==
X-Received: by 2002:a05:6a20:43a0:b0:1c0:f114:100c with SMTP id adf61e73a8af0-1cf500944d8mr3641696637.17.1725956840861;
        Tue, 10 Sep 2024 01:27:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908feaf7bsm897137b3a.86.2024.09.10.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:27:20 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:28:25 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] ref: add symlink ref content check for files
 backend
Message-ID: <ZuADKU3Lzpee4KJQ@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
 <Ztb_Lzxgla2FHICH@ArchLinux>
 <Zt8OcPTzYg3raQlN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt8OcPTzYg3raQlN@pks.im>

On Mon, Sep 09, 2024 at 05:04:17PM +0200, Patrick Steinhardt wrote:
> > Because we are going to drop support for "core.prefersymlinkrefs", add a
> > new fsck message "symlinkRef" to let the user be aware of this
> > information.
> 
> I don't we fully decided to drop support for symrefs via symbolic links
> yet, so this is a tad too strong of a statement. I'd rather say that we
> consider deprecating it in the future, but first need to asses whether
> they may still be used.
> 

Yes, that will be much better.

> Also, didn't we say that we'd want to remove support for _writing_
> symbolic links, but not for reading them? Not a 100% sure though.
> 

I have re-read the Junio's patch about the breaking change. We will drop
the support for writing. But for reading we may or may not. I will
improve this in the next version.

> >  	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
> > -		if (create_symref_lock(refs, lock, update->refname,
> > -				       update->new_target, err)) {
> > +		if (create_symref_lock(lock, update->new_target, err)) {
> >  			ret = TRANSACTION_GENERIC_ERROR;
> >  			goto out;
> >  		}
> 
> Why does the writing side need to change?
> 

I squash two patches provided by Junio to sync with the "master" branch
to make sure the build could be passed. This is because Peff has
introduced the "UNUSED" check when building.

So we could just ignore this part.

Thanks,
Jialuo
