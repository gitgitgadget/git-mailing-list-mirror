Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC65013BE
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565747; cv=none; b=onuvbr3lrJYWHPsS9s+z44jN6XjRa6FkrZWs9oRFdRiTvNRaLHMzfs0/1G0h06yI/eU5+ifmLbUA0CErm6fCW+jvtRJmwdBKqghQmo2HQ8ygar1xZ2x7VO+Nrj3/slsGmCOJnJnxR7JCwdOmxMKvTABLlHcn2SC6YoeP4DqmxDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565747; c=relaxed/simple;
	bh=bFcP/2tjL6C8W6bMukvjxRA3Gr7MhHnOSYycoQNloKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8kHxSbB+krRKArB2433WGjKY4V1jlLQ1JSnhr8pKdW8EG1pKm1jSpMxvu23EICVNWWi7R3oa5dOHrhYX66Pr1L1E/dz3P3ub/qKzXETFLZ9w7xJMrrIs2cu036cXRO1rZEl7R2ERwsn40a2UXSFXiX9zqv9tfO1b5BWgiHstBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRs5jAaX; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRs5jAaX"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a58so155680366b.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565730; x=1790170530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7MrHTbHzu98tBB8m3DukVSDHQqTOw0CrBYqlI4GfnKc=;
        b=cRs5jAaXXTAqCNrTktf8+oeRaJ+pkOe303o4XtH6i2w/z4JrzYevowgjaHjdzRR2rC
         UUcoflmJDsppth8nFmQGJK2ZwzmrWYKIPIvCX+jiXR09swJI0mDgg6CFeSjqciMcWCJ8
         d+DIKC1LZkRIrOk2j7vyTEVqVhKwJZ5Ll36spvBgVbaFYkzI6CF7Ms/UIMbtCV1fqZrM
         /AEMqOfOrZsfm0XJqQnfzzKY1riab5huHdQzyFRQ81Yrx1C2tCdAI486cudxREh1Z05L
         VT1b6HBp6u8xO4NY9q1ecwkZWLktOegMjoYdRJTFjJJQUZk+VxZPUK/DjRSZhvbUvNvV
         +Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565730; x=1790170530;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7MrHTbHzu98tBB8m3DukVSDHQqTOw0CrBYqlI4GfnKc=;
        b=I2IbjFcN3zKwr6GPUNg8HgnKl+kLqpxyQIkOYaw3NDb/vjP6NnTHJeLwobBevzZQrT
         KrbNv+0GXmtNgMb4SJoPVGrHZkDayAkeYJonrp9ww+96aKc21hY9jHBF0JWB+37hAA2U
         8YlZdRQdo8ceZhP91uDsgCEV3pjyj9QLN69I2gQzPB56NeQFe0usMPsuyqMPxgHUi2u0
         YZ1nI45aOZ2GUC63Xl2DwQM4GSG9Efv/tI7IXU5IvURbd2syhiUIegdtcqT3ekFeF+Gm
         sazSdxJkw5k7z/WSKV21nxq9rswjGatFu7Wa7f2VC6K/2IhVewP9493xBAtkgkOh6I6P
         4S7w==
X-Gm-Message-State: AFuF++n3DjdtKrElFinu55NcDh/ENmCyPBsowA75LiQrouoBMekUFbS4
	FiqWp0CDlO8WmjfrjYPZ6zcICn3NDvSumKWb8MVAchftpquwS8D0SCqV
X-Gm-Gg: AYBFou1i7JeCgKyc41hs1wGwvAgjWj5EJKMFHd+V9nDDHuCOXz+IXphe8wXCo/3/jch
	LTk8FbK0is7Eb+HuB9KjOl+oVKSle46uK4+mISFAIECWyIx1iK5dUobp1BJHSHHhidAq46WJuG4
	lzYz4sJC36rbMKryBs7w6JPvrPzIo6NNpQUEnSxk8s3yQMPa/jgyW0FFEMnOnUQYP3vmqM3EZ18
	1PcyipmmMK1EnaCt3btcY3gO+gx4BlpRGZTBVNlf6ke/5Ia1PZ490gIqER7hw4+k06LJr+zjzyd
	rBGaXgxqb3YolLa+d8GfW/9A8ir0l24u83ti2b8Do643bg/suCWzZopKwz4W2dnkbLgwYFjbBIC
	dDKe/XGKyuSty2ancKKJ1rG6pvm/6fs3XDEHF/8TYst0Ji/6XtYtsd3zFS7sYdJgZp5RzojFenl
	zAhnKLswJgM+ov9yIeNu0BtqZubHrDp3TyoMtL2JMij2EZKvFqWdTTaoC+xQr7nMLluBiIAn82/
	GTFoBK/3VhkzfQHJnUeOBDiDSPQWECwY4k4pyfitkKyf71NvLJQeA==
X-Received: by 2002:a17:907:97c5:b0:c29:52dd:317b with SMTP id a640c23a62f3a-c29e52c8c0dmr197176266b.29.1789565729508;
        Wed, 16 Sep 2026 06:35:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29e86309a2sm94954666b.45.2026.09.16.06.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:35:29 -0700 (PDT)
Message-ID: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
Date: Wed, 16 Sep 2026 14:35:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Eli Barzilay <eli@barzilay.org>
Cc: git <git@vger.kernel.org>
References: <CALO-guvbk2TcrVwzdNQ3yRpzHr0HHZ3h1wite0Xp0sUyAT4otA@mail.gmail.com>
 <CALnO6CCkq7mjBUKxOYcwKX8=SrH441FuWopoGZutPk99JRTGUA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CALnO6CCkq7mjBUKxOYcwKX8=SrH441FuWopoGZutPk99JRTGUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 15/09/2026 22:16, D. Ben Knoble wrote:
> 
> I'm experimenting with something that swaps that out for a call to
> reset_working_tree(), but I don't think I've gotten it quite right for
> this bug yet (let alone run other test cases that might be affected by
> this change).

It looks like stash has its own unpack_trees() wrapper, so I think the 
simplest fix is to replace reset_head() with

	reset_tree(&c_tree, 0, 1);

Taking a step back, this code applies the stashed index changes into the 
current index, writes the result to a tree and then resets the index to 
HEAD. We could avoid touching the index at all if we used 
merge_incore_nonrecursive() to cherry pick the index changes instead. 
That way we'd get a proper three-way merge and avoid spawning 
subprocesses for "git diff-tree", "git apply --cached", and "git reset". 
We're already using merge_ort_nonrecursive() to merge the working tree 
changes in that function so we have nearly everything we need already 
set up to merge the index changes as well. Essentially, when merging the 
index, we just need to call merge_incore_nonrecursive() instead of 
merge_ort_nonrecursive() and use info->i_tree instead of info->w_tree.

> BTW, it's really weird to me that the reset manual doesn't mention all
> these "extra" cleanups reset does via remove_merge_branch_state()!

Agreed, I think it comes from "git foo --abort" calling "git reset 
(--merge|--hard)" though that doesn't really explain why a mixed reset 
also removes the branch state.

Thanks

Phillip
>> Possible directions, in case they are useful: remove_merge_branch_state()
>> is about ending a merge, and `git stash apply --index` is not ending
>> one -- having stash's reset_head() avoid the branch-state cleanup, or
>> teaching an in-flight autostash apply to shield MERGE_AUTOSTASH, would
>> both close it.  Making apply_save_autostash_ref() tolerate a missing
>> ref would silence the error but leave the duplicate entry.
> 
> I also thought briefly about disabling stash.index for a merge
> autostash, but that's really papering over things, I think.
> 
> I'll keep noodling on this (hopefully tomorrow morning), but in the
> meantime input from others welcome :)
> 

