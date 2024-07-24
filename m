Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58515B551
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837543; cv=none; b=plCSiK4/g28Jfru08P/3rXmAlC/hp9Sx0vrhyLEPJRy5bGqIn4HJeIcKevTUC4z2+uxSdn7/Eoe2QVd37lgrARzt+xKXKOvSpqXmjfw5ovx7Ncn6PQA595hJ1sojHb8CsWl3D4yAvVX+YlST1cGivKah4n4llBvlzskDwHeSNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837543; c=relaxed/simple;
	bh=kg+GX0DIW5kXyMcvRI9Vi03vuX/ds1jTBV0Xsw4IPdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZqTf3FKqE/PqsSXHqBPWxgluh2nFbQOpdgpxssBLhCiz5dRL9gF6w1IctCH8PzyxRKln7q3svbbUbntQscdYCsPYaUZDsED1Bm0C98NilxJKdtOUpHIuCFIQZ2xYTAM0HVg9BCwo1LRham7tCpBR0l08Iq+RRAtYBe+INXWdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/FDAUdj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/FDAUdj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427d8f1f363so42238305e9.2
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721837540; x=1722442340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avzsspDN7Wy5yniD9vUzTfLgEKTAMe3MwdMYKPre/dQ=;
        b=h/FDAUdjGCMnNhBBF21EuRkW75SO1t7BRHPiR/XN/nndKtXvKNApHtRJWJvhkVpfT9
         YsTu6JnvZTM1xR3+Cbtl081ZVtrpoc6PdDqWV/ZcKmINmMQw8QUNotsfjTbTSp7hulOt
         jBIR+YNjBqSNixuaUvsmrKTT9IA6OHRkUt9+uAYl9H+cK4vRGtpXNQQ8bZOHMF28mT9b
         Fx3q00rWtHejfovh7+X1KnUNr3QOumXmZAESVKkIRzT52w5cEFs0DpZxVw3opCZsFk4y
         IT3Fcs/4/NZTPAmuUtlZURZLiwu7/bXQTvPSwurFDaWxSBwA9/6yhZdpN1YKCQEM0Pun
         V+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837540; x=1722442340;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avzsspDN7Wy5yniD9vUzTfLgEKTAMe3MwdMYKPre/dQ=;
        b=BioS7u6tcfxotO9wnA6dMmYRY33RlXDTWPSTTzRmJiBM7s5jpxMxI+mVqe3CdLKyw2
         GH26H4R9KmwPlOo/rUDgs44aqYIiU16mpjLByHmajgF5bCXPW1wxywcGTbFRXbkrMu+w
         PojGipCHOvKWH0+AxWUplWfDMkqE0E9/Yqy4w6dQtQTJko0oEfaF7B8gx5bA8Hny3YRU
         V6YQ9FMPpB89rou/lRyPwcp0yYGr7TUM0751K6avsWNHLVjIKKl5uBAhc23OtEjbcHGz
         le87uLottLF6E+2nudkX/o2jrDCZthIY2UZ7NX5Pi4fxC5yy68DNBhuyQnYkvb7H+Bv3
         E+Mg==
X-Gm-Message-State: AOJu0YwLq/5YNTLsa2yCcfNsdBCyp+Vkka0kKABfMEP5js0o2iX52sZm
	96MUOfqFtFnkLCr65GkV97n9lfQgGv71pTxAbs6HPPODr/5MqQ0s
X-Google-Smtp-Source: AGHT+IGZNZq3rT2x5IR4afmPdzDrfMQFH6XlV+86TnV6Ob3o/hBxH5EYLK/NkNSucscnpbHy0RtevA==
X-Received: by 2002:a05:600c:b96:b0:426:525d:ce3d with SMTP id 5b1f17b1804b1-427dc567549mr78159965e9.33.1721837540189;
        Wed, 24 Jul 2024 09:12:20 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f938d63csm35642015e9.20.2024.07.24.09.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 09:12:19 -0700 (PDT)
Message-ID: <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
Date: Wed, 24 Jul 2024 18:12:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] add-p P fixups
To: phillip.wood@dunelm.org.uk
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jul 24, 2024 at 04:21:53PM +0100, phillip.wood123@gmail.com wrote:

> > I hope that what we already have in Junio's tree is the final iteration
> > of this long series and that we can let it settle before making further
> > changes.
> 
> The resulting tree is good, but the history is not bisectable. You should
> squash the fixups locally, updating the message of the fixed up commit as
> needed and submit the result as the final version.

That was my initial thought [*1*] when the problem with "dash
0.5.10.2-6" appeared. 

Junio proposed [*2*] documenting the changes to address it as a separate
patch, and I think it makes sense and it is valuable to capture the
situation this way in the history.

Regarding the bisectability, I don't understand what stops from being
bisectable.  Except in a scenario with a shell like "dash 0.5.10.2-6"
there won't be any problem.  And in one with it, which should be
uncommon, the situation is well explained.

So, I dunno.

   1.- 2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com

   2.- xmqq7cdd9l0m.fsf@gitster.g
