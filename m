Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B2BC3567B
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6703220828
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgBXJUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:20:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46441 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgBXJUH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 04:20:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id g4so3090587wro.13
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 01:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nEyMToBR/ZkjJXtvOnBAzzg+6A4K9waFMGsu64uEwE=;
        b=QM7Ma/bBpeFW2hBIeBfP6evg4pXUt/vgz3hvZzVDnAmOj45Pe11ia+8MIqJdhXuzsL
         yeT/2HfqPiMC3UvXB5Wps3MHeUxCJtJenueu2crAk5hUZPlIMHxSOEtOSi3knvaDkZXy
         2R5nYepRZstzte4Y70FPs93HU3UHCUXE5qmBVundZMPhqQwxZ+d+HaXTH8r3M4y9uunk
         fU8rLp/FifdQLv3BR4PxW2gEc83z8gu6FlmeGgTYzonZyScQLOF9AYBxmwBVMPziq0b1
         AEuGbGz+oGn/5t08ILTLr2pNQbycTCDpC011gA9SLc/9ysRlVWbvzGUyYGRYIgaFZG7z
         HtxQ==
X-Gm-Message-State: APjAAAXDEbExfuRqNFiBmamok+rV93jYsgVE7moIHlLjN3IWK9Yloxbi
        +0a94aCQmg2JX2fFTKhFMfYjuoeoSJgFaZ5oxeAiXQ==
X-Google-Smtp-Source: APXvYqzLAdXJqC9OO6pbMZCuM3fK2NJ4MnIAakAvVJgP9FEM4mseBo+DBUP7r4RKWZwrMsJfscy9b2aKeGB/p2xguhM=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr69078356wrr.226.1582536005720;
 Mon, 24 Feb 2020 01:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20200220002932.5jws6qpnivlvxckw@glandium.org> <20200223101407.77036-1-sunshine@sunshineco.com>
 <20200223101407.77036-2-sunshine@sunshineco.com>
In-Reply-To: <20200223101407.77036-2-sunshine@sunshineco.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 24 Feb 2020 04:19:54 -0500
Message-ID: <CAPig+cQBSCius8a2eDsyOZb3-p8nd-aNqgECgxM9+iTmBSGW5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] t3400: make test clean up after itself
To:     Git List <git@vger.kernel.org>
Cc:     Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 23, 2020 at 5:15 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> This test intentionally creates a file which causes rebase to fail, thus
> it is important that this file be deleted before subsequent tests are
> run which are not expecting such a failure. In the past, the common way
> to ensure cleanup (regardless of whether the test succeeded or failed)
> was either for the next test to perform the previous test's cleanup as
> its first step or to do the cleanup at global scope outside of any
> tests. With the introduction of 'test_when_finished', however, tests can
> be responsible for their own cleanup. Therefore, update this test to
> clean up after itself.
>
> A bit of history: This 'rm' invocation was moved from within the body of
> the following test to global scope by bffd750adf (rebase: improve error
> message when upstream argument is missing, 2010-05-31), which postdates,
> by about a month, introduction of 'test_when_finished' in 3bf7886705
> (test-lib: Let tests specify commands to be run at end of test,
> 2010-05-02).
> ---

Missing sign-off, so here it is:

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
