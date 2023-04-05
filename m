Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBDC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 20:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjDEUD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjDEUDw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 16:03:52 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E426AE
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 13:03:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id DAD523C09FA02;
        Wed,  5 Apr 2023 13:03:51 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5aZEMnBhpMz3; Wed,  5 Apr 2023 13:03:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 905833C09FA04;
        Wed,  5 Apr 2023 13:03:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 905833C09FA04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680725031;
        bh=8PkslEbHjoWrpxk5RHwWEEVpxilllW7PcwBgH/aBFtk=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=CftoLGsHsh5+2RqTPkPiiFimYzMr4dQgc415GFbs6dKBjA2ISMPv1p2YYlZn/6k4W
         yOuq+Fv6giOfadQqgV56YsHcz4rZfo+tCY7rlNTo8MLLSTahRqwc3buVoBzY6zKLVT
         JC8Ea7lsV+gVxbOwyBIVlj6+pJLNXW1GP/wJ3+mB6e39YJg1MqYj/kv3oF6YCuAaBs
         LUIWivy/Lnwa+ozTMLlxqmC50PBwy9cZaQ8116gwM5KLLBeWBOwuK4XawQOGxkQa49
         DSOvtaQKY/TYKIiVDmqEwrlsZ8ERVJ36HcSlVPQuo11NPCVlb3F7goLAwUQhNes8vk
         DX5sQ4hLPkE7Q==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EB-czLSrBsYx; Wed,  5 Apr 2023 13:03:51 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id 4A6033C09FA02;
        Wed,  5 Apr 2023 13:03:51 -0700 (PDT)
Message-ID: <ed237a07-2f77-74eb-2f52-49b9b8f08873@cs.ucla.edu>
Date:   Wed, 5 Apr 2023 13:03:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Jim Meyering <jim@meyering.net>
Cc:     Junio C Hamano <gitster@pobox.com>, demerphq@gmail.com,
        Philip.Hazel@gmail.com, 60690@debbugs.gnu.org,
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
 <CA+8g5KHYqgAZPpTOXWekDpWv-mvj-rBkGu+4MXy4OB1VDeS4Lw@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: bug#60690: -P '\d' in GNU and git grep
In-Reply-To: <CA+8g5KHYqgAZPpTOXWekDpWv-mvj-rBkGu+4MXy4OB1VDeS4Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-05 12:40, Jim Meyering wrote:
> (C)  preserve grep -P's tradition of \d matching only 0..9, and once
> grep uses 10.43 or newer, \b and \w will also work as desired.

If I understand you correctly, (C) would mean that GNU grep -P, git grep 
-P, and pcre2grep -u would all use PCRE2_UTF | PCRE2_UCP, and would also 
use the extra option PCRE2_EXTRA_ASCII_BSD that is planned for 10.43 PCRE2.

This would require changes to bleeding-edge pcre2grep -u (since it would 
need to add PCRE2_EXTRA_ASCII_BSD unless --no-ucp is also given), and to 
git grep -P (which would need to add PCRE2_UCP and 
PCRE2_EXTRA_ASCII_BSD, when libpcre2 is new enough to #define 
PCRE2_EXTRA_ASCII_BSD).

This option works for me as well. In fact it's the least work for me 
since I already implemented it in bleeding-edge GNU grep (so it works 
this way already :-).

