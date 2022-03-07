Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761DFC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiCGL3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbiCGL3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:29:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA4580FC
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:11:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q14so7076142wrc.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OkeD7IL/x0sRbT6BunHTslBe6da5WEChZ0HWAC7RrTk=;
        b=qfNJB08Q8ArsbK0HsV46t640mKkrMN7Fa91m4+yKYJpMVPcI5qBT5uN3N0y3j1tm9j
         WfkeRDjE3TFJQ5pnRNXLtfYsSB2VyjGYJzEMX9KEtaBSR/dvr9ilhAfolyrC14dA6wp+
         IjDXGq9pD750uCf4uef75SVOV7+HjHjZxKRri5TLfei3DkA/WcI5Ez/b4rOH54VyTISC
         OSkm6kVPiZDGvzaHkh5MeOz8cOJGWbPyNKarA6DceX0ah/JLqe78yRbbUh+uZrYUZ7ev
         vnHMTKqsM/ppKgi8iyuXUVYImg4QqFYQ418nLNFw40R0OsCk6N+jT37MjtrU90VWwCPc
         ompw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OkeD7IL/x0sRbT6BunHTslBe6da5WEChZ0HWAC7RrTk=;
        b=E5O/NXbv7z5/j6BbpEonNdoRHdIbPR0cFrfySpVw+YivYPbuajPoiLde7C33sW+Osv
         epmU17aQJygragkqsOt+OaG3Pm8+/UmYBm/mEtT7iq13W6BEHEzg1CVnF79j8Nl3F0Py
         efuKaS64JTDL38C7+4GCS5/0owoYorsiral4mHLMbIwNUeqAa7FawbMzfnaTawsUTsFJ
         1TRDazrWKz5agjLCUpVCfXUEUvVo2+zK+D4IvF/fmHCMMA6AQO/6pV3xG92LzmU2AJAw
         B+pOPud7iAwmJQAtj+iIFTS5d42Ln/Cf/GvRdPbuCXU7ZLao9iban3gOV4oWy3cmZOSJ
         q15w==
X-Gm-Message-State: AOAM531+083dSDfKoRR2Qr6DlCVwqIXMwXxVUzwKLtEoKY/1OCVtLcPg
        InIJ/HJhAnqU/hkj8PFHlGuqgVsb+tk=
X-Google-Smtp-Source: ABdhPJwEkJvTOSXtdN7PtFC9iVvrPPNUsXjMM8cix9w+ALvcjknKyAJta8+3nlvuMweZxT2mPm+uHw==
X-Received: by 2002:adf:f0d1:0:b0:1f1:f24b:a702 with SMTP id x17-20020adff0d1000000b001f1f24ba702mr4357631wro.415.1646651476018;
        Mon, 07 Mar 2022 03:11:16 -0800 (PST)
Received: from [192.168.1.201] (206.2.7.51.dyn.plus.net. [51.7.2.206])
        by smtp.googlemail.com with ESMTPSA id d8-20020a056000114800b001f045f3435asm17860466wrx.108.2022.03.07.03.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 03:11:15 -0800 (PST)
Message-ID: <a2d91895-d933-9909-2f1b-5addd38974f3@gmail.com>
Date:   Mon, 7 Mar 2022 11:11:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] terminal: use flags for save_term()
Content-Language: en-US
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-2-phillip.wood123@gmail.com>
 <95cbca4c-ec26-853e-243f-461a365d9f71@ramsayjones.plus.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <95cbca4c-ec26-853e-243f-461a365d9f71@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay

On 04/03/2022 20:40, Ramsay Jones wrote:
> Hi Phillip,
> 
> I have not studied/applied your patches, they are just floating
> past my inbox, so please ignore me if I have misunderstood ...
> 
> On 04/03/2022 13:11, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The next commit will add another flag in addition to the existing
>> full_duplex so change the function signature to take an unsigned flags
>> argument. Also alter the functions that call save_term() so that they
>> can pass flags down to it.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   compat/terminal.c | 41 +++++++++++++++++++++--------------------
>>   compat/terminal.h |  5 ++++-
>>   2 files changed, 25 insertions(+), 21 deletions(-)
>>
>> diff --git a/compat/terminal.c b/compat/terminal.c
>> index d882dfa06e..bad8e04cd8 100644
>> --- a/compat/terminal.c
>> +++ b/compat/terminal.c
>> @@ -34,7 +34,7 @@ void restore_term(void)
>>   	sigchain_pop_common();
>>   }
>>   
>> -int save_term(int full_duplex)
>> +int save_term(unsigned flags)
>>   {
>>   	if (term_fd < 0)
>>   		term_fd = open("/dev/tty", O_RDWR);
>> @@ -47,11 +47,11 @@ int save_term(int full_duplex)
>>   	return 0;
>>   }
>>   
>> -static int disable_bits(tcflag_t bits)
>> +static int disable_bits(unsigned flags, tcflag_t bits)
> 
> .. you add the 'flags' as the new first parameter ...
> 
>>   {
>>   	struct termios t;
>>   
>> -	if (save_term(0) < 0)
>> +	if (save_term(flags) < 0)
>>   		goto error;
>>   
>>   	t = old_term;
>> @@ -71,14 +71,14 @@ static int disable_bits(tcflag_t bits)
>>   	return -1;
>>   }
>>   
>> -static int disable_echo(void)
>> +static int disable_echo(unsigned flags)
>>   {
>> -	return disable_bits(ECHO);
>> +	return disable_bits(flags, ECHO);
> 
> .. and pass it as first parameter, good, and ...
> 
>>   }
>>   
>> -static int enable_non_canonical(void)
>> +static int enable_non_canonical(unsigned flags)
>>   {
>> -	return disable_bits(ICANON | ECHO);
>> +	return disable_bits(flags, ICANON | ECHO);
> 
> .. here as well, good, and ...
> 
>>   }
>>   
>>   #elif defined(GIT_WINDOWS_NATIVE)
>> @@ -126,15 +126,15 @@ void restore_term(void)
>>   	hconin = hconout = INVALID_HANDLE_VALUE;
>>   }
>>   
>> -int save_term(int full_duplex)
>> +int save_term(unsigned flags)
>>   {
>>   	hconin = CreateFileA("CONIN$", GENERIC_READ | GENERIC_WRITE,
>>   	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
>>   	    FILE_ATTRIBUTE_NORMAL, NULL);
>>   	if (hconin == INVALID_HANDLE_VALUE)
>>   		return -1;
>>   
>> -	if (full_duplex) {
>> +	if (flags & SAVE_TERM_DUPLEX) {
>>   		hconout = CreateFileA("CONOUT$", GENERIC_READ | GENERIC_WRITE,
>>   			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
>>   			FILE_ATTRIBUTE_NORMAL, NULL);
>> @@ -154,7 +154,7 @@ int save_term(int full_duplex)
>>   	return -1;
>>   }
>>   
>> -static int disable_bits(DWORD bits)
>> +static int disable_bits(unsigned flags, DWORD bits)
> 
> .. Huh? Ah, the DWORD suggests this is in an #ifdef'd windows
> part of the file, OK. ...
> 
>>   {
>>   	if (use_stty) {
>>   		struct child_process cp = CHILD_PROCESS_INIT;
>> @@ -191,7 +191,7 @@ static int disable_bits(DWORD bits)
>>   		use_stty = 0;
>>   	}
>>   
>> -	if (save_term(0) < 0)
>> +	if (save_term(flags) < 0)
>>   		return -1;
>>   
>>   	if (!SetConsoleMode(hconin, cmode_in & ~bits)) {
>> @@ -204,14 +204,15 @@ static int disable_bits(DWORD bits)
>>   	return 0;
>>   }
>>   
>> -static int disable_echo(void)
>> +static int disable_echo(unsigned flags)
>>   {
>> -	return disable_bits(ENABLE_ECHO_INPUT);
>> +	return disable_bits(ENABLE_ECHO_INPUT, flags);
> 
> .. but here, you pass the flags as the second parameter. ;-)

Oh dear that's embarrassing, thanks for your careful review.

Are patches 3 & 4 OK for non-stop platforms?

Best Wishes

Phillip

>>   }
>>   
>> -static int enable_non_canonical(void)
>> +static int enable_non_canonical(unsigned flags)
>>   {
>> -	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
>> +	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT,
>> +			    flags);
> 
> .. ditto here.
> 
> ATB,
> Ramsay Jones
> 
> 
>>   }
>>   
>>   /*
>> @@ -267,7 +268,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
>>   		return NULL;
>>   	}
>>   
>> -	if (!echo && disable_echo()) {
>> +	if (!echo && disable_echo(0)) {
>>   		fclose(input_fh);
>>   		fclose(output_fh);
>>   		return NULL;
>> @@ -361,7 +362,7 @@ int read_key_without_echo(struct strbuf *buf)
>>   	static int warning_displayed;
>>   	int ch;
>>   
>> -	if (warning_displayed || enable_non_canonical() < 0) {
>> +	if (warning_displayed || enable_non_canonical(0) < 0) {
>>   		if (!warning_displayed) {
>>   			warning("reading single keystrokes not supported on "
>>   				"this platform; reading line instead");
>> @@ -413,10 +414,10 @@ int read_key_without_echo(struct strbuf *buf)
>>   
>>   #else
>>   
>> -int save_term(int full_duplex)
>> +int save_term(unsigned flags)
>>   {
>> -	/* full_duplex == 1, but no support available */
>> -	return -full_duplex;
>> +	/* no duplex support available */
>> +	return -!!(flags & SAVE_TERM_DUPLEX);
>>   }
>>   
>>   void restore_term(void)
>> diff --git a/compat/terminal.h b/compat/terminal.h
>> index 0fb9fa147c..f24b91390d 100644
>> --- a/compat/terminal.h
>> +++ b/compat/terminal.h
>> @@ -1,14 +1,17 @@
>>   #ifndef COMPAT_TERMINAL_H
>>   #define COMPAT_TERMINAL_H
>>   
>> +/* Save input and output settings */
>> +#define SAVE_TERM_DUPLEX (1u << 0)
>> +
>>   /*
>>    * Save the terminal attributes so they can be restored later by a
>>    * call to restore_term(). Note that every successful call to
>>    * save_term() must be matched by a call to restore_term() even if the
>>    * attributes have not been changed. Returns 0 on success, -1 on
>>    * failure.
>>    */
>> -int save_term(int full_duplex);
>> +int save_term(unsigned flags);
>>   /* Restore the terminal attributes that were saved with save_term() */
>>   void restore_term(void);
>>   

