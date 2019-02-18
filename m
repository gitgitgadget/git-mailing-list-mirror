Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C881F453
	for <e@80x24.org>; Mon, 18 Feb 2019 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfBRVAi (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 16:00:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37122 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbfBRVAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 16:00:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id m12so14941450edv.4
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 13:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+ax/mle+Zl8n60cLDzOTuJxK1dhMrPAJOCk4y5vz/k8=;
        b=KwIsD6YjCSydvZPe+Ve/i+eoL7ZWY0FqL5Qyo0sDzH89e2BfH4FAMzqxsDC501h0Bg
         dLNVNnwl8BmppNGQc5h83+zeQG97omQYd5ZJkHXEATYhaH1JWHhcqufj1QROcDXlco83
         J3F4imn9Qt+vXh+cmQFQiWolmBXgo14jTKQEOD45G06TxgqxsufkGU2WIazaXIBGwAtj
         hkrRMpDOY/6jkTcR3xCHfvyI/z840FUpbqjLbDoKrO7pPukmgeppnF1qfZ9v4n7RJ7kv
         dVYkI7WxBsgR0s7Bnfi1Gp43awyoPoa5KfUS8lbMGdNSohiwf70/W0K6qEA7ejoiHnG2
         tndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+ax/mle+Zl8n60cLDzOTuJxK1dhMrPAJOCk4y5vz/k8=;
        b=g8PMPjnXAG1vJvVxPQs4dnLcLuQvBGqCf4TbOzKk8KidJrSNbEArawhVm82TkciFnQ
         ITtTHqtVJNOWrWGYuVS7i7ZG3Gw6odmQCc4NeYQ9t5DnUG43v2511Lu6kgW7+TZq8G+V
         OpxX8MBZveX+FDcxsw3pXqt2bJIUGq95qisn0X2znRoyT7ZG21OmUecVqYFohrE1WYug
         w3wu5YBb9WpX6H0WjOtBJl1QlAAUMAbBDW1+uqjlTn0w3hxC/xOmoQkpRYwOeVoaKlql
         1zYc8juLY3GHuW+GRO+7A+UOAPI11T7kTijs7BVo6j2IpNi+ktk+KEb314U51Ki99B9T
         xKmQ==
X-Gm-Message-State: AHQUAubsmjF0XqOypfXd4CTRNOd6dUxiHBxuKz0AU9uJ7vJ+EmbKTThs
        mmvyNVY6E1n+YXl1oARKgBc=
X-Google-Smtp-Source: AHgI3IZbRdLILMtFaA5lpcwv9N5fPT8E/U+BsTRNSKU/WDpsGwDM8E6Sqk2ZjN6mDX0ZKBO+y36PTA==
X-Received: by 2002:a17:906:1d0d:: with SMTP id n13mr10237570ejh.23.1550523636205;
        Mon, 18 Feb 2019 13:00:36 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x7sm581476eju.12.2019.02.18.13.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 13:00:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 30/31] Git.pm: make hash size independent
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-31-sandals@crustytoothpaste.net> <87zhr1jmr4.fsf@evledraar.gmail.com> <20190218190920.GL684736@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190218190920.GL684736@genre.crustytoothpaste.net>
Date:   Mon, 18 Feb 2019 22:00:33 +0100
Message-ID: <87r2c4olqm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 18 2019, brian m. carlson wrote:

> On Tue, Feb 12, 2019 at 11:59:27AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The gitweb code doesn't load Git.pm now, but does anyone know a reason
>> for why we'd avoid any perl/* dependency in the gitweb code? If not the
>> regex here & in gitweb could be factored into e.g. a tiny Git::OID
>> library which would either just expose a $GIT::OID_REGEX, or something
>> like the sort of interface (might not be worth it) that I suggested in
>> my feedback to 31/31.
>
> I think one potential issue here is that some distributors bundle the
> Perl modules with git send-email and not gitweb, and they're packaged
> independently. I'm not opposed to seeing a patch to do that, but it
> probably belongs in its own series.

In packaging terms that one's easy to juggle, FWIW I'm just aware of
e.g. RedHat packaging perl-Git as its own thing depended on by git-svn,
git-email & friends, not anyone who packages it with git-send-email
specifically.

But according to gitweb/README it's also meant to be used as a
stand-alone script. So:

 * You can wget it from the git.git repo & run it
 * You can run it with any (reasonable) version of git
 * If you're missing perl modules, those are all on CPAN (just CGI.pm
   should be missing these days)

Making it depend on any module we ship would break all those things. I
don't know if anyone cares, but avoiding this very minor copy/pasting
seems like a bad reason to wake that particular dragon.
