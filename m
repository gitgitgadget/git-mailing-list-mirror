Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB195200A5
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705447884; cv=none; b=phwuovdBFJGk9Qmyk/oavL6KImMkB409s5yH2rvlBv3QBY0A3Vyb4YbHdBqre7Xmrxfh5PI1wmXJO+ne7xzzfLSKAvdKLoGxG6I1Bd7lKLfXGKFw1gm7b7QitY4gnDB824oS1/A/IuciLd3F9BLWFkrE99YWqgCywHlB/sCsnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705447884; c=relaxed/simple;
	bh=+UNZXp5ytCu3F4XmW8eqCOjBFb/IRYfJws34PHnC6QI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=haLBoZ2vm2P1MI4tNkgWO3sc7DZPuiTAdMi56OkqiuKOhrqJzzsJ3jgu7l6hHO6WPTgoAYcCLsEew/62pZQA5XKbM0zXzyWZLsYoG1FXWBKtL70rtfg4qS+MpIE2K73nq8yT1O1/TzS6UCqtjDog9VZtCq6FhOjGUt195JoT2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YlxnGaP5; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YlxnGaP5"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4b77c843fbeso2931762e0c.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 15:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705447880; x=1706052680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vD99qpAiEwfwer1exM4z/7k06Y0wd1Fy3fe4HoUWBv4=;
        b=YlxnGaP5SFe369LEXOTOy7Aoumqdlaa10MtcRreAJV6vniQk+AmWtvHcrie+huzyS1
         HAPkOUHT8lfDwfPcdeLtMYgK5j7oyBAnUWzdb7Ipc3R9fRIAGG4zwX49hxNiKn+2hSqP
         j2ioRA8yUikah/wXYxm1XQ7HV0LR4wNhYA/DnyCaVdlRZXO/0LlfJPCc3XFn8AAgvD1E
         hQGtPFKVZphrT4HiPS7HtE+Nhc0V50z56z7pFeYN9SaPUG18nZj1DtCdLJGMgWmtPNLb
         hROVJSYaZ0NK83Tpr9UGjpsdiRSx6WiUD7BZy7AwPYQcqrs9zgIsf9VKpHFkg9+QPUKm
         eWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705447880; x=1706052680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD99qpAiEwfwer1exM4z/7k06Y0wd1Fy3fe4HoUWBv4=;
        b=UV781pbqc0uObupZ3x0N0/Hv4H9bZdD8xPruT17MkZfYhjfm7LvAjn4+P3Wyx64dKG
         2zTHt+sQTamm1qwtn+LH2iYK+oJxl79ry/4hx2SmIEzJmkYOZeY7Kka5xoG8cT9ouds6
         kPsuol5GOHc+JBR2O+3MqXrClVck9j0M1jT0nTxv2dOn3ib2wnoyCKy21nuBtQFUVaB7
         XIw0w7oEAz/GZrgdpNGAw1CaqpE/8GhLcMxh2Vg4F5vSec2XSkbgOjrqAs9c/wD8603H
         taYvH23o69j3AzCc2QLjm1zIi1OvG8syQSWiCc/XfxalW+GXaLdxiyGpstZmedlvHcwc
         Ku6g==
X-Gm-Message-State: AOJu0YwvAUVqsBuNn0TPsV+HNDpaNZQzsY2gRit96KGMNIyIHnToEWcb
	0CsZRgnwg/w+Eqn6SychbpYyQbYW5OUPzA==
X-Google-Smtp-Source: AGHT+IHAKZaaMe5uzbnNrlhxYWW9yfUUeBIpsuYTlHF8/6DQiN5vTcO8k7WiQzKNtMeEIGRpKDQ9JA==
X-Received: by 2002:a1f:4ac5:0:b0:4b6:e383:5f with SMTP id x188-20020a1f4ac5000000b004b6e383005fmr3668727vka.25.1705447880644;
        Tue, 16 Jan 2024 15:31:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l16-20020a0cc210000000b0067f8f04a2fcsm4558922qvh.57.2024.01.16.15.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 15:31:20 -0800 (PST)
Date: Tue, 16 Jan 2024 18:31:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <ZacRx1rbESvYiVgN@nand.local>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <ZZWOtnP2IHNldcy6@nand.local>
 <xmqqa5pm9tnx.fsf@gitster.g>
 <20240113183544.GA3000857@szeder.dev>
 <20240113225157.GD3000857@szeder.dev>
 <Zabr1Glljjgl/UUB@nand.local>
 <xmqqfrywyk16.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrywyk16.fsf@gitster.g>

On Tue, Jan 16, 2024 at 02:45:41PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > OK, everything seems fine thus far, until we inspect the value of
> > g->bloom_filter_settings, which is NULL, becuase of this hunk from
> > commit-graph.c::graph_read_bloom_data():
> >
> >     if (hash_version != 1)
> >       return 0;
> >
> > which terminates the function before we assign g->bloom_filter_settings
> > for the existing (written with v2 Bloom filters) graph layer.
> >
> > I don't think that there is a way to fix this in a backwards compatible
> > way, but I'm comfortable with that in this instance since we don't
> > expect users to upgrading to v2 Bloom filters and then writing new graph
> > layers using a non-v2 compatible version of Git.
>
> A big red button solution to avoid this would be to uprev the
> repository format version once you start writing v2 Bloom filters
> anywhere in the layers.  That way, existing Git clients would not be
> able to touch it.  I do not know if the cure is more severe than the
> disease in that case, though.

I tend to think that in this case the cure is probably worse than the
disease. I expect it to be extremely rare that a user would upgrade to a
modern version of Git, write commit-graphs, then downgrade, and try to
write more commit-graphs.

> In any case, at least, we should be able to prepare the code that we
> teach to grok v2 today so that they do not trigger the same segfault
> when they see a commit graph layer containing v3 Bloom filters (or
> later).  Then we won't have to have the same conversation when we
> somehow need to update Bloom filters again.

This series should accomplish that by loading the Bloom chunk
unconditionally, and only reading its filters when they match the
given hash_version.

Thanks,
Taylor
