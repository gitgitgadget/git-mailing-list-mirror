Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49FCA1FF34
	for <e@80x24.org>; Tue,  9 May 2017 05:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbdEIF14 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 01:27:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33879 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdEIF1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 01:27:55 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so6653116pfk.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 22:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qtYPtFTsNfDnPw++T07u0QXWwzY5sr4TU6oJnYLaTuU=;
        b=Muglgcd5UwgZbM0zOqEfztQsxVdR+LvGRIQ0Tcks3aBvlbEjusMCGEi4tRQ/MehZWR
         uRpczV7AFY48pC6qumDD/tf132sSQI7hOvNxsJnrpBNtTCtBa+bI2ix/Ap2mW7g9UEeN
         S/bSDhPwPjQseUP1zSfqykMPuSdJf1iwTxd/YnY4vdgLWcnj4pCCjOAut1p44fMdz/U6
         RlZ3lQxGQOsV2mVO8UleCNr6fGDNJJ4bPHz7oXgrbs120JgTNL5N+G3SJ7fej4K2QyNP
         sZmL7+RKhyusJEZbmA/fgY3YbtU3rA/qpQiKTWMe3e+68B3gTA2tpSs/O5dPSRVEBCEL
         bIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qtYPtFTsNfDnPw++T07u0QXWwzY5sr4TU6oJnYLaTuU=;
        b=Oeddwg1BqzApcvV7ykLKLZs6YH8ScjtfiXCih3x9WY6X0G94Wp6ew4F8EJFJpywCBi
         JxJUrZ3ebQj3k3vmD1c++bF0hDGSPMyfQgyUkLKlRX7csaHe1G1uvx+E3HfBNiW3vzP1
         skhnGakZYIS5giPr/m0agYiy2ctRwdXiHNri1h47bYCb3NMOfOO1EdOboyXZZNFRXRWq
         uLMu4nIg9+dMttDtAhTdYLzwGy64m3Gs6I1XG6eLpja/rmj3H9S1oECV67UBiZr5SLnl
         pRgLYf5NMuEF8xnNqHL1YVAEAnehiiC2EWVNl3LVisXLRjt9Qjh/pQvWC4/K1CQqHWEe
         6rhw==
X-Gm-Message-State: AODbwcBowWuMHYNAinl74GHlvNuHwNrXJ1fI+qkhJ+/8aoP9/8rq9ZKv
        T2n1hQAk0Ns+4xgyiq03iQ==
X-Received: by 10.99.8.2 with SMTP id 2mr11637285pgi.18.1494307674561;
        Mon, 08 May 2017 22:27:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id p7sm25587673pfb.125.2017.05.08.22.27.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 22:27:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@jeffhostetler.com, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
References: <20170414203221.43015-1-git@jeffhostetler.com>
        <20170414203221.43015-2-git@jeffhostetler.com>
        <CAP8UFD2v8R8bSjUi8+1271fJ=jR5JbbGfgO_fdeYpzE=EGx_Pw@mail.gmail.com>
Date:   Tue, 09 May 2017 14:27:53 +0900
In-Reply-To: <CAP8UFD2v8R8bSjUi8+1271fJ=jR5JbbGfgO_fdeYpzE=EGx_Pw@mail.gmail.com>
        (Christian Couder's message of "Mon, 8 May 2017 11:45:02 +0200")
Message-ID: <xmqqtw4u38h2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 14, 2017 at 10:32 PM,  <git@jeffhostetler.com> wrote:
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 33a51c9..677e15a 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -689,4 +689,17 @@ test_expect_success 'bogus head does not fallback to all heads' '
>>         ! grep $blob out
>>  '
>>
>> +test_expect_success 'detect corrupt index file in fsck' '
>> +       cp .git/index .git/index.backup &&
>> +       test_when_finished "mv .git/index.backup .git/index" &&
>> +       echo zzzzzzzz >zzzzzzzz &&
>> +       git add zzzzzzzz &&
>> +       sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
>> +       mv .git/index.yyy .git/index &&
>> +       # Confirm that fsck detects invalid checksum
>> +       test_must_fail git fsck --cache &&
>> +       # Confirm that status no longer complains about invalid checksum
>> +       git status
>> +'
>
> This test does not pass when the GIT_TEST_SPLIT_INDEX env variable is
> set on my Linux machine.
>
> Also it looks like you sent a v8 of this patch series with a different
> test, but what is in master looks like the above test instead of the
> test in your v8.

Thanks for raising this.  I almost forgot that the final finishing
touch to update the test was needed in 'master', and this exchange
caught it before it is too late.

