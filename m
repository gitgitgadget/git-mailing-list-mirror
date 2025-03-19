Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EAC21CC44
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424620; cv=none; b=eysWAl4iOlhUeuAtI48Ve6MmUyMEA0kKFZECC2axxp4Ck7UR1XNWS96ipdj/YeREzZfXkCGC0yl/D36VrTkWLx0TuxXxPLGH1C5Qu9Oc0GuXyo6UVnf8e1J4L6rrwTmioEAaWNKWD3xnhHB16fMDLcawsbJdqtrIk1GJFXNacOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424620; c=relaxed/simple;
	bh=PHeAQKTbFvllxsqIIUVfMlVJ+wXtqx7jvHZa3ePQORM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbWr58CjfzYdeCkJco4NVEZgMmXRKqhWDJ5Jg05/icog7tCDI6PoiQVooMKFeuZ0iaOJaAGDY3jv/9vkBsAz0Gb5Im6EhQbWv1RuSBf3Sjq696MjOmw4HVS6GcEz4WknC47mggGzt6lqEcpOLgG7yXAp0ltbwEQ8I46jTxXhmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tXzAjVo/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tXzAjVo/"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f6970326so1454856d6.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742424617; x=1743029417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vfDufkGD8JdzoKBYDmq9DhpiVN5i9KzWKGRPY5QbG7s=;
        b=tXzAjVo/g7/S6GjivAWpBgm1pev8d3UHj5h0nj0QCk8rgI8xDjZ5Wlft/3NmPOpyR9
         U6C5+fYyixOAwb2aX7tqhNGKSPdMabROClyHmxdeNR0zk8OwQIIZmS+q1mlBlxRR0fhc
         fNIhOx9xi4DD8d+VZoNWdJqwhTZNcSLTRFwnqygQ+JO5sT8zHiMq7ckw6B4bab883yPL
         obALtCQ5aXvKyKfpa/wxSjfEvMS9Ui9GZLr/HBdRCKhmRwSx5fX53vo/IrnkvgNyTvNY
         sHlnQc8/ZmPu94vXW6jUvTaWYkzVXtvY472TfxhYXkkrmwbRbkaa0I4kJp+c9AUY/4qZ
         1XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424617; x=1743029417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfDufkGD8JdzoKBYDmq9DhpiVN5i9KzWKGRPY5QbG7s=;
        b=p3SfbaEjMbc7/F+BmDw6neT8kRswsfgPOa+je29cuyUxhTNUftXj8lBEJDK8mET+6q
         ur584znebTkUONLRSa+AOTLv0dS/XZTd1mkf7lBNvNMsVuhuVnVGexeud8nSL372Ct8Z
         tJId2KcSzZUV65I6n8iJptO1qA1HlnZj9Af5Cwc2zIyhVv8EERf4ImkIKChJC2i9jnOU
         Zl7TRXux0WuS66qpdnB1KcTa+HsLC2LcZuXkprtIVdq9w4Hb59Lf0Aj4e97DalxevHnZ
         mgc17ZYRe+VTkWkjXHI0XxjyTRvXFEtWqapkVwU/xWPybhw5tfy0X6VdCZpkqJasGT2p
         aCpA==
X-Gm-Message-State: AOJu0YwMAgC3V4w6js5pNAZSRsepoPrwY5em7r2YEs0/u0XUOJ2pbvAr
	bxgzxd4h3B5DV3DvG/SYadAQU+g6rHcSd5fOuF/QU7H9OjZZTX2Tq5V0r9+Yf2E=
X-Gm-Gg: ASbGnctD4u6/+PpTIt6t/AZ1spJdcucmQEAAsbx5ipo6GeJkLUDSAvwjqTemF/Kvs0P
	zu5C+kaHii29Dqkm9K68yJQAhj5PtnkynGHKLyM9SRrIrrZE6vW/rDSjS2WkTg5mhNynMLKLy+g
	67hxSJr4wxF8Y7r6B0RjfL66PRZyRSjtd5o8mguaGkWgfX95lS8zVPIv7sKBYdJZEfXHyGAClhI
	ihgK9cNux+65k7xSFe8oUm3whr1gKYFH5AszcqvQPKoZTehxAoSFJUhT+vpAP7Te3sMp8geYH60
	boqxrp3R/QMIN/35QLdBMZEQOphFkGkSCoHbBJ07yZ8k23xXzINy59hEaHaBXsPhyq+5V3n1lEs
	dQV7ox/NvKZiSFJLG
X-Google-Smtp-Source: AGHT+IG6O8sjUrbcbZeaAbxTq+rJmiOXskkXRjkF2rWNKXM2Jj7AohFosGE/0Y6AlNVdBgiM880tfw==
X-Received: by 2002:ad4:5d4b:0:b0:6e8:ebc6:fd5f with SMTP id 6a1803df08f44-6eb2939fb0cmr69468076d6.20.1742424616938;
        Wed, 19 Mar 2025 15:50:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34ba77sm85049986d6.95.2025.03.19.15.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:50:16 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:50:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] repack: begin combining cruft packs with
 `--combine-cruft-below-size`
Message-ID: <Z9tKJ47+3ffiB2fx@nand.local>
References: <cover.1742252411.git.me@ttaylorr.com>
 <7f120c35e95dcf41282c87dc2d1b2640ecdc5d84.1742252411.git.me@ttaylorr.com>
 <CABPp-BFhZ1JGR_qWSgmcZm=Pix2n6z1AQ+-R-mw9Q_fWFi=_Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFhZ1JGR_qWSgmcZm=Pix2n6z1AQ+-R-mw9Q_fWFi=_Ew@mail.gmail.com>

On Wed, Mar 19, 2025 at 07:21:01AM -0700, Elijah Newren wrote:
> On Mon, Mar 17, 2025 at 4:00 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > The previous commit changed the behavior of repack's '--max-cruft-size'
> > to specify a cruft pack-specific override for '--max-pack-size'.
> >
> > Introduce a new flag, '--combine-cruft-below-size' which is a
> > replacement for the old behavior of '--max-cruft-size'. This new flag
> > does explicitly what it says: it combines together cruft packs which are
> > smaller than a given threshold, and prohibits repacking ones which are
> > larger.
>
> To me "prohibits" suggests some kind of stronger action that
> potentially persists beyond the end of this operation. Perhaps this
> could be reworded to something like
> s/prohibits repacking ones/leaves alone packs/ ?

Fair enough, I went with "leaves alone ones which are larger".

> > This accomplishes the original intent of '--max-cruft-size', which was
> > to avoid repacking cruft packs larger than the given threshold.
> >
> > The new behavior is slightly different. Instead of building up small
> > packs together until the threshold is met, '--combine-cruft-below-size'
> > packs up *all* cruft packs smaller than the threshold. This means that
> > we may make a pack much larger than the given threshold (e.g., if you
> > aggregate 5 packs which are each 99 MiB in size with a threshold of 100
> > MiB).
> >
> > But that's OK: the point isn't to restrict the size of the cruft packs
> > we generate, it's to avoid working with ones that have already grown too
> > large. If repositories still want to limit the size of the generated
> > cruft pack(s), they may use '--max-cruft-size' instead.
>
> ...but then they wouldn't get any cruft packs being combined.  Did you
> mean s/instead/together with --combine-cruft-below-size/ ?

Oops, yeah; I meant to imply that '--max-cruft-size' was/is still an
option, not that one excludes the other. I went for s/instead//.

> > There's some minor test fallout as a result of the slight differences in
> > behavior between the old meaning of '--max-cruft-size' and the behavior
> > of '--combine-cruft-below-size'. In the test which is now called
> > "--combine-cruft-below-size combines packs", we need to use the new flag
> > over the old one to exercise that test's intended behavior. The
> > remainder of the changes there are to improve the clarity of the
> > comments.
> >
> > Suggested-by: Elijah Newren <newren@gmail.com>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  Documentation/git-repack.adoc |  8 ++++++++
> >  builtin/repack.c              | 38 +++++++++++++++++++++++------------
> >  t/t7704-repack-cruft.sh       | 22 +++++++++++---------
> >  3 files changed, 46 insertions(+), 22 deletions(-)
> >
> > diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
> > index 11db43b1c5..8e6d61aa2f 100644
> > --- a/Documentation/git-repack.adoc
> > +++ b/Documentation/git-repack.adoc
> > @@ -81,6 +81,14 @@ to the new separate pack will be written.
> >         `--max-pack-size` (if any) by default. See the documentation for
> >         `--max-pack-size` for more details.
> >
> > +--combine-cruft-below-size=<n>::
> > +       When generating cruft packs without pruning, only repack
> > +       existing cruft packs whose size is strictly less than `<n>`.
> > +       Cruft packs whose size is greater than or equal to `<n>` are
> > +       left as-is and not repacked. Useful when you want to avoid
> > +       repacking large cruft pack(s) in repositories that have many
> > +       and/or large unreachable objects.
> > +
>
> Does it make sense to modify the documentation for either the
> --max-cruft-szie or --combine-cruft-below-size options to suggest that
> if both are used, it is recommended to make --max-cruft-size twice (or
> more) the value of --combine-cruft-below-size ?

Ehhh... I kind of want to avoid mentioning it TBH. Part of the reason
there is that I think the explanation of "why" is a little too detailed
to spell out meaningfully in the documentation while still keeping it
concise. But more importantly I want to avoid encouraging people to use
the '--max-{pack,cruft}-size' flags to begin with, since there really is
no reason to use them outside of filesystem constraints.

Thanks,
Taylor
