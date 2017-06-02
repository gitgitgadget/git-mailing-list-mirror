Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D519F20D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFBAmV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:42:21 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33864 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdFBAmU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:42:20 -0400
Received: by mail-pf0-f173.google.com with SMTP id 9so41240748pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+fvwml+awwmLmUgYKZApxy+RXmzX3kmMAADjNZCRKpQ=;
        b=QPiyHojzu0zI2QvAiXw0TYqURzcej4qMbbqzTrxNmySN0ZmHkjYoo6nBlW8+fpurr2
         +CVHEzga40RkVfx6lLVbVtdUo2W2skX+CmFYRVYvT1lmo/SQUFnaKlo07ct86VLnGSVe
         OcDGe0wqsLy2/Mg0+pn8RiGK2qqDY4b33r9XFKq1L2cyxUQJCElwRY6AbBGnn16/mOzw
         jftHYvm7AIqgTyXfshUpsFCwpTBoSB5f7gRt3kDS0iOFrB9E+vNEKHk6FtapoLvXvV7R
         MvjQhc/El+W6NZfpwpqwsgE7aWn7sYZAIneiRAUXezzlQfvo4MCueuKyaDffjkOOF3U8
         1dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+fvwml+awwmLmUgYKZApxy+RXmzX3kmMAADjNZCRKpQ=;
        b=gnrCk3ZR4SQH0Qt+XdMBvktMlb5xMcfCUKTTX7B2r7wTGDPO3GhkeLvmvR9Vrfn/Cp
         GmeDrXigRJsrR+8QDZ06XeDA3eCQuBJFOg913a6PVuLosOjQpA6InGH65W2dZD1AURUy
         c9SK5Z6nyScOTmQOMroB8oOly0spjLO16yxQLqWjjMihqEly4fY8xKGdULwCqt35uiVL
         5EIvxzHiHmFZtZ2VXylcZiH2LBbZeJ+6x5BBWyzKSjgQEVhYUG7pjnywDO/Qu+Yrf534
         NMdU4OXHUzt0VG/QDBqH3quAZHFj5ve4Ufk+CjfAvWvRcwfbq9sT7YhAFHd+JY61n2e7
         aFxQ==
X-Gm-Message-State: AODbwcCaUk8vNGuSaLKGadOfUvUM0a1ooIFo4maTkyDwovjFzKFxVe4O
        LTBzlCBfbpc8rg==
X-Received: by 10.99.138.199 with SMTP id y190mr470183pgd.187.1496364139577;
        Thu, 01 Jun 2017 17:42:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id q135sm47641231pgq.41.2017.06.01.17.42.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 17:42:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 23/33] notes-merge: convert merge_from_diffs to struct object_id
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-24-bmwill@google.com>
        <CAGZ79kajzJGdN1uu5kni3AB31joP5hdnsWp1NBGkX3Rs-BkPpw@mail.gmail.com>
Date:   Fri, 02 Jun 2017 09:42:18 +0900
In-Reply-To: <CAGZ79kajzJGdN1uu5kni3AB31joP5hdnsWp1NBGkX3Rs-BkPpw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 31 May 2017 11:04:54 -0700")
Message-ID: <xmqqtw3z2pat.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>         trace_printf("\tmerge_from_diffs(base = %.7s, local = %.7s, "
>> -              "remote = %.7s)\n", sha1_to_hex(base), sha1_to_hex(local),
>> -              sha1_to_hex(remote));
>> +              "remote = %.7s)\n", oid_to_hex(base), oid_to_hex(local),
>> +              oid_to_hex(remote));
>
> This part is interesting.
>
> 7 used to be the default abbreviation length for sha1s (see
> e6c587c733 (abbrev: auto size the default abbreviation, 2016-09-30)
> for details) and this may have been a left over from the conversion
> to variable length abbreviated hashes. This could be a reminder
> we want to fix these, too. (Though not in this series?).
>
> Roughly like
>
>     trace_printf("\tmerge_from_diffs(base = %s, local = %s, remote = %s)\n",
>         find_unique_abbrev(base.hash, DEFAULT_ABBREV),
>         find_unique_abbrev(local.hash, DEFAULT_ABBREV)
>         find_unique_abbrev(remote.hash, DEFAULT_ABBREV));

Sharp eyes ;-) As you said, this is definitely outside the scope of
this series.

