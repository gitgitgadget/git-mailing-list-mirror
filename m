Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38513E7E9
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755088; cv=none; b=Zvmo5pAD81XqSHvNh4IREAtIGNfpeGi9javqx10Jb7wyZrQmcc5jXKRLRz4FZSGOS2HkFlOND0cmb7HFJGJrhI5gYLbcu2UF24zRDLjXn5lcIZdefPVcniEDbbABbhhMB++3mVfbNUgPZe/3XtBbuslCH7MSGos4W6vwWN9g1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755088; c=relaxed/simple;
	bh=rM0BZkKu+aVHFwgOznJGFEx+2cye43F6PQ+wWTruQUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdPzZJ9mNzyGk/AG5Nk+fLPqYKUc8ad+iQsvPqktKPwNjG4qso/EW71BctPJ8l8EV3zTZtyFuRXP7b1MXx9Mr3d8N1fbrN+TDryn2DTP5FyseqiIsUsyBPzZWht39084GRa3TeFKQ9OfVhXZCEre15f7IoaGKk4zTP2B1dcmAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+h95WW0; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+h95WW0"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a1ae3091aeso55316eaf.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 11:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709755086; x=1710359886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djismc8qAVX3qv29Y50hz6u2ZcQsUvaA+/c8khDLS/A=;
        b=A+h95WW06fUvFZh21/pJz9b9jc7VuQaqVHIkvvu59kStcTl6nUJraFnG88aa66hBrs
         vbExvF1Wpvra2Pf/wFuLxjjkxrr24SPtOiyz3TIyAT87Z6f/WM159KMNzkfJaAcSKStT
         FnfIc4FO39wXd5JlxEpMhChhUEz29vTpr3HT2dVSH0FtVI6nUMocrPG41FNbql4/2krV
         YOyAwcqcacAWSCim1vqDT+Zjo4ZyVLzysWTZo4fu/HbNH/OPY/eJ7iphqbjMYsNr+jqQ
         hhaGvmJKcbERPwhup61dDkiZM9CVJMugFgYbty3pIlaBRD2ASDaCiCseMTazgZlECU1h
         BEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755086; x=1710359886;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djismc8qAVX3qv29Y50hz6u2ZcQsUvaA+/c8khDLS/A=;
        b=A4VDHyDJKJFL+biUVwfSYt9y6AeVsxHI/UxsdTP2HLsAsZtTUSMUk49jzrjeuGK6tp
         kjIMvy8RBCYpD/na19DVx8BmAcNc2/qtOdMoaZDZVQkZ0C5MxT4a640UjHYJ8woPk9xs
         Z39+RtWcnTgEiMrO5pwQbcj7XYmdN4mzSDqGVRJQxDfVDQSlw637m19jgWXj/J+2hEd6
         UN1m5YvlG+BqyAF4fBh3Kekk56nWX3BGE9ZfwlQ+MmphcglDMdYydlPleS7diB+9kbPW
         OkDd2SGG79XRv09MBNb8LjEL1QhBpUhW9JyKzG+H3lDhU8L3ZkF3jKikwhxV5e+B6bV3
         Fh9A==
X-Gm-Message-State: AOJu0Yxq35TY5DwDNK3TqZ43vZJuVMVfyTMgxSjnSMI+ykWkUsq1BzlF
	Nw0nuxrGqFMcYR1VT8vBSLhVnAYGAvMLp7y44Z+CzW1cxRrYkcONJt6V47J8
X-Google-Smtp-Source: AGHT+IGt3g748c7it6LgmOTg8dxHhz/EK+foCZPqu2ML6mgChw+Ou90BRxWXkAAL1pOAD5KDAnL87w==
X-Received: by 2002:a05:6820:296:b0:5a1:2a9f:c7a6 with SMTP id q22-20020a056820029600b005a12a9fc7a6mr5627008ood.0.1709755086375;
        Wed, 06 Mar 2024 11:58:06 -0800 (PST)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id bw10-20020a056820020a00b005a14eff813esm824839oob.7.2024.03.06.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:58:05 -0800 (PST)
Date: Wed, 6 Mar 2024 13:57:23 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] reftable/stack: register lockfiles during compaction
Message-ID: <tqr5merpvso5g7b53idhtfhy7wjipkbujxv6bmdij2absrtmmk@2lbfweqvldc4>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1709549619.git.ps@pks.im>
 <45b5c3167fbfd64d8d1e14ed55bae94cb9cba28b.1709549619.git.ps@pks.im>
 <mwhby7dxpiyrvknqe2uoli4ulygjy6hbxcxpqt3alw3dthwntr@4o24tp5jp6h7>
 <ZehauDgP4L40QKcH@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehauDgP4L40QKcH@tanuki>

On 24/03/06 12:59PM, Patrick Steinhardt wrote:

> > Something not really related to this patch, but I noticed and had a
> > question about.
> > 
> > If I'm understanding this correctly, when a newly compacted table is
> > empty, it becomes possible for a range of indexes to no longer exist 
> > within the stack. If this occurs in the middle of the stack, future
> > compaction will likely combine the tables on either side and restore the
> > missing index range. If the empty table was at the end of the stack,
> > would this effectly reset the max index to something lower for future
> > tables written to the stack? If so, could this lead to issues with
> > separate concurrent table writes?
> 
> Very good question indeed, but I think we should be fine here. This is
> mostly because concurrent writers will notice when "tables.list" has
> changed, and, if so, abort the transaction with an out-of-date error.
> 
> A few scenarios with concurrent processes, one process which compacts
> the stack (C) and one which modifies it (M):
> 
>   - M acquires the lock before C compacts: M sees the whole stack and
>     uses the latest update index to update it, resulting in a newly
>     written table. When C then locks afterwards, it may decide to
>     compact and drop some tables in the middle of the stack. This may
>     lead to a gap in update indices, but this is fine.
> 
>   - M acquires the lock while C compacts: M sees the whole stack and
>     uses the latest update index to update the stack. C then acquires
>     the lock to write the merged tables, notices that its compacted
>     tables still exist and are in the same order, and thus removes them.
>     We now have a gap in update indices, but this is totally fine.
> 
>   - M acquires the lock after C compacts: M will refresh "tables.list"
>     after it has acquired the lock itself. Thus, it won't ever see the
>     now-dropped empty table.
> 
> M cannot write its table when C has the "tables.list" lock, so this
> scenario cannot happen. In the same spirit, two Ms cannot race with each
> other either as only one can have the "tables.list" lock, and the other
> one would abort with an out-of-date error when it has subsequently
> acquired the lock and found the "tables.list" contents to have been
> updated concurrently.

Thanks Patrick for the great explanation! Digging into this a bit
further, I see that we return `REFTABLE_LOCK_ERROR` when the list file
lock already exists or has changed when attempting to add a new table to
the list. 

When performing compaction in `stack_compact_range()`, after initially
acquiring the table list lock, we also check if the stack is up-to-date
with `stack_uptodate()`. I noticed that this check is not performed
again after the table list is locked for the second time. At first I
thought this could be problematic, but I realized that this would only
be an issue for concurrent compactions and because the tables are locked
it should not matter.

-Justin
