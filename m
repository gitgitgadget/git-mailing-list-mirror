Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBDE3A1A5D
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390179; cv=none; b=tn/UwqHaZP4y/H3a1WJoQW7aydb2APsbGY2Wf/m9N1BxiXKl8HIdH/t48MMTfnDKCg5IBv+Nqov0bSsTERvWFFwp/1sy/GEp08juN8NmGNgr08rkummsNJcx8UB0poeVBWeZ8Fqtm+sTvN2LB657ufkWc4L/+txWMO+S7kvDecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390179; c=relaxed/simple;
	bh=t+er0HKm8PzhHiLW2xExj6F/xCTkum8eyrIeHyNU7RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM9kIS9n+2HjrJW/vyE5sFkZHSEalmqYUJU/yfPdk5XeWr79DnsgHHmD7/hdm7bOZ2M/UAGbIxhTjUmAJizQPWZv1AtYNJnQ0ezCKlbkKLVWoUsW9PEHFDwumxL5NOdc7g6ZgF5vPoN+3GQ2C6CWLDXrxWZDd/uclwf1b5jczSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP4Dz0jI; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP4Dz0jI"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb6573bd52so1595760a34.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390176; x=1786994976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DDuhYI/ITOajQ5s4sR584bzmZFRtQLUywSDAaGTJnvE=;
        b=YP4Dz0jIyd6WW7glZDWNB+4Pa67yUbJs6wjdc0mgMbtV9PFabaW2WJxm1xfFtaowfs
         RdO/8PF3lUmQQ9CHowcN2gZpaFxIiuDWtLUVm2yZcXbfR2wKIMeeZefVUkxRaPhcVf+k
         UwkraSYntjGaIZwgNXdel0aDi2ypnnTwtgqbS1ZBS4unDVP53cl9uUFr4BXFN2T58DLW
         7nm0HlrqxNd+y6ct3EdaEAqe7w7fRm5uVuhLZNRixBTSIt4WwxcnOhjIh9u1To/LIYKP
         s3R8GgTNFbG/FwUylR4vlvf1caib1wSQImtJtrIE1mgWwmbYgNC+ynVecdsKFeTo1nTZ
         oVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390176; x=1786994976;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDuhYI/ITOajQ5s4sR584bzmZFRtQLUywSDAaGTJnvE=;
        b=D0jDIip/2CdPB4jKUT8svJ/0/VADCphTv0c5tE0D/yRJmKJGHLlGw5Bg2r3heJPnb/
         OpaKuNdNXcF8lztkf0lJ/EyuEqQid7BK7SvWrc3MWWWPZfqYfow5nWaZMNVmlsDPefJS
         u/KZDetn/tX39W2tuxcfjt9H0udQByAYi+cchejx1meTUzmq29WqREW7+nl68yd33Q0y
         BFGqeMNdkC1phW9qaq9ZeraL7GvuYfv7dNrW/E3+IhEhEGwYCEqL1hmnSqWKc5nO4RUm
         YRcDtLyq/t2TLvML53RS/n56W7mzravlXxGiDEUMTgeU5VZxVInYWtwh8q4O2++759yM
         ptDg==
X-Gm-Message-State: AOJu0YxqfxSLjHQsPX2NB4NaBqLCHr9OM4qcEulCCcw9+2Pn/qliYK8A
	H1xcmHRHPKy5lh/zW65lu7p0s31/t6KR2yAm75+kaAEG665vNSjoJJDK
X-Gm-Gg: AR+sD10/B3E8EaUqRigeMnQ4JqlZvCdPPJGGeqzOHI6AsTbvTx+DFF1VrLsi0r28fVu
	L/QoS3JnH6qcE0X6dzCTqpNH/anFWfZ/3+iVOnmVYoe4qfbX/lC1XunmfyjsH1J/MWzqW0KNVey
	mTKruZ3Uyp+37+Y5D+6ICH/MRIIzfI/laphmieyzlDJyCHSRxiUgPepWHcW3aGMYszBOHcXPqrS
	UIe9qokNbJmI1MoE9u5gE0CsXrz4Vj2rkPCZvx5r4VLZ8jXitaglw8hYWt3ynXv1my241GxZnz1
	YRAc+S6Tv+CoahDtBdPs07CM1C3m+cxfTOjpu6bsmYVcRlbPWHo9tY/sNWI0eiNpR8GbCJNjtpi
	l4wYWsnqoHFkDTLvKEdbfNtEwvWvvwzyGXb6vW9Law9ZSXd6xMSVR+pTJuKyQwW1PLqB2dIHbmX
	xMIv7CuLqOq9wkp5W6eudwHp7KG7dIPhAu9yJhuVQo17znkY2V1jYV3w==
X-Received: by 2002:a05:6830:6f89:b0:7e6:eb9c:3781 with SMTP id 46e09a7af769-7f39a97b4bfmr2820145a34.12.1786390176338;
        Mon, 10 Aug 2026 12:29:36 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b7c4c25sm8043834a34.22.2026.08.10.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:29:35 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:29:33 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 7/7] odb/transaction: add transaction interface to
 write packfiles
Message-ID: <anojlSEahYWzFOBV@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
 <20260809190106.1565882-8-jltobler@gmail.com>
 <xmqqa4qu91vi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4qu91vi.fsf@gitster.g>

On 26/08/09 06:54PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > In git-receive-pack(1), the incoming packfile is written to the ODB via
> > `unpack()`, which spawns git-index-pack(1) or git-unpack-objects(1)
> > directly. With pluggable object databases, an alternative backend may
> > need to handle writing packfile data differently though.
> >
> > Introduce `odb_transaction_write_pack()` as a generic interface to
> > handle writing a packfile to a transaction and use the logic from
> > `unpack()` as the "files" backend implementation. Note that a packfile
> > written via git-index-pack(1) is kept in place by a ".keep" lockfile
> > that must be retained until references are updated. To faciliate this in
> > an ODB backend agnostic manner, the "files" transaction backend takes
> > ownership of these lockfiles and removes them post-commit through its
> > release callback.
> > ...
> > +static int odb_transaction_files_write_pack(struct odb_transaction *base,
> > +					    int pack_fd, struct strbuf *err_msg,
> > +					    const struct odb_transaction_write_pack_opts *opts)
> > +{
> > + ...
> > +		odb_source_prepare(repo->objects->sources,
> > +				   ODB_PREPARE_FLUSH_CACHES);
> > +	}
> 
> This assumes that we are working with the first entry in the
> 'repo->objects->sources' linked list.  Should we not use the source
> actually associated with the current transaction (I am guessing that
> it is 'base->source' but I may be wrong)?

Currently tracking of the transaction's ODB source relies on reading the
first source in this list which is rather awkward in my opinion and
rather fragile. The ODB source specified by `base->source` here is
actually the main ODB source that the transaction is created against so
it can't be used here.

In a future series, my plan is to stop reordering the source list when
starting a transaction and instead track the source separately which
should simplify some of this. It may be a good idea for the ODB
transaction itself to track its own source regardless though and may be
something nice to add as a part of this series. I'll explore this in my
next version of the series.

Thanks,
-Justin
