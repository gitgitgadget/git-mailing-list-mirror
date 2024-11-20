Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E441BC097
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141414; cv=none; b=CVsv5B/WN8Etv/uMORMqdLG6rdqio/f/qPg8U6mWizqYD2TUi9fPEhQPRWKdWBRGsuuLFydqBa/+8xiJyyIBXwGxDfvl/NaiS/wJ3B4Bz7MFwZsHREb/Dfp0Sj6HOzAkLlmX5Dm0M8GdoSpWBAC556cUve7p2wNv16fVBmCQSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141414; c=relaxed/simple;
	bh=k86Hl7a4XzlV8EfWKl9P/f9Nsx8qGpKvGwcdHE/wYo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djHaHQm0Rls8QUX0rd+kO7vPwJmwau/E+IqzOqrSl4beO4djs5Z5nOQZnV34CHruWR8j3ro/fVqfKSBU3qpQRbLaFC2Dk5Y2G55NPBH6S5wMd3VECN2ZQK9e3S/6dEtoTU9yJp3uz8GD4opG+BLmS1Wl32hjXvBg0eD6SPVCynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=V/Aaph5/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="V/Aaph5/"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6eeafd42dd8so2508737b3.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732141411; x=1732746211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k86Hl7a4XzlV8EfWKl9P/f9Nsx8qGpKvGwcdHE/wYo8=;
        b=V/Aaph5/tuyHtMwHv1pYfpxe0dXbHO8yzgtvoyrOT72vbAiIi+230p0joYV+MnR3Wu
         CW0rbeRu5Et5J8xNF7P6NLzaFNfMYSKBUFBOWPnKBxRduqYQiUTnh8cpfLhKi1JBYYwn
         KHkeYIe5uSH2+IkffaguhtSS127oF9ElPnqj3aCymVh5VHHFOR1M3dbyy9fnRUX2bRNi
         I71Z4j5Fnw4AnQVUBnv4S7vIxngSuEx+cT2yCnMllRQUVYwuDAjICONL94npsE61On5T
         0p4UtaszBA/cVqRNEoeJfN8+J+H64F3vZlp/viwi9pMxr/7t371Olftg5wkudRY2l35g
         OhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732141411; x=1732746211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k86Hl7a4XzlV8EfWKl9P/f9Nsx8qGpKvGwcdHE/wYo8=;
        b=SPjUA2ELXyxhu12G5AxAB+q5vqwItv25x2VuvjxRw/camXDKx49wKB5KayS6fjPFMh
         dEBhJ5WosXjWfz7AmgU2EHjMjshPFenkGtLUm15yj1J2sNJy2yF6C7yDjVvbi8xN++YY
         cOdTr5RhkYIfxR6QdGovow2NAzT4SrTV33LtD8dxejGEPS5g0rJMrCPI5J1+dojp7VeS
         8WGDCJaJ8haUpEjIhWG3MjAilTv8DrSiKlsFpCCzRkiz5PCyyFEzcd7xxdLgs3qulr3o
         PpcHswyeNj69xMs8e0MYl6QCmxRSX7EVPlAl0AQPGLKack8zV5vJGFGCy06ogrBfGP7l
         vL5A==
X-Forwarded-Encrypted: i=1; AJvYcCVeSqIvn0sF4aSWz5c/oOATdZggrGdV+VES+Iqo/hAydfgX3VvDBR0h41GFplzLW5HFS/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bhunBfkTW7odRKt1+o9mtd/CM/jddDP5CcpXjt3BhHnLzcHp
	KyPTmcUOjRhrbyu+Yxlq6rHrzIt05ggvO6BYWJgbPpC5Iwb+Es/JBZmJ8ZS8rA2gb0k3B1YrfbX
	n
X-Gm-Gg: ASbGncvCadGg0YO+iespwoPM8PNEUZzSFzypU9z7VXanTCJLGyWym90kzPOm1Tbdm8g
	+B4QmvAXGMAw//KqBGHUCQjF3HU2XTHk3/Yh0zfu+Cle/lDJJZ5INh/iiP0H4Pf6wigjUvEkF9G
	0L9AC5a04yJbpJNBX8xNJq6GAss/WR0qDiphK846Pj0BZlSyYIP3koYZSYq4YrHYcqVizMywDWn
	wsJrSYIWSKcLOCzRuouA5JbLvG2HPbQRkG2iXynrLUFtZYTfyAFT22v1mqBiccE3tVMpniUMqTa
	GAqALoVkf1b/8L6+AMzd8Q==
X-Google-Smtp-Source: AGHT+IEr3b68aBJGO13QcEVd+FZHo441FVzltnHBiwo9idjztv36gsfkvmjQ4M7HF/cx+kfpeSkNWg==
X-Received: by 2002:a05:690c:74c6:b0:6ee:7012:d72 with SMTP id 00721157ae682-6eebd2b2460mr50663767b3.38.1732141411460;
        Wed, 20 Nov 2024 14:23:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7136b359sm24419197b3.115.2024.11.20.14.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:23:30 -0800 (PST)
Date: Wed, 20 Nov 2024 17:23:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	shejialuo@gmail.com
Subject: Re: [PATCH v2 09/10] midx: pass down `hash_algo` to
 `get_split_midx_filename_ext`
Message-ID: <Zz5hYfHLL1vsxdY5@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-9-e2f607174efc@gmail.com>
 <CAP8UFD02a+ZfHo1L5qhbzD2r4bmhXadSj4sy0acPncnj4pcRpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD02a+ZfHo1L5qhbzD2r4bmhXadSj4sy0acPncnj4pcRpg@mail.gmail.com>

On Wed, Nov 20, 2024 at 07:15:40PM +0100, Christian Couder wrote:
> On Tue, Nov 19, 2024 at 4:47 PM Karthik Nayak <karthik.188@gmail.com> wrote:
> >
> > Similar to the previous commit, pass down `hash_algo` to
> > `get_split_midx_filename_ext` and use `hash_to_hex_algop`.
>
> I think we prefer explanations in commit messages to be a bit more
> self-contained, and not to rely much only on other commit messages, or
> links to a mailing list thread on a mailing list archive, or other
> external content. It's better to err on the side of copying more.

I agree, but in this instance think it would be better to simply
combine the two into one. I do not see a reason why these commits should
be split.

Thanks,
Taylor
