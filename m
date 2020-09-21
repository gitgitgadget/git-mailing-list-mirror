Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAB6C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E367121789
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noJkRtXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIUNT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIUNT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 09:19:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A6C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:19:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so12732453wrx.7
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OwrBCORAFMrB5FBj1u4ScNW21m6bIT54HtmqePt6+58=;
        b=noJkRtXYaRDPcx8DXYiAs9gRe8YthG8U9Txlh0eDnm89nx1n2oBzDh31l9gDVzu2uY
         iCTQ7Lh4eacOSe+FniUbNaTJvuoCViRJwhR/52qp8NmOpl+LfXfKWlRTsDPgHCRFf7Ub
         B93QADyUi2Ls+GGrxMZCtZfZ6omnRugjLxvsewKtESLVtHRbbsV0mYt7HOVj/cE1L4FZ
         4Hg4O/tzeP7bbIv1Jnl2dfvLZz+VoQljNlS21A+m4NB4xMeLMOTnP2Z2bUJTCMUFIj+X
         UDvq/ui1JGCtOk14VmYnqXnJNu/IJJq3IlOq7iBfzEjdJHBffJ+dLV47uL3a2ZRi7zew
         7LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OwrBCORAFMrB5FBj1u4ScNW21m6bIT54HtmqePt6+58=;
        b=mFiQvPbXLVsmYLqovuUk8GsWGrk0njA6OJSpqDvnc8V/s2M1tGU45RcSwFE2lsoQxO
         ydhA+YBn4KOwbLVmJxsjb8xOeSMiSY8O1Y7ZECJF3MvSXuiaFxJCvogePD8T1TjNYKNI
         Qw5c5EppSBbvdIZ0iwWW9RQpfVSblyXuOI6CsBEw/7NhRElfIvzWRtdLIGpAxtg7xgsb
         QutihsUm8N6mvgNjX1sJtnxJvo87kLSkPturKuEX9DYr6f0mB2FnNjRTA4rGkGANkDSI
         kIlr4XJKIIyTwMKnborYCha6c4CHhlQiQr40CGcPxQ0l+eUOIzDKOE3woSnN+36FEcJH
         p7VA==
X-Gm-Message-State: AOAM531XKuczgc9swU/WZYG73htYpN/Wtep+v6joFAr6oPkjtyxv7vHZ
        2bwTACO3HZceAG5Xp9/BGriD7TmZD9k=
X-Google-Smtp-Source: ABdhPJyOYvL9AqLjgh/WE7IVrN8WKPnZLPFw5Daq0X256LdVOgSEajAscrNLKopw4pLDtxgk6x8BNA==
X-Received: by 2002:adf:dd44:: with SMTP id u4mr50354920wrm.22.1600694364448;
        Mon, 21 Sep 2020 06:19:24 -0700 (PDT)
Received: from [192.168.1.240] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.gmail.com with ESMTPSA id n10sm20264708wmk.7.2020.09.21.06.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 06:19:23 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
To:     Junio C Hamano <gitster@pobox.com>,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
 <xmqqft7djzz0.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f6bb2b1f-0f1b-f196-59f1-893580430cf2@gmail.com>
Date:   Mon, 21 Sep 2020 14:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqft7djzz0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/09/2020 21:03, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
>> +/* Checks if the ref is reachable from the reflog entry. */
>> +static int reflog_entry_reachable(struct object_id *o_oid,
>> +			       struct object_id *n_oid,
>> +			       const char *ident, timestamp_t timestamp,
>> +			       int tz, const char *message, void *cb_data)
>> +{
>> +	struct commit *local_commit;
>> +	struct commit *remote_commit = cb_data;
>> +
>> +	local_commit = lookup_commit_reference(the_repository, n_oid);
>> +	if (local_commit)
>> +		return in_merge_bases(remote_commit, local_commit);
>> +
>> +	return 0;
>> +}
> 
> Makes me wonder, if in_merge_bases() is so expensive that it makes
> sense to split the "were we exactly at the tip?" and "is one of the
> commits we were at a descendant of the tip?" into separate phases,
> if this part should be calling in_merge_bases() one by one.
> 
> Would it make more sense to iterate over reflog entries from newer
> to older, collect them in an array of pointers to "struct commit" in
> a batch of say 8 commits or less, and then ask in_merge_bases_many()
> if the remote_commit is an ancestor of one of these local commits?

As I said before[1] I think we should also be checking the reflog dates 
so that we do not look at any local reflog entries that are older than 
the most recent reflog entry for the remote tracking branch. This 
protects against a background fetch when the remote has been rewound and 
it would also reduce the number of calls to in_merge_bases().

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/624d9e35-29b8-4012-a3d6-e9b00a9e4485@gmail.com/

> The traversal cost to start from one "local commit" to see if
> remote_commit is an ancestor of it using in_merge_bases() and
> in_merge_bases_many() should be the same and an additional traversal
> cost to start from more local commits should be negligible compared
> to the traversal itself, so making a call to in_merge_bases() for
> each local_commit smells somewhat suboptimal.
> 
> If we were talking about older parts of the history, optional
> generation numbers could change the equation somewhat, but the
> common case for the workflow this series is trying to help is that
> these local commits ane the remote tip are relatively new and it is
> not unlikely that the generation numbers have not been computed for
> them, which is why I suspect that in_merges_many may be a win.
> 
>> @@ -2301,6 +2380,15 @@ void apply_push_cas(struct push_cas_option *cas,
>>   		    struct ref *remote_refs)
>>   {
>>   	struct ref *ref;
>> -	for (ref = remote_refs; ref; ref = ref->next)
>> +	for (ref = remote_refs; ref; ref = ref->next) {
>>   		apply_cas(cas, remote, ref);
>> +
>> +		/*
>> +		 * If "compare-and-swap" is in "use_tracking[_for_rest]"
>> +		 * mode, and if "--foce-if-includes" was specified, run
>> +		 * the check.
>> +		 */
>> +		if (ref->if_includes)
>> +			check_if_includes_upstream(ref);
> 
> s/foce/force/;
> 
> I can see that the code is checking "and if force-if-includes was
> specified" part, but it is not immediately clear where the code
> checks if "--force-with-lease" is used with "tracking" and not with
> "the other side must be exactly this commit" mode here.
> 
>      ... goes and looks ...
> 
> Ah, ok, I found out.
> 
> The field name "if_includes", and the comment for the field in
> remote.h, are both misleading.  It gives an impression that the
> field being true means "--force-if-included is in use", but in
> reality the field means a lot more.  When it is true, it signals
> that "--force-if-included" is in use *and* for this ref we were told
> to use the "--force-with-lease" without an exact object name.  And
> that logic is not here, but has already happened in apply_cas().
> 
> Which makes the above comment correct.  We however need a better
> name for this field and/or an explanation for the field in the
> header file, or both, to avoid misleading readers.
> 
>> diff --git a/remote.h b/remote.h
>> index 5e3ea5a26d..38ab8539e2 100644
>> --- a/remote.h
>> +++ b/remote.h
>> @@ -104,7 +104,9 @@ struct ref {
>>   		forced_update:1,
>>   		expect_old_sha1:1,
>>   		exact_oid:1,
>> -		deletion:1;
>> +		deletion:1,
>> +		if_includes:1, /* If "--force-with-includes" was specified. */
> 
> The description needs to be tightened.
> 
>> +		unreachable:1; /* For "if_includes"; unreachable in reflog. */
> 
> 
> Thanks.
> 
