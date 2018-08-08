Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBA3208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeHHSV2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:21:28 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:40812 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeHHSV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:21:28 -0400
Received: from [192.168.2.240] ([92.22.29.155])
        by smtp.talktalk.net with SMTP
        id nQtVfjf6hoI6LnQtWf1VjD; Wed, 08 Aug 2018 17:01:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533744067;
        bh=1j0uY/RMZ4DtAVCZLits6vxceBzaeM+7ClW0GN681Kg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iR99R8e2hrSdi+n31ZbFjW6aqCNEVRgZGeScUhbCKtlh1njNnnTKMdAvbklsSZPPh
         ibAsT45roBxSA8Pr2Mu4ZlN4UDORnHWj9X663Bv1ik91rzN5rBkSjJbRMtdP5Mk7cl
         07/Ij9mSyUkNZcy/3CuZZRsF2eoXRsOqH9CrVjpA=
X-Originating-IP: [92.22.29.155]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=yeAZMs3+wWQh+Rh+YWy7CA==:117
 a=yeAZMs3+wWQh+Rh+YWy7CA==:17 a=IkcTkHD0fZMA:10 a=3m-pOZQshecqAkykS6AA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 02/20] rebase -i: rewrite append_todo_help() in C
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-3-alban.gruin@gmail.com>
 <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
 <d8f0e5a2-f621-7847-5113-df4a6da11151@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <89a83826-53e6-aea1-2012-475a09f76ddc@talktalk.net>
Date:   Wed, 8 Aug 2018 17:00:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d8f0e5a2-f621-7847-5113-df4a6da11151@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfECfb2CY8fOCZQyZPERdNppw4jGZDpzCWM3Nb4txmlTBWpQLcVN/zNfvAN8HnNy2iitmwqdJqwq4yjaGBsjLw1q8dOo0MZnRx18X2ZbmiXWZWG3al30Y
 EyJUebQdaoKv5hminKthoHyR+GnQlp0dmWmRB7UYxSyA0qz+uCf2vbFmjSxOAphDtK9TKxOEnS4YckZwAA62xyCyGLxpawPNs6IDYPPGG3Qk6PRKf1YOG8se
 qIYZGCvRub/VM3Mlaq2nE+Syy3TgR2hl/T+6oJVZuiT3DsgfbIU3VOqE5cEkikCi3bwn9TSzjHQwqvGlt00TbYwHegQk/9x+kOjcGrfptQKUSd1g7XLXhIcU
 ZM4/id42gsw1DMo5FI0B3YWIHZfE82USycDmn0qa62oQCKSpPiWBt753dn6PYo1VRnuO9yz+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 08/08/18 16:16, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 07/08/2018 à 15:57, Phillip Wood a écrit :
>>> +	if (ret < 0)
>>> +		error_errno(_("could not append help text to '%s'"), rebase_path_todo());
>>> +
>>> +	fclose(todo);
>>
>> You should definitely check the return value and return an error if
>> appropriate as fputs() might not actually write any data until you try
>> and close the file.
>>
> 
> Is this worth a reroll, as this goes away in a later patch (refactored
> in 08/20, removed in 12/20)?
>

Ah, I've only made it to patch 10 at the moment! If this is going to be 
removed don't worry about it.

Best Wishes

Phillip

>> Best Wishes
>>
>> Phillip
>>
>>> +	strbuf_release(&buf);
>>> +
>>> +	return ret;
>>> +}
>>> diff --git a/rebase-interactive.h b/rebase-interactive.h
>>> new file mode 100644
>>> index 0000000000..47372624e0
>>> --- /dev/null
>>> +++ b/rebase-interactive.h
>>> @@ -0,0 +1,6 @@
>>> +#ifndef REBASE_INTERACTIVE_H
>>> +#define REBASE_INTERACTIVE_H
>>> +
>>> +int append_todo_help(unsigned edit_todo, unsigned keep_empty);
>>> +
>>> +#endif
>>>
>>
> 
> Cheers,
> Alban
> 

