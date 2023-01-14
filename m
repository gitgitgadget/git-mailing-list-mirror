Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F130DC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 12:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjANMyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 07:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjANMyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 07:54:16 -0500
X-Greylist: delayed 495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 04:54:14 PST
Received: from blade-b3-vm-relay.servers.aueb.gr (blade-b3-vm-relay.servers.aueb.gr [195.251.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E27B8A4F
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 04:54:14 -0800 (PST)
Received: from blade-a1-vm-smtp.servers.aueb.gr (blade-a1-vm-smtp.servers.aueb.gr [195.251.255.217])
        by blade-b3-vm-relay.servers.aueb.gr (Postfix) with ESMTP id 0DC441CB8;
        Sat, 14 Jan 2023 14:45:56 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aueb.gr; s=201901;
        t=1673700356; bh=Pf5dFe8b1jc8Q9kT89gW6gzgwkUrQ93/ilVGTlKQ9qM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iq7HYdjgtPxUBm4BEu8Ax2blPiFwHNgc/WP9RYRBS2u049Rm0FQsnfDlS7QQCJEVa
         LgFxh/wrwmt4C8Qo75rPOSVXp0OzBd5M2qX8KGugpLBSUL3FZcqFRmzyLbJ6rBj5zv
         QcONeUxYKGBYZAQR5Do9C8XXIE/bL7dbJ1da4NGwrnOm1ONsAAwKOpVQPl1Am4FhLu
         trNS5ZCiQv1PGa0Iyi+Z4CR6AhtXIKlhz+Xm1GUfPGkIw1xRfW+B8svLFFexIzm2v/
         jbImMI6iNbZ8g+5wtR2uwOk9KJ0nfEROt80yHrUjTFWnJDu2S2ZVcNnPBOAyx3ETE6
         YEf+ezKCuRRjw==
Received: from [192.168.136.3] (ppp-94-68-109-36.home.otenet.gr [94.68.109.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dds)
        by blade-a1-vm-smtp.servers.aueb.gr (Postfix) with ESMTPSA id 313974C5;
        Sat, 14 Jan 2023 14:45:55 +0200 (EET)
Message-ID: <ab50c16f-dbb0-0661-4d08-fa150d31f88b@aueb.gr>
Date:   Sat, 14 Jan 2023 14:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
Content-Language: el-en
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
 <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
 <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
 <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
 <Y8CBrtmL45tA/N8z@coredump.intra.peff.net>
 <230113.86ilhazved.gmgdl@evledraar.gmail.com> <xmqq5yda5p4l.fsf@gitster.g>
 <0e25e6b0-2eb8-40ee-7999-f2863a545a15@web.de>
 <b2e597aa-044d-e136-43b9-afc84a1e3794@web.de>
From:   Diomidis Spinellis <dds@aueb.gr>
Organization: Athens University of Economics and Business
Phone:  +30 210 8203621
In-Reply-To: <b2e597aa-044d-e136-43b9-afc84a1e3794@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-Jan-23 10:31, René Scharfe wrote:
> Am 14.01.23 um 07:44 schrieb René Scharfe:
>> Am 13.01.23 um 18:19 schrieb Junio C Hamano:
>>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>>
>>>> On Thu, Jan 12 2023, Jeff King wrote:
>>>> There's a couple of ways out of this that I don't see in this thread:
>>>>
>>>> - Declare it not a problem: We have -G, -E and -P to map to BRE, ERE and
>>>>    PCRE. One view is to say the first two must match POSIX, another is
>>>>    tha whatever the platform thinks they should do is how they should
>>>>    act.
>>>
>>> ... this view.  The story "BRE and ERE work via what system
>>> libraries provide, and 'git grep' matches what system grep' does" is
>>> an easy to understand view.
>>
>> That was my stance in my first reply as well.  But 3632cfc248 (Use
>> compatibility regex library for OSX/Darwin, 2008-09-07) explicitly
>> added alternation support for BREs on macOS, and 1819ad327b (grep: fix
>> multibyte regex handling under macOS, 2022-08-26) removed it seemingly
>> by accident.  And grep(1) does support them on macOS 13.1:

Indeed, I removed the alternation handling functionality by accident.  I 
was not aware of the BRE-handling difference between the GNU and the 
macOS native regex library.  I think having git-grep behave the same as 
grep(1) on each platform is consistent with the principle of least 
astonishment (POLA).  This would mean that on macOS plain git-grep 
should use enhanced basic REs as proposed in René's patch.

Diomidis
