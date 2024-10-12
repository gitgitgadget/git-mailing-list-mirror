Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209AD528
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698717; cv=none; b=WNdzUgIJhU+aRryT+JDYXDk/wM/1BXOqfxeETqUPTV1HxgG3ucE5liW8ldQ4p5g6OFefaJyR3uRmJXSwkyVkeVyZTel5cjCd5xYfiYcb1lRrMZ5JqOdRpeLTEUXLjg64VpxlK3bo9JPxXZoN0uSA2JrlTboN5kRQvOvBfTfB77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698717; c=relaxed/simple;
	bh=5KmYshAjadRKH8Q2lzHK/06Rq8X6MPQSxeWWzqM7Y0g=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Qt9YFEQ+95iKFcaQIujjVH8+Mf8wySaziuY8yhea7rxkmQ9r4XQy3Dw41uPJwL2dR6T+ZnVozXSNxEq72Wg4PNTnjT8ALVbk3SjdJUwPNDzY2vwrFbYJX/A3Gl+mrDc14Z0fcg1R541DLZovyuGBUVay7vVYzyfBtmKXpJFhWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bzs6Kd1E; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bzs6Kd1E"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso51113387b3.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 19:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728698715; x=1729303515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5KmYshAjadRKH8Q2lzHK/06Rq8X6MPQSxeWWzqM7Y0g=;
        b=Bzs6Kd1EASluq3m1G9qxDt/wi2h9hurEVegYpAEwkrkQTy9DaeLMtFbDCmWjxua5si
         XiKMjv4BHxVCH9Ippo5rAXfXGLynqUAiR3niT7LZbw4YFd0nHO/IhbitfTOaBSKTVCT3
         qgs7xWR7uwz9+RbeKawHjbja9CQSjYg/9hz1eAVIMebuzzlpbUzvtZXT/qQjABaS4KEs
         b4gfc+8iueHX8scbGy3FuAES8VWIGq6jiQgqmgwnPaitbKtf4y7R/3Or/7haosWhxz5R
         0/+l+QCgSBL3F6vcqiAeObERVbvikNwARXE7CDlJIR5+IP3mxFpGt275sJpIQ948ihIV
         QPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728698715; x=1729303515;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KmYshAjadRKH8Q2lzHK/06Rq8X6MPQSxeWWzqM7Y0g=;
        b=ZL/5Uo0jPIM1i9qkxbd2ROyoVTXxLFiZNCIIJNmC6a5F0hR9aFk4sX8v0T2yUZP61G
         kfvTd/kdiDrUIWjNQq7Cvh3BvmXWYLGx/lq3pnnWkrvLJbebbVt8cZiJL1553J0+l6jg
         4rXktK7dqkFGUEvEv8gxLRbNeet4C7LcfULBHZUfyArS74rypoOe7VQE12WsIOkj15L5
         tT4KoGN738CX43rzo6HeAVsgTyJ5SX7Tqgml6QnDsHd0rboxKi7AkQSQm4EP3k30buKn
         x2cAbTjbvtqixLAYq+41P9QMiBhMdv2yN2Q+8l+MpHd9SOe4AIWHOuifturiVO1EHIe3
         N1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXyU2uF/QzftudO+OL/sDvWAoqizDltaGSKTYMUUYIKIC4fzsBuA8fgVwSW2NtmzyikWDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYcErwWKD0j9ri4va5F7Y9V5DKozhJY531eq70Ed+ZGELjFWC
	CHvctLBXvWgM9zla+cH1Pekf90AxSy+WK/VksSAvR9TuCm7+OAU0apctiN2qJL/Ibj+mAdQOMYm
	TPaU/etxk8wIbIOQEySs02qnkgzcfog==
X-Google-Smtp-Source: AGHT+IEnk3LFm2vP5SJpSsWIyI3+/p9QJ/7uxVVlQjVyNE6Z+/DBPb1ibN5wuKCsylbEXsMzRudGI4LM+3jDEnUGBAA8
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:142d:eae7:a14b:a39c])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:318c:b0:6e3:f12:1ad3 with
 SMTP id 00721157ae682-6e347c75f04mr684547b3.6.1728698714757; Fri, 11 Oct 2024
 19:05:14 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:05:12 -0700
In-Reply-To: <20241009183455.164222-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012020512.217383-1-jonathantanmy@google.com>
Subject: Re: [External] Re: Missing Promisor Objects in Partial Repo Design Doc
From: Jonathan Tan <jonathantanmy@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Han Young <hanyang.tony@bytedance.com>, Calvin Wan <calvinwan@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"

Jonathan Tan <jonathantanmy@google.com> writes:
> For
> this reason, I think the repack-on-fetch solution is the most promising
> one so far.

I had time to take a closer look at this solution. One problem that
I've noticed is that the "best effort" promisor object check cannot
naively replace is_promisor_object(), because a lot of the time (e.g.
in revision.c's get_reference()) is_promisor_object() is used when an
object is missing to check whether we need to error out or not. Our
"best effort" promisor object check cannot replace this because it needs
us to have looked up the object in the first place to check whether it's
loose or packed (and if packed, which packfile it's in), so it can't
work with an object that's missing.

So I think we'll need to use do_not_die_on_missing_objects. It does have
the weakness that if the object is not supposed to be missing, we don't
inform the user, but perhaps this is OK here because we know that all
objects we encounter on this object walk are promisor objects, so if
it's missing, it's OK.

In addition to do_not_die_on_missing_objects, we'll also need the actual
code that stops iteration through objects that pass our "best effort"
promisor object check. Probably the best place is in get_revision_1()
after the NULL check, but I haven't fully thought through what happens
if this option is used when some commits are UNINTERESTING. (For the
repack-on-fetch, no commits are UNINTERESTING, but it's probably best
to make sure our feature is as useful in as many cases as possible,
especially since we're going to further complicate revision walking
code, which is complicated enough.
