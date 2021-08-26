Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90342C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A07660EE5
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbhHZVC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:02:27 -0400
Received: from mout.web.de ([212.227.15.3]:42477 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243600AbhHZVC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630011691;
        bh=RYsDl1hJe0vJ3ECp4YapQmjeVAPwzOCQ+RGOno3prp8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gnA8Wm9RQG4gwVr0Tx0vNGln5tlsAuuL29px+F/SY6OmEZHA3YOGZ4pRhO7/kLgve
         ZlEj/cISrUlBnX9CXWOeIIJnGMoGRWrH7wCOOKo1oclLQ/OjR45pOqH/3wXeb6hs37
         6eelqWHaWycHaa7/SPNU0hmIG5MfDAnabMa+Ptco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N2jaS-1n0Vt90YMG-013Mdp; Thu, 26 Aug 2021 23:01:31 +0200
Subject: Re: [PATCH v2] branch: allow deleting dangling branches with --force
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <325d64e9-8a31-6ba0-73f2-5e9d67b8682f@web.de> <xmqqk0k8do27.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9c999d1f-9263-965d-a0a1-527e1260a6d9@web.de>
Date:   Thu, 26 Aug 2021 23:01:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0k8do27.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iLJ2fYr6dqUt3sjOKU2EH67iiaG1KAljq4NFyX1DWSYcNtw1Hhu
 BTvpAMzVQEyyPM7ky6eHtjXaDwSSRaevyb6qghTbQs6g+uEyW6Wr7g1o7fd+a/5SZE8iEZW
 LSFwwLybc1eCMwrUso78hmza1LjC1417L4FbBhi11JcKPgrfVGvhBk//Mm34F9idVVDpuv8
 7zH4jyUgbAadBosS2+qfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:io/qF84nl0Q=:hNmRZN16OnWAFd42M3Tv7u
 Tt4NJX+nuHqqquuMBz8FAl5IpqqILccGtwygpejNQjQeGEbpaGvYAPxc/mkm3qPDXJtVXlIRy
 VQ5PtSmERAJVIHijT1jhFHlVIWebqODVGmh2It+ANrtP5dMsrO7/xAsyjTk7wuPnwcvdHsBd3
 PCZd9caAandgHauZBuS4AQaAshNCPGcCP2F9BOzJoSJjQPJYqdXAi7rIxWO4XMbbTeDc4OpaJ
 GyOg020XtIXXUjtb5dNpy/e7Ndt2I87cdB/k2mHRGbL2nI0PywXsJ7b36JKky7IroiiMKQMqD
 kCBK2O8nf3wLao0Ht2XFzFHOTPYLYVWhHCm2WPMx4+YRvzKPMUKHg/yb0Q0BO2aYgD+/l3cSK
 vhlUKvcO6eYxUD4oopQy0XvlUbbKL9W521y9PN0aGsunnMSamdjBQ80yMnGUWfLeAv9GFupjo
 h0NtHRZJD8k1HcPdShpy3NHu+qSKFCUhnHGXbFn9rm93ruJ6RBKQIIJXTT51q92qtSfB0q6tY
 VYLImE7hcl+WeI5AlTW7qdGas/IlIUpBr5d/7O9l0iJuU4bVL9vys6jMFI5cO1GD9PrznEGqo
 BXB/78h8KNRwAVIFTLWvU07wTOg0LUWhUYPmLzzBX+tcSJjvXYbT4m1AInU/9HQbQeNbNsXtY
 qByp810DrW5ylC1Is409yYPRrgcVdr681lxq7VsZpx8EzJPX2ImMsl1KVck6zJAysRCoQ/TxH
 d1O47yHAdjdAhaZiPQVLmVAr2jMkVwuZYD51VO12O66ajHPmZxR+Bg6zbqWIV/JgahgQMMzyj
 C3wY8qevrj6Hnvp708LJ/AdIADNPfRu7lVFJGvS5cSMPsj7ka9kGos6DjD/KsQhBWfu765l9R
 p/RKJWbCUXHRzo+wCxweRJYOTXt6D5vT4roPQdn2QlQ78vugEgqeePEJ+Moe6iuNV+hMnXWOQ
 g4WmrGnRQZ68W+ybIjH3zW1tki4KStq0xDZue3WgnSe8YgklipzSccR+x5eqYIPrnLe6ScN5b
 a3eTVlEedHGiRd+yji6VJh0bQg/hA4Mv1mjjoyV5FQGCN248qzj9Qm3AozvG04tkVN554up0g
 DRx5PvQIS1Ecj4A34He/Mh7TZ/AfYUS5uHu
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.08.21 um 21:05 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> +	hash=3D$(git rev-parse HEAD) &&
>> +	objpath=3D$(echo $hash | sed -e "s|^..|.git/objects/&/|") &&
>> +	git branch --no-track dangling &&
>> +	test_when_finished "test -f $objpath.x && mv $objpath.x $objpath" &&
>
> Do we need test -f here?

If the mv in the next line fails, then test in the cleanup prevents it
from adding another confusing error.  So it's not really needed, but
kinda nice to have.

>> +	mv $objpath $objpath.x &&
>> +	git branch --delete --force dangling &&
>
>> +	test -z "$(git for-each-ref refs/heads/dangling)"
>
> It is not wrong per-se, but maybe
>
> 	git show-ref --quiet refs/heads/dangling
>
> is more straight-forward.

Actually it *is* wrong, because that check passes even if the dangling
ref still exists due to for-each-ref checking if the ref target exists
and just erroring out if it doesn't.  I somehow assumed it wouldn't do
this needless verification.  So we'd need to check its return value:

	git for-each-ref refs/heads/dangling >actual &&
	test_must_be_empty actual

git show-ref fails both if the ref is missing and if it's dangling, so
we'd need to check its stderr to distinguish between those cases:

	test_must_fail git show-ref --quiet refs/heads/dangling 2>err &&
	test_must_be_empty err

To avoid these complications we could ask git branch itself:

	test -z $(git branch --list dangling)

Ren=C3=A9
