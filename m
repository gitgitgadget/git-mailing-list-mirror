Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9DB1FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 15:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755152AbdAAPYw (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 10:24:52 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35443 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755109AbdAAPYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 10:24:51 -0500
Received: by mail-qk0-f193.google.com with SMTP id u25so43875254qki.2
        for <git@vger.kernel.org>; Sun, 01 Jan 2017 07:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LQ6QB3jJwSikD1Cd3dNXVSCWN+4aDy9B8DJ9g0/ETts=;
        b=LrgPjg0GSDxsUgsJ8kFf47CsnJFxNxw9veibGsi58EIyBCKAwlpsjr9hZTKW8qo1ni
         t7WE5fBLeYl88oO9um8TflxsOTAAY4QCCfO6t5EEUhbThALBsycy1PL4g32dQDg4wh5B
         EAZiNairAm2VSW7L3o/2fdMh06DXpGnw4VyJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LQ6QB3jJwSikD1Cd3dNXVSCWN+4aDy9B8DJ9g0/ETts=;
        b=piFbnGSVMhwkJrJHc012Z9dtX246H/CWrZF6LB0qaVHs7R6bM5Z21z0j/l+u3vEbwo
         eXw9WnlpnN/SuF4y2okK0UDgrgLeQZmvlyfWXqk5yWsFlTxi94i00hkCQhD8s/0xjMkP
         lMVZQap0ZRR8+Ltbl2YreunR2vBOkqxpSKrpdOXlg2W7Q7VAPD4l+lekICzFmHJUdLZX
         j5DzFqgWxN3/JCs9L146FATCR9QAhWBM5EH8bpJjKmfDRcmZ6PDGEc4MYOcquKQ9Rq3L
         gStITxD8cjCK1wSlSOWnR/Y+PcMm33YQ0ty4WG67CzOF9BIRkmJpfdBlW170EoZPfBdZ
         t6FA==
X-Gm-Message-State: AIkVDXL42nlJKeVlMofPXM4ALpMGSr1WRyYcCIMsitI9g6uyMVOgj7dd1IIjUknHxhxKHYEXClL5fKn4/N89Xw==
X-Received: by 10.55.132.67 with SMTP id g64mr33030894qkd.153.1483284290400;
 Sun, 01 Jan 2017 07:24:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Sun, 1 Jan 2017 07:24:49 -0800 (PST)
In-Reply-To: <285ed013-5c59-0b98-7dc0-8f729587a313@kdbg.org>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
 <CAE5ih7-7e+ZLUbE7iquWV2=qP4ofzAHUC2ZPg3b-ivSpCo4eRw@mail.gmail.com> <285ed013-5c59-0b98-7dc0-8f729587a313@kdbg.org>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 1 Jan 2017 15:24:49 +0000
Message-ID: <CAE5ih7-b7LpPYPkuDnJakb12LPZ5UE2TeV17aYXAsbP2aH5zEA@mail.gmail.com>
Subject: Re: [PATCH] don't use test_must_fail with grep
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1 January 2017 at 14:50, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 01.01.2017 um 15:23 schrieb Luke Diamand:
>>
>> On 31 December 2016 at 11:44, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>
>>> diff --git a/t/t9813-git-p4-preserve-users.sh
>>> b/t/t9813-git-p4-preserve-users.sh
>>> index 0fe231280..2384535a7 100755
>>> --- a/t/t9813-git-p4-preserve-users.sh
>>> +++ b/t/t9813-git-p4-preserve-users.sh
>>> @@ -126,13 +126,13 @@ test_expect_success 'not preserving user with mixed
>>> authorship' '
>>>                 grep "git author charlie@example.com does not match" &&
>>>
>>>                 make_change_by_user usernamefile3 alice alice@example.com
>>> &&
>>> -               git p4 commit |\
>>> -               test_must_fail grep "git author.*does not match" &&
>>> +               ! git p4 commit |\
>>> +               grep "git author.*does not match" &&
>>
>>
>> Would it be clearer to use this?
>>
>>     git p4 commit |\
>>     grep -q -v "git author.*does not match" &&
>>
>> With your original change, I think that if "git p4 commit" fails, then
>> that expression will be treated as a pass.
>
>
> No. The exit code of the upstream in a pipe is ignored. For this reason,
> having a git invocation as the upstream of a pipe *anywhere* in the test
> suite is frowned upon. Hence, a better rewrite would be
>
>         git p4 commit >actual &&
>         ! grep "git author.*does not match" actual &&
>
> which makes me wonder: Is the message that we do expect not to occur
> actually printed on stdout? It sounds much more like an error message, i.e.,
> text that is printed on stderr. Wouldn't we need this?
>
>         git p4 commit >actual 2>&1 &&
>         ! grep "git author.*does not match" actual &&

The message is actually part of a template presented to the user via
their chosen editor. For this test, we set the editor to be "cat", so
it comes out on stdout.

Your first suggestion would therefore be fine (and similarly for the
other cases).
