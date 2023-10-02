Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE111E784BC
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbjJBPSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjJBPSV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:18:21 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC9890
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:18:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-775751c35d4so444863985a.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696259897; x=1696864697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4+NqDhYENhwOFIbEgT/1MF/7FsFILsFIiYrFtYUYNk=;
        b=2JQ6KsrG2eHIEK44/EX5lWwkxJePp8JAVNYckX5JyIgVEX1L52L9LslHfZgvbhbns7
         1Fn19GyABG6cCAxPG1iL6ZdPNRH9Tp++1yRB/pietxygP9ycrrWbEF1lS/2MYcBRN+yv
         uFzltNBHbuHgP8EKFWerwxQ4rCgxM7sAhaWZtxNCZMLBf1ax8vPN0MPybd7v54SIh9Fb
         NjPca4+rGDglJuxzdTGDu0CCbI2x7+3tGuY5bdysUcqhSQ01jlUnCDD/zBfdTggoQS+5
         azeVsFyP37H3PpigP42MuNhuYxL09M8Kab0SVScpZ3HS5C1Nz+W4pq9Zj+WsMRk98Dag
         herg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259897; x=1696864697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4+NqDhYENhwOFIbEgT/1MF/7FsFILsFIiYrFtYUYNk=;
        b=cz3gNuuCuH/HW7eDa0HwHT+ZiC37gD9KtVcwyYGk0lozcoN83IeFjiRaOO4XkQFaAf
         bXtWqNgaTo+GI/YkV5n6+68GxoDRwpu7l4EFiIMG3IdwnAxkwRm9IOGgBF2sH3aLOOeo
         YaZ0WXFW/TNWWiWrVaqKDqgpSLVr5OH6H8XY0Ct78P7b810FoZPIKwuQChUAZf2Yv6ua
         a15qrV4GP9JcBXqthmAMGUoI5ANfpO7amqC3rBOpwCw5rMVLuGXoNIEoYUuw/68qthAy
         be8CR3NXo3HyIPnHhIfvcO6gOYO2ET7RF3OdmDpSuYWbMJoy3potDda5P87eAhk1F1JZ
         R/vA==
X-Gm-Message-State: AOJu0YyfhEi8CK4BPyV0Ddah9+A7OrXzHk1gJ4qLq3ki31spRz32GLCf
        L2m2Uj1NCRYVl7YwMh1zHG4B+9z2vLswEbv6aRbM/g==
X-Google-Smtp-Source: AGHT+IEIDqcfpJu0OB5v3bbiDOnOw6rfaNR9zqJ2GQn0wd1/lUhrirDIAM/xS/FF4Qgra0hVlZVXmg==
X-Received: by 2002:a05:620a:2551:b0:770:df33:58af with SMTP id s17-20020a05620a255100b00770df3358afmr12551903qko.62.1696259896811;
        Mon, 02 Oct 2023 08:18:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a16cd00b0076cbcf8ad3bsm6968649qkn.55.2023.10.02.08.18.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:18:16 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:18:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 02/12] Libification Goals and Progress
Message-ID: <ZRrfN2lbg14IOLiK@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Emily Shaffer, Notetaker: Taylor Blau)

* The effort is to isolate some parts of Git into smaller, independently
  buildable libraries. Can unit test it, swap out implementations, etc.
* Calvin Wan has been working on extracting a common set of interfaces, refining
  the types, etc. This is in pursuit of a "standard library" implementation for
  Git. Close to being shippable.
* Josh Steadmon spent some time in the second half of the year suggesting a unit
  testing framework in order to test the library interfaces beyond our standard
  shell tests.
* Goals:
   * Google has a couple of ways to proceed with their libification effort.
     Community input is solicited:
      * Interfaces for VFS / callable by IDE integration to avoid shelling out
      * Target libification for the sake of Git itself. Code clean-up, making
        the code more predictable / testable. Example being submodules, which
        are messy and difficult to reason about. References backend, etc.
* Is there an appetite for libification? Some particular component that would
  especially benefit from clean-up, being made more test-able, hot-swappable,
  etc.
* (From Emily's comment above) If others are implementing the basic references
  backend via a different implementation, how do we make sure that we are
  building compatible parts? Goal would be to have Git's unit tests pass against
  a different API.
* (Patrick Steinhardt) For reference backends especially: would like to be able
  to split between "policy" and "mechanism". This would avoid the issue
  discussed in the last session where different e.g. refs backend
  implementations have different behavior.
   * Emily: white-box tests for the API to make sure that different
     implementations meet the policy
* (Jonathan Nieder) For reference backends in particular, the current
  implementation has an odd "layering" scheme - packed-refs today is an
  incomplete backend using the same interface as the complete "loose and packed
  refs" backend, serves as a mechanism without fulfilling the policy
  requirements. The approach above seems like a positive change.
* (Emily) Are also looking into a similar project around the object store, but
  have found that it is deeply intertwined throughout the rest of the code base.
  Difficult to reason about, even without a library interface. Can we make any
  given change safely?
   * Hunch is that it is still useful to target that sort of thing, even if
     there aren't clear boundaries.
   * In the interim, can still be part of the same compilation unit, just
     creating a clearer boundary.
* (Emily) For hosting providers and others building things on top of git, are
  there parts of git functionality that you'd like to have libified so you can
  get benefits without having to wait for feature lag?
* (brian) not interested in using Git as a library in GitHub's codebase because
  of license incompatibility. Would like to experiment with different algorithms
  for packing and delta-fication in Rust as a highly parallel system. Would be
  nice to be able to swap out something that is C-compatible. Have been able to
  make changes in libgit2 while causing libgit2 to segfault, doesn't want to
  write more segfaults.
* (Taylor) There's an effort going on in GitHub to reduce our dependency on
  libgit2, precisely for the feature lag reason Emily mentions. I don't think
  we're planning on using it as a library soon, but we rely on the Git
  command-line interface through fork/exec
* (Emily) Is licensing the only obstacle to using Git as a library, or are there
  other practical concerns?
* (Jeff Hostetler) Pulled libgit2-sharp out of Visual Studio. Issues with
  crashing, but also running into classical issues with large repositories.
  Memory consumption was a real issue at the time. Safer to have memory
  segmented across multiple processes so that processes can't touch other
  processes memory space.
* (Emily) Interesting: thinks that performance overhead would outweigh the
  memory issues.
* (Patrick) To reiterate from GitLab's point of view: we are in the same boat as
  Microsoft and GitHub. Have used libgit2 extensively in the past, but was able
  to drop support last month. No plans to use Git as a library in the future.
  Having a process boundary is useful, avoids memory leaks, bugs in Git spilling
  out to GitLab. Still have an "upstream-first" policy. Benefits everybody by
  spreading the maintenance burden and ensuring that others can benefit from
  such functionality.
* (Emily) If we had the capacity to write portions of Git's code in Rust (memory
  safety, performance, use it as a library), would we want to use it?
   * (Junio) I notice in the participant list people like Randall who work on
     NonStop. I'd worry about the effect on minority stakeholders, portability.
   * (Junio) Not fundamentally opposed to the direction.
* (Elijah) did not parallelize the C implementation of the new ORT backend.
  Wanted to rewrite it in Rust, cleaned up headers as a side-effect, and looked
  at other bits. Merge backends are already pluggable, could have a "normal" one
  in addition to a Rust backend.
* (Emily) If we already have something in C that establishes an existing API
  boundary, that makes it more tenable to rewrite it in Rust. Could say that the
  C version is deprecated and make future changes to Rust.
* (brian) Thinks they would be in favor of that; is personally happy to say that
  operating systems need to accept support for bottom languages eventually. All
  of the main Debian architectures in use have Rust ports. They are portable to
  all of the main architectures. Would make it easier to do unit testing. Could
  add parallelization and optimization without worrying about race conditions,
  which would be a benefit. Is happy to implement unit tests with Rust's nicer
  ecosystem.
* (Taylor) Is it just NonStop?
* (Elijah) Randall mentioned that they have a contractual agreement that is
  supposed to expire at some point
  (https://lore.kernel.org/git/004601d8ed6b$13a2f580$3ae8e080$@nexbridge.com/).
  Could we have a transition plan that:
   * Keeps NonStop users happy until their contract expires.
   * Allows the rest of us to get up to speed with Rust.
* (Jonathan Nieder) doing this in a "self-contained module" mode with fallback C
  implementation gives us the opportunity to back out in the future (at least in
  the early periods while we're still learning).
* (Jonathan Tan) back to process isolation: is the short lifetime of the process
  important?
* (Taylor Blau) seems like an impossible goal to be able to do multi-command
  executions in a single process, the code is just not designed for it.
* (Junio) is anybody using the `git cat-file --batch-command` mode that switches
  between batch and batch-check.
* (Patrick Steinhardt) they are longer lived, but only "middle" long-lived.
  GitLab limits the maximum runtime, on the order of ~minutes, at which point
  they are reaped.
* (Taylor Blau) lots of issues besides memory leaks that would become an issue
* (Jeff Hostetler) would be nice to keep memory-hungry components pinned across
  multiple command-equivalents.
* (Taylor Blau): same issue as reading configuration.
