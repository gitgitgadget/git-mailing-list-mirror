Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858132B114
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834771; cv=none; b=L06td4kbfpLsj/WwoUNpz3OD8bFEpT1c7fnXKqu9RiMSQU7hKXh9mIOYoNbaed40dbSFTcUVnlc4oTuO9pZyqy7SjSqBTEyCdItcztoaYn+R7lBQFFZksVAviRowcglqMwmpknRnOGNrTmL+iyNCSgXuBH6/h/HqUpKSPOoAcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834771; c=relaxed/simple;
	bh=YaxO0pmcGHg9yxZl4K/VGAdPFKfaQzbCDZZbDaWsUb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttruNvOMXQipvy/tg56dLEfaF0WC/Z5OqTP6PU5btWjGuCTTkYrVYIMBuFXhq8yJ8GclupxsHecMB/lSoV0NugC0+pgHXj/1nWzVbwQuJ4xDx1HOGhQA0+aR7q3w1N+M37pD39eCf5HC+3eZ3MgnXSDgDQfhVGKL0GyowPjuXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3s9QeHN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3s9QeHN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso714091a12.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784834769; x=1785439569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZTyK2y+hDNIxHkxXvvMtvezddtx5eayRhJpYkVPXwZA=;
        b=S3s9QeHNOffwWdodHW1TjvH76ef7zBbxpZQapm0tSMl4WSLzdpL1zfF7PVxrjACqm8
         wMcusDoRJcLAefnljS+1JspOjZOV4mFvG4SpjbDSP87IxdRCaXdhbSR1pa/SlZJ2sAo7
         1P6b/f0ii30siYAf1YRhDGbo8QfRU3NVLN2boT2ImheT8uaSKz0gwBlTCFSpz0hp1xlp
         aADqjSjJaDbaFFnj+DLrsiPHAXsZJ7LkPcc8BMR6Y+eDSNEnLpIkiHLJQpshzu+aQHtx
         7RxvatGbARjaICFXSAguhYaCnxgzVJiMeOcLoUJvZ3jj72DYM/FvMf7cTGlHto5xIkAs
         XdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834769; x=1785439569;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZTyK2y+hDNIxHkxXvvMtvezddtx5eayRhJpYkVPXwZA=;
        b=B3OeHfs/jrksosNj8E5TkUEteV/2M9Hmb7Od377ZDw3xy6Su1FNcbzIq/82yds0NGn
         dmFsReOGUMHMKE6CXI5xqJMtInJA36RXaHJBwZ/39MwgiEW4dtX5h6raCfWQbog8WJmc
         f4GrxyNbt5XOZt8VDLPs95Q0Y0636AGeTk5JqEugMdSIfYBdMDjsCnme/ZXEahLhbF9d
         UpEWSzyKaVZIN9o6jgnPEHdGT2SNga/CMcmgp/x2o3my2oez/GiaaHJPSX8aEb3pdPgl
         GYHos8b1inuGM+lj5QLktWVhICC0mQ0UG8AgZpa4+Do9XcfO1pGt+4GQQ/4prAH3Z7F8
         XHHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrnJ6e0b4kn2Cua7+wvnmhiRXpvBXbSHlDfMrx0xIxee/ydc+/ELB28vBc9cg0P9GZEuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3KFueXzKZ37HxhorOZY0Gms1k+Udu9TwkQCWG9xEt5OhnEfq
	Go5vQQcHyL2ZAIHxFF1JDYh4qMWxQqEzM9v/ql9+ZiZDTTAsI+zRPT4M
X-Gm-Gg: AR+sD10NA/+kSpTuF+R3WoqW+KeDRGzAPUcFoc+BMnaF8YijnyzglZ96SYtJ8e5Tcjy
	5MB2jvGlTHR8AA6Ftn9D5ZSLaYsL880F8E6picWAjXz5VaRuEG2rGD3sJg4bKjJT68Hxptuims5
	WxnZqeKq4Q42Vl5uijqTProLHgsxsJPfxtYE08frAL+F7iLZTsXzdmOuDr5q34OzSdzjUFpVy1g
	Je+4joC2SgfPxKijq8ABASo7lHHkhVnaZHAKJUEKkxCSbBqnKvNO0aBv8lK57kGRk6P8MNvDqaI
	YhsENd4xn+ujP2t/Ge3HMrHRoYYAngY2MoWmSq0ZKO4bunSfoZ+JYUIi2GK9cvBncL6VtHmfDNl
	HACWIE3xKug1MTzVfjVpJ8FugHR+kDGlr4qQQwXYG0dd0jO19E9b6Z+lVPkaXcunl7DmWoZFrZc
	eJZwIdHs2B1AGdM/UARj72KQwPgcrUug9mh2lBX99+x2GuaD4CkIZVmoXDh5Zs2nzx9y4xAfCmH
	xsUktX9r/ZuiTTyKxxlqMcV1H43xuN/edh4jFJ9k5RTvokpBgI/rCwiAj2pXaSmCoitDqdLbwNq
	gNEkVEeFxC/StETD4WT/9WB3sCP5mFrBa3QG
X-Received: by 2002:a05:6a20:7483:b0:3c0:9c19:659d with SMTP id adf61e73a8af0-3c44b26c1afmr4541682637.69.1784834768843;
        Thu, 23 Jul 2026 12:26:08 -0700 (PDT)
Received: from ?IPV6:2409:40e3:40f2:e504:b8c9:6fa8:29d4:f006? ([2409:40e3:40f2:e504:b8c9:6fa8:29d4:f006])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm22567754eec.26.2026.07.23.12.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 12:26:07 -0700 (PDT)
Message-ID: <f9c26c07-1dde-4bb6-a919-37d5229642f5@gmail.com>
Date: Fri, 24 Jul 2026 00:56:02 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] repack: add --drop-filtered to reclaim space in
 partial clones
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
 ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/07/26 18:58, Siddharth Shrimali wrote:
> This is an RFC series seeking feedback on the design and approach.
> Several pieces are still missing (noted below) and the commit
> organization needs cleanup.
> 
> Partial clones let you work with large repositories without downloading
> every blob up front and the missing blobs are lazily fetched from the promisor
> remote on demand. Over time, though, these lazily-fetched blobs
> accumulate locally and there is currently no safe, built-in way to
> reclaim that disk space instead of re-cloning.
> 
> This series adds a "git repack --drop-filtered --filter=<spec>" command
> that removes large, locally-held promisor blobs that are recoverable
> from the promisor remote. The dropped blobs become absent locally but
> remain lazily re-fetchable, making the partial-clone still reversible.
> 
> How it works:
>    * Enumerate promisor objects directly (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)
>      and select the blobs exceeding the filter threshold. Because every
>      enumerated object is a promisor object, it is guaranteed recoverable and
>      locally-created objects are never candidates.


This looks like the right approach to me. Going through the promisor 
repack path instead of write_filtered_pack() matches how repack already 
splits promisor objects out.


> 
>    * Rebuild the promisor pack without the selected blobs, reusing the
>      existing repack machinery, so the drop is crash-safe.
> 
>    * Record each dropped object in a drop log
>      ($GIT_DIR/objects/info/promisor-dropped) so a later change can
>      explain a failed lazy fetch (when it was dropped, which filter
>      matched, which remotes) instead of a bare "could not fetch" error.
> 
>    * --dry-run lists the candidates and changes nothing.
> 
> Planned follow-ups:
>    * Safety guards: refuse to run while a merge/rebase/cherry-pick is in
>      progress, and refuse to drop blobs referenced by the current index.


I think these matter before we present this as a real space-reclaim
tool. Without the index guard especially, users may drop blobs and then
immediately fetch them back on the next command that needs the worktree.

The drop log and remote-object-info can wait. I would not block the
next RFC round on them.

On the UI, I am fine with a separate --dry-run for now (same as
Christian). We can revisit a --drop-filtered=<mode> form later if we
grow more drop-specific options.

Thanks.
Siddharth


> 
>    * Authoritative remote verification: the drop log currently lists all
>      configured promisor remotes rather than the exact remote each object
>      is recoverable from, because there is no client-side way to query a
>      remote for object availability yet. A "remote-object-info" command
>      is being added to the "git cat-file --batch" protocol for this. Once
>      available, the exact remote can be recorded.
> 
> Known issues to address in v2:
>    * There is churn between "enumerate promisor blobs" and "actually drop
>      filtered promisor blobs". The former introduces
>      enumerate_promisor_blobs() with an interim signature that the latter
>      rewrites. These will be reorganized so the function is introduced
>      in its final form.
> 
>    * The tests are in a standalone commit. They will instead be
>      distributed into the commits that introduce the behavior they test.
> 
> Siddharth Shrimali (7):
>    builtin/repack.c: add --drop-filtered and --dry-run options
>    list-objects-filter: add list_objects_filter__filter_oidset()
>    repack-promisor: allow excluding objects from the rebuilt promisor
>      pack
>    builtin/repack: enumerate promisor blobs for --drop-filtered
>    t7706: test --drop-filtered enumeration and validation
>    builtin/repack: actually drop filtered promisor blobs
>    repack-promisor: record dropped objects in a drop log
> 
>   builtin/repack.c                |  76 ++++++++++++++++-
>   list-objects-filter.c           |  45 ++++++++++
>   list-objects-filter.h           |  16 ++++
>   repack-filtered.c               |  81 ++++++++++++++++++
>   repack-promisor.c               | 106 ++++++++++++++++++++++-
>   repack.h                        |  12 ++-
>   t/meson.build                   |   1 +
>   t/t7706-repack-drop-filtered.sh | 145 ++++++++++++++++++++++++++++++++
>   8 files changed, 478 insertions(+), 4 deletions(-)
>   create mode 100755 t/t7706-repack-drop-filtered.sh
> 

