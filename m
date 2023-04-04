Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B94C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 06:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjDDGrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 02:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDDGrE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 02:47:04 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16022729
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 23:46:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id B809F3C09FA06;
        Mon,  3 Apr 2023 23:46:58 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dRGahyowkSL6; Mon,  3 Apr 2023 23:46:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 50CD53C09FA08;
        Mon,  3 Apr 2023 23:46:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 50CD53C09FA08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680590818;
        bh=OPKGbZHEgoMi8NRsw8a0G2vgxL3IygYevxOn970mno8=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=SzxiOLdccdooebFoT64zRlOK1yMXrRpaZZTb6G913crnXjlaCR9GtOg7enjqjrHRK
         dK4wVg8cHY1IiOyaP/vEPnM4n7aMZUXu40/SZ6H7gTZbJKQH7qECPXC1QoDbvfyAmo
         WKPy28P+4mI1eAGN0UlagJWtNNmlB7GcLnMm2nGGfV3DqqKcCzgBxnLp94pzrMBDj/
         c+U9KvQtBHXCFeOhE/X8i+HyltGsZr23a8t2L0f9bA8EQezx+KHCSB4dVoB4MO+up7
         iOvwIOSimA/sZl71UWJUTYE3VlF3UmpKgP1Afd7UILJ8urXbEbEA0JjTBbi011K/C1
         ycpJq+AqoDfJg==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V-Qx7gZwcg3n; Mon,  3 Apr 2023 23:46:58 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id 0AB563C09FA06;
        Mon,  3 Apr 2023 23:46:58 -0700 (PDT)
Message-ID: <920dcc8d-9e45-a03e-af06-6b420c6e0f81@cs.ucla.edu>
Date:   Mon, 3 Apr 2023 23:46:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Jim Meyering <jim@meyering.net>
Cc:     60690@debbugs.gnu.org, demerphq@gmail.com,
        mega lith01 <megalith01@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?Q?Tukusej=e2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org
References: <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
 <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CA+8g5KHuE-kQqmi9cVjeJbpyt54v9m9omh9A9we1zmR0+aTDHg@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: bug#60690: -P '\d' in GNU and git grep
In-Reply-To: <CA+8g5KHuE-kQqmi9cVjeJbpyt54v9m9omh9A9we1zmR0+aTDHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-03 20:30, Jim Meyering wrote:
> have you seen justification
> (other than for compatibility with some other tool or language) for
> allowing \d to match non-ASCII by default, in spite of the risks?

In the example =C3=86var supplied in <https://bugs.gnu.org/60690>, my=20
impression was that it was better when \d matched non-ASCII digits. That=20
is, in a UTF-8 locale it's better when \d finds matches in these lines:

>> 	> git-gui/po/ja.po:"- =E7=AC=AC=EF=BC=91=E8=A1=8C: =E4=BD=95=E3=82=92=
=E3=81=97=E3=81=9F=E3=81=8B=E3=80=81=E3=82=92=EF=BC=91=E8=A1=8C=E3=81=A7=E8=
=A6=81=E7=B4=84=E3=80=82\n"
>> 	> git-gui/po/ja.po:"- =E7=AC=AC=EF=BC=92=E8=A1=8C: =E7=A9=BA=E7=99=BD=
\n"

because they contain the Japanese digits "=EF=BC=91" and "=EF=BC=92". Thi=
s was the only=20
example I recall being given.

Also, I find it odd that grep -P '^[\w\d]*$' matches lines containing=20
any sort of Arabic word characters, but it rejects lines containing=20
Arabic digits like "=D9=A3" that are perfectly reasonable in Arabic-langu=
age=20
text. I also find it odd that [\d] and [[:digit:]] mean different things.

There are arguments on the other side, otherwise we wouldn't be having=20
this discussion. And it's true that grep -P '\d' formerly rejected=20
Arabic digits (though it's also true that grep -P '\w' formerly rejected=20
Arabic letters...). Still, the cure's oddness and incompatibility with=20
Git, Perl, etc. appears to me to be worse than the disease of dealing=20
with grep -P invocations that need to use [0-9] or LC_ALL=3D"C" anyway if=
=20
they want to be portable to any program other than GNU grep.
