Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC9209691
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357699; cv=none; b=inUqpj7Br51zAIVWbTEXUmsU4JIHuwfaBMsZXf3oZAXHqh0gyGGt6xzwBCOw5mB5xd8l85TusyqPGle6BUjhqv+XSwYLhpQXDY5bMgQ+LJQ9/PA92R+C2o97UL4Q6U2/Pbqd9W27qcGQ0hLuSKjKLyhkvDwIwhLQ5Anc2yWWkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357699; c=relaxed/simple;
	bh=pHZdBSZ15PNtnMmvQ+1qF4yNNnas+fbPljJhm792kr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlhU7Ik32t7kQtNBqKV32qWWBBpn3ioKMP/MwqNj93b64obp9mAJJpbEgqTxDrWW6kGRxfqN3xdYW8dMoVEnY5Ou4aPnZ6g/9jn0wI0ykgwLm5VpVVKprwKZ1AG4yNRipoFGEO1r6Ma9RcJu771Wh37QXnJuy1nBdsaEQS/cDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4RhSLmI; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4RhSLmI"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd43aa1558so51759306d6.0
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 02:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739357697; x=1739962497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdUpE8BkTcPAJTfhEjrgIkOEDrlcNvZ1gOT+enp1vw4=;
        b=U4RhSLmIuodElRWLrDmAitqRj9a67K7IfBQaK7vOy7GP7TU9R5zdc8prj25clRplkV
         ryaSDxJ9Rm7nrvWtH9aeY3vztGf1cKMF776aNQKdMmjucRwpqt7jjhPCCBA5BCyfXUDT
         9j3xgXGmLOtqIeUGGRyVdz4PWqZnZdE59W+qsU1th6Vl6ThAgiytEhiSJ5pXd1O9pn58
         mWcq7kMPBis/uLblrJAoiKWvqP6capysKooVFJeC2QYZwIzQ0DJaRT6CEb8mfiaJDekB
         SklvnGg6xfGavWVNJfY2Tt4fA1X9NanS1MKP7Cs2NlAiSkCiiQ3BNdDMcVjAXXB+WVPq
         iqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357697; x=1739962497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdUpE8BkTcPAJTfhEjrgIkOEDrlcNvZ1gOT+enp1vw4=;
        b=rsDVJWSsNqvqece8u0a9Dowzx0QkXV4Hi9oyeEvjeurFHNOHpvwz55xZu5ZJ3IOP/I
         uwG7zw43Fix9UB8nKm/Bjl8Bj7q99YWeyy9eEJTAUVhWmVly3OWAkzg2vN8Mym5/B01g
         uYtwNu/8M9bogS/onT7Omft3LgdweIrBVLq45c0BVpxfXSVTjCBtQL19y/rz1wk/SAPV
         fFbkpKu+l1xksvBtnj/zfeHOgtoSZjlpypP6u4b05RoakJqmnC2zBUcdxX4NTrjfZmg3
         pr/4ccFq6M7A/xicQTxcjK84AW8+IxxMNgaCa5sz/5/gq1/YUzLzCNA7Y7ctSfQLTzvZ
         QCwg==
X-Gm-Message-State: AOJu0Yxjfrjz/5metD9KiGdqDc2Et7I/Tz4AUJje01147AGzHbXTj/FZ
	M6dheVaMewJt6k6+yQGvBkgoEZZq9K3EoWrgzqcjv3RT5hJbyNM7hdBErg==
X-Gm-Gg: ASbGncvdj5ReVtXkocVr6dPEZ8uymXtNBEX15QCJ7S72FmkKJuhw1nJbO45wdMoSjoz
	DDUjaKuTdV7EFmv+wNbJCG0REBiASmG4SJQv2yws3iflY3c6bBQv/Ziw3fSQZ7F43kZc8X/lNW4
	IXjszslcA8KJPoFxz9rMSl953qAGdgHypHb8a68HEsWmzj+1udagTnoBxnBc9/CbPpt/8aC5OeO
	uPPPL/RdNpT3hSfDGv+onsfm6H+UFJg1/yA8JJOHNvtnFWdEJulYGiZmqX+WfLzhNdK2Q==
X-Google-Smtp-Source: AGHT+IGRlSrmuo3F6DMbOBe2KEdxXuRtFtQ9PqVETyr8RZZsqP8XVOUuypT0gbP8iaBjjTiFSKYC9A==
X-Received: by 2002:a05:6214:1310:b0:6e4:42bb:5edc with SMTP id 6a1803df08f44-6e46f8688c5mr28133726d6.8.1739357697227;
        Wed, 12 Feb 2025 02:54:57 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65a5d69c3sm125696d6.26.2025.02.12.02.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:54:56 -0800 (PST)
Date: Wed, 12 Feb 2025 18:56:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 7/8] packed-backend: check whether the "packed-refs"
 is sorted
Message-ID: <Z6x-ccfRlVJXkMMh@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RP2_wL1gjsWpkR@ArchLinux>
 <Z6xwaMIUx_x6QVrU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6xwaMIUx_x6QVrU@pks.im>

On Wed, Feb 12, 2025 at 10:56:56AM +0100, Patrick Steinhardt wrote:
> >  static int packed_fsck_ref_content(struct fsck_options *o,
> >  				   struct ref_store *ref_store,
> >  				   const char *start, const char *eof)
> >  {
> >  	struct strbuf packed_entry = STRBUF_INIT;
> > +	struct fsck_packed_ref_entry **entries;
> >  	struct strbuf refname = STRBUF_INIT;
> >  	unsigned long line_number = 1;
> > +	unsigned int sorted = 0;
> > +	size_t entry_alloc = 20;
> > +	size_t entry_nr = 0;
> >  	const char *eol;
> >  	int ret = 0;
> >  
> >  	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
> >  	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
> >  	if (*start == '#') {
> > -		ret |= packed_fsck_ref_header(o, start, eol);
> > +		ret |= packed_fsck_ref_header(o, start, eol, &sorted);
> >  
> >  		start = eol + 1;
> >  		line_number++;
> >  	}
> >  
> > +	ALLOC_ARRAY(entries, entry_alloc);
> >  	while (start < eof) {
> > +		struct fsck_packed_ref_entry *entry
> > +			= create_fsck_packed_ref_entry(line_number, start);
> 
> Instead of slurping in all entries and allocating them in an array, can
> we instead remember the last one and just compare that the last record
> is smaller than the current record?
> 

Sorry here, I have missed out this. Actually, the way you say is the
most efficient way to check whether the "packed-refs" is sorted.
However, there is a concern. When we check each ref entry, we could
compare the refname with previous refname. But I don't want to do this
due to the reason that I don't want to mix up these two checks. To
conclude, we have the following call sequences which are independent.

1. check ref entry consistency. (oid, refnames, format...)
2. check whether the "packed-refs" is sorted.

But I do agree with your concern. The reason why I record them is that I
think we have already parsed the file, I think there is no need to parse
it again. So, I use a way to record the information needed to check. And
this would definitely introduce memory burden.

So we have two choices:

1. Keep the design unchanged (space overhead).
2. Parse the file again (time overhead). Thus we only have two allocated
memory.

From my writing, I think 2 will be better. If there are many entries, we
would allocate too much memory.

Let me improve this.

Thanks,
Jialuo
