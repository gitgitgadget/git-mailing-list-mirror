Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0231D69E
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232328; cv=none; b=qtk1GrHQHXGhgUxeXKZx3QKdfn/U3lrYQb89htqiZh4D55k5jeV93AE8YEiS2jK7u/Fi1/5HM0J3exZP0U7KW6PgZZdplvOZQnaUpAkSQ0TU1tqgrc6CRDEK5D1MJCuhNbrEvTcBrlPcLnmjq5odnfSqEcO1x5+GDEobrUg4zPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232328; c=relaxed/simple;
	bh=ZJBafaOAbcs3YQ0fz3Y6esMxDohjqCiaxvc8U74h5Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mId6rjPHnGPnSIIkMQfqdtCy82oUUQ2e/G3gVq5+1WJWVKQYkDCtJwjKxFU5hs4DR1cHk2BzwDJetQ1dytOjXtq/6OEMwzeOZHhG5wR9AYzc/QWlU3x9ZPL0A4Cm/Cp8U9qY+gEhLGOToeBiaKmErCH5HpGDCXGVCloG3jgFDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttx2Jjjn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttx2Jjjn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc47abc040so7185295ad.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721232326; x=1721837126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDhC1KASRnZ7GWzCMWMIJNl+UB3BlXipOLLDAmzTJiI=;
        b=Ttx2Jjjn5Uo8N7L+ReO+ztAzvMpu5wCx9B1fRM75fwxUscf5vu/5nacEBxIDarMMin
         ZjckZlRlB6Lan5fDO1Cq5KDCTrBhhdyM39e1GBpJuCtXcNKviBvvenZhQ0LyY9DJuaey
         +wanCap3RKYw5tYbG+CdbUKNRKbBgkNQzMgQEnb+A43ssc1Tvz2q13PyrSxk+vsjNMct
         gH0lG/pX6+oM0oZCru0ROQX/EbPLIzMclHtvTpn2SffVzi9AlW2ZXnU1lBHd18WZlXBJ
         BA4rTO9vZ+HnDS9NXhFCaPwnDAZb1K1VbsEAHQk+G6Ru82y063jvrMkKVs1iMiTgT2v/
         KmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721232326; x=1721837126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDhC1KASRnZ7GWzCMWMIJNl+UB3BlXipOLLDAmzTJiI=;
        b=UZlF/mcBilYAxL0w5iHGWDajY6pIugpdp3avunHijxowNZC2h10sg073aY+JNQ4IAY
         ZxzMlyFjCDwOKqzPYJfB/CcfErN+MmCoIEOmVTC2ebcWp9Pp6CZoMj7GlZBvOUkbHQyy
         PFdTXAgYWmDoEMA/HXBlqkfXOk2efDzolcBMeORgUPS5KHBPmiJpT8mbwnmg1ONkbqhq
         OJDXDVWwlfBbo8Rha2Xemn98PGliLFnWwR5rZmzOHzVJjmQ2S8PMM12+o3O/KL8zIvsy
         PrztAM1bYdOF4LgAK2KVkk0+xXzrHFMfvPr3m6cxVjQhB7sANgVZAo+Qcg7Z8cLFI/hl
         /2xA==
X-Gm-Message-State: AOJu0Yyi73WfPjdyg3flFaz0PwAkP8BROegC5z4oVC07NBG3p9/entDg
	E79ScHKW6aZVhqAMAs3c8ckZCLgTnwv9153o/LpOro8GE7M0PX9iKvnGcFxEqZg+rCMCOuSKb4k
	7CSGSuCNIj7WyqsIdYHDEcWCoHqUKJaPK0Z8=
X-Google-Smtp-Source: AGHT+IHxPlpt8/JEo0jROyJQ2d0kZSUsKpDcBXQBdWmAAt47f6gd3m+DHtzuoHeopghkvXj8cFV99OQxq0jOGTq0GWs=
X-Received: by 2002:a17:90a:bf85:b0:2c9:815a:80cb with SMTP id
 98e67ed59e1d1-2cb527b5aeemr1583312a91.21.1721232325636; Wed, 17 Jul 2024
 09:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqikxnqzz4.fsf@gitster.g>
In-Reply-To: <xmqqikxnqzz4.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Wed, 17 Jul 2024 18:05:13 +0200
Message-ID: <CANiSa6hs1AEp1e+o0hT55DvCwPe2EUyU1EXg1E4BKCkeuEOPvw@mail.gmail.com>
Subject: Re: [PATCH] checkout: special case error messages during noop switching
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks! (This is a fix for a bug I reported internally at work.)

On Tue, Jul 2, 2024 at 10:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "git checkout" ran with no branch and no pathspec behaves like
> switching the branch to the current branch (in other words, a
> no-op, except that it gives a side-effect "here are the modified
> paths" report).  But unlike "git checkout HEAD" or "git checkout
> main" (when you are on the 'main' branch), the user is much less
> conscious that they are "switching" to the current branch.

Yes, that's exactly what happened to me. I should have used `git
restore` instead. I know that's the modern way of updating paths, so I
don't know why I didn't think of it. I just verified that `git restore
--ours <path>` works for restoring a conflicted file to my side.

> [Footnote]
>
>  * Yes, the end-users are irrational.  When they did not give
>    "--ours", they take it granted that "git checkout" gives a short
>    status, e.g..

I actually did not even know that it does that :) I'm a bit surprised
that it does, especially since `git checkout <non-HEAD>` doesn't seem
to do that. But that's off topic.
