Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7F153BF8
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736016956; cv=none; b=KRYWk6ay28O9WeeaVXmxN6s8oT8jiLKl2+aMgC5A9FcbXRsMUH07k4GXbozRzfHFfa+yZ+TiWJfVShGuT56h7aGpwRK0iabHdnnifJnhu4e1yEcQ9TIcl0LcouXcjUxDeOEYf/sVlQsMPeI9pQ+VAjLZFv0p17iFiuzZYzyMzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736016956; c=relaxed/simple;
	bh=URM/m6YtSZszFAekZfcZC0D2ZJCQcjDlrxMiVo22GAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mg9Py+80uXoBGykRakdcY69JeFfF0Stmbnohvi7TaiHPwZF2Br1u5mbN72nEApSicoQjCKwVYuUZISddDC1wpjWfY9CR07fTR/D+Cy+dqAzrNmKdqSd71t0Iena9yqAGli4phE8LH4S6GZW583kWGjukHKVNtrkoz9CAeJEfx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFw+WpKa; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFw+WpKa"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844e9b7e50dso1211743239f.3
        for <git@vger.kernel.org>; Sat, 04 Jan 2025 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736016954; x=1736621754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVoiDMWSr9oYs5bLr7L9scVH63qNaezLTagWqCaTQNA=;
        b=aFw+WpKaWBEaHGzYQqWge55TxKHVCX9vyCsiFLdh8Rg/wDV1KIzmiuV5xhq4YRtxyu
         EekFd86VfktHkRITzhChlWtSHSQ9HEbLMbJJGeyATN83CcPSTXgGdnpvDToMP2N+jj8j
         qfScgj4VdGG4NEzdkubgqWqJi+KECM5VNWrMYKjDugoWIAk10FRP3YqhjXlvycXAg29S
         3cL0NeBO465Fpo67n3A9JnBKw5CB2x8WDC31bFFsDTJUApKYjGQbx6gphExA9KUpRdoM
         ZIQlfrtealQ0g2A/cdLIFtZfDsGvOip7Fu4A2kLORuc6UKeVlk/ioyDojsOfVaCvlRv9
         1Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736016954; x=1736621754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVoiDMWSr9oYs5bLr7L9scVH63qNaezLTagWqCaTQNA=;
        b=da4oMzC3Uu6fyD+TJ9Ph41gcz3bfj/xTYlhve7JZD+GWGc+tYLFuEROoPdIcyK6t7z
         DsiB08JhcV8KukovTAxXFnmApE2FL19hC8o4hj+a6+iIG/9itzMlhPZQdCvarOg+mo+W
         hApu4NvfaAzi1qJaSRL+Xk3MOXMe507XTxqhUo3sMH3EXoXHOBKQeJPbGOKwj0zHI93I
         jXf3KQHsukrDfXCj1Lqauo0d3oLssU1ElTSgUX5ckGMxdqzIqnYp6UXoUdOzLHFO0WWq
         MFiHcZ4X+PvaSRDPxQeEmsPTaYAXUQgd3m9FcNo+imW+MpLpPjI1B3ORIXTCkvq6GNMm
         9YCg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ehWDv/jo5/yuNxJsxjIpcSbxnoxeDX5uwPNZ0aoBQxxtXjRofE/U7+J9iX6YrZAA1og=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAM3bxoq0pSkzhdrB3WtPTiTmwaxo7EgxRaP8OLTK3e3lLPdbR
	fBus2PVAJ/rzQRJkCULiHrN7PiOcA44cmahfdDNmPo2/uI/dbmQx/vVal+c6ORgvfcyur/1co+c
	j5GnmImmBeGDGZDCoww1jQ9HBM4c=
X-Gm-Gg: ASbGncs2PO3o9M1b81Xq2bFoknG7Q3EcbXgXWxYprd1bGGsbktfi0BhlwGSgAyMW4Oy
	koayz8Lgj466uX5ZJWkQ7genaGz1OWTYdVvEJFbfKUFOQcbl+sxsd5tu/2A9xM99NDLZmnV0=
X-Google-Smtp-Source: AGHT+IG4q3ZAoeSbnC8ahR6BjiBl++qQFTSXLIIEDyBHiEVkfCPgCUmj4uNCvvxlyyixvMRwBgPx0jr5jm7K828dDVs=
X-Received: by 2002:a05:6602:6b86:b0:83b:5221:2a87 with SMTP id
 ca18e2360f4ac-8499e4f30d2mr5510461339f.3.1736016953816; Sat, 04 Jan 2025
 10:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
 <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com> <xmqqed1i4pga.fsf@gitster.g>
 <CABPp-BEzKyXY7YZOzedwQzAFqLiE_9oWsD=GByiDhi7go2aXNw@mail.gmail.com> <xmqqy0zq31s3.fsf@gitster.g>
In-Reply-To: <xmqqy0zq31s3.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 4 Jan 2025 10:55:42 -0800
Message-ID: <CABPp-BF5Sw=DY3rahmoS8NXg3GZX+nAKC0v0Y49vgq1i38DR3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] object-name: fix resolution of object names
 containing curly braces
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 9:51=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> In general what would we do if a string can be interpreted in
> >> multiple ways in _different_ parts of the object-name codepaths.  We
> >> all know that "affed" would trigger the "ambiguous object name"
> >> error if there are more than one object whose object name begins
> >> with "affed", but if "${garbage}-gaffed" can be interpreted as the
> >> name of an object whose object name begins with "affed" and also can
> >> be interpreted as the name of another object that sits at a path
> >> that ends with "-gaffed" in some tree object, regardless of how the
> >> leading part "${garbage}" looks like, it would be desirable if we
> >> declared such a string as "ambiguous" the same way.
> >
> > How would that be desirable?
>
> In "a:b/c-0-gabcde", *if* "a:b/c-0" *were* a valid way to spell a
> valid refname, then the whole thing is an ambiguous object name,
> i.e. it could be "something reachable from object 'a:b/c' whose
> object name begins with abcde", or it could be "object at the path
> b/c-0-gabcde in a tree-ish a", and in such a case our code should be
> set up to allow us to give a "that's ambiguous" error, instead of
> yielding the first possible interpretation (i.e. if we happen to
> have checked the describe name first and "$garbage-0-gabcde", we
> yield "abcde" before even checking if $garbage part gives a possible
> leading part of a tree-ish; but if a future refactoring of the code
> flips the order of checking, we may end up yielding 'an object at a
> path, which ends with -0-gabcde, sitting in a tree-ish', without
> checking if that could be a valid describe name).
>
> Of course we should make sure that the syntax cannot be ambiguous
> when we introduce a new syntax to represent a new feature ;-)
>
> Now, I think ":" has always been a byte that is invalid as a part of
> any refname, so "${garbage}-gabcde" with a colon in ${garbage}
> cannot be a describe name.  So in the above about "a:b/c-0" is an
> impossible example, but I was wondering more about the general
> principle we should follow.

Are you only interested in the general principle for the "possible
examples"?  What about the general principle for the "impossible
examples"?  Things like "master:path/to/who-gabbed" are unambiguously
a reference to a path within a revision that cannot be spelled any
alternate way, but the code currently gives the user a commit instead.
What's the right way to fix these "impossible examples"?  I've given
three proposals and implemented the first of them:
  - ${POSSIBLY_VALID_REFNAME}-${INTEGER}-g${HASH}
  - ${POSSIBLY_VALID_REFNAME}-g${HASH}
  - ${ANYTHING_WITHOUT_A_COLON}-g${HASH}

You said you don't like the first two because check_refname() rules
might change, and not commented on the third.

Also, as far as I can tell, the set of "possible examples" you are
focusing on is currently the empty set.  A change of syntax might in
the future expand that to a non-empty-set, and then bring us backward
compatibility headaches because we have been allowing
"${garbage}-g${hash}" to mean a reference to ${hash} and we'd then
have to deal with it becoming ambiguous (and potentially also having
no way to disambiguate those cases, similar to how if colon is allowed
in garbage then we have no way to disambiguate paths).  If we want to
allow future object naming extensions, it seems like we should lock
down and rule out as many existing forms of known ${garbage} as we
can, but that'd push us towards the
${POSSIBLY_VALID_REFNAME}-${INTEGER}-g${HASH} solution I implemented
that you don't seem to like.  Is there a middle ground that you do
like?
