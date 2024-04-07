Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC62575A
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498432; cv=none; b=cVZjttBfilIZ3iYwKGuikmvdX4vzRsWRlYZ+Jo7izE4A/4DPW0QKSpheiqZ3fDn2tn50PwVEFj20uOQQk7ykILC1nesz/OLq2hPo6blrsVoGr2x4y8eAjaFjfcfC6j5OGmg7n22we2tnpBv7RrAK4jNr4vovIcn22rFhJZPVQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498432; c=relaxed/simple;
	bh=PGvrDjoq4NR4dZo4LUUlJowXMaEhf4ulQAqQLwiuiqU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XCUDPRJ8ySVLPkXEDrsmTFBhU/0HYBftzSfSrnblg+l5EaLE+MewAwMgYnpWHvVx+8aXNBOM8b7L1IBNwAh0BX0swo6Iqr3XEH7iCfc10E5cphU56if6zTS7uLFaLP2PvK9v2n16en3mbK3X/k7lLMx4CTSNDhzATZKMPBfMVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo+HPvQ1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo+HPvQ1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-416422e2acbso3636995e9.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712498429; x=1713103229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+smRgUUXOLtJc1+89M0XIlG/ImF3dPgmocSTR9+KMc=;
        b=Oo+HPvQ1/vry7oqol8k1idUtk9wnRlDugrRxHGlPWeklBOpjXDpTe1xpMbrnAdqZ00
         5WTHLbHRWn1vSOpIFdxlIQlZQvJTDnmZgK0mas3E7pAvhXUiOc2RZobdaF9tXWtFvy+1
         LegzrcZjDdAjH1uCdfZnnutA40zRh4pSc1RwAoc/mz2AzovKgdvSe9ii9kXQtvceDovp
         9fpe/thbNeKQGWB9Cn32+b89IZz1pg+unclKlIMJ88QpM5hXvprUebtLy37Ba4n+1XTo
         vVHz9wt7zf+GpK+avFkwDjmYY6c+LAPMsNTuEhLapZGgKxuoWI74YACyIM8E2q/FBspm
         cIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712498429; x=1713103229;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+smRgUUXOLtJc1+89M0XIlG/ImF3dPgmocSTR9+KMc=;
        b=wpRH9RKbMX4wzfz2u5k9reXRpfVju7cd8WVdl/j0xziR1o15f2KSLR2MnWOQsWvTL8
         k5wmRRhCs4bo+An42g3tMJnzqUqqABFJOZaX+r5QbYGLN+hjRSoFwT4QPseETCp3BlS7
         bOAfHNL1Ag7e+7HeED14L3/itCbiW/d4krPGU1Smi5kkzMFjOaNbFl4OG00caxsBCRu1
         lq2c/WbV4Ban/TCd754rAOX8rFfx8Im2q/ex/o2uPS4Zr+K2fRWlca9OpejCKjIU1L8T
         Fl8hcmQASPhvMbBcRfhAfZuJUfy7/QISlC2f4jgg64I/rMWkMD7+uSdKUaIql6ZDVuU3
         lXHQ==
X-Gm-Message-State: AOJu0YzH9Xb9rm3iBCzZjkR8+drlbRPZzDd5HffAIVtwTybBWCPqevf5
	6gEM9AToRwhI6zNXDhsZKOPd6KvGt5nPuznSu6vnX3Qwd0vrgzNF
X-Google-Smtp-Source: AGHT+IGCaboi6+SRYHmFsv74eOzIHOXvlsPRCIbVw78M1/oARfjdIDBzwunEPhrtQta0O7Wp43zu9A==
X-Received: by 2002:a05:600c:3ba7:b0:416:2abe:b886 with SMTP id n39-20020a05600c3ba700b004162abeb886mr6072666wms.0.1712498428512;
        Sun, 07 Apr 2024 07:00:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id y26-20020a7bcd9a000000b00412e5f32591sm9871418wmj.28.2024.04.07.07.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 07:00:28 -0700 (PDT)
Message-ID: <0bad6e79-42c6-4149-92f0-58c4726080b1@gmail.com>
Date: Sun, 7 Apr 2024 15:00:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] log: add option to search for header or body
To: Junio C Hamano <gitster@pobox.com>,
 Max Coplan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, strager <strager.nds@gmail.com>,
 me <mchcopl@gmail.com>
References: <pull.1710.git.1712353687464.gitgitgadget@gmail.com>
 <pull.1710.v2.git.1712460247516.gitgitgadget@gmail.com>
 <xmqq4jcdhfht.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq4jcdhfht.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/2024 07:08, Junio C Hamano wrote:
> "Max Coplan via GitGitGadget" <gitgitgadget@gmail.com> writes:
> I am imagining a pair of new options to name people (all OR'ed) and
> to name places the names of these people should appear (again, all
> OR'ed).  I am not good at naming, so the option names in the example
> is not more than illustration of an idea and not my recommendation,
> but a command:
> 
>      git log --by="Max Coplan" --by="Junio C Hamano" \
> 	    --by-where=author,Signed-off-by,Co-authored-by
> 
> would find a commit that has one (or more) of the given names
> in one (or more) of the places that are specified, where the places
> can be either "author", "committer" to specify these headers in the
> commit object, or random other string to specify trailer lines with
> given keys.

I like this, yesterday[1] I didn't have a clear idea in my head of how 
such an option should work but I think passing the names and the fields 
to match those names against as two separate options is a good idea.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/c93817ba-5945-4ec0-9775-5621481b972c@gmail.com/
