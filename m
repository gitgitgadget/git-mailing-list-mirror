Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF731C3C1A
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737588526; cv=none; b=oHMm3W8f4vBCN9g6bbOEicoFmHJlPUBCB56fYmJYL8i8VYKLODaZks4n3B0UI6+Te6/SmflHauUtkRzmeL8BcZvwgL3yVbaVNmA7z0a3CMziNmndBO40Z70hGPCxzAFPT8BtaboxYSSV3tQUpJjK6F10an/bm4GvNCdx4jevSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737588526; c=relaxed/simple;
	bh=4vnad7+O44g1R9FbiOP3DUtdPIbwIwn1tZ6j5CMzfPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqdvz5T8nTWcXKR8qPoVZSb0C5RjrF35aRg/q6mk+hfi3cYGBc1XIUOFFCKtbJhpL0RQq1PNW0NCb1tnZyegIw20yYCFEK59rPz04PQ6ntv26qq6ciYVAv0dfFVAxwhfIfP7vz/kEQci/I8kbAlaZi8XLKOXEEagsKzUNz4JSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BFvTX5rk; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BFvTX5rk"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e46ac799015so449142276.0
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737588523; x=1738193323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vnad7+O44g1R9FbiOP3DUtdPIbwIwn1tZ6j5CMzfPA=;
        b=BFvTX5rk39IxGm5KwLfYqSgZ9SY74FUZX7IoI5j77tbyZIk+OXFe9D+mf1cf9Xxfp8
         Dow6cnJQyXFmmpzAkAlKPhkkbXaJfptRkSaFLpliNpDCm14RYWjBx3PN99GO+29dyy9E
         yFIbz2lnt5QNT2A4M0epOafXhcWKMUwMGGrDR+VMgMLIIFjkVmRlWZg0IJ2n/WpMHFTM
         +Vk5yOQuQk2InLqSSs2oQ3tv4HYJrJW+Tn+BYjYipaAXI03w82hZnSIz3RFvx07QGwMk
         sZKaYrFKgGZRe9p/h+HafdgEoclFBF3aJvpqwBNwSWfDWDY8fS6KFin/4X/fCjxr4Wyl
         nnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737588523; x=1738193323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vnad7+O44g1R9FbiOP3DUtdPIbwIwn1tZ6j5CMzfPA=;
        b=bmzM1eGIPV3rSi0I81UBxO5aiex7LnJLtgjK1J6EQS4ECy+8TpGh36VoiLZMlcvIbC
         gAIGyw3s6TrF0ZW/s4+SPmowdtnZmjil1bbvyorqS2K+8Km40fE0CywfJiyUHLVD9n+b
         eBK10vtxsa44wxWJsHSk0N9jyo1ns1X9vpAoES0WLJE26QrZ+PW4fLNAswIZAaFSdo1Z
         ggKZ1JHbVhAhCytWqtueN8QTKI3L84hNzo3u7It1gsncxYsRV9WD2/vZ5m8NVmH7Erj4
         OgH460OfWRyMS04M1cjLLrTiktWJlzW00+LOlCWXgeYyGJtLqwifbaevhZsdb3ibCOuW
         CwMA==
X-Forwarded-Encrypted: i=1; AJvYcCWY2tiMrJO5exHpTlb1AB+3GyAW22MiCPaE943J0OiPX2hxkjaiG1LHzXDYixXZe4/xHu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08Z5u3KXemczFWHJ/MLFNol4K/IIYnRVbsMWIMJ6mktqk8NqL
	2LPVjQAEpIk4I/eJajvDRkmW50kRbtufuWhxOMX8S2cj9AegrwILbT0YBkW8/E8=
X-Gm-Gg: ASbGncspYuDQ/TYpcrHKRnPQhTyV1VbPSILEYgGI7HMbS1Ns6Z813odnmHI6T03DpjN
	5ZqSJONhLJVG04DMpbUTQwKWiZ7621rMVocwx1rsi2MDgxjpaim2d1lpjrLwJ0nsPuas4LcWAN7
	QeXNpLJsYHjkCgsgoX8chsQxcUXTZTh+mgAqhOCLOzqRcqqt97Mf2D0uB0k9J9DmlMi/4819ie3
	rGJhCIxARVp0dI2mELD1L8f1OLEB8SlaFO6hn1QxP5iFPLqJX2+bQRenevFk8dCvlCOQiO91mLt
	x7nAMn6wYNRyaEHiirsgFS0nMgifINERzpTFaqHWng==
X-Google-Smtp-Source: AGHT+IFLsw7TgCvI211RoyjFOmXd1/GCCks35vnma2ROpKmyvCVm5WIAR47QEKXG1/2EOi9MVGUYiA==
X-Received: by 2002:a05:690c:4090:b0:6ef:a4bc:8bc9 with SMTP id 00721157ae682-6f6eb6b02ddmr130644477b3.21.1737588518680;
        Wed, 22 Jan 2025 15:28:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66fd850sm21798107b3.117.2025.01.22.15.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 15:28:38 -0800 (PST)
Date: Wed, 22 Jan 2025 18:28:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 0/8] pack-objects: Create an alternative name hash
 algorithm (recreated)
Message-ID: <Z5F/JdnSAYqUBJ8s@nand.local>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <35026c72-f9b4-40a3-b528-1c28b1238972@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35026c72-f9b4-40a3-b528-1c28b1238972@gmail.com>

On Tue, Jan 21, 2025 at 03:21:15PM -0500, Derrick Stolee wrote:
> This series has been at this version for a while. I'm pretty sure that this
> is the most promising direction we have at the moment for improving delta
> compression for many users.
>
> The only decision point I think remains is whether or not to include the last
> patch (--name-hash-version=3) which I would be happy either way.

Sorry that I punted on reviewing this for way longer than I should have,
and thanks for bearing with me.

I took a close look at this latest round of patches, skipping over the
parts that I remembered from previous rounds. My memory is far from
perfect, so I may have commented on things that we've already discussed,
in which case I apologize :-).

I left a handful of comments on the patches themselves, but they are
mostly cosmetic. My idle thought before having a chance to review this
series is that the --name-hash-version option was handing over too much
control to the user without clear instruction on when to use one version
over the other.

After reviewing, I think the idea of having a versioned name-hash is a
good one, and I agree that it'll make the eventual .bitmap changes much
easier to implement.

So I think in that sense exposing a `--name-hash-version` is the right
thing to do. My feeling is that we should probably just add Jonathan's
"v2", since it appears to be a improvement in nearly all cases against
v1, and more often an improvement than not when compared to v3. In that
world, just introducing v2 leaves us with less code to maintain and
fewer, clearer options presented to users.

If you feel strongly about keeping v3, I am definitely open to changing
my mind here, but my feeling on first blush of this most recent round is
that I would probably just include v2.

I'm excited about seeing these patches land, and I am glad that someone
is working on them!

Thanks,
Taylor
