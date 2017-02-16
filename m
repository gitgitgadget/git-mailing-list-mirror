Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F4E1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 22:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933644AbdBPWey (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 17:34:54 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36167 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933429AbdBPWex (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 17:34:53 -0500
Received: by mail-lf0-f67.google.com with SMTP id h65so2508636lfi.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 14:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kocP1TpWx7enZvaDs0MwJx7R4+NG8dLbTst//Jek70k=;
        b=Q/UZyqMcxboiuMGb559Avozhv4quTDb6FuSaxbWsi7LcmWBk1cfhe/8MZR8pYdOtEn
         S1mXDPQwvP8c6BO5H5+mhQ7da/Zz/LwvVBaV5I8ZnC27AypOzRG+8OW+STRsNb8xSo41
         2Ri3DIvA0eMhIT7B7pQE7jDW2Umt5kVv7dCKgqzy//BjWTGmgnvN1hEE7C1tOhZkF/Vg
         EVqW8WIIq1hjiuhDkXKUjfvacitsQdPo7uvqS0HJm4ben5IrX5KuoS1TFWAHP7fDC54F
         ZHr6I3WtxCKaS2ONJ+Y1CTnkF7wr+3acYTP0OpXl4nW6CCgaZsxn2hb4XVVCxEK6O1UM
         jKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kocP1TpWx7enZvaDs0MwJx7R4+NG8dLbTst//Jek70k=;
        b=WX5Stj0uV7IsC0vcovdYf+Zs1QwGUTLX3LtiojB+shwl2XlK4O99vfYNje7IER+9CN
         ppaMJj3QWW8Ns7FDNR9vv2jp9NR2DAyH38ZPVnzyXQM4eB6OwpuO7sitde3Tiopkq0nC
         JADzikxWzv8d2DpGf4AYc7cNDfSdM8HdoikzV0DtCUGY9/Lnw5+krgXN1p36bzuiiID8
         vtU77+OxG4GA+EXNvhfslLHNSyzyw1xSD8XEUsPD5EgMz9n3nZjbT0DB36osTABDtxFI
         bjfhHdAGvBxTFbxoe4Y7nRqcti7pjBkUDYKyetA3B9UKsSM8uvN2LgnVuxGxa8QplgJe
         6fMg==
X-Gm-Message-State: AMke39nidMrL/kArx6uTNjDoBaT4QweiAFqq5Q8Ba0unVRmaFhAuwC73qcYgt0suI2R+TjOQyYwMZS6n8EpFgg==
X-Received: by 10.46.0.210 with SMTP id e79mr1339016lji.34.1487284491605; Thu,
 16 Feb 2017 14:34:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 16 Feb 2017 14:34:31 -0800 (PST)
In-Reply-To: <20170216003811.18273-9-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-9-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Feb 2017 14:34:31 -0800
Message-ID: <CA+P7+xr=2=ZvFvSjMMKsS_T9uPzVW3K3jtaCjc4DSaxNGgozOQ@mail.gmail.com>
Subject: Re: [PATCH 08/15] submodules: introduce check to see whether to touch
 a submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
> +int touch_submodules_in_worktree(void)
> +{
> +       /*
> +        * Update can't be "none", "merge" or "rebase",
> +        * treat any value as OFF, except an explicit ON.
> +        */
> +       return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
> +}
> +

This function doesn't and the comment don't make sense to me. What do
you mean update can't be "none", "merge", or "rebase"? I'm thinking
this means that the update_recurse_submodules checks whether it's ok
for doing recursive update on submodules but only when the update type
is checkout? This appears to be connected directly to the previous
patch that reads the config value somehow. This is pretty convoluted
to me, and took me quite a while to understand. Is it possible to make
this more clear in the comments or in the name?
