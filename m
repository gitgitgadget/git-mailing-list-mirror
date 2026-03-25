Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8A25A359
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474388; cv=none; b=ZCScdyKGN+KQ1yw/FBbR3ZaagFCb19xbdR/o9hCqCLkEyK3noVWEd2QGE676aZcDVSfP9Z7MQGUKK8L+UPZkpb1xXp+G8qus/EoEL462dHW4yrAPJKJjci3YIKIi29lNGQK2yHXbMRP1YrFlA78QmQLnQp0mmxXCw2l/A3LXZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474388; c=relaxed/simple;
	bh=jgEIpgd53rYyRf8RVNJJQTsMw7eWYPS7VAu0ySHfagY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2BtPNIaeogKIcLtpZMJ6Ei78qhZkIV9FO2bj9fHVh3NbT2bNUGW6ARh4fgVYG973Y439CucL0jLqolr8bGRZx0K8O5TqMmTLiYH4IvEMnZ7u4HAgPWF1ij01qZpGctlBKhVZQPfsW7QQab7pbSd4J15SrCYKJdIyjSjRm+LLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBiTVceV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBiTVceV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48374014a77so3772255e9.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774474385; x=1775079185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bvJkZvGb9ueZ9NIVunsHBRGlBQp2sUKltCmGstrBvA=;
        b=kBiTVceVpIH4YBTLFzzuc542v085jCADFMdU0jbscv7sAxNB1Z2Hx+0IJn/CY9y7+F
         mNHOqc5MAMhwxKWdE+6Xg5ifIGnXn4Wh66+MWH0BntHOdb494V0+f8paVSzNe387YRpG
         AB4RXAK2/78Y9ey2yWTGhKhG+GI2dErbhWAbTXJWbQ4ddAxCkvWNU57b8X4IGJK2BICl
         YhuUKklqCKNt0Yv5VW0k7tD494Jz42vL0KMuuN7kmfQxV2QyzrztzBjYIJzJ8otz0ofu
         zk9r0KMzIAYrvE6gHObV92bXWMKckEKYW6sbSvqr4oVXU0BWi6UKYbIxbYAzHYiTHSe3
         iVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774474385; x=1775079185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bvJkZvGb9ueZ9NIVunsHBRGlBQp2sUKltCmGstrBvA=;
        b=htOGU7FDldwcU+S5ggX9KZmYqO0MypjdZ3gPwWDxOVSJZ552A9nYY9UmwIy6N0pKtr
         6ftRSAOnvHhpze8dcM3uXgiw7e21640T1XbSjsGEgJR6xwGnoT3/E2YYqH1/3eVPPvsc
         unfs6uuRCTk1r402u02PR5Av3P/UlTY938x17gXEFhvumxP0uwH7S/2zU7KRmwqzlISo
         C1SJDA5LzKsA40g9Xl1dGuz1WXAWJmOwvxK+3dfLUfxt+ygfV5OG6s2T5FgqbkmG8gjl
         Yr3MTDiKUF3pbUiZg1ltUbLxuSvCmfcyKsGpLfH8XLpDKS3y+u6Wye0wzxFW9Crdruj9
         9AIg==
X-Gm-Message-State: AOJu0YwraW3aDkQ2icMo+0ctbjWNnaJe/+eigk2LJYXdIHVY55CvCXyP
	+5TWfyWl7+w/ZRoFsYXK2w+Jwb1rqeHD2Nv4C65xw6K9kp3L+Jc42Sr8
X-Gm-Gg: ATEYQzxqecGCFT28/o387SabBv1Mq+sAnJO4ih9kYLAMbM/TEovCl8zB04qyqQnKmul
	NjMoFb6oH00roJv4wDHgRJqGCwrmUF1nZ64JEPV0KPKnn74NWbOZAbYa9l5zteu59bb+XdISo2V
	4tdfZQWjBRITsNKOMmJHkiVIkQp4cuEFZJcWF8iGGpXMHpszr27MRdfl5hddrgjDT0NTjIk8eQc
	53Kx+N4fZUcsZl/8+vbSQkR8+GatfBW4Wzat983BubLC73XAuJQrjqACosWW5pMCYw2Pt6DnZ8D
	bkF9vPlyXv6GSYdcTPh6u5XXeK3/aXfY6Kwsvke+zXF53NPadbUrPs5DmCcya4rh5+UdzM1B1Wt
	OOd2zTHJbjpKxmfDC73Iai+XliWj9LWzkV+AGCKyq7yOFYTUZ2Dh/JCMguLrf1LCUXlwQsT4iRv
	ZAu/75Birfg/bMyp56sJMwdliTasPiIwkA
X-Received: by 2002:a05:600c:8489:b0:485:ae14:8173 with SMTP id 5b1f17b1804b1-48715fc3532mr74557575e9.1.1774474384785;
        Wed, 25 Mar 2026 14:33:04 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720926246sm348045e9.26.2026.03.25.14.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:33:03 -0700 (PDT)
Date: Wed, 25 Mar 2026 22:33:00 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v2 1/4] pack-write: add explanation to promisor file
 content
Message-ID: <acRUjAG7QOD5kVMI@lorenzo-VM>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <fec0c24897092d19a718563ca4ef6e509ab104e6.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <xmqqmrzy45m4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrzy45m4.fsf@gitster.g>

On Mon, Mar 23, 2026 at 02:07:31PM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > In the entire codebase there is no explanation as to why the ".promisor"
> > files may contain the ref names (and their associated hashes) that were
> > fetched at the time the corresponding packfile was downloaded.
> >
> > Add comment explaining that these pieces of information are used only for
> > debugging reasons, and how they can be used while debugging.
> >
> > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> 
> A natural question any reader of the above (and below) would be
> asking is: Who told you that these are only to aid debugging?
> 
> Please refer to the commit that brought in the reasoning behind the
> comment to make it more convincing.  
> 
> Something like this replacing the second paragraph,
> 
>     As explained in the log message of the commit 5374a290
>     (fetch-pack: write fetched refs to .promisor, 2019-10-14), where
>     this loop originally came from, these ref values are not
>     actually used for anything in the production, but are solely
>     there to help debugging.  Explain it in a new comment.
> 
> perhaps?

Makes perfect sense. I should have done this from the start. Thanks for
pointing that out.

> > +	/*
> > +	* Write in the .promisor file the ref names and associated hashes,
> > +	* obtained by fetch-pack, at the point of generation of the
> > +	* corresponding packfile. These pieces of info are only used to make
> > +	* it easier to debug issues with partial clones, as we can identify
> > +	* what refs (and their associated hashes) were fetched at the time
> > +	* the packfile was downloaded, and if necessary, compare those hashes
> > +	* against what the promisor remote reports now.
> > +	*/
> 
> I do not want to sound too pedantic, but we align '*' asterisks in
> our multi-line comments, assuming tabwidth=8 and monospace:
> 
> 	/*
> 	 * Write in the .promisor ...
> 	...
> 	 * against what the promisor remote reports now.
> 	 */
> 
> Your second and subsequent lines lack a single whitespace after the
> leading tab used for indent.

You are not too pedantic! Ack.

> >  	for (i = 0; i < nr_sought; i++)
> >  		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
> >  			sought[i]->name);
