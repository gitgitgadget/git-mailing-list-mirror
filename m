Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82063C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3EB60C40
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhJKUA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhJKUAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:00:25 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F8C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:58:25 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u16-20020a056a00099000b0044d25b2f807so1508243pfg.12
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h3wvex0q9y1/BA10IiAwwNQZNAyXYf6ppjX9GR7oem4=;
        b=i8x1+4+ZG6uiIbYozpDgFKihvFiyQhM26X7+xjshV24iTgLeEb9tv+fsX2REGP7KuT
         DGp4pbiPy0+WqC1xQTFAZMlSNxpUSP7SXs7lFCtqj3HWWfVOVdt1dPqf/6O+o5dFqmQ3
         kOEGk5d7424KcYcbZ1f3rqxic0fGLztWRyU8ul8Fm0FJ0guwVMZYLgn/8rGejRWvo5Nj
         PBhjCxBQ/8B/R5Ui1jWV2mnfZ7eQnSqZFsLhUeGE6+o8NBqWUrqlnmn9GR/8GjR8/liI
         jT5BtyNR7juJKRqd3s+l0YpmXArZWl1gA6nMfcvKt8QeijAJHSt8U5jwz1YqcrkP2bau
         TuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h3wvex0q9y1/BA10IiAwwNQZNAyXYf6ppjX9GR7oem4=;
        b=MopELD+muRydXLw69W0PeaQa0jlc8KeeP0tQJWsGPi5Mb2QSH6Hy99zMA9A3VTDMuV
         YRsCYFjJQxORvOHOUHj4+2cfMsc9i8jDRW604sjjs39QFo4pXfgh+wzE/fY3RCGjqu8+
         6ow/8gAVNSKgUJLCF3uXM6sqUZxsncPvVzTBblFQ1bEZNSPMOD7Ho/KRe4p640S2SBq2
         2H/gS4tHQpxPxJo7AtODftBRcKYA4z0cDHGPSimBCj/fp6RFEwzmNzFGuXuY8fZijBdE
         R5HohfpaEW/JX0C2L4OJ7QqazJSykq42ok/uq8/afjIFN2SmWHcU70Waz377155w/dFI
         gt/Q==
X-Gm-Message-State: AOAM532Whm9asRKlQmyqCLr5332vOO/J+EV/hMetMdPVkuka2n0g1AHV
        af3VoofT4NfEUDhmllB0rs5B45BXyEajQQ==
X-Google-Smtp-Source: ABdhPJyi97Bajzs0O5z8ipzfAsXqShxm2a6B2dBTcu7Fvs06IfsBP9/VJqfIQl6B2H8ythTPqX8ILykeIt8raw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:76c3:b0:13c:957d:561f with SMTP
 id j3-20020a17090276c300b0013c957d561fmr25857333plt.27.1633982304889; Mon, 11
 Oct 2021 12:58:24 -0700 (PDT)
Date:   Mon, 11 Oct 2021 12:58:21 -0700
In-Reply-To: <xmqqfstafyox.fsf@gitster.g>
Message-Id: <kl6lfst72v1e.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210917225459.68086-1-chooglen@google.com> <20211005001931.13932-1-chooglen@google.com>
 <xmqqfstafyox.fsf@gitster.g>
Subject: Re: [PATCH v3 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> With this merged to 'seen', the CI job with the extra set of
> GIT_TEST_X settings fail.  When this topic is excluded, with
> all the other topics in flight in 'seen', everything seems to
> be OK.

Thanks for the feedback, I did two CI runs on my fork in response:

* [1] uses the same tree as seen. Looks like osx-clang passes but
  linux-gcc fails.
* [2] is rebased onto master. Again, osx-clang passes but linux-gcc
  fails.

This should be enough for me to hunt down the issue, though I would
appreciate any hints if anyone has any :)

[1] https://github.com/chooglen/git/runs/3862097340?check_suite_focus=true
[2] https://github.com/chooglen/git/runs/3862670035?check_suite_focus=true
