Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49B302CCC
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111348; cv=none; b=pdsRVdq37XzqALO5G8OJSFBWoFtDcJK92cL3/g29BLViS0xXCqi71K3fqVrvNeZMPcBdZKCRmNJOpVFjIClONQBlTaERqlQvfwIHrCmogNP+CE6b6sTEQl31fojR1qvM/X52fZRypQnPZ/o/dvraxbvQZk+fHbMbWknmtRYaXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111348; c=relaxed/simple;
	bh=TB4VUDen3rkPx5IbZqldFtfDGAzLUyX1V2HmlJkrCjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raToXJi+2tYClfGS+FDTBOeBm+iNKgQtTb/1dDUyieq055LUjkImqwdUzD3pwImIrZ/lHfALiw/EY1JmRe2Chew5BPYve2hzWXeHEjew/vbPlKMnG7qfwtKaWFIQ0d0sm0thsk7bOAtWDv0fOaw61vRFRgDuH5SqNbu/9TtZvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5huvLtr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5huvLtr"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b656412so247804a12.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755111342; x=1755716142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIkchnVR16kfR2CYmz8IQHZntEdlwQnisRz5HfutAmo=;
        b=R5huvLtr55SytQy3XsqvDM+PiNBgFsSNKPoE7/7qzecmiMjOL/5N979j+HTKLKJpjv
         c/rO4cIzf/hSQvTiUNGsS0QmAWZTid4PhOAUODfHVtxhWuxlFAr5lnfgyFeuxnO7uP1m
         eWxutEz8Y/nl+FfQA5Tb3eCMUdOeDSXutq4hQj2E9qUeJupNPy+Df6Bv0Xz33plkjB8F
         wrpmdHtjg3ZdS7Jkv06yf0eeefkb7W1z2gUzEPXJU9O4lePj73D8t1TmYrsf9pQEDBsz
         ClIjmhDlEbIA4ZE+ZZbSci1ys60Oi7OsdV/W5T6xknkmHqIfWX4Ng528zqyisvSY3H5b
         WW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755111342; x=1755716142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIkchnVR16kfR2CYmz8IQHZntEdlwQnisRz5HfutAmo=;
        b=ehI4/Ugs4UFoHjr7dgPX98Wgvha8FFjixYhisEenJ5KBLBNqNH8xazGfNdvi8ii9re
         XtPyv9tdhV6Y8JbTHA+E1fLtuhG298uTD7H/YfErSDl09uU8sKgkU4vti5Pb3amEgv02
         I/7w+P7Stwm9SYcjEAZpesK/9EebBFv9+XTKs81UCV5DxOd5Idu8yYh0FcV5UTsFM3k1
         bjqYuMPdrwGy13mGrG4/n1HWpk9KVQy+ek9Do9yVn3VnQa8FriUZatXk4bIg761M+cSl
         x9YaK+D0tLOltH5f5tXg3k6cJh0zhwbTnaxcsC/8kdq98FBG3M36hxSnwdMnPS6pe9GV
         yr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzrbvRZqrgAUGP3SaGxjmnzUjvy9x+SWxgFmgOlossY4Kob9tktZb+44yoqNzncJFaXAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWrOi7DmQ+n/mPei9oxm9V+qKd3Mu9jURhcnqZNDDeACp52Nu
	gbkGW4oQHKks5UF8c2LWFbeKN12iOiB277ZC82y4LXDGAK3fnSPSTLSgFdQhdQCxXVBZJvV10nP
	1qWQjld773eNWKnbdb+ae5HfHiYHu/yqgCSU2
X-Gm-Gg: ASbGncsqCF2cu412nghhIjvThqnOBOwZ8XXsRQD4NDs3xY5XXYB1bcFoAqJLGehUpGa
	mIjor4OEuy+99b3cfrYOGjHq3ZL0jhn1DRzzOiClR/eSvNNIHT4rEpYEB41I0BK4NDBeofiiasS
	Stgx127k1wlxvJRWrOKDS3UIjC0NufWwGDpE21iSPLSHg2R01DabVldGZ5piwJmHUc3XXYMoH+i
	3yw6sAVtpcRvHI7l0eDqBpicWRCPgsRS34aXAwW6w==
X-Google-Smtp-Source: AGHT+IEVEpS7vHEvq0bll/wDTAY2lZQrEjLtfjyoiHfOuij/vDHIi6vBLJw5SKXEb4Am4WTZ1qF0rzAROnAXeEq1YMg=
X-Received: by 2002:a17:907:948d:b0:af9:29c1:1103 with SMTP id
 a640c23a62f3a-afcb991c9admr22283966b.55.1755111342006; Wed, 13 Aug 2025
 11:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com> <105a65e6e7121ac6a9a8a1d0b4f3217495a9f5e7.1754702057.git.gitgitgadget@gmail.com>
 <10372e00-3bb1-453a-bb62-332aaa935b24@gmail.com>
In-Reply-To: <10372e00-3bb1-453a-bb62-332aaa935b24@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 13 Aug 2025 14:55:30 -0400
X-Gm-Features: Ac12FXystnWW-uNLPswhcU4BuyxTzj869YnnITrz-vWvNsXGG3O3syOuPBc3jUY
Message-ID: <CALnO6CBOWTCd-cREfGYL8DPPd=S-s3Y6s0cgwvBzCJZr6E6hvA@mail.gmail.com>
Subject: symmetric difference with --left-only vs. range notation
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, Git <git@vger.kernel.org>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 11:42=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Julia
>
> On 09/08/2025 02:14, Julia Evans via GitGitGadget wrote:
> > From: Julia Evans <julia@jvns.ca>
> >
> > +Here is a more detailed description of what `git rebase <upstream>` do=
es:
> > +
> > +First, it makes a list of all commits in the current branch that are n=
ot in
> > +`<upstream>`. This is the same set of commits that would be shown by `=
git log
> > +<upstream>..HEAD`.
>
> The existing text is not quite accurate here, it should really say `git
> log --cherry-pick --right-only <upstream>...HEAD` as we drop any commits
> from the branch that have already been cherry-picked to <upstream>.

This reminds me, I've been meaning to ask: is there a meaningful
difference between the following 2 commands?

    git rev-list --count --left-only @{u}...
    git rev-list --count ..@{u}

In my estimation, since we're not using --cherry-pick here, the first
says "list (count) the commits on upstream but not in HEAD, since the
merge-base (which is reachable from both)" while the second says "list
(count) the commits on upstream but not in HEAD." Is there ever a
situation where those sets aren't the same?

Of course the symmetric difference is not always the same as the range
notation, but when we add --left-only [or --right-only, by symmetry
;)], does this collapse to the 2-dot notation?

I've been assuming the latter is more performant, too, but if that's
not the case, that's also good to know.
