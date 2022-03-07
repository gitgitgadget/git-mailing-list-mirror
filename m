Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D538C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 13:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiCGOAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbiCGOAA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:00:00 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB8A4B435
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 05:59:05 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id x193so15240301oix.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h5xHm3IMjLQ+RunomTsNsctsR/nnPA6QzI0qu98e28g=;
        b=fMRr3MZvreosc9pDjMOTE2onuevL5cZJjYnmfeL72kzR+CYIEiuIbxTeIBytn5fKw/
         YzkUPri8kF2Co05ClK1YSVNyOKyeeFo98hmEmWrC99E2zJpgBHQy/oiVF7FNQR+of/Fl
         h6LAt0+BW9+I6jTCjiaFlSa7gA1yvrXnDLVxN0dJK8r0wRJMMzrYDSJjg3NHMdprH3F/
         V6MvutnMyNsYpbnwhFjFrKZzva9vENdaetXFYPI4ZlAZ7+yKQYNoIgYgSXftzVLHt3jf
         XaEkZC6PfZGzorNMYzizU5gOphA7IC9R6DPAthJN7I+FoVEyEmBHqBQHtIGbbcwar1EP
         pOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h5xHm3IMjLQ+RunomTsNsctsR/nnPA6QzI0qu98e28g=;
        b=6oAMpn/WBcnYhYbGysvxRl6NzlOZbnU521W6DgPKKN2Y3bJKr6NT0THuKQfnNxEv58
         30fVgkQcZU8ijjvRJYXjHmZAoZMmrFBw6qu2eb2DWZDt3O/wkMGUHA4rbeYsdKA/TBsi
         nU6aFpTu1sVAHx2KLAMbzVk/4c7Fs86uMRdSEJs4hMzuJCN7KQP5pqd3Z/OkCFs2E5kF
         HjdaT7i4B0TdHB20acyWLWln8O85hw5hHSXk+jgMurPtN6vIxIW6LdcAPEZzwbdyijnz
         KqePCrMx3SbFAeyVXgoN42o4OsejoALJi3uh+Y8JmgvDEt4Fi1niKG9P/oieevbUDFZS
         M6dw==
X-Gm-Message-State: AOAM532+k3y6TAXJjDowBoWs2cou14JGkzr0Sq5Ytfm45pFAOAnj5y/a
        aQP8xtLbuRF/RoqnF/61nIxx
X-Google-Smtp-Source: ABdhPJxVTSnmFonni5RDzTOEUTtgm5OuWZ4EclGoOm2BiFtHrFxVtUgtx2Bzf34v5qGEJAht10REiA==
X-Received: by 2002:a05:6808:2383:b0:2d7:9bbe:7c50 with SMTP id bp3-20020a056808238300b002d79bbe7c50mr17715157oib.93.1646661544838;
        Mon, 07 Mar 2022 05:59:04 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x22-20020a056830115600b005ad1076095csm6242175otq.21.2022.03.07.05.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:59:04 -0800 (PST)
Message-ID: <d00617ba-01e8-1a3a-3cf1-49324e604f01@github.com>
Date:   Mon, 7 Mar 2022 08:59:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 02/11] revision: put object filter into struct rev_info
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <3a88c99d9bc765bf4728fe0f0df1eed86adace0e.1645638911.git.gitgitgadget@gmail.com>
 <xmqqk0d9z7nc.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqk0d9z7nc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 5:15 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  static int try_bitmap_count(struct rev_info *revs,
>> -			    struct list_objects_filter_options *filter,
>>  			    int filter_provided_objects)
> 
> This makes quite a lot of sense as filter is now available as
> revs->filter.
> 
>>  {
>>  	uint32_t commit_count = 0,
>> @@ -436,7 +434,8 @@ static int try_bitmap_count(struct rev_info *revs,
>>  	 */
>>  	max_count = revs->max_count;
>>  
>> -	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
>> +	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
>> +					 filter_provided_objects);
> 
> And we should be able to do the same to prepare_bitmap_walk().  It
> is OK if such a change comes later and not as part of this commit.
> 
> Perhaps it is deliberate.  Unlike the helpers this step touches,
> namely, try_bitmap_count(), try_bitmap_traversal(), and
> try_bitmap_disk_usage(), prepare_bitmap_walk() is not a file-scope
> static helper and updating it will need touching many more places.

I'm making a note that this cleanup can happen in a follow-up series.
 
>> @@ -597,13 +595,17 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>>  		}
>>  
>>  		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
> 
> #leftoverbit.  We need to remember to clean this up, now "--filter"
> is well established (I am assuming this literal-string pasting is
> because we didn't know what the right and final word to be used as
> the option name back when this code was originally written), when
> the code around here is quiescent.

Good point.

>> -			parse_list_objects_filter(&filter_options, arg);
>> -			if (filter_options.choice && !revs.blob_objects)
>> +			if (!revs.filter)
>> +				CALLOC_ARRAY(revs.filter, 1);
>> +			parse_list_objects_filter(revs.filter, arg);
>> +			if (revs.filter->choice && !revs.blob_objects)
>>  				die(_("object filtering requires --objects"));
>>  			continue;
> 
> OK.  The original "filter_options" was a structure and not a pointer
> to a structure; now we have a pointer to a structure in revs as a
> member so we need an on-demand allocation.  CALLOC_ARRAY() instead
> of xcalloc(), when we know we are creating one element and not an
> array of elements whose size happens to be one, is not wrong but it
> does look strange.  Was there a reason why we avoid xcalloc()?

I think I've been using CALLOC_ARRAY(..., 1) over "... = xcalloc()"
for simplicity's sake for a while. I see quite a few across the
codebase, too, but I can swap the usage here if you feel that is
important.

> Makes me also wonder how big the filter_options structure is;
> because we will not use unbounded many revs structure, it may have
> been a simpler conversion to turn a static struct into an embedded
> struct member in a struct (instead of a member of a struct that is a
> pointer to a struct).  That way, we did not have to ...
>>>  		}
>>  		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
>> -			list_objects_filter_set_no_filter(&filter_options);
>> +			if (!revs.filter)
>> +				CALLOC_ARRAY(revs.filter, 1);
> 
> ... repeat the on-demand allocation.  If some code used to pass
> &filter_options in a parameter to helper functions, and such calling
> sites get rewritten to pass the value in the revs.filter pointer,
> and if revs hasn't gone through this codepath, these helper functions
> will start receiving NULL in their filter_options parameter, which
> they may or may not be prepared to take.  This "we get rid of a
> global struct and replace it with an on-demand allocated structure,
> pointer to which is stored in the revs structure" rewrite somehow
> makes me nervous.

I think the main idea is that the filter being NULL indicates "no
filter is used. Do a full object walk." If we use a static struct,
then we need to instead use revs->filter.filter_spec.nr, but that
is already being used as a BUG() statement:

const char *list_objects_filter_spec(struct list_objects_filter_options *filter)
{
	if (!filter->filter_spec.nr)
		BUG("no filter_spec available for this filter");

so a non-NULL filter with no specs is considered invalid, while
a NULL filter _is_ currently considered valid.

While we _could_ make that switch to using a static struct and
change our checks to allow empty specs, that would be a more
involved change. Maybe we can leave it for a follow up?

Thanks,
-Stolee
