Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D943AAF
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030380; cv=none; b=Iz/Vg9B4V+e+x+XUsKojdxhKoucrF216YzuH3Pig/tnUlpRpyYmZ6NZ2AIs5JmuM57/7/Lr4F/jfKh2JCsE7VigVGu3ZuJTnLoz/rNP3f5W3QSf2pLX1jvvZgHdtqExm3G5znL9+U4kcmghBBuZOnX7hrxlNn7LhBTrA+rkMhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030380; c=relaxed/simple;
	bh=Mlqn4viRLpDllLBm/vQaFoQEkTGKSg4pxamkB7lqr6Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZIwjy5hXzSpuKCh8J2KbC/BUThiX6iTgqLnzc++L/jebLusSIC5QmWawYc7kcTK2quB09o37RUYfmrskYLSLMfw6oEXiVeY3mMJ1x3BO43iXkftIOPVssRxh1k+W4goxw2y/vJ0ui+DWUrzh4hXjdFVDE4hK65Edu41Z0DoQoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol880N41; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol880N41"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d220e39907so64829311fa.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 02:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709030377; x=1709635177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=scHDxWLUoDfyuCwSyPDQpNzWrp4UAxVyxSS3G9JrEis=;
        b=Ol880N41tp1ORcorXvKRLgL43XV7QsrZb3avN15Qv815lxIZP9C9LDuvWgrpAXly1e
         jwnLM609+wBrHj5qud+lRiRbC1If0S7ocpkYhyhTvkI3XUXt68Gmp71ThhbyPqcqNwLe
         NRj+8tlicG7UobADWN/+fxbK85pkHhp5M2ApKJps40ynpoPgsdxjez0jylVtXYVLgn+1
         1SxO2T4wo39BFTsso33ESBurrzazQlYXB5z8oBpiS9/jlBdhuOMcibYsVzdNOm/A4eJU
         +vzPLs2KGKhWuFPrf5ZVUMo3vOZ3fzORBoPuUCsugSfA6V7QWBuJBI24f4fi60/TcfIf
         fnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030377; x=1709635177;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scHDxWLUoDfyuCwSyPDQpNzWrp4UAxVyxSS3G9JrEis=;
        b=ImO1eWQUlNHu9RNXFfB4NCuNrqsuHW0DiBwklhtBS5bwEwu64/3QndkKM0i3VxfTt/
         4h6QlRx1GmATKJM7rDxuP+jjrP46Oy7zc72G+z8/KiDH1SYGZd2U+N5nLDbEfnywuaSN
         7rGWCKY56cKGZabgJwWb4TmUeM+rMTPUL9vuh/X4tvZUWECyoYJLb4PX5d7wdELUSsyy
         xXyYNh1cl9wApBxr94vpWsdV4nYicqQmy5KeWMPGjRCMghWCG1mtQqXkqf+vyBJb72b8
         GHZlyjhWHxEYkiprNP02epJ0noMmbPqglel+SEAmyLVVMU/RGe9PG05MPGwubCSubYWJ
         yXyg==
X-Gm-Message-State: AOJu0YxKeDAVFN6PHGivInfzHeAp3HMyKgL1DUWExyIEw5y0ElWcgH3l
	ZrI7iC751Qrn+qIr9LrTq9Y95OCtvRFQCzz9CitPcqcy1bG5Y1cwNL3F9S1+
X-Google-Smtp-Source: AGHT+IEDpUHEkDmCgWaP6H8PrI1IBCqh8Pzbobb+ygu9xTZzwwNF5FWcO1N4Wr5YByHvyHU/G49XWQ==
X-Received: by 2002:a19:f018:0:b0:512:abe6:2905 with SMTP id p24-20020a19f018000000b00512abe62905mr5593420lfc.50.1709030376898;
        Tue, 27 Feb 2024 02:39:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id fa20-20020a05600c519400b00412acb0b323sm1612065wmb.26.2024.02.27.02.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:39:36 -0800 (PST)
Message-ID: <1004c565-ee6c-4aa4-8226-47d0ef7c8631@gmail.com>
Date: Tue, 27 Feb 2024 10:39:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk,
 gitster@pobox.com
Cc: git@vger.kernel.org, newren@gmail.com, me@ttaylorr.com
References: <17b74c2ffa1884ed.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
In-Reply-To: <17b74c2ffa1884ed.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 26/02/2024 03:32, Brian Lyles wrote:
> Hi Phillip and Junio
> On Fri, Feb 23, 2024 at 12:08 AM Brian Lyles <brianmlyles@gmail.com> wrote:
>>
>> On Thu, Feb 22, 2024 at 10:35 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>>> I agree that if we were starting from scratch there would be no reason
>>> to tie --apply-empty and --keep-redundant-commits together but I'm not
>>> sure it is worth the disruption of changing it now. We're about to add
>>> empty=keep which won't imply --allow-empty for anyone who wants that
>>> behavior and I still tend to think the practical effect of implying
>>> --allow-empty with --keep-redundant-commits is largely beneficial as I'm
>>> skeptical that users want to keep commits that become empty but not the
>>> ones that started empty.
>>
>> I think that's fair. I am okay dropping this potentially disruptive
>> change.
>>
>> It sounds like you are on board with `--empty=keep` not having the same
>> implication?

Yes indeed

>> That said...
>>
>> On Thu, Feb 22, 2024 at 12:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> I do not quite see a good reason to do the opposite, dropping
>>> commits that started out as empty but keeping the ones that have
>>> become empty.  Such a behaviour has additional downside that after
>>> such a cherry-pick, when you cherry-pick the resulting history onto
>>> yet another base, your precious "were not empty but have become so
>>> during the initial cherry-pick" commits will appear as commits that
>>> were empty from the start.  So I do not see much reason to allow the
>>> decoupling, even with the new "empty=keep" thing that does not imply
>>> "allow-empty".
>>
>> Junio -- can you clarify this part?
>>
>>> So I do not see much reason to allow the decoupling, even with the new
>>> "empty=keep" thing that does not imply "allow-empty"
>>
>> I'm not 100% sure if you are saying that you want `--empty=keep` to
>> *also* imply `--allow-empty`, or that you simply want
>> `--keep-redundant-commits` to continue implying `--allow-empty`
>> *despite* the new `--empty=keep` no implying the same.

FWIW I read it as the latter, but I can't claim to know what was in 
Junio's mind when he wrote it.

>> On the one hand, I agree with Phillip's sentiment of "if we were
>> starting from scratch there would be no reason to tie --apply-empty and
>> --keep-redundant-commits together" (though your points perhaps provide
>> such a reason). On the other, if both `--keep-redundant-commits` and
>> `--empty=keep` behave the same way, it makes sense to soft-deprecate
>> `--keep-redundant-commits` as I have currently done later in this
>> series. If they do not behave the same way, that deprecation makes less
>> sense and we have two very similar (but not quite identical) options.
>>
>> Just to make sure we're on the same page, the options I see are:
>>
>> - (A): Neither `--keep-redundant-commits` nor `--empty=keep` imply
>>    `--allow-empty`, `--keep-redundant-commits` is soft-deprecated
>> - (B): Both `--keep-redundant-commits` and `--empty=keep` imply
>>    `--allow-empty`, `--keep-redundant-commits` is soft-deprecated
>> - (C): Both `--keep-redundant-commits` and `--empty=keep` imply
>>    `--allow-empty`, `--keep-redundant-commits` is *not* soft-deprecated
>>    as it is more descriptive as noted by Junio here[1]
>> - (D): `--keep-redundant-commits` continues to imply `--allow-empty` but
>>    `--empty=keep` does not. `--keep-redundant-commits` is *not*
>>    soft-deprecated as it behaves differently.
>>
>> (A) represents this v2 of the patch.
>>
>> I'm coming around to (B) based on Junio's workflow concerns, but to be
>> honest I am fine with any of these options. Junio, I *think* you're
>> saying you'd prefer (B) or (C)? Phillip, it sounds like you are okay
>> with (D) based on your response -- how do you feel about (B)?

Yes, I'd prefer (D) as I think it gets confusing if some values of 
--empty imply --allow-empty and others don't. I could live with (B) though.

Best Wishes

Phillip
