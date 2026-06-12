Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637FB3112AB
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245102; cv=none; b=o2tIzP2TEXT4xDddqy44GM+XJ0YHbMwrAKR5DALiZqiMrSzAf7yBPkcpFOuuB/mpqgK2g+T9a3Sp38f4SPdEQ2w3KJRIc9FqK9EJ/ufzN48sItbqN3eZMRt29P7ws5Mqe2OX7u81WbMcVZ45vQhXdK5vSfw64RHDUeDulInFB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245102; c=relaxed/simple;
	bh=nNckjuPVLdr2mcEbC4c/ruqvn1oEMp4F4YhkM6JHp6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYrERmyJnmBObOTQAFQgU5383Z6ngSjDLAXgGiT7CLHqtacH+ob08Timzg84qyJS4G775uOe7tTv3rVVEMok8utVEks5OXGCX4plXuHUVXyuda1VIXJglQPOjkHlhzbmmQBVrVJ4XxgOwJ1N2MPhaRqKk+bsrsipIoSbHXHwKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nyk35cv/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYiuh0g/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nyk35cv/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYiuh0g/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BAED7EC01BF;
	Fri, 12 Jun 2026 02:18:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 02:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781245100; x=1781331500; bh=PcIC8v05yr
	1A+hJlDzp5qR7o4dqofPfmKKxY11SFSU0=; b=nyk35cv/Pa3v5PCNZuKcqZFRTp
	CuJXwAiNI/R2fMPwpALN2RRDJ/n6w0ySi2TVp3dgXtRIQ/r/NNSODD+Xy4B61004
	/b/PfEMkoipzCqDOwGlYVBHqe+453B6Hk5ZraFjJB88oHLsDzOYVEIRdu+WsiqBc
	0Ppys/Wa9Ko9iNP+xWEe8CSG4rCpDxFyURAy0Wn0VUSNziZClZDW1M+9rcz/XLSF
	HMN+4HiruVufCu1jl1q6p3xYfrWUFKJ/farftPoY3gtTG7ojWi0nch9UXM6RfLCX
	k3WPN1YKmIeLDMS0MxV+5xjOLfpOfES3Q8EvqPiXkp6Jiicpmyl6mNsQh8cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781245100; x=1781331500; bh=PcIC8v05yr1A+hJlDzp5qR7o4dqofPfmKKx
	Y11SFSU0=; b=jYiuh0g/4JcqaPuN9IJZJ/B2yua/y9dsaOEjbYeBx5fLoDmQf0u
	9kZiWhqLULhXag8f8SLFLFduAY/vUkjs8ohHDVwsf7Eus8BsHz+gBE350Q1rrdf5
	C1rRgGqKNsjqY+CZgScysBTSkWfRz9mJQM4ptirIqb5R6Kx6rR6BQTWqJaGWo6IE
	qh7ik8ENWnE4o7CKpoNCaz1xVpMXGpaoHIkA2ckaAbLKnWdtGnP+vAeHjypRcZei
	V/EwW8LWOJSJYJ/+IY5ORAt5He4L6ixYckuXpeiRauuNsA9IjM4f4EWiOzMUFk5A
	ak95f+7vLvZXMnrHkMQbRUy3hLVfGtHfoLA==
X-ME-Sender: <xms:rKQranTOe9DGugfldUP8PtILRFu4TAgxGFpog4nGuEl3fAdf3GUyIA>
    <xme:rKQragMX9ZwR-YRyu7Pg9K0r0QX9k5qczONHGvnBkBcztpzzf4LcECR_rwCJOqL0w
    QEX2MCnEE_g7Y_AID0Bg69iBXVuQiJ3rjLV2fhjno10Iu-aySNu>
X-ME-Received: <xmr:rKQraqOGSQw3VLVLbIvYy8UmHC0vJxQpVv15ox5p-W5OthG-T_e_5UP8NorMQIC7z5XStgN4lEiMQdpCV1BpORCPis0Bwq1RYjQXlXH1gUA>
X-ME-Proxy-Cause: dmFkZTFOJeI8Tl/FBVX3wlT2dnscVCx7YoYiKwpnJy4hD3oIXtfgY/8GZnd6IH/OS8Evth
    LgQczB8QD7J1YRlCPTy8pwrNqrNEWze6j/6DFCVApwHihDf3wc5A8r3nIWRsRhn8N1njxn
    BsH1By+WBh3IK62cDXLNRjIuIzg8Ei0IrKioDpG+sBC99NbO00vK+cMVLr4JpcjwXtAppY
    sz2ZyAR1htrpW+AzKsB6RnRa0NV5sKl5WQZew65hPt+82BKxpEyrYp6JxKi8b2c9+Lk4dW
    yjujjI1krc2zVcyyZeauKQaLNWpu6IPIumMomZuvoOXoIZo8QApUsj7I6BiVNuRJgXQ7RA
    YIH/NehaQLU/QVYEFy40CkN4WCm4fVnv/Gy4kMv0Cq1lIXaHp8EEyujA6zCbulezWr0xjq
    5c1M0RPiaNyMc3CB+m1tcvTYQkD+sJgoPhVp3FphHharN2GiL/NPU7lRuB6HOhfkF4tlQ7
    i66DmRfJz3V9obEqgXVVsJAkfxoSNW8LKaKkFYnDBJYZyi0mxC3s6SpJ5g12dtoSFGdu6m
    JUMZyndxUKL7NBvMMsxEynDtXPuqo6CpQfAofYFs5LdTjn3iG3M9xP+BUz8goTGdn4oqDs
    A0Gp8gAwWBzQ5R7gjVe0UkVvBs7tHPeHD+67f811iVPLu2H/t8YST3PHcdig
X-ME-Proxy: <xmx:rKQragtJU6vY8HHP6QoTNQPr8bHVSLgLMFGk3yWFcdNMo21DJ47Mkw>
    <xmx:rKQrakV3mxASz0FlnqH8GeoBvUTiKu8Vhj8vVBape4bfNkCsMlZ7cg>
    <xmx:rKQraotHh5OgWxkWLq5UACVtuNrQCQwWSvRXmiVNYhnHnpgIlj1LnQ>
    <xmx:rKQragVi10bPzMAvwWPAWg72EN4EJR6p3r2HDBY0MH5F8_44UvzUgA>
    <xmx:rKQraq5rcDorWklYmFan3vUR4iYYj05rtrnz19j_Tdb6ZpNocmSMlfll>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 02:18:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4521db51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 06:18:19 +0000 (UTC)
Date: Fri, 12 Jun 2026 08:18:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/9] refs: stop using `chdir_notify_reparent()`
Message-ID: <aiukqI0Nj_RRn-wZ@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260611065346.GD2191159@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611065346.GD2191159@coredump.intra.peff.net>

On Thu, Jun 11, 2026 at 02:53:46AM -0400, Jeff King wrote:
> On Wed, Jun 10, 2026 at 04:57:06PM +0200, Patrick Steinhardt wrote:
> 
> > this patch series is a follow-up of the discussion at [1]. It converts
> > the reference backends to always use absolute paths internally, which
> > then allows us to drop the calls to `chdir_notify_reparent()`.
> 
> We added chdir-notify to suport set_work_tree(). Commit 8500e0de3f
> (set_work_tree: use chdir_notify, 2018-03-30) mentions an optimization
> from 044bbbcb63 (Make git_dir a path relative to work_tree in
> setup_work_tree(), 2008-06-19). That commit demonstrates some measurable
> speedup from using relative versus absolute paths.

Oh, that is context I wasn't aware of. Not much of a surprise though,
given that this is from 2008 :) So thanks a lot for the pointer!

> If we move to a world of all absolute paths where chdir-notify is not
> necessary, will we lose that optimization?

Probably. Unfortunately, the commit doesn't have any repeatable
benchmarks in there, so it's hard to say whether we could still
reproduce those issues or not.

> I'm not sure how much it matters in practice these days, or if those
> timings could be repeated. And they weren't all _that_ big to start
> with. I guess it may depend on how deep your repo is within your
> filesystem, too.

Ideally, we'd have the best of both worlds: absolute paths everywhere
without the performance hit. A while back I had a discussion with
Torvalds on the securiy mailing list around this issue, and ultimately
the conclusion was that the best way forward would be to use openat(3p).

This wouldn't only allow us to optimize cases like this, but it also has
the added benefit that we're much less prone to TOCTOU-style issues and
we might even be able to use flags like O_BENEATH. So it would basically
be win-win. The only problem is of course that Windows doesn't have
openat(3p), so we'd have to emulate it, and that's where I always lost
the desire to do this.

When waking up this morning though I had the thought that we shouldn't
try to emulate openat(3p) directly, but instead create a higher-level
interface.

    struct fsroot;

    /*
     * Open a new filesystem root at the given directory. All subsequent
     * calls to open will be relative to this fsroot.
     */
    struct fsroot *fsroot_new(const char *dir);

    /*
     * Create a new fsroot from a subdirectory relative to the given
     * root directory.
     */
    struct fsroot *fsroot_new_subdir(struct fsroot *r, const char *dir);

    /*
     * Open a new file relative to the given fsroot. This will use the
     * equivalent of O_BENEATH so that we only ever open files that are
     * located below the fsroot.
     */
    int fsroot_open(struct fsroot *r, const char *path, int oflag, ...);

This is of course heavily inspired by similar interfaces that exist in
Go [1]. By having such a higher-level abstraction it should also be way
easier to port this to different platforms, where we can then add safety
features like O_BENEATH when available on any given platform.

The idea here would be that we can then convert some subsystems to use
those structures instead of tracking paths. I'd for example love for the
repository's working tree to use this mechanism so that we can squash a
whole class of potential security issues when checking out files that
end in locations we didn't intend to.

Thanks!

Patrick

[1]: https://pkg.go.dev/io/fs#FS
