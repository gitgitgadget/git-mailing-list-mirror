Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23E2E62A7
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744321250; cv=none; b=CylHPlezFtz9Y5PwSJl90EkLp2cIUAaU0lTqqY07ZgZEbrwKa0G3r2lGrazMbn6JKHVdCyl+T1EYJU0NipOjKgRdV+qnX0ySYM2UxEx879aHs9ruBgKDfXhYTuJCTKq5/9ObdsmYGa7aoDKiin/ui2oHeuy57X0nRImDPAHm9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744321250; c=relaxed/simple;
	bh=cUbO5vmFIePy/qZOJ9AEz+PUhVkEM47j8Q68qqg0fWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHbIagSeky51eO3HZPinYtjo+aqaLzdwKUqIkUYdHHMNcOMqgMDA+daDcXAvX3cbv/4eidcfYaZe59abR/+A0XlCYZVZM0WnM87a88ieK1Ngd8BM5XdlbMhKtZoWi0xAGtWaBdf+pn6dI/jV3fm8cgWqqNh/uvbh1axqD0C7KYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlBIu9wB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlBIu9wB"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f09f2b3959so3692a12.0
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744321247; x=1744926047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYTqjx9uX2wPTSGC37yBQsm6M1EOdan5T+MTuKhjLB8=;
        b=QlBIu9wBdqzjyaiU9H+WhzZij9WBeiPm18u+HsA2ty+y5kod5mMEn8HJo8+ewP2JF6
         E47BuU0fGTM6tKHSKu0AlVtthoMLVsPRCSPwY9gSpIYFvabPEkPNJa4vPZbLiNPVvQVu
         UDS/adrKfXt+0imyFoMmkbCANKgWuie4f1s1zWI+BvdX5kcnJxQyFOp9jIXMyfdgABv4
         IPvoEfPhVNmzrtRicN0huzD8YExT2xb7ucoH2J5GnbFL6TpLC1je4kXcwr6su7VJBXVa
         Z4kQATvVoogBcPqSb5WUqeNSSel3gkjcs6jvD2IdibzDMxFf914c4vJy8JidZRCLaRfT
         nE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744321247; x=1744926047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYTqjx9uX2wPTSGC37yBQsm6M1EOdan5T+MTuKhjLB8=;
        b=AS2Ee+RXh8PHHDZCRggHysC04fcqLYOwNvkMnXlOKWyEy2qCr2HovHR0oi9p8NsvWO
         yot4SBPuY+LYwbl/JcfJaOKzagd2CMzVTwzQoaG+ilnimQyulnC+Hq0IEZU8lDpAY4cs
         Y+CENvFm/zWD5NOT+yXBNZSI/LRmez58s6plrScSLN1Ci4fX9JsvEitJVHs0OiXOZfiC
         gTPAbpYUaW00jDTw9x95oAbccd+90vW7ukzanJpnCVCcMsphwpulP8lWuf4iUJIuGjZ7
         Qv0MPnv9W8eKnGcjX+FparkuvmSdLD5MkCXbLfGQbMzaqptP1BVymewP2jokuv5RPwWl
         JN7g==
X-Forwarded-Encrypted: i=1; AJvYcCWZGZVPjhustXu4wQOCvL6MksE3H6M+B/qDAvyyUv9Sb2kBnJuQKLGoXuHjGSVOIJpxRfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqJ6TeFb9LA46zAWer/gSGNKHWpt/qI7ZuNjExeGbTS5Iq7XJ
	cLQGC/I7vkKDnOUn7alE4WhEuYmcNEJXyYgL4DyzjofpinF9XDfi8TrBIZvKM6J8aX8qcIwGqEB
	x2vmoAKQPtbGFf8ccUCrUuiNU6c2LqnriOpAU5AZ8JwcIwhFLa8br
X-Gm-Gg: ASbGncsnDI0WQhl1UREecTNGDsa171tvaeQFd7XQjnoZmceb4AZoHoSnYcL523N4a3q
	J2E0GieSUsYN09pSBXkFvLw0Kri/xW5wYzkXku1P0dra3OfgVIN0iA+O5BBvkoYIPn2IYAtDCKL
	7JkwGhbyScAOtbDeJL8e/Rvw==
X-Google-Smtp-Source: AGHT+IFhDRJTt7HRTXSamUtj34yc/hVamS4P3+ZZTQpIgbf9xvosuNG8rp2+xUTIKyNVz3v5JAAA1xehMKrO1cWMqXI=
X-Received: by 2002:a50:cd14:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5f36f0a10e6mr6686a12.7.1744321246375; Thu, 10 Apr 2025 14:40:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <xmqqlds9trwv.fsf@gitster.g>
 <Z/bGzvDfsIcclBW+@ubby> <xmqqsemgpggd.fsf@gitster.g>
In-Reply-To: <xmqqsemgpggd.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 10 Apr 2025 14:40:34 -0700
X-Gm-Features: ATxdqUHT89tyMuJ8csLOyDoib_hmD3wQalQKPO6ju--Xczc0mnsifU0v9UrZxe0
Message-ID: <CAESOdVA7O2sg3t2YjrWAbHv5edREOh94ckf4oqdi70eH4Q+QNA@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Junio C Hamano <gitster@pobox.com>
Cc: Nico Williams <nico@cryptonector.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Apr 2025 at 01:29, Junio C Hamano <gitster@pobox.com> wrote:
>
> Nico Williams <nico@cryptonector.com> writes:
>
> > argument against similarity heuristics over change IDs.  I still think
> > that explicit change IDs would be better than using only commit
> > similarity heuristics.
>
> I do think it makes sense to explicitly record that this commit was
> (or "these commits were") created to refine and replace that commit
> (or "these other commits"), if we want to keep track of how a set of
> patches evolved, if such a determination can be reliably done.  And
>
> I suspect that IDEs can do a much better job keeping track of such
> correspondence than they can keep track of renames and copies, which
> I mentioned in an earlier message.
>
> It is insufficient to just record a single "change ID" to each
> commit, in order to handle anything other than "a single commit gets
> updated by another single commit" case.  It is insufficient to even
> keep track of "a single commit gets updated by another single
> commit, which in turn gets updated by yet another single commit"
> case, without assuming globally synchronised clock in a distributed
> environment, simply because you only have three commit objects that
> share the same "change ID" string among themselves, and you cannot
> tell between A becoming B becoming C (in which case people would
> consider C is the latest in the iterations), or two developers
> started from A to produce B and C indenendently (in which case it is
> not yet decided which one between B and C should be considered the
> latest).
>
> Since we are all human, it is possible that we think things through
> and make a design as complete as humanly possible but it later turns
> out to be insufficient.  If we make such a mistake, we'd then need
> to deal with it and that is just simply a part of developers' life.
>
> But something that is _known_ to be structurally insufficient before
> it is added to the system?  We should refuse to make such a thing a
> part of very core part of the data structure, like the header fields
> in commit objects.

I think we are talking about slightly different things. The change ID
proposal is about providing a stable way of referring to an evolving
commit. You can think of it almost like an automatically generated Git
branch name that follows the commit as it's rewritten (as if you had
passed `--update-refs` to every command). I think what you're
describing is more like the "Git Evolve" proposal [1] (also linked to
from elsewhere in this thread). I think that's also an interesting
feature but I see it as mostly a separate feature. There is certainly
overlap between the two features, such as how the simple centralized
flow I mentioned can work pretty well by relying only on the change
ID.

Change IDs in Jujutsu are very useful without support for changeset
evolution. With the indexing I mentioned and the prefix lookup
prioritizing "mutable commits" (roughly those that are not on a
remote), it's quite convenient to run `jj log` and see a highlighted
prefix of, say, "xu", and then you can do e.g. `jj show xu` instead of
having to paste a longer ID or type a branch name. A further advantage
of preferring change IDs over commit IDs in commands is that you don't
risk creating "divergent" commits (similar copies) by rewriting the
same commit twice. For example, `jj describe xu -m foo && jj describe
xu -m bar` will rewrite the original commit to have message "foo" and
then rewrite the rewritten commit to have message "bar". I understand
that this use case is less useful to Git users because Git doesn't
like to work in detached HEAD mode and doesn't rewrite descendants
automatically. Consider experimenting with jj to get a better sense of
how it works :)



[1] https://lore.kernel.org/git/pull.1356.git.1663959324.gitgitgadget@gmail.com/
