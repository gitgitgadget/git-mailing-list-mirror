Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127D149DFD
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708135173; cv=none; b=clWsl3dExB/x2HCGgbr9Xe80BYFYxsw1dphJEUKL4wzVoSKiw/MZTY987bp5rN5ZBIAa7esvME8Fta+X+2FZmxEPnec0YkvMgxxCw+2qSYQlIyeCAnJ0eA9IfslThceSKHXIntlGtcSEVgzgY81dDt3cO/Q0hEahQaDKd/XeQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708135173; c=relaxed/simple;
	bh=6PAMlmLAybt9MRMvSYk0N/52EdJBRFXN15t/MhGhkKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nkZOj8xfLbaVOfYyNvvJkMLEQ7LBM9Pc8MD+pD8/tWrQP3/iRxpWpXMx/9PnPQDld/VrhLiXTdDVLiJiN0Z4dt9DaCOIIWfaMKAJfMhdK9wlz/45q4n6ZYd+hUq4H4OFxJmrFtWQZfU0CVTxrJtDIZlKI+dJYvzkg3Y4M5jJ1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6f/oPrm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6f/oPrm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e56f7200so20083257b3.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 17:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708135170; x=1708739970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PAMlmLAybt9MRMvSYk0N/52EdJBRFXN15t/MhGhkKc=;
        b=l6f/oPrmuf73R62UAc2jihhOBQMz1gj8UR6VkeBJnKSr+IDLkRkCuMSuFeO5QjpSL4
         z8KCq88Iw1/a0UQT85gOckzMcTireX/TCJHoqjCsj+1HGrbDpngn9fdWyT3R9w6Yl6Gs
         7hnUZsyteiKDzuM0gE3PtFn+UMBN9VG9ucR2K3+ktN/i8xXn1HnaXravKBNEWBmdqkzE
         mDFsKTBIjjjxsNp/3zRZvrsVaH5yezdcyk/im6LfThEApJXIOqaCQsYKlbT6inHCVv5Y
         5w77dUe0EXh0BPh+fhCYJICb+A8lglicskM+beDNJ2M2rJmxAr9eLibTjsK69TUnyXHa
         n2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708135170; x=1708739970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PAMlmLAybt9MRMvSYk0N/52EdJBRFXN15t/MhGhkKc=;
        b=xERUs2tQBl2W0Oe0Oya9bOD8mB6enp0qTl+hizDz4JMxWZ8+jlCZ96AoQV3mRiYdGd
         f/P3PlhbhLvW6AU2rTJc8sdUFu5iO2a0X3xVDo1ytx04uJP1Ig71IVnLlchAehBfMRLV
         1A8sjSAJUfZixg6ZNEAM/6JDuP3xwlVfFpk2GCZrDblLhJNHPvrZFhbEKzr8ZO2plY1V
         TZUtFUWy1Tsl+5TUYJvNke5lpnn2zQuuAq5EjAmGm61Yb8M/aHnI/NbrA7zKSCj1/CuT
         cdw3GTwVBvjrkw2T2DE69FycLTcal1mBR59U3g2QwBqWSOoPYZ/tVE79vEGCn9WXF6AI
         RD7g==
X-Forwarded-Encrypted: i=1; AJvYcCWWwkoOxBhUMd1YQlZdpN9Smb/Fx6ZY3eqa4FeU/vnI+7qa12W9J3gnGT5W92tlaTDUuaOsQmqNOE2khxDZuzx+7LnT
X-Gm-Message-State: AOJu0YyWxg3VOkTeo6zvDR1dWb5jwn5MMFFpWPH55tFY4TmPg20eCNVH
	c4NSkR31fpTufHzEaBB50m++ouYTO4dlG/vFFgEph1MxbweY5bnswumU3OBFdG601NnIwITNSxN
	CBg==
X-Google-Smtp-Source: AGHT+IG7fAtz5tFUpEza9Xh9jvveBZZK4JZOOZ+YluKJ7QX3v/+MAEtyx6DILUDPEtQtEsg4ImgoK4T9TzY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:e888:0:b0:5fb:5605:494a with SMTP id
 r130-20020a0de888000000b005fb5605494amr1036863ywe.7.1708135170726; Fri, 16
 Feb 2024 17:59:30 -0800 (PST)
Date: Fri, 16 Feb 2024 17:59:29 -0800
In-Reply-To: <87le7lkoai.fsf@gmail.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-2-ebiederm@gmail.com> <owlya5o4dbj1.fsf@fine.c.googlers.com>
 <8734tumekr.fsf@gmail.froward.int.ebiederm.org> <owly1q9d9sau.fsf@fine.c.googlers.com>
 <87le7lkoai.fsf@gmail.froward.int.ebiederm.org>
Message-ID: <owly8r3j97ge.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple
 kinds of oids
From: Linus Arver <linusa@google.com>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>
>> I would still prefer the "early return for errors" style even in this
>> case. This is because I much prefer to have the question "how can things
>> go wrong?" answered first, and dealt with, such that as I read
>> top-to-bottom I am left with less things I have to consider to
>> understand the "happy path". WRT emphasizing the "algos equal each
>> other" concern, a simple comment like
>
> void_hashcmp is a function that reports how two elements are ordered.
> There is no error handling.
>
> There are in fact two cases that need to be handled with oid_array being
> able to contain more then one kind of hash at a time.
>
> The two entries are ordered by oidcmp.
> The two entries are ordered by hash algorithm.
>
> The order that is maintained is first everything is ordered by hash
> algorithm, then for entries of identical hash algorithm they are ordered
> by oidcmp.
>
> So I don't think the concept of early return for errors can ever apply
> to any version of void_hashcmp.

Ah, yes. It appears that I simply read the code wrong. Thank you for the
clarification, and I agree with your analysis and preferred style.

Sorry for the noise.
