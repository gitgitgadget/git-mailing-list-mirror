Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC951F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 03:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbdAZDVV (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 22:21:21 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:33792 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbdAZDVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 22:21:21 -0500
Received: by mail-ot0-f169.google.com with SMTP id f9so166906431otd.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 19:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammant-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=a5LTjKT9OOJg/rrKD9DOkiYiahUiNTkw1abQJD53h60=;
        b=BchGIACLyxxbm8iHy4lK6BNTX3iJcNvXU880Oe4t+EDLOUuOf2OEItpdsf4wF20BY/
         kzk1xtCjSxevACgw0o0p/IOKMVIYIMIQg66gj7MaQrsNehJ16O8i7iZKrq7CNziS0n1k
         TU2quk9fZ/ufRLC7pGVRW5rTYdyXTE0n5zqFBRzB4dhGG8PQF1MC6JtlbuxgURKnJ2ak
         OP1XHEw63u9CudIouyKZkpC2kTkli7IB8JIt216mgmtgieCof9fpJ5z8v6Q6jE3RpRfA
         2U//yu6Er0jz2BebRndn25LfbHqGBwdVF4yGrqeAtifx5qVwWqT7QUgefCMnxIQgV271
         uGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a5LTjKT9OOJg/rrKD9DOkiYiahUiNTkw1abQJD53h60=;
        b=PqfKX6HSE+XCgq4SAnfGPAcu3RMvEqyDh4PlFrOO34JNlTX4W/LKJ56yNaJux6UuPE
         ruXiH2RkPrcnyCC/p66L7g+tFAIfaf8cxN24Rxtny7khZLnpRpEJNuMTZkOYS9U7EwIg
         MSsbKwqXgQFjC6IqrAumIKNxUTtuz9T8Qc34fZeBpuR7tpglWfPIuB2erAZioWwCiM/A
         cOqlp+wj2PVBbK+WvxJy7KLXRRpOrOhNc9Wmt/yo303TRgyt5sGLmAzsi0GAAy1MFOD4
         n/K0g6O6hgQ1WBbiE4up+6jVTvBi0hzVFTbSQk8PS0SvMWZE/XuJsPfvOmSlYXMz+M+b
         BJMg==
X-Gm-Message-State: AIkVDXIEIU1gxv0O1BSbzZB5c7+JtAJNveYXMGr1NYWHkort4TmU+Jl0MTiHkgwL0I1scT/7aKQoeFKG+QB1bQ==
X-Received: by 10.157.63.211 with SMTP id i19mr275046ote.63.1485400880254;
 Wed, 25 Jan 2017 19:21:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.143.1 with HTTP; Wed, 25 Jan 2017 19:21:19 -0800 (PST)
X-Originating-IP: [65.78.25.171]
From:   Paul Hammant <paul@hammant.org>
Date:   Wed, 25 Jan 2017 22:21:19 -0500
Message-ID: <CA+298Ujx2wH2WnoYiOaWKoneBrF_E5VUXXSMqecGgNLYS0Wemg@mail.gmail.com>
Subject: Re: sparse checkout - weird behavior
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Related bug (maybe the same). Reproduction:

  $ git clone git@github.com:jekyll/jekyll.git --no-checkout
  Cloning into 'jekyll'...
  remote: Counting objects: 41331, done.
  remote: Compressing objects: 100% (5/5), done.
  remote: Total 41331 (delta 0), reused 0 (delta 0), pack-reused 41326
  Receiving objects: 100% (41331/41331), 11.91 MiB | 9.15 MiB/s, done.
  Resolving deltas: 100% (26530/26530), done.
  $ cd jekyll
  $ git config core.sparsecheckout true
  $ echo 'CONDUCT.markdown' > .git/info/sparse-checkout
  $ echo 'Gemfile' >> .git/info/sparse-checkout
  $ echo 'Rakefile' >> .git/info/sparse-checkout
  $ echo 'appveyor.yml' >> .git/info/sparse-checkout
  $ git checkout --
  Your branch is up-to-date with 'origin/master'.
  $ ls
  CONDUCT.markdown Gemfile Rakefile appveyor.yml lib

I was not expecting to see 'lib' in the resulting file list

I didn't say so before - I'm on a Mac, with a homebrew installed Git 2.11.0

- Paul
