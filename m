Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C14276D03
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698605; cv=none; b=Bt4Map5XmztFsXJmeWGq97PoK7bvq0Vn44+J8ymn8MyGOWQ4j7F4VcecaGO9K8Nd2WBQnQL1xRtwggqHTyFhQ4GQ0RAQW8IJsWKzFsvPtw5563dhRiZbNkumKkdgEm06TMAoc37XTaJ431EApElXLhVeQCxz9ZOxfwvd1eegAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698605; c=relaxed/simple;
	bh=bTz/oY4GEIEMkjpzD64usC0yWHk/+AmqTk+TNThVWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osJN4O0OvZD2EWHEZ0fBhL+wsCPwzZu64Z0ecZnGrvQqNh5kFDP7fRCZEjEiwmNwZBKQRpKgL3bYkdeJpqFg8SvhhbEmc5Ngn1ILgpL1uPWX73Fg08ghm3m82xNCXjkKjZN82ZmtxcaohwwtRwdFL1EGa3eOqRxVPFG3OVGxHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mXv6g6rG; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mXv6g6rG"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so1171041276.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740698602; x=1741303402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+X/3VmEOgmL9iwu0YKeHNg45pIYcVbRFN0MPPnVT7ls=;
        b=mXv6g6rGDzKRMyARBpWB3+0O+IQMCZ18Bl2VAgc42zJOHqgY2J8oV2Bu2yGPKRjWt2
         MIqPExiEqNzTxqSdxEhWP7U4cXeWQylXPY4hCnAGeL/5BVNmQ32nlRc2gz4kv0+JDe5A
         h0GYTXqh2Eg8Hg+8J3Y7hjv0J0XN2HETspO6hY2d/IHIfF7wIgojNlEUzzUxZ1cdvNVY
         l5XoL26Va7rgEuiitge+xxt0ucF8QI9pIdj99EllBCuKMR3lcNwLGUJ+xfHr3JCMipJ2
         7nnnnzwMuieNiw+D6oKgWLkY0ZvP1eHIeN8TGnjFBnOI/mdsIJwlvt1CKTUrMDUZJ5zv
         XsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698602; x=1741303402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X/3VmEOgmL9iwu0YKeHNg45pIYcVbRFN0MPPnVT7ls=;
        b=PNmwD7QQNLwxewsJZLP82pQfYTfACfuDJzPVoxY5Yq1HYBSc/F+huNB+JYNiOV5GM6
         WXR7Vj6GqEq9FyAK5bb+2k7sIQ9KemH6ujvd2FTMs5d1KVVJ8yGAz523ylEpHxJHDeAJ
         eH/Uy7OafgAXctGWOqU/FyGfsYST7UyEMkCdqq0jIsFHljtyQjf5G9z9oOmkYFqTc1o+
         JggjrgIITC1RK5J9k6VQj4l8XJHpnA259iako5cYiOGl+B1b1WIPZzWee3jFOqt9Wr2A
         fA/NsEusHqCtzPlcGNko3EqkxuCDgT25C+QoopbEspaxGOTyX4zllPjyYKTl/rUEwMUp
         kvjA==
X-Forwarded-Encrypted: i=1; AJvYcCWJY6S5zAqNgENenb42LUXcK2kjjjleNuen8w6EnKZryLToKUp9oIox/q/WCJ1CtXOMx0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnnWPdrEB70fYYHVgJ1H/UcXLRAcwlTlr8htCWF6E4d1JdyOF
	d+eA/wcnsF1sum/0H6BT/UCPxeyfkS7sS9z8h2sRRcJ3+rYjbRbQ3oYNaLSvwEw=
X-Gm-Gg: ASbGncu8xz6J8XoGwsEmiF3uv5LuBmVlTMjNwdHogQl+pUjuECxNUfbqNZkKZ45UU1c
	tvi9YNFpvl2pN5U4BuRCWde5crc7us89vbRyU8C3TCo/MgI9rBLUH11W+OdODgHf8vpgNqs2zcR
	HBiDw1mk1FoD08BpZTYSHiqQeCIfGAOpXsVW3YACGBoGdKMmKcRtCTucicMbTcPaA5seCyPoCMw
	bTflDgUnLP88Tda4uctxIRd1qKygAZy5CSoAADRtmTdl2z64EGUOIU4TK+T1G0BnzDxbB4DmCEB
	caMLDPnvbcg/zopltbe7LyGkpyPvHtYwQQtlk9W9hM131f3FOZcO1SyJn1RabWIxJkEIcRRlcg=
	=
X-Google-Smtp-Source: AGHT+IE95cN+63o4FhSFA+G2E2018zpSuq/EzDHjtU8nk2d3Sj+iOQF6BeCplT8GoDFyefa/O8yU/Q==
X-Received: by 2002:a05:690c:67c3:b0:6ef:6536:bb6f with SMTP id 00721157ae682-6fd4a03ef13mr20169437b3.22.1740698602082;
        Thu, 27 Feb 2025 15:23:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca6a886sm4973757b3.64.2025.02.27.15.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:23:21 -0800 (PST)
Date: Thu, 27 Feb 2025 18:23:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 6/9] pack-bitmap: expose function to iterate over
 bitmapped objects
Message-ID: <Z8Dz6EkIpr/g3vuY@nand.local>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
 <xmqqseo35ic8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqseo35ic8.fsf@gitster.g>

On Mon, Feb 24, 2025 at 10:05:27AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Expose a function that allows the caller to iterate over all bitmapped
> > objects of a specific type. This mechanism allows us to use the object
> > type-specific bitmaps to enumerate all objects of that type without
> > having to scan through a complete packfile.
> >
> > This functionality will be used in a subsequent commit.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/pack-objects.c |  3 ++-
> >  builtin/rev-list.c     |  3 ++-
> >  pack-bitmap.c          | 65 +++++++++++++++++++++++++++++++-------------------
> >  pack-bitmap.h          | 12 +++++++++-
> >  reachable.c            |  3 ++-
> >  5 files changed, 57 insertions(+), 29 deletions(-)
>
> After 2189649b (pack-bitmap.c: keep track of each layer's type
> bitmaps, 2024-11-19) added <type>_all bitmaps to the bitmap_index
> struct, this step would need some adjustment, I am afraid.
>
> Taylor Cc'ed.

Thanks, I was going to respond with the same thing.

I was going to suggest leaving that function as-is to prevent future
breakage and/or a messy integration into 'seen'. But stepping back I am
not sure I understand the purpose of this commit in the first place.

It looks like the aim here is to introduce a function which executes a
callback for each object of some type in a bitmap. That's a thin wrapper
over the ewah_iterator, but it's not clear why we need a wrapper around
that function since it is internal to pack-bitmap.c. Likewise, this is a
performance critical area, so I am not sure I'm in favor of adding a
function pointer to a hot path which executes once per object for some
object type.

Thanks,
Taylor
