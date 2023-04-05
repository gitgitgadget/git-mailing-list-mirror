Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8921C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 19:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjDETEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDETEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 15:04:42 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F506EB2
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 12:04:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 7CC873C09FA00;
        Wed,  5 Apr 2023 12:04:29 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RQFYaT8pCWkd; Wed,  5 Apr 2023 12:04:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 3F3603C09FA02;
        Wed,  5 Apr 2023 12:04:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 3F3603C09FA02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680721469;
        bh=A5QqC6pTJiuMWmHDn0PeTFbe/cing73GoNhYwwNMCXk=;
        h=Message-ID:Date:MIME-Version:From:To;
        b=Kshsl4GHwHgUO4jd/s3/C8xBzgZPwTnyInFsabrj1l3fg9P69ZaIKk7zsHF+Osx4T
         dWG6MNbxOt5BTc6303ooOhQIXsrR19858BZzNjyoaeZRYyU5ilMjeXg2T9NV0C5uxP
         029lCtfR6OAEJy6TmMSpAQWknN76bRdRniFGNnGLhw6TIkkcOj96qsqdGLTMyKard0
         TVvdCmmbCgetrxK/5njbSxnEEVn/beLt86vpVKmbDGhWBNuIuPZOIenjrjsTKjPf6q
         vVl192QJ+rjcuGPxW9/M5JqLBt20Tk+YvP6aDRN1KnijKorU69GPfgEqSaHZBRH5kH
         HYuFDvX6+NF8Q==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IigyzgVcjc-m; Wed,  5 Apr 2023 12:04:29 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id EA1B33C09FA00;
        Wed,  5 Apr 2023 12:04:28 -0700 (PDT)
Message-ID: <33b3eb15-73e2-8004-9f06-19e5ec5c5877@cs.ucla.edu>
Date:   Wed, 5 Apr 2023 12:04:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
From:   Paul Eggert <eggert@cs.ucla.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     demerphq@gmail.com, Philip.Hazel@gmail.com, 60690@debbugs.gnu.org,
        mega lith01 <megalith01@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        pcre-dev@exim.org,
        =?UTF-8?Q?Tukusej=e2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        git@vger.kernel.org
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu>
 <xmqqttxvzbo8.fsf@gitster.g>
 <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: bug#60690: -P '\d' in GNU and git grep
In-Reply-To: <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-05 11:32, Paul Eggert wrote:

> in a February 8 commit[1], Philip Hazel changed pcre2grep to use 
> PCRE2_UCP, so this will mean 10.43 pcre2grep -u will behave like 3.9 GNU 
> grep -P did (though 3.10 has changed this).

Sorry, due to fumblefingers I gave the wrong URL for [1]. Here's a 
corrected URL:

https://github.com/PCRE2Project/pcre2/commit/8385df8c97b6f8069a48e600c7e4e94cc3e3ebd9

It also mentions a new --case-restrict option, intended for 10.43 
pcre2grep. Given Perl's and PCRE2's plethora of options I suppose one 
could imagine several other options of that ilk.
