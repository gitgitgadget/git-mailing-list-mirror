Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67A433AC
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268115; cv=none; b=cygQTOiO8l8CJHpMPsOC5GmhgvfNJtfh1e3JC4QMeld1IRr6INUp4iwNMLSpzX2hMTxwKhFcqKYvXaQKlXyeuVIxbtHY6KAFUJntwVH3LNJwPhqhbZLczvnkuazBB/+4dI87dkC8zBR08xyEh31hEFTU7O/JBcuGcKUUHifUe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268115; c=relaxed/simple;
	bh=z3U9mBBaV2PBgeoNYidjHDx4DN3fFPYGNBziWZpEOBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9QfvPQjYEHMgamLe5kWkvZuyIYXryiAP49+a/qRlg3XT1oUBq3eIo0GUQIs2TXowKlAba0lFwo7HJb+5iF2fDgGFsUexf86Ang0tnEa4Piy6j2zjiRUA1W/yLRSC3c0g5A8dTN4o+bnCZKLrsRcFCiUTAzp38AKmI+blDZIsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPqUZltc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPqUZltc"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742af84818cso1336998b3a.1
        for <git@vger.kernel.org>; Mon, 26 May 2025 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748268114; x=1748872914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3DVayddKESmzGGtRIb8oNnXhCqPed0dGJpIjDs5Mk0=;
        b=GPqUZltceXif8Oj7dNeHmPcvRo7wabTciMG3sX825KzZi/9RMf5oQ3C5Yc6AqxWz/k
         Sv7v8jWj2biSbTkW7D8WJOVqf6uuDvH8+OJ/UXHN3vkLphI3EeWSFjWU0AoGKPfZnEtb
         DNIjNo/YRJKrS76GvVkm5VD+SQfMzFrhirWxadUdO5hd9GEvBwihPO9IpETBbm+hWVDz
         4M4aiC+H7dK7iMH9yeA8BVO05eu2898URzImgurDQuMGToEqPC+VOvL5pq0B5OWxMl7j
         Izq/AuxQ8jI514JtL2KHEPfEZt0DqO9ZyThyBWxlmR0lqeR7xsg/E6a0u2cmVXNTM9db
         NQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748268114; x=1748872914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3DVayddKESmzGGtRIb8oNnXhCqPed0dGJpIjDs5Mk0=;
        b=AmSlDGjiCm3nOZWe9IdZ58acGgGn8arU9eR4R1j1J7yeUD2V434np/GhfAQC3NwQML
         x+QdoDltG9ER0CETnjyX7f03FcUmv+dng9+3pBKpP6PZX5YE9kD1noG6lvqPCmberTcZ
         DjWzOehp9vdL7GsbZXkMgULjHNmPbzTxsopCEZ6fEF6RpHKkNXCzBpIn9hJFATNMa+QO
         KbL52H81gMSgbSURRAszfWB8UXDkwzsxCC4Lf1HhDKgWzB5K/bigYrF1ZosN6T5hKgyL
         mzknPG0Q9c70V7GRHS7s1UehXniUEz9raajpwe1ERDaphh27lrzFynxsdrB1i0JhF1Pw
         pvXA==
X-Gm-Message-State: AOJu0YyiRrK2lD7dYqbDcG7t8JnkUifkOHZj1J0D56R8MC/9/WWFfUv5
	RcDQY2rw+11bsNwBMgV+M+RnM6XncWLiSLTwj7m0HTEJeUcz2uojDsnw
X-Gm-Gg: ASbGncsU+SUS0fPkamNGdhO+agiyQ7cpKsSxYlYpNClI4Gr4fr9nOx+svNS9Y7cyonX
	n4J07/2INAJPvBc2iyxJzwH9DVXB7sT1NcPEbMwALjSw3TCXXYHALGTpmAWyfOqXwwbwFX6rbZo
	c6t7/+ps1spNSdQ8iNcePOW6yMVwmYkg1FHq9y0Qx624quAD1c2eaz/sOmkI+nYXBckgVpdls7w
	9v/NDz2q4KYpE0QyyNP9ry/FFsBGEUQdv33iL2atuC2VkbdYzbtrTcQTBoiCQ5sBpYMNeHnWwtS
	56wJNsZbm2ImavC99QLPjJeOET8/mVOP8jhsvoFA6yRxcak=
X-Google-Smtp-Source: AGHT+IGc9//tMTyaKx8W4i7+IDrZgeCqkd2QuC25YhBOCLXNSgZkvrSEJ+kMKbUl80PTcK7g7m5kQg==
X-Received: by 2002:a05:6a20:4393:b0:1f5:6d00:ba05 with SMTP id adf61e73a8af0-2188c3c6d1amr13258001637.38.1748268113233;
        Mon, 26 May 2025 07:01:53 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74615cac674sm1400326b3a.153.2025.05.26.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:01:52 -0700 (PDT)
Date: Mon, 26 May 2025 22:01:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/8] string-list: remove unused "insert_at" parameter
 from add_entry
Message-ID: <aDR0VS_4n8Io0QYp@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDU46MmoGPB60b@ArchLinux>
 <20250519075119.GE102701@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519075119.GE102701@coredump.intra.peff.net>

On Mon, May 19, 2025 at 03:51:19AM -0400, Jeff King wrote:
> On Sun, May 18, 2025 at 11:57:07PM +0800, shejialuo wrote:
> 
> > In "add_entry", we accept "insert_at" parameter which must be either -1
> > (auto) or between 0 and `list->nr` inclusive. Any other value is
> > invalid. When caller specify any invalid "insert_at" value, we won't
> > check the range and move the element, which would definitely cause the
> > trouble.
> > 
> > However, we only use "add_entry" in "string_list_insert" function and we
> > always pass the "-1" for "insert_at" parameter. So, we never use this
> > parameter to insert element in a user specified position. Let's delete
> > this parameter. If there is any requirement later, we need to use a
> > better way to do this.
> 
> We can see from looking at the code that removing this will not change
> the behavior. But that always makes me wonder why it was there in the
> first place, and whether we might ever want it.
> 

Yes, I agree. Actually, in my first implementation, I didn't realise
that this is redundant. However, when inspecting the code carefully, I
find out this is useless.

> The answer in this case is that we used to have another function,
> string_list_insert_at_index(), which used the extra insert_at parameter.
> The idea being that you could call string_list_find_insert_index(),
> decide whether there was something already there, and then insert
> without repeating the binary search.
> 
> But you can see in callers like 63226218ba (mailmap: use higher level
> string list functions, 2014-11-24) that this was not really that useful
> (in that commit we just try to insert and check the util pointer to see
> if we need to add the auxiliary structure).
> 
> So the function went away in f8c4ab611a (string_list: remove
> string_list_insert_at_index() from its API, 2014-11-24), and I suspect
> we won't need it again. (Also, I think these days we'd probably use a
> strmap instead anyway).
> 

Thanks for the hint. By seeing this commit, I totally understand the
history. Because we delete `string_list_insert_at_index`, we simply call
"add_entry" by specifying "auto" mode and somehow we don't delete the
legacy check in "add_entry".

But I have one question: should I include the information in the commit
message? I feel doing this would be chaty. But I somehow think we should
do this.

Thanks,
Jialuo
