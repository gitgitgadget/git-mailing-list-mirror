Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A242B1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 14:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfBUOum (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 09:50:42 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:32787 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUOum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 09:50:42 -0500
Received: by mail-wr1-f41.google.com with SMTP id i12so30825009wrw.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RTv3JrfQYoM2IXLv3k2UsheIRdAkcwFWnO3yGx2F7HU=;
        b=ouqlyZ0WS0aAEEfRTif6pDMVQbDNmxOZQYAw+Zy1qr2uD6RJtFN+7DaY2mdWHmGsTX
         tPIksiaszGsA5Mj5sR38RDmZYYrYfGc9Zqwp21J41fReaN/JEvme1Yl595izWFCVB0jb
         Vk/ZbDscmpSmqyqWehKRGtbPQg9qGARE9u0CAkYxFRT08RxigoFBBg9ltATeluFrlBQ5
         HYI6+/taw2kK/b8ByqcQ44DtHborEsuGPP+X0L66OMX5tf58mVDaffMARYvPmDnm98XX
         txMMaCYz9UHgm32m3TV5BVH8B0dE1DLkKxE/G6emowYv3UXBeWaqESj0dEeQhIZulrjX
         IDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RTv3JrfQYoM2IXLv3k2UsheIRdAkcwFWnO3yGx2F7HU=;
        b=BAiNjv+7YJMlrZ4M8wrUkIRIhzlXmO73zXrUaLVl2H6BTpzQ6YTxpj4aCCyclQMuz3
         QVT9CQJxulfAEU7q/mhggRwiIOEue8UCMT5tIRC3QlKRKX0y/XYm/lquCKhaIkU/T9m+
         G6DrVUYBEkeB/nH3rKmLEwj2AcwYLbhHPghSRNLV/3dZnAjmcy3KcG3tlf/exlT3CRwm
         Ku3h+cxpia/oGKwEjnZsBsxYwMb1SFVd2NQc7WY568L0zGMMiHBTH5WjrbrVBh0mWJ0E
         DiOLgBDQM+jNHp2HB89LW1Ep2jxCnCo4W1p3jn7vObUgyZgyaljj7kGVj9D7JXeqOJKa
         Y3VQ==
X-Gm-Message-State: AHQUAub138deTQXkNsj65roENdQOUbyjOG+MKUf0DJ+Z5Mw95Vegy9oU
        TN9C6kMgLyPASWhch7tv/24=
X-Google-Smtp-Source: AHgI3IZG1U7EraGkhNPnyutB4UX2elfdO6ref0YqCE32sq2vEfDgnioKzdCUu/h/alyWgjwSq4CtIw==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr10300971wrv.304.1550760640078;
        Thu, 21 Feb 2019 06:50:40 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s3sm28550559wrt.81.2019.02.21.06.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 06:50:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: 2.11-era rebase regression when @{upstream} is implicitly used
References: <877ee2jyh3.fsf@evledraar.gmail.com> <20190221141042.GA21737@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190221141042.GA21737@sigill.intra.peff.net>
Date:   Thu, 21 Feb 2019 15:50:38 +0100
Message-ID: <87bm355h6p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 21 2019, Jeff King wrote:

> On Thu, Feb 14, 2019 at 02:23:04PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This is not a 2.21 release issue, and pre-dates the built-in rebase.
>>
>> When you clone any repository, e.g. git.git, and add one commit on top
>> of the cloned branch, then run "git rebase" you'll get e.g.:
>>
>>     $ git rebase
>>     First, rewinding head to replay your work on top of it...
>>     Applying: foo
>>
>> Before 4f21454b55 ("merge-base: handle --fork-point without reflog",
>> 2016-10-12) you'd get:
>>
>>     $ git rebase
>>     Current branch master is up to date.
>
> I'm not entirely sure this is a regression, and not the patch bringing
> the behavior into line with what would happen when you _do_ have a
> reflog.
>
>> The results are not the same for "git rebase @{u}" or "git rebase $(git
>> rev-parse @{u})":
>
> Those aren't using "--fork-point", so they're going to behave
> differently. The default with no arguments is basically "--fork-point
> @{u}".

Yeah, that's what it *should* do, but it's not equivalent to using
--fork-point manually:

    # my series on top of origin/master
    $ git rev-parse HEAD
    2a67977d3f70fa7fc4bce89db24a1218dc9ab2aa
=20=20=20=20
    # Junio's origin/master upstream
    $ git rev-parse @{u}
    35ee755a8c43bcb3c2786522d423f006c23d32df
=20=20=20=20
    # Where my fork point is
    $ git merge-base --fork-point @{u}
    35ee755a8c43bcb3c2786522d423f006c23d32df
=20=20=20=20
    # OK
    $ git rebase 35ee755a8c43bcb3c2786522d423f006c23d32df
    Current branch master is up to date.
=20=20=20=20
    # OK
    $ git rebase $(git merge-base --fork-point @{u})
    Current branch master is up to date.
=20=20=20=20
    # ???
    $ git rebase
    First, rewinding head to replay your work on top of it...
    [...]
