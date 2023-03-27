Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF1C6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 17:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjC0RXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjC0RXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 13:23:46 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9553C3F
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679937816; i=l.s.r@web.de;
        bh=UamConE/7bFCDza4mS1n/GM3QeaeWdypEjt4j4g/T7k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=C+vTN/9Z80roxhKw7UtthHv2s5fy7Ff/HVInE0p7recaJLgn13ICcprecjB6cKaFp
         7SIzg7qjV8OTopIBIlNmbzQrIJQHKlDpiirBMeQKtiDkikQkxaZmDqlnskmqMYkCQ4
         2rWmBMin4YOYbIw2v5lxX1cxNWcjDOFp69HBAF8glSWv2HxGqwOTpYVkQSitmVAwUL
         /p7MsXZ/GUn23vVX8YurXDa7/0H8JuASVJcuW3cNVuR/o48KWgAgXqU8fllHkCaaH9
         1KN3I9EFWlv/6cGgURut2hhqt0+PZHX0YBfyhEX/zwB6MEDpvw8L85fhABA6tU9XQB
         7WWEvWJNKkEiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFdB-1q0rUR17kJ-00KW7E; Mon, 27
 Mar 2023 19:23:36 +0200
Message-ID: <03fd7ddb-8241-1a0a-3e82-d8083e4ce0f7@web.de>
Date:   Mon, 27 Mar 2023 19:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mario Grgic <mario_grgic@hotmail.com>,
        demerphq <demerphq@gmail.com>, git@vger.kernel.org
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
 <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <eba23dc4-c036-fd1b-a1f0-028e8fff602b@web.de> <xmqqh6u6cg4l.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh6u6cg4l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+w1fTl/uo5ALFClzZw8/NGw6YlCBq+kRX8dYMAK6PNaZtfxfn6K
 LVeiw89ahGNOhklUJ/94wYYLjj1H/hL2FCYsCfSUuGhg2QirFjVY4skpNz4/dODckmDuWu6
 FKVItuZ2s4ffcOKkr39hJVwoChz23NFotAWLOxXDhNEhZUdj78y5rQkyZ1hi/swIm0rjBTx
 eEOvNfVFgD6m3g+awCqWQ==
UI-OutboundReport: notjunk:1;M01:P0:26X8Xk7Kb1w=;dDGLIEtPknXndk3O7f53tbyp7ah
 uia196V4/RnXQw6qUUqq/OaXHtT7iaEh59rJchGrpu5F7c38NG3hXfmcMGc4Dn8USooa0TF6G
 oSvW+LTIaOBGr/+MF0he8pKHzrcFOAtfcCc4C20ZRwJDyX5/r/geJQss1n5Oe7OuvDot8cUZR
 aoKQT3j2jB24O0Y0r0sW8AXEGe3wXrnSlLwaUW6n94lEFXox6CPIQKY9328p4Y0VB+ui5vm+B
 ImzmJAdk1yhTeYQjvlKg4gVhhH5Fo3e6/UJwMBVTLaGirZ1Jx3APXU9bNbL3tsVR6hwMEsRsU
 dOfmpvdQpl4q22I4qRMvn6jndbroOSvAhzf27YfGf8m8QCLSDz1VcZpFO1aNyfjPE6M/DyTLz
 c4w+blZbZKthR7xqKyQU0kZ1jKgcuXFFNR1iaJSGnT9wnozqvnDGfhPz3NfNJ04f2nSpV3joR
 kq4H0vStPC4acAmIDkwZxYBmiJ9K/f+eOzaO+u2XxcPPhnLNyIrAsaLM/Pu4juhqaiNoAojKm
 rnfFaE1EKdl8aAqlngBkTm3zqKBjQQ93Ax7erVM6nkYjn/p/eq0+E1kxQXzYtY3BuSu/nOG2W
 aMIr9fXEvOLSAnybpsssxK0Rl34T0MqrbWKD60Lfsv+LYa/4QkErAVxF5GpyLRW8+3vI6x7jw
 1rPQfpCiKZ3WUZ5u4G5mHYgV5z21/92vcO+6KwiFBqSn6FXirzpk+z5wJ5yVaaBtSXq67phGE
 dTzII9J2i8RwPIC1aIHtL+RYY9VQaqQXZHxzpLq4MoaaT6kUIED68FjBki5V1shPR4XCwf4GD
 sFuouTIFkKOIovGEQv01Pr2AK0lNkQZiFSa/znueQs4ulqXh1nJKVZrSY8h+Wdfq4MSu34TXY
 WeAWigyd6sUZgKupA4t8+FJj81SUx1z/2618RwteYdyoNFMel0XS3auhEsPAywzfBoG5PtV9Q
 Xd+t08XhkM3L9gW7w/0YWlg2gpg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.03.23 um 18:29 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Or to enable REG_ENHANCED
>> for them, at least, like 54463d32ef (use enhanced basic regular
>> expressions on macOS, 2023-01-08) did to get alternations for git grep
>> on macOS.
>
> This one sounds like a reasonable thing, which may not have huge
> unintended fallout, to do.  I am a bit surprised that we have to
> cover each individual callsite of regcomp(3), though.  Doesn't the
> 54463d32ef fix use "#define regcomp git_regcomp" to cover everybody?

54463d32ef only affects basic regular expressions (BRE), but -G and -S
use extended ones (ERE).  macOS allows both to be "enhanced".

I have a hard time finding a readable reference to the documentation to
brings us all onto the same page regarding what REG_ENHANCED actually
does.  [1] is in raw troff format, [2] isn't very pretty and shows ads.
Anyway, the rather lengthy section "ENHANCED FEATURES" explains it.

Ren=C3=A9


[1] https://opensource.apple.com/source/Libc/Libc-1439.40.11/regex/FreeBSD=
/re_format.7.auto.html
[2] https://www.unix.com/man-page/osx/7/re_format/
