Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6137CC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 20:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiLTUk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 15:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTUky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 15:40:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B065D14D15
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:40:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 131-20020a1c0289000000b003d35acb0f9fso1990323wmc.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GyYOkfZas+Cj5d8X3NvhRBw/OdTSLwK87eMQca9D9Y=;
        b=rX299CTHn8rNqdGDzvxv01viz1DDsiD2k67wUYa53xudqg86ckH5zxpYDnIsWSfNc0
         zkBrDtIgStxes6/Ww0zo66zXCQTo3zEaXk7IqNYpCsvi6OqZnBEW5ACUqEAKFc+16RCV
         ygNTEBni+Eg1Fpu7NZfwZ8SDTQmQ0ly2pOa4s19U8Ou97Jm9xWGyjOBinCi9VKQy9c3b
         AfY7u1uBHZfO509Ra/9IzcnQDruHiw2ip7lrilZ76WEfQzvIri5enw7nwLnsJn540wfL
         5a4GLoOqxoejZ4bu+PQcsn0rJQCQJnjnhbZPPKlfWvHt2yHY1pZ4xDi+bXq7Z3xm+k3V
         JdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GyYOkfZas+Cj5d8X3NvhRBw/OdTSLwK87eMQca9D9Y=;
        b=vIwzzP3/rGOLbyWiZhJLHQjMAtdneqgPtAvznj12kt8sTrkUFUnE7MO6LK5mhgzH5J
         I3F8tBqUXHRawlEQiFKebYS7B18EUI1jFHtBjuLdpgBpe762XkOJu6AFVM3+oG034RTq
         yM3mzGltcB/73LCnSf4iXOnDt4bA/qrjGUwxHR7px7Fg6s6nf9vupq5ZP4S0uB2yE+XJ
         Bkuv8ll1ip67IW9CieQb8Z00pGx02RlRs0TlQVh3P7ESro98ZV37C6XcqZGK8NAPPvtD
         TDNtfarHT+qYbU/+Dn1Gx45Zr+Ai2H22RBqMZfXYIIggpefyXLd+y7MYQVZbMnjXyw8p
         h/DA==
X-Gm-Message-State: AFqh2krAcph5nrCafr0Bcp+xrb0r3ndDJMB+JrlAjjNnnviXVhYptTUU
        FJHe1/wfMa5x2TxRvBWDOEHebmQljzUWBkQF
X-Google-Smtp-Source: AMrXdXsZdDBq0/MG0H4vTTcaO9YWl6a1HcE4O62Yq/oQvBbbs1gEPUJc6YdZoIAPYK48i49DxvPJWw==
X-Received: by 2002:a05:600c:3acd:b0:3d0:7415:c5a9 with SMTP id d13-20020a05600c3acd00b003d07415c5a9mr2614862wms.21.1671568851227;
        Tue, 20 Dec 2022 12:40:51 -0800 (PST)
Received: from ?IPV6:2003:f6:af0c:f800:f5ff:4df9:7300:71d0? (p200300f6af0cf800f5ff4df9730071d0.dip0.t-ipconnect.de. [2003:f6:af0c:f800:f5ff:4df9:7300:71d0])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c3b1600b003cfd4cf0761sm27487881wms.1.2022.12.20.12.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 12:40:49 -0800 (PST)
Message-ID: <7a657644-cd7c-8638-55aa-667c528a5624@grsecurity.net>
Date:   Tue, 20 Dec 2022 21:40:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <xmqq359fm06c.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqq359fm06c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.12.22 um 23:52 schrieb Junio C Hamano:
> Mathias Krause <minipli@grsecurity.net> writes:
> 
>> Such a change was already proposed 4 years ago [1] but wasn't merged for
>> unknown reasons.
>>
>> 1. https://lore.kernel.org/r/20181209230024.43444-3-carenas@gmail.com
> 
> This part does not belong to the log message but should go below
> three-dash line.  If you have a more concrete "it was rejected
> because ...", to help judging why this version improves upon the
> previous attempt and it is clear the reason for past rejection no
> longer applies, that is a very different story, though.
> 
> The way I read the original thread (assuming that the lore archive
> is showing all relevant messages there) is that RFC was reviewed
> well and everybody was happy about the direction it took.  It even
> received fairly concrete suggestions for the real, non-RFC version,
> but that never materialized.

It had a follow-up RFC[1] half a year later, adding a config option and,
after some more discussion, even command line switches[2]. But not just
IMHO is that far too much, but even you suggested to simply revert back
to the initial RFC and implement the automatic fallback[3], basically
merging it with a proper changelog[4]. As that never happened, I took up
the work and tried to do just that.

1. https://lore.kernel.org/git/20190728235427.41425-1-carenas@gmail.com/
2. https://lore.kernel.org/git/20190729105955.44390-1-carenas@gmail.com/
3. https://lore.kernel.org/git/xmqqh874vikk.fsf@gitster-ct.c.googlers.com/
4. https://lore.kernel.org/git/xmqqef1zmkp5.fsf@gitster-ct.c.googlers.com/

> It is very clear that the posted patch was not yet in a mergeable
> state as-is; "for unknown reasons" is less than helpful.
> 
> Now, we learned a more concrete reason, i.e. "it got tons of help
> improving the draft into the final version, but the help was
> discarded and the final version did not materialize", does the
> attempt this time around improve on it sufficiently to make it
> mergeable, or is it sufficiently different that it needs a fresh
> review from scratch?  If the latter, then "for unknown reasons"
> becomes even less relevant.

Sorry for not digging up that information for the initial patch
submission. I'll add it to v2.

> The rest of the proposed log message, and the change itself, both
> look very reasonable and well explained, at least to me.

Thanks a lot for the detailed review. I'll update the commit log
accordingly but will wait for more feedback to see on which solution we
want to settle on.

> Thanks.
> 
> 
>> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# tweaked changelog, added comment
>> ---
>>  grep.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index 06eed694936c..f2ada528b21d 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -317,8 +317,21 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
>>  	if (p->pcre2_jit_on) {
>>  		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>> -		if (jitret)
>> -			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
>> +		if (jitret) {
>> +			/*
>> +			 * Even though pcre2_config(PCRE2_CONFIG_JIT, ...)
>> +			 * indicated JIT support, the library might still
>> +			 * fail to generate JIT code for various reasons,
>> +			 * e.g. when SELinux's 'deny_execmem' or PaX's
>> +			 * MPROTECT prevent creating W|X memory mappings.
>> +			 *
>> +			 * Instead of faling hard, fall back to interpreter
>> +			 * mode, just as if the pattern was prefixed with
>> +			 * '(*NO_JIT)'.
>> +			 */
>> +			p->pcre2_jit_on = 0;
>> +			return;
>> +		}
>>  
>>  		/*
>>  		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
