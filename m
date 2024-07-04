Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C86A039
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720129134; cv=none; b=SkF7liy1qxgdvYGaNK7M0e8Elcx4MpJNAaOerdHkmuxsXZyw7Qt4YzalLuom9b5aHCGbRVidIptrNNwRhmKYDzEwRN+Epc8voIJ9h6Q9SIEQEdlbNvF+/DjLPeyvIr8UoFDoEowF8G+pDHPTYD+me/1uBclpWA7/mQEDpl7jj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720129134; c=relaxed/simple;
	bh=djICmpHI40sal3yCyK/cJ4+rS0zi6x/IwxRKbWBPNg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PVgR/QAncJUTnzTr75GJhP84DKzezHt4PNyWYOpxqvdGLpuDIkgu2ANgNEze+dZvvQqiNwMCrSQd7QwMbdlZ+fL14partVnKfluydmoNNkNnwyjegT+Xuvc/XAIDE3oup5gHgXXZdVrsmJdWV4pmQJzZ9pE8rtp8Y9SrilcFv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8t5tihb; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8t5tihb"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e03609bd52dso1022388276.1
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 14:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720129132; x=1720733932; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/t+buHedDaFcMDk9N1FTNywehOmXAV/+FAJ4D6o9bg=;
        b=m8t5tihbMDHkKS6qG5s2VJ08r4m2QVxTe5ox/oRbBGPJLjH5N4/4vEparG9wd2z+zx
         lcWhQKBso79su4CgjTy9IGDOYGQT2pHZ/VNvCYfC/P8+fyM/ogNDTPFp8/mQceTGUtMq
         2Kuq6ivlPCfOeLZ8ZfuEaFNOYsZYaVHC6HyvksygkntbbHblPEPT+BKkNqFlqTtjA9ix
         XMbIi3jg2enTF6yx1um/phSFQXOOELfLId1Q+2l5kE5Nd6aSy8mA7VPb70pgxx9D1aAR
         gkm1hlM6rmAqS8QbR9yAe2UvCMHf6t9yZBqP8HNaDjuidLfFNbIy/ERJGiK1aHM/tfmn
         knZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720129132; x=1720733932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/t+buHedDaFcMDk9N1FTNywehOmXAV/+FAJ4D6o9bg=;
        b=cFjIGwB/AwTS2z4b++cReyUt4265pOUpCf9iyaR6y76og4bQqescYlaJUCigXul20C
         T4i4Izjg+5VMnQzj4J4rKyEKfA84SwHkwb6oVDzb9sW6xooMUgz6m2nrIaHpcY5Jjqb9
         RSijuCSLbh3+77dRbwq37VnS1aCoL4IbdZQsIS75GGQNcq0Ui6gnJGqbdrELi6xVg6n/
         cWc/56SWD4uVCeH9oC6Sr+J06RnB2pe/c+1WtvsbTrzHyoc60z4FbIy7EAo1KY1GAL0h
         G1GS1SuFoQeljACwW9/BKKqADYKKOF57ZgNrKLHPcICIihhFH0CLNLL1b+f0PRn5mPZn
         A3/w==
X-Gm-Message-State: AOJu0Yw/qKvjnMb9v3/s1/lGisbsYIjqletqN4kjcIExTZar120LRhev
	34TS67GLqdKxNA3Z3luYla1kSgHyBhNonqRb33Q9kr7hrQEYmwL75LdJCAK3Uc5k22FkYPZJ58e
	DUEzY0JVYNUNQ0RpeO0J5k0E1A+ETug==
X-Google-Smtp-Source: AGHT+IG3yw/FYNp7D5TXBIaqTX4+hxX2S21fBvqUp/qj3nbrRHcqjFxvaobrYUaxJFYLw/ucqMLBIJuqji5LOsmzOJ4=
X-Received: by 2002:a25:6983:0:b0:e03:5bca:aee6 with SMTP id
 3f1490d57ef6-e03c1a1eed4mr3102677276.54.1720129131916; Thu, 04 Jul 2024
 14:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
 <CABPp-BGVdQZCr=0NzY9vpUJqaH+5yxJdpvfUqqhtWB4V=nkwDw@mail.gmail.com>
In-Reply-To: <CABPp-BGVdQZCr=0NzY9vpUJqaH+5yxJdpvfUqqhtWB4V=nkwDw@mail.gmail.com>
From: Emanuel Czirai <correabuscar+gitML@gmail.com>
Date: Thu, 4 Jul 2024 23:38:41 +0200
Message-ID: <CAFjaU5vC--bGWBBPP=6YW43sXR6rDgLA7sTL4G81xVeBKsgFrg@mail.gmail.com>
Subject: Re: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. in
 the wrong place) (just like gnu diff/patch)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 10:08=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Wed, Jul 3, 2024 at 8:25=E2=80=AFAM Emanuel Czirai
> <correabuscar+gitML@gmail.com> wrote:
> >
> > Subject: `git diff`/`git apply` can generate/apply ambiguous hunks (ie.=
 in the wrong place) (just like gnu diff/patch)
>
> Yes, this is already known.  In fact, it was one of the big reasons we
> changed the default backend in rebase from apply to merge.  From the
> git-rebase manpage:
>
> ```
>    Context
>        The apply backend works by creating a sequence of patches (by call=
ing
>        format-patch internally), and then applying the patches in sequenc=
e
>        (calling am internally). Patches are composed of multiple hunks, e=
ach
>        with line numbers, a context region, and the actual changes. The l=
ine
>        numbers have to be taken with some fuzz, since the other side will
>        likely have inserted or deleted lines earlier in the file. The con=
text
>        region is meant to help find how to adjust the line numbers in ord=
er to
>        apply the changes to the right lines. However, if multiple areas o=
f the
>        code have the same surrounding lines of context, the wrong one can=
 be
>        picked. There are real-world cases where this has caused commits t=
o be
>        reapplied incorrectly with no conflicts reported. Setting diff.con=
text
>        to a larger value may prevent such types of problems, but increase=
s the
>        chance of spurious conflicts (since it will require more lines of
>        matching context to apply).
>
>        The merge backend works with a full copy of each relevant file,
>        insulating it from these types of problems.
> ```
>
> > This doesn't affect `git rebase` as it's way more robust than simply
> > extracting the commits as patches and re-applying them. (I haven't look=
ed
> > into `git merge` though, but I doubt it's affected)
>
> This was not always true; and, in fact, rebase is actually still
> partially affected today -- if you pick the `apply` backend or pick
> arguments that imply that backend, then you can still run into this
> problem.  The merge backend (the default) is unaffected, and this
> problem was one of the big reasons for us switching to make the merge
> backend the default instead of the apply backend.
>
> git merge is unaffected.

Thank you very much, I really appreciate knowing this very interesting
info! Cheers!

This also tells me that I shouldn't expect a solution for `git
diff`/`git apply` any time soon, else it would've been done at that
time, I suppose.
It's all good, I'll find some kind of workaround for my use case.
(probably something based on `diffy` as it's simpler for me to grasp
than the C code)

Thanks everyone. All the best!
