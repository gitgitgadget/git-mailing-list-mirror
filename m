Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F67E784BC
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbjJBPTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbjJBPTN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:19:13 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED990
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:19:09 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dd54aca17cso6493591fac.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696259948; x=1696864748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5MBbXvpzTDtB9hvYDgpPkucBYZhPHCEHBnkU8JgzPs=;
        b=wPnvA7ZUFyVCVz0eL1rr683LMMKYA5HGECdnku96kRC0IP5UmIRvLBvx7h4gC10Oj6
         XZyzfgEy11p0LvLyO0dgHyrYIRI+RURz4uGPF7sHusJoNUb2snqOXKl6jYRXqkLGUziS
         2z518PA+4OHvyQyBU5DkmI1Ea7LautAL9SB6ZYFW7ijptbKMwMWB2nIBrdUB6zwOu0F9
         2NtxIDmtviJj48JW2V7AuiQU1JnvexWbofq02XRmY/h9mj2XO41+agMxQEexUylGPYn5
         +dDA+MJFFj4PxUpUunaoeO4sH8PzebREv3IURbSzemsdL8byFGonwJ9wDopy7OtEhTbH
         /W1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259948; x=1696864748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5MBbXvpzTDtB9hvYDgpPkucBYZhPHCEHBnkU8JgzPs=;
        b=ePkh3j/ZWW6Bcx6beKsJ0HIsjsN+J7YmyijlOQnNz87Aa0S75QHiWpXERt3iSrktX2
         ms6Y9fEknmGVFRgNKulOndQ58tGFAN4P3uebLRq3Zoqkkxd3maaTbMXb0ujCR1DSsO8a
         cDyT4/ypmfE8BlCShu5VCeE6MsEeMQ4k5xeLCBdJQawrR1U0vqbWnSneNWSZuTsbQ/Gm
         xN1p8pelsmDqwpAPW/plllKc6Z0VdG+0f69PQS1+7wblYReDMk8zA/f94yRD8iG9K+Xh
         zyd+IlLGSP9BsWUNibHNum48cIAg6p4Zp0RYnsy7y2gCsq7fBs+MpL4sFupPMR1YZMWg
         KbJg==
X-Gm-Message-State: AOJu0YyGD+9JqxHFDn1kYeojiiE9l4RJeZmxhKnSC3vvPVjA/3Ku2Fma
        fWAGoCZHDtqyshFFjWr4x53lq2c432F1fYAGc3rQWg==
X-Google-Smtp-Source: AGHT+IFn2i9AtfeGjSip5jzwIflq4gnw+CU25RWRwXqIaikfKXEnYIz9nYfk3/hfoO+pZiwwUhDpjA==
X-Received: by 2002:a05:6358:261a:b0:139:9fc3:eade with SMTP id l26-20020a056358261a00b001399fc3eademr15239299rwc.29.1696259948123;
        Mon, 02 Oct 2023 08:19:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x14-20020ac8538e000000b0040331f93ee0sm5037185qtp.77.2023.10.02.08.19.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:19:07 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:19:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 4/12] Scaling Git from a forge's perspective
Message-ID: <ZRrfamSepdiQU9CH@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Taylor Blau, Notetaker: Karthik Nayak)

* Things on my mind!
* There's been a bunch of work from the forges over the last few years -
  bitmaps, commit-graphs. etc.
* Q: What should we do next? Curious to hear from everyone. Including Keanen's
  team
* Boundary-based bitmap traversals, already spoke about it last year. If you
  have lots of tips that you're excluding from the rev-list query. Backlog to
  check the perf of this.
   * Patrick: still not activated it on production. Faced some issues the last
     time it was activated. We do plan to experiment with this
     (https://gitlab.com/gitlab-org/gitaly/-/issues/5537)
   * Taylor: Curious of the impact.
   * In almost all cases they perform better, in some equal and very few worse.
* (Jonathan Nieder) Two open-ended questions:
   * Different forges run into the same problems. Maybe its worth comparing
     notes. Do we have a good way to do this. In Git discord there is a server
     operator channel, but only two messages.
      * Taylor and Patrick have conversations over this via email exchange.
      * Keanen: Used to have a quarterly meeting. Attendance is low.
      * From an opportunistic perspective, when people want to do this,
        currently seems like 1:1 conversations take place, but there hasn't been
        a wider-group forum
      * Server operator monthly might be fun to revive
      * Git contributor summit is where this generally happens. :)
   * At the last Git Merge there was a talk by Stolee about Git as a database
     and how as a user that can guide you in scaling. Potential roadmap for how
     a git server could do some of that automatically. Potential idea? For
     example, sharding by time? Like gc automatically generating a pack to serve
     shallow clones for recent history.
      * Extending cruft-pack implementation to more organically have a threshold
        on the number of bytes. The current scheme of rewriting the entire
        cruft-pack might not be the best for big repos.
      * Patrick: We currently have such a mechanism for geometric repacking.
* (Taylor Blau) Geometric repacking was done a number of years ago, to more
  gradually compress the repository from many to few packfiles. We still have
  periodic cases where the repository is reduced to 2 packs, one cruft and one
  of the objects. If you had some set of packs which contained disjoint objects
  (no duplicates), could we extend the verbatim packs to work with these
  multiple packs. Anyone had similar issues?
   * Jonathan: One problem is whether to know if a pack has a non-redundant
     reachable object or not without worrying about things like TTL. In git,
     there is "push quarantine" code, if the hook rejects it, it doesn't get
     added to the repo. In JGit there is nothing similar yet, so someone could
     push a bunch of objects, which get stored even though they're rejected by a
     pre-receive hook. Which could end up with packs with unreachable objects.
     With history rewriting we also run into complexity about knowing what packs
     are "live".
      * Patrick: Deterministically pruning objects from the repository is hard
        to solve. In GitLab it's a problem where replicas of the repository
        contain objects which probably need to be deleted.
      * Jeff H: Can we have a classification of refs which makes classification
        possible wherein some refs are transient and some are long term.
         * Jeff King: There are a bunch of heuristic inputs which can help with
           this. Like how older objects have lesser chance of change vs newer.
         * Taylor: Order by recency, so older ones are in one bitmap and newer
           changeable ones could be one clump of bitmaps.
* Minh: I have a question about Taylor's proposal of a single pack composed of
  multiple disjoint packs. Midx can notice duplicate objects. Does that help
  with knowing what can be streamed through?
   * Taylor: The pack reuse code is a bit too naive at this point, but
     conceptually this would work. We already have tools for working with packs
     like this. But this does give more flexibility.
* Taylor: GitHub recently switched to merge-ort for test merges, tremendous
  improvements, but sometimes creates a bunch of loose objects. Option to have
  merge-ort to side step loose objects (write to fast-import or write a pack
  directly)?
   * Things slow down when writing to the filesystem so much.
   * Jonathan Tan: one thing we've discussed is having support in git for a pack
     handle representing a still-open pack file that you can append to and read
     from in the context of an operation.
   * Dscho: that sounds like the sanest thing to do. There's a robust invariant
     of needing an idx for the pack file that you need for working with it
     efficiently, which requires the pack file to be closed. So some things to
     figure out there, I'm interested to follow it.
   * Junio: There was a patch sent to list to restrict the streaming interface.
     I wonder if that moves in the opposite direction of what we're describing
   * brian: In sha256 work I noticed it only currently works on blobs. But I
     don't think adapting it to other object types would be a major departure.
     As long as we don't make the interop harder, I don't see a big problem with
     doing that. Conversion happens at the pack-indexing time.
   * Elijah: Did I understand correctly that this produces a lot of cruft
     objects?
   * Dscho: Yes. We perform test merges and then no ref points to them.
   * Elijah: Nice. "git log --remerge-diff" similarly produces objects that
     don't need to be stored when it performs test merges; that code path is
     careful not to commit them to the object store. You might be able to reuse
     some of that code.
   * Dscho: Thanks! I'll take a look.
