Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2A91F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfDYJjn (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:39:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42299 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYJjn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:39:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so625454eda.9
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=A9N57p4croNYQNUt6WIMWXiG/5mcog4vtVZtIH2oFGQ=;
        b=LGUuinmmxo0uYMf2N5zZufbZXWY/d2IS9O78GN9AhK1n4Y0DnGv7oWetE6NEwkxdMJ
         D2/cjRP4fPhYN81z3KsghuDqGkz9BqiXmlKo9sGH7qHm+bWU4c7Whg9FDWIJwNNAbEKc
         DuN2b2+OTFyWT02XeLJ9E5yULy5Es0mMf6U8w+MMdfU0RYVnh98NngNQRe48zLKLuntp
         0ICnvCalIS5fEDG+C8JiuHumfzPzyrjLC73DAmzQR4Av7ptJv8UeqZPdjJC7tMsDPQxP
         G5G69w565FPhxl9cct5drIOhVCrfgQQv3eFR6GbGnZ9o6PQ9nlvOLIgq3HMqftYSfGS5
         I3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=A9N57p4croNYQNUt6WIMWXiG/5mcog4vtVZtIH2oFGQ=;
        b=oZhbqEVeC/4P1ffHy1WOj61x7HsHUCxeAy5xtMAwsaSeAEohSAMXs6GGpVubH21MKB
         k/YEz0DLWBIgYJ73+CM32odfutKw5HU4gVvNb7a7eKredD4LCVgWa+26FeTZCRsl3mNL
         6hgLlbC4OAZQkUIkWdXJXcrgoj3kVq1Bqk2mVy2P+C8U976j1zmdfpu19rboGcFRkAuX
         55Qyji+Bt0F7UNqjadaWYYynW3YcfKfa211TvbRyb06x2+4tHzKhGRoq+V6WMbBvZy1X
         5pbweXWZ06CybBNhwUdS8/JuSJ8AjXGklAPLwB+mghRSfq94VR9LnAEKmCIjyrVnYqxm
         OUPw==
X-Gm-Message-State: APjAAAVmg0QVVzlfSalS9T7Qc6g4dqdDThUoeu0jrHxBVwe7+GjFDFdz
        aDZjhzozJ6iZjqgjipnYt/w=
X-Google-Smtp-Source: APXvYqyZrBJQr6a/r+hu5oSN912jPOdbgKdE1LX3ZH7VcLFuZDZ+Cg2b+X1bqo5kgnfRuIpIH+iBpw==
X-Received: by 2002:a50:a7a6:: with SMTP id i35mr23766184edc.96.1556185181340;
        Thu, 25 Apr 2019 02:39:41 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id t2sm85119eda.41.2019.04.25.02.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:39:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple hooks
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <20190424004948.728326-2-sandals@crustytoothpaste.net> <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com> <8f79d251-58d9-f63b-7171-7f1fbd11c6f9@kdbg.org> <xmqqo94uzyxa.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqo94uzyxa.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 25 Apr 2019 11:39:38 +0200
Message-ID: <87lfzys9t1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 25 2019, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Furthermore, basing a decision on whether a file is executable won't
>> work on Windows as intended. So, it is better to aim for an existence check.
>
> That is a good point.
>
> So it may be OK for "do we have a single hook script for this hook
> name?" to say "no" when the path exists but not executable on
> POSIXPERM systems, but it is better to say "yes" for consistency
> across platforms (I think that is one of the reasons why we use
> .sample suffix these days).
>
> And for the same reason, for the purpose of deciding "because we do
> not have a single hook script, let's peek into .d directory
> ourselves", mere presence of the file with that name, regardless of
> the executable bit, should signal that we should not handle the .d
> directory.
>
> IOW, you think access(X_OK) should be more like access(F_OK)?

To me this is another point in favor of bypassing this problem entirely
and adopting the semantics GitLab (and it seems others) use. I.e. in
order execute:

    .git/hooks/pre-receive .git/hooks/pre-receive.d/*

Instead of going further down this avenue of:

    if exists_or_executable_or_whatever .git/hooks/pre-receive
    then
        .git/hooks/pre-receive
    else
        for hook in .git/hooks/pre-receive.d/*
        do
            $hook
        done
    fi

It also:

 1) Makes it easier for users to experiment with more granular hooks if
    they have one big pre-receive hook by adding pre-receive.d/* hooks
    without having to move their existing pre-receive to
    pre-receive.d/000-existing hook (which will be incompatible across
    git versions!).

 2) Is compatible with any existing trampoline scripts you might want to
    migrate from that *don't* use pre-receive.d/*, e.g. one script in
    our infrastructure (that I didn't write) does:

        my ($hook_phase, $dir) = fileparse($0);
        my $exit = 0;
        my @hooks = glob("${dir}${hook_phase}-*");
        for my $hook (@hooks) {
            next unless -x $hook;
            $exit |= system $hook;
        }
        exit ($exit >> 8);

   I.e. you have a ".git/hooks/pre-receive" trampoline and it runs
   ".git/hooks/pre-receive-*" scripts.

It occurs to me that we might want to make things configurable for the
#2 case. I.e. have a core.hooksDSuffix=".d/" by default, but you could
also set it to "-". So we'd then construct a glob of either
"pre-receive.d/*" or "pre-receive-*" from that.
