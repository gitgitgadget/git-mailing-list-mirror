Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13A7C6FA86
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 05:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIRFhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 01:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRFhP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 01:37:15 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6B227CE1
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 22:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663479421; bh=rsAAFPHaJDH/WAh7PG7smVk3weh0I37EVe2W4o4J258=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UEXO6Z3Jn3PUJ8U9HR9TpG1IbHyqQdTqasiIsiGuoMAE5XB7C5P8kbjJLuGV/GSj3
         UOKsGp2cN+RCoN2HAmRbMahBNkxN3W6MHdhmcZXGS8Hv8D7GVToWa6NF1mt5c9YpJF
         jUwv94+o7I0768xAl7abOzMXFS2TfqqgoV1aZDX7D+/o+JlLL9ZMDNR8voTao11A8u
         9d23Vyoa53axFrX2xq/hWONio8pt6LF7mD8zHthTPK2YaVK7+cSVKKkKqcVxWHzzgi
         rKFaKXnTUxr5MWYJ5Sldln/DhOk8UUhZRGaXVjE2YmMpwkDwBeAWCnSzdBdQrAzTs4
         ex64lC+Df4mLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.149.146]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ZeA-1od6Mq3XRU-005njj; Sun, 18
 Sep 2022 07:37:00 +0200
Message-ID: <fd323d96-28fc-a362-2f23-d99ccc5ec76c@web.de>
Date:   Sun, 18 Sep 2022 07:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH 6/6] revision: add parents after child for ^!
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
 <84018532-169f-dc9b-f894-3d19bb7b4245@web.de> <xmqq5yhoo76m.fsf@gitster.g>
 <29d50baa-1923-38e1-6ecb-73840376d28e@web.de> <xmqqh717jou6.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh717jou6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LFpDc/uKil0JnGZuW+5qO7J5t+70LewqijFUxFRpvbBcxA2OL+n
 xK56J7dziSbmT0zA5VaFAEs+/Wz4eeMMFAmRSGT1yGgrpU+7jHxEKKJtF2+q68UIy0hONW/
 R24bqKO8DT3C/ACQlOoP0TsDs8NedWPIYydR3ZzlJDCRhWp5GymHYKIYCL/gHJDvjNy9oi9
 hXKT+J0oMjBLDaVjTR8FA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lce/8W5vZ28=:5bFb08VfyW7NeIDXNhZ/g7
 F13oZ1GHRk+MavWxfCsVsO2wPD6KCx1fo8kAHBLAcCWjXaQOgO+AHOnU2frd4nQD21JR1Qmjz
 vG5v42rgz5JLXFFayzbeGG65fxFwYof0k6UkLIGeLkRZurc/xwhfzgIHWhyIUeEL3RiSI/FN5
 PZwnFe4Jnqen5Q1012seHAhniORTsD5pVbLVEkzTaew0jL1dTpi741ZbnB4/ymVRhcTvY7vu2
 1KTO1TNySKEfPD90BlYWLCAq6ewJNcyA0k4QOTaZw/FPS2M39yHajLz5I0WCRxxluvXcHaJuR
 zV8sRNPWutsWV4Ab4H8D4pvw/ldhpv2IXaJsjINPgXwyGTZJUa9Iv4KuAcec4G2E8H+kwVK+8
 ykVk+w9R8wtiRqHY2P4x7z40sJ/1oPiw+gLxDYfgflWOcibvXQANcF5AyGnQDbkZbIVSNFSJw
 SUxHBgqlajqwFr30unnhDv9XTLbqCFdQ2zPMNl1rTTmJMvftw3SUGXxMiLBgxFCk7UmEbej31
 W5boNoOzV6FzOM0YlYeMt7ZHemkFMjeI6+OFBm/Q642cjnJDlAADLK+fUNErst9C4bGidxA1v
 C9xL3GICy1uiSONK1/HGQWeyYgaOzVNRlpph4z7Ls0YtEeJc2J/Iuud8u1dcPd7NvON+r/xoK
 QY+mpjz6qxrP+mzU/CowCcvlQDlHuqaKeqpcVMKA9COs6EVVHNpUF/0fAx4jcXNOvGa8+bWGO
 rC33rAm9jKArXe6MUSep4pAld5jAsgPCt7MHro1taqDaxQah3euPuZJTh593Cr8wf+NwQz9JR
 w7t/2wchCL+dcQwSIifdAV8F8GsXqbvl8Z34ofrtoTdwbe/+GngcnPeCfb2YVqoFNB+/kQkM1
 Nxfbq4PNJVM/1DSwru7CsmbuXouAl2jT+60SwvYOFMZnTz40lrg31kJO8xph3iS4kvA0VC36F
 iza8lnKC1hQsfFietSMFDUKIP6OB4P+BC4rPm7z/gecV1nLXy3+jBc6lQZeM9eKIe72KG4r3r
 flzA47b6jjZ6bz3DOqxxjBZsYlHLXzC/I+yPCZGm0HA6rSvloGYvWg3jiCKktkV2YG6tpj2FQ
 j299zZhaCoIa8t+BNSk2J1WY8Lt8MnsvP4oQ3mk7uYXRnSRrze7zyW3kMoWdgzdqKQzCnpzJ8
 1dbOs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.09.22 um 17:55 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The check "i < rev.cmdline.nr" is necessary to avoid segfaults e.g.
>> in t0005.  I wonder why.  Shouldn't rev.pending.objects and
>> rev.cmdline.rev always have the same number of entries?
>
> Things that did not come from command line can go into pending,
> can't they?  E.g. add_head_to_pending(), when lack of rev defaults
> to "HEAD", touches pending without touching cmdline?

Indeed.  In t0005 it's even only a fake HEAD with an empty_tree added by
cmd_diff() a few lines up, for a diff of a new file in a fresh, empty
repository.

Ren=C3=A9
