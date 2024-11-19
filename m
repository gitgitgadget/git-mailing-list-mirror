Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541711C727F
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018371; cv=none; b=YjkDMFhsAe3TOX41zPFDBZ8XtQA1zD+R5u1MVqSAbbkrol3Yrh9+fmRKeR/R5CNXCqlp+I8cfYXnAMMGp56N0/1fYmsn2OfBiOByeA7JTNb7gZBA8nXmHYztus6Q2BZWnywLy/a4lMSls+p7KytXXiQtGAoPuYG61qY6/QkAUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018371; c=relaxed/simple;
	bh=ZBsTtVemOkMg9EKHWpMf8PxIUXRQ2/9NPC9UwG88Odc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAVXXF6y86041oI1x0n6WhpFX4Jqy+fIvJxYQwyAHsXKqi7VeQmQb18B8EXpUqG53DTbjL4xbjFOCGHryDoDc3rjjIugu89ILcwF3S6k2JKlW24Hr2cj25w6I+0pjZMA1RKw4GCsFxrv5Hb4ku6BxtjerlEbRioTfwmkhuMBKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTw09Mdk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTw09Mdk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c6f492d2dso31793735ad.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732018369; x=1732623169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jRZW49Cmn+raCp5yROSNhvhXDiG/1NfsJ7MUrjE0DU=;
        b=hTw09Mdkw5iwAEOFOANwUnfqk/3/BOLRmBqgQ6PHWkewUoW9BLTPZ/P6ZcCIGuVOZ5
         /d0JGttIByGJXFJtli+I32QpcABkAZZZhOgSpv6nD+aJ6lo+87EhJ9vHZGzTkOM9Sjax
         g1FpxIbS3mhT6KEU5Ofb+SNcbLQhRcN4TBYZ+27q5HS+p72DM6A4WrkE92g5gNIavy2X
         wniOLu7qrOOcp6yvAD0+YqvKFkVqsks7W/i5gM0LuHtxDTciz0Tlby9Ptv12dr8xKrUU
         i718xZHSvyPrE4EjOcXACQrpDegVOiYac0Hq1DQA3uC1eCyDx5fZfbCdSg9aRqAPfpT4
         rOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732018369; x=1732623169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jRZW49Cmn+raCp5yROSNhvhXDiG/1NfsJ7MUrjE0DU=;
        b=UHpzoHwSe7kxAw5/xY7zncJc8y0hDb1tzJwjv+7gg7+uEGhdvA/cwzTaYdnHIBNGe+
         THm0G9jBnYGHGe1E8onUxh4EDMMrQ8M+mDci6qo92JE/JnVBDhYp35+IVD6NXgSZnVkz
         30RN9XtDRCXAVcx0Ss2A2TuFLcndxnadN8uojt751EkF5ql2Bwm7o2KKFQdyt5vcA6e5
         WGQFDStmX2klRrcn+i7wO2geSkoYmDovMbi8wFuGrOT8ObRzXUVlcyy1LLUBah3/IH9Y
         aRt8/JhMW96woRd3N0fswOjZrCb2tujKmLyTmqhVG+81wwdR4dkmPZ//iVTamUfiwnx/
         qQXw==
X-Gm-Message-State: AOJu0YwNKCI1AB1KbYU68KbU1syqspldTLu4BN6KA0X/336OjbD2JmvS
	4hOFsjEFNBbSLEnLKaD4U1yRc5wfJV6IqZ5amtt7wjnzWVMF0yBJ
X-Google-Smtp-Source: AGHT+IHbvGNbfvyhSqlVZI3bYJMslxtCGjWv/Fk/ugcjTBTjR2+xTng+748m3GrGzqx/uqH68YVItA==
X-Received: by 2002:a17:902:ec8c:b0:212:548d:a5de with SMTP id d9443c01a7336-212548da8f4mr26126435ad.34.1732018369330;
        Tue, 19 Nov 2024 04:12:49 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212009e1c90sm49975575ad.136.2024.11.19.04.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 04:12:48 -0800 (PST)
Date: Tue, 19 Nov 2024 20:12:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 6/8] midx: pass down `hash_algo` to
 `get_midx_filename[_ext]`
Message-ID: <ZzyAyMs0_A77DtGS@ArchLinux>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-6-761f8a2c7775@gmail.com>
 <ZzibPPpDw518npNp@ArchLinux>
 <CAOLa=ZTU08VGeATHDwnREiYT=PMevrTvG3BzffLCc8DBcHy-tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTU08VGeATHDwnREiYT=PMevrTvG3BzffLCc8DBcHy-tQ@mail.gmail.com>

On Mon, Nov 18, 2024 at 10:25:09AM -0600, karthik nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Fri, Nov 15, 2024 at 02:42:19PM +0100, Karthik Nayak wrote:
> >
> > [snip]
> >
> >> diff --git a/midx.h b/midx.h
> >> index 78efa28d35371795fa33c68660278182debb60ab..7620820d4d0272926af9e4eeb68bfb73404c7ec2 100644
> >> --- a/midx.h
> >> +++ b/midx.h
> >> @@ -7,6 +7,7 @@ struct object_id;
> >>  struct pack_entry;
> >>  struct repository;
> >>  struct bitmapped_pack;
> >> +struct git_hash_algo;
> >>
> >>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
> >>  #define MIDX_VERSION 1
> >> @@ -89,8 +90,10 @@ struct multi_pack_index {
> >>  #define MIDX_EXT_MIDX "midx"
> >>
> >>  const unsigned char *get_midx_checksum(struct multi_pack_index *m);
> >> -void get_midx_filename(struct strbuf *out, const char *object_dir);
> >> -void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
> >> +void get_midx_filename(const struct git_hash_algo *hash_algo,
> >> +		       struct strbuf *out, const char *object_dir);
> >> +void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
> >> +			   struct strbuf *out, const char *object_dir,
> >>  			   const unsigned char *hash, const char *ext);
> >
> > I don't think it's a good idea to put "hash_algo" in the first argument,
> > we should put it at the last to align with the code style where we use
> > "git_hash_algo".
> >
> 
> Could you elaborate on why you think it is not a good idea?
> 
> I've mostly done this to stay consistent, because I see `struct
> repository *repo` being passed as the first variable in our code base.
> 
> Roughly:
> 
>     $ grep -Iir "struct repository \*r" --include=\*.h | wc -l
>     524
> 
>     $ grep -Iir "(struct repository \*r" --include=\*.h | wc -l
>     327
> 
> Since `hash_algo` is similar, I thought it would be nicer to be
> consistent.
> 

I will elaborate on this. The reason why I think this is not a good idea
comes from two aspects:

    1. I have thought that we will always put "struct git_hash_algo"
       to the end of the function definition. However, when I carefully
       inspect the code today, we could put it everywhere. So, I wrongly
       made above statement.
    2. Another aspect is that I think "struct git_hash_algo" is not the
       most important parameter for these functions. When the caller
       sees this function name "get_midx_filename_ext" without any
       knowledge, passing the "hash_algo" firstly is a little wired.

However, as 1 shows, we may not care about which position we put this
parameter into. So, I agree with you that we could just align with the
"struct repository *".

Thanks.

> >>  void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
> >>  void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);

