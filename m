Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C394207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979940AbdDYCK5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:10:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36388 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979849AbdDYCK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:10:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id v14so6092811pfd.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rrKSlyVb4A6GPV/8kpxdySjNQCOyxTwl/ARrGK6312k=;
        b=HBKEUh96U5oobxvnroVzPG6RtYfoWXsRI702MgDCihKCzz0429KT21HC5LvAuf7b+K
         CXevs3lyTCBh2+5+5W9KfZXZjWe36iOHnp85Jg5rzZWlNlpTOhKNQ4MHwQAaKPOmAM6d
         6Fw5tNKOUWQIcSaL05PJqAVMC0njkspb29DwBSZpzC3b8T9UXqRFdmn/y6QE2E36DOiU
         3Ji6IicF9rpydkhaHN/z9Cf3eRrHZCKBTPhu+oeQX7y3iTiEeu1kQISJY1usUdNxOzid
         BUjF5yl2Mp59Cb7kY688Qf+/Z2Gi49qMsp+sy4EXoa6jmz3KyXcOJoGsZ5SpcWtrsgMW
         c9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rrKSlyVb4A6GPV/8kpxdySjNQCOyxTwl/ARrGK6312k=;
        b=cJWolVhUNvbiOmgq5GVNkfrrjGBSSYaOFOhbY9KJL8bdWfL3U44zMNKy4Gp8B2evP/
         cMTSRud3lly6DDUfwkm3U12KYaL4VlFPOAtQ5kfJ6KAV22LROZ/JW+RKxZ8SM8xz9CHp
         3glbWOG9VSD+XxYb8W/Ip4iuBJvdRWTfrmdNQs980/FnY7kxDwSC78ON7mkefHnhKAe5
         iCr0MPnY4w7eS9xx3a9bhVpefae5k10p/kOo/ATKJgm5s85TkGtKkxJ8rCjoQxURdgaf
         /s9lDP96Y54eizhpEXC+mcKUSrp6mV2zQKXbZeicxewxqutl3jny+FjRNh1Y/B7XmP3Y
         x6ZA==
X-Gm-Message-State: AN3rC/789FxNCleSFQe9ub6yQXtJeLYWsjDdmtETXpknw6I7Z3WS5+RK
        5mootXas7VSFMRdxdnA=
X-Received: by 10.99.4.2 with SMTP id 2mr26752141pge.187.1493086255365;
        Mon, 24 Apr 2017 19:10:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id 25sm7085804pfr.61.2017.04.24.19.10.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 19:10:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
References: <20170414203221.43015-1-git@jeffhostetler.com>
        <20170414203221.43015-2-git@jeffhostetler.com>
        <870a8a36-fc6c-6b07-d09e-eec8a9f46a5c@kdbg.org>
        <8bde0b54-c0f6-364d-1f08-ce5207eb6c86@jeffhostetler.com>
Date:   Mon, 24 Apr 2017 19:10:53 -0700
In-Reply-To: <8bde0b54-c0f6-364d-1f08-ce5207eb6c86@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 24 Apr 2017 14:39:27 -0400")
Message-ID: <xmqqk269xmmq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>> +test_expect_success 'detect corrupt index file in fsck' '
>>> +    cp .git/index .git/index.backup &&
>>> +    test_when_finished "mv .git/index.backup .git/index" &&
>>> +    echo zzzzzzzz >zzzzzzzz &&
>>> +    git add zzzzzzzz &&
>>> +    sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
>>
>> sed on a binary file? Sooner or later we are going to run into
>> portability issues.
>
> In v5 of this patch series I used "perl" and it was suggested that I
> use "sed" instead.
> It doesn't matter to me which we use.  My testing showed that it was
> safe, but that
> was only Linux.
>
> Does the mailing list have a preference for this ?

Instead of munging pathnames z* to y*, I'd prefer to see the actual
checksum bytes at the end replaced in the index file.  After all
that is what this test really cares about, and it ensures that the
failure detected is due to checksum mismatch.

>>> +    mv .git/index.yyy .git/index &&
>>> +    # Confirm that fsck detects invalid checksum
>>> +    test_must_fail git fsck --cache &&
>>
>> You should ensure that this failure is really because of an invalid
>> checksum. The failure could also be due to an extra LF at the end
>> that sed inserted, no?
>
> I suppose we could, but I'm tempted to wait on that for now.
>
> Jeff
