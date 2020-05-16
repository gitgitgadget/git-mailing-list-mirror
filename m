Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A07C433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 02:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384D62073E
	for <git@archiver.kernel.org>; Sat, 16 May 2020 02:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKqGuRDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEPCVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgEPCVz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 22:21:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A07C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 19:21:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ms17so1825408pjb.0
        for <git@vger.kernel.org>; Fri, 15 May 2020 19:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GhJsKKxhbOrRjg3POfvAyBH7c4w7CkaVznqmX0/OnPc=;
        b=DKqGuRDKYos/QZmPZ4mvFj4nWknL5Qso2CjXra47mQdTIzfnD3rC12ICJTHebWlvjA
         aJFy9P4ObrxsyGnlwfQ3AE3dfkMKaPXK9sIdAkzxKjZyBeUN/mktYugfsq/hzJbD9Dhk
         lCcJwtt0Am7N1dlHzwUwKHFCV4Mh4xAIj2BTB5JPf+sjWtVmcd1v7nDLrGfBeZa3hsK+
         h5Y8vf+wvz/UlztBDLmQGAg3k0hXxLfvP9X0hLZdppliQRdu3yHMUFMVCz6TGTmyjbdE
         M6GX9rOYfJ5BHgoLQz/rUvMfKhL1OjfjGFTiFhqbGjeJirZCUDLqwkAzSvmqthdk4BlZ
         b3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GhJsKKxhbOrRjg3POfvAyBH7c4w7CkaVznqmX0/OnPc=;
        b=F0BC8dZfBMKkEm4IWyJl3aZeadvrQ41O9xzA+BaCNX8dgeY4elMJKXFNRZAMHH5DRW
         DZnkbJnZ9JabXTwG5NR4XYJFX0gdhYqK4JzrqTuaxmbzXekBLyYtY5nzDGXKK+o/Sc9K
         SxDB0myTtzuFiTgpcftyy20BU6KJ7Z0Fmhp1XdcZp7yCxcoFKFpqylsYc813YNMmdukm
         kqSd/2AqsmB6YkxnmC3ea2LF3I/WQdZ9q2+IjPr7++uZg4t7e1fWdYo50cnP1nhy9x+a
         6vLH7Ye7mv8JRrfRIWbg7Ey28iUA4IJoRPBOj9axlbKZMcskLXairWwtYTn5MFY4ODIa
         /8Lw==
X-Gm-Message-State: AOAM531Uz8Iy5l3ZFqji2Z1tKrvhKP7pY2OLLJ9xQvbX4e8dm6qEVNyx
        bllU8IgmYGl6zKzQ1wlmPYO4cFzqrQw=
X-Google-Smtp-Source: ABdhPJwQ+8y3SDEGMmWQNWku6G8gUwACbU2VtR2aDXgEl+f042J17HnhjSKdIw3/zLJbhExXFAoLHw==
X-Received: by 2002:a17:902:7446:: with SMTP id e6mr3720949plt.178.1589595713990;
        Fri, 15 May 2020 19:21:53 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-241-206-39.socal.res.rr.com. [23.241.206.39])
        by smtp.gmail.com with ESMTPSA id cx11sm2555891pjb.36.2020.05.15.19.21.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 19:21:53 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org
Subject: Re: [TOPIC 3/17] Obliterate
Date:   Fri, 15 May 2020 19:21:48 -0700
Message-Id: <20200516022148.20863-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <5cab1530-f8b6-cef3-7b93-48fad410a160@iee.email>
References: <5cab1530-f8b6-cef3-7b93-48fad410a160@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Hi guys,

Sorry I missed you at the contributor summit, but this is an idea I've been
thinking of on my own for some time now, mostly in the context of dealing with
large files as opposed to security issues. I've come to a lot of the same
conclusions that this group has already come up with, namely

* Using git replace functionality is a very obvious apth forward here

* A list of 'revoked' (could I propose the word 'obliterated', in order to make
  the names consistent?) hashes needs to be maintained so that any
  functionality expecting the original object can figure out that it's not
  available.

* This needs support from GitHub, Gitlab, etc. in order for it to work. I'm
  thinking that git prune gets updated to remove 'oblierated' objects, and
  when a git hosting service receives an updated list of obliterated objects,
  it just runs prune. Of course, there would need to be support for replace
  refs as well

I've started working on a prototype/proof of concept. In the v1 it will do the
following upon receiving a hash (i.e. git obliterate abc123):

* Add it to the list of obliterated objects (I'm thinking just .git/obliterate,
  any issues with that?)

* Create a new blob containing the content "This file was obliterated by
  $git.user on $today" and create a replace ref from the provided has to the
  hash of this new blob (so instead of an empty file, there's some info as to
  why the file is missing)

* Run git prune (which will be modified to delete obliterated objects)

It should just take a couple of days. If anyone is interested in joining, I'm
livestreaming my work on twitch at https://www.twitch.tv/actinium226 from 1pm
to 5pm Pacific time on weekdays. This version will still have some issues. As
Damien pointed out, index doesn't handle replace, so the file will look
modified, but I hope that having an initial prototype will help further
discussion and get this feature closer to a state of being completed.
