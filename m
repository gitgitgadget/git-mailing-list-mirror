Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9771FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 10:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757257AbdDQKI0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 06:08:26 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35900 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932599AbdDQKIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 06:08:24 -0400
Received: by mail-oi0-f52.google.com with SMTP id r203so137276646oib.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qmb++AfQUElmbjYcPcMAC3UrrY1L7JMyuFyp5GdgiE4=;
        b=m+Hh9zrZKZ4FQaKnTAsZ3n7aInnmq4sVGUTSYM1juw24jayQbIWvqw5a7QP2Z72uMK
         USSVn30ud9LVn+bIWh2s+vZG9Jjv3ChdPc9aRuhvjEc2Fw1TZliqfN3oyDivHnJlU4r/
         BWbpTE0iSvbCy53kRwJU8xYcT2G1ckWUqqOy7FCHvsT1XkMvFTg9YeVSatPL52X/I/hg
         Z0rzdS6rE02eqzCmvFxofjOnv3821h5/q/BUR1z7BMlXiiihiHVE40wJBnNfUjMgbiPA
         kj2y+36k2IrDz6JyRlALG+9gE/DWq2PyC0z5T6rywBGTwuGoXifNIOqBeFANTg8ReGMN
         0VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qmb++AfQUElmbjYcPcMAC3UrrY1L7JMyuFyp5GdgiE4=;
        b=awpINxVl2msuno6DEYSiE0qUZtkZ1lUpMcF6YQcKGeEoZLjLbhRVmHP9AuRfTseRcD
         O3icw65c/CGRmJ5kM8hgv4eXW5NR4FX71ZngQRIrQ4cO1p8eT9jDL6RTfYttzKUptn/N
         YfcPTyINuCmDhWBVHPZjCojZnJBmRqbjvUhOWkZlyt+EolVsJqd34nK5vo7Bmnm3GAZl
         k3fk16aKmIbBKdBiBb8rv4tbPxONNihIt/7XcgK9Pf7f6MBLGUvNkQjFJuFjjSnnwCLD
         BDeq9DH7Kv8laVcALGX79mHp0VXvN9eRsyxzK1z9+k+gUhatuBWPuOGfmQi2aiV0ZH4Y
         AN7Q==
X-Gm-Message-State: AN3rC/5F+HmBDAy1NZtKk15RgFDdaaWYvE9r9+bQYA2LN9bI/E4EDID5
        b/yHrq4pBWrKCVvNN3FPE7Qh2QVkng==
X-Received: by 10.157.28.165 with SMTP id l37mr4052851ota.199.1492423703220;
 Mon, 17 Apr 2017 03:08:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 17 Apr 2017 03:07:52 -0700 (PDT)
In-Reply-To: <20170416155131.ppp5iakohiiphzmk@sigill.intra.peff.net>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
 <20170416104125.15300-1-pclouds@gmail.com> <20170416104125.15300-2-pclouds@gmail.com>
 <20170416155131.ppp5iakohiiphzmk@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Apr 2017 17:07:52 +0700
Message-ID: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
Subject: Re: [PATCH 2/2] config: handle conditional include when $GIT_DIR is
 not set up
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(To Junio, this series conflicts slightly with
nd/conditional-config-include, let me know if you want me to rebase
this on top of that)

On Sun, Apr 16, 2017 at 10:51 PM, Jeff King <peff@peff.net> wrote:
>> +     if (opts.git_dir) {
>>               struct git_config_source repo_config;
>>
>>               memset(&repo_config, 0, sizeof(repo_config));
>> -             strbuf_addstr(&buf, "/config");
>> +             strbuf_addf(&buf, "%s/config", opts.git_dir);
>>               repo_config.file = buf.buf;
>>               git_config_with_options(cb, data, &repo_config, &opts);
>>       }
>
> ...we have to re-add the git_dir.
>
> Might it be simpler to just xstrdup() to opts.git_dir, and then leave
> this later code alone?

Sure thing. But we need to restore the "if" expression too. Otherwise,
if have_git_dir() is true, we may come here with an empty "buf" before
that strbuf_addstr(&buf, "/config") is called. It does not matter much
anyway because this block will be removed.

> You can see the second problem with:
>
>   # random external
>   cat >git-foo <<-\EOF
>   #!/bin/sh
>   echo foo
>   EOF
>   chmod +x git-foo
>   PATH=$PWD:$PATH
>
>   git init
>   git config pager.foo 'sed s/^/repo:/'
>   git -c pager.foo='sed s/^/cmdline:/' foo
>
> That command should prefer the cmdline config, but it doesn't.

I actually had problems seeing the problem, for some reason it didn't
work for me. I guess I made a mistake somewhere.

> The fix is something like what's below, which is easy on top of your new
> options struct. I can wrap it up with a config message and test on top
> of your series.

... anyway I read this last sentence too late and spent too much time
wrapping your changes in a patch (well most of the time was spent on
writing a new test actually), so I'm  sending it out too. My test uses
test-config though (I have given up on dealing with pager and tty).

Off topic. Back to the pager.foo thing (because I had to fight it a
bit before giving up). I find it a bit unintuitive that "--paginate"
forces the pager back to less (or $PAGER) when I say "pager.foo =
my-favorite-pager". Back when pager.foo is a boolean thing, it makes
sense for --paginate to override the "to page or not to page"
decision. But then you added a new meaning too pager.foo (what command
to run). "--paginate" should respect the command pager.foo specifies
when its value is a command, I think.
-- 
Duy
