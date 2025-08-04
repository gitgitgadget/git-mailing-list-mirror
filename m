Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBE239E92
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343854; cv=none; b=uqNlRzgGjJd2wkeF+f0XeP1phKM4MG+qp9O1NorP9Ak334cnYM/NAEgGDoIwQZHgAUpK6yPQHMJsAR5js8IAlo8AadrSTfyf/s8r3w0MFGTD7GlfzZHKKqljXF6BxuKCHguCmPK9gSXyi5b3rCH+aZz7ELCjTY1IfBXB0Ue4Zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343854; c=relaxed/simple;
	bh=Z6cy4HzDoX26i1PVfZ2y6bGKGhdw636lnXSO5wyemL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNGsoSVYJ54Wygh8oMidB421NR/WofNW04MmclZKuqbz92vWizOWUyYeSzEVV9Nq7FIAjLA2L5mMtdGWlND7aOD8fKXYI00PQlX7bwFeuzikSY+bP0kZvNIGrIYbJb1WPA/HRQsXiTYQg34h+Q0f4S66jmsGRN8Vs3iuHp35WOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WjTXECLA; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WjTXECLA"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-875dd57d63bso119100439f.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754343852; x=1754948652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGZunhW/xOG4H3a/yhQmZ9kanuTmC/D3hWj7gxZnq/s=;
        b=WjTXECLAIMvVm8+kza//+vbVA4aseILaakuUjw2WtUdV4E2CPfFwm0Dtq6Xd1BugpE
         Ums/ODZPWrKnuCwU7lTCQHqn0tR2fjVNJDQz1MFJkakYuC89h2TdYhQn1k23iGh8jznU
         LeBCMO5XifCCd8pyQmvAwZHM9LpdCptJJC8yun6uiOCCNFnzTQmtWR27LxZScEMNpEFu
         W4DMudXFTANjgvANJJB90qQiHO2OGvZyFd/vCPAToPiXEhWM/1bfrIgrVgcnkZrMwml4
         ucCmYPnAf5SdA7DOC+d3WMVHEPeWd5XEUyuAm8PMHoNQcFo9KZXbUaX9/JOI6RBCPEG5
         I9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754343852; x=1754948652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGZunhW/xOG4H3a/yhQmZ9kanuTmC/D3hWj7gxZnq/s=;
        b=G4vIZh9ylON3O06jV2jkW3HitLHOko4yV6mIztbo96yRXuYFxOSzkvQ3ZPLMJzM3l9
         PLglVgeSFOcWrZLNycwT38ikyeAmdfbsQwdUpLFXptA+Y8BRNO+ply3lHLWN3ChpcYTx
         LVy/UQKR5KA+riOOhOXHqw/qt7jDHhGBJi6M2VKdv1ijK3FTYU+D23WVYttrDNSgSb4N
         RFSrWlB8D5kCoALuUH1uu3xVC4tQVDoaxWfiFt+XYdRLNYaYTrd5tWgyT5NexEXFy7Xp
         M84SKQUrQKENNhWidSLDB03Rr/1327w4ZLtwMcoZ+G2dVs3+AbZXBh3n6d1f6Ny5RBBX
         dZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKydMSIHndM71R+tQSFNL5pyEn5SYa+aIbv7GUTpj0y8D5WrfjI1LjopM85+kDgvwGmTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2sDH7PG9sLE3hKTh95nO3IQC+NoizWZ0W/EbSzkoa7MRlXWZG
	n7RGRMbpBqi2WTo+FQGY0Ymy86/i3/3ibO7wH+z2moVxxoqGxDYep9KvEPIOvzWNMSg=
X-Gm-Gg: ASbGnctoaajqq0AEzPyJBSzflRasY3PBv5C0KW4D3RgM8zRROq36h6gTW7F1UuqHuYT
	HEm2lnEUirqwH2zlBep7AVmIXLlQPSbyNWQY7zryZZ6hm3cGEtLtPediKaBStA7WhN/yQxUGg5A
	rkOmcAG2l88dds4nvrxdo9QyrGLSIqRoB+YqJIMEPvM/1hOJs8eDpP18D3MtyigUuJSuaE5oPaZ
	E53piwzCTulA/A95HcdWwaSm3nKe1Ybids8dUH1Ifj0Ackj/e0zCx5jO4+BVIaCXMIipaqIusS3
	5D2jmfSKW4Yp7ms0WGN2K4DMH6lHPoy0EruA5Mb/xmbpmscblim+HmwAf2kH7tdIwRasHaULRKI
	E8CDJ44MF69dY+4ql5msQDPsdCDkG2v8AA4x4Lfekg+JDKpzfjd95kZvrNIx+SlkvigVGGg==
X-Google-Smtp-Source: AGHT+IFqOyxqsTAOOZTBfq3SBufsXRspcOLo4McyEP/Zw82YHqq3u74ZoL/IUtSiwPip6qZCDFV0Tg==
X-Received: by 2002:a05:6602:6008:b0:86a:441:25ca with SMTP id ca18e2360f4ac-88191d1b9f3mr207694439f.6.1754343848147;
        Mon, 04 Aug 2025 14:44:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50a6096b11asm3231888173.7.2025.08.04.14.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:44:07 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:44:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Message-ID: <aJEppnTkY+66IEza@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
 <aJB5uKFdGybf-IbN@ugly>
 <aJCW7aYqJB20LDNg@pks.im>
 <xmqq5xf35429.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xf35429.fsf@gitster.g>

On Mon, Aug 04, 2025 at 11:34:22AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Mon, Aug 04, 2025 at 11:13:28AM +0200, Oswald Buddenhagen wrote:
> >> On Mon, Aug 04, 2025 at 10:17:18AM +0200, Patrick Steinhardt wrote:
> >> > When writing a new commit graph we have a couple of counters that
> >> > provide statistics around what kind of bloom filters we have or have not
> >> > written. These counters naturally count from zero and are only ever
> >> > incremented, but they use a signed integer as type regardless.
> >> >
> >> > Refactor those fields to be of type `size_t` instead.
> >> >
> >> mind elaborating on that choice?
> >
> > We tend to use `size_t` when counting stuff.
>
> And I would have to say that it is wrong and we need to wean
> ourselves from such a superstition.  Unless you are measuring how
> big a memory block you ask from the allocator, the platform natural
> integer is often the right type to do the counting.
>
> Each of your "stuff" may weigh N megabytes in core, and if you have
> M of them, you may have to ask (N*2**20)*M bytes of memory from the
> allocator.  Your (N*2**20)*M must fit size_t _and_ you must compute
> it without overflowing or wrapping around.
>
> None of the above mean you have to express N in size_t, though.
> And more importantly, nobody gives you any extra guarantee that you
> would compute the result correctly if you used size_t.  You can write
> the right code with platform natural integer, and you have to take
> the same care (e.g. by using st_mult()) to catch integer overflows
> even if you used size_t.

Agreed. I think it makes sense to use size_t to keep track of, say, the
length and allocated size of a buffer, but when it comes to "counting"
something that isn't directly related to memory allocation or pointer
arithmetic, size_t is usually not the right choice.

For instance, the MIDX code counts the number of objects and packs in a
given MIDX (and likewise for its base MIDX(s)), but those are all
uint32_t. You could make the case to say that, "well, they are encoded
in the file format as 4-byte unsigned values, so we should treat them
the same way in memory at read-time", and I think that's reasonable. In
that instance, using "int" would be the wrong choice, since I have
definitely seen repositories that have in excess of 2^32-1 objects.
But there is no reason that we shouldn't use size_t to make that count.

> > ... Regarding the data size I
> > don't really think that matters much. It's not like we have hundreds of
> > thousands of commit graphs in-memory at any point in time.
>
> Aren't you saying that a platform natural integer is a much better
> fit?
>
> As to signedness, it sometimes is better for a struct member that is
> used to record the number of "stuff" you have to be a signed integer
> that is initialized to -1 to signal "we haven't counted so we do not
> yet know how many there are".  So
>
>     These counters naturally count from zero and are only ever
>     incremented.
>
> is not always a valid excuse to insist that such a variable must be
> unsigned.

I wrote these counters in 312cff5207 (bloom: split 'get_bloom_filter()'
in two, 2020-09-16) and 59f0d5073f (bloom: encode out-of-bounds filters
as non-empty, 2020-09-17), and I don't see a compelling reason that
these should be unsigned.

It's true that we don't have any need for negative values here since we
are counting from zero, but I don't think that alone justifies changing
the signed-ness here.

Is there a reason beyond "these are always non-negative" that changing
the signed-ness is warranted? If so, let's discuss that and make sure
that it is documented in the commit message. If not, I think we could
drop this patch (and optionally the patch before it as well).

Thanks,
Taylor
