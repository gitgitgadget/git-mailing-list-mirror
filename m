Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00132202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 23:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbdJZXha (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 19:37:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:54299 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdJZXh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 19:37:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id n89so3599362pfk.11
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 16:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0BVtff87ipWD7CDNULNF9MN3tSA2BcgjrN1FfZsubyw=;
        b=qLPxK27rgoLvmabUGGC0JPMpuN1prq+oqTMlyGeWZPHGgOUmwg2YgI5Em2x5idK9Qs
         k52BcTF0Y5ODvj9Dhe3GcRyX/VDsne1Ox5V4rQtMrmblg2jEZfyZENDBTYoBuqhMLlQ5
         KTud39yHwCYaUdI0v4bRi3rPOVsn8UqNkec5eqFokOs7uCcKE4Oiv6EOlxtPIljhbjHW
         43iXESrtyfrt53teQn7WAzdM2cXfVexRxhGdb3ndn6PIc+bu9qGCVn5AGBIrY15Pzjla
         aswBAKm4/wT0pULt01RruKZUh7E4EKFKTqePbncqbSGCvZc85chTMTJw1xKZfqGaS8/K
         3Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0BVtff87ipWD7CDNULNF9MN3tSA2BcgjrN1FfZsubyw=;
        b=aP7zR9A3vl1TDMWWSTiaZYKa7L3xQ/L22w4/ITs1MJzlpwn+cbm/J9gajDsgdD0upC
         D0S3piv2HbZr2zTdjVRkjfgg8avcayMe1VULZZlSFV2qODkttoap0085NHEISNfLnLlv
         gPC6lrTTkyzyBKWAzKQUdjGRVoRAAhWXxx3Pd1bBJwJ5ApB40or0ZZ8LBIlq+4evvHRA
         brr6DP1w5zNJ3o7s8fZPidZe19NtJG+1Z867RZ9ZdQK/ByGBoPvtmzo48yj90JRdxgQq
         50ZyApTCYvS2+Mg6XWM+EFvfCCJIt2JDqeJMZnNxsInTHLi8wkrdHf3GhHYT503wPGHe
         /cIA==
X-Gm-Message-State: AMCzsaX9dqjIkxkukduYvIU1XSDWYlGG+vOZeKN84+7Sj/fI7fBNtcNi
        /GUipwTJMbokROGZX2AoaDtF5w==
X-Google-Smtp-Source: ABhQp+RO9kyJMeg71ZdOOzpl4dvPIy9ePSIQNFYuNoB7VfknjgjVJhQyP2iySR0jc1GK1xR/FV7KOQ==
X-Received: by 10.98.214.17 with SMTP id r17mr7040130pfg.246.1509061049374;
        Thu, 26 Oct 2017 16:37:29 -0700 (PDT)
Received: from [172.22.44.87] ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id l79sm13733762pfb.33.2017.10.26.16.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 16:37:28 -0700 (PDT)
Subject: Re: [PATCH v2] blame: prevent error if range ends past end of file
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
        peff@peff.net, bturner@atlassian.com
References: <20171026153111.21813-1-szeder.dev@gmail.com>
From:   Isabella Stephens <istephens@atlassian.com>
Message-ID: <acc03a7d-69a6-680a-a435-dbdc50cf1e87@atlassian.com>
Date:   Fri, 27 Oct 2017 10:37:25 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171026153111.21813-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/17 2:31 am, SZEDER Gábor wrote:
>> If the -L option is used to specify a line range in git blame, and the
>> end of the range is past the end of the file, at present git will fail
>> with a fatal error. This commit prevents such behaviour - instead the
>> blame is display for any existing lines within the specified range.
> 
> s/is display/is displayed/ ?
Oops.

> 
> 'git log' has a very similar -L option, which errors out, too, if the
> end of the line range is past the end of the file.  IMHO the
> interpretation of the line range -L<start>,<end> should be kept
> consistent in the two commands, and 'git log' shouldn't error out,
> either.
Good suggestion. I'll submit a separate patch for git log.

> 
>> Signed-off-by: Isabella Stephens <istephens@atlassian.com>
>> ---
>>  builtin/blame.c               | 4 ++--
>>  t/t8003-blame-corner-cases.sh | 5 +++--
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 67adaef4d..b5b9db147 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -878,13 +878,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>>  				    nth_line_cb, &sb, lno, anchor,
>>  				    &bottom, &top, sb.path))
>>  			usage(blame_usage);
>> -		if (lno < top || ((lno || bottom) && lno < bottom))
>> +		if ((lno || bottom) && lno < bottom)
>>  			die(Q_("file %s has only %lu line",
>>  			       "file %s has only %lu lines",
>>  			       lno), path, lno);
>>  		if (bottom < 1)
>>  			bottom = 1;
>> -		if (top < 1)
>> +		if (top < 1 || lno < top)
>>  			top = lno;
>>  		bottom--;
>>  		range_set_append_unsafe(&ranges, bottom, top);
>> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
>> index 661f9d430..32b3788fe 100755
>> --- a/t/t8003-blame-corner-cases.sh
>> +++ b/t/t8003-blame-corner-cases.sh
>> @@ -216,8 +216,9 @@ test_expect_success 'blame -L with invalid start' '
>>  '
>>  
>>  test_expect_success 'blame -L with invalid end' '
>> -	test_must_fail git blame -L1,5 tres 2>errors &&
>> -	test_i18ngrep "has only 2 lines" errors
>> +	git blame -L1,5 tres >out &&
>> +	cat out &&
>> +	test $(wc -l < out) -eq 2
> 
> Please use the test_line_count helper instead, as it will output a
> helpful error message on failure, making the 'cat out' above
> unnecessary.
> Thanks for pointing that out.

>>  '
>>  
>>  test_expect_success 'blame parses <end> part of -L' '
>> -- 
>> 2.14.1
>>
>>
