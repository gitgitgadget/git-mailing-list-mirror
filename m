Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641091FD09
	for <e@80x24.org>; Mon, 29 May 2017 01:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750861AbdE2BNj (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 21:13:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35784 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2BNi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 21:13:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so10478469pfd.2
        for <git@vger.kernel.org>; Sun, 28 May 2017 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JvDyxiER1Jj1ZrVk50magi2uQfUkeXyBp98kOeo5Gn0=;
        b=TE0J/ELmZHGZKP4cpYfNdFYnfoR2PDTvSGxPqaHKBBlnDoukpvN77oPk56nDovIDiV
         2Vre/xwWzSPYLLz4Qry2o0LEtx+NM9sZOU4DD0ZHRW6hA0GWfMR8LOgjo9P9kTqndyFo
         QLXPmO9Lzx+bmlXQaxz4RduIXboAPTiaH2eSfdI4i/MM6/vA8N4FMiwVGWRIZm4Aekq6
         Vf0zwmgnNMlv6eHQxSnwqOI0yncuMyX0kSH2AzU0b1RgXC/k/K+25YbdWV/l69Y5ua//
         8jllScrYKXNBoNZ5DhEliI75uYQBbUzOgmwnBd4H15308oxyfFz+8lxHTJ9NoQSj94vf
         ViTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JvDyxiER1Jj1ZrVk50magi2uQfUkeXyBp98kOeo5Gn0=;
        b=OVXKmzESuYgdsaJ6MY+h++iNi5wHGYqpXiKpeYOmMfmGjcNxL5EGfBieWu6qAzbXjo
         KNScOHqSJ8xbxAeos1akhHAcRQGSg+ujQd7cp0lO61jaOl+qlFtIyMP5ajg90+KbSjHD
         0dT8Lwk7zBhelJE5L6cSKMWQYJ0sq2Vjuj46ODm7rNBRGRLuqi828744pSW1a8hMWCPV
         WaDh2fch6cXJABUF+lWCfu8gzYs3E24basNzzhCkW0ChcQRXTpRNYogYZPexHE0Xp0TE
         86owKrN5VqSpGOtF/WGv5M6w/EIFrFD5khW6tILZfdVN9k0ovMq4FZgK4ifkcp/eyySE
         Nnig==
X-Gm-Message-State: AODbwcBNZlFSPH7wTpd7vZ9unLXuie1gu9OlCVcGmlkeH2QRJNdTBJdL
        //YxG8EwWCDaGg==
X-Received: by 10.98.63.14 with SMTP id m14mr15268001pfa.143.1496020417975;
        Sun, 28 May 2017 18:13:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id y2sm12908150pfk.1.2017.05.28.18.13.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 18:13:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch test: fix invalid config key access
References: <1495991536-71204-1-git-send-email-sahildua2305@gmail.com>
        <CACBZZX7J4xjw0ThSrQ-kG+KGiePZ-8vXET4cHEBOUFL8ydwE9A@mail.gmail.com>
Date:   Mon, 29 May 2017 10:13:36 +0900
In-Reply-To: <CACBZZX7J4xjw0ThSrQ-kG+KGiePZ-8vXET4cHEBOUFL8ydwE9A@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 28 May
 2017 19:33:11
        +0200")
Message-ID: <xmqqzidw8ny7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sun, May 28, 2017 at 7:12 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
>> Fixes the test by changing "branch.s/s/dummy" to "branch.s/s.dummy" which is
>> the right way of accessing config key "branch.s/s.dummy". Purpose of
>> this test is to confirm that this key doesn't exist after the branch
>> "s/s" has been renamed to "s".
>>
>> Earlier it was trying to access invalid config key and hence was getting
>> an error. However, this wasn't caught because we were expecting the
>> command to fail for other reason as mentioned above.
>
> Looks obviously correct to me. Added by Johannes in commit dc81c58cd6
> ("git-branch: rename config vars branch.<branch>.*, too", 2006-12-16),
> CC-ing him in case he has anything to say about it, but just looks
> like a typo back in 2006.

Yeah, it does look like a simple typo.  Sorry for not spotting it
back then.


>> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
>> ---
>>  t/t3200-branch.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index fe62e7c..10f8f02 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -338,7 +338,7 @@ test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
>>
>>  test_expect_success 'config information was renamed, too' '
>>         test $(git config branch.s.dummy) = Hello &&
>> -       test_must_fail git config branch.s/s/dummy
>> +       test_must_fail git config branch.s/s.dummy
>>  '
>>
>>  test_expect_success 'deleting a symref' '
>> --
>> 2.7.4 (Apple Git-66)
>>
