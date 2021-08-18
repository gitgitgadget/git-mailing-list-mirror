Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1432FC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA98A60524
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhHRKJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRKJf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 06:09:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F9C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 03:09:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso1416540wms.2
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0w330s1tHJHhO1lIdPrLbSfffmpwtmH3kPzlXPWiY4=;
        b=jCg6Yhrwxn2DjdK5rTgw3dSCV2+A9bn5/VB2KtgNxFMtWR2HJWeicGjIk/GVIUs3/K
         RNxnunOKoYKYz0XMTK9YVpmUZ9S6DfSYMfunDVc1jDZWAUtFQSKXnalfCnsal149d8x0
         EV5IZMGmvOI1x6RGb6wCNZgVaE19WW0uX4ODYLtabzBNwUUgQHqvxw5GyXEpzMNAc5KX
         SFuk9Xw59e15xqCPmBWjfE8NxvbHdPQAY/H1IsAmDY8AgK4gQENVzdxIpmjHQQWE8x0o
         P9FwJ2LLU+hnmzgZObPlq6UQ1Gro0CoXPQAnuEIDoOnxD8DY1iw5l9v4Ra7UA4sHJLLL
         HXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z0w330s1tHJHhO1lIdPrLbSfffmpwtmH3kPzlXPWiY4=;
        b=Wq20Hxl85mr45rbmfzGBXwzzYxL0iIB3ggYkKd52/PGY3+ZFcEYVKYGwXFSdiajxrJ
         mRPIq1hOMvEfKL3D1l0xa6PvoL92SAp+Xu2NC888QoNojLvhp0l3hQk279YunlNznfSf
         qEYbGpB9npTqpUyM11iFIKYOdsJOWwtV5r1ySGILdpdQfri9JIQyzSzNhxslaOlEfiVq
         52GEDvPYywPl71vRI/FZbSi2YbY35oQL4d6EmvTOnGVFZj45fONsvx/E9KvJhvEU/ZpV
         xUA7Ff6AD3RYAt+zSI2YjB3TS+I6gqDc/iAsvHRUzjmqBJrNsyoFcDccblgUclJoS0EV
         dgsQ==
X-Gm-Message-State: AOAM533K9xF54AJhY7iJHcssCpAXfhAH8ms6AD2eznK0jRGkTFAddYdi
        kIkmx9dtpqdwfYLttxVQr214wmQVGPg=
X-Google-Smtp-Source: ABdhPJx9b00JKju2VA/PbXpOe6hyAHqlGrlqXbezYuqnFqrXLgGvI5w8usGv//Jjtw0D6c+w3Aa+qA==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr7744428wmr.168.1629281339919;
        Wed, 18 Aug 2021 03:08:59 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id x13sm5361592wrq.44.2021.08.18.03.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 03:08:59 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
 <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
 <xmqqwnotaq0e.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2973f162-d2ab-12da-49ec-82ef823089f6@gmail.com>
Date:   Wed, 18 Aug 2021 11:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnotaq0e.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2021 23:33, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
>> @@ -5149,8 +5150,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>>   		oidset_insert(&interesting, &commit->object.oid);
>>   
>>   		is_empty = is_original_commit_empty(commit);
>> -		if (!is_empty && (commit->object.flags & PATCHSAME))
>> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
>> +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>> +					_("skipped previously applied commit %s"),
>> +					short_commit_name(commit));
>> +			skipped_commit = 1;
>>   			continue;
>> +		}
>>   		if (is_empty && !keep_empty)
>>   			continue;
>>   
>> @@ -5214,6 +5220,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>>   		oidcpy(&entry->entry.oid, &commit->object.oid);
>>   		oidmap_put(&commit2todo, entry);
>>   	}
>> +	if (skipped_commit)
>> +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>> +				  _("use --reapply-cherry-picks to include skipped commits"));
> 
> I agree with the change in this hunk that advanced users may want to
> squelch this "what to do" hint.
> 
> I am not sure about the earlier hunk that reports when some commits
> have actually been skipped.  When --no-reapply-cherry-picks is in
> effect, the user is expecting that some commits are cherry-picks
> among other (hopefully the majority of) commits, and even those
> users who do not want to be taught how to use the command would want
> to learn the fact that some commits were skipped (and which ones).
> 
> Using two separate advice configuration variables feel way overkill
> for this.  I wonder if the previous hunk should use warning(), i.e.
> 
>> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
>> +			warning(_("skipped previously applied commit %s"),
>> +				short_commit_name(commit));
>> +			skipped_commit = 1;
>>   			continue;
>> +		}
> 
> possibly squelched by "git rebase --quiet".

I think that would be nicer. Using advise_if_enabled() in the second 
hunk makes sense but I think a printing "warning" rather than a "hint" 
in the first hunk.

>> @@ -5369,8 +5379,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>>   	while ((commit = get_revision(&revs))) {
>>   		int is_empty = is_original_commit_empty(commit);
>>   
>> -		if (!is_empty && (commit->object.flags & PATCHSAME))
>> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
>> +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>> +					  _("skipped previously applied commit %s"),
>> +					  short_commit_name(commit));
>> +			skipped_commit = 1;
>>   			continue;
>> +		}
> 
> Likewise.  I wonder why we have two so-much-similar codepaths that
> we need to touch, though.

--recreate-merges implemented the main loop for its todo list generation 
in a new function as it is much more involved that for the linear case.

Best Wishes

Phillip

> 
>>   		if (is_empty && !keep_empty)
>>   			continue;
>>   		strbuf_addf(out, "%s %s ", insn,
>> @@ -5380,6 +5395,9 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>>   			strbuf_addf(out, " %c empty", comment_line_char);
>>   		strbuf_addch(out, '\n');
>>   	}
>> +	if (skipped_commit)
>> +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>> +				  _("use --reapply-cherry-picks to include skipped commits"));
>>   	return 0;
>>   }

