Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9030155A4D
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367967; cv=none; b=bR4XAyj+zhOTFCHczeiqhO+R2jE+iUrvP5iFWRcU0YFhIaw/xvxVvkA7Z0bHA1xhdSAcPudyJKywZIjTXK+vk/6q+NWhMOoaGEo/SGoL7DA8oe7GLrlDgbbFqq7JM1yB+cZdd4uMB2s2glZ4pgnZuK+Ng7Y/RKU7P41HR77X1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367967; c=relaxed/simple;
	bh=vt0OQHXUlDFdN3zr996sQWxoWhCwrRkcoCNjbY3FG0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=if2S8VDIALG6p7+nekxnZL0KIb0bLdhxUurH1xUBMhoUlwmoJk9+oRYWUPtR5rE1Etg5yoza1i5wSLidIwTMNMfJeZXtqfa1ZrxsPsHZWWgFwXYBmOS9ZdRswUMVJ348Pr89k8W0MJCwCDPFebvwmeMCZtlXCbckoWPfrQ8dd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp4pUktT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp4pUktT"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-27d045a73easo715728fac.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367965; x=1727972765; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vt0OQHXUlDFdN3zr996sQWxoWhCwrRkcoCNjbY3FG0c=;
        b=Dp4pUktTysDxndi4+7lM8SsnK/lldhTnWZqdIXdhq5qj+66LWqjU9LFWavGCkHJedN
         JJW3AJ+ovKOvkN/1ASMhF7X1Y5PErcoluXr9lDBhTe4QdD3RgDsWvSMo9VHyrLX+LF+9
         /ihaerlhFzD1T5dwCEIfGOEldntaWQYEKMX4llbEpNq2MBoxjKoUwrktj+HCNuPhPqCR
         jeFP9/jqZLzq1z9wZgxmsKOKPlEHLyQrhYxCvWUAFQCtyqqLEIdXmBpUF9WT+m7/FoFF
         YjKcTEEZf77TNH7yRhU5g8comg8ghW+tWfVIj+MDsIqZECpl0AhGByFNWPGKLFVp4Hzt
         W1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367965; x=1727972765;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vt0OQHXUlDFdN3zr996sQWxoWhCwrRkcoCNjbY3FG0c=;
        b=djMf05l0uOutSKiUcPdggNl5ri6Wtbh3Be3vvSdq6JSYSKPSjubxlUrR+llJmOIBaf
         dtYy2LKtxOXwkzPXQHJbdc8Xz+l7kqIyFAD1vmewTsHwBv96T6QSVzWDrVE+oisjCV6H
         mIYkCd4UmhQs6Vb7qmo1HQtMsCWatCzj84bhTubfC0Oka2RrcFcZDs6349w6iYKkdP2Y
         aDaHC0JjRCUhv4afqvJ6JfiySB4zloqZ2Jp2dG14fm5pVg5svMkOMAspCInuhZ7zbq3A
         ENa7xROaLBGCqTGc5zyVht9DH2Pv819C3Qj+yjAotCAADgqvcC9KbA4uuExwGhf+ITbL
         9mbg==
X-Forwarded-Encrypted: i=1; AJvYcCVG+A7aZruJI1RF1mH3+YVUkAMGVYPBH35IEMFMwRKIttXiOt3WWJrcgdmUqrDMzqe7ws0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOVGgT/RLHzto9ccj3TOIWLoZPhDFF0ikzqQCzVw1NIiP3Bs3
	v4wS+BBXW1U49zpz3u7mXwXzMTfS9H0zarsSgMLbM5MsY6CcHy3G
X-Google-Smtp-Source: AGHT+IE2+gWcY/vblnqrAjio2dn93Vyra5sYdHCeIQS8y+e4IS+cLuF9wYFK/3oG1sF0h0+Ww5KJbQ==
X-Received: by 2002:a05:6870:ac08:b0:270:276d:fb54 with SMTP id 586e51a60fabf-28710a9119amr464209fac.21.1727367964782;
        Thu, 26 Sep 2024 09:26:04 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2651623asm83306b3a.120.2024.09.26.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:26:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>,  Jonathan Nieder <jrnieder@gmail.com>,  Emily Shaffer
 <nasamuffin@google.com>
Subject: Re: [PATCH] BreakingChanges: early adopter option
In-Reply-To: <02d7b805-f006-43ca-906e-fe9398b8ec35@gmail.com> (Phillip Wood's
	message of "Thu, 26 Sep 2024 15:16:09 +0100")
References: <xmqq7cb77810.fsf@gitster.g> <xmqqploydn7j.fsf@gitster.g>
	<xmqqtte77f0n.fsf@gitster.g> <ZvVMNMiyjd4xfHzY@pks.im>
	<02d7b805-f006-43ca-906e-fe9398b8ec35@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 26 Sep 2024 09:26:04 -0700
Message-ID: <xmqqjzeyl6ub.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> One problem with runtime toggles are commands that go away
>> entirely. We
>> can of course hide them away in various different places and make it
>> impossible to call them. But one of the downsides is that it is not
>> "true" to the actual removal, as for example the dashed builtins may
>> still exist.
>
> We should be able to make sure those dashed builtins fail though,
> while that isn't exactly the same as the command not existing it would
> signal that the command does not work in git3.

Yes, that is what Patrick means by "we can of course hide" and what
I meant by "it is more costly for developers to do it at runtime".

> Yes, it's hard to see many people doing that, though if we're lucky
> some companies that build their own git will test the git3 build. It's
> also hard to judge how many people would turn on the config option -
> if we go with that route we could be doing (a lot?) of extra work for
> not much benefit.

That is certainly a thing worth considering.

Thanks.
