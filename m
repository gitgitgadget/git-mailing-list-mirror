Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4290C1922EB
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475155; cv=none; b=EHL+F33P1QzIDoGJwcEOTfZ7gEnzj4+gMFGQfqRNeixBVBwdMdpfzeif8wlOrMWyLCSWs0IHKJYBKpe3Rr4gjkt4QVBDEbWfTdOd3cCwH8Qv+0DKGXz5koAnhHmQDTeFPTwJ3Dwq1oY6+ZJRCl6xDOFHRnexzVtxfKvvqHD/NI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475155; c=relaxed/simple;
	bh=gOHIYym1dNLNPlSQ0nO1+9Ro4viQVgIJZoN0jKp4xsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6r7ZFd6vcW0fm4fBVVKc/wZp41FXbwdsG9/CJypaaMhDib+J1AklWwcBH5T6wKaYGgTUmXEi4cL1fo4t6FDvxNE1iT84dcgXFw19OQ8cnv0A1IkbxdXOUMiFcMem2Eh3jrCSlglKeCf8+dSHcDSbNrcOx3+exbE0HxQAJ+FDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZkJpBrC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZkJpBrC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6bce380eb96so4018201a12.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728475153; x=1729079953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4ot1E2AulIc0JO94jTxLyt0/KofGWiwwpFMAzQUuBE=;
        b=XZkJpBrCGPBSE/FCMnp04itVfZQNwSBJrGd0KjXWxinIJmCiHStRq6+idAMvjxzGeu
         fVlbPih5QnZWmdVRpKY5gDfF0k0jSzZdvhnoqKdHFuyWqGggNPVM5fWOs3w7iIcEjTkG
         6DsfLS0Jbk3aLLgXip1Ktfr0sKec7wX41IAyTf6MKTENydOL9Pczhw0oAdMPO1QjSC8U
         MIaGfxqBMsx9NGUjqlUGvAIo2NMSbS9sEgxmzmzVcio72imQi59hjSmhB2R5vH/2ZsTA
         D7sW0nxe8npwN020G78FH953U8svcmPLKoubxo8ZNui5hUSH2P8Lpx456iNPpTLb4cJ8
         XEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728475153; x=1729079953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4ot1E2AulIc0JO94jTxLyt0/KofGWiwwpFMAzQUuBE=;
        b=gNOevLtAPGrMDz+n68QxHjxDn/VsgBOwScVWI8vR5pBVivKba69tpYiyQx+bG0SWMv
         /SImGhKBhsxhEe0np5GViQteCgJ95tBHvLxmN0flJRxPATL8c3MMZViukzamjATPbMP2
         bT0uSmZg+cLV5gIo7sCMyAYRQFY92TbEc0gRWPajbIHLez5brwTwJW38MYWcl0HdR2tx
         OR77PIMQS4EzQMyo5wzLMV59AitmyBbggao1gvs2x1r188cl9mNHl2CXJA4ubpufK4HZ
         OmW1Hu0BQiuAQwUAC4hEn4YdjCGI4fKa6o84IN+6pheZrBruIXlIWiKnj0kO8vFmb30Z
         8L2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0H6n+r7Z9cotO2FHQUw1gXH48zCCagdDQpkKoen5sx/HaLf6hDt8SL6qiUYIXBMUVt/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Dw66ku7dbyNNHnhBp0hUO3mBwI0+m42s9iAJmKEj7fSEygi6
	1zVLTuDZqGQpn0OE2JOUV+GugY3uRdBhefmKGrlFgpyJx8g3faTvrfTrKQ==
X-Google-Smtp-Source: AGHT+IGIbSeqNPpENbKSRKc7YCrUQStMTKEYy6E+Qi+QggU6okGcF6vQDwqMZ7N4Y9eCvlyOTs7+9g==
X-Received: by 2002:a05:6a21:918c:b0:1bd:2214:e92f with SMTP id adf61e73a8af0-1d8a3c003ccmr4516161637.14.1728475153544;
        Wed, 09 Oct 2024 04:59:13 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c35f36sm7069860a12.64.2024.10.09.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:59:12 -0700 (PDT)
Date: Wed, 9 Oct 2024 19:59:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZwZwGAxkbQtnozh9@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
 <CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>
 <ZwUkZuCtYu7niuFM@ArchLinux>
 <xmqq5xq232wa.fsf@gitster.g>
 <ZwY5O63OI01LZX1u@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwY5O63OI01LZX1u@pks.im>

On Wed, Oct 09, 2024 at 10:05:19AM +0200, Patrick Steinhardt wrote:

[snip]

> > I may have said this before, but quite frankly, the API into the
> > fsck_report_ref() function is misdesigned.  If the single constant
> > string "cannot read ref file" cnanot give more information than
> > FSCK_MSG_BAD_REF_CONTENT, the parameter has no value.
> 
> True in the current form, yeah. If `fsck_report_ref()` learned to take a
> vararg argument and treat its first argument as a string format it would
> be justified though, as the message is now dynamic and can contain more
> context around the specific failure that cannot be provided statically
> via the 1:1 mapping between error code and message.
> 

It is not "learned". At current, `fsck_report_ref` can do this and is
the same as "fsck.c::report". I have explained this when replying to
Junio.

> > The fsck.c:report() function, which is the main function to report
> > fsck's findings before fsck_report_ref() was introduced, did not
> > have such a problem, as it allowed "const char *fmt, ..." at the
> > end.  Is it too late to fix the fsck_report_ref()?
> 
> I don't think so, I think we should be able to refactor the code rather
> easily to do so.
> 

It's not hard to refactor the code. But this is not the problem. I am a
little confused here. Because we already allowed "fsck_report_ref"
having "const char *fmt, ..." at the end.

> Patrick

Thanks,
Jialuo
