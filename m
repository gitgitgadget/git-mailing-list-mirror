Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9973C3C12
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808597; cv=pass; b=as6Qzl/lKpajCZyuzY667YdLrjm6mgvIga/Gs668hsuJnuFi8eIfJdDGmOEitei08zSpAFF8RGp6uZueiFgihNMA16rgwUfOOi3QFtVbPwK7PIeq3DjntKpJHzuouHQXc5KFLBigkgWELY+nz2mR5YC9gIAKgnsBMd7zOb7irIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808597; c=relaxed/simple;
	bh=AKA2LpCb/vo2mCGYj+kMp862s5zxsn67anZjdkjAKnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiC2KUxslJQd+IOpN0Ag35AUgEPuX4ZT/8efHYQ9H6EdGecvtaUCaveQ3vE6zr+kS20U7bei4Fd9vkOzI01LHKtg+7hucdfKmDOmIpKgMJBu0AgezH8O9L5nKpvuWOgU8ue1JVCejypDYk4VDE5aPV9Ste9X/UXl1ffPcqk2iRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBmtfC03; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBmtfC03"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso540376a12.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781808595; cv=none;
        d=google.com; s=arc-20240605;
        b=k5KSXbpFaVWEaJ9EajEJrTOpuzsKrIn9kOeHfSB4I4FEpACiJu6y/OxOmfkSGUj0x+
         ZA+uqwE46HsV845jB4zLpdLWpNWAseNnDc2R4uaquCXIOnqNXW+BkBjSJL+UxT1lHhY9
         0RLzmSSXu7Q5ZaHRofCHDeR8rR8nZAiw+2TchQXwC6FvuydbdAL6mO+XfWj7mwvMvyb0
         OzmTrjor+GNc6CbDtF+EpiR0ra34ExWNzd7UnlsVjYOALC/zc5P4FiSFb2xZJ5TLlgjk
         DmkujR8wfzW5VpAfSSPmXEMtIJrtphsqBmLxMti5L6PAO2dVk394Ooa35cyTvJzhmtoY
         8F9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hzrT1bz+kis8qazBhBtDF+scLjK7jAOtwP+a67wEAns=;
        fh=DxBzptdDbLyVJmZTrposGAIUNq9/B0o2En/XtpZFBMY=;
        b=bI5EpumIzA/ndZh7vs5ikc3tK9Ssgy3vNClJ0MvvlsfUIEOVie/6pklOKzSo/Fj0Li
         oszkgasHOIqBnWsDMdzqBjHv1RuoN84O3Ej2tv/SL37kJSbsrBH120H6C0q4B9Ujb3jV
         k4+Q8Q3PisgMqVpqidZUzI7UXMIZKB7ky+kUCt6p8bWHYFpNVCDvxntRngFW7PHYRG4i
         fByLWINMDh5vpcG3WCEQRH4pFDJUJfL6HVgmqdmAWM16SfB2sEt3oVZs0ieCMvpSExne
         o8FolKbss7sXorYNDIphdD8rErRtWRlGQypdRKLKE53bx0C42BIVVXmHIVn2qC8M9uie
         g71A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781808595; x=1782413395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzrT1bz+kis8qazBhBtDF+scLjK7jAOtwP+a67wEAns=;
        b=XBmtfC03HlVFtbTEjNvvij2uAikkGlb1nW+8CJvSPw8JCcmdxbdJkMmQQtKscXbRke
         mjv4eLTHUXsHhX2hY2zgxCvWn+P5AzhCKU96IjJMa9uEoJmvTeB1GFJ+dRqAY2cKHxcl
         jrtJKIbx1JoNz4mhsVN0W2R2y0PW7l1/PkuHT5T6EVLfKkNlmOfNG4X+ZFMafNdX8NIB
         h9oYYCerFek0fI6dx4Pj++cdrASzy8r77ar9VQx3TnfJ+UVO7KDNSS3cqKgNc4Gjz2Ye
         UGOEIXmvxGH4wjEBIjXEjRouPjBqpWZu5qPcaK32MvJm1LF9JXCgzYSUq8NyizVIg66M
         lbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781808595; x=1782413395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzrT1bz+kis8qazBhBtDF+scLjK7jAOtwP+a67wEAns=;
        b=q+Hlyv4ePLj3+NoaLmu2nIubqiHYOxjNWPFTyX+mOA3I9S0ogs6qnNWS6QBxgCn0WG
         N0vuyBmxQivh6elU24s/yfVNZm8p/i1RszBXa1UyJrrpoDlh938cVW2k4To0P5oreMBY
         bAMiSRzqKLByUjCN4OCQZk07Y4voixyF24eZR3xHDzp6RidMBIInhmfoUlmJYg79mpZv
         1n2Ebrd9Qcv7KaMtl1br1fJ9JRR0yT/JOuBoTaTwktpXamSVDLjE+cq9Ex47bxwa8IIQ
         4c548Q49zAAHs3wS9Lz89XrgZ5INVoiSJBFga/nXsA4vDwaPThtSmkz9ULeG1n0PO9Rf
         QJtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pTVdu3W5fj+dIfWYqcFzjjKzhbhUWarClKXHOgcKxUW+FSQD6Xg1xgt4Bf+7NAifYyLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrDL228OZF1+e9nEra9W4FDDCpIb6WSnHZymudhsRVGXptxH0
	oFr5OhU961UNc2Q87kaOhrEZjO+ZJuM4VntNHgIMBsVIc4PqF1hVhbHTcaMenuLNf9jtAIRpRQa
	FsUClqblMvKJ/PS2dwx8xFb5pODrmlmE=
X-Gm-Gg: AfdE7cn03ooq1ylP2re1xlsnwlX/QH+5jaXtlwUdWYTlSAdHda6A34Kf5KHyiA5Uev8
	gbMvxHmvIqPxeti/rb+zCGna8Yj23l6hcUxPdPqOTJsWZac55gVxEXNwYjxBZ9VeUfYXFT/mFJM
	obe0o2hE8YSatVLhOGiv4o0VtxjtTdcytmrd/gYPKWK2IMDkZpPDD7lW5yAi+lPn2/FWE69gUA/
	jwqsh/af65hd7DDXX1yNDYMycvU5h2oUwXjw2ETzOPHwZEERZwc4N6gRLnAQsn46BbXRoGWj2aU
	jvf7Ipc=
X-Received: by 2002:a05:6402:40c7:b0:689:b30c:421a with SMTP id
 4fb4d7f45d1cf-6973aef69famr162002a12.0.1781808594664; Thu, 18 Jun 2026
 11:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
 <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com> <xmqqpl1q2xw5.fsf@gitster.g>
 <bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com> <xmqqo6h9z7e6.fsf@gitster.g>
In-Reply-To: <xmqqo6h9z7e6.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 18 Jun 2026 20:49:17 +0200
X-Gm-Features: AVVi8Cfqs8soZZgIKoyaFidrkvfmt4wzOUwNJI4_RI7aaoR9leqFtIPnDLQY2fA
Message-ID: <CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com>
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just an example when working on a different topic:

I rebased with -x to run all the tests, but ran a test that didn't
exist yet on the first commit and ended up in a bad state. Here it
should clearly show the 'git rebase --abort', so I can start over,
it's not something to fix:

```
$ git rebase --keep-base -x 'make -s' -x 'cd t && prove -j8
t3454-history-squash.sh t3453-history-fixup.sh t3452-history-split.sh
t3451-history-reword.sh t3450-history.sh'
Executing: make -s
GIT_VERSION=3D2.55.0.rc1.20.g1e31474ef6
Executing: cd t && prove -j8 t3454-history-squash.sh
t3453-history-fixup.sh t3452-history-split.sh t3451-history-reword.sh
t3450-history.sh
Cannot detect source of 't3454-history-squash.sh'! at
/System/Library/Perl/5.34/TAP/Parser/IteratorFactory.pm line 256.
...
warning: execution failed: cd t && prove -j8 t3454-history-squash.sh
t3453-history-fixup.sh t3452-history-split.sh t3451-history-reword.sh
t3450-history.sh
You can fix the problem, and then run

  git rebase --continue

$ git status
interactive rebase in progress; onto 95e20213fa
Last commands done (3 commands done):
   exec make -s
   exec cd t && prove -j8 t3454-history-squash.sh
t3453-history-fixup.sh t3452-history-split.sh t3451-history-reword.sh
t3450-history.sh
  (see more in file .git/rebase-merge/done)
Next commands to do (9 remaining commands):
   pick 498da64046 # history: give commit_tree_ext a message template
   exec make -s
  (use "git rebase --edit-todo" to view and edit)
You are currently editing a commit while rebasing branch
'rebase-fixup-fold' on '95e20213fa'.
  (use "git commit --amend" to amend the current commit)
  (use "git rebase --continue" once you are satisfied with your changes)

nothing to commit, working tree clean
```


Harald

On Wed, Jun 17, 2026 at 2:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> It is very true that users who know what they are doing and got into
> >> such conflicts are opted to go into such a situation tnat it is
> >> unlikely that they would appreciate a choice to abort.
> >
> > That's not quite what I was trying to say which was that aborting in th=
e
> > case of conflicts is more likely than in the case of a failed exec.
>
> Ah, I misread the intention.  And I agree with you that "failed
> test" case is very likely to lead to "further changes/amends" and
> not "aborted rebase".
>
> > So if I've understood we'd print a message explaining what's happened
> > and how to continue followed by a hint about aborting. The message woul=
d
> > depend on what problem caused the rebase to stop, but the hint would be
> > the same in each case. That sounds fine to me.
>
> Yeah, and "failed test" would not be one of the problem that would
> invite the hint to "abort".  I am OK with that, too.  FWIW, I am OK
> if the "you can abort" hint cannot be configured away, either ;-)
>
