Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9165F1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfI0Lsu (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 07:48:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40521 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0Lst (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 07:48:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id f7so6849239qtq.7
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1E/3xlNafe8FtUVrw+XdxvnFuFDeck7bweUJITkcXWo=;
        b=cTbqyt8y2erJ+GZDp63otb8+ZmgBBclhFoKGowmlPKps+yjdpjZFSaeHrd+299+KVN
         4wDA8pR1Ip9YzBozPCq/Pn9wq2nCKw/BHLIKHZkQwjnqvVlC37hzYGwsk6C/rD5vEtEr
         QJc7t9s/ANaUfGUsGCzdDIdlEUFxKVu0xvRPIHCYNMI7BF/zpsFZ5g4F7EG+Dus8CkXA
         nWHRTuhnC90kRhx/HvLLMfyOEOwwTkIgvb/wqSgknNUObnAFFa1lmZbeZ2HSkTTl7pxz
         YyJAvl+67+PgoDFiSFq19hll17Od3aTiYrqLbw/E/d5igagTIbK9Baq4WPbeJdT2Xhpt
         vsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1E/3xlNafe8FtUVrw+XdxvnFuFDeck7bweUJITkcXWo=;
        b=QAQV52DQEINmKIZzd4ZI8o8vGFKvLThc49Da0b8s9M/65EfCGmgyrWwqdzwb7H5CiT
         rv6m0FxRNKP0pjdNNLxM6+L6ToEbfOiQnrmID35e3UsmwMXZyrQUV64P3iJLewfC5jcW
         RFKoU4WaPr/0HUt6L/QSC+jpbGevPQa6xiM+2MV37wXJv5gSBSyazzwGV2HamJZOGGoB
         zjnsg+w+eSurWj7EBMizoW+RsBP69KWQLlj4K5t520NHbFpldap4XrZYPcNJCjHub5iY
         jgz5RCHwKuyIzJh/lbg5PUp0fDiUjKJuq+0Z93wg+gpJiUqul11Ld3cvb/wLdl+linjn
         xOQg==
X-Gm-Message-State: APjAAAU9j5SqiNPafXy5yKZdoZt0GZ/zDJBh9uSc1RSmqHCgBWEgXXzu
        RtnK0a2Ri5jMDjHb2q6lT54=
X-Google-Smtp-Source: APXvYqwDi/g79HryXRYPcod0acMFODP9ffBDR762AZ8GqAoQMUk/l2vqr1E2NBUNMrpLuT262tKI9A==
X-Received: by 2002:ac8:236c:: with SMTP id b41mr9157438qtb.253.1569584928473;
        Fri, 27 Sep 2019 04:48:48 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b594:20f6:c10f:d45d? ([2001:4898:a800:1010:66ca:20f6:c10f:d45d])
        by smtp.gmail.com with ESMTPSA id x19sm973492qkf.26.2019.09.27.04.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 04:48:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] wrapper: use a loop instead of repetitive statements
To:     Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        davvid@gmail.com
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
 <20190925020158.751492-4-alexhenrie24@gmail.com>
 <20190927024502.GC23736@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d26869f8-9373-51a1-a146-7367aeeb2e85@gmail.com>
Date:   Fri, 27 Sep 2019 07:48:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190927024502.GC23736@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2019 10:45 PM, Jeff King wrote:
> On Tue, Sep 24, 2019 at 08:01:58PM -0600, Alex Henrie wrote:
> 
>> diff --git a/wrapper.c b/wrapper.c
>> index c55d7722d7..c23ac6adcd 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -469,13 +469,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>>  	filename_template = &pattern[len - 6 - suffix_len];
>>  	for (count = 0; count < TMP_MAX; ++count) {
>>  		uint64_t v = value;
>> +		int i;
>>  		/* Fill in the random bits. */
>> -		filename_template[0] = letters[v % num_letters]; v /= num_letters;
>> -		filename_template[1] = letters[v % num_letters]; v /= num_letters;
>> -		filename_template[2] = letters[v % num_letters]; v /= num_letters;
>> -		filename_template[3] = letters[v % num_letters]; v /= num_letters;
>> -		filename_template[4] = letters[v % num_letters]; v /= num_letters;
>> -		filename_template[5] = letters[v % num_letters]; v /= num_letters;
>> +		for (i = 0; i < 6; i++) {
>> +			filename_template[i] = letters[v % num_letters];
>> +			v /= num_letters;
>> +		}
> 
> I'm not sure the readability is changed much either way. But it does
> enable this additional cleanup on top:
> 
> -- >8 --
> Subject: git_mkstemps_mode(): replace magic numbers with computed value
> 
> The magic number "6" appears several times in the function, and is
> related to the size of the "XXXXXX" string we expect to find in the
> template. Let's pull that "XXXXXX" into a constant array, whose size we
> can get at compile time with ARRAY_SIZE().

Removing magic numbers is always a good change. Thanks!

> Note that we probably can't just change this value, since callers will
> be feeding us a certain number of X's, but it hopefully makes the
> function itself easier to follow.
> 
> While we're here, let's do the same with the "letters" array (which we
> _could_ modify if we wanted to include more characters).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  wrapper.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/wrapper.c b/wrapper.c
> index c23ac6adcd..e1eaef2e16 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -441,7 +441,9 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  		"abcdefghijklmnopqrstuvwxyz"
>  		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
>  		"0123456789";
> -	static const int num_letters = 62;
> +	static const int num_letters = ARRAY_SIZE(letters) - 1;
> +	static const char x_pattern[] = "XXXXXX";
> +	static const int num_x = ARRAY_SIZE(x_pattern) - 1;
>  	uint64_t value;
>  	struct timeval tv;
>  	char *filename_template;
> @@ -450,12 +452,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  
>  	len = strlen(pattern);
>  
> -	if (len < 6 + suffix_len) {
> +	if (len < num_x + suffix_len) {
>  		errno = EINVAL;
>  		return -1;
>  	}
>  
> -	if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6)) {
> +	if (strncmp(&pattern[len - num_x - suffix_len], x_pattern, num_x)) {
>  		errno = EINVAL;
>  		return -1;
>  	}
> @@ -466,12 +468,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  	 */
>  	gettimeofday(&tv, NULL);
>  	value = ((uint64_t)tv.tv_usec << 16) ^ tv.tv_sec ^ getpid();
> -	filename_template = &pattern[len - 6 - suffix_len];
> +	filename_template = &pattern[len - num_x - suffix_len];
>  	for (count = 0; count < TMP_MAX; ++count) {
>  		uint64_t v = value;
>  		int i;
>  		/* Fill in the random bits. */
> -		for (i = 0; i < 6; i++) {
> +		for (i = 0; i < num_x; i++) {
>  			filename_template[i] = letters[v % num_letters];
>  			v /= num_letters;
>  		}
> 

