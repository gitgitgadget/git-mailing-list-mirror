Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49813BACE
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141343; cv=none; b=n4J1bPstCALSzrhh6eUBBr9apnS6fYzQpTW/NN/OqRnc8pQXOJlHGy8qzGLvOEJdgupeeVwmh+TE5EdfCMJpOoJ2PwdEogdiVOfvk5SbyrQ1fsdxRebCcuIGuECoOxsd2ihxCrG26S6+duE3pfvAozEBp+DOdCRRg4aYdRR7W5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141343; c=relaxed/simple;
	bh=amMWZakEVmXwLbXtkKiJUR7JoKSfw+Zv5RrjXMPX8hY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvKUZl7spDrCz3DYehdYODM5bFj268h27R9lVW4hUKAaTTbbPqEXc/o/spXhyQkKPcykBMLNM58aYTzZo2eOKo2wA6BFfpndPdqVra2UGCjXgRoaPuw3GrbC0XBcXfSORIE9TH87VS0VZvVssQ2NCDXpVmepzP4EvBHYDoGiVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+sagPKc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+sagPKc"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb81c0ecb4so1719702a91.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723141341; x=1723746141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUTYEVWRC2zdCkjaUWM3O66X/BOcGC+v9OWRHJJjDpU=;
        b=j+sagPKcR8rUccPWSS1x2nyYN9Hs4JpjDosvuNyIm+U/gnAntEBWQcbAygOnF+2hpX
         UsVNWykfBoGqyXa97GTXYMJmtm/D2hy09dDNYof6o2v6ZqUPWtiG+yVWMdcGHCHqHTc1
         dcl7WbGVsSFlmbOCNm1xDqQMjyEL9rJn7DnWq9CS4hn5yPXakOHDJHo/QhiM2eSu8nh5
         Oc1mdOA7o17iCnt+bHPGVwtfcD3ROpht3imKAjcCnMVHyhPpieGkk7k6Tpz43MCtjU4L
         anVMuMBFLSVDcQSSfSajBtKCz/2+9s03zrxNdmZy8Gj+zZDptTSVznoRMQKFP0cmvVA+
         9r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141341; x=1723746141;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUTYEVWRC2zdCkjaUWM3O66X/BOcGC+v9OWRHJJjDpU=;
        b=Ok2NuYE1/O5sCrnTfzqRvBNNqZvBq9fLez+2YQ3r0nx8L/mktWoSj5n0SfyvbJeMr8
         7WBuM5VqK1Dtw7ih4Dwnr+9FvPPU8cRu+M8afSjbGf3l1Wa6ncMy1uJEVxNZ6ZH4BHWT
         6uX462JMkpA2RLWW5RWhQEAS4OC9xuKabVupPsBWkdzcBY3IfnU3+NqaGjiEAaPooTbp
         NOZ7haXak47ss538tNw1DGapgfsoVjFRLcgFjuDFES21NOWVAuIor7lkIA+iTpA5pBgh
         MhSxyBx3Tnsmlxaq2TObixYak9yg+5wrLZa5P0Di9kRVAUAA3RJLKCtQfAqtkvRlFIBo
         OE9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/ai5hvZEzoLEItrFjdTV3fiExMR8RsWvnS7H4qRvPBZBvpA6kcLP5OF+Wk7QvepZX3vHJFTrKrIsSkEhvMYNR3i8D
X-Gm-Message-State: AOJu0YyS0M8xwtP/LBRYP01GM4ug12yoWo3cwUWZptrLoHASnQ6JVD3v
	bFUDRnqAtKdHO/k3XmjOMv/o7tQ0eZdzA2kcoCzetWVdVYpkkBFGBJJAU4Nhfw==
X-Google-Smtp-Source: AGHT+IG9lAtK9TJg8iHVaIua2mpc8Ft0tlsQr3Yeje3totfmvb8NWxL7bDO/KkBCQXeXDC34D3icmA==
X-Received: by 2002:a17:90b:3b4a:b0:2c7:49b4:7e3a with SMTP id 98e67ed59e1d1-2d1c4b9bf1bmr3921572a91.7.1723141340584;
        Thu, 08 Aug 2024 11:22:20 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:fa12:a76d:ac7c:e104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b8a7453e92sm6944014a12.41.2024.08.08.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:22:19 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:22:15 -0700
From: Josh Steadmon <steadmon@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <htakxe76kl7ll3q7trjj6cjnsrg4tnue2k46zo25bnf3zre7t7@r74vgvebdhsx>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
 <b5epjlsptw3punygmx2abmfnrkki6n6ta4fk3yse7iodlabr63@zss4z3575r7v>
 <ZrQJe32sYNOTSJGf@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQJe32sYNOTSJGf@tapette.crustytoothpaste.net>

On 2024.08.07 23:55, brian m. carlson wrote:
> On 2024-08-07 at 23:05:00, Josh Steadmon wrote:
> > Yeah, needing to free() is the only thing we striclty need from libc
> > right now. Please correct me if I'm wrong, but IIUC then any memory that
> > is allocated on the C side and then passed to Rust needs one of:
> > 1) freed by libc::free() on the Rust side,
> > 2) passed back to the C side to be freed there, or
> > 3) leaked
> > 
> > Am I correct in assuming that your opinion is that writing additional
> > *_free() functions on the C side is worth it to avoid libc? If so, then
> > I'm fine with including that in V2.
> 
> I think if we're going to be writing a general purpose API for
> libification, we probably should provide free functions.  Normally, that
> will be a call to free(3)

[snip]

So in this case, does that mean we'd replace our call to `libc::free()`
with just `free()`, and then add a declaration for `free` in our
`extern "C"` section of cgit-sys? It seems to work on my machine, but is
that actually the more portable option compared to using libc::free? Or
have I misunderstood something?
