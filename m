Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C0C255E26
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759656586; cv=none; b=aZQCRJ8m75rHPT04RtqEOcNN39g+AAqLrJCEHgIK7//OuTHFQKhqpJkY1fuBQhkX6DfRgXwYe4tHM5BSiqzi96kHFelHE3nEP0h79ba3viHe09omdGikQoWoGT72lq46SRCrNE3U8D9TaFZfCl6146b+VoZQMQm/n406aHejOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759656586; c=relaxed/simple;
	bh=GaQ07uP4CKCriQ8tRMvfunxe8EHB5Y/+/TBzkfuYsks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD0jrzyFkKm389BVCT61lebCf2eUK9PB5Y9og1jo3C6lMKjLsXk97eOVBPDjW5V92iFhw8rJYDuKfYqA/+f8vZczCyWW3rqg/o/iUO9WZhMCHCOupYk1zdr7uV58h1cdfmjY0Nwy/bykwDGoQEpVa6rU60ylSRU2vo8fwqUSV+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqTUX0j/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqTUX0j/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so3663341b3a.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759656584; x=1760261384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbkdgEVL/GV6XclbIS4+l69Y2UZc7GnCAtguQdPQgKQ=;
        b=gqTUX0j/7KtBp4BMNIoRaN8dN/GL0EP2tbDTcjc96CG5z1vpAPJLKNID6cJxc7lp+e
         Xzn1aEaYOXO1UdQOd3R52vTg4zMCNaJ8HlwJyk9N8hhjSO/7jZr6g52YCLJVSqrvsvS5
         XHqGFjnoq5QU8S2MAXpK0dibRsfQ4OKAtZMGucXTnNbLgDAHzboosT2ANvkOwjqxwoqJ
         wT4N1rqOeEU4gpTysu/T/eHVmwGsoLmppOmSJUMA5d4+4qsXuP3YvjkZdvt+uOS+xvHr
         m2xu7wci4Rdi/moW5MfiiGjcigvbhGEbmvvnkdaOhpKFYJDn2t5Z1J4DnszD0MBM0mWc
         0Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759656584; x=1760261384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbkdgEVL/GV6XclbIS4+l69Y2UZc7GnCAtguQdPQgKQ=;
        b=sdDC3IrPTc53zBFBJrm1MdWk4Jdyw5wE1xymMsiqMsurxuchSCYE7oD7BbIfNBt8EM
         jik3hH5z8hj3KYHnvwO0g3vGbS3mBb1mzyrI1aBok2j1qAfa1UWtiePXIcFQRrW1RbnV
         SxxNRrWsGSEYRgoCm1STZH01YunvJy7KCFb2+CG+VrXNYRHZ12umwYNX1C/ltw+f91Vc
         cai8d4VzEBlM4e5eaaaeFfraWKBfdNAkt/mYEWCEDMNNjEN4ZFJGb/R482uaqBd0z2UD
         mKpEREZN1U/WVPKsFK5xAXgWkXQ02FP1egRM0XChXciNTVrNzxkVBjs7+vdATbssIrv4
         nPFg==
X-Gm-Message-State: AOJu0YxJVKsbhmrFXe6sp55BhZeKabOw1Rz1crX+wz1hRZUXnwQo7RU0
	c2Qw82FSA9xq6VNCbZ4Ie53k0EeL1RNbMduihE2H5L62OyWJRhJ/eScm
X-Gm-Gg: ASbGncug8y63F5PdgFgq96z4oP+epIa7YE21z1r2hO4J528Kiqwd3b1tHI6FlBkkffl
	FBhLfnC6imyZF4JfOMlD4w9pSIkcVXz3YCRpLeWvUeHxlGOz8TPRM5/27KRcw36ATngh+T7b/c9
	Id/F39ydOaFqxe3QiLMWLCbzNWBY7RtoDnpg9D6LyVeiy9aUmXuC9Y3/jFOtlfIt7pvtJSoNONl
	MId78KIa1GtCN4HWv7mshGyTQYVcv/cqD0fnhDhT9ZEaY66nmpQdu98LV9+EnaGUzzWjuRsyr20
	nKdteH61WODcRMJ5t6qoOQlYaEYVz4I+TjSXZhIcUxNcDnPej1AgOr98GwndioCbRsbxDefjLNp
	FGEMIzW1eDyA1Q+Lg6a/PvNjJ25OlubyzfmvUT7gVZEWPUoNUQ3Ai
X-Google-Smtp-Source: AGHT+IFAp9VZ8PZevOpcexRwP7WHru+6v7+a4t8MxcZRpdpvzeu2RfbpFBlHzbM+HLP9XvESplIpBQ==
X-Received: by 2002:a05:6a20:42a3:b0:248:86a1:a242 with SMTP id adf61e73a8af0-32b61b2db4fmr10257657637.4.1759656584035;
        Sun, 05 Oct 2025 02:29:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6099af2deesm9211172a12.12.2025.10.05.02.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 02:29:43 -0700 (PDT)
Date: Sun, 5 Oct 2025 17:29:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/4] string-list: change
 "string_list_find_insert_index" return type to "size_t"
Message-ID: <aOI6hrpSvp_RS5VY@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9Qs2AHBax62LL@ArchLinux>
 <CAOLa=ZSGb_vvcneJ-b7ahL8J46a-FFKzupXaO0eKcyNehwTF+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSGb_vvcneJ-b7ahL8J46a-FFKzupXaO0eKcyNehwTF+w@mail.gmail.com>

On Tue, Sep 23, 2025 at 05:44:42AM -0400, Karthik Nayak wrote:
> >  /** Determine if the string_list has a given string or not. */
> >  bool string_list_has_string(const struct string_list *list, const char *string);
> > -int string_list_find_insert_index(const struct string_list *list, const char *string,
> > -				  bool *exact_match);
> > +size_t string_list_find_insert_index(const struct string_list *list, const char *string,
> > +				     bool *exact_match);
> >
> 
> Super nit: can we also add documentation to this function while we're here.
> 

Sure, I would update this in the next version.

Thanks,
Jialuo
