Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B401F1908
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001983; cv=none; b=bgWz0SBqPSYdoT9p92NEMbUC/l83VOpLBf3YEpOBDRprT9pjM4ENPIbEno2dnyLGsSTZODtb+7PkJoQN31Y0QGJx4000tT995AyaF9MTvfWol1rWxGoHeXdRoslTIYAq52Mh5Q2s96d8DUk/eOUVFsl93ISQ4vWHusEJ1Npdu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001983; c=relaxed/simple;
	bh=oacqcukN4qSHsmbDz7Fg2qRlUTx8DCKdf2W7RUlNppc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=sJ+pfZc8SZT7UtOhwdUF9M2Ep1ggnxELghBaEP89njrtvkvaFS0N3eidxpKIlRJXsECvJdnBYbUFqC8oMaOU+gUV1yY7Rn16gfOFJWj4T2iAF5xNc+6m3kw89Iy5VCh0F/pg50+r8WKh9WN8vrBfH0TSk4PI+30n8tJEsHiz8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irjeIgDM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irjeIgDM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso1778955f8f.2
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743001980; x=1743606780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vC+CYhKroWrUNHbFjRUHBpnEhe5oZyVSB+UXRMECqPo=;
        b=irjeIgDMQZ6siq7PUa/Ld0c48Vn0BpXydxVcYOU53xOgBpkS05l+d9fRRRw8AaPDGI
         /XOPzVvhO0P3VuJaKFoPkYrgUPWBilQ2P7VrzhSHHbVSSUpAAyWjI7wHBIMJeVnXaorl
         nXCNBfZNYlZhZHtogBKTdLIqp5JMGxofPnC/4ytBMMo/teXMxnPu1uxUSMszIC+3d2Xd
         E9HKBaJyB/vIJCG+cnzTFYeuJryJ4OmWsw9QrOlbD5ubV8WWt7batMbyPi4Pera9Jrr6
         gzIkP199kpBrtbmlEGXRHa0qPeDck8kv3ZTG8IHda/lIvsbAZE/6G5C5ZHc75+SfYTIt
         posA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001980; x=1743606780;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vC+CYhKroWrUNHbFjRUHBpnEhe5oZyVSB+UXRMECqPo=;
        b=mfzIVZqZvBKyNboX6MD2KWuWWivQ8aoQzA0O0tcs+7kDaEjbryfZG04d93RRCjAgxl
         EbULld5wFK8DFxrv2otiaQKGhz3xOa2TMnskxCSlpPiwAGuiLRLLqsrsDj6x/1K4lBnI
         xmUE9znEd3EGE7aQ39kRSiwKfzyvsgIL4Ow2vSVUUHO+7sZxCXIabzIJPpOiQOUxZJ1l
         fqWaE7sA91wyC6qgYlbWkPN40hpOVe7fZUQSqzRyLKgz2nuILUOp0v3DRhXQqDlUZLd0
         cGLdvGA9/HcwznVvj7kQFZkrUQXQXb9+b7ZDkugz2iGxO3uj8qFkhg3e8FUPIVYVQSPp
         bcJw==
X-Gm-Message-State: AOJu0Yy/YXJ0ux+MY0oTGohllLdBR7j2U8yYJCNrxJWoDLuWX273iAXi
	WtEWUHEsjcBL4ymFmZBP16ZiXpWDovBpU92fLZll6T2hKtJpB3VS
X-Gm-Gg: ASbGncvbEPAx4T/AHL6neGKB541yngK9UyX8KuLZVFOOZNMzGP3tY+LrCNWX9qsESGA
	c6eiAB9PB3Q0kvw/fXeh0YkYQtKVzcmOw+JhAsiWmHLcrOeMSTSM7AaSBO8D3W6LUTvLqoKg9a+
	+2zfp7tyl8Vy9Yhbzagx2slao1Vjq+u0sdEeAIY6lD7KlQBCQqZRn+zklvxvF78Lutm3+0ddD5B
	N8EtGTAZLQ1PZxIF9SI8+sonuTDID+0NBNq5aXih3d4G3uhVwoSVxtMgiOygosZnPsSVXcLFbcK
	CJptjYzTf/TC5fR67jIZZNsfLjxOrXox+jS775b4gk+TrFh3252+VWLqzgck22gcKuY4vNkrEwp
	i9Y+CNiVGaHOeAMCzjpw9
X-Google-Smtp-Source: AGHT+IEMb+mdmFjjR8Cqb/HPCOo9NXnP04saZE5pE65JtKSho2nPV2KXGAu3pQ7WyPbTcQ87uzRfnw==
X-Received: by 2002:a5d:648b:0:b0:391:4763:2a with SMTP id ffacd0b85a97d-3997f937afbmr20628222f8f.47.1743001980206;
        Wed, 26 Mar 2025 08:13:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5b8dsm17321577f8f.59.2025.03.26.08.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:12:59 -0700 (PDT)
Message-ID: <65e64dda-31e2-43fa-8269-f1bd5f3d26e7@gmail.com>
Date: Wed, 26 Mar 2025 15:12:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: error: could not parse 'Drop' when rebasing
To: Jarno Suni <jarno.ilari.suni@gmail.com>, phillip.wood@dunelm.org.uk
References: <CAOqj8L0hknJ2aYGSmXdUvRgzHZRWBTMgSvywGpc=TUZL-Dqnmw@mail.gmail.com>
 <3b09226a-8281-4560-aa23-74aeaa3ff41a@gmail.com>
 <CAOqj8L1Ammwp07ju2dweVhRVdkTv=hROaDjcoXbxJj8xNq8Gtg@mail.gmail.com>
Content-Language: en-US
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CAOqj8L1Ammwp07ju2dweVhRVdkTv=hROaDjcoXbxJj8xNq8Gtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jarno

On 26/03/2025 10:43, Jarno Suni wrote:
> On Wed, Mar 26, 2025 at 12:20 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>> It appears that the object id for the commit got deleted when the
>> command was changed from "pick" to "reword" and so git does not know
>> which commit this line is referring to. The commit subject is there for
>> the benefit of the user not for git - after all many commits could share
>> the same subject.
> 
> The error appeared first time in the rebase after I changed the command
> from pick to drop (or d for short.) I had never used d  before but I have
> used e many times without an issue. Even the d command worked after I
> edited the commit message title (in new rebase). So I suspect that there
> is something in wrong in parsing d command.

I'm not sure that explains why the commit object id is missing. If you 
are able to reproduce this bug and show the edited todo-list with the 
drop commands and the errors produced by that todo-list that would be 
very helpful. Without that it is hard to tell what's happening here.

Thanks

Phillip
