Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBC48C3F3
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331449; cv=none; b=da+edtd1BA7iROFKan1SwP1Jk0dJp1HxXYNBbnukxcz2GPSvmx96cvgtDuNzuDEkyvwA23Pb4UX8KVboWEDvMR3pwZk3qUb4oDEAf50R8Fn3HtsaEQrVilFXN+AIUEcwSNRwzM1+LjZZ91VAqe2jp+iLTAm/1rXQkSpCMiVXl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331449; c=relaxed/simple;
	bh=5gf4dmjnWqpGlctTDRUiVR2ADduUY4RTtRjna3xYBxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bKOa5txQAOlzkUu/zYtab+sTnD0x92xVCA7zc2t+Tewtc44fhEMIv3MXESNgMzJpwe0s+/hFuSySfBRs1kHf5ikP44zsIVa5TAsHoa49oBaK6+PDwGGhGEJ/IET5/da0Jo+Ao16tf3Q1D7DZSKH5oPc6JqcUbOE76gk7jq35xYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjoTGm0r; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjoTGm0r"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69e8ea2783aso1334302a12.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785331445; x=1785936245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C+ioyortPE21xJqEf/W8feOTcKMZNJ36pIWW86+66rI=;
        b=QjoTGm0rYRCT6oFo/Cxkkr3fbMRFUdA84Q3OqQGbu0FTU/hgBP4iirmQ5aB9hHn9pE
         tgQYtj4g7OemgQ39KFrpKZsop0k2uMXcuqPZ0xIG+/k0HZlh2/kIDI2JbQ2bW25ar4BZ
         Va8NtkWHmHSlUkKwTb6HgyMDrzD5DgHbUcYFAW9hu28RQfBjuU63gEyz0uh5B8S9l1uq
         UumzETs4apPhPdHKyyO/UsEXJ5TYyYl/0yobKMfhID9hGpOH9lV7xKnxtaPtw4eQqxNB
         cBg7ucnKPI0Q+24tN7aEcoMCphms+6jwZ771bRgVpPj+Z24fm/HxBPfXzkXi/pFBsMsK
         /GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331445; x=1785936245;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C+ioyortPE21xJqEf/W8feOTcKMZNJ36pIWW86+66rI=;
        b=B1G7o26CGotFcdxU8W7dKNcK23ePcDiMy0rk34UIWRzjArRLGM7lYT3lzfh+iG1scK
         tdjg9Geooc1Yq9B2W6DOCLWHIH+6cKVEMx9qF1v+h33lNN8g09+44zjH418Cv3IBkCvZ
         5e0FYlNAymrrxe2I96Owl8tLFNOC2Slrkz1pDw6dHE2WCvbrpokFM355JIR8MG04alr8
         ZuQgcbAoznK1GkqNIYbriq6LmxdKwwl6PE+lf9Qs6ZJ7hjgG8jM8OVec+9eCQgn4QVk7
         2HlY9coc0c2tAy2fhH2XHSMFnzpSJp0UODiVIrFbIseIriZ/LWbeJLSoWAUtL214BnOt
         G/bQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrw+LsCscfSKP6nHt6feBp34qTL3/LkuZbsquA8hsEQNn9KcPrDRLhII1W1fiXxZfRT5C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXYkNFXSN6mkO4CNhUjfe8UpS7/AC3X4/sdYl7NdTnu/7xEux
	KGx04UeGnRba17nEI95ctZyjoRaR5uBSFq0zRy/cr99CeSasLdfYBL9r
X-Gm-Gg: AR+sD11r/Yk29e+OgmLi1Y15PFcVjjcNpFfkom81miGciiDN7woHeRPgAXZGODgveiM
	CRYdJyr4fpOaMGJlv5UTTW9CnZRl/QYisMOTIYfE54I9AVv/gQPRO+eRZCJdiz95pg1I2d9rgT5
	Ejo1NBMc/4I0+hjVFTNrILZzX/C+0H5ZNLgZyvCAdI3DUk/YVe2UxpDVhJoRChQYBCnqDa8nLvh
	PFlqX4j7YQ78baBmvh+w20YRAIDPJ7lhX3enODvufCa2rK+CtKtpHSgo7rYnlxnbvWM0BZWvWLd
	S1BhLvhgqS9a5TSGBhQzF632P7BxsaD1vF3cRzPzvzcRkwwXhgpW07Im9EmXxvt4KQ5aDW1SSH5
	eb9zRV2V98b8Gf0P3I5qaZ4pNTfF1/ksvPXrk7FCKeE6Zp0zCuvwQfGkpAY31OQOccEBCdNSv2a
	EIkrWbEi980BiFogSVMmgBySE9WVHFlV13WpGQitNd7bM8sDyGXCX/gm/jTWjDiNNeRCo0J4mdh
	Ziq3mzZxVPBXwzrBK7cx+NXC6aWSZ8zCCeobyDd2mHlobzAOhIo1xY=
X-Received: by 2002:a05:6402:194e:b0:6a0:c62:75c7 with SMTP id 4fb4d7f45d1cf-6a034a9e9b2mr3441042a12.26.1785331444958;
        Wed, 29 Jul 2026 06:24:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c4ac3fsm816455a12.15.2026.07.29.06.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:24:04 -0700 (PDT)
Message-ID: <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
Date: Wed, 29 Jul 2026 14:24:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2026, #12)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfr15ruw7.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <xmqqfr15ruw7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/07/2026 04:09, Junio C Hamano wrote:
> 
> * hn/history-squash (2026-07-20) 5 commits
>    (merged to 'next' on 2026-07-23 at 2790c83e45)
>   + history: re-edit a squash with every message
>   + sequencer: share the squash message marker helpers and flags
>   + history: add squash subcommand to fold a range
>   + history: give commit_tree_ext a message template
>   + history: extract helper for a commit's parent tree
> 
>   The experimental 'git history' command has been taught a new 'squash'
>   subcommand to fold a range of commits into a single commit, with any
>   descendants replayed on top.
> 
>   Will merge to 'master'.
>   cf. <DK1KIF2OI8IF.11188A3YEQV1C@lfurio.us>
>   cf. <DK1KIH6CXW0X.1U2V3GU8L6HB7@lfurio.us>
>   source: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>

Oh, I'd missed this going into master. Has the implementation received 
any serious review? I've seen messages from a couple of people trying it 
out but I can't see anybody reading the code. Having a quick look 
through it assumes the presence of an UNINTERESTING commit means we have 
a BOTTOM commit. It then assumes that UNINTERESTING commit means we 
cannot reach any root commits. Both of those assumptions are false I 
think. As far as I can see it allows multiple tips so that with

   - A - B - C
          \
           D

it accepts "^A C D" but does not squash them correctly. It will refuse 
to squash "^A C" if there is a branch pointing to "B", but not if there 
only a branch pointing to "D" (in which case the branch is not 
rewritten). It also refuses to squash if there is a tag or remote 
tracking ref pointing to "B" which seems rather strange. None of the 
other history commands complain about rewriting commits that are pointed 
to by tags or remote tracking refs.

Without "--reedit-message", it will happily discard "amend!" and 
"squash!" commit messages even though the user creating them is a strong 
signal that they intended to use them to reword the commit. 
"--reedit-message" is a rather verbose option name which does not make 
sense to me as we're creating a new commit with a new message so we're 
not re-editing anything. I've commented elsewhere that I strongly 
dislike reusing the rebase squash message template for this command 
where we can squash fixups into multiple different commits at the same 
time. I'll try and go through the patches and produce some fixups, 
though that may not be until next week.

Thanks

Phillip

