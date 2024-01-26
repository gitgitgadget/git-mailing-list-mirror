Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4E1AAA5
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270984; cv=none; b=i5X+Lfja/8MIUtzuHGjW0Kfy6dH3ZUgTDxRD2eKmdH09ZfinX+S5dtdKZDDcbe/GUH70xDuG4oB625wDjvVv3kjuQblg+s0iqxmlFVGcQA6GsseLi28QyLm3w7J/LGk4+mHY5xmluTWcf/4VhDvOGWYNV8ZWJhugJXHaN9jUD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270984; c=relaxed/simple;
	bh=h/BKlkEA2RNUnrssaPmSMuykGTbfRkekq0wGNEhPTW0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jrVOwDSUvkUpWppsWbnkPL5MAGiKpLLCu0idoio/87lb5LCA5PYwil1o2jVlfMvkFO0LFk+T5pdAfCUwEPkr0aajkPz6TUZ/2wf4kLPa+chZ4YdSaP41W2dD98EjugMpWARYc93wvibCMGO5+woG6zpzKaTLFqYmGxaMwQMphE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4yeC9bd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4yeC9bd"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso3089251fa.3
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 04:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706270981; x=1706875781; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ow1QHymouK7/Rn4fWjyF47PUHuoOpPZypq1Z4GhAr8=;
        b=M4yeC9bdpXbj0v5NtF375DEijzcLFf2/tc59SbPWN4LyJ4lFIbX9ADiagwBfE5El9F
         TQ8dQnxA0X572uMi5rX4e/IQwh12HUZNwBl0ew5k7+Ffk2D0BMMaIVTf0lGSgfUqmB0K
         cczAya8yoLR0o+55I0fK3tcJiBO/lRRYNse1G8iw5G9VExBL2D104JFU5Se94qqrZ4S/
         obWM7V8x0JXE2FNxiwJfpU5KCKq18gSf/ojVSFUPPXqAHHR5pk14KcyhiSFymFl0BqE2
         xK16wj9Q9HDVD13BPN7vteqnA8F3ekl8KKdE6r/ZHaVA97xEUTneXD/H0ogjyhfxOcN8
         h+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706270981; x=1706875781;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ow1QHymouK7/Rn4fWjyF47PUHuoOpPZypq1Z4GhAr8=;
        b=Gixys9S7E1UOuhRY8xZPilwRtMTloXos+oY9iNVvXlt84tsK04um2fyYzdlnii07Nt
         dPE0uK++vcw7LGb2+IOYFA0jr2vIYc0OQ9FKrwlGWEERo7en/Lw7uPb56P9pqrdo9nRm
         OWLDeHWdSAaVbiWgrWThD7rcC8EAOmQiZPENoHKg94L0R5htEBpRPv8E7j6f7Gz6ujV8
         fkJJkbtzlBYujasqb8zi7WjyvwvNVwkRUXM8/t8xBWfwruFScCHOAMhZw79tloWnro03
         X+KR/veQwXtj3jEAwsu9gM7QST8SymHaFjHgBkalwBClgzs2sjikXTtOo5cxx7LT6JaX
         6YCA==
X-Gm-Message-State: AOJu0YwfdZw52njwOFkVOqMv4IEU/KchuerLja+buAGF3RkTccvKEU9k
	+EXj4iulJ/Xkr2IDkjzfVI8L6WUmAGhDjx6x7CCkyZPlycaue5MQnVmBOUJq
X-Google-Smtp-Source: AGHT+IEUCG1J/xJPSSHSvBZd5e5BBrcTchXg2d4li7eaMo5LNp61bBGVo6rk7geGe3mPrjrgJRw+kA==
X-Received: by 2002:a2e:9d91:0:b0:2cc:e274:70ae with SMTP id c17-20020a2e9d91000000b002cce27470aemr413063ljj.165.1706270980832;
        Fri, 26 Jan 2024 04:09:40 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x3-20020a2e8803000000b002cf2ea847e7sm143182ljh.137.2024.01.26.04.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:09:40 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
	<xmqqzfwspmh0.fsf@gitster.g>
Date: Fri, 26 Jan 2024 15:09:39 +0300
In-Reply-To: <xmqqzfwspmh0.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	25 Jan 2024 23:44:59 -0800")
Message-ID: <87ede4fg8s.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> ..
>>>> ...  If the original semantics
>>>> were "you must force with -f to do anything useful", instead of "you
>>>> must choose either forcing with -f or not doing with -n", then it
>>>> would have led to the above behaviour.
>>> ...
>>> If we agree on the behavior above for sane "dry run"...
>
> Not so fast.  I said "if the original semantics were ... then it
> would have led to the above behaviour".  As the original semantics
> were not, that conclusion does not stand.

OK, fine, then my point is that the original semantics if flawed.

>
> The "-n" option here were not added primarily as a dry-run option,
> and haven't been treated as such forever.  As can be seen by the
> "you must give either -f or -n option, and it is an error to give
> neither" rule, from the end-user's point of view, it is a way to say
> "between do-it (-f) and do-not-do-it (-n), I choose the latter for
> this invocation".

Yep, and in my opinion this is even more a mistake than "-f -f".

> And in that context, an attempt to make "-f -f"
> mean a stronger form of forcing than "-f" was a mistake, because it
> makes your "I want to see what happens if I tried that opration that
> requires the stronger force" request impossible.

I believe this just emphasizes the original mistake of "-n" design
meaning something else than simple "dry run".

>
> And there are two equally valid ways to deal with this misfeature.

I rather see two almost independent misfeatures here, so I believe both
are to be addressed.

>
> One is to admit that "-f -f" was a mistake (which I already said),
> and a natural consequence of that admission is to introduce a more
> specific "in addition to what you do usually, this riskier operation
> is allowed" option (e.g., --nested-repo).

This addresses one of the two deficiencies I see, yes.

> This leads to a design that matches real world usage better, even if
> we did not have the "how to ask dry-run?" issue, because in the real
> world, when there are multiple "risky" things you may have to
> explicitly ask to enable, these things do not necessarily form a nice
> linear "riskiness levels" that you can express your risk tolerance
> with the number of "-f" options. When you need to add special
> protection for a new case other than "nested repo", for example, the
> "riskiness levels" design may need to place it above the "nested repo"
> level of riskiness and may require the user to give three "-f"
> options, but that would make it impossible to protect against nuking
> of nested repos while allowing only that newly added case. By having
> more specific "this particular risky operation is allowed", "-f" can
> still be "between do-it and do-not-do-it, I choose the former",

Yep, makes sense.

> and  the "--nested-repo" (and other options to allow specific risky
> operations we add in the future) would not have to have funny
> interactions with "-n".

Yep, but it still leaves "-n" being defective, as it for whatever reason
surprisingly clashes with "-f". I believe it shouldn't.

> The other valid way is to treat the use of the "riskiness levels" to
> specify what is forced still as a good idea.  If one comes from that
> position, the resulting UI would be consistent with what you have
> been advocating for.  One or more "-f" will specify what kind of
> risky stuff are allowed, and "-n" will say whether the operation
> gets carried out or merely shown what would happen if "-n" weren't
> there.

I'm not arguing in favor of "-f -f". My point is that even if you fix
"-f -f", "-n" deficiency will still cry for fixing.

>
> It is just that I think "riskiness levels" I did in a0f4afbe (clean:
> require double -f options to nuke nested git repository and work
> tree, 2009-06-30) was an utter mistake, and that is why I feel very
> hesitant to agree with the design that still promotes it.

Again, I'm not arguing in favor of "-f -f", I'm rather neutral about it.

I'm still arguing in favor of fixing "-n", and I believe a fix is needed
independently from decision about "-f -f".

Thanks,
-- Sergey Organov
