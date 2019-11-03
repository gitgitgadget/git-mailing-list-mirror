Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A241F454
	for <e@80x24.org>; Sun,  3 Nov 2019 20:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfKCURP (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 15:17:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36042 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKCURO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 15:17:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id a6so7278037lfo.3
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 12:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BPyfOgfVd0BIhqre7yntwXGdBCsCUWWMD5FcK0RIeWU=;
        b=hB8Hh5yc6CJlydI/I+o1W0SLEZdjd8yAY/F+zNN/7h/AwcBcVO3Fab98fLRylO/n4A
         OXu0M/Exu6mCsi14aKVwYnE/nUhZBKTlKvJKe8cUWIdFS5d8dRPTJrwsASYntL36W70l
         2AzGgHpyQCm52vz5XS+rEHuDmBNJImFvrEaETC8JNXy8vkhvTel/Oi4uf7vJgKIQad7k
         fTO21XGh5+KrEEb2vVSml/d7AhCRaa+0rKf/DhlE/rr4DT94rZa+nKPtAPAapzc2o7in
         so91rxmEd2z8F4JMQ8qtdjEFwmQJqV9uHRkrz4jubzMUQiUuzBEfc47hvXuf75onSy2h
         lFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BPyfOgfVd0BIhqre7yntwXGdBCsCUWWMD5FcK0RIeWU=;
        b=RrFGD0YyJO2fN99YvdmrWOZ2bIZi833XqPh6LjvvVIhK1cnB5fSNx/C7tYcxINbhUa
         GijOJ1kr4Bndb2tzAv4A8qrDso2jSOkGk1CaW+HbQ0tDJRoN0TY+/+A05uU02a9g27m/
         ohjOS428IYBfpaXcTCv0RhTbTyYTDuG2hRYbqkH9Vg5J5YpFDev8HdRzUOARL0RhpkoR
         UtnXHW39UUmdSX35OVIeQx+eSjbaAsMSG76JJuimaMwZ4rxAdQ33oTNC/jwQbGWgU2Fv
         ZS2oZ0VBjKnZKrH1mjnyv1IRXXYJOQK7ksf8snbPtgSdWQkxhwxIb5H0ZlRi0pmrwvXb
         IOOw==
X-Gm-Message-State: APjAAAX8V6KvQuN3Z8McaSpcSnbF74t9SZ+y3/5hD9Ey2fk60hUtJbX2
        OFIQQInYOcak5n14PfnhW3F6628s
X-Google-Smtp-Source: APXvYqztKRfq4aPKz8Y5Ly6e3kIvi+9Obxvf10djfrZ9wC3oSytZyPmU6hQzzfDIBhR2eNP+l9YmKA==
X-Received: by 2002:a19:f610:: with SMTP id x16mr2255736lfe.141.1572812231354;
        Sun, 03 Nov 2019 12:17:11 -0800 (PST)
Received: from [192.168.10.10] (c83-252-115-0.bredband.comhem.se. [83.252.115.0])
        by smtp.gmail.com with ESMTPSA id s27sm5808335lfc.43.2019.11.03.12.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 12:17:10 -0800 (PST)
Subject: Re: Re: [PATCH 1/1] add: respect `--ignore-errors` when `lstat()`
 reports errors
To:     Junio C Hamano <gitster@pobox.com>,
        qusielle via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.432.git.1572127149.gitgitgadget@gmail.com>
 <fd022f88f54f6cf0feb61965b2dc47bca64c0937.1572127149.git.gitgitgadget@gmail.com>
 <xmqq36fdbp8v.fsf@gitster-ct.c.googlers.com>
From:   "qusielle@gmail.com" <qusielle@gmail.com>
Message-ID: <eac0456e-0f61-9424-975d-0567bb92327d@gmail.com>
Date:   Sun, 3 Nov 2019 21:17:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq36fdbp8v.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Junio,

Thank you for reviewing my patch. I completely agree with you, that 
add_to_index() should not be called with undefined data.

I will amend patch now with proposed changes.

Thank you!

Best regards,
Qusielle


On 28.10.2019 03:03, Junio C Hamano wrote:
> "qusielle via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: qusielle <31454380+qusielle@users.noreply.github.com>
>>
>> "git add --ignore-errors" command fails immediately when lstat returns
>> an error, despite the ignore errors' flag is enabled.
>> ...
>> diff --git a/read-cache.c b/read-cache.c
>> index 133f790fa4..67237ecd29 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -801,7 +801,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>>   int add_file_to_index(struct index_state *istate, const char *path, int flags)
>>   {
>>   	struct stat st;
>> -	if (lstat(path, &st))
>> +	if (lstat(path, &st) && !(flags & ADD_CACHE_IGNORE_ERRORS))
>>   		die_errno(_("unable to stat '%s'"), path);
>>   	return add_to_index(istate, path, &st, flags);
>>   }
> The only callers of this function that matter calls it and then
> responds to an error return like so:
>
> (in builtin/add.c::update_callback())
>
> 	if (add_file_to_index(&the_index, path,	data->flags)) {
> 		if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
> 			die(_("updating files failed"));
>
>
> (in builtin/add.c::add_files(), where ignore_add_errors was used to
> set the ADD_CACHE_IGNORE_ERRORS to flags in its caller)
>
> 	if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
> 		if (!ignore_add_errors)
> 			die(_("adding files failed"));
>
> So you correctly identified what is the right place to fix.  We
> should not "die_errno()"; we should give the control back to the
> caller instead.
>
> But after a failed stat, the code with your patch still calls
> add_to_index() using the now undefined stat data, which would
> contaminate the in-core index with wrong data.
>
> I think we should instead return without touching the index for the
> path we had trouble lstat()ing.
>
> IOW
>
> 	if (lstat(path, &st)) {
> 		if (flags & ADD_CACHE_IGNORE_ERRORS)
> 			return -1;
> 		else
> 			die_errno(_("unable to ..."));
> 	}
> 	return add_to_index(...);
>
>
