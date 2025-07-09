Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414D2E9720
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077584; cv=none; b=qqw2vw+80Oi71d161aourRpULQqTmC/rurMDTL/ctgn3XRxMXJo75u0yg7adyC7eH5NkqE3Iou54veu2wWUnECta3rNs8M+/RFv62fOxYC38AcFRBv+v48BkvzkPXpfTiTAk6c4wU27Q9UYlJLoeyB8buDk9zmhWDjdtcmEncwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077584; c=relaxed/simple;
	bh=/2EUoBuit0dJ4MQ2a40PN8ePkOpYaWMzMAPHtlQHqKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcHgRBS/kPytil4as3+XJETyTTbP9/6JmzHirIpy+hxp7Ecmcm4/CTg08P09hXiCt1Cc7EMIoe60VBSJsEnou2lj3irROEeMXn1WZcUoS+ueBz42fzs0VNGlIXxSPelE2s7EI5nMk9W1Ag8tg3Z9/NmLy2P23FfircYSlzFgXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsCVLDSA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsCVLDSA"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e767ce72eso1018107b3.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752077582; x=1752682382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIs8+GJys4O7tjZyvV/bsOeDm9QCr9Y4nc8GIDIXDVY=;
        b=fsCVLDSASFVMlSWopxDnEY2xgRk4OD9LiqiIgWTXHPgTv31uryFeojulHb4NGgij+q
         Ky7Usbb7HdTpT5TEKDkQfKC00IS3G9feqeevRoEab5wdqv/5NnYHe/MebsQCsIhaxvo0
         a5+bkjhwfUfiPEi9Ir3HXhv32+87upZ7xXWijN3Orwud2z76IU7dtS6rRbs8rvt3BXtH
         q0lQ3r7b/HnEPg/DQcr+gJurpWHTR3FKiHOtADiIVxdYoRNYq+GPMs2REqOSg/SHI9I9
         mvKXJcXGy3E4hm34N2W4/8s30PN929iMpZA402XcAPcoNsphQbvSuuqZy6nqou6ThVlm
         DsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752077582; x=1752682382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIs8+GJys4O7tjZyvV/bsOeDm9QCr9Y4nc8GIDIXDVY=;
        b=FE1u6CgmagC7FScypOq2nCPP9Ry1uP3g3vRbM1fHnTBPZ0SPKT1yr2Jz7QxIm1fVtj
         +7DFNv/x7HTEsm3S1dC6gUjBjhBg3oU0N+yPtjysNBMm89dO7dMQLEUlwHTJ4Paj+TM4
         ckbZd6DE8KjeGe8zPOwVkeBTwWHCRylp1+i92T+t+aqZaxagVr6CX5TSULROmtrGEMlK
         l4Q5/qYOVv3cr5tAA7OdLPqJ+V8+BZOzBRtOwklOKLR17nfEyy+1sY9ruBQAYljMFydP
         yS7SRQ/AQYP4sebe51MR5gOxDCleha5goaiAszAfj/WHr0elsd82bK0CcRwCIaqnex71
         sFgw==
X-Gm-Message-State: AOJu0YzB3cm2CLlX+xSNoxRzEkH8wvKzadmQPp2Ch62RMxZlVzz5dX2D
	Ajs+Z/ouYBKZCRe8KgJ+9C0+F1Bw2I+upZGTzDAAmpkITX9FzWlV0iptaMo0Ky6y
X-Gm-Gg: ASbGncsuObE1QBwY4p6u+LFW30+Ff2qe8JINVZAKT4Q7U5zFFFB+eNa0jab77ZjsujX
	WBEno/LDVsUKkUGMkJJTvj+ClBC2fzHWGU0Ptm9gfd5nsRitEOE1EeaRjO9pJqHV/V2SuOQEBS2
	GaeWg79ZOoQI4DoCrGvIT6X2t4kddP+rmii6m/VL+9d1QtjjWtifmw85E2osAQIhbDjShUObWJM
	33e2yXMQF/ZI7OSrBG+6QoG2+D4gzNJUMQtlKm5gek7TAgTcsLbEbzGTVDIup7DGF+RYlTwrYob
	+0hpKFT/L0X4YqEBN6Cl+IIyKvdEgn126/YV3kLtm32oq8uI+g5FCO5+SSG8CSqys597bpv2A/K
	+t5kt3efwJXfAnXzAHy+oImW5NdJatQ5XWLLhFw==
X-Google-Smtp-Source: AGHT+IGjdnpWtneX1k3mVf/oUl2sN+bxgWOaXc5fLKuDUkBgJHeg/zH8pbLRbIt3C7urr8u1IDk7YQ==
X-Received: by 2002:a05:690c:6e12:b0:703:b8f4:5b0e with SMTP id 00721157ae682-717b19af767mr45937417b3.28.1752077581777;
        Wed, 09 Jul 2025 09:13:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c467:2cb3:90ce:6b3a? ([2600:1700:60ba:9810:c467:2cb3:90ce:6b3a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665ae1fb3sm25911527b3.65.2025.07.09.09.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 09:13:01 -0700 (PDT)
Message-ID: <492244b9-2402-4e8e-8599-8bcd5d27e2f8@gmail.com>
Date: Wed, 9 Jul 2025 12:13:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
 <CABPp-BH_JGbtDsne_tKBoqDr9LzL==gs0E5xyPdbqygyXs8+vA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BH_JGbtDsne_tKBoqDr9LzL==gs0E5xyPdbqygyXs8+vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/2025 5:43 PM, Elijah Newren wrote:
> On Tue, Jul 8, 2025 at 4:20 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> When users change their sparse-checkout definitions to add new
>> directories and remove old ones, there may be a few reasons why
>> directories no longer in scope remain (ignored or excluded files still
>> exist, Windows handles are still open, etc.).
> 
> Good background; I am still particularly interested in the "etc." part...

I listed the cases that I've confirmed to be problems. There are
perhaps some that I'm missing or overlap (such as "I had my terminal
window open on that directory" which is really a handle problem). 
>> When these files still
>> exist, the sparse index feature notices that a tracked, but sparse,
>> directory still exists on disk and thus the index expands. This causes a
>> performance hit _and_ the advice printed isn't very helpful. Using 'git
>> clean' isn't enough (generally '-dfx' may be needed) but also this may
>> not be sufficient.
> 
> Very well motivated.
> 
>> Add a new subcommand to 'git sparse-checkout' that removes these
>> tracked-but-sparse directories, including any excluded or ignored files
>> underneath.
> 
> "including"?

Yes. If we leave the ignored files then we have not accomplished our
goal in deleting the sparse directories.

>> This is the most extreme method for doing this, but it works
>> when the sparse-checkout is in cone mode and is expected to rescope
>> based on directories, not files.
> 
> So is this also meant for cone mode without sparse index turned on?
> What about non-cone mode?

This command die()s if not in cone mode. We can consider future
changes that perform similar actions in non-cone mode, but I'm
not sure if there is a valuable need in that case.

>> Be sure to add a --dry-run option so users can predict what will be
>> deleted. In general, output the directories that are being removed so
>> users can know what was removed.
> 
> Is greater fidelity of interest when there are multiple different
> types of files contained?  For example, "git status" lists individual
> files within a directory, unless it find an ignored directory and then
> it simply lists the directory.  That means we get more fidelity when
> it's warranted, and less when it's not.  I'm not sure if that's a
> perfect analogy, though; it may well be that we don't need the same
> kind of fidelity that `git status` provides.  (And I'm kind of
> guessing it isn't needed, except in error cases, but I'm just asking.)
> 
>> Note that untracked directories remain.
> 
> What does this mean?  If the sparse directory had an untracked
> directory within it then it'll be left on disk, you will only clean up
> untracked files at a depth of 1 within the sparse directory?
> 
> Or that untracked directories not contained within a sparse directory
> will be left alone?

This second part: "untracked directories not contained within
a sparse directory will remain". This is mostly to point out
that we are not saying "the only directories that remain are
tracked directories within the sparse-checkout" as that could
remove valuable temporary directories that are covered by
.gitignore or exclude files.

>> Further, directories that
>> contain staged changes are not deleted.
> 
> Shouldn't those be safe to delete?  When a sparse directory has files
> underneath it with staged changes, those roll-up into a staged
> sparse-directory tree value, and so we should be able to delete the
> file.

This is _mostly_ an implementation detail. The sparse index will
not represent this directory as a sparse directory, so it's not
deleted. (see the next paragraph:)

>> This is a detail that is partly
>> hidden by the implementation which relies on collapsing the index to a
>> sparse index in-memory and only deleting directories that are listed as
>> sparse in the index. If a staged change exists, then that entry is not
>> stored as a sparse tree entry and thus remains on-disk until committed
>> or reset. 
> In contrast, the files under the sparse directory with unstaged
> changes would be problematic to simply remove.
Except that a user is only using this command when they want
files outside of the sparse-checkout to be deleted.

I'd like to find the right way to make it clear to users who
discover this command that they are asking for the following:

  "I changed my sparse-checkout and some directories that I
   expected to be deleted are still around. Delete them as I
   don't care about them or the files inside anymore."

Some of the discussion around having a --verbose option (in
conjunction with --dry-run) would allow for the following
user scenario:

  "I changed my sparse-checkout and some directories that I
   expected to be deleted are still around. Which files are
   preventing that deletion? I'd like to know what's in the
   way so I can evaluate if those files are important to me."

>> +'clean'::
>> +       Remove all files in tracked directories that are outside of the
>> +       sparse-checkout definition.
> 
> If literal, this sounds unsafe, particularly if run while resolving
> merge or rebase conflicts (since those conflicts may occur in paths
> outside the sparse checkout definition).

If we are in a merge-conflict state, the directory is not
collapsed in the sparse index.. 
>> +                                                    This subcommand requires cone-mode
>> +       sparse-checkout to be sure that we know which directories are
>> +       both tracked and all contained paths are not in the sparse-checkout.
>> +       This command can be used to be sure the sparse index works
>> +       efficiently.
> 
> So...what does it do when in cone mode and the sparse index is not enabled?

It doesn't effect the behavior, since we don't care about the on-disk
format and instead use an in-memory sparse index to determine which
directories to delete.

There could be a benefit for users wanting to clean up extra files in
their worktree even if they are not using a sparse index. It is less
likely that they will discover that they are in that state if they
are not pestered by the index expansion advice message.

>> +       if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY))
>> +               die(_("failed to convert index to a sparse index"));
> 
> So, you make the in-memory index sparse; I don't remember the details
> on this function so it might invalidate some things I say below...but
> after this point you then...
> 
>> +
>> +       strbuf_addstr(&full_path, repo->worktree);
>> +       strbuf_addch(&full_path, '/');
>> +       worktree_len = full_path.len;
>> +
>> +       for (size_t i = 0; i < repo->index->cache_nr; i++) {
>> +               DIR* dir;
>> +               struct cache_entry *ce = repo->index->cache[i];
>> +               if (!S_ISSPARSEDIR(ce->ce_mode))
>> +                       continue;
> 
> ...skip the entries that aren't sparse directories.
> 
>> +               strbuf_setlen(&full_path, worktree_len);
>> +               strbuf_add(&full_path, ce->name, ce->ce_namelen);
>> +
>> +               dir = opendir(full_path.buf);
>> +               if (!dir)
>> +                       continue;
> 
> ...skip the sparse directories that, as expected, don't exist on disk.
> 
>> +               else if (ENOENT != errno) {
>> +                       warning_errno(_("failed to check for existence of '%s'"), ce->name);
>> +                       continue;
>> +               }
>> +
>> +               closedir(dir);
>> +
>> +               printf("%s\n", ce->name);
>> +               if (!clean_opts.dry_run) {
>> +                       if (remove_dir_recursively(&full_path, 0))
>> +                               warning_errno(_("failed to remove '%s'"), ce->name);
>> +               }
> 
> ...and then unconditionally remove the directory, as you stated in the
> documentation for this clean option.
> 
> I'm worried whether this is safe; if someone does a merge or rebase,
> there could be tracked-and-modified/conflicted files outside the
> sparse specification in the working tree.

The conflicted files will not collapse to sparse directory entries.

Does that ease your concern on that front?

> Even after resolving such a merge and committing, the paths may remain
> around until the user does a 'git sparse-checkout reapply' (I don't
> remember details here, but our documentation for reapply certainly
> says so), and since the file might stick around, the user may make
> further modifications to such a file.
> 
> ...or will the convert_to_sparse() call above fail in all these cases?
>  If it does, should it give a better and more useful error message
> than "failed to convert index to a sparse index" and rather e.g. "path
> %s has modifications; please stage or revert first"?

It won't fail. It just won't collapse as far.

You do make a good point that there could be extra help messages to say
that there are uncollapsed directories (detectable by seeing a blob path
with the skip-worktree bit on, maybe). I will think on this.

Thanks,
-Stolee

