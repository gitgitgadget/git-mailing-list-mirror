Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1F8207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 20:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S977914AbdDXU5n (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 16:57:43 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36537 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968548AbdDXU5l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 16:57:41 -0400
Received: by mail-qk0-f195.google.com with SMTP id y63so13707162qkd.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=dGzBSawKaxqcK+OlnsSgot//oIG4dGL6vQrR6ue+XEo=;
        b=bkKp+1RB/OC0FcCqcawa96CybH/RybNSI70QZ9trQz9teZ2ph8K2h9KdOUw+2tKzxg
         s93K4iVE3Yrv0PW0m7jf0DwzgH3PeYKDIKA1KU1+XgFIs2cS/Z+T7qzkbjl4LwufZj8d
         qzw3trm2bp/TnViOGWtd8yFdF/XYik+ep0g/SZ1TWKDX4qe0zMGY3/pmqlY60zCgOT7b
         uC0D8aWizEhVLmmMv2XUlgx/jqj77RHDWAQHyGgJRVX4KgmbBmAqJcEKm15d+zy45qs1
         ty0KgIlHjOwaHhwH3gEBXTQ6URD8L/h+vwpkqCfRHwzQyeeHVguQ0jFYPJHjxtj2C70M
         A3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dGzBSawKaxqcK+OlnsSgot//oIG4dGL6vQrR6ue+XEo=;
        b=jmTRFpbw9hgVM238uWFeJGdPj2t6k0OMwRSH8Ys1+uFGkjiEQ3Qlofbl4QPvsOwWlV
         u4HVmllP0NBlQOJMe+lvFuCRissCg2UeiYkooNSLECsuBIjpj2S0bf+5U2mye93RMN0C
         QKzFDzcOMTYf3NOlXVRE0dOxr2uSgd93k7/vw5X34Ggob6QiCqyEELkQuHQrqMAoj4C1
         wGwEUASE/Hjt12g72TE9rIGoO6hAk6qevWAdeQR+iJWKmrVoK2RgiA2gHjhznyZctGII
         9RUnv9ydIffekCIE23K0xYEI0VrFHlh2QAu1Q8VBWD59clz5gQBycfd4BwrCFPOwkMH0
         Y2Wg==
X-Gm-Message-State: AN3rC/6ECDNVHA0y4mxW14lveLXqMe9+VB3DIoo+zAb1Hw19BL/GbCBY
        aXcKYx7MzxFDNA==
X-Received: by 10.55.142.2 with SMTP id q2mr28442718qkd.271.1493067460655;
        Mon, 24 Apr 2017 13:57:40 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id p10sm5445377qkp.49.2017.04.24.13.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 13:57:39 -0700 (PDT)
Subject: Re: [PATCH v6 3/8] convert: Split start_multi_file_filter into two
 separate functions
To:     Junio C Hamano <gitster@pobox.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
 <20170421172611.12152-4-benpeart@microsoft.com>
 <xmqqshkyzask.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c6bec1c1-6e70-4acf-ab9b-b123d2742388@gmail.com>
Date:   Mon, 24 Apr 2017 16:57:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqshkyzask.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2017 12:31 AM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> Subject: [PATCH v6 3/8] convert: Split start_multi_file_filter into two separate functions
> Two minor nits, because the capital after "<area>:" looks ugly in shortlog
> output, and having () there makes it easier to notice that a
> function name is being discussed.  I.e.
>
>      convert: split start_multi_file_filter() into two separate functions

I'll make it so in the next version of the patch series.

>> To enable future reuse of the filter.<driver>.process infrastructure,
>> split start_multi_file_filter into two separate parts.
>>
>> start_multi_file_filter will now only contain the generic logic to
>> manage the creation and tracking of the child process in a hashmap.
>>
>> start_multi_file_filter_fn is a protocol specific initialization
>> function that will negotiate the multi-file-filter interface version
>> and capabilities.
> The above fails to describe a lot more important/significant change
> this patch makes.  Two mistaken check "errno == EPIPE" have been
> removed as a preliminary bugfix.  I think the bugfix deserves to be
> split into a separate patch by itself and hoisted much earlier in
> the series.  It alone is a very good change, with or without the
> remainder of the changes in this patch.

OK, I'll pull that bugfix out into a separate patch.

> Thanks.
>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>   convert.c | 62 ++++++++++++++++++++++++++++++++++++--------------------------
>>   1 file changed, 36 insertions(+), 26 deletions(-)
>>
>> diff --git a/convert.c b/convert.c
>> index 793c29ebfd..36401fe087 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -565,35 +565,14 @@ static void stop_multi_file_filter(struct child_process *process)
>>   	finish_command(process);
>>   }
>>   
>> -static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
>> +static int start_multi_file_filter_fn(struct cmd2process *entry)
>>   {
>>   	int err;
>> -	struct cmd2process *entry;
>> -	struct child_process *process;
>> -	const char *argv[] = { cmd, NULL };
>>   	struct string_list cap_list = STRING_LIST_INIT_NODUP;
>>   	char *cap_buf;
>>   	const char *cap_name;
>> -
>> -	entry = xmalloc(sizeof(*entry));
>> -	entry->cmd = cmd;
>> -	entry->supported_capabilities = 0;
>> -	process = &entry->process;
>> -
>> -	child_process_init(process);
>> -	process->argv = argv;
>> -	process->use_shell = 1;
>> -	process->in = -1;
>> -	process->out = -1;
>> -	process->clean_on_exit = 1;
>> -	process->clean_on_exit_handler = stop_multi_file_filter;
>> -
>> -	if (start_command(process)) {
>> -		error("cannot fork to run external filter '%s'", cmd);
>> -		return NULL;
>> -	}
>> -
>> -	hashmap_entry_init(entry, strhash(cmd));
>> +	struct child_process *process = &entry->process;
>> +	const char *cmd = entry->cmd;
>>   
>>   	sigchain_push(SIGPIPE, SIG_IGN);
>>   
>> @@ -642,7 +621,38 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
>>   done:
>>   	sigchain_pop(SIGPIPE);
>>   
>> -	if (err || errno == EPIPE) {
>> +	return err;
>> +}
>> +
>> +static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
>> +{
>> +	int err;
>> +	struct cmd2process *entry;
>> +	struct child_process *process;
>> +	const char *argv[] = { cmd, NULL };
>> +
>> +	entry = xmalloc(sizeof(*entry));
>> +	entry->cmd = cmd;
>> +	entry->supported_capabilities = 0;
>> +	process = &entry->process;
>> +
>> +	child_process_init(process);
>> +	process->argv = argv;
>> +	process->use_shell = 1;
>> +	process->in = -1;
>> +	process->out = -1;
>> +	process->clean_on_exit = 1;
>> +	process->clean_on_exit_handler = stop_multi_file_filter;
>> +
>> +	if (start_command(process)) {
>> +		error("cannot fork to run external filter '%s'", cmd);
>> +		return NULL;
>> +	}
>> +
>> +	hashmap_entry_init(entry, strhash(cmd));
>> +
>> +	err = start_multi_file_filter_fn(entry);
>> +	if (err) {
>>   		error("initialization for external filter '%s' failed", cmd);
>>   		kill_multi_file_filter(hashmap, entry);
>>   		return NULL;
>> @@ -733,7 +743,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>>   done:
>>   	sigchain_pop(SIGPIPE);
>>   
>> -	if (err || errno == EPIPE) {
>> +	if (err) {
>>   		if (!strcmp(filter_status.buf, "error")) {
>>   			/* The filter signaled a problem with the file. */
>>   		} else if (!strcmp(filter_status.buf, "abort")) {

