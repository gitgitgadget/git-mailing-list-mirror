Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66B21F516
	for <e@80x24.org>; Tue, 26 Jun 2018 11:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934850AbeFZL7h (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 07:59:37 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33767 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934771AbeFZL7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 07:59:35 -0400
Received: by mail-it0-f66.google.com with SMTP id k17-v6so15161883ita.0
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3unNTjV1Mkx2W8i7NRy9Tz3NgSjdIyzqTjdyfUgi7nQ=;
        b=DsxpQqeYKg8Dimh2jNt5XA/ZRlYn42OlFTo0CEtlCnJY+VgdFsPhFO4XDimNb1+0Jp
         rX7EqVODC+kdwJ1GcJW7Hzd1wUDMz7c02fEI8ZjmhnaoIDYL+f83btutXU0s1WRdEYAV
         IuQi9gPyfZnI3wN+xuvllSfScVugFpZ1lPWHowwMVmd41w5QPpZxYDaZxyLg1qBTpUt+
         ZG1Faax3GWQNGUoC4ONQq8/QXz31reiO1KVsX4/FyYZvibEYKBPFd14OzMxnD1hRYefM
         /xybPDC/80HBsD6QBuP8VMJBPC6Ow9A+7ylcywbYK6+t30c06pdCLWTbZvoa7KzlV1iJ
         qsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3unNTjV1Mkx2W8i7NRy9Tz3NgSjdIyzqTjdyfUgi7nQ=;
        b=lallO6yIhJXNAXCsXLcP6smWxKGxCVeEw7u7m+bmwvXJts8j3XSID80HviVsFvuskm
         MN09eRe/EKN3dvbgaI9zZiQcTQRENY43sPhvVjqrbVRPxNL7wVsu4yjW5e/CpjQ0pntn
         UTz+YUhq4wa5xV+KquEuyiZx0Fs9+EQR047j6N1kPSL35Aipg98yr3VqOm+N0I92VukA
         8gC70e63BiDv1mHrgwhghpZ8073pTbY3MIpTiiScoqWcvZphioXnI/GuHioziEq/FtpD
         cgUNb9lJ/cPrAn+Z6kwdCwwoEu0LYSaD6mXEc/biNxRogUzZCZFXxI2acWLUwpBJvRZN
         U3/A==
X-Gm-Message-State: APt69E27w2RoCbhR3aYXkHdx73l/vlF9qyi7RmbiI7sOHIWq5gFNEOBt
        1sjhvoWAEUOI921bQNeUOG9nYDJ9DdABjEqUid8=
X-Google-Smtp-Source: AAOMgpdQG7/ZWw1JbXHzkW6/ECBTBfF7NOLEwV3B/9WOl8HIh7sD7w0B7k0ZoHF6DXgJZ07gf/dKVrIh6AGpf4IWd/Q=
X-Received: by 2002:a24:6bd7:: with SMTP id v206-v6mr1057030itc.129.1530014373600;
 Tue, 26 Jun 2018 04:59:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 04:59:32
 -0700 (PDT)
In-Reply-To: <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com> <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Jun 2018 13:59:32 +0200
Message-ID: <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tiago Botelho <tiagonbotelho@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tiago Botelho <tiagonbotelho@gmail.com> writes:
>
>> +test_expect_success "--bisect-all --first-parent" '
>> +cat >expect1 <<EOF &&
>> +$(git rev-parse CC) (dist=2)
>> +$(git rev-parse EX) (dist=1)
>> +$(git rev-parse D) (dist=1)
>> +$(git rev-parse FX) (dist=0)
>> +EOF
>> +
>> +cat >expect2 <<EOF &&
>> +$(git rev-parse CC) (dist=2)
>> +$(git rev-parse D) (dist=1)
>> +$(git rev-parse EX) (dist=1)
>> +$(git rev-parse FX) (dist=0)
>> +EOF
>> +
>> +git rev-list --bisect-all --first-parent FX ^A >actual &&
>> +  ( test_cmp expect1 actual || test_cmp expect2 actual )
>> +'
>
> I hate to say this, but the above looks like a typical
> unmaintainable mess.
>
> What happens when you or somebody else later needs to update the
> graph to be tested to add one more commit (or even more)?  Would it
> be enough to add another "rev-parse" plus "dist=X" line in both
> expects?  Or do we see a trap for combinatorial explosion that
> requires us to add new expect$N?

What about the following then:

test_dist_order () {
    file="$1"
    n="$2"
    while read -r hash dist
    do
        d=$(echo "$dist" | sed -e "s/(dist=\(.*\))/\1/")
        case "$d" in
            ''|*[!0-9]*) return 1 ;;
            *) ;;
        esac
        test "$d" -le "$n" || return 1
        n="$d"
    done <"$file"
}

test_expect_success "--bisect-all --first-parent" '
    cat >expect <<EOF &&
$(git rev-parse CC) (dist=2)
$(git rev-parse EX) (dist=1)
$(git rev-parse D) (dist=1)
$(git rev-parse FX) (dist=0)
EOF
    sort expect >expect_sorted &&
    git rev-list --bisect-all --first-parent FX ^A >actual &&
    sort actual >actual_sorted &&
    test_cmp expect_sorted actual_sorted &&
    test_dist_order actual 2
'

This feels overkill to me, but it should scale if we ever make more
complex tests.
