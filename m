Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573A3209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 21:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbcITVDI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 17:03:08 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37455 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbcITVDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 17:03:07 -0400
Received: by mail-wm0-f44.google.com with SMTP id b130so56823506wmc.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UqIo9xlVUD+aiRyJydjj1QIv3HukZkkRJtDejh893xA=;
        b=U+/uUanX4SHK0HXA20kqG5naEL5Kbshv8KK9f1Vn6BzMj3lt7YrDpPF0dtYTA8k6FF
         RVYnGk9U5D9vOJbnjAz/hz9/hRYH1FFHHHa9cEUSbBarcBE44ISYEe66s8bJruFJGuPW
         chIGXLQviuYh1nBcUSgbC9JBAQ63+EmHlot0fAIhJcQoKv15kgeE0gP+GssiUDYG6BLC
         k2RWszxENltBeB73/0wWUNjcx9JaTeWc4ZM46otST1vzqwxinqAPPrh8DX7a7Io33m4s
         yO2ZEDXt4898+a6rTFHWOOCLDcn0pWLH038hRilvTs0NJRyJC1ipRlEvlBZWdIpAr7N8
         sNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UqIo9xlVUD+aiRyJydjj1QIv3HukZkkRJtDejh893xA=;
        b=QTzIwiUXb2u8oJz4MMvHf7ueb2n6Kd0Ct8Q7nmET2ioRlTzc7oG5suSMEgY7Eo9AaG
         NzL5ARUeX42GH3g3lkDdqnyrt1H0gcMLyVkwlajNXh7kxgsT/dDk0JQ5IWYZav4dUQj8
         fE1+LSTaH9jMK2YRWYZBmWerxMu30A9bSn9GYaflxVsN/iayUa76W7C8zCW/wSee0j3z
         WRAr1bWR8ChCBLAEhIb8JfvGn0qHLiWi27eXRV5be95O+QSt5iGZkUgrbRZYETzsMUkk
         36GqqThAU4hQb+sOYdXyr7F9uDi2J3R1wiZqjPczA5pDkGt/I44tuViRwB1/NCMM4zhf
         NDMw==
X-Gm-Message-State: AE9vXwOFOlTRpGCoLM8ex5NOb+ayDJYitkLBLSmLp1J+UwQ/yyEcjQAvABAbxsgjdqczoJO652pn9odmzjejYJ1u
X-Received: by 10.28.22.6 with SMTP id 6mr5325656wmw.55.1474405385694; Tue, 20
 Sep 2016 14:03:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Tue, 20 Sep 2016 14:03:04 -0700 (PDT)
In-Reply-To: <CAKoko1oU+QR61Vy0eSxaRe_w8u4q_bC9gx9H7oMqH=CwNzBVCA@mail.gmail.com>
References: <CAKoko1qrAuLhn6qQax-BSZFhEqbFdiBbVrip8TD3NVjD8Xzy0g@mail.gmail.com>
 <1474311151-117883-1-git-send-email-bmwill@google.com> <xmqqh99bcw6m.fsf@gitster.mtv.corp.google.com>
 <CAKoko1oU+QR61Vy0eSxaRe_w8u4q_bC9gx9H7oMqH=CwNzBVCA@mail.gmail.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Tue, 20 Sep 2016 14:03:04 -0700
Message-ID: <CAKoko1qS0+DgnMeNnjayEK3sWnvpuiS4oRDBSR=6s8i4okQ_Hw@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> +
>>> +     if (item->flags & PATHSPEC_ONESTAR) {
>>> +             return WM_MATCH;
>>> +     } else if (item->magic & PATHSPEC_GLOB) {
>>> +             return wildmatch(pattern, string,
>>> +                              WM_PATHNAME |
>>> +                              (item->magic & PATHSPEC_ICASE ?
>>> +                               WM_CASEFOLD : 0),
>>> +                              NULL);
>>
>> Isn't this last one overly tight?  I am wondering about a scenario
>> where you have a submodule at "sub/" in the superproject, and "sub/"
>> has a "file" at the top of its working tree.  And you do:
>>
>>         git ls-files --recurse-submodules ':(glob)??b/fi?e'
>>
>> at the top of the superproject.  The "pattern" would be '??b/fi?e"
>> while string would be 'sub', and wildmatch() would not like it, but
>> there is no way for this caller to append anything to 'sub' before
>> making this call, as it hasn't looked into what paths appear in the
>> submodule repository (and it should not want to).  And I think we
>> would want it to recurse to find sub/file.  IOW, this looks like a
>> false negative we must avoid in this function.  As we cannot afford
>> to check if anything that matches 'fi?e' is in the index file of the
>> submodule repository, we shouldn't try to match 'fi?e' portion of
>> the given pathspec pattern.
>
> good point.  Let me think about this some more.

On a similar but slightly different note.  In general do we want the
pathspec '??b' to
match against the sib/ directory and subsequently have ls-files print
all entries inside
of the sib/ directory?  (this is in the non-recursive case)
