Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380651FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 16:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbdBPQ7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 11:59:33 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35085 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932338AbdBPQ7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 11:59:31 -0500
Received: by mail-pf0-f195.google.com with SMTP id 68so2005766pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 08:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=577GaQ5rj5rOPrPGIzRGFPtLAdQw8jtkrjqDKeNwPSQ=;
        b=FFwcIJG5K3W1OAMpVG5sWDuk5RF4MFJ57sS+aRPnyMd8R56XD1xDNwISW+mGVTAt6n
         Uf4zU7u7AQvlKvSTNZe0dNrwxPC8Atyl3Nph9HL9zezppJH2yV/MYe4SMxj8/AlPVD8H
         8wiYwywe6aDEIDblPaq+xiziO/PwxEK8rAJwWSjqtnjcmYr9v4QhCTJt41FfTHSW0j07
         YJe+iRhNyqT7vhC61IjgdJoEd2S6yMabNZDFpbVCtfsV6kdJs5Ys0wi1J1GruUOaUNVc
         1fZ2XTph5blGzWkqiXuaaBLeT2aWaFjYPQuQMGfZqKGzsKXvLFbs3/WIMAaXJBL5LUwh
         d13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=577GaQ5rj5rOPrPGIzRGFPtLAdQw8jtkrjqDKeNwPSQ=;
        b=WZo1Gb7PtAx4ghPvMriCeNwjoWAvOCYhtdxKYwcvgYsHHPsUyAOMSRn9poNfOa82Fn
         Wy8ThUGyovyzFUw2pyM8RT43zvJlMgmC7IOlCSp9KFQt2tZ8FfHq7Ra673p0JgK3Vrhb
         jF3jD+Ir/Kii7x24wAd/cuBqtdxh7I0GOabHB1heuRiczP1oj7ORXD7+qUCO9t7Q5dbH
         0BBOjQTWUEHhnqRp3OTCdy6lbrZXMpxvq8JrCDumK1Ei/6lZa+1zNjrG93ABDvLMPIbU
         aWljso7mspWDx6NOWO8rRXqVy99lItfSJ+zNCUssxqxBFYRr2E24W7h4rh0VUklKabQr
         TSEw==
X-Gm-Message-State: AMke39kXBsocc0zcg68vonr0LA2AwekdhJfFr1zo1IOVrQ2qUUf7dUbavBPlFTOSapPr/A==
X-Received: by 10.99.130.67 with SMTP id w64mr4041537pgd.194.1487264371004;
        Thu, 16 Feb 2017 08:59:31 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id i21sm14677073pfi.94.2017.02.16.08.59.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 08:59:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH] config: preserve <subsection> case for one-shot config on the command line
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
Date:   Thu, 16 Feb 2017 08:59:29 -0800
In-Reply-To: <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com> (Lars
        Schneider's message of "Thu, 16 Feb 2017 11:30:28 +0100")
Message-ID: <xmqqlgt6ysum.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 16 Feb 2017, at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> The "git -c <var>=<val> cmd" mechanism is to pretend that a
>
> The problem is also present for gitconfig variables e.g.
> git config --local submodule.UPPERSUB.update none

Yuck.

> But your patch below fixes that, too!

Heh.

> Should we add a test case to this patch?
> If not, do you want me to improve my test case patch [1] 
> or do you want to ditch the test?

I think a new test for submodule (although it already exists thanks
t you) is  a bit too roundabout way to demonstrate the breakage and
protect the fix.

We'd perhaps want some tests for "git config", probably.

In a repository with /etc/gitconfig and $HOME/ that are tightly
controlled (I think our test framework already do so), running these
would demonstrate both breakages, I would think, but I am sure
people can come up with other forms that are a lot easier to read..

    $ git -c v.A.r=val -c v.a.r=ue config --get-all v.a.r
    $ git -c v.A.r=val -c v.a.r=ue config --get-all v.A.r
    $ git -c v.a.r=val -c v.A.r=ue config --get-all v.a.r
    $ git -c v.a.r=val -c v.A.r=ue config --get-all v.A.r

Thanks.
