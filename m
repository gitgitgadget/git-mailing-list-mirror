Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8F2576F
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017529; cv=none; b=ZNYq/hP3rgJspeOQ3ga0akyGnOaJ6L/QxM08wbP3YxNk+rHhb4PhYBBHMYlXEJLLUERxGuNUdj9sovTerqF0yFfhP/8dVK1dVloX7DjfeLwgd8v6I8A81win/X1uyf7rPl1zcGFLtm2LI+Oj0JE83ZGZTmZNFBFDknYIkCQzzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017529; c=relaxed/simple;
	bh=FszjKBRWUXxaDkIYsovQPN6TZu9e5NN7Apv5AF5T4J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F035u7OSEFnwqOZFLC0TeN/TW8vrbKb48iGGESGTNRgtUZ2fJOOjbQvNHermitE67WknkID1DOHUxv4Nw7xav5yaylBmamqUkX8vStVw+TORArnkt2x8g/PGgnr5bbeIe0K8WSjT1GAWRaUOTJx+6bdhULHrnT3p841qiN453FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeASjDXd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeASjDXd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso2559096b3a.3
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727017528; x=1727622328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCHQuTHv7nwg4vebQh9ace+FIni1ySnd8LUrWoPXHXg=;
        b=CeASjDXdZkalZgVBab2OAQNiVVmyj85lEBXEqO95hufM9vioEJHNG22Dbx3rcUN4Yw
         MpJBZZrfDpH4Rawturi/bvjqDOCEgCMhi2n3kmR7zwcn7FJFw7Ibh1jVyI3hy//pQ9xx
         GcpcjHGY76hJtkiO8+tPrPzJEwKg9Ngcn4cgdklwZCsbCf/fIhyQLO9Bt+N31u7mfYPE
         2Mv9M3eYndiibXTntXL1jLI/PnTfUSRgwvNdtMIfVNan9xYMeBQKBuQ96l8zNlU0IdwE
         M5f+dKi+J+MaR+kdofib7wGmIac+wUfYvBK1Qg1GZ/UaYoJhj8HLxQcBYDaIyoycNXpO
         1c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727017528; x=1727622328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCHQuTHv7nwg4vebQh9ace+FIni1ySnd8LUrWoPXHXg=;
        b=oChr5zhwHDqFr6Gr3kv3ZZ+ElcZ5kwjEpjsJ+w1U3LiCdYnr/eaOdlY9yfRD1ISoeH
         RJ0GtdOUxUuYyZiX1+cgE+uTKZ8vq9gjDJc8LzaywmB/NicsAEt1BX1BqnKEC6Z87smh
         HcVDKA9Ivt7cqPKzTL1G93r0GGqkF8/HU3VBJioJYojiphT68fXXEkpXqsARaSYH4FZI
         qCZsBYsHMcuyzOXsdAS/IU4GA2SX+kr92mwv1+dIQn3H4r01wDbBRZA3/QSKe9lwWzIF
         x+6uhwuYO6W44jqk0yPujjLPVa8wvOUB5WeL+GdbZWsC3UrtrCjIN83ZM0w39BDJ84Jo
         3MrA==
X-Gm-Message-State: AOJu0YwLZJjrMbmj1nq28HuOTEZXBm8QJzMADliP3KVJ10PqrElpHs+O
	nElpQd27omvIBnoavf1gy2PsYfDAHLLuauSJdfwwdpVHMKRFa+IE
X-Google-Smtp-Source: AGHT+IEPNclMf4Uo2J+hGj4S/rnqLYqJWJYrB9eDOB59Djn/wSw6rmTi1oWFAfev9hpzvZuUaSZZKA==
X-Received: by 2002:a05:6a00:218d:b0:717:839c:6838 with SMTP id d2e1a72fcca58-7199c9c0ca1mr12697660b3a.14.1727017527537;
        Sun, 22 Sep 2024 08:05:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab535csm12529502b3a.58.2024.09.22.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:05:27 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:06:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 3/5] ref: add more strict checks for regular refs
Message-ID: <ZvAyf8Uy6R33mUda@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
 <ZuRzxyjAI3tp4uLK@ArchLinux>
 <xmqqr09gbvku.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr09gbvku.fsf@gitster.g>

On Wed, Sep 18, 2024 at 12:39:13PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > +`refMissingNewline`::
> > +	(INFO) A ref does not end with newline. This will be
> > +	considered an error in the future.
> 
> It is ONLY files backend's loose-ref representation to store the
> object name that is the value of the ref as hexadecimal text
> terminated with a newline.  With packed backend, even if the file
> ends with an incomplete line, it would be confusing to say that such
> lack of terminating LF is associated with a particular ref.  With
> reftable backend, the object name may not even be hexadecimal but
> binary without any terminating LF.
> 
> At least you should say "A loose ref file that does not end with...",
> because a ref NEVER ends or contains newline, and what you are
> expecting to be terminated with LF is not even a ref, but the value
> of it.
> 

Thanks, I will improve this in the next version.

> Also, isn't it too strong to say "will be" without giving any
> further information, like:
> 
>     As valid implementations of Git never created such a loose ref
>     file, it may become an error in the future.  Report to the
>     git@vger.kernel.org mailing list if you see this error, as we
>     need to know what tools created such a file.
> 
> or something?
> 

This is nice. I know the intention here.

> > +		if (!*trailing) {
> > +			ret = fsck_report_ref(o, &report,
> > +					      FSCK_MSG_REF_MISSING_NEWLINE,
> > +					      "missing newline");
> > +			goto cleanup;
> > +		}
> > +
> > +		if (*trailing != '\n' || *(trailing + 1)) {
> > +			ret = fsck_report_ref(o, &report,
> > +					      FSCK_MSG_TRAILING_REF_CONTENT,
> > +					      "trailing garbage in ref");
> > +			goto cleanup;
> > +		}
> 
> Not limited to this patch, but isn't fsck_report_ref() misdesigned,
> or is it just they are used poorly in these patches?  In these two
> callsites, the message string parameter does not give any more
> information than what the FSCK_MSG_* enum gives.
> 
> In fact, MSG_REF_MISSING_NEWLINE at least says that the complaint is
> about refs, but "missing newline" does not even say from what the
> newline is missing.  For TRAILING_REF_CONTENT, people may expect to
> see what garbage follows the expected contents, but that information
> (i.e. contents of *trailing) is lost here.

I agree with you here, I use way too general words to describe what
happens. I will improve this. Actually, I feel hard to find words for
"MSG_REF_MISSING_NEWLINE". I think we should say:

	LF should be at the end of the file.

Thanks,
Jialuo
