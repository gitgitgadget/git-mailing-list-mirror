Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D5231C8A
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928328; cv=none; b=T8zMCi0aTczoZZR1/vabf/jlvaSTYv81T2BNLdb3AlH0wE467/Kga9HcEfOPCBBZenB0oK92Sk1Tq3fA05mPHJYl7qxj5mOdcn9ZVE1CIANIusil3wEQhV724PZO5kAOnEqRBivpA0CGh42f+Rhgq015KLak71gp7ucZQP2D4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928328; c=relaxed/simple;
	bh=FXovKHXvZ0sy+9sSO8uWLZ8O/5fFZWny03OeU6/GKEI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=YwcZZFY9MuZMV0kjee4hOixSxJm1Puoj/KJHQ3a3113Xiop3+QtYzH9M1Bs5l9O7d41MsFWBMBSzH5QSwzTokWB1pivKEQ7W4au8vFDFiXNvJFkt1RukM/SNbRulQcyyQ8WU0SYAD4cpP0pSFwHj69gx2EVpnrZ11p1TkscNDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gu7qy8n/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gu7qy8n/"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2e5e376fcso87014517b3.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728928326; x=1729533126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXovKHXvZ0sy+9sSO8uWLZ8O/5fFZWny03OeU6/GKEI=;
        b=gu7qy8n/OIl1NcjAXivOcMQVMKNQpX/hSgyWOFxgMALZ9sTfqedsEMGvCv6y++pzn9
         cAlzLk6+9WAJdlzQJPmzS63A1Y1zeweeC1smpp6n56ytvbma4W23xTgPExgrGx2n934Y
         306jDQ63zTenxbDXAhRsnaqLV/FSUzsUD2FNW+qKH3K2H8at8lFZPYRVAR3ZZrEZTC8b
         UOEtNTqvUOBVA/vj3lU7DPa0yEaD8HV1DacLUPMDZlGnhKaj9Oq5MpFVV7r0rXEUwozq
         qAEeSODuJs6kK6mTFdss1OF7WtbMT6+3iutyE5ksdmquU9aYhqUWkFWUsJCvD8ptEzft
         mT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928326; x=1729533126;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXovKHXvZ0sy+9sSO8uWLZ8O/5fFZWny03OeU6/GKEI=;
        b=L8/Zrr16hNFa/nEixhX5yX8JofZZL7ThFx6NOYmcysUGxrY8ZTLkvBgu1u7Yjj6nPa
         xESVwLLXgJ9LwvBxIAMag9SyzsxKepkHlzK6jaVjMhPe5K9q4OTzXzH6GdXxAiNHUxlC
         GpcKYpLdq1v73hRNCkM8OwJOmSXGICJeey+QRJ/tFQHaOsQdtWd4PArCW4A5PW6REezW
         9quP3Aar/kNY4DRkt3SdGPHAP+epI/pZJs0B5tuOWvgnm7vGkakgHUGM/LFxya3W3+u6
         0t+nPBRIY5ep07oeO2SMvLILCgOPKREjvugfG1YnqZpMNqoRDkTsjzBj3a1MmQhf5uZw
         1obw==
X-Forwarded-Encrypted: i=1; AJvYcCWgrQzLq0JaL3MkLWzrupUs+B7bwJlVWsWgcl6VkDEu0JqNVq4QXfCS1TGMsz8MlRnWM0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmKNv4Uk3oShFE3HtxPv4GbGshAto9+rjX2eU1XzTE/SUG6Zh
	NzSNwzefOzXOfmGjCwHjWVpRwGdVmlbtVO/FNEzPjD4CECokfimNyG5gFfVdb8IK4GMk57n1klB
	dyuUT2fFGzYHA3PT61KW9nagMGXZi+g==
X-Google-Smtp-Source: AGHT+IGhnPw4lEHYKd39RipK5Sl944uuyn8b1c737xnXU15reNgVKQ9Y6Mjk9moAhEVeXRoZSgCXZUNUhVG2zNEUcogO
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a67b:e464:3f29:ea51])
 (user=jonathantanmy job=sendgmr) by 2002:a25:aa68:0:b0:e28:e4b2:15fc with
 SMTP id 3f1490d57ef6-e2919d638fcmr7279276.3.1728928326105; Mon, 14 Oct 2024
 10:52:06 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:52:03 -0700
In-Reply-To: <CAG1j3zFFYcwYg7b9_xGRGHAOHm+qTHY=WpngqtJCrmDznhD+HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014175203.740046-1-jonathantanmy@google.com>
Subject: Re: [External] Re: Missing Promisor Objects in Partial Repo Design Doc
From: Jonathan Tan <jonathantanmy@google.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Calvin Wan <calvinwan@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Han Young <hanyang.tony@bytedance.com> writes:
> On Sat, Oct 12, 2024 at 10:05=E2=80=AFAM Jonathan Tan <jonathantanmy@goog=
le.com> wrote:
> > So I think we'll need to use do_not_die_on_missing_objects. It does hav=
e
> > the weakness that if the object is not supposed to be missing, we don't
> > inform the user, but perhaps this is OK here because we know that all
> > objects we encounter on this object walk are promisor objects, so if
> > it's missing, it's OK.
>=20
> And I think users would prefer the git command to succeed if possible,
> rather than die on the first (noncritical) error. Maybe show a warning
> and swallow the error?

Just to be clear, this is not an error condition so we shouldn't show an
error or warning. Whenever we repack non-promisor objects in a partial
clone we will almost always encounter missing objects. In the gc repack,
this is mitigated by --exclude-promisor-objects, which checks the
promisor object set whenever a missing object is encountered; it does
not show an error if the missing object is in that set.

My proposal is to use do_not_die_on_missing_objects instead, which
always tolerates missing objects (without showing any error or warning).
This is probably not safe enough for the gc repack, but should be OK
for the fetch repack, since we are only repacking ancestors of known
promisor objects (so we can deduce that the missing objects are promisor
objects).

> > In addition to do_not_die_on_missing_objects, we'll also need the actua=
l
> > code that stops iteration through objects that pass our "best effort"
> > promisor object check. Probably the best place is in get_revision_1()
> > after the NULL check
>=20
> get_revision_1() only does commit limiting though. Some callers of rev-li=
st
> also do tree walking on commits,

Ah, yes, you're right. The repack on fetch is one such caller (that will
need tree walking).

> in a (corrupted) partial repo, tree could
> also be missing. There isn't a central place we can stop tree walking,
> callers using this feature would have to implement "tree walking early
> termination" themself.

The repo could have been cloned with a tree filter (e.g.
"--filter=3Dtree:0") too, in which case trees would be missing even if the
repo is not corrupted. But even in a non-corrupted --filter=3Dblob:none
partial clone, we still don't want to iterate through promisor trees, so
that we don't repack them unnecessarily. So yes, get_revision_1() is not
the only place that needs to be changed.

I think that there is a central place to stop tree walking - in
list-objects.c.


