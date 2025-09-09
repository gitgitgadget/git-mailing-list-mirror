Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E891FDA92
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401117; cv=none; b=ovWXKt+Nv0D1tKtrYAA/oFMa3e+F1os4Hdy7kTPyWiV52+6BQergvxt1yMWZpVt/6Z2aOMBGkbxK8yBVeSxRuPXgJFUeTdu5hpyvUwtqsSDcrPoEpnDbs2npTHxIUZf5InPw18hY2WRp2Sv1j8WqklB7GG1QCo3Oj45vvYC+WxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401117; c=relaxed/simple;
	bh=erPHPs7xiEyXwaNuWDIs0Ri6WvovFSJZMK7vQZV4ZKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KylNMYaqw74jJ8N0lC0J22DbAhPC2PrrUSngl2XyI1w3G8c96kdic3+783S6y8t+Fgm1/a6ESzvSOQg0lwZVOL3VC93Hbu8i83Ka8fe44Zuo3xwK2t9VBJ5pDBpXyHThSs3sBaW7g1+HN1horkQbBDT1CR92TM7eCBc75SXCTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG/dQfrc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG/dQfrc"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso3274903a12.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757401115; x=1758005915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/UEYdKhmAn1LhT2iPf7FE1/YuwYlt+VO5aqlqXGQ8M=;
        b=WG/dQfrchsMcaIEJ73p18GvCcSZpD5sPKcretXbJjttwt+PsZMxZOm7Fio60cWnSKM
         roTUkaQGbssfoL8ciCx/Mw2fmGOP9cs00vHDdJRTx8jOpjjGTA705vgZrrAwyVD/ss3i
         txZWX9FeQkpNBR0ntVBg6B8AM5tpF5PKFvMSRC69MCbDlpu1LsHiN8D49m8naNQDKsUp
         nzd2S4cSgtXe0G6m/Wj3bOMOyEPFpQ0msN+m4skGXeoUff4oYFKBYqf6/q84ihc0tsod
         w3Qa/CetPVhURcVlAssBzJHf1sl4bLUUp1NQq5fnMt8VB6FO5KzEbBGlsSlTUBGO+xx/
         kNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401115; x=1758005915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/UEYdKhmAn1LhT2iPf7FE1/YuwYlt+VO5aqlqXGQ8M=;
        b=Wa1iR/4i9JrvCDMAPK6hazpxN/fA+H6xAHxj0d64mCw8kUJ9/6U5XALeydCBgOmyNb
         yJm7uac41mNhDHFcz5T9/kqjRTcFhAc0MK3OuIzgsWom0q4LA7AFlIpGh66xbfh1JuUs
         VhDcEP6U9rw6i1Q5wZhOFaMTok2RAvVdjWdm6GdZh1dBn5xfsEWNn5MjU3NwLVZyxsjp
         pEQqmpfPtRLAFPiSLHPFKqbYtE1HccUCizCO5M4jqeqQMDiBNhx2wv/FjyGG49DVhxsJ
         Y0jIaOSA4gC1RqVdzVPzh8bRmfoEuAO9iA8pN6KhqRzxrmbDnEkWoG1lcXC8052GOhPm
         4iTA==
X-Gm-Message-State: AOJu0Yw8vPvjRFEyx8oidJwm9Ro+v3B1fRGU/CxnNQlrE96UGZCgrO4c
	FSJUHJVqT2KbiY5VDEnigbeDd6v+Sbr1h12b1djZjXXpbELjzJKJiUfp
X-Gm-Gg: ASbGncuuH9DoADqRm91snj7kJzU7FG80DJK++vyWCrnCntShtITXBW+bIpAp66haeGJ
	M0NB0NAMOxRKZrYMEb8licNpkiytfJKbXSSo4HN6ezFC5eUgHfGtGdryEkHye9o/4OOhza6h61d
	wQFcGPcGuF/EOMUa3dDsMl3RvAYJLBoyiQUhMCs5CoAjhjmOpganWECNIOWHOKShcsZC1+ihKBT
	yOIGuiRW73a6jsYKxCKFQHb/2D+EwzSMPgp8lcUqE2CBGU2o0cBBX21R+xhHGy1TtLI29Ii0vFL
	iEykXLHlJkqslmtqg/krcz+o1nIQKL5Cof/0P4TGXq9l52m9Hq2GzoLXWSoKvIGD8o+n+ilN3WR
	pjuWkW8Wx7RMMylh5578v+XoPcx6ERnPpAp81NuhHxNIjNFE2L/42JKH63hUg5YfXgXRPo0EAjI
	YvVTJi36dyuO8/e7uYnKLI6+p472Bd
X-Google-Smtp-Source: AGHT+IGW7tx4p7gEUAtFx8x9aNOPwe9rwm9YXJURQkC+RHrSOu8HoFnxZbpeyDHrEdxHkjKSeZOOqA==
X-Received: by 2002:a17:902:dacf:b0:250:a6ae:f4cd with SMTP id d9443c01a7336-25174c1a971mr145525135ad.44.1757401115037;
        Mon, 08 Sep 2025 23:58:35 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:7e97:c01c:f128:b5c5:e0c? ([2406:7400:56:7e97:c01c:f128:b5c5:e0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2566a8deebbsm44413965ad.74.2025.09.08.23.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 23:58:34 -0700 (PDT)
Message-ID: <c7615356-04cc-47e2-a894-4d24e416e4ad@gmail.com>
Date: Tue, 9 Sep 2025 12:28:29 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] replay: add --update-refs option
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>,
 John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-2-siddharthasthana31@gmail.com>
 <aL6n8KEHSDii5Wd1@pks.im>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <aL6n8KEHSDii5Wd1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/09/25 15:24, Patrick Steinhardt wrote:
> On Mon, Sep 08, 2025 at 10:06:19AM +0530, Siddharth Asthana wrote:
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index 6172c8aacc..a33c9887cf 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -284,6 +284,37 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>   	return create_commit(repo, result->tree, pickme, replayed_base);
>>   }
>>   
>> +static int update_ref_direct(struct repository *repo, const char *refname,
>> +			     const struct object_id *new_oid,
>> +			     const struct object_id *old_oid)
>> +{
>> +	const char *msg = "replay";
>> +	return refs_update_ref(get_main_ref_store(repo), msg, refname,
>> +			       new_oid, old_oid, 0, UPDATE_REFS_MSG_ON_ERR);
>> +}


Hi Patrick,

Thanks for the detailed review


> Is there a strong reason why a user would want to update refs one by
> one? If not, let's not add new code to our base that does so. This is
> known to be inperformant for the reftable backend, but also for the
> files backend in some cases.


You are absolutely right about the performance concern. My thinking was 
to provide a simple mode that exactly mimics "git replay | git 
update-ref --stdin" behavior, but I see that's not worth the performance 
cost.

I will remove the individual update function and only use batched 
transactions with REF_TRANSACTION_ALLOW_FAILURE when needed.


> If we really want to support the case where
> only a subset of references gets committed we should be using batched
> updates with the `REF_TRANSACTION_ALLOW_FAILURE` flag.
>
>> @@ -319,6 +355,12 @@ int cmd_replay(int argc,
>>   			   N_("replay onto given commit")),
>>   		OPT_BOOL(0, "contained", &contained,
>>   			 N_("advance all branches contained in revision-range")),
>> +		OPT_BOOL(0, "update", &update_directly,
>> +			 N_("update branches directly instead of outputting update commands")),
>> +		OPT_BOOL(0, "update-refs", &update_refs_flag,
>> +			 N_("update branches using ref transactions")),
>> +		OPT_BOOL(0, "batch", &batch_mode,
>> +			 N_("allow partial ref updates in batch mode")),
>>   		OPT_END()
>>   	};
>>   
> So I think we should reduce this to only accept two flags:
> `--update-refs` and a flag that accepts a subset of refs failing.o
>
> We might also want to make this something like `--update-refs[=<mode>]`,
> where `<mode>` could be "allow-failures".


That make sense. Would you prefer `--update-refs` with 
`--allow-failures` as a separate flag? I am leaning toward that since 
it's clearer than the parameter syntax.


>
>> @@ -333,6 +375,14 @@ int cmd_replay(int argc,
>>   	if (advance_name_opt && contained)
>>   		die(_("options '%s' and '%s' cannot be used together"),
>>   		    "--advance", "--contained");
>> +
>> +	if (update_directly && update_refs_flag)
>> +		die(_("options '%s' and '%s' cannot be used together"),
>> +		    "--update", "--update-refs");
>> +
>> +	if (batch_mode && !update_refs_flag)
>> +		die(_("option '%s' can only be used with '%s'"),
>> +		    "--batch", "--update-refs");
>>   	advance_name = xstrdup_or_null(advance_name_opt);
>>   
>>   	repo_init_revisions(repo, &revs, prefix);
> We have the `die_for_incompatible_opt*()` helpers for this.


Thanks, I will use those.


>
>> @@ -389,6 +439,18 @@ int cmd_replay(int argc,
>>   	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
>>   			      &onto, &update_refs);
>>   
>> +	/* Initialize ref transaction if using --update-refs */
> Nit: the comment doesn't really add much context, so I'd just drop it.
> It's generally discouraged to add a comment that re-states what the code
> already says. Instead, comments should point out things that are easy to
> miss or not obvious at all.


Will remove the redundant comments.


>
>> @@ -445,10 +525,43 @@ int cmd_replay(int argc,
>>   
>>   	/* In --advance mode, advance the target ref */
>>   	if (result.clean == 1 && advance_name) {
>> -		printf("update %s %s %s\n",
>> -		       advance_name,
>> -		       oid_to_hex(&last_commit->object.oid),
>> -		       oid_to_hex(&onto->object.oid));
>> +		if (update_directly) {
>> +			if (update_ref_direct(repo, advance_name,
>> +					     &last_commit->object.oid,
>> +					     &onto->object.oid) < 0) {
>> +				ret = -1;
>> +				goto cleanup;
>> +			}
>> +		} else if (transaction) {
>> +			if (add_ref_to_transaction(transaction, advance_name,
>> +						   &last_commit->object.oid,
>> +						   &onto->object.oid,
>> +						   &transaction_err) < 0) {
>> +				ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
>> +				goto cleanup;
>> +			}
>> +		} else {
>> +			printf("update %s %s %s\n",
>> +			       advance_name,
>> +			       oid_to_hex(&last_commit->object.oid),
>> +			       oid_to_hex(&onto->object.oid));
>> +		}
>> +	}
>> +
>> +	/* Commit the ref transaction if we have one */
> Likewise here.


Will remove the redundant comments here too.


Thank,

Siddharth


>
>> +	if (transaction && result.clean == 1) {
>> +		if (ref_transaction_commit(transaction, &transaction_err)) {
>> +			if (batch_mode) {
>> +				/* Print failed updates in batch mode */
>> +				warning(_("some ref updates failed: %s"), transaction_err.buf);
>> +				ref_transaction_for_each_rejected_update(transaction,
>> +										 print_rejected_update, NULL);
>> +			} else {
>> +				/* In atomic mode, all updates failed */
>> +				ret = error(_("failed to update refs: %s"), transaction_err.buf);
>> +				goto cleanup;
>> +			}
>> +		}
>>   	}
>>   
>>   	merge_finalize(&merge_opt, &result);
> Patrick
