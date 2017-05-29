Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9D120D0A
	for <e@80x24.org>; Mon, 29 May 2017 23:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbdE2Xx0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 19:53:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33664 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdE2XxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 19:53:25 -0400
Received: by mail-pf0-f179.google.com with SMTP id e193so55651914pfh.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YZ40cD0x5uyZzhLK3KJi2ubE64CjVGl0NO9kFSDf5aA=;
        b=BCeDzlXSsE4Q+4v4XDi+WchVbZc95T7gU3Nxz2cocd2z6vQEu85Zv0sfrF8niQ+I00
         Ztrpqwh1Gz5xN7YHKh5LE18PkuxN/xZlYVQq1V0+b9xythgiTskpELQfkr41DcGs2Js8
         TcSOghFbKyIxLgplaWlfNgqtqtx6GE4ns371QkD3iwx7ww1m6MJuNpjnhww93AUoOYGQ
         DKwd5iJK/T9jvqxNmwQcXdlPLpUt0gofnah/hp76qdCjEO0xaGEFBfhfriEzpFN3s6mx
         6qIC3BCEOz8oybCHkDrbhatO/174G8PefvFbAq4rWe3C1ma5oTD4KUxOPe+NMHs/tmz9
         AQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YZ40cD0x5uyZzhLK3KJi2ubE64CjVGl0NO9kFSDf5aA=;
        b=X97ZuET36/BRCkZmTM0ziU5ifbusXsYzxj72RggSd1hymy2UPk66qkAkn0UI/Jq+Yk
         UxdU4eteAGy2hm8p0fhazAEiGJJmkdMSC85SpUhF1PyVm6ZZC8USJR7hv4NS/JWWsPxZ
         oFhzHlhlLSBY2rptyGgBx7tf+49lDuePdHJUTDOgsgkUtNqkXtn+EMh+/YZxhc/l36kA
         dzyDzhNY2+AMw2JwfVxEASrlmsekQM0ATzwkFeri7H0AFPYRiIZBwpgZYVF3RrJa0wse
         rthTV04fDy8El2coCAaCubsni1Ksac7EdaZkvohIs5qVAKezwqYFgBy05sc5VVeitero
         WpNw==
X-Gm-Message-State: AODbwcBqIoThmG2xyVhSWRHLdwr8yzwpwaabcAtNFcMiRVN0Flz5Miqf
        p8tYFAZ9inuFMQ==
X-Received: by 10.99.42.68 with SMTP id q65mr22163228pgq.78.1496102004702;
        Mon, 29 May 2017 16:53:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id n87sm18772368pfi.124.2017.05.29.16.53.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 16:53:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote nicknames
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        <20170526033510.1793-1-gitster@pobox.com>
        <20170526033510.1793-14-gitster@pobox.com>
        <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
        <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
        <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org>
Date:   Tue, 30 May 2017 08:53:21 +0900
In-Reply-To: <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org> (Johannes Sixt's
        message of "Mon, 29 May 2017 23:02:15 +0200")
Message-ID: <xmqqshjnfcem.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 29.05.2017 um 22:40 schrieb Ævar Arnfjörð Bjarmason:
>> On Mon, May 29, 2017 at 10:25 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
>>> index b195f71ea9..fd719a209e 100755
>>> --- a/t/t5580-clone-push-unc.sh
>>> +++ b/t/t5580-clone-push-unc.sh
>>> @@ -1,13 +1,19 @@
>>>   #!/bin/sh
>>>
>>> -test_description='various UNC path tests (Windows-only)'
>>> +test_description='various Windows-only path tests'
>>>   . ./test-lib.sh
>>>
>>>   if ! test_have_prereq MINGW; then
>>> -       skip_all='skipping UNC path tests, requires Windows'
>>> +       skip_all='skipping Windows-only path tests'
>>>          test_done
>>>   fi
>>>
>>> +test_expect_failure 'remote nick cannot contain backslashes' '
>>> +       BACKSLASHED="$(pwd | tr / \\\\)" &&
>>> +       git ls-remote "$BACKSLASHED" >out 2>err &&
>>> +       ! grep "unable to access" err
>>> +'
>>
>> Doesn't this need test_i18ngrep?:
>
> Good catch! It would be this one in warn_on_inaccessible:
>
>>      wrapper.c:581:  warning_errno(_("unable to access '%s'"), path);
>
> But actually, I'm more worried about the unholy mix of
> one-test-first-then-skip_all-later that occurs in this test script (I
> do not mean the skip_all that is visible in the context, there are
> others later). I think there was some buzz recently that prove only
> understands a summary line that reads "1..0", but here we would see
> "1..1". What to do? Reorganize the test script? Dscho, any ideas?

Put this new test after the other skip_all/test_done and you'd be
fine, I think.  It should come after the "setup" test anyway, no?
