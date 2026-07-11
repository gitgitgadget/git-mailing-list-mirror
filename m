Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4481547C0
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773097; cv=pass; b=H1HgHt/V0d6WATLqaCcCVcc/Z7p2K8wuzaRmF2yAWugs+hafTKOt0HToLHwfbw/tBVHq+sZNvz2YPCBi/2c1YSDhpxsE3RP2kexdCbf9zn9mWPnpTofDIwfR7CBL2UY88XiZcwBRXrDl6a4BVTHSJZl8Jd9xIg+QWclzMhKeZSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773097; c=relaxed/simple;
	bh=M7KcQAQLGrAx0SC4zx/uGYu4jJYlgFCAcl/jTDaYbnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjcmaJ33/2koQa/DWr/P8IqzOFLrJqhWoEqzc/se1MaJO0S3v7PDoxWkonBMHRXO/d832aXbHRDxsFcnR5IourCH8OTQ6PthqlO/Ff7pAUAAV+15GY6Lwctu2ILKpbbgWLtO7j0VPDNM4h2FFntm9JNyjy/imGmq0Sm0G839yX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXWdVR43; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXWdVR43"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso1794372a12.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 05:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783773095; cv=none;
        d=google.com; s=arc-20260327;
        b=sEaT64zXR1xtuDeqJRSImyAI3AAipq4uv+2ZdBRjxdV5KbE1iEDYclb+AWbtZ5F9/5
         HgQrxzxXuwMJDajtxzkdiH2jQ04N+ageoK4zaNK/dYCbRJyEwDu9KJtiykknTGZ2J9uO
         VBfKgplBY69jqn8nLFxzfZbAQIdMXyd33Vz/jWPr7cBewC+YVA0SbnnP2E8eyCAmN9LP
         o/t5djgCrr4OqBJ1JoabrquEJN2/z4KO8sAZm9TjHIjjLzt0oiTVAX2ymWNJszYVKqaf
         /BZsTi//I8e2lpV6FTzMyui8inyV6I+6d8KNThih54x9s7AMIg1Zy1GaNNYjEp4q3ETK
         3EVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mJWsELBq+MCNqLuFsAOH3SRYNzCMxLWfWE7dK7fTNaI=;
        fh=CcbGVoWJx0NAAQ/b+nbmhKf9fq8wt0JzGcMrOmxzDVI=;
        b=HTkUhAJ/xGWlX9K3U0RY2z04HKtwlQHOML9fRJum4pmdz7njRIupaKQO7e1YcIRDCc
         Epcz0qywSk0/nPsvc2P5q+IQ9jO/TM8iu79Iw+qjQmRs6thHso9bsGz/5MMdwcHrGCcP
         HmdwbDXCldtZGzb7U1M4jx4hdj853R4MrcM1kXm8Nv0D8fkEI1IABqmrUJQdNYEqY52B
         0dgN5RtL/RCaTbJ1fG6aY8f9xBIUMTZyidgg2Uw3wtwERpNnzY3epA7DszAWWkP5yBUP
         SMqWqV9gK9dW8mFXOxkaW63wKmMGYJSmzZOqfI4alqKq3K6qPGDLGTxz/yq/PWim7Dz2
         OsKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783773095; x=1784377895; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJWsELBq+MCNqLuFsAOH3SRYNzCMxLWfWE7dK7fTNaI=;
        b=MXWdVR43PytF2j3VIbMJ/bHInoFoXf/mfj9+O2oxpHbqjGO2LdAxA3YvXwvmQRbO3z
         SeA9egVGX4X/GkqUVNA/8hrcTOlFW+gsibqWFYEHPMPHqaNL5rNAecIDlxOIk8RDQ/NE
         C/saBjAi3K3hghbt5xlRPUxojxI2s4QGyIO8q11il86Wlz6e7c42gOehHV1pmZFbjQGc
         uA6YKjKGFyqbu8iX47Tw0NgBHesTnQBcjw8+0ZM8j/L/JNrWjQSow80KhyAFi2M/Ya6/
         AhkLLYUbhNxOl8fHrfd20GNvWidjRmiFiF09wjONu8pbDEqxAl18ONje+t63aM3o64BU
         7Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783773095; x=1784377895;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mJWsELBq+MCNqLuFsAOH3SRYNzCMxLWfWE7dK7fTNaI=;
        b=qcL5YUUfnsSuL0JJg97iojcNOn5nSJr8y9FgfHQxaIF8pkBLgEo+h86BxkBEnn6bfm
         h7v/HSkovohDMj5JirA0DFaaJcBif5xvbqsJ84VNiHj2Iq7gIbfbux/Nx73PLNKxy6MK
         4rzH7heAtz9ombhzUaoRRj4eQl7mnfR/7w+5kdwzft+0HSzc9hxApqzIk78fOEi61swm
         9FvUvq/y8rvZvwFzJemFI7crmKR/MNNpu1hlRWHDayi/kOOt+X7WoR85B/S6qyH4LIUs
         /xieXeQbmEobzkYvDTQblEZ2+e2IyshVs+FwQnC9XOVA818jIXRvDBLdioXFhKw5k8NM
         nUjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrV20qic3KRTm3CJQD1y9sUa2OioQxo0V2W+a/YKenOwEcTBM37pZL/wfmWxT6oBhXHVS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhzEfl0fBb2zpB2zByL2dYFA3ZGb6cBeOxjdAn1C2N/MN0P0TK
	DTbksixYv2Y4OowLws0s1Z/g1O0xGYMPgDu5DxhSIMqrMx4xCVOXcDEJVF+TWE36oZGlqQsuXnQ
	pAhsz5Swdj9H1fWRm+TdbyNnhUmHg+7s=
X-Gm-Gg: AfdE7cmf8H5cW+U1GXwzCMPyKVZQXbdWywDYYtOYoVWnLmw9ko1ULEQHeLquyjRcZkS
	MRLHGPQnyOR4bAcHkrLdnTAWFXPew/PZ+oURg9x33Km38MZMXA4A1ekE2WkLfP1os4ubkYYIP3q
	zRYb0gujmAr34galkgfEwaVxdKrpRXWIF6A4WQKmu9UgHsqFEAdnAobIdOiiaV/59OTVd2nuF4Z
	6RKlYNiVww/z0W1UmNlCWg6dT2IssiyAfgZ0BqIF/vZZkI8RqTV6XJlr4zxkA6ixWKLEuVB
X-Received: by 2002:a05:6402:26c6:b0:698:f7d:4e11 with SMTP id
 4fb4d7f45d1cf-69c5efb5b50mr1248646a12.1.1783773094555; Sat, 11 Jul 2026
 05:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com> <3e29ff17bd703d8333c2d65d36b15c69ddfc2ab9.1782338106.git.gitgitgadget@gmail.com>
 <8ee46e33-4eb8-4e01-800a-82cc7cefa3f9@gmail.com>
In-Reply-To: <8ee46e33-4eb8-4e01-800a-82cc7cefa3f9@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 11 Jul 2026 14:30:56 +0200
X-Gm-Features: AUfX_mzCgzJCEQKCB3W_5Cv6K7T1iPktooWOyCakh1gq29QxElra8-oDtlcJaDQ
Message-ID: <CAHwyqnXq=gk=hKUWbFHWLZFKCTPTWqHRv=tH0BC3HaetoRG5Aw@mail.gmail.com>
Subject: Re: [PATCH v18 1/7] branch: add --forked filter for --list mode
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> The implementation looks good, I've left a couple of small comments on
> the tests.

Thanks for all the help so far! Much appreciated!

> One thought I had was whether we want a mode which recurses
> so that if the upstream of topic2 is topic1 which has an upstream of
> origin/main --forked=recurse origin/main would list topic1 and topic2.
> So long as we don't think that is a sensible default we can add it in
> the future if we want.

I don't understand this one, but if we safely do it later then that
sounds good considering we will soon be on v19.

> > +             git branch local-base &&
> > +             git branch --track local-one origin/one &&
> > +             git branch --track local-two origin/two &&
> > +             git branch --track local-foreign other/foreign &&
> > +             git branch --track local-onbase local-base &&
> > +
> > +             git checkout local-one &&
> > +             test_commit --no-tag local-one-work local-one.t &&
> > +             git checkout local-foreign &&
> > +             test_commit --no-tag local-foreign-work local-foreign.t &&
> > +             git checkout --detach
>
> Why do we need a detached HEAD?

The '--delete-merged honours branch.<name>.deleteMerged=false' ' and
"branch -d still deletes a deleteMerged=false branch" ' tests need it,
but it's not necessary here, deleting.

> > +     git -C forked branch --forked "origin/*" --no-merged origin/one \
> > +             --format="%(refname:short)" >actual &&
> > +     echo local-one >expect &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success '--forked rejects unknown branch/pattern' '
> > +     test_must_fail git -C forked branch --forked nope 2>err &&
> > +     test_grep "not a valid branch or pattern" err
> > +'
> > +
> > +test_expect_success '--forked requires a value' '
> > +     test_must_fail git -C forked branch --forked 2>err &&
> > +     test_grep "requires a value" err
> > +'
>
> It is a bit odd to have these two tests in the middle of the ones that
> check the functionality works.

Good point, reordering.


Harald
