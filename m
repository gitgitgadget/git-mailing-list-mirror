Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE33314DD
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055567; cv=none; b=GMGbAfdN8pFJUF4Ya8JQSZRwNqfOzmpxQfeFhm6kTbGhuRBiCjTj+P32b5JD9+q4hEid5pp+mGVVCpz0RLYSmvqYqrKMsJx/Ku/A1ZnBgbIqMXQFrknZiLnnjDNfLXZzqR9iqecY6pmFoPKEzw2/wkb5Ln5lDVKVdu1Gm7rA3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055567; c=relaxed/simple;
	bh=qiBrLbtgoSkowqbZ5hJ3u6RMCycRhb9QgVuBB9Gxjlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlIM1iKRNHdTgBOCsANl9oDEPz3X/bUad5iGi4ipI4Xz4cG62pKNLHTziShJOavl58KzBccB8G4ylQqtZ6SV86UcFTx6mGAlXv2wY3xGPpIWSUbygaOGK08psTj87Z9DlbRzf2TyFznThtlJMaZmWIhc7UCLeWCyVaB3/uS+q60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZNvUj+H; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZNvUj+H"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso424112a12.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766055565; x=1766660365; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4uugrKyjW5MgZj/7j0aTYmwsn6frXRLxYIXvgu6FRLc=;
        b=jZNvUj+HmfzCpkXw7+9/+NsZJxLHjGy3ItfDLfPtWuCau2YScsxM4TY1D1YEaJi/zr
         uuKj1lyTG+26KmotkFD1BrBI9NhusfAwR4Nnv2QUEdiBKSx6/HQOvb1VAoTUTGkf3SBy
         HDLr93+n0150NCXvd4/CbuTBn93NjJoopP0Aq7qjzbq4dRgsJeapmQ259++1kSKXZcsi
         kFH+MSehCdJ5Rm3vKSpCDP0smapCNrnLHSA/xwTW82NoxO9ZfKIfQkU8J14pwRHOag+g
         gRsZc9ZbjEzApwqQLRDwpwbZI7D+/QZhxnn/A8S2946BUWcELdyExvUpCE5Eg5brNCpN
         IVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766055565; x=1766660365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uugrKyjW5MgZj/7j0aTYmwsn6frXRLxYIXvgu6FRLc=;
        b=Exgs1NEFnvwl1on+wjw4/T+mr6//BDJ8xXsK5XoAi6JBkoDcvdLRNBpcyfXwS1KCVo
         sIcOrMPIkxGUVYYR/ydfXBfMeE8TIo75owL4nlFumj9Ru6pQ6suQh4wh0ZfBgdzK6TYi
         SgvEZ1RbjeQRxYJn/+Seo9I9KVFFwVPtlDOt9crDcPQHN/b0fNc6k+LACeorLduisLKy
         KmKUztV40A5m3q9tbARW2qsgo39z2Z7iJygL5FDxEHJABMDtKtM315Mis2gX4QOKP9p8
         nYZCFEJyyvu5ljzvm1QrFvFOPGs9XVqnnJ69DfMopa8wDONRLoxZ4BPVzHDyucVQ9Bj6
         dgyg==
X-Forwarded-Encrypted: i=1; AJvYcCWNzp+cGd/t+Nv71tA05dxSYd8ZFtVokmdIdvdfAtIDqyRJHEw0qYwvoQY3kDyA/vGqSRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+/MdkAerRqw6lpJWcHN22ToNj0/9/xgvnIsteADQygovnAU1
	MMVb5fkWoGpxFIxqWRHmxe8JisDmGNdVvkcoNPc1fTT4Q221Bk16giqH
X-Gm-Gg: AY/fxX7V57yRHGcaMF+xfafqrV6qME3IOxP5cf+/LiyK2fwoxg7ibY/jUbSqNeEdLzs
	yLa+yhfA9Jx3BRpGx4QxyvBvJmOgM2jk8UvAy4oNXGJ6TKQOpFV3xtlOVzphxClheqZK4/7xAeK
	fbiXtqZVlAWdvDFnzCgfsrudw7gybex5/+qXXcoMneGAQPPcDCPtlx8/Wv8FwDjRlUBQB6+ioh8
	6VClExcREX2M/jzm9XF8QXMeVI+MyMaM0BWUZm94DnpqhiEqw2/WyV7W4cUuZaI9dQcA7tlceJr
	QpLCFSuOGk/z7lYS0fhI+YYVolWvwKV9MjBE6C5MrwgjWRM3rOUXlupgnjtUWr+YXr27BXwXeMQ
	AURsf9WOiKpqpR87py1pykFRnXPSnVrOhvB/35nxWnOdaShslIkbu4zqCAcUBdGmKxNhQcNMUTg
	PyJFGVTRjuohEEdL4YgufN1EuJLJF+hJ0B0Ihwk5Qr8QLDSaIdRG50EqV4FsJLJLOcNC7KWb30R
	jN4vC1CuAcvmaW4jZ49WVPX8GJ0ItZjlF465+8=
X-Google-Smtp-Source: AGHT+IGm+I/xq1mFM2YN/0cgPwyT6yPfoh5OOT8rBWwQq2TtVzWEaB7Of3ryM99SsjQXKdTx3+GkFg==
X-Received: by 2002:a05:7300:80c5:b0:2ae:6118:dbce with SMTP id 5a478bee46e88-2ae6118e072mr3241987eec.10.1766055565133;
        Thu, 18 Dec 2025 02:59:25 -0800 (PST)
Received: from Carlos-MacBook-Air.local ([2601:640:8e80:3680:94bc:9b4c:461e:f38d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b04e58d423sm3349500eec.6.2025.12.18.02.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 02:59:24 -0800 (PST)
Date: Thu, 18 Dec 2025 02:59:23 -0800
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Aaron Plattner <aplattner@nvidia.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] odb: do not use "blank" substitute for NULL
Message-ID: <aUPbgCSTgWJAe0wu@Carlos-MacBook-Air.local>
References: <xmqqpl8cxy0j.fsf@gitster.g>
 <a31e054e-0eb2-48b9-a802-3592a737d1e3@nvidia.com>
 <0e860421-8f8c-4bf9-8ad8-82fe269a7a9d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e860421-8f8c-4bf9-8ad8-82fe269a7a9d@app.fastmail.com>

On Thu, Dec 18, 2025 at 09:02:59AM -0800, Kristoffer Haugsbakk wrote:
> On Thu, Dec 18, 2025, at 05:51, Aaron Plattner wrote:
> >>[snip]
> >> By explicitly handling NULL input, we no longer have to worry about
> >> it.
> >
> > This reasoning makes sense to me.
> >
> > Would it make sense to add a
> >
> > Fixes: 385e18810f10 ("packfile: introduce function to read object info
> > from a store")
> >
> > line?
> 
> This project typically does not use that trailer/tag.

While factually correct, I think the "why" is more interesting in this case.
anf the answer IMHO is: not, because it is not needed.

% git describe 385e18810f10 
v2.52.0-25-g385e18810f

shows that this bug is only present after 2.52.0 was released so unless you
are using unreleased version of git (ex: some development version, including
ones that are based on "next"), there is no need to "backport" this fix, as
the next version you will use will include it.

Carlo


 Only trailers that
> attribute people are recommended. There are exceptions, like some
> recent usages of
> 
>     Best-viewed-with: <option to git-log(1)/git-show(1)>
> 
> If a commit fixes some other commit it might be referenced somewhere in
> the message text.
> 
> Commits are referenced with:[1]
> 
>      git show -s --pretty=reference <commit>
> 
> The maintainer uses `--abbrev=8` (simplified):[2]
> 
>     git show --date=short -s --abbrev=8 --pretty='format:%h (%s, %ad)' "$1"
> 
> † 1: Documentation/SubmittingPatches
> [2]: https://lore.kernel.org/git/xmqq34j5h7v9.fsf@gitster.g/
> 
> >[snip]
