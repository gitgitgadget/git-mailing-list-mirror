Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E62EC4
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017624; cv=none; b=AJFbioqwcrDNClyCqLMNGWas6BLwKF6ns9K9gpG+xu8KSzzPjgqvDjU4G2yp4J0LK8FCAlUZzXWAtPpG2aHxyrE3MvCRV+k3Vf4VuPRo5T0HEWjfBDKGOFtqPjZD9PA7pXhYmlbQ9XHddBisFX1uaTJC5DrzBxX0DQf6oh+Nsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017624; c=relaxed/simple;
	bh=HVn7mCxjR37oBGjrCg+vBXSAfaVbPNb3QWa7KAzgOEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+d2Az3rfFuF/5ZENslkTQn+v3Qky7tScrONwRgHSjzirivsg4ydbninZnQ9oQXAlELtJohkACo6tLOH0uWOU2YxMLXUw+KaRVqNn+TnR4WvrlzuOyWPbna6Q/wqwjJU7fODpp7gztJvAEMkJTIAYnoKLf2endyq9qbwii+6jsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qn9kwacP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qn9kwacP"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso6442547276.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712017622; x=1712622422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qu0MuhUmFawyprwSs37glj/+btekTXC/40QYFp7Ib7M=;
        b=qn9kwacPxeCGXqlG08SP9yKOMlgMNbUuzQALdyQRrleWJRF4rNEPjCQFcyi1FpDpAQ
         S5Om2KpDo7By2xz1e7b2hWxelBS1eRJi4acbcZh/KvHShqxNFASUPrSjn0zvxp+x7D5q
         pyb+9xAaKDHu1Icou3sBETvmm7o30WjIvLfLBYyiR1JWRgVAhbx5n9mb6x8UTFhnDd69
         IIRltryHoGhs3wwMTZW6QGKS99nfubsPRRnHPQ/wvKF+Vjb3rDfaoLoCC49Buf8R8huV
         ydj+KYzTjUOzh3ghpENoLVTVDxgNDCPMmXGE7/C/QwCHTJB5ScOhC212r/jAUwAKvglC
         dsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712017622; x=1712622422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qu0MuhUmFawyprwSs37glj/+btekTXC/40QYFp7Ib7M=;
        b=t6AssZLhujNRNbp78qg645yaCXCubfNySbKZnogskTkspsIy8ZoBOh3FaZQrWbGul3
         BE/RDbJplszaWSez+Bj6JcgKugBhK8J7F396YQgxSk4n6YQ+/+vbyODC8XIy/Ga2bpwW
         pFzOvMkq6NdeS49l/37whtQqkdGFN5ThumlCs00arrbUGd7Lb8Dx4XVEM0wPirspfn4n
         YqBqOSQn/qa9K4yUW8TnhOuHWWy09eF4hDdn8eZ7v0KQ6uzsaODRpHm5xBiPgVjhI+aE
         5aVYcTKbtrUgbwfFXrhUwLnfqj1X16eQLwDlCVNEC3Pwh77D/pTTEwQuNdWvNSpacJuQ
         3olg==
X-Forwarded-Encrypted: i=1; AJvYcCVZC3y/AInA147XCusqYgC2aLfyJJt45rOfk2MA26t3kUZS4ek3B51ELcOqlLUZZQgVElVEwLrcQLECw0IriwA/ypjw
X-Gm-Message-State: AOJu0YzDBe6vDHAVWU3TXae+R7s42XLTB6FMoLT+vanpebMinPuwOehZ
	GPa0Zmwznyopt8GU5yHECgkJ1WV4lTCGct2byKMEaQKorfabroukg5EdIWHthYYtNtrK1j79+kw
	bFQ==
X-Google-Smtp-Source: AGHT+IGE2NSRuMhTPE75/nFtLfvzzzHwqo66VUSJg2/mv3PFTL7tLsvzXK2dRdwPI9VFQMGRDK7uXSMciCM=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2302:b0:dd9:2d94:cd8a with SMTP id
 do2-20020a056902230200b00dd92d94cd8amr879438ybb.9.1712017622041; Mon, 01 Apr
 2024 17:27:02 -0700 (PDT)
Date: Mon, 01 Apr 2024 17:27:00 -0700
In-Reply-To: <xmqqplvg7j1y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com> <xmqqplvg7j1y.fsf@gitster.g>
Message-ID: <owlyjzlg623v.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Hariom Verma <hariom18599@gmail.com>, 
	"=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"


Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This series is based on the initial series [1], notably the v4 version of
>> patches 10-16 as suggested by Christian [2]. This version addresses the
>> review comments for those patches, namely the avoidance of (temporary) test
>> breakages.
>
> It has been 10 days but we haven't seen any reviews on this one.  It
> could be that it did not get to intended mailboxes due to the header
> corruption (I manually fixed in this message), but without reviews
> we cannot move forward.

Adding a couple more folks to the CC list according to the
contrib/contacts/git-contacts script. Thanks!
