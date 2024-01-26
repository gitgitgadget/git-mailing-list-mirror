Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4F63A
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228100; cv=none; b=jCJvrmEgZvvV6OmDCJyBQ8TAPaxs6geJwbYgayjTG5SrLob7primtHR3RuPO0vHs0m0wqGvaGXRjuM7S93Laytsqe92lGRs6bsg7g/cUCQZGYnghzs084PeqF3j4xT1KMk/o2/0GPuTl8pBzvPKvwRECMXWEwkGHNxPhLZt/UIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228100; c=relaxed/simple;
	bh=oaAh5LcBPDJFKACMqQWRZrlW8XrVnfV6mVKIXUR0v/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SSsRhqYzDI+007xzgUi0RFa0M1l2mlFfRS1ixMoX+jlLecM25fhgsD9dFcKffHxiFhUsA4GIYx3YWyS7mqDqmsRljD0y9Ad0gfyG3sRla8VDwC/zUB8kJORcaAlmEADxz6whHomyUWik8Z0sm7Fx0X/OaiTeuO0eKbskh96tmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zh5HPier; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zh5HPier"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso15294457b3.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706228098; x=1706832898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fULEsA73+89sb26aoBns+LEvkV1QcBJCDncsyIUMvAs=;
        b=Zh5HPier8Kb+2orXMdPCW+Krms+4m7MdUkx89+hwbsr0V8PyXR2zUsnOgzwnp2mZpc
         GSL1vwbV9zlNN0h4Rwv31lplO7qB3wMvNzvRg0rUr4WhYnv6pRWDBNMCrEnDuBDVmHg3
         ImSTkNes1BDs1ojuTt7dTwJnAtXvbVHOG6jSIkcOWtQV7HHodpVa3f3fDzYpEZR6u6Jq
         HwMuHhYE6tCKAypJaGDBYie5oBT87DLOcjO+WHjs78zN1SJm2cLAlEEFVagMtQRe0xqS
         N2iACc6MH93FAlQNYgEHDMzggRygl3zmq79CfeUaYuhpZsBbLjeJ2KEbSzEPa34BxaZR
         3NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706228098; x=1706832898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fULEsA73+89sb26aoBns+LEvkV1QcBJCDncsyIUMvAs=;
        b=H4Km8NKWkvDRCmyG3GaSSJ8eDH94B/VE6tO/rEz+LjhOV4vIbihWAWcPL/UFltF6Ae
         tpqQRQ3kldO4SzPFGI4HYdrPtIzeL023scD1oGmWYEx7OVOz/4ssJe1reOPbDMVMu+/O
         pf23+a33aYzn0y0akl1jDVTUjfnFK7XnVdghH7q9OnRFJF9WrmU5M+AlcRYyYkD8q5ey
         TmAs3ph54VHu9fRYVVpUI03shtkAtPdtQNYNboHzFkmKNMVp+0P0UFcWhd62ro6xSX19
         iyqOJo/Yb5wDdROJuPczuC8oTfiiq07xrpJzRvBJF4BOgy31b8vVEQBvboA7buRvVZlr
         hWAw==
X-Gm-Message-State: AOJu0YxMfqtTVAG2rl8grxeAeZ9CHDMhcQSfUmJtmH0W6rC71GKla2TP
	7n5BPqNvenGc2+7wZyWdFx06GuwX8ytaWtt2A4f2YJMfvGxvfgNko5HCorI9TaPoU4OkR8QkkbN
	UwQ==
X-Google-Smtp-Source: AGHT+IHugxG5+FLbje62Sk3ArNW6ZDNJQ984YNdo+mODihegkX+nJaeC8rlrv19tYCl1HYQmIJTPIKLkFSg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:118f:b0:dbe:49ca:eb03 with SMTP id
 m15-20020a056902118f00b00dbe49caeb03mr45676ybu.5.1706228098026; Thu, 25 Jan
 2024 16:14:58 -0800 (PST)
Date: Thu, 25 Jan 2024 16:14:56 -0800
In-Reply-To: <ZbLxG8zVZAnrCQea@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <406725df46a81f485d7a74c11488e625d3026dc5.1704869487.git.gitgitgadget@gmail.com>
 <ZbLxG8zVZAnrCQea@google.com>
Message-ID: <owlysf2l2bnj.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 08/10] trailer: prepare to move parse_trailers_from_command_line_args()
 to builtin
From: Linus Arver <linusa@google.com>
To: Josh Steadmon <steadmon@google.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:

> On 2024.01.10 06:51, Linus Arver via GitGitGadget wrote:
>> diff --git a/trailer.c b/trailer.c
>> index 360e76376b8..e2d541372a3 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -33,7 +33,7 @@ struct trailer_block {
>>  	size_t trailer_nr;
>>  };
>>  
>> -struct conf_info {
>> +struct trailer_conf {
>
> Can you also add a note about this conf_info -> trailer_conf rename? I
> agree that it's an improvement but I think it should be mentioned in the
> commit message.

Will do.
