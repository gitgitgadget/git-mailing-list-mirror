Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6806C1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 17:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfFYRym (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 13:54:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51917 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFYRym (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 13:54:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so3750506wma.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VdsIMSw/fdlwRpsUCbljkaw2TnyE2eWHzMHXLyMEqsY=;
        b=s0EtFOqINdasVNV96TK1WgwD/OpakQXio0pfqpgV/lkVnha8X5RsnYKyAQqP7WN/D+
         QZ1U+FLjUuzBiluL6M3JawJhAxI9w5jaZVKzLJuiPsczFp24zCO0DzuKKbQmOWgk6OU0
         YawuRPozlh6dFGnF0N0Cd0v4rOfM/5zf+VpraDkXnXJMEqu7X76f8LJ1tY7qRI4RS/Fd
         iMm2/AdPqsCl+9BMwAwjHB0t7TBR1QOifJ1KPcY7vjQTokuIpUszZVmjhOqe7f4Ggqtn
         SkN8lzvRS6hf4eYVREPy/X7z7ym8/0Zyss0hO0kjJVS0qK/6wb74ho9eiorO0djUIfV5
         F/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VdsIMSw/fdlwRpsUCbljkaw2TnyE2eWHzMHXLyMEqsY=;
        b=a2+ZCemFjP+bH1Go4UxaTbT26qFu9R2K3FCPpdeZTE5N42wvIq4wLYZbDkidCAL37H
         bAkaTJdaMD3GxP+Cjf1xMCkpBYadpkBsVGWIpkrv0eHBsQXW3I5NFnsFSXXhnHhovm3b
         P6EzGcrZunycfy4OnPgCNA5u5CzTQmMz9O3WAuHE+nQYp+jyjDKIMy/ww8vDvsoQj1jv
         Oabap4FfeAcUee0oJ0Q3C00hMKQI46dinGjjIkva+us0AyACqfwyEPEE7Cht0D63EpC1
         EyiN8CMTUCjB8FxC7o5Ah/AmdiEK/9sLdRko9rU/O9GYIIYgVtmFbnb/Bd5BRmxd5CfD
         c4VA==
X-Gm-Message-State: APjAAAUfSRHW+uboyPaW71YZeFohoQt/LYfmf5tIdFSqtTD5mN7w5Awe
        OOsHr5ucVpEvcwkrgxzCrI4=
X-Google-Smtp-Source: APXvYqw2voKPGjqwF++GCUpJ9a/dlnnyhfqU0vQrvaIePOw3Fv+H5EYHqcHenIbzW1IjznbIjPQ5Qg==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr21567546wmc.62.1561485280046;
        Tue, 25 Jun 2019 10:54:40 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id c1sm29566434wrh.1.2019.06.25.10.54.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 10:54:39 -0700 (PDT)
Subject: Re: [PATCH 2/3] sequencer: factor out todo command name parsing
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.275.git.gitgitgadget@gmail.com>
 <ebe8a2b3a1638e8457b1b703b8c4890a9b8904a0.1561457483.git.gitgitgadget@gmail.com>
 <ebaa5956-37aa-29b6-60c7-f287e06db505@web.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <08709a9f-0c4b-996c-260f-e4702f61c4d5@gmail.com>
Date:   Tue, 25 Jun 2019 18:54:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <ebaa5956-37aa-29b6-60c7-f287e06db505@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René

On 25/06/2019 18:03, René Scharfe wrote:
> Am 25.06.19 um 12:11 schrieb Phillip Wood via GitGitGadget:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Factor out the code that parses the name of the command at the start of
>> each line in the todo file into it's own function so that it can be used
>> in the next commit.
> 
> "Factor out" sounds like functionality is intended to not be changed...

Indeed, I thought I should have explained a bit more in the commit
message after I sent it. I think it is unchanged but it's not
immediately obvious.

>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  sequencer.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 919e3153f5..793f86bf9a 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2076,6 +2076,18 @@ const char *todo_item_get_arg(struct todo_list *todo_list,
>>  	return todo_list->buf.buf + item->arg_offset;
>>  }
>>
>> +static int is_command(enum todo_command command, const char **bol)
>> +{
>> +	const char *str = todo_command_info[command].str;
>> +	const char nick = todo_command_info[command].c;
>> +	const char *p = *bol + 1;
>> +
>> +	return skip_prefix(*bol, str, bol) ||
>> +		((nick && **bol == nick) &&
>> +		 (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
>                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ... but this adds support for LF, CR and NUL as separators after short
> commands...

They're there to detect the end of the line, as I don't want to have to
pass in eol from other callers. The check that the nick name is not '\0'
means that if we pass in an empty string we do not read past the end as
the test will fail before it gets to the "*p == ..." part.

> 
>> +		 (*bol = p));
>> +}
>> +
>>  static int parse_insn_line(struct repository *r, struct todo_item *item,
>>  			   const char *buf, const char *bol, char *eol)
>>  {
>> @@ -2097,12 +2109,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>>  	}
>>
>>  	for (i = 0; i < TODO_COMMENT; i++)
>> -		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>> -			item->command = i;
>> -			break;
>> -		} else if ((bol + 1 == eol || bol[1] == ' ' || bol[1] == '\t') &&
>                             ^^^^^^^^^^^^^^
> ... while this removes the check against the string's length.
> 
> Is this safe? It probably (hopefully?) is, as skip_prefix() requires bol
> to point to a NUL-terminated string already.

Yes the string is NUL-terminated

> But is_command() could do the old (and shorter) eol check just as well,
> so the next question is: Why this change?

For the next patch so other callers don't have to find the end of the
line if they don't need it. The new checks for '\n' etc. replace the
'bol + 1 == eol' part.

I'll reroll with a better commit message

Best Wishes

Phillip

> 
>> -			   *bol == todo_command_info[i].c) {
>> -			bol++;
>> +		if (is_command(i, &bol)) {
>>  			item->command = i;
>>  			break;
>>  		}
>>
> 

