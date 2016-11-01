Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B853B20229
	for <e@80x24.org>; Tue,  1 Nov 2016 17:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbcKARbn (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 13:31:43 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33044 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbcKARbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 13:31:42 -0400
Received: by mail-qk0-f182.google.com with SMTP id v138so116708501qka.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N4YN8InpRbGLmoDvtQVFNA3X/podSIW8O/T4vYJJQ+Y=;
        b=Unquoqy3haj0gInM8Vg7q9nTja96pGz63Z52ipu8DqyrrNKydxYDpTPUQjek+uEopA
         SJYAcJKtDMkU+vFszzsfDahE6KXYUqxievWmP/tVzA5sWadpet2ucVFeGl7r5Bz8T972
         7bqHdaCftmhjAyuLGH6wt6Eq3/lcS1a2+lZdv4Y0hkaqx8VK52a4yXhX8Bb3sYE+fgAt
         O0qT6TI9FyHHA/aGyTpYJ5L2a9lLRMyUfxCzRNHR1li6CulBk5JMDjIQhCnpvAhBwS0G
         naSiZTTWuzTSzFbdX8SbsyCy2mKvucNKM8l9IH6B0ckl6TosVijOVyrH6P789mLz1MmX
         wtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N4YN8InpRbGLmoDvtQVFNA3X/podSIW8O/T4vYJJQ+Y=;
        b=hWXMNMeBTH+w065g9+qeCKL2BRm1+0HzCBVcLcCq1ZP9JX3T8rgSm/P2s+pURKFa26
         iro4pZ4Dy1pBGI5HpuqtUn8ZcBYm+2t9M+65lpUlMsvX/eXTLG9iW2JzmAuBceuaHQyP
         I9ZtW6EGQ4KX5TiJzPoAPc2OuBdam5g2DB+nrnrXKmlVgdBk8AOcNY6NK42znqfM9mw6
         8WcgQx5DEEP6qwTt5k8R4Mw6dxSZXJLB26j7UZ/omdieGcBwZHrDKz5pURnGOXxsnHIr
         8V3gpS0MYpcXpYmu7KxV2AwgZBjP4NWsOugMCTVnpaeCiRGQ2O/pKCog35xaTLQKRIrC
         0mvQ==
X-Gm-Message-State: ABUngve8WMcYYKJv16pk42f0taJNOgo/JzuFXz/MtutmmJQiUqoE7fZRZzb3kH45PnAuzltjfEIpR/DU+G/kBUZF
X-Received: by 10.55.186.3 with SMTP id k3mr4711278qkf.47.1478021501851; Tue,
 01 Nov 2016 10:31:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 1 Nov 2016 10:31:41 -0700 (PDT)
In-Reply-To: <xmqq7f8nqfqc.fsf@gitster.mtv.corp.google.com>
References: <20161027223834.35312-1-bmwill@google.com> <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-2-git-send-email-bmwill@google.com> <CAGZ79kamzSPyM65k9ugS0dAJCfGnGvk3m2p+XtCEozCvoZ5+OA@mail.gmail.com>
 <xmqq7f8nqfqc.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Nov 2016 10:31:41 -0700
Message-ID: <CAGZ79kYcs0FiXdP6UZGgSmUpn_3vpnKo2RwTRJCvksP7+1o_wQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 10:20 AM, Junio C Hamano <gitster@pobox.com> wrote:

>
> Maybe I am old fashioned, but I'd feel better to see these with
> explicit "extern" in front (check the older header files like
> cache.h when you are in doubt what the project convention has been).

I did check the other files and saw them, so I was very unsure what to
suggest here. I only saw the extern keyword used in headers that were
there when Git was really young, so I assumed it's a style nit by kernel
developers. Thanks for clarifying!

I think we'll want to have some consistency though, so we
maybe want to coordinate a cleanup of submodule.h as well as
submodule-config.h to mark all the functions extern.

This doesn't need to be a all-at-once thing, but we'd keep it in mind
for future declarations in the header.

Thanks,
Stefan
