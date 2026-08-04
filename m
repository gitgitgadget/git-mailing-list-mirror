Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E2392C2A
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877931; cv=none; b=W3Vv3ajnzDqJ74qKj9whyMRM2F49dxmY1AqeyWpICM/BeGJKvbKgLiEI0+e6NvzYS7gaHBPgddw+rec8rf6ezrKyb3MHoRFoirikuzXax+Vxa7oXw0gbFnMkZ83UCOofIm8fUDelfMP4WDrXlNDWisg0lBfs/LU1WO9CUBwfzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877931; c=relaxed/simple;
	bh=JBIytVkRB+xHvW3LDGXmYyBThO++f0DGUW90ZeOQMnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUk1mJjYIAnEgATcUM/+HpQOLbvGG8tFP2eFI54WKfIxsXYDTt/rRC+oZAIzMfeRKzHs8NocGXeH1LSvE8dHOEY/kRKRUDK5dvy910LK4v7l366AclPU8KGphxKYLa/1yuYqdOstkBVriL1xNYhQl1f/kYoaGz3kVrjGT2EQ52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uek29OvK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uek29OvK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc97653887so3852825ad.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785877930; x=1786482730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pY6lb0MCC5D1fLxe0aZtMkz0J5t8AzM74qewpRqqhIs=;
        b=Uek29OvKmDAuGjy6YHuFcP/ppFIB4p654GSg16Zp2NCb4r8VVAyDTeVc7DoofgUoHP
         T6oC2NWb/ciw/Of8wNC6yPM3CQ0f0MF3bTOG9u4EVDU2TPFg6I5Ln3VJhrBam4KchMJW
         E4WmyI700EZigXdxak4fOTc0EZY/MIWvGbBWuhBwhYxcDldIT/OSg0snLXy3S6zJwXN3
         iszVuPiF73uDYTLC8rmtt2qpWTU2V5esGiTaz0VPJG1d4MsPkJCsO46oKBtHCVAPzaCS
         G+sS10kejSpK1CStyTWYKWGaqQ0ZIAovqHh7yF2sSZrC9hrRr630yChH8Iqgkbdp6VlC
         fGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877930; x=1786482730;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pY6lb0MCC5D1fLxe0aZtMkz0J5t8AzM74qewpRqqhIs=;
        b=R7H/1VgF+FtB0DzBOfZmXXJrZYpmETyzlXf+fy+UNnWXzvR5VAQxhc4LIbEbWgaGt6
         a/FxAOueJxxlb9aY6SV98T+z4Aw8mTiWOMCXPRXkvZ9XkEVyNpyrnvHqK5r9FdjCO5XN
         Lj6RMb4nf48ETEObMSylNwlS94hKf/IHzloyrPSkG6LO5V7ocvybb40bqjdIY5JBzQug
         7rhKh7EMA9sk9m21A11SpG+3M/lW6p2mUCfyifP16KnPvR2tXeU3Wkg4+MyBIs/2qFsa
         6HVLTxC3lY3UFp5incHiby/VBuqoRAGoaNtjhLBI/ws1HbhLEF5mGrbQX/IS35FhSKee
         hZkw==
X-Forwarded-Encrypted: i=1; AHgh+RopYXW+JaYMhIo/LvtlZlxlcrXrqI4wqllueXOmbwZaMtj+Xe1bVt57Ou9rzCsT6XuDYfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xEeVV/0ochGtDvb8aabrEfTktFUYTk5qQ3VKxV+Un+T+gTsD
	k1d8HXYHvYajky+63/H0Sp3BvqcZNN/EeZrua0rOIdVCq44CxH73eWJp
X-Gm-Gg: AR+sD12o8oSGhlQaTFyrZLV9lXgJEO0VtGNpMFHVgKqzOsGX3F0WDSITUkz1QdaF/YL
	Tei1K/wUE72n5KMUL34c+MRlRuQIDu/B19pijVmexZmQlZoyPbKQ+re1I9Gvzp1MNAAj79y6mXn
	+VQreXwArXaZqKyI6/8Ul/2AdlFjONqqBMqK8+RB/mbrkltHsqNMC6zWTpZuraUcmBSCYt/ciTA
	CZosftS/8R/kPsxOmf22fI2TA4UgkTMglirfzRRunUaNLYC8YVB66dj8lhdeMEtGUOVmcnmLcGV
	w3aXoBhezJkjldJIGIyIGal5NXn1iy19ChsBOfJ4j7p8L5KN0QU12gIkxvsPnuBPmlW56fvqzNw
	hbeRI51WvJH42hgO++dlQ7JdqVJuFlgvijNIMg5lAxa0LnZMupFpy+SfgzR2uFFLeoJMYCYPEA0
	Y2Hxq52S4M0HBqSAwQ4vLNqINuXLWF8sbByzY/aeRZqEldFimTq0NeWq00CVjBtcy8RumaTrKEy
	zfqrQonNKXG4B4KoVTtF0zRNt1h9q8qQCO1MAX8PTnG3CNSg2iT6DLwaNMSIbGV/Deq9j1oR+j5
	4OB2AWU8KMKvF75QcNdsy9+g0MUY5u6kGTjcMoQeyaXVtp6sueXdOyW6xL17YQxqmZhpF9F9dmI
	J0JwCEiXJ
X-Received: by 2002:a17:90b:538f:b0:38f:9674:ef61 with SMTP id 98e67ed59e1d1-3903c584291mr1928911a91.13.1785877929600;
        Tue, 04 Aug 2026 14:12:09 -0700 (PDT)
Received: from ?IPV6:2409:40e3:40f2:e504:7c90:c2e4:caf2:ba21? ([2409:40e3:40f2:e504:7c90:c2e4:caf2:ba21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca9111b6sm6615922c88.13.2026.08.04.14.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 14:12:08 -0700 (PDT)
Message-ID: <81939944-9d8a-4bcd-a6ba-f3a7728b33bd@gmail.com>
Date: Wed, 5 Aug 2026 02:42:03 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2 0/7] repack: add --drop-filtered to reclaim space
 in partial clones
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
 ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/07/26 23:11, Siddharth Shrimali wrote:
> This is v2 of the series adding "git repack --drop-filtered" to reclaim
> disk space in partial clones by dropping large, locally-held promisor
> blobs that remain recoverable from the promisor remote. v1 was sent as
> an RFC [1].
> 
> Partial clones let you work with large repositories without downloading
> every blob up front. Mising blobs are lazily fetched from the promisor
> remote on demand. Over time these accumulate locally and there is
> currently no safe, built-in way to reclaim that space short of
> re-cloning. This series adds that reverse direction: enumerate promisor
> blobs over a size threshold, drop them locally, and rely on the existing
> lazy-fetch machinery to bring them back transparently when needed.
> 
> How it works:
>    * Enumerate promisor objects directly (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)
>      and select the blobs exceeding the filter threshold. Every enumerated
>      object is a promisor object by construction, so it is guaranteed
>      recoverable and locally-created objects are never candidates.



Thanks for v2. Guards, docs, and dropping the drop-log all match what we 
have talked about on the RFC.

On "guaranteed": I would soften that a bit in next round. It is 
recoverable in the same sense as the rest of partial clone, as long as 
the promisor remote still has it. Fine for now, just a bit strong
without a remote check.

For the promisor-only walk: that matches how we already treat those
objects, so using it here looks right to me.

On the guards you already covered Junio's point well. I still like the
index one so we do not drop something and fetch it straight back. Mid-op
is more UX. Docs/cover can just say that clearly.

Thanks.
Siddharth


>    * Rebuild the promisor pack without the selected blobs, reusing the
>      existing repack machinery, so the drop is crash-safe (write, fsync,
>      install, then delete the old pack).
>    * --dry-run lists the candidates and changes nothing.
> 
> Safety guards refuse to run while a merge, rebase, am, cherry-pick,
> revert, or bisect is in progress, and refuse to drop a blob referenced
> by the current index (it would only be lazily re-fetched by the next
> worktree command). Both are skipped for bare repositories.
> 
> Changes since v1:
>    * distinguish an explicit -b/--write-bitmap-index on the command line
>      (reported as a conflict) from a repack.writeBitmaps config value
>      (silently disabled for the command). This addresses Junio's review
>      that the previous check could not tell the two apart
>    * documented the choice to keep --dry-run as a separate option rather
>      than --drop-filtered=<mode>
>    * implemented the safety guards
>    * Added git-repack documentation for --drop-filtered and --dry-run
>    * Reorganised so enumerate_promisor_blobs() is introduced in its final
>      signature
>    * Distributed the tests into the commits that introduce each behavior,
>      instead of a single standalone test commit.
>    * Dropped the drop-log commit from this series
> 
> To do:
>    * Remote verification: verifying against the remote awaits the "remote-object-info"
>      cat-file protocol command.
>    * Drop log: introduce with the error-path change that reads it.
>    * --verbose: space-reclaimed reporting.
> 
> [1] https://lore.kernel.org/git/20260716132848.95982-1-r.siddharth.shrimali@gmail.com/
> 
> Siddharth Shrimali (7):
>    builtin/repack.c: add --drop-filtered and --dry-run options
>    list-objects-filter: add list_objects_filter__filter_oidset()
>    repack-promisor: allow excluding objects from the rebuilt promisor
>      pack
>    builtin/repack: enumerate promisor blobs for --drop-filtered
>    builtin/repack: actually drop filtered promisor blobs
>    builtin/repack: add safety guards for --drop-filtered
>    Documentation/git-repack: document --drop-filtered and --dry-run
> 
>   Documentation/git-repack.adoc   |  35 +++++++
>   builtin/repack.c                | 135 +++++++++++++++++++++++-
>   list-objects-filter.c           |  45 ++++++++
>   list-objects-filter.h           |  16 +++
>   repack-filtered.c               |  81 +++++++++++++++
>   repack-promisor.c               |  15 ++-
>   repack.h                        |   8 +-
>   t/meson.build                   |   1 +
>   t/t7706-repack-drop-filtered.sh | 179 ++++++++++++++++++++++++++++++++
>   9 files changed, 511 insertions(+), 4 deletions(-)
>   create mode 100755 t/t7706-repack-drop-filtered.sh
> 

