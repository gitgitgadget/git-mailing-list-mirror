Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEA27F73A
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670467; cv=none; b=NoXBH8AndOqmnMxt9nY5krTw3Ddb2p5oIDTPzymPEyuFZdzayYwD7bjPapL9D+eA8VbVHqhBGEkycufrkPbNi2lFuzlhTSv03RK5MVh05QwY6zPniP8gmoUJutOguOxvOBgy6Hnh8YREy1l+iur5VCJ3AUygTLevfT9Wi9cQDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670467; c=relaxed/simple;
	bh=oncy1qMF5ZtSHd8oQQNs/gq+n8TSXk+BBJsuUN033r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAdunO/t/Qys4Q/QKl3VAgKB+I0dretePg/qGKlGOvaXeWAaQBQl+WglgZ6pyZ859h8/7CpQHXs+sBK3EN0hKJidU1KzXDca+2oEtk+zdfk6eFvAQHegzBZx1YXzWzFF3jnPZHMfzPumSEGqMCJgXsPJz12XuZzt21z/bBQb16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1vSCyn7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1vSCyn7"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3612c38b902so56672941fa.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758670463; x=1759275263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oncy1qMF5ZtSHd8oQQNs/gq+n8TSXk+BBJsuUN033r0=;
        b=e1vSCyn77SAuxYLaDuz01q3Wcdmuy1cE7nQYg+l8bzwKjGxgtOrZtJgbzs0IIUZhJA
         CREfZZZgbbD2ql+eH0eE/ERg0z4O+smqLZBlToMsU/gjQkuBpK3XMrX0+4EaXCbKE5Zl
         YWXCXAcmvs6yYyOVNrkkJCvwu1Q7m0XzCRwj1EQXAbJP4zDyIWRC2g2sHNwsCrEXZHT2
         qjoEew78+sRag6zuBCrqf+WNvSQ+O1K9+ybKlvMSQ4C5kP6LAvqm9gDiIjPg8QlxtRW2
         E5b+17xAd2rfYAX6k6fyrDilOCMeh338W49GgwAURshh4zg+w2+dK87WPbjEpZtwT530
         PFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758670463; x=1759275263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oncy1qMF5ZtSHd8oQQNs/gq+n8TSXk+BBJsuUN033r0=;
        b=G54p610gSh/oi6FMtPZhriUCFUu8us1b1k4OO48UdsajKEUQEdu4VB2cqky+H8+ODM
         WDHH/d1Aql1SMoYmOWIkqy8dQhtCvCI/wnLs5f0TIhnV1lOIZQhEpUyf1EMmCYJxUuwN
         c848cePGWLLX5ig8cKLOBb/fu5cJqIFcITNud1u35sg4dk2jqtqZyiOIMaPL7wz1+3Xt
         XvEjwanryET0z6pjRWAd5v6cN89X0zIV05rZSBHUFF4FulmbY7pnG4cCCKmuASXXQM0Z
         UIxUGjU0DSr/YzN6RQIzGnsSWjx37dc9nkO3ncu28+phuE0PbhSwD6Kdb9GKjF9yyoz4
         MYkw==
X-Forwarded-Encrypted: i=1; AJvYcCVH1dEMhWdhLaDMWz1ZQbJJrh8UbZVd+oTo+WPdS5d9ybozfhckDdJq0wTzYmYojOXTZgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sRe9VM98FL93czz52W3vvLswuBMlBtnOk15H0Y+UjCal6Fds
	CQBkbcYTiDpj3r+AGT5HVJnTlxF5Y9SNytMatKzdcoUZ+cn/cOha9ohN+Dzpfr2ibNZCqoj4bJu
	XfZXikrNnRyVIJb+Op+8B6ScY5V9qognSDDE8
X-Gm-Gg: ASbGncv5J9K5/0CXOYB4XgSR+DzP2gcJgATMznnN8zUHhVCE50WOMlpWtW0DrmMNOGL
	3VzyAzQrB2R6wjU5B9Oi5xJnoHsW+YNf8z5bDFWhNw5bpG7Yrc5SZLR/bhT/hyKgHS+EirHuojE
	iRRcAW/1HRS5msgB5NZcOsORsogRCvfNvFdLng00GZ7dbhpWA4I+OqGJueLMbVvfzqAnS/DhFZG
	HOf1A==
X-Google-Smtp-Source: AGHT+IH42ekjeBVhB4rFX+3tXmkEqcdDg076aHjRaBi8TmDK2KXWUPVMNlCH+lZEXsVCWgXJi0fmcEFSlH6zIN+uaj4=
X-Received: by 2002:a05:651c:1990:b0:36d:1f0e:1c02 with SMTP id
 38308e7fff4ca-36d1f0e24d9mr12345521fa.39.1758670463115; Tue, 23 Sep 2025
 16:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
 <aMnhSm5QSdRwiJds@fruit.crustytoothpaste.net> <CACEPZDU2Bu2c9RFBwD499-UUNyQGuRRXNbMx0aBrqwGoc=4EhQ@mail.gmail.com>
 <aMyGHriNpmekoqD5@fruit.crustytoothpaste.net> <CACEPZDWgoa18LAhzOzu__jy8ssgR8-PmZb6gmDzCS=q6f25=wA@mail.gmail.com>
 <CABPp-BEU-DzNtyeC0j9OKJhqnmOw18TXvCwmmPjZL33Hp=gSUQ@mail.gmail.com> <CACEPZDUYKhRBB9Te+dn8fdgDtuo_gHdmxqGBMvp+xG+GEiYc3g@mail.gmail.com>
In-Reply-To: <CACEPZDUYKhRBB9Te+dn8fdgDtuo_gHdmxqGBMvp+xG+GEiYc3g@mail.gmail.com>
From: Antonio Mennillo <antoniomennillo87@gmail.com>
Date: Wed, 24 Sep 2025 01:33:46 +0200
X-Gm-Features: AS18NWALtJscWGghEGu0jR_jkQwnvI5vIi2Vn4rKMdMMZjzb_H-fnE87fyjPL6o
Message-ID: <CACEPZDUah8CqnMpXRNB_djp7_fWZe56XRXVF-swtk-R=XpMJOQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC=5D_git=2Drebase=2Dclean=3A_mitigating_a_=E2=80=9Csemantic?=
	=?UTF-8?Q?_conflict_cascade=E2=80=9D_during_rebase?=
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Brian, Elijah,

I need to acknowledge that my initial reasoning around this tool
developed quite rapidly, driven both by enthusiasm for sharing results
and by pressure from growing interest in my work network. Now, with
more time to reflect, I can analyze your comments more rationally
seeing all the implications.

The "semantic conflict" example should be considered only as a
limiting use case I've seen in emergency situations. It was not
intended as the definition of the tool, but my fault I set it up in
the object of the mailing list. The actual purpose is to consolidate
rebase conflicts into a single step (one-pass conflict resolution) via
squash, ideally reducing the cardinality from N to 1.
For instance, rebasing a 20-commit feature branch with 5 conflict
points currently requires 5 separate git rebase --continue cycles.
This tool consolidates those into a single resolution step, then aims
to reconstruct the commits. On large codebases, such as multi-modular
Java projects, managing a rebase in an IDE becomes significantly more
manageable with one consolidated conflict rather than dozens, reducing
both cognitive load and the chance of errors.

I fully understand and respect the importance of atomic commits. To be
explicit, this tool:

- does not make non-atomic commits atomic
- does not guarantee bisectability
- does not replace developer discipline

It only reduces the number of conflict resolution iterations. Poor
commit atomicity will still widely affect the number of conflicting
files. The "temporal flattening" I mentioned earlier refers simply to
this consolidation.

From a technical standpoint, I am developing a different approach that
properly addresses the concerns you raised. This new implementation
works directly with Git's internal structures to ensure deterministic
behavior, specifically handling revert detection, intermediate-only
conflicts, non-content conflicts, and attribution at appropriate
granularity levels.

I'm targeting this weekend for a working implementation with
integration test coverage.

The goal remains pragmatic: helping developers handle complex rebases
more efficiently when dealing with real-world constraints. The
consequence of a bad commit atomicity will still be there to be solved
by a strict commit discipline.

What becomes easier is avoiding redundant conflict resolution cycles,
while the consequences of poor commit atomicity remain unchanged as
the Git philosophy rightly points out.

Best regards,
Antonio
