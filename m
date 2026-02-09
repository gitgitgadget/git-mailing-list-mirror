Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7302BEC45
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633806; cv=none; b=n4Xtn/NfvU9o0t5iuOuEw0Sk/Bjuq2/1mXDl38QR5lDhdXLQqxeaJMTLflSxSys6/wDt8EEAVAFnEI2qKSNDD0v/v7AvvvFcOEqo92Bof3qGfQ3SiYoUT/ybO8FJq7DfSjiduEFj54J8hSXesrK9BdQK3SM78OfD+ivMdmkzgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633806; c=relaxed/simple;
	bh=ppwCB8C7iVdDOEhnhicfOkU5fLNUNLeHVqsyA9abOuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqY7EL+3AvTAVfaB+gbZse59vEpc7T6nxGhkOCkBjP5PCWuOa5X482O9kbRzGL07JM89B52Y0r58eOThzIVnICfznAEkC+qEF2gFzWHMoIMAOAeeMGki9+2p/oUQceDSxaEomYk3kg27i4SRVHu2Fdb6gSboWEKiI2xqUhON3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwqMOMtQ; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwqMOMtQ"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so43454745e9.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 02:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633805; x=1771238605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=exRWPoj3WLVk8UCuVUA2ygHIiEkME1xXNp4qRfCucus=;
        b=BwqMOMtQHezoBJepAKSJfNTxTQxh/cS5IqofzodiOipaC8Y6IXac5aodEJ5sC33yiJ
         0utl1zQOfArYmMHA4h7OBwNuU1V+L3GKOg4M86DgCTQwEBUcupsQ//Ee4rpvb2CJA5uX
         9JVq/umvZinQdKIu1GCNck8BHmEUYby7wAXB3glZgOww39V3ttp47qzRy/dlY7mucTsm
         n4IR1jxL9lWrAGXbDlIECLHH7OouCb0ZAsnU9VP6IZwdyafDv8OKqQ276qThmhxeZVuD
         faCJorrjgGFfHu8f9KTQ+Ji8RruxKuOxycdPJsj6EecyEbmBHzQdSjPob0Omz54FoOQu
         VHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633805; x=1771238605;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exRWPoj3WLVk8UCuVUA2ygHIiEkME1xXNp4qRfCucus=;
        b=sSRVuVtv1IHWN5PcRqeFZwTTPtfVLXFejHZSTIeirS4uarb0WRcnm4NoyJi0ZdZXw7
         TMsYPK7uklxKq1uQewSttlO4ANOysc2rnGd4AnA24A9Mt+lNfC+fgkKPEnbCvqB+H5r9
         FziLB5t7C2F4dUNJpWQAtuvYTUGenM8BjSeWvfvqmHFlrNY5uguDciO0vGFGt1f2F9xY
         Mi/rh1108BhjJmS2No0G0A7vNWzQjsvKtqelw3i53iPNL8QKkFQE+NVJkXp6pvDK2BYg
         x3dGxJ9xQ5yJxCEAT/Rk3YPXwLRJlxVaLxN/32XDJbxUjZRKXZzKK/oXI/JhqvWOD5dz
         fuaA==
X-Gm-Message-State: AOJu0YwaJY0Yfp7evfUs9fcFn1rgxzXfBtO1GJh2EH0SZgZQ6EtTIO3w
	5IuBbqWr5ZxSibm6MdAKM2u4sYKEQ8QT/ZQM+AlDVR3xnVaFQ10tWAHx
X-Gm-Gg: AZuq6aLkcmSJg0JwThQFwVho94tZTfg42kUTOPOh4C+225Ic3853alm4XV0t0ne9Tx2
	uvgy90gL/yMJw4Yksk/XkWf+J73simcsTbk8Xiaomp1Ye4Bj8QLdarLJ2ZB1yuI8Kshipmum6og
	YJwgm03vL4+Gcrb9ok9xwWQVTujzx4tGVn6IK6v/0oCMeC0SSj/LqHWjyA0FjhSfbAKjsLLi9d4
	3bqLM7EgFLuJNx9zb5bT9YSCkM+/m9mw6C8foIJhQ+lz1PlLi2PGuHBikjAn6L6h1UvGUPQDoUy
	1imB+UXiUtVi2Vj0SCoKhLn7BsAKOhjtS2pF8ag13RrOrXEMcGbJht1yn1uwAg6LMQv6kHBiwqY
	fkTiFysjxhXE/0Q+u/IrXThj1TitGNbRf8ZhG7ermdpJScIqn8rBKL1CptRLRvIR5mIpp3jMeWY
	f1zj5p5X+E9ODsU+6mPxcFCxXt343k1OM0vTwb/571/R7QXH+bEHbOmlybyoAFK8IOKTc19CL+F
	979
X-Received: by 2002:a05:600c:4753:b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4832021b564mr140402215e9.18.1770633804451;
        Mon, 09 Feb 2026 02:43:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320719bd2sm211795185e9.11.2026.02.09.02.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 02:43:24 -0800 (PST)
Message-ID: <f5f100de-815e-4bf3-832f-3d473413c635@gmail.com>
Date: Mon, 9 Feb 2026 10:43:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] commit-msg.sample: reject messages that would confuse
 "git am"
To: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Matthias Beyer <mail@beyermatthias.de>,
 Jacob Keller <jacob.keller@gmail.com>, pyokagan@gmail.com
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770476279.git.phillip.wood@dunelm.org.uk>
 <20260209065703.GA585828@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260209065703.GA585828@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2026 06:57, Jeff King wrote:
> On Sat, Feb 07, 2026 at 02:57:59PM +0000, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> On 06/02/2026 09:03, Jeff King wrote:
>>> I don't think there is a way to unambiguously parse the single-stream
>>> output that format-patch produces. This is a reasonably well-known
>>> gotcha (at least around here). E.g., some earlier discussions:
>>>
>>>     2024:https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
>>>     2022:https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
>>>     2015:https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
>>
>> If we cannot improve "git am" perhaps we should update our sample
>> "commit-msg" hook to reject messages that will cause problems. Here
>> are some patches to do that.
> 
> I'm not entirely opposed to it, but my initial reaction was two bits of
> skepticism:
> 
>    1. I imagine that hardly anybody runs commit-msg hooks in the first
>       place, let alone our sample hook. So I doubt this will get the
>       attention of many people.

I think that's fair, but having it in the sample hook doesn't do any harm.

>    2. I'd guess that these days only a small minority of people care
>       about sending patches by email. So for most people, a warning about
>       their commit message containing a diff or "---" will be mostly
>       useless, if not outright confusing.

People do download patches from github and apply them even if they're 
not using a email based workflow. I'm not entirely clear but I think 
that's what happened in the post Matthias linked to. Though if they're 
using "patch" rather than "git am" to apply them indenting the diff wont 
help.

> I'd imagine that documentation updates would be more likely to get read
> by users than the sample hook. And a warning in git-commit itself would
> be even more obvious (but fall even more afoul of (2) above). Adding a
> warning to format-patch would help with (2), but at that point it may be
> too late to change the commit message.

Kristoffer has kindly updated the documentation. I'm wary of adding a 
warning to "git commit" for the reason you gave above. We could make it 
opt-in but then hardly anyone would probably set that config option.

Thanks

Phillip

>> We could perhaps think about adding a more prominent warning to the
>> "git am" and "git format-patch" documentation. The docs for "git am"
>> mention that it splits the message on a line starting with "diff -"
>> but maybe we should spell out what that means for commit messages that
>> include a diff. In principle "git format-patch" could also warn or
>> error out if it creates a mail that "git am" cannot import verbatim,
>> I don't know how hard that would be in implement.
> 
> I think the patch from Matheus linked above added that format-patch
> check.
> 
> -Peff
> 

