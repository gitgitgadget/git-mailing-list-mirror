Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6115A791
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525731; cv=none; b=Ya2XLhEsAxBwzYo6ByvWZKmauXXelclfAs8XaEbjsKttcRB8wxJd2YavQ0ja6b6zelEQwaQpRHpMX+cUuIrpOPJ5YiU7gJ4COCms1av8WCRYyaVPV+YlN8jB+CRENjCLAJIE7mgDbecg+jAxoE7oGtp3/n2S4YmCrhIwdvuUUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525731; c=relaxed/simple;
	bh=bu4XGKqmiD2IQEbHocwD2cvqiofMLXV0463ZiNksUDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e70yNOxF6Gzgd+HbBq6qXUXKT3YeFv2QPZVSxNJcRdd3vH7Ernb5jW7sHf2V8ZvV/clbDYzkH09Ag0z4KLLFCNuBKFx75lVnPU4YWiQP1sAEmHRx9+dA7s43Zp3oXedBSMMvf8nb2jjT+9jResCTleevIukEk4OpeRoDbUmnQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL3JjelF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL3JjelF"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a35385da5bbso248744166b.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 02:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706525728; x=1707130528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wugp6QSRtXQq+NTxbkMRzeUjQIxzwRiEhExkjjLFJJY=;
        b=HL3JjelFfT3cyfElLhFluVHz1cUMw1MhdlTRNi/fxjGPPxqcCiPjZOuYHFa5I+QSAK
         AklT9P6Ev3MyH0L8/j92jV7wurO3psnNRQvJJKBC5C3txbsPWLQJEtFe/LfXfV1f7oW4
         DFV9QB7sp34w4Br64ByDVub1ztHP1GcN+3XyJbHe/w+mo5vVSkWh1gTPmyWf4I50nZZP
         pf3pHCTSRacWSL+Kq8eA1WBG9wV/sNCEvEuZl0TUubXGWcCKM7q0yU9I3Yr5oSwBAxrG
         MSXCzwd2GU+OK82x0fUVML0WN+V0c0kVuuoCOIiPJ64/ytPZKG+LWOVz2XKgcUzGG1ta
         WOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706525728; x=1707130528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wugp6QSRtXQq+NTxbkMRzeUjQIxzwRiEhExkjjLFJJY=;
        b=gOy+54cWLCbkddyi2lHOapQKlMJvqnRH1KtWa3RoQG+ViJ4my/YkiddYX41zZUEfs9
         +y0Huv//UOT4BiKdKGhO84XC3pnylEN2AFKvajZFk+y3yXEN+oGSuAbyn276xAXOfPhj
         oNEPXCri28FhYC6+CTDfWzo2c+t9j2wWaJWqXqyImgGWLfFTRctglaiCac3tn0v3agtT
         p1FsWkoGybmBseXdfhXEL6OCfA18axSbgro8pUILx7rsOgNZU4BRAQHYTZoIEKuh+eNY
         8KbhUqh9bLcJKj6MnI1a5MtcoDb/Dqs8khTVyz67gGi0I5VkB+8TOwqDlcp1sGEqeODb
         ioiw==
X-Gm-Message-State: AOJu0YzBTuIW/1c/mkGciEF5mvucEqTdzYGa6xh3o3rqWldQQJ5UQo/2
	HqIyTok7NpTLVTNiwv4JJ90SUQEFFr0mbYRoCGuav0Lr3/ommLHcI28jgF/6
X-Google-Smtp-Source: AGHT+IFlphrPTb1RGu3Gz6pTPlAD9eENlOyKj5Hy6BHqBNyKjJjfCTRJtuP5wTV5ufaE4DQduJ/VEQ==
X-Received: by 2002:a17:906:4719:b0:a31:4c0a:dafe with SMTP id y25-20020a170906471900b00a314c0adafemr3687841ejq.72.1706525727509;
        Mon, 29 Jan 2024 02:55:27 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id hu22-20020a170907a09600b00a31641972c4sm3778522ejc.21.2024.01.29.02.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 02:55:27 -0800 (PST)
Message-ID: <b5213705-4cd6-40ef-8c5f-32b214534b8b@gmail.com>
Date: Mon, 29 Jan 2024 10:55:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
 commit options
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <7229fe62-cf9b-4829-80ec-c6b44c52163e@gmail.com>
 <CAHPHrSeKY2Ou9VCq6rtADTOwycc0KCTPaCCwtqf94yLi0wj0OQ@mail.gmail.com>
 <CAHPHrSf=UkR9+hMfb7pp5Y6uHqa2pBrEf+cTLJv=z=BOFdL3rw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHPHrSf=UkR9+hMfb7pp5Y6uHqa2pBrEf+cTLJv=z=BOFdL3rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 28/01/2024 16:36, Brian Lyles wrote:
> [+cc Junio]
> 
> On Sat, Jan 27, 2024 at 5:30 PM Brian Lyles <brianmlyles@gmail.com> wrote:
> 
>>>> For some amount of backwards compatibility with the existing code and
>>>> tests, I have opted to preserve the behavior of returning 0 when:
>>>>
>>>> - `allow_empty` is specified, and
>>>> - either `is_index_unchanged` or `is_original_commit_empty` indicates an
>>>>     error
>>>
>>> I'm not sure that is a good idea as it is hiding an error that we didn't
>>> hit before because we returned early.
>>
>> I think you're right -- Previously the error could not have been hit,
>> but now it can. An error is still an error, and we should handle it
>> regardless of how `allow_empty` was set. I'll address this in v2 by
>> simply returning the error.
> 
> As I dig into this more, I'm noticing that this may have unintended side
> effects that I'm unsure of. After making this change, I noticed a couple
> of failures in the cherry-pick test suite. The others may be a knock-on
> of this initial failure:
> 
>      expecting success of 3501.8 'cherry-pick on unborn branch':
>              git checkout --orphan unborn &&
>              git rm --cached -r . &&
>              rm -rf * &&
>              git cherry-pick initial &&
>              git diff --quiet initial &&
>              test_cmp_rev ! initial HEAD
> 
>      A       extra_file
>      Switched to a new branch 'unborn'
>      rm 'extra_file'
>      rm 'spoo'
>      error: could not resolve HEAD commit
>      fatal: cherry-pick failed
>      not ok 8 - cherry-pick on unborn branch
>      #
>      #               git checkout --orphan unborn &&
>      #               git rm --cached -r . &&
>      #               rm -rf * &&
>      #               git cherry-pick initial &&
>      #               git diff --quiet initial &&
>      #               test_cmp_rev ! initial HEAD
>      #
> 
> It looks like this is caused specifically by not hiding the error from
> `index_unchanged`

Oh dear, that's a pain. I haven't checked but suspect we already hit 
this when running

     git cherry-pick --allow-empty

on an orphan checkout. In do_pick_commit() we treat an error reading 
HEAD as an unborn branch so I think we could do the same here. If the 
branch is unborn then we can use the_hash_algo->empty_tree as the tree 
to compare to.

Best Wishes

Phillip

