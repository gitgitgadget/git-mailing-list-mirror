Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1551C433E0
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 12:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EAA20885
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 12:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XvXNN1Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGDM4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:56:32 -0400
Received: from mout.web.de ([217.72.192.78]:58587 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgGDM4b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 08:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593867389;
        bh=eBLfUXkpW4VgHVJhyzla2fzxOZtU8sbFX9XJBoOk8jA=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=XvXNN1Qq89Gh/E9TVs8lHTeO7oA72tIx/sUq8g+sYCE4vUnISAvI5cw57ZEdoSeP5
         i3K7JrGjYUWFV/AOBRxQ6Rwl21hDoWfGg5YcDushdQafEBaszXny0238eTBmK//O3g
         BVosD3lKwnTcHQw0DPmPw1WJLB6/csLoG63sok74=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSai0-1kJ5vF2XvY-00RXbe; Sat, 04
 Jul 2020 14:56:29 +0200
Subject: Re: Git log: filtering by date and by lines do not work together
To:     =?UTF-8?B?0JzQsNGA0LjRjyDQlNC+0LvQs9C+0L/QvtC70L7QstCw?= 
        <dolgopolovamariia@gmail.com>
References: <CAD6JL5SRvB_yXcqJ5HGADQaGtZAiKrtd447vtHLSagJqNGPChA@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2c4a6657-1a47-cfbb-21cd-04f131d2ed49@web.de>
Date:   Sat, 4 Jul 2020 14:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAD6JL5SRvB_yXcqJ5HGADQaGtZAiKrtd447vtHLSagJqNGPChA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vY2NdfRyc+PORZKKl3I9OGFpDyHlSE2/zErqxdIBg7mmMzvnxjZ
 GQUoQBUH7I51YGi10wjvZblp6sib1lZPJc9888CJl99qdMKaCglYmUTBnNN+1r3lcCUALZY
 4prL/eJNBFsepoQFlPM0oN9T1kcaQ1/vh7iqrKnH+cCYvDa9JhR1RYq+IwCmo7UX/+EIKO/
 5ZDzJfCvEU0lk1IAWXMhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o3IIquOlPjc=:oiMo4csjsxFZx9lKkx6wuW
 rduu3PNon5aStXu1JTlhVMuOPVF1SpwgdZB6HFc7liQP8BM2Sg9LgHrkH3x0CXWbLspxhFRXm
 LegyzzYKT1XfFRD+vR9Bre3T/OlEjVJOx8dQHBe9aV+uXoHqT3mTw/BcH6wJ1uJ2HhytwXg3Z
 DS3gG7mIjsZAIZmXgTDwjJxfsHCR8m753v7dACBwywb9pF7oxKinXI7CU6bsAq4fjOhXmDVfZ
 6gUZCfUJ8QlxG0bEDQM++znhl/iYVZvc12aJ0I2XdgmwXcDeW9WwzhZgMpl+huN3MM55nFLmc
 SHI0hIn3wdLHj+vxbtoVWsz2BSX4RPMPRdhHJrXVzwmcBx1eIwrbxqBMRs/tuIichdZOoZVrC
 irrNJdYASIhvTBtStaLyS0d7Q5VVo72uSv4G/TgZSGmlT6MjNBaim00q7e/dbC6OCpxBzoDgN
 wpecCAPXzhy8vh20H5CGyNihh/f6FmP7K6qF4hjEP5QWXyXoNLxhw96TARbOyVz38V2lrspw0
 SuM3XB9+eCYiA2KyLHUHNMeNgwTH+JdpGOzv01B2xq+Aw3rgRGzu2npM5wzFOV6I4evpWDxFf
 /SH0syoRf01QLUGMYeLSA3OCIQiHELb+X9MZbsZWDDVQ102tWH88ZAVElC2Jqbmel8g33tz2z
 8NfmW1KPLx6qIwbVpYJkZdtacIo/VsN9CfcfhlUvdpuZOIqvy60KkTdKOHez8Sejdhkxf5bJV
 NdcnjEtcUABENzN+qqJH5PNywNe8clEleogDwzS96tk6xzh093liNOT8gJpcbV0DLzHSNsH0U
 gMwUyqUvq0CphrYeKdDWIvAuHHBfiT4kHzvwfIBJTf8J5IJOvt9i5QKTXFhvVo/Xkrcet9vB3
 L03YUmaVkqeEgzb6U7RwT3rFCUp8UCBF7RSpmpDN9/E2jrbfCUsjrozi4+jzPZnLcgTm3U5R/
 kD66JFpFj3RL9ym5aBEcS5lria+Qy2eGhNNnfGkePbJfTtt2DrNTvYFi2JESXrIdtlZ9jfqPR
 bTKt0ApDbyoHiynDNQ0mww789R1x7mVOacw5pJtp3qw/fpbiVEzUkb8eMy3fLEzMUiAkJ5FB+
 hXOraChVjL2Q+EcDR5SbqA+1XPZwacglRJpj5f8nyoevSHBA4q2xNwBJPq8vLK+vJ57Jrv63J
 N5mp4qFpv7VU+tkc+OKGZzYI/4p30ij5WoGK0+iVTfUwVfgmig65QOgNSi485vOvB0Uaw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.20 um 16:14 schrieb =D0=9C=D0=B0=D1=80=D0=B8=D1=8F =D0=94=D0=BE=
=D0=BB=D0=B3=D0=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B2=D0=B0:
> Hi! I would like to report the bug.
>
> I want to get commits that change specific lines in a specific file
> and were made before a specific date.
>
> Steps:
> 1) I apply filtering by date: --before=3D"2016-11-18"
> Result is in the picture FilteringByDate.png. Commit
> 570778797effd69bd4536c51125b7d2e8f654c08 is presented.
>
> 2) I apply filtering by lines:
> -L33,34:src/main/java/org/toradocu/translator/Subject.java
> Result is in the picture FilteringByLines.png . Commit
> 570778797effd69bd4536c51125b7d2e8f654c08 is presented.
>
> 3) Finally, I apply filtering by lines and by date:
> --before=3D"2016-11-18"
> -L33,34:src/main/java/org/toradocu/translator/Subject.java
> Result is in the picture FilteringByDatesAndLines.png . Commit
> 570778797effd69bd4536c51125b7d2e8f654c08 is NOT presented.
>
> Expected Result: the commit is presented in filter 1 and in filter 2,
> so it must be presented in filter =E2=80=9C1 AND 2=E2=80=9D
>
> Actual Result: the commit is NOT presented in filter =E2=80=9C1 AND 2=E2=
=80=9D
>
> Environment: git version 2.27.0.windows.1
>
>  I beg you to provide me with a workaround. I am doing research work
> on analyzing commits in open source projects. Therefore, this
> functionality is very important to me.

You could do the date filtering on the output of git log, e.g.:

  git log -L33,34:src/main/java/org/toradocu/translator/Subject.java --dat=
e=3Dshort --color=3Dalways |
  awk -v before=3D2016-11-18 '
    /^[^ ]*commit/ {state=3D1; header=3D""}
    /^[^ ]*Date:/ {if ($2 <=3D before) {state=3D2; printf "%s", header} el=
se {state=3D0}}
    state =3D=3D 1 {header =3D header $0 ORS}
    state =3D=3D 2 {print}
  '

This command is a bit unwieldy, so you might want to put the AWK
script into a file, then you could use it like this:

  git log -L33,34:src/main/java/org/toradocu/translator/Subject.java --dat=
e=3Dshort --color=3Dalways |
  awk -v before=3D2016-11-18 -f gitlogbefore.awk

Ren=C3=A9
