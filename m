Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAE41F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeJWFsf (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:48:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34747 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbeJWFse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:48:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so39369160eds.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/FqYmyvtsAdeBznlOkDTA+3nCkIpNXqESdc0I0+De0c=;
        b=tN9XzqkLDtQwoP8mNeldnhWemUh/gpXR6T6GpfEPCIijLZgehTtzLkCtYMr8QKfkJ4
         4lbqOjBQliu2n+3f9xAoJZwoicBW4S+WUB07IXyU7f3bYNQqzsraCfFp9L2QI7l7oV/M
         EPGgScOPnRETlEhtyFiK8xTo/TuXd95IbEmjdpMlwCr8j52ADg1Jdn+JIf6GsY5piZK6
         cq4l1lLvuW8lPcpkw7G5jvUjH+RV1HgRp2Lr89v8/BMQDeziyhbqf8e0QA4WUv8ozlUv
         3Mzb5P0QxlSPmb77Qg+td+QjuiAjUgksmto5UAXc+wexs2WNhFeU7u8etaS0SNQCcvZT
         WZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/FqYmyvtsAdeBznlOkDTA+3nCkIpNXqESdc0I0+De0c=;
        b=dvoBdGI+5Yv19CqK5/+yP4ZgJsrLz8nP5kdenH5HSjcJNiuBOaMM/PEL+hZ8QlS884
         6rrC479caa47qtKzATPlf47IWAF7PGDIdjz7oN39EMYf3oIoVcoP0amgfgqDDpr5iz2N
         l+4Z3xrz7bZgJt0Py6VBeGQ9YpR3P2BUh0qLqFFxM1gA69aFZx9LC49PGEsTtlFPiHMT
         1tU42olPOEcSsoElJLpd7s/+iKvfOQ177Vm5KLT+MzLpIo6uc0e/sugwmTfQ3Qzf+9Hh
         ZJs+fEsvI8oWow6fJWJjhRkc/AzPzbdkuy41jL+G3ro36Vbc12eqIvRj47ffp8vl7PEx
         b2Gg==
X-Gm-Message-State: AGRZ1gLa8n/npHimWjRfsHvLmZMYBPI8gV0/wizxtj6J+3KPqvUDBi0k
        g3jbWCO/ecqQ1Zrl4n3dCWI=
X-Google-Smtp-Source: AJdET5fENv1SQDPTXZ7u8/PnFq6fCRot+CV4lQ8Dy6CA6tdbbTxjCleiW/YMfrOJAgxwZPR1uF3taQ==
X-Received: by 2002:a50:f5f9:: with SMTP id x54-v6mr4075390edm.166.1540243697971;
        Mon, 22 Oct 2018 14:28:17 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id c24-v6sm13329282ede.73.2018.10.22.14.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:28:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
References: <87o9dar9qc.fsf@evledraar.gmail.com>
        <20181018225739.28857-1-avarab@gmail.com>
        <20181019220755.GA31563@sigill.intra.peff.net>
        <87ftx0dg4r.fsf@evledraar.gmail.com>
        <20181020185852.GA6234@sigill.intra.peff.net>
        <87efckctqa.fsf@evledraar.gmail.com>
        <20181022211545.GA15713@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181022211545.GA15713@sigill.intra.peff.net>
Date:   Mon, 22 Oct 2018 23:28:15 +0200
Message-ID: <877ei9d634.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 22 2018, Jeff King wrote:

> On Sat, Oct 20, 2018 at 09:18:21PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> We didn't support chained aliases at all before, so I think the odds
>> that people will run into this now will increase as they add "!" to
>> existing aliases, and I'd like to have git's UI friendly enough to tell
>> users what went wrong by default, and not have to resort to the likes of
>> GIT_TRACE=1 which really should be left to powerusers.
>
> It's true that non-! aliases couldn't recurse before, but couldn't "!"
> ones always do so?

Yes. I meant that maybe now it's a feature that works for that people
will start using it, and then convert some of that to !-aliases they
wouldn't otherwise have written. Just idle speculation...
