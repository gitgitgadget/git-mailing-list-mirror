Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E814601C
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792939; cv=none; b=DiURXAHq49McLqCP3a4IQbJRF/78EAGqjt/NwAKJlpw0z1KWCJhv5R6obul/MHPLcmQd8UGVoVsDeMDS1aw9CQnhL55lgfj8v/o5XNPpBPQd7MebEOqBz022eh/lxvj1u5wbYct75M72WCr4hZ/8Xd20QyopoxFnm8kTSGJwI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792939; c=relaxed/simple;
	bh=WLDCDq7Ai4gedzXe4YXczOOCBC25DLAFrZ++T5Xg3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwTsBwehvHVOerBAYHQe2PHMRiIymOovSUN1scB9PsrG8HYrAZ+kB/tIgod50by5AoGC/3rsgIASE/M3xDCd43wxSxBUVlkxM+YcIp+qQEmqqFSKdk1Be8euxDH5BhpEVtDmVFLeg7xXNXEokq7N025kFdPNqVrWXh446HtpDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ERSe3pzb; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ERSe3pzb"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e637669ef11so3288426276.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741792936; x=1742397736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTP3embx/R9kjjmd96baaqxIBZEQxc+ghPXhRh82Vro=;
        b=ERSe3pzbZ0ieLPx8QmMf7JjSaMheFBg7Pqwc1OT8UuPTcD7E2ARW0ysuzSmB2RiIcy
         nZd3o84WMeUQ16n0w2gRke+GvgBpYaoW33Uyk+cwpetUOnv32mgVf6vlgggZvQ9UXFXz
         xApYQVpBkVJ/iEeHTxzPafUCKCZuZSFf5p3EJsPrftexDOo4WvCamd2VHkucxOsHmCGg
         /qbasiCWz+vuip8qDUT0B/umVj3+w54BbBOKirdZ49gvdXSwKAN1PO8A/SPHDkcuh6Ak
         EtsrPPreOuJafm5EmA8oaAe/pY8Wxf6wbYHpQ4JCvG0yM52cblJ0MH2XzSfJMfLuVh/F
         aEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792936; x=1742397736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTP3embx/R9kjjmd96baaqxIBZEQxc+ghPXhRh82Vro=;
        b=t+y6NpWZbRqqqS8EOruOJl6mPkt/VGQIM1oeJqtcFZt9G4zkiZqF4dTnMVOQ8bj+5s
         /a1bnoFNlF4gNChEX6AMlwyRKWXaHphmbkuvLmWLGj2HbC8OjwZ8+e3u83eVsvvFe+Hv
         KGRcUTEC3Ez9OGR3Iu/50iVPKFJSw51fTH8GAdBhEdEhNxrGN+IWUaZmTWtZLDnNJt/G
         Cq59+B42wGDKEZus7v6fBokqrX1fJ8nwk8hjbbexaLsWbf7YGQOf33M0tWkKDHidR1b4
         vL8TPHu4YF8ZrFCmLe6nA8d+Er1z5h3Xu//nW03hsjkhvQV5KDhnMGOWK3acPCdMa1o0
         luNg==
X-Gm-Message-State: AOJu0YwZg6qKV2q+47mrStORiJ/wiZw+8Oou0g6OMlVZ9UFr+CbOiXkz
	QOCXj5TwF9gxgCj+UvF2kP/Mt7oGkuC5/CgKgVV96bw4JaOb+b+l+O8BmTdtrkk=
X-Gm-Gg: ASbGnctcb3KzcFUin0yVLBnNK763/pYMnNJzpOEOWiuxtjK0SwongbUs8pW6hmuSaFf
	9/ZBlQDxYx2BpX6/TiyE3HWwkuwjCXfz0ZxEN1vvpWSaRJpoFz+GLHhcvnQb5mg6FTo4CCC9w8r
	QVXUM9jyEiQVOXvQpis40iKODSDp2DCM3mFPgGZ70Dcv7vnV1x8dv16AAUWI2z5E4A7znoMSm21
	tQpxUCjGxXNv5SwIhzTDbmtS6mVosaF2m99+JgFwWHjPNrmbX2UDRqSRNk+T3iOK4tNp7F4Lnav
	GpmFammiPWnaG8hQhfjudA8cIT+mXeoLKjUcd4jVQhBEwqfOMy8EUj4Bg7bEzTuVdLyWC2klAti
	sFDRkw8RZkXEpOfVI
X-Google-Smtp-Source: AGHT+IH6E69yh8wzGSgsNX6vq/G0bFVsa8NaxhCz+y2iO1mzAfXomzU/9iPzbJDwat7y1L9wG2edhw==
X-Received: by 2002:a05:690c:d19:b0:6f9:e45d:8a32 with SMTP id 00721157ae682-6febf39bb68mr315647397b3.23.1741792936087;
        Wed, 12 Mar 2025 08:22:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a6b14bsm32180237b3.49.2025.03.12.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:22:15 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:22:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
Message-ID: <Z9Gmo2P3Fnt3JeOs@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
 <f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
 <xmqqikof2pqp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikof2pqp.fsf@gitster.g>

On Tue, Mar 11, 2025 at 02:59:10PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > When generating multiple cruft packs with 'git repack --max-cruft-size',
> > we use 'git pack-objects --cruft --max-pack-size' (with many other
> > elided options), filling in the '--max-pack-size' value with whatever
> > was provided via the '--max-cruft-size' flag.
> >
> > This causes us to generate a pack that is smaller than the specified
> > threshold. This poses a problem since we will never be able to generate
> > a cruft pack that crosses the threshold.
>
> So far I see absolutely *NO* problem described in the above.  The
> user said "I want to chop them into 200MB pieces but do not exceed
> the threshold" and the system honored that wish.
>
> > In effect, this means that we
> > will try and repack its contents over and over again.
>
> The end effect however may be problematic, but isn't it due to the
> way when to repack is determined?  You see 199MB piece of cruft pack
> plus some other cruft data.  You have generated no new cruft and no
> existing cruft expired out, but you do not know these facts until
> you try to repack.  Because 200MB is the limit, you include the
> 199MB one as part of the ones to be recombined into the new cruft
> pack because 199MB is smaller than 200MB and you do not know that
> the reason why it is 199MB is because the earlier repack operation
> found all remaining cruft material to be larger than 1MB; if there
> were a 0.5MB cruft, it may have made it closer to 200MB.
>
> So would it be feasible to remember how 199MB cruft pack is lying in
> the object store (i.e. earlier we packed as much as possible), and
> add a logic that says "if there is nothing to expire out of this
> one, do not attempt to repack---this is fine as-is"?

I had a similar thought when first thinking about multi-cruft packs, but
the line of thinking is somewhat flawed. When we do a pruning GC, the
vast majority of objects should be expired out of the repository,
leaving only the recent ones that have mtime newer than the cutoff. So
the majority of packs in this case should all be removed, and the small
amount of cruft data remaining can be repacked into a small number of
packs relatively quickly.

> > Instead, change the meaning of '--max-pack-size' in pack-objects when
> > combined with '--cruft'. When put together, '--max-pack-size' allows the
> > pack to grow larger than the specified threshold, but only by one
> > additional object.
>
> I do not think that would work well.  You have no control over the
> size of that one additional object---it may weigh more than 100MB,
> combining your 199MB cruft pack with something else to make it ~300MB
> cruft.  In other words, "just a little bit larger" sounds like a
> wishful thinking handwaving.

I think that it is somewhat of a handwave, but I would note that our
current rules around --max-pack-size are not quite as strict as I
originally thought. If you have a single object that is 100MB and your
pack limit is 50MB, then pack-objects will generate a 100MB pack today
containing just that object. So I don't think that our --max-pack-size
rules are quite that strict.

Here is the case that I am worried about:

Suppose you have a 100MB cruft limit, and there are two cruft packs in
the repository: one that is 99MB and another that is 1MB in size. Let's
suppose further that if you combine these two packs, the resulting pack
would be exactly 100MB in size.

Today, repack will say, "I have two packs that sum together to be the
value of --max-cruft-size", and mark them both to be removed (and
replaced with the combined pack generated by pack-objects). But if the
combined pack is exactly 100MB, then pack-objects will break the pack
into two just before the 100MB limit, and we'll end up with the same two
packs we started with.

Ideally we would combine those packs into one that is at most one
object's size larger than the threshold, and the steady state would be
to avoid repacking it further. But in current Git we will keep repacking
the two together, only to generate the same two packs we started with
forever.

So I think a reasonable stop-gap here is to let pack-objects generate
cruft packs with a --max-pack-size that are allowed to grow *just*
beyond the threshold by at most one object. Yes, that object can be
large, and so it's possible that you could end up with a pack that is
significantly larger in size than the threshold, if the one-extra-object
is itself large.

But the point of --max-pack-size in conjunction with --cruft is not in
the original spirit of --max-pack-size, which was to work around
filesystems that don't do well with large files. Instead, the utility
here is to bound the amount of repacking we have to do when generating
cruft packs in repositories that have many unreachable objects.

In other words, if my --max-cruft-size is 1G, and I have 20GB of cruft
data, I am less concerned about generating a pack that is 1.1G in size
than I am about repeatedly repacking the same 20GB over and over again
each time I want to add a single unreachable object.

Thanks,
Taylor
