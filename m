Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1EDC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJ1OXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJ1OXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 10:23:37 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E427E81B
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666967003; bh=Jkv3bdhX1R79tRIgVXVJyI+ta2aR07LhA5JHqedgfrI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PGBTwv4QzbW/0XaM/kOzmkdGq2Hrv1bZMDpTrhqslwAXN/15aoav70vdEfbY05TmU
         EbMTnLhp5ZXsVYJaiedHSalxcZ9GaLqTbsZ96SUm1Qp8PMadP8ZyL24Clv4v5nygyT
         hoMGybsum0+qmw8YGLF0XPaA1nGOJfuJrjf0Zg1g/R0lD+GI6+tbrNO++y9mmuIp/M
         batvb06KOj37jLHQ8pwKQ7n+eSuJ1yMFA7tqanHNXW41CLSJm1+nrrh2PFvi2ikriW
         DiYXlrDn/pjbIeI3aZ3zzgxg9GIUP4+P+1RXBQbT1UkQWHcH6P8OWGgL+vFn0BpD+u
         DYsBMISWPtn8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUWM-1oq4A43eFG-00FzUZ; Fri, 28
 Oct 2022 16:23:22 +0200
Message-ID: <8428e83f-9deb-e928-8699-b5b13e8b7577@web.de>
Date:   Fri, 28 Oct 2022 16:23:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 8/8] replace and remove run_command_v_opt()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <72e04965-56ec-73cb-4554-9e3bc8f10cb5@web.de>
 <221028.86mt9gants.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221028.86mt9gants.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o8AyVp1TvKziJceikgWt9Eh++QHYDGyr8PZ+aLiux6t6/Ne2m9v
 ZPM215CQVkmf2W32WF+TD7eHgY3ZUJhMJeU16//o77tA/aVy/1CLJoCk7KfQesv97+NrSAu
 RKsAwFgS+ZMYznyBsjUezFFcyLGZNmNd91sI+Nwy5cWPcCKImI79ySz1Q8Df+1DOCYisYAD
 kIcooqY+UWyJG7OpyGuXQ==
UI-OutboundReport: notjunk:1;M01:P0:TmMQdoTwXC8=;NF6USNayGo7YpDx0QhkZhXuEzeR
 1/abQoYjt2iO94VIm4YqRwI1bMTboATajiXGKFYMOAo2oQ692eTQgCzm/NNv1yY3jG939czrB
 i0AAh2BNIafAVTNJSe6jmNWunAd7Kn7n1DWE0KoEQ4pebYKoygAvUADnAQJtz03VD6Oi7gCV/
 FEPs3LXfyVF37TquzPtX6FIj1fPy4UQXEb6zl2jMd2iDacO7wUB4wqZDMxiArvIjreBR5l4h0
 tX+CNNamjHkFBgUfb4VoS1kKGl0zisSP50v6+srpjaUpN4SfMjhfwVqmw5lCmkRF4FdS0QRx4
 xAB5Iec1hkKSvBcfLNx9/BekB//ehKEZVb0Ffv+QEd5FSJqVCrYxWg7rO7RKqQVi6cEy1stye
 V54CBVaO+xgtxyNRkvtRcJmY1MxyPRk0zrRjcn3IUnelNCzy+ipEphI4YU1SPqv60slCAXvlL
 Vv/gKt80Uos8MQ+4VuDKT49D9bfOdW7vmNIyb4R4TMtAM9ZggevC0Bg2PAWu9CcdqJd44hm4E
 AtHjsD0dpeKqk9O2PxTU61NycLegwbHsqd4EGkHxtFXX3kFn2F2nad3aqhhT7oqvCx6zKlJ3+
 qzAGYtSNbXX5ua4pCoZUxqZ2h2iO8paePUPdRX9qjKNLYFBf9GIzJZqTTKEI0DX50kyNeA+CH
 HL29k5GTVH6y4OWlxedpd8e4sLfQZq9hAKpG/Ce+ZPRD+Vokr0WvjXHmQf7xLFlUFySOd2EO8
 8sTfJBHAisirQ7HuPHNcE/sLKKd/CGmbnPioSIIKe62UNbCqIyJgJFdAAM0F4br35xHtFz5Ok
 iQ67KaXEfIB8qkVP55u74bKwlrsnlufgVnl2TaMBJVtHELakgO9LtRN0DAVXnmu9y0cixAd0a
 n669bnwJds83XPowvf31GhPNaI3snR6czLTz6QaCXgmYgnAC8LElA6wzsJwtTdrhRRcC8kK/w
 ODqx/YjsnloNUDQcjQ8DeiTojDA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.22 um 00:41 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:
>
>>  #ifndef NO_PTHREADS
>>  static pthread_t main_thread;
>>  static int main_thread_set;
>> diff --git a/run-command.h b/run-command.h
>> index 04bd07dc7a..fe2717ad11 100644
>> --- a/run-command.h
>> +++ b/run-command.h
>> @@ -151,7 +151,7 @@ struct child_process {
>>
>>  /**
>>   * The functions: child_process_init, start_command, finish_command,
>> - * run_command, run_command_v_opt, child_process_clear do the followin=
g:
>> + * run_command, child_process_clear do the following:
>>   *
>>   * - If a system call failed, errno is set and -1 is returned. A diagn=
ostic
>>   *   is printed.
>
> A pre-existing issue mostly, but maybe worth cleaning up while we're
> fixing these docs in general.
>
> This summary is incorrect, because the first bullet point is claiming
> that these "return -1", but 2 functions on this list return void.
>
> It looks to me if we just remove child_process_{init,clear} altgother
> from this it'll be correct. They have their own docs below, and this is
> really describing how this now-simpler API works vis-a-vis the
> start/run/finish functions.

True, and I added that mistake a while ago.  Oops.

=2D-- >8 ---
Subject: [PATCH 9/8] run-command: fix return value comment

483bbd4e4c (run-command: introduce child_process_init(), 2014-08-19) and
2d71608ec0 (run-command: factor out child_process_clear(), 2015-10-24)
added help texts about child_process_init() and child_process_clear()
without updating the immediately following documentation of return codes
that only applied to the preexisting functions.

4c4066d95d (run-command: move doc to run-command.h, 2019-11-17) started
to list the functions explicitly that this paragraph applies to, but
still wrongly included child_process_init() and child_process_clear().
Remove their names from that list.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 run-command.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/run-command.h b/run-command.h
index fe2717ad11..7ed2c04427 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -150,8 +150,7 @@ struct child_process {
 }

 /**
- * The functions: child_process_init, start_command, finish_command,
- * run_command, child_process_clear do the following:
+ * The functions start_command, finish_command, run_command do the follow=
ing:
  *
  * - If a system call failed, errno is set and -1 is returned. A diagnost=
ic
  *   is printed.
=2D-
2.38.1
