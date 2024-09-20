Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52192482CD
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841860; cv=none; b=hup20ExzCp0qQ50JJvutmLbSBn1EFsUEfN1Yr5yeBzGCb3Fj349l5fa9P/zAlx56kLbusPPOF0mL8r7vrvK7j/r529vCJ1LorlFqTvTdBPKFlElPeYkDapHzzAz2ralylwfYQwLbFFV+TvMgjS+vv7/6+g8dN9V+fWJR7l3KrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841860; c=relaxed/simple;
	bh=pumwYE2zGJiJJbi5LBpaerLMC6xnRvA6VMWazEkw0+E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD4IOUuarzRvu4YA8xaLASpNE33sUrlM7mbofZav8JVXtwykIZW6Nd639g0Z/fEacM9d+eWwN8ZUtokqlqw5fypMm+/h2x4l/LlAUp0nwgXA42oTE9E1dYbct+f/WVOUcQbMTNVcImgUHo3lE+BvRYr3AamR14Uuu2G7PCEycUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CQ+SDLlf; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CQ+SDLlf"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82ce1cd202cso102866139f.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726841857; x=1727446657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ajYSDEXgIWVNmqNqxsc8nMAMh6vw/NERYPwB1XOx6w=;
        b=CQ+SDLlfdK2KCU6y6s6nMs0nt0Cl0P0eIZgQ/zRABRUwL/kMrafzR766BzpFywtjPB
         QgQWE37S/UqOlqNfP6bGud9ddcLZj91todWejNRAbOtHMqVkZz5IFHuR2sHavmmSDFFd
         Ns7/ZCS9VuLOniPe/6xsfabYmbb34Yc452Y9S9Iow1fcDfgBbI0J1QAg3CVu3613biWN
         Z3c7PdgFTU70rhkmnCitxBcyxi82oAsDfgeuUH59FuYUuI9dvL6X4ry/UpoMVr+0w6pf
         B3S5d7CNI+UyyFjrDFgPJybVwe4NehpX6gxM985HsfLB88NnsuKDgyRBOIc7eW8ScEZZ
         UGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726841857; x=1727446657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ajYSDEXgIWVNmqNqxsc8nMAMh6vw/NERYPwB1XOx6w=;
        b=Rcd8dA9GVFpRHQ0GUuqlCFFpY5+eNMnKac8C7a8GsyI42isWd4bzRDkxgLZcwsWZ4Y
         k464FZakpwFta+4K7c1BS8oNnPdwJDKsQD8ivlptMEOsNSu69DOGvzUw04AjPd/JOeCz
         uCHZBvv6jVf4/BBjukrwPr/Hs31gCirSvMYeyY7VOZayj/z3GFQeoO1ZFlEYDu/nJODr
         7KoiP1P1Wq0cDdge8+5VEEnLuGEqRHDc1Hg1m9bZFZEQjcRrf9ZvwnDZ33KuinGsGm2X
         QnNb3a8a7RVPs07pQCQubIJyYPeZ7AOJCqB2j+6tmXkbaLznY0rway1vVsHjGLh+iDnR
         JE+Q==
X-Gm-Message-State: AOJu0Yyv2Lk0CO6rc727JVHmqUmMHfZ9EbUcoJW+s+ge/902ggjdgXOf
	Twoyl8f+ybzKNryriAFHWvo7wvT3qrif6IVPUJ95q2JiJM+xKAizgMn/AeiWKRMQzZlrdGgho60
	JP2y9NQ==
X-Google-Smtp-Source: AGHT+IGsTeMX4tutcC7B7hbD5ZlmHxdyf5gEo7GfDMXZlrz+1sBovKV0T9zySNt9YddJWR759qG5KA==
X-Received: by 2002:a05:6602:13c1:b0:82c:e4e1:2e99 with SMTP id ca18e2360f4ac-83209d69fc1mr338203339f.11.1726841856919;
        Fri, 20 Sep 2024 07:17:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf4633sm3624776173.4.2024.09.20.07.17.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:17:36 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:17:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 01/11] Rust
Message-ID: <Zu2D/b1ZJbTlC1ml@nand.local>
References: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zu2DmS30E0kKug2a@nand.local>

Rust
=====

(moderator: Kyle; notetaker: Taylor)

* Kyle: Rust code in the Git project; do we want it? Why would we want
  it?
* Elijah: Anybody other than Randall that objects to it?
* Peff: I don't object, but what does it mean for existing developers?
  Will non-Rust developers need to start learning?
* Emily: The avenue for introducing Rust is replacing low-level C
  libraries that are complicated and un-maintainable.
* Peff: What's low-level? Peff considers strbuf to be low-level, but
  Emily considers merge-ort.
* Kyle: Anything dealing with untrusted inputs would be a good spot to
  start.
* Patrick: Instead: take a system like reftables that is already
  self-contained.
* Jonathan: Another nice thing: if someone is on a platform without good
  Rust support, then they could stll use Git without reftables.
* brian: Rust is optional, can we add small new features and performance
  improvements that replace existing code, but it's not required.
* Emily: are we then carrying parallel versions of the same thing? What
  does that mean for the C version?
* Taylor: I don't want to double our vulnerable surface area.
* Patrick: Right, either you go all in or don't.
* Taylor: I don't want to give too much stock to a small number of
  people/platforms and hold the project hostage.
* Emily: old versions aren't going away.
* Patrick: Those could be maintenance releases.
* Do we need to support an older maint version in pure C
* Backport security fixes? Would issues be in both implementations?
* Do we want to encourage those without Rust support to maintain a
  friendly fork C version
* Johannes: Transpile C to Rust?
* Elijah: Does that presume we're not using Rust libraries, or are those
  transpile-targets as well.
* brian: We are going to have to use 'std', the question is what
  versions of Rust are we going to support? Can't be the latest version,
  since it only lives for six weeks.
* Taylor: vague idea of why we would want to use rust, but what are the
  concrete benefits of moving to rust?
   * brian: increased parallelization, can't write unsafe code,
     incremental parsing of objects. When it fails, you get a panic
     instead of a segfault.
   * Patrick: clear ownership semantics, was a huge problem with the
     memory leak work that they have been doing, it's not clear who owns
     what at what time.
   * Jonathan: 3 things; (a) user-facing benefit of memory safety, (b)
     productivity benefit to ourselves to have better architecture makes
     it easier to make changes, (c) would attract new contributors to
     the project.
   * Kyle: that's what I was going to say on (c), writing C is daunting.
   * Patrick: I'm in the opposite camp, I'm scared of Rust!
* Why not move over to the gitoxide project? Probably not realistic
  within the next 10 years, though Sebastian is doing great work.
* Taylor: great, what's the transition plan?
* Patrick: can't start until libification makes progress.
* Elijah: what about a low-enough level function that we can start with?
* Patrick: Still not work-able, there are too many global variables that
  we need to contend with.
* Taylor: IMO better to port to rust first from an implementation that
  we know, then libify in a language that has better support for
  refactoring.
* Jonathan: likes what Patrick was saying about having modularization
  make this easier. The other obstacle is that if we want to use any
  Rust at all, we need to have a POLICY on how we use Rust.
* brian: C shared library built in Rust, or top-level build with cargo?
* Have had experience with a previous C-to-rust migration! C FFI to call
  into Rust from C until everything is ported over.
* Patrick: modularization should be the first step, otherwise we're
  going to have the same architecture that we have now. If we inherit it
  now, it'll never get fixed.
* Mark: need Git to continue to be relevant in 10 years, making this
  kind of change is part of that
* Maintainability is something we can invest in.
* Emily: governance can help corporate contributors behave better. Say
  "your contributions have to meet this standard"
* Patrick: meanwhile I don't want to push away drive-by contributors
* Elijah: if someone wants to contribute a specific component in Rust,
  such as a replacement builtin, they need to call C, what happens to
  infrastructure such as option parsing?
* Emily: I really like the idea of starting with reftable
* Patrick: I was going to make a Rust implementation of reftable anyway
