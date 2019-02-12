Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1B91F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfBLRYi (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:24:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44197 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfBLRYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:24:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id v16so3561342wrn.11
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OrbYa0eQ2gS5ya0hN7t/Fo71Xdws2p/qMGsqAvx6C04=;
        b=PF1becMHvIQbkEBzTvagarN6ckI0XlFEgAjBcz1YfMkY1nW44Wnn6lyBKGNoi907Nl
         1CtE3Hf6yDsAraiaKsl7GIEZjTH3EgumkSjVHP9Tx5PWiWyhraSXCJugZJN8y2Ovishi
         BFLNvk44YRRq7Zi+/JA0uOmUASFSfhoZszb0Pdrk4ifgLvtuzOMBFejnCWQHMpUejXBR
         Eus645+53QJ6niB/C53dZPG9fD06xZrQubo0XlO3P0bLmZAhRujmtf2zbQXFktnDZ7EQ
         tlck44lmPT0jy8V5/n160HztsxZn0JlTCigjuyvLZ1ZF+MxJJn8UxmppVRymdHJ64bvl
         vBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OrbYa0eQ2gS5ya0hN7t/Fo71Xdws2p/qMGsqAvx6C04=;
        b=LTlUhh/RgPbld9Kh1yNWljz1hunBkJ5sLGROIC95E6hnQIBgPyBGgKCKaDwyT/NnSU
         KHCKpPcRuXMpv4W90en6fl2ahlWh5IVJbvEjQVfxIRD5bUNjKUJi8obtMRkGqBsSLYr5
         ZtQf4yznXZAYtPbH0l7AubGJEy3Qe9MKW2YgBhIsJg8ahTQD6vuxWyPuo6GcOD4MTiDV
         WIgCiK61eSvC6Q8Zj1BuDqFEldMxsp5puyOePEJOP2PBZC/I06KG1y4P6PnONlar1AI0
         aKQ8/EybTO23WTpXI1goBFbs+sqvw7lS9XRwfGyaeZ1HqutB1dh4AbPmJN2Pq1koqLBM
         PmHA==
X-Gm-Message-State: AHQUAuaU/zg97j+SWfAVM5TimKsDMeGW0HAopNNPezOYd+mft5C7YefQ
        NRzGoJ9N1aZO1I7zWycbu0o=
X-Google-Smtp-Source: AHgI3IZDpw8dFjO4Gsn/9+1vyWx0vt6XrmiFg/YEohlSHN5nWavdRW85f8m17PTYd9HjntO7dX/2nQ==
X-Received: by 2002:adf:c543:: with SMTP id s3mr3511699wrf.192.1549992276257;
        Tue, 12 Feb 2019 09:24:36 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t63sm3531725wmt.8.2019.02.12.09.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:24:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     randall.s.becker@rogers.com, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [Patch v1 3/3] t5562: replace /dev/zero with a pipe from generate_zero_bytes
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
        <20190209185930.5256-4-randall.s.becker@rogers.com>
        <CAPig+cQY57w9rmGzVifKMTMVwt209b959iL9+K79AMfEgiVTfg@mail.gmail.com>
Date:   Tue, 12 Feb 2019 09:24:35 -0800
In-Reply-To: <CAPig+cQY57w9rmGzVifKMTMVwt209b959iL9+K79AMfEgiVTfg@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 9 Feb 2019 21:12:21 -0500")
Message-ID: <xmqqd0nwex7w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

[jc: Summoning Dscho, J6t for their Windows expertise at the end]

> On Sat, Feb 9, 2019 at 1:59 PM <randall.s.becker@rogers.com> wrote:
>> This change removes the dependency on /dev/zero with an equivalent  pipe of
>
> Too many spaces between "equivalent" and "pipe".
>
>> deliberately NUL bytes. This allows tests to proceed where /dev/zero
>> does not exist.
>
> It wouldn't hurt to cite "NonStop" as an example of a platform lacking
> /dev/zero.
>
> The first sentence is a bit off grammatically. Perhaps the entire
> commit message can be collapsed simply to:
>
>     Stop depending on /dev/zero which may not be available on all
>     platforms (for instance, HP NonStop).
>
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
>> @@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
>>  test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
>>         NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
>> -       env \
>> +       generate_zero_bytes infinity  | env \
>>                 CONTENT_TYPE=application/x-git-upload-pack-request \
>>                 QUERY_STRING=/repo.git/git-upload-pack \
>>                 PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
>>                 GIT_HTTP_EXPORT_ALL=TRUE \
>>                 REQUEST_METHOD=POST \
>>                 CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
>> -               git http-backend </dev/zero >/dev/null 2>err &&
>> +               git http-backend >/dev/null 2>err &&

Doesn't this "inifinity" mode have the same issue that was worked
around by 6129c930 ("test-lib: limit the output of the yes utility",
2016-02-02) on Windows?  If I read correctly, the process upstream
of the pipe (in this case, perl producing a stream of infinite NULs)
would not die when the downstream stops reading with SIGPIPE.

Or is it safe to assume that nobody expects to use http-backend on
Windows based servers so this test is a non-issue?

>>         grep "fatal:.*CONTENT_LENGTH" err
>>  '

Thanks.
