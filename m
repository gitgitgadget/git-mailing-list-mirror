Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0886B1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 17:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbdLKRN5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 12:13:57 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:37313 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbdLKRN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 12:13:56 -0500
Received: by mail-wr0-f171.google.com with SMTP id k61so18354485wrc.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Dv45GZpAzBLZr/BzsYua6oQO00dUQE7ipBzQeIEzBJg=;
        b=RavbEb72E/HMxV33vCxAt4DjtgeYhQVqDQgTSHOHrd9xZkuPKXTNdX2H5cwjzksFAn
         N8behy6dY9MXuVneUt1hNUEx6K8PJahoT71COlwYb5HHhn/oNVcFzmDW+t944nq4Cejs
         FkKFXrhdtZDYuDlpPEhTyH/UkUzIFOLDAsl/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Dv45GZpAzBLZr/BzsYua6oQO00dUQE7ipBzQeIEzBJg=;
        b=PhJmNdTbOrHnvFJNQjO9eTvrFNaBpYt8FnWYOt4btN46JNcx2p7KflMDD/HeGThIJy
         IXnyWfM0v/kimfJJIXH/171Q6BZhmYG/b/llySkWv2fBmsqQPzJNzttiq/njvrm2He1N
         RrqmAQ7Nr/UmQPP6moHCuE3a37oQy2//udwJIx7Z9Ih8XP5f3HJnXId7/7mQLavTnLvV
         3uRzXlHIg2gS4GkqLQBmjrZmXb79FkwygpgO+OWz4MzLogvL+2B+0HoPFrp44FVHarKA
         ZgFX001zpqmxvJz7X1/vIDNd6LeaLvXlyAScAwfGUK4pij2/57WaDtaONJn0bl4H7MUo
         ccuw==
X-Gm-Message-State: AKGB3mLmOiq6mkhMSXWJLeOMrb0LhJIXHHuDpmqx+iCd+Tlw/O9BQd+O
        EIM2r05LpCrw/Mz2HM7Tw4Wp9xEtUcs=
X-Google-Smtp-Source: ACJfBos7zJZhkjq7yBOacNPWyC8mHa2OdzWLAVsK2EsPvotmHQvz3j/YC0jk569B+e2slx/CRZ4bbg==
X-Received: by 10.223.157.138 with SMTP id p10mr1177924wre.28.1513012435324;
        Mon, 11 Dec 2017 09:13:55 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r3sm10075962wmg.31.2017.12.11.09.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 09:13:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 838D23E041E;
        Mon, 11 Dec 2017 17:13:53 +0000 (GMT)
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com> <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop> <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com>
User-agent: mu4e 1.0-alpha2; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Adam <thomas@xteddy.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
In-reply-to: <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 11 Dec 2017 17:13:53 +0000
Message-ID: <87mv2p89wu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Thomas Adam <thomas@xteddy.org> writes:
>
>> Trying to come up with a reinvention of regexps for email addresses is a=
sking
>> for trouble, not to mention a crappy rod for your own back.  Don't do th=
at.
>> This is why people use Mail::Address.
>>
>> https://metacpan.org/pod/distribution/MailTools/lib/Mail/Address.pod
>
> Now we are coming back to cc907506 ("send-email: don't use
> Mail::Address, even if available", 2017-08-23).  It argues
>
>     * Having this optional Mail::Address makes it tempting to anwser "ple=
ase
>       install Mail::Address" to users instead of fixing our own code. We'=
ve
>       reached the stage where bugs in our parser should be fixed, not wor=
ked
>       around.
>
> but if it costs us maintaining our substitute that much, it seems to
> me that depending on Mail::Address is not just tempting but may be a
> sensible way forward.
>
> Was there any reason why Mail::Address was _inadequate_?  I know we
> had trouble with random garbage that are *not* addresses people put
> on the in-body CC: trailer in the past, but I do not recall if they
> are something Mail::Address would give worse result and we need our
> workaround (hence our own substitute), or Mail::Address would handle
> them just fine.

Ping?

So have we come to a consensus about the best solution here?

I'm perfectly happy to send a reversion patch because to be honest
hacking on a bunch of perl to handle special mail cases is not my idea
of fun spare time hacking ;-)

I guess the full solution is to make Mail::Address a hard dependency?

--
Alex Benn=C3=A9e
