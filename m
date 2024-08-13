Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA22198E71
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556696; cv=none; b=o83S1See0oVAH7Eg9ReIMF9SbMIFxU7s92mnNluyMp2ONo1smTXxUIMn+brg0/2cVtj2l8RTYuNfuHy0v0GQ7VDrGbi2I8H+Oc8Q5kPvsNDtpFndRefGNc+wKBkOvOrvZWvjL6dCSJ5iLrLqX+NWH+WoKxyAoJxiF7v2O/1KnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556696; c=relaxed/simple;
	bh=a/DrfBgfCZYdUSRRqn5vGkCgE+MSeyhCsDS/YeiYFLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1T1vvA8j5g9xnx5+wcbUEeZ2GjoBvPfSacoWslMOkMxe0eyr/qRo/yh+jfFO9GD91j9eAvbx+uBAiStbJ32PslsJtDcAPXWlJOv+vtYd5Bb7dCqF43NI/CQtuQgHXE/TUvDbPXms9z589SiGY6WDrhIA9/FqIeCfoNMZ7BJjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5fLqPY9; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5fLqPY9"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-690e9001e01so53373177b3.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723556694; x=1724161494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOnXbW5XZOSlHoHjUxBeneQsIbKUwTeNPeXIKQLGpMg=;
        b=O5fLqPY9/5q5SFLGz8zCSOVL8ga3uJm3atifDGS73OZhZkPEdP01ysJtA5/g+TSTJl
         bk9HSsYy7an6HFsjE4l1fbNHZ6qPzWzmiCBfAvadP+3reZ9xkzHtEE83LRuPvn2IivoB
         /vyE3k8HZhebtWR9yDQ2YUFA2eSes0MIMfa3aJ6G78mC8CcdIw+Na9vQVXLh95YNIuq+
         PO1vtRUimJlZSUEviy7bMu1zCX3BYPziTvgsdq24+4iuDPcNPPHulC3o47nfNiQktC45
         //4VHbyBipET1mFp1wclQX3jBhTJTweRrHCJa6RjY1RV2BQyYwVnv1LWarS94r+y8Ehi
         Uvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556694; x=1724161494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOnXbW5XZOSlHoHjUxBeneQsIbKUwTeNPeXIKQLGpMg=;
        b=imCa+vr+GcvkqV0/9erEvX5H0ZJwEIsobqcdaLGUjIUp2CN2R4Z0q4rTqXYjwFTWew
         Oc4FF3Vj3O0B0DvSX7Cd6dN0RmiaWB/6poh3RkSmrmM5/0tP/OptHqa27po1XDNMbfl1
         msZevThk17sg5wpa+KErMRzZjcz06yYUopX8Sahx/5SBd78cIHnDlLgmYun9gpLhLmQy
         4ak2QYCYxnDuYLvKESSCyRg4SpW2g9EMTiz4b/yIvNCPrcFjitczB+pppwIcs6cvSXhU
         YjZg7bARVO59YQlKrhKMbQxmHoaxUqSVFG2NvAhL1k+PMFgcaWN4JBD0PtA3qyADrfuj
         IefA==
X-Gm-Message-State: AOJu0YwDWSZrQKm73Ow72AE+c3SDfpEt/a/xceVFe12DZIiYqQrLCIS/
	r89HIIqoecB2K0e8qH+c5Q8A0JVAsoL9NzP2pXcHrVCtg46IzBBr
X-Google-Smtp-Source: AGHT+IFaFN/WTkb/qMTZnMQ1K9yVWq0kMTyuswq5fhYITXGWgC7DMjp2raI34m0C3tlvFRpxL2SR+w==
X-Received: by 2002:a05:690c:888:b0:65f:cd49:44a1 with SMTP id 00721157ae682-6a97285c627mr48183367b3.22.1723556693654;
        Tue, 13 Aug 2024 06:44:53 -0700 (PDT)
Received: from ?IPV6:2603:6081:1c00:1341:80b4:b73d:2075:7041? ([2603:6081:1c00:1341:80b4:b73d:2075:7041])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a50a27f6sm12166587b3.140.2024.08.13.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 06:44:53 -0700 (PDT)
Message-ID: <8b1b05fa-829b-4f3d-9c25-cbb478176531@gmail.com>
Date: Tue, 13 Aug 2024 09:44:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] for-each-ref: add 'is-base' token
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, vdye@github.com
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
 <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
 <13341e7e51241e077a85ea83eb76d4e48d04be7b.1723397687.git.gitgitgadget@gmail.com>
 <xmqqsev9zc2j.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqsev9zc2j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 5:05 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> +		} else if (atom_type == ATOM_ISBASE) {
>> +			if (ref->is_base && ref->is_base[is_base_atoms]) {
>> +				v->s = xstrfmt("(%s)", ref->is_base[is_base_atoms]);
>> +				free(ref->is_base[is_base_atoms]);
>> +			} else {
>> +				/* Not a commit. */
> 
> This is unexpected.  I thought that most of the branches except at
> most one that gets annotated with "Yeah, this is forked from branch
> B" would take the "else" side.  They are still commits, no?

You are correct. This is leftover from copy-pasting the ahead-behind section.
Will remove.

>> +	for (size_t i = 0; i < array->nr; i++) {
>> +		const char *name = array->items[i]->refname;
>> +		struct commit *c = lookup_commit_reference_by_name(name);
>> +
>> +		CALLOC_ARRAY(array->items[i]->is_base, format->is_base_tips.nr);
>> +
>> +		if (!c)
>> +			continue;
> 
> Hmph, wouldn't we want to leave array->items[i]->is_base NULL if
> "name" looked up to "c" happens to be non-commit (i.e. NULL)?

Your comment initially made me second-guess the logic here, but...

>> +		back_index[bases_nr] = array->items[i];
>> +		bases[bases_nr] = c;
>> +		bases_nr++;

This array of "back_index" is intended to allow the array being passed to
get_branch_base_for_tip() to have no gaps with NULL commits. The indices
are then translated back to the original array items when scanning the
results.

This matches the behavior of the ahead-behind code, giving an existing
behavior. The alternative would be to allow get_branch_base_for_tip() to
be sensitive to NULL commits in the 'bases' array. But since we need to
create an array of commit pointers (different from the array of ref
items that we start with) this is likely the simplest approach.

You did inspire me to double-check that this code works in the presence
of non-commit refs, so I'll update some things and send a v3 with a new
test. It will also include some things to make error messages quieter
for that case.

Thanks,
-Stolee

