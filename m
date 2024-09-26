Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE114B086
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366252; cv=none; b=ZMc3RG/ckig7WvkOqgxt/4A0KRx1Y8QwIPgYiuHLE56FFk+bYtOYU0lfT8s7KDyS6hzwYP24JSYm3tjNYvnUHTBMnSa7J3AVhPaTRhc0PBOfBV8r0YzXXvOhqTlX2QWcs6Ug3mz6Kdajy49M93gbDzHb6W1StZLOEHZ2JBZLKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366252; c=relaxed/simple;
	bh=FsotBioymwZ31JhU5dqgI40nAr+KcM8WP6Fx5942z+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=itJ/yB0e3JDxORBcPMVwBJ5wsOV6W9qKyPkI6d8UQvYRBnl/lulqZ2zHRh/RJzHSD0LzkEv29ERjmcPHQdA6x4f52jpy5gGE3SXCsTj+fxXiLizDGlvtvzds1aCmG7has4mOEfKj5bi3WzfO2//DyRz3M62xwvD2LKxzOr49APM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMxaoLUi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMxaoLUi"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6ba3f93fdso680895a12.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727366250; x=1727971050; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITqZBg/xfBnezo7sWGPjThK3oRq4ZgmS7hH4DNKkJz4=;
        b=eMxaoLUiN9bxib0Q+kuySh5Xw+kkgJTYzeVTRVDvfd4JE5CZtCn3f98OH6IBpt3lPI
         f6bJEfeQhaHEyjjHc1Py0LFu4m7i51XjBC20ctQv47IXz4gV+6iTtfZJpf8sBn3VI18P
         jYS0nLKGvIhvytuixsmkGtZ4Pmtyw9gEg8m0kllMr4D4/gxZmtyb+J7/HMId5SVr/GXC
         WfdaxhIz0ZYnbXS53gpRQRmMR1y+jJAw1Vt76fZc6H7SRjbARSqGcK/CInO2nAM9yW4x
         SI+esoFAsoUNfggWN+ofcfqBhISHCuqO3xdwhz2DduZh+K7X4rZucNhNhuOJslryJbGo
         o8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366250; x=1727971050;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ITqZBg/xfBnezo7sWGPjThK3oRq4ZgmS7hH4DNKkJz4=;
        b=aJcvZX+8yQBFVTA0sKu5jc+Hy/CxEap8dgEWXi+IuamBHSFnyzMiAVJb9ytpju4nHR
         NNbChQqKJLfszVcQ+MbRfWD+vRdJh84JO/pJF96Qwlv2Km9UiX2VxeT2ZFUtCfLYieAs
         TUAP4iuSt3okhjge0yvE9CmrIOdRRyjytJ5wzQbMPo2lWa6FFp15L2TaMGY+TYn8b9/Q
         0kTM+P4A+X5jxP8DSdwJRByTBYPvdF6q0d0A4yvNbSIxfYu4s7ZbgAUSo7Rk/OF9DAFN
         CP2eyPNg43fohN/Pg2dGDGiOe6syJaWB7qaEckDTdDY63/7YUJYuXUcFvXuUkgywPyIH
         U+Uw==
X-Gm-Message-State: AOJu0YzrBa2O1ULWRnw4S4FXzzMTTVnyByDSMM4fRN7SkutVjrACh3RE
	ROMo7suwFewD4CjPcOtBxLcP8Wlypxx/4lWcmNDWcoaY65WB1Eh25zhA3Q==
X-Google-Smtp-Source: AGHT+IGWlPaLcPy4HV71uo4hPUGHHxAtblxDiBPN9UXD6cj5XDikd06ApjyoXt2EKfi5jVhOEaRz2w==
X-Received: by 2002:a05:6a21:1709:b0:1d0:3a28:d2a7 with SMTP id adf61e73a8af0-1d4fa806e8bmr217763637.41.1727366249929;
        Thu, 26 Sep 2024 08:57:29 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652bb5esm51425b3a.175.2024.09.26.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:57:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Jonathan
 Nieder <jrnieder@gmail.com>,  Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] BreakingChanges: early adopter option
In-Reply-To: <ZvVMNMiyjd4xfHzY@pks.im> (Patrick Steinhardt's message of "Thu,
	26 Sep 2024 13:57:52 +0200")
References: <xmqq7cb77810.fsf@gitster.g> <xmqqploydn7j.fsf@gitster.g>
	<xmqqtte77f0n.fsf@gitster.g> <ZvVMNMiyjd4xfHzY@pks.im>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 26 Sep 2024 08:57:28 -0700
Message-ID: <xmqqed56mmqf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> How much more costly to do at runtime is still subject to further
>> analysis, I think.  I know that it means we need to build and
>> install the docs twice to support "git -c feature.git3=on help", for
>> example, but I am not sure what the best way to use CI would be
>> (write tests that check features with different behaviour by
>> explicitly running them with "git -c feature.git3=on"?  Run the same
>> set of tests in a separate job that has "[feature] git3" in its
>> $HOME/.gitconfig?).
>
> One problem with runtime toggles are commands that go away entirely. We
> can of course hide them away in various different places and make it
> impossible to call them. But one of the downsides is that it is not
> "true" to the actual removal, as for example the dashed builtins may
> still exist.

Yes, as I said, such a change to various infrastructure that are not
specific to Git 3.0 boundary (e.g. run_builtin() dispatch needs to
tell which new commands are from the future and hide them unless
configured) is costly but reusable once written.  A new or removed
command that is not a built-in is even harder to manage at runtime.

> That makes me personally lean into the direction fo making this a build
> time knob. The big downside of course is that we'll have less exposure
> as almost nobody ever would build their Git in such a way. But the big
> upside is that we end up executing the code exactly as it would look
> like if it were removed, so the coverage we get e.g. both from Git devs
> and from our CI would be much more telling.

Sad but I tend to agree.
