Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700AB1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 22:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeAPWU4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 17:20:56 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43534 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeAPWUz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 17:20:55 -0500
Received: by mail-yw0-f196.google.com with SMTP id x190so7455587ywd.10
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 14:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0fXH6Pzc1QiKFxv8O84ssRlDAoMsq0HyM5T4xuUOop8=;
        b=Eg4U2PB0snDmevjtQqGnIMIudnBtmQDaJzx55qmh/mzcDFeBeo5uC/owZkp4Dy+ooK
         UcY0TH9KCGGYfwnf8euPj2i5SwP7KhPhrV6GnigL4TazEwUllAOuR8Ex6Dg3cCw3IHs3
         r3mKmEKEWjrsvreyOJDuD6nzmNRPSCYx4VdXCC0n8IMPO+2+QUiS6PVStR3tF0SCY7+P
         qX6LKEW+5CziJmxxr7CppJ0uDA9e42wwrEyK2o2PFWqejq9kXUkkWXdGmRUkTq9KpJK/
         um8svgNUfi6xBvQmZhGatAg0e8OdpfHKXomkySyzAS053LP5uK9EXW51i/ZvxsdjrQil
         fjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0fXH6Pzc1QiKFxv8O84ssRlDAoMsq0HyM5T4xuUOop8=;
        b=I5iBu0sDN4xD7uLrs5+bNN2aRp6FuXb/QUaE0kAAqq3/7nFvqEop1Tso0EHA65RPfp
         LkyOkQbPCgLWpiRUzqFXYUNxtMHc6K62UGXMdkPBXw5tT8t8/72Wv3Br52fOeGeh//GB
         gJRNnu9sJriWnC5TNUivk1hNjMC8i805sQzAVC2+nheR2Fd4nOl/rFUZ2Z1BbtBbNWFT
         QudwRnzjJIkKk+Pd2Yn5Q00K6wb/9vkqAxwVeVNo77wScYObsPF30Dfen3+tBWnN/ZVe
         2KiE4RPDyeAuJeP59zftxStdzqzHgZuBBQdvHIKx+z/oSJ1GAftZaELoa1A+RWfQouxC
         n9gQ==
X-Gm-Message-State: AKwxyteojm6oAGu2qIVMSrL/f/RyRu7gFzadHe97W/jZwUc5OdEZTiZ4
        kenIxM/3xXobuyI39oXxJ72cI7w4q2fEZjZWb+sM0Q==
X-Google-Smtp-Source: ACJfBouY9v4hMM9JxICv8xBqd2XmPkkGQc68WtiXQM9rA8Opbyo17WQttkhT022YA1dTrGtUbz9BkbCjkFvQw5kLAZE=
X-Received: by 10.129.108.196 with SMTP id h187mr653525ywc.249.1516141254468;
 Tue, 16 Jan 2018 14:20:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.134.197 with HTTP; Tue, 16 Jan 2018 14:20:53 -0800 (PST)
In-Reply-To: <xmqqmv1dtptj.fsf@gitster.mtv.corp.google.com>
References: <20180112095607.18293-1-pclouds@gmail.com> <20180113064949.6043-1-pclouds@gmail.com>
 <20180113064949.6043-7-pclouds@gmail.com> <xmqqmv1dtptj.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 16 Jan 2018 14:20:53 -0800
Message-ID: <CAGZ79kbWvxoBtcU9iKPHSy_Agz-ko_KSE_M9budrtCOq7-Swdw@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] trace.c: print env vars in trace_run_command()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> +test_trace() {
>> +     local expected=3D"$1"
>
> Style: "test_trace () {" is how we start a shell function.
> Portability: we do not use "local".
>
>> +     shift
>> +     GIT_TRACE=3D1 test-run-command "$@" run-command true 2>&1 >/dev/nu=
ll | \
>> +             sed 's/.* run_command: //' >actual &&
>> +     echo "$expected true" >expected &&
>> +     test_cmp expected actual
>
> Consistency: everybody else in the test script contrasts "actual" vs
> "expect" (they happen to be of the same length ;-); don't say
> expectED just to be different.

3491 entries in the t/ directory disagree with your imagination of
consistency. ;)
But I agree that we want to go for consistency, and most likely it's
best to go for 'expect'.
