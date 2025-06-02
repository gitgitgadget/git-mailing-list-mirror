Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1193C1DE4FF
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872777; cv=none; b=mWLMHreLxAI6MpEjz29VEEVQziPg1e7b6PQ0RtB6Td0OtKDazN5GMkY7IfSKqVFsh5KI1l/AhcDYdOUDO6f+fr2A1yxxNI5eCCq3SspYwfhnykCFiZwhrYPIDZJ/dCo5BUS4qTV6oLdIX8FWoWCfFQSK56i2ENOg4u5JqiaPPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872777; c=relaxed/simple;
	bh=i4iPgYZwHAEZgDbZHUf/4E8RKye8lZhx753Cr5TJ+wk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kFfFQkJyJvtJlxkfLd5M2NLwbN+LtVc4hFNpAIGBCFOM1hjgmEVwSdmKU78vw9yJi6wNehYGAxnU1yABMq7SKBY5XhGJiS0jvd2x71MZskuL3L6PjZUwvjYgVLptRY7UB2UXcz7/oMEWUElgCK+VMneo1FVpLAHPTzokk0NUZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4HRFSsQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4HRFSsQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so32133845e9.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748872773; x=1749477573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCyV0PEmvhKHsba06Ffk3XQJYByRw2cJX41zPBr22oU=;
        b=F4HRFSsQ08BfIzIyj2l4Oj0HTSWxUpbu/xb/qIjvbEj2t6G4G55jzrhIs2tRkgKprs
         CW7dSYNLUpcwRN0RpuFETDCNXxKfFHg3F2+6VOGzAtnmko/smT6wRGiZ1sctj6rpoYAM
         kGATyVD2OmLCk5vLGiOT/FF003+jhsy5Z+lj5IqdYtfow8HLlNrdLQKlxKfBRGm/G2xz
         1s2kVo/S9h0kWZB1vW+M/Nxoxwto51lM82ZddMnS0txIuvy0jl8x57UNHJrchmV9EiUS
         OVH2qRIREOyGR/tqvlc6CNv9JYBQW0VBwb0+B65Zt4Kc2yFlfQzpRB6Lt6TXglBVrm9S
         6WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872773; x=1749477573;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCyV0PEmvhKHsba06Ffk3XQJYByRw2cJX41zPBr22oU=;
        b=XMRg+G0SS9KW9IlophqlbkjfRkuVxnb2TCtT1qIaL7dFa8WkoaW24B0Noi/3PC5J/E
         8PHCLohVBbbvBps8slfUlFd3r0ptwQDBQClfcI1vVmlLahAPDObSpGbQYJq1YxVnNnFO
         PAE7Dn1o+XsZybrmEc5u78zV4EkX3XxJaO9HL4Oa3sNHn/PuirntNek5i5Yvhwzwv5XU
         nslahds152970yAH0pPwbWSneIytb/dhBI4fgV1/qnM4YOFKUaAi66DyKWxJKFPx+e6b
         g1G2jnvTz+g1iY11Kdj9ljZnjBnIYoWbNjEXzRVDfRMhRRUPILucTZTLU5MAvF0JCb4h
         2eIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp8VviQCdDBkYq3CdsMGt//8GzAJBpoey761J6cl47aUm6znXsP0YTlL3sPpUh98HrPvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPl7FJP43ySDfQcpD9Cv/7l0cbhoDGCXoRC4IN3DyJZ6i7SuLN
	epiIdE/bNhJiqeEfdGBexrOWtGDo8OJDscAq4Pte+YOqLXOIytOl4sib
X-Gm-Gg: ASbGncsalfqu7ULtZLI3iYkgosefAjQQ4SIO4usyMNRRou07+Ku3txMkFHYA5cOIBoK
	O3+Fx615sUubwc0f4v5nNQOw2WRCxb/kbZmOfuIwHbUV4FHHNBacSJCpyT3XwQAev7yDLgnDB9P
	ZXR7x9BImZ8cXMSJzen49Svf7AD6kwdz2rquoOIUTjYfzHTDNblCoYzNNd7mVTDSrsztHXi+Wkt
	f/g8/pR1LLvyBG0566Y3SZ96zX0So8z1ty6SZsfpMHxnhrt1N1uIUyoNAFDGfVvEKBusvHJ+PVj
	ZLfP9o2DegabVELohfY0a9uh/Rbp0sfRdaM7JSuUBtOd3/sL+lzBSYxw3D8atMGI+NsIRBCecLt
	OA8YqK2DbRPSbtHJe98IiAvI4Ou8=
X-Google-Smtp-Source: AGHT+IECSRuVfC7SsEknKKz0JPfpFyMNP/Sh7LrkkzQw1V39DnHY8lTChpYGOSmf9lCeLrWxxXQphw==
X-Received: by 2002:a05:6000:2407:b0:3a4:f024:6717 with SMTP id ffacd0b85a97d-3a4f89e169cmr10747204f8f.53.1748872772989;
        Mon, 02 Jun 2025 06:59:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73f01sm14643713f8f.45.2025.06.02.06.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 06:59:32 -0700 (PDT)
Message-ID: <eba62aad-a396-46d9-9a37-3521e4e7a23e@gmail.com>
Date: Mon, 2 Jun 2025 14:59:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: replace error() with BUG() in
 update_squash_messages()
To: Junio C Hamano <gitster@pobox.com>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
References: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
 <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
 <xmqqr008peil.fsf@gitster.g> <edd4d392-f124-4e97-b4a9-6cf3fde1e804@gmail.com>
 <xmqq1ps6iuw0.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq1ps6iuw0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/05/2025 05:29, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> OK.  Or
>>> 	if (!is_fixup(command))
>>> 		BUG("not a FIXUP or SQUASH %d", command);
>>> at the very beginning of the function?
>>
>> Asserting the precondition at the start of the function sounds like a
>> good idea
> 
> I am of two minds.
> 
> I do not know if this is better for longer-term maintainability or
> not.  Such a message at the beginning of the function declares that
> the current implementation does not want to receive a command that
> is not either of these two.  Such a message tells the next developer
> who adds another caller to the function to make sure not to pass
> other commands, which is good.
> 
> But I do not know what it tells to the next developer who wants to
> add support for another command.  After opening that initial gate a
> bit wider, perhaps to
> 
> 	if (!is_filxup(command) && !is_my_new_command(command))
> 		BUT("not a FIXUP or SQUASH or MYCOMMAND %d", command);
> 
> would they make sure to handle their new command correctly in the
> if/elseif cascade, from which we are removing the "error()" with
> such a change, and would our reviewers notice if they forget to do
> so?  I dunno.

I guess it cuts both ways. As you say it is a small function and I think 
someone adding support for a new command would need to do more that just 
change the precondition to get their code to work unless they're calling 
this when they don't need to.

> In any case, such a future change will have to be done with a good
> understanding of the entirety of this small function anyway, so I
> guess either way is OK.

Agreed

Phillip
