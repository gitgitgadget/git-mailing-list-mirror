Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289937A132
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237016; cv=none; b=sOfsE+MSeIHlBHOOA/tTitHf6sY+n19cIOL+0jitwCUHcuYILMZnA8gPcwHlxwVv/153ZsaSk0VI443I8SC6akmto0QJGHqG4sJ+3j9czhtUQuPgZT/orS+8dohjadSUMdk/WGTjEJyGt9OU+Zw0aifuUKpQ7Xe2YThWMsW9rCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237016; c=relaxed/simple;
	bh=6YzNOroumoV25qh0L0sNfOu7otHksf3ImToN+eIr5LM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJ1nEv65vD+O61gFRtSjfVCcRT1dSI9VZyAW3Jy+r3GnlUSEn0cB958CQCIX4tP/Jyq6JdwREOQcOLik5ILXEpMsx4dG8kbUFslhlhTZo8Xi8ztkHW3osIaYyShvMohq6NXDgc33Xa2N+81x33W+U5eR2HU1dSHNCc05AQ248kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pe38+bCI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pe38+bCI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e56f7200so13298657b3.2
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709237014; x=1709841814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nE8XPsnRkER7+eRxH5IZtqzBKCdJ88VnEN/6Swsw+iM=;
        b=pe38+bCIsQDkpF/Ty2WxGabb0Gb9rAcRuwGqk9NbH+upEZqBuBhC6OcncjBgljcLsd
         WQe4AnOUTUCDXM0FJp8tlu8m1D8GUyXLROXTcWwa9LgR8z+/fRDwABFtSXyT0IX+TeMP
         s3EHaVWhwiUUDjYdDUPdnbspsRG7hyQSQ/51aCsk5rcemQ2f0zauaTx4FHfoZhFumuKM
         2Al64ToyhrcoxxMVpmeyq10tU8IhLRFV2WjVnWNx3e/sCUVLSqknhl2L+ngTWIP4wOCC
         K1RVQRYNXttpk82zikKpBpVM9PBDm6oMD2/fTFCsJl7bUOaGJfClqT3yNFTvxjGvkPI1
         EWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709237014; x=1709841814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nE8XPsnRkER7+eRxH5IZtqzBKCdJ88VnEN/6Swsw+iM=;
        b=Cr/c7M8vsx07RsBWJbR0kVrrxi//aphqF3eC2H39N3GH0oNAZzXxZe1+DyjzHgXVGG
         rNvv2Sxbn6VssM8zNRg8EyoxFh6sc5QNQLYMjhVxk4ujK6mLXfjd+F3x/mRdNVC76Asm
         bWG5wt8fYxgykX2IO3uDEBgA6DbaCRD+ZxaTmAEcbzgO+hvEMA9EKbiGbIscakv9FUyu
         7p8YU+jM/aA/P6XgVk0WMngqaHS7MDcbwoIKS57U7NRpBNt8iiO9O5vWs2/RVE1MpT1k
         /51KlRNsIP7jIKarvII/yj9NvSONKR+pvCgniNBb6jaYPzy6O+petSd7F2Jm/B+qZ7Wa
         qINQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKLxa9tEJxI69FvRYycn/501Em3jIBQ2XjoZOzZOvwevVEfuJoCPr4vIaikDq/efnOojz9ZVdU/dmZguG9QTTLQbkb
X-Gm-Message-State: AOJu0Yxp3JrxOJOmNstGsfUdaAYLNfEKl0zp7t+/MCGt6FVRir39yWvW
	KhvnTNKWnLrQOMPnQPsYTvtEJDqdnKyS/clrPxUcN26CEIVktsJg91Apv8JJB0qH8z41NP9TzZl
	T3A==
X-Google-Smtp-Source: AGHT+IFEtn32/sP44llvN8UGSE/l3+6ZB8SqV4EzMJLMUOoX6VTHsA2xvI2mZfHcFBij8+oLxb1Sb5u72FI=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:70f:b0:dcd:b593:6503 with SMTP id
 k15-20020a056902070f00b00dcdb5936503mr161077ybt.2.1709237014101; Thu, 29 Feb
 2024 12:03:34 -0800 (PST)
Date: Thu, 29 Feb 2024 12:03:32 -0800
In-Reply-To: <xmqq8r33gkxu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-3-calvinwan@google.com> <db8b2398-c6d6-47a1-a4d4-7e4726d13312@gmail.com>
 <xmqq1q8vi3pz.fsf@gitster.g> <owly34tb5dop.fsf@fine.c.googlers.com> <xmqq8r33gkxu.fsf@gitster.g>
Message-ID: <owlyzfvj3unf.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 2/3] git-std-lib: introduce Git Standard Library
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> It does make me wonder if we should stop being lazy and do the
>> work that the linker has been doing for us "for free"
>> ourselves. IOW, stop linking against a monolithic libgit.a.
>> ... which might help us understand which things need what.
>
> [...] If a tool is
> available to help us and if there is no downside of using the tool,
> we should keep using it.

Of course, if there is no downside, we should use the tool as is.

> If you are proposing to move away from the
> current build practice because you have a concrete downside of the
> approach and avoid that, then it might be a good proposal, though.

Right. I was just wondering if the "explicit dependencies declared in
the Makefile" would provide some value WRT libification. Currently IDK
the answer to that.

> And "we do not learn otherwise" is not a downside of the approach;
> "we do not learn" comes from your not learning, the tools do not
> force you to be ignorant.  We do not propose to use more __asm__ in
> our C sources only because compilers were doing that for us "for
> free" and because the compilers were somehow robbing us the
> opportunity to learn micro-optimization techniques, do we?

True.

> A small downside I can immediately think of is possible in a
> situation where we have been throwing an object file into libgit.a
> archive that is no longer used by any final executable.  In such a
> scenario, if you change the source file that is compiled into such
> an unused object file, your next "make" will update libgit.a to
> replace the unused object file with its new version with your
> updates, and that would cause the final build product to be linked
> again with objects needed from libgit.a, but there shouldn't be any
> change because we are talking about an object that is *not* used by
> them but still is in libgit.a due to be listed on LIB_OBJS variable.

IIUC, this (theoretical) downside will result in Make thinking that it
needs to rebuild libgit.a when it actually doesn't need to (because the
updated change is for an unused object). So it could slow down the build
unnecessarily. Makes sense.

> But that is a purely theoretical downside. It may be the case that
> we haven't done our spring cleaning recently and we haven't noticed
> that a source file or two are now unused but are still listed on
> LIB_OBJS to be included in the libgit.a archive.  But even if that
> were the case, it is implausible that you are touching such an
> unused source file in the first place.

As you noted, libgit.a is not a true library; it's just a big archive of
everything and we let the linker figure out what the executables need
out of it. But I was under the impression that with Git libification, we
would want to create a real library in the fullest sense of the word ---
such that our executables also need this library ("-lgit") to be built
in the exact same way that external programs would need this same
(single) Git library. For example, I believe this is how curl is built
(it first builds libcurl, and then links against it as an internal user
for generating the "curl" executable).

Going back to libgit.a, I was just wondering if the exercise of breaking
it up into smaller pieces would have been helpful in figuring out this
"-lgit" library (or what a smaller version of it would look like).

I sense that I may be missing large pieces of context around the
git-std-lib discussions though, so I apologize if my points above are
not new and moot. Thanks.
