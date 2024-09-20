Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CE17838C
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841910; cv=none; b=NXpe2WCG0yuVKGSHnM4bvWPdxAZNjLhvPD1YpRfHT33Ea3VT/MHOKAKn3lMO94mSFJfJkcDY/jRqMhZSJmpbbyzDrkIDQ118qLh12FbzmsLqgIYRzziPji8LfYkBJswrCrxH0SEi/oPgIgDwH8bbiFcnVxnmWjwcgoMGo63kZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841910; c=relaxed/simple;
	bh=eUosnGjdObaj/IRpLwjoJFARBEBR5+XemILsOgKOBE0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4KMJKQRnRiltlDbj8jI52Dza5J8glQfWJIXo6atL4sPLmlHccl8F4g87yRTmZvj+lRVPWr0nz83x0+nq4QkmnLO4nYFwcJ46QBhtJNyyYI4JwNie5/8K8/F+irlVw1WZCd/D1GfyCAC+B99NxWTIGIpNe9lAYwJQ55MP1ZCAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VAIcwIZm; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VAIcwIZm"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-831e62bfa98so110441839f.1
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726841908; x=1727446708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnAmUvSoaWorIEl8ASgzvxWZCEFquC7ESej14YA6blk=;
        b=VAIcwIZmDQKyu6+WpT61bpPWeicLX6z7lmThOu5h/X+gub3gLfitzTtCzAQVnv0iKB
         jZ5Hr3Q3pzrhcHFb5jP/Ez23uAvKGv1gFCWiUSwEI+yzTZiOgwmdsY5T+GubBU8zx8cH
         uIzYHa6X8FkLsQXKvr38nasFeGrBfkcVFBi4BzbpdM8xjiuDbJrxL3mi6+zSFzSIBLBE
         Y/YYrWl307V1LUuaXlRwMwRpP301BxfJvAZP9m86gpUN08FnKmUODZkcAUJvKqICl4tO
         84id6rlWdpS8Ik2H90FTGHlymZDYWaYpDvEZk11O7MgkKsZshkEj6UjB1PPuL1E7V2Ri
         WqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726841908; x=1727446708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnAmUvSoaWorIEl8ASgzvxWZCEFquC7ESej14YA6blk=;
        b=WT3ocG7hEwarrf+UNLsrkse6MB0codZ/1YGpQye2tkrzg7LSKnvdQ1YFGjap/jhyBi
         amtkYztlKQhY4EBUCOK1CC9zqi/XIpt4DF8JI0kb+ENtzRSfZLXjjgWKvQo65JOGZzlL
         02TYa35ojmCJcfdO4+b0QBSfxR1Byw9c6XgTXuJsNRlq662tfjZls4T6DnHfbl8B+8+P
         7SDIJXPUbmZi3StP3qi4UrI04rGbxhkWll337KmaaK/10C/KrSlY2CR9GOdOSJmrewer
         us1lc3dhlt4snZRSXLahGUmsCYOBiH5GfaH1PTj+DMDBPq+UC3rWXWQUqguvbj7QZREY
         pzJQ==
X-Gm-Message-State: AOJu0Yz5vaHp0gbt8oSuAq8qjyoCpfQ0j4PqFIzCLCsi0DTHXVo2Ic7P
	D8lmxmRuukpZUEGODRXG+Yyo4k8+cE7dRoW58fZDWSUmlRs9307I2b5vqaSjJDTZCUCqW1k9uv/
	FcSalsA==
X-Google-Smtp-Source: AGHT+IG4MrCjfPW/BsXTdUrxSSRFeGSEY9KZrU/GjQX4rOUbTb/k64WQcf71a5nTORjd/GoMAHHwAg==
X-Received: by 2002:a05:6602:6186:b0:832:123:c470 with SMTP id ca18e2360f4ac-83209e8da51mr236811039f.15.1726841907670;
        Fri, 20 Sep 2024 07:18:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-831e9697887sm189039139f.1.2024.09.20.07.18.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:18:27 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:18:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 03/11] Structured Error Handling
Message-ID: <Zu2EMKMmNhugAcbY@nand.local>
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

Structured Error Handling
=========================

(moderator: brian, notetaker: jrnieder)

* brian: idea for structured error handling!
   * Very little needed - pointer to error string, uint64_t error code,
     and ??  (third thing I didn't hear). Return it on the stack. Rust
     does this kind of thing all the time.
   * Having that structured return value lets a caller decide what to do
     with it
     - print a message, decide whether to exit or recover, etc.
* Patrick: a few requirements
   * want to attach arbitrary metadata to an error (e.g. "I had a
     conflict between that file and that file for this revision").
     Especially useful on the server side.
   * avoid having to parse error messages. Gitaly runs into this. Can
     imagine setting an envvar to get json or some other parsable format
     instead of human-consumable error messages.
* brian: sounds doable. GitHub also has the same hassle with parsing
  error messages.
* Peff: in your proposal, low-level code produces the error struct which
  is consumed at a higher level. Sometimes, though, you have many errors
  that are related.
   * "I couldn't merge these files because I couldn't open this file,
     because of this errno".
* One thing we've considered is having a callback to decide what to do
   * - print the error, collect into a tree of errors, etc.
   * The point is to keep what's happening in the generators of errors
     as simple as possible - I have this type of error and maybe some
     kind of context strings. That context could be owned by the caller,
     the callee can be responsible for copying it, etc. Inversion of
     control.
* Patrick: I like the way Go does things, can wrap errors or append
  messages, return up the stack until someone handles the error. Why are
  we afraid of allocations?
   * Peff: What do you do when the allocation fails?
   * Patrick: can handle allocation failure by having a special error
     that has a statically allocated string.
   * Peff: sounds good, getting rid of die() on alloc failure is okay
   * brian: Rust panics on out-of-memory anyway
   * Peff: there are two different cases - small allocations are "you're
     in trouble anyway", big allocation of user-supplied length is
     something else
   * Carlos: Rust has a "try to allocate memory", relatively new
* Calvin: how do you propagate up the call stack?
   * Peff: in my proposal, every function would take an error context
     struct, call the callback when there's an error, and keep the
     integer function returns. In brian's proposal, we instead return
     the struct.
   * Emily: Are we comfortable with the amount of churn that generates
     in the codebase?
   * Patrick: my inspiration is Subversion in that respect. It has nice
     error handling in C, they're a role model for me in how to do a
     library. It has nice error types that aren't a hassle to use.
   * J6t: if you compile in C++ and use exceptions, the problem has been
     solved 25 years ago.
   * brian: allocating strings for errors and then freeing them is a
     hassle in C. Versus Rust where that's handled automatically.
   * Emily: so it sounds like this is temporary pain
* Jonathan: I like Patrick's description of requirements. One thing that
  would make me more comfortable with the churn is when we get benefit
  even from partial conversion
   * E.g. could say we get structured error messages for the call sites
     that have been converted and not from others. And when I go on a
     debugging quest and wish I had a machine-readable structured error
     message, I can send a patch to convert more call sites
   * Peff: Refs code uses its own strbuf based error handling which is
     worse in every way than the options we've been discussing. :) That
     can be a good playground to try things out.
   * Patrick: +1, seems like a good place to start.
