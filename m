Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9F355F49
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835114; cv=none; b=QLbfYWWcaozTsuu7BA42PUxCQ33lU3xOUrpcHrgR94tvwmlOykOg9TmoiR3KiNQu6W/nwHQtHPhp/1QYfLB4QpN36SVtXyxoy9DB3RiED2MyHbv/nQoLkbyCFh64kVp5MWe9ZlnC0f/YqcTCMoQ76yHNryUa1BYJLD8nnmK0E54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835114; c=relaxed/simple;
	bh=Rtl1lV0Pnxm9YufRa7HrnC8XrX8pf3F4x2AE8RwSGyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2MgJK1tQ5eIEBWdGZQDzb5t6yGZtLcycF5mJCYxdZSx+VWvqrJpo43BhxmNMb+lXDSzLPvgsMQ5vhs6mM6yLCM57trqniqaO5/ZRbfuHfGikBBSVNkBVUBQytedomGYv7JXVLbeERLeYsv0lF8VCth6rl8OYnHSZfEP+Hr5XLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLLavIEy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLLavIEy"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so786561a12.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784835112; x=1785439912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MVF/HNA75st/8b/MTYrEEcU7OLyJS+4hxLIxpUynQxk=;
        b=BLLavIEyAcWj6csVVXvcaK/To2mXiacG4k0jhk5vFNxzqORBz2ceqcXmm531xBaig3
         A2jbkFfY+nG9bCfKxRuVtzhZnmlfzqSF9154kGHqxX7seoGJuLL+EZmG+ImE+HKcRv8I
         ZUuH3VUTngEZefkk4EAMFwfv73CZ4x6WnJ68ttIlnNd7nRuIYBj2zKpRRLSmvRIvvXJy
         UOL9SvVObZ0gfcIloKsI99SzszeWEGLnTj1uMoz2otGtnew87UXFSYFK8Cit7Ryj6Jvb
         kVFL6IV3jCallc15t7i10+i9+7ejywK3q3jqFlu56gkFgv6zYR5WT/pYDu9jmn+K9z++
         mlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784835112; x=1785439912;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVF/HNA75st/8b/MTYrEEcU7OLyJS+4hxLIxpUynQxk=;
        b=SiQe4/yRNMlXuXaXQ54hv9geZ1NZ+q4CsDxqlsL6WmOOQ9tJ9SPnY7LhsnS81kieJR
         ky1V6pmsMwUD3kfuRU3US/zF+PoXkQHCKhemaJzPq/da46FBYN5Ya4FizWs88Jlq6r/n
         KkSoAWW5xKHR1Lqy9xAgpsNrVsgb+MKAQ9RBS/WSIHENwVn+yRtW6s3gIIibUM/imnON
         z1lrWAz0LMHpmCUx5eYjR0jayKvsnEscmqGm6/MhCW5Jvh2kk5Ctz26ZsBo8V5zlp47k
         iXnL6J9ih7SUmE+qCbPAbfMr0iRLys8tmjX6Dh4mrdPP6NAusGJqOKq10pzp62HKC8iH
         Gj2w==
X-Gm-Message-State: AOJu0YwR/d3AhTgw1AJ4LSBYnW0pNv2FAiOSdkp/5mA3R/89xD2hZ/9z
	NPMTI142AdB8TfEzxlbAJVWATyfqjij0s/iyxJTERkS8RQbXrWDm6Vj5
X-Gm-Gg: AR+sD10BlgUAtOupKJ4v5Dhv2P7wE4On6wYQWz4D0dVJCo21+8m1Ooj1273uK3TNQvH
	ohux/++25U/k9I48oTLccOKKW7cXj2FlS+SZi5CFopq5FzAVi9FpT7csU0RGOour6ZyI2RE0My5
	Jso0L8PFm6qm3SxVqsJ7MfAtcLYnBixp0nWbijwZw7pd30AmLGqbcMmEZ1xA8tDuajHpK8tcgxK
	s85CQQxO78OkWV9R9JT6u3T7fdZ2ipgIGyHt1YUjiyhBJ8j6Ypjjd8ZwcqSDbyqocdgH9Rt7Yvc
	GJE6vJJ4WDupbGQWyJCKwXSIV1mdcsn/4x9HxAWXVg1rkr6n9pNMyDEWB+bbJaAmXTrfUcU8uFx
	2cMRIeGA2NrCqZHZ4zx1Iv7lGe51ftO/+i8HATVmCGTSBqJZqRvqS3JhrbRdJQRxy0/3CON3+KW
	kIyk4Br3/JBdBWVFN9RLlSmFucTdnAAGVLOqP2ELKXBC896JgW+T4RsBeqnswR8SN0Mtws4p1hW
	i1gTWwdmkmZSsr3OzlucyVtl8T9yNO2HSqHXVcwOPvUtGlHIMhKbBOWjdmc5Y4s1RqMjT4AsUrg
	CgHV92thOkcTy1E+JDoesmEIVQ==
X-Received: by 2002:a05:6a21:460e:b0:3c4:396d:4a7f with SMTP id adf61e73a8af0-3c44af6dff7mr4847392637.15.1784835112119;
        Thu, 23 Jul 2026 12:31:52 -0700 (PDT)
Received: from ?IPV6:2409:40e3:40f2:e504:b8c9:6fa8:29d4:f006? ([2409:40e3:40f2:e504:b8c9:6fa8:29d4:f006])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13014d27sm19059417c88.4.2026.07.23.12.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 12:31:51 -0700 (PDT)
Message-ID: <5bde84d0-d612-4dd6-b1f5-1b40f41c1d8d@gmail.com>
Date: Fri, 24 Jul 2026 01:01:47 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] builtin/repack.c: add --drop-filtered and
 --dry-run options
To: Junio C Hamano <gitster@pobox.com>,
 Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, me@ttaylorr.com,
 ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260716132848.95982-2-r.siddharth.shrimali@gmail.com>
 <xmqqh5lyej6f.fsf@gitster.g>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqh5lyej6f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/26 02:38, Junio C Hamano wrote:
> Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:
> 
>> --drop-filtered is incompatible with bitmap writing: filtering breaks
>> the "all objects in one pack" closure that bitmaps require. An explicit
>> -b is rejected with a clear error and a default-on bitmap configuration is
>> silently disabled for the duration of the command.
> 
> That is very well intentioned.
> 
>> @@ -231,6 +234,10 @@ int cmd_repack(int argc,
>>   			   N_("pack prefix to store a pack containing pruned objects")),
>>   		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
>>   			   N_("pack prefix to store a pack containing filtered out objects")),
>> +		OPT_BOOL(0, "drop-filtered", &drop_filtered,
>> +				N_("delete filtered out objects (requires --filter)")),
>> +		OPT_BOOL(0, "dry-run", &dry_run,
>> +				N_("only show which objects would be dropped")),
>>   		OPT_END()
>>   	};
>>   
>> @@ -252,6 +259,43 @@ int cmd_repack(int argc,
>>   	po_args.depth = xstrdup_or_null(opt_depth);
>>   	po_args.threads = xstrdup_or_null(opt_threads);
>>   
>> +	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
>> +		!!filter_to, "--filter-to");
>> +
>> +	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
>> +		write_bitmaps > 0, "--write-bitmap-index");
> 
> Hmph.  Since this step does not change the parsing or configuration
> for write_bitmaps, we cannot tell if (write_bitmaps == 1) at this
> point in the execution came from the command line (e.g., an earlier
> call to parse_options() around line 247 of builtin/repack.c) or from
> the configuration files (e.g., a call to repo_config() around
> line 245).  In other words, wouldn't it be ...
> 
>> +	if (dry_run && !drop_filtered)
>> +		die(_("--dry-run only takes effect with --drop-filtered"));
>> +
>> +	if (drop_filtered) {
>> +		if (!dry_run)
>> +			die(_("--drop-filtered doesn't work without --dry-run yet"));
>> +
>> +		if (!po_args.filter_options.choice)
>> +			die(_("--drop-filtered requires --filter"));
>> +
>> +		if (!(pack_everything & ALL_INTO_ONE))
>> +			die(_("--drop-filtered requires -a"));
>> +
>> +		/*
>> +		 * Only blob:limit=<n> is supported for now. Reject other
>> +		 * filter choices early, before walking the object database.
>> +		 */
>> +		if (po_args.filter_options.choice != LOFC_BLOB_LIMIT)
>> +			die(_("--drop-filtered only supports --filter=blob:limit=<n> for now"));
>> +
>> +		/*
>> +		 * Without a promisor remote there is nowhere to re-fetch the
>> +		 * dropped objects from, so dropping them would be permanent
>> +		 * data loss.
>> +		 */
>> +		if (!repo_has_promisor_remote(repo))
>> +			die(_("--drop-filtered requires a promisor remote"));
>> +
>> +		write_bitmaps = 0;
> 
> ... way too late to drop the flag here?



Yes, I agree. At that point write_bitmaps > 0 can come from either
-b/--write-bitmap-index or repack.writeBitmaps, so we cannot both
error on an explicit -b and silently clear a config default with the
same check.

For v2 it would be nice to treat those two cases differently.

Thanks.
Siddharth


> 
>> +	}
>> +
>>   	if (delete_redundant && repo->repository_format_precious_objects)
>>   		die(_("cannot delete packs in a precious-objects repo"));

