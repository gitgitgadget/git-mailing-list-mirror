Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812A18A6B2
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665524; cv=none; b=qo9M9Vy7b9/R1M+BI3P9VlL/IH6wtN0vIAJXfls0hm19MtR7fRuOs8B12ARCRmHuaY3o7Wxf8Ij9bWVBIWcWhiR4jP/uB3Q5NauoXfIRuMEWehgEMGDCnZQWFjKfxTmU3H+fP0xyUiWWDX4ApEtZg8OzIbbtwR0+SYqpszOEmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665524; c=relaxed/simple;
	bh=Ioy8vdZXmSCwWyxt9O+ZheHrOwkByoCtZkU5AIZj2Kg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I6raZChOj5hKxa901IZz1RUsBQQ5fUiH1z2G+h2g6MCd3jScdmY3Ok45llhk1uTkgkz/jjddhEGcNgO4ro5B6pX9q02/j6ItQx1QeuCDr5fF82HOw6tJLKqTSJ8sjoArMzlLeIebFUB5HmVf0i1uTOdS8a9vTYmCDaQ3QOvnXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5H/IUg4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5H/IUg4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-375e5c12042so3757679f8f.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726665522; x=1727270322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrWeJeS2bW4XjcPlFUPBCEdaKaYz7MmJ0RsThuda0Kw=;
        b=L5H/IUg4jfTrJ1YLZF2VnJRSG6FyWtaG3/iKYEJ+GOqweoGvgTuVJCdpEGDo8d59bc
         WY8f3V5l0Z/H3MwV0hiafyLZlc7PeL+V2MsdSI4kYwDcio1KSvQR3r/1P5v9f2Z2f1FQ
         1gWpjIq0s/+zf7r4CU7/uhvhjhX8UBi5okbgSvFvqyEuosPf/UIKrnF1Ych/QannNEg0
         HEHdoaIsn6OPfHhvYFx31TWCC/7IPztsX6QouOLn2vIrViJ9mNH7ZLrQmf4NxrRMUybn
         Z3o3r6N7bieurv65e0yW8jYaC2Sqd7I0VBQ8+7uS9wORAZ9PAnz5eqBZVd6Gm+IeI4ab
         sYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665522; x=1727270322;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrWeJeS2bW4XjcPlFUPBCEdaKaYz7MmJ0RsThuda0Kw=;
        b=DOWg0s8mfRWWwQ4dyenAlU8arw75mlbAX7fyarMfsoucgnZs1BnwMGMv7QUhKR2JbS
         7r1qlXHSKkgZSkM9Wh8fXiuG9X6n8i60qVQ/sI8N+MwcihkICCynqkHnMMl5+y8J4y39
         zpopFCeLY+deRR/vAEHOMJxqIkJ45YUNnGOlFJxakWKKDa7Ne3AZs8eSSzTpfT1aaW1I
         IhAvlcJUNydBlXuQ7DVRQlQROV0mwMx0pbLm/O0OPbPp7rw7ju5KtvmC3+JiRuikBPk8
         YDGEcpq399SysZlG/qxv96tRXNuH4yNoTZ8Tlv1ug0CG1gUJoLsfXBhw1kH//cnnat8i
         tPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyjL7HhEOjX+sYSB90S3vmWDajQ8kVkRWJrOCqBxJUa7D+9q4VgTHR3a58Rt4Gfx4GMPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldTd9gmwzNobd5VNfxIjhr/TA2W1dXUODTXa4ZMYjpC1bw+OY
	EgofqDdV26H5qYw3WLgxIBtXAdwY5whqqZuj1d3lU5utAhqhch7b
X-Google-Smtp-Source: AGHT+IEI6f6gY1Fp1lLUHZjCcg02fsjQB+0PSL8lL1ZI41ExOUxgWOF5xifP8XtXXuVwQBW+UVWovA==
X-Received: by 2002:a05:6000:1f89:b0:374:c040:b00e with SMTP id ffacd0b85a97d-378c2d5a827mr13260333f8f.39.1726665521294;
        Wed, 18 Sep 2024 06:18:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780defdsm12158624f8f.115.2024.09.18.06.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 06:18:40 -0700 (PDT)
Message-ID: <82a08e44-3822-4a26-ad09-4ca1a9b44c11@gmail.com>
Date: Wed, 18 Sep 2024 14:18:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] remote: check branch names
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
 <dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
 <xmqqfrq686n5.fsf@gitster.g> <4915a1ba-eda9-435b-b615-4f78c7fe25f7@gmail.com>
 <xmqqy13vxx3m.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqy13vxx3m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/09/2024 18:49, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>> Thanks for the patch, I'll re-roll based on that. I wonder if we
>> really want to support "@{-N}" when setting remote tracking branches
>> though - should we be using INTERPRET_BRANCH_REMOTE instead when
>> calling strbuf_branchname()?
> 
> Perhaps.  Users try to use "-" in surprising places, though ;-)

strbuf_check_branch_ref() already rejects "-".

INTERPRET_BRANCH_REMOTE supports @{upstream} which might be useful but 
then we will need to check it refers to the correct remote and expand it 
when setting the fetch refspec so a boolean function to check if a name 
is acceptable is insufficient. Given that "git remote set-branches" has 
only ever supported "real" branch names and patterns on the command line 
and no-one has complained I wonder if we're better off doing something like

	if (strbuf_check_branch_ref(&buf, branch_name) ||
	    strcmp(buf.buf + 11, branch_name))
		error(_("invalid branch name '%s'", branch_name));

where the "buf.buf + 11" skips "refs/heads/"

Best Wishes

Phillip
