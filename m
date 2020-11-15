Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB3C2D0E4
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D71223C7
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnYDr2Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgKOVN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Nov 2020 16:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKOVN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Nov 2020 16:13:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57DFC0613CF
        for <git@vger.kernel.org>; Sun, 15 Nov 2020 13:13:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p8so16657561wrx.5
        for <git@vger.kernel.org>; Sun, 15 Nov 2020 13:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zA40jQNFeox3/WUBt07J/53vMhROlRYJgwf3OtImLso=;
        b=YnYDr2AdpCrCpCv3rNaBxmk4WXT8zoKEkcUC7eFbdSu7hNxa7b/HmfD5h9diuiRW3w
         Ca0jFBuAY0p45uzJ2tEJ3u8nK2b0AeLVOMJIKiCUw8YG/WdFiYtx8NV00SsDRcPiM/8N
         6YBwKLKhPhDR0tU5q3J1xooYMTgZPtFL9hz0mlIAVcBPS/A7Jgl/B9xj1MGPTiusngyl
         R0t600WoHfL/GbrAbfgNss16ctAfcTgYGQPQNTaVr0gNpo0/f4q4FnjYMcM33YVN7AUd
         x2Vs/GccB0OtqJZX3xqIQgoVToqV+UwFxLtsnJe+MYgvwJh9ejgCSOULK1nW4PAVvwFg
         MJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zA40jQNFeox3/WUBt07J/53vMhROlRYJgwf3OtImLso=;
        b=QIempqZTAtSJ2jNNsd/BGAQdfgeVAKug/vfAONwSUN7089GspUA2oLySWFKZtKysyL
         So25/0VOo+X52GGhN9Wely8EkImPCGMjSN4VOV5T6zfJ+F5MDt6VXw6YAqHFzkTNCcPs
         /3DAOJ8/UrhWFiaSPDC4KD+K0SrxyfKWVzZC9EJLDGrh4Hq2HoZd7UV/OMU7AfacD3Aq
         Bpwr9DV+peqLBPsVcsQkj8TkKAEkimBnx2tC4UEd3XMo0xZGTbhCCuDiBPx4pNEUFyGB
         +uvFZGkgZSmJBggi9L9nluEFkWJnqcbz4V23lkw1HCTRcdJZUjfe3ZqiEaTOVZAtcg3O
         JVyg==
X-Gm-Message-State: AOAM531Njht2K/dLfSwv/hY/ZyAcD+tdbi9AYPmcjH/B+vePFLsoqJtn
        B5kNW7k8uw5MLQQ6PHalySOgLsWl8C0=
X-Google-Smtp-Source: ABdhPJyLkZWYFnWPuKu+Tz5EbAFaH5LjXriEVkJ3Q4Wsd3R804tM0B0k+qkyWQvJ+98vj9R/3ouQHw==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr15975669wrb.228.1605474837212;
        Sun, 15 Nov 2020 13:13:57 -0800 (PST)
Received: from szeder.dev (94-21-58-64.pool.digikabel.hu. [94.21.58.64])
        by smtp.gmail.com with ESMTPSA id h81sm17678831wmf.44.2020.11.15.13.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Nov 2020 13:13:56 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:13:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
Message-ID: <20201115211354.GB8033@szeder.dev>
References: <20201113215307.20855-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113215307.20855-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 10:53:07PM +0100, SZEDER Gábor wrote:
> In 't5310-pack-bitmaps.sh' two tests make sure that our pack bitmaps
> are compatible with JGit's bitmaps.  Alas, not even the most recent
> JGit version (5.9.0.202009080501-r) supports SHA256 yet, so when this
> test script is run with GIT_TEST_DEFAULT_HASH=sha256 on a setup with
> JGit installed in PATH, then these two tests fail.

So both of those tests invoke 'jgit gc' which fails with the same
error message in both cases:

  + jgit gc
  fatal: Invalid id: 93b89bd36289ec88dd9db249a48da3e7440e46b94d3a93d98540062bec0e5ac1

This is clearly related to SHA256 (though I think JGit shouldn't even
get as far as looking at object IDs, but should have errored out upon
seeing the unsupported extensions.objectformat=sha256 in the config,
and it's alarming that it didn't).

Now, we do have one more JGit test: "indicate no refs in
standards-compliant empty remote" in 't5512-ls-remote.sh', which fails
with SHA256 as well... but the failure comes from 'git ls-remote':

  + test_expect_code 2 git ls-remote --exit-code git://localhost:5512/empty.git
  fatal: protocol error: unexpected capabilities^{}
  test_expect_code: command exited with 128, we wanted 2 git ls-remote --exit-code git://localhost:5512/empty.git

This doesn't at all look like an error related to SHA256, but I'm not
up to speed with SHA256-specific protocol stuff...  so I'm hesitant to
simply protect this test with the SHA1 prereq as well.

