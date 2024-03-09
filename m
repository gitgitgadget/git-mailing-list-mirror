Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4316FF33
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 04:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709958900; cv=none; b=HK8F5lsCeXre/JE1mwS6sKuh9Swbd2JfnsfQz5yNPhDYm8a1KGUCEsSUXNWXeCDyXXmtlT5e/IQS3eK+lv2ujjG4aw/W/S19z7tzgKMt0mkkeM+PdNEJmWAxL+9dMshmTfr+iTiwMZZPXzc8Cc4++Bml/WfQdZFH1aQ9ZOGNILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709958900; c=relaxed/simple;
	bh=S6IWD5tBSbtTs8eaN+KWZzFDrOzigVIs1wr0/7pB7V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcXHNhzzLovKtn3tdQyE9SJTTjSOkUKn6SUCmkKvTkNGT48zg8Bna1ORbj73bYYDSHZ6vg0bi8gnCfE2jq+3im15b3FZD+Z/8aAJP/By9E1V/+OpgfAxJUy1jhgvmR7eKsHw9BZoK/i9RW0N8qRhDXYlNzgrK1OMCjO1+9W+VAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCBxnXS8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCBxnXS8"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso2078757e87.0
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 20:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709958897; x=1710563697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl0oPlJJRsQrQBbgt8/hsecr3Zuz9ROSlhryZc2rK6Q=;
        b=CCBxnXS867XozAwdn87Dv3r1dzFWkysotblGLw4H2BwTuoyXD9IOXnl4U4EnlDoLr0
         iF/UAQYgoHOC9/tLyo4INEPxFJWpsqeyxLngHazrkLABRT5082DjfKKF7WugmwsWG96K
         uxhDz10CNx6vwnYCx2VUHiwRqSLdAFrg8if5N4FZwv4IawAb1Jb+a1Ncoj0K0GPCjp1g
         c5Bqmo5dOkBVUkuU5gWUxisyDu8UzX1wWZTjk4WXoxZ7rDYMEM8AjBIMleBJuNJ1QN4v
         Ftcp/r3zhv+ABMytu/n1YIjfhoRoOg/siS08O4FjzyuJRfAcwkEeHtdflpmNLTMU+7UV
         nrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709958897; x=1710563697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vl0oPlJJRsQrQBbgt8/hsecr3Zuz9ROSlhryZc2rK6Q=;
        b=So+rn4N/gC1zdQWjaYJstPFfFvYd6SNVyWpa+VBQCpyvgvOLuarug2Kd9MJwr4DiVH
         XA7SN0E7Bw8GIgARkwJHNDrr8dNIHfqLPbRLYDPDwKQccASs+HUbTL35C5ZQb/HwUfLd
         jXreAeZzjA4C6esKlM40eRfzYyHel9RvcxwiExVOo98Eig/ztTEEs8lPSMJBX/6L/3AD
         uxl+mgbrwuUcNYfmMFp6hTXVVScgB6C4TRZ9L1z9KyYKH8FJuebEXIyB9FNTqQQ7FJcO
         4JZwlYAIhmc0RCDdLbzlM3dLcJWGIhezJd+YQ87U7HJ/yvPld8vrbweskYGP3ezKzCqw
         wLFA==
X-Forwarded-Encrypted: i=1; AJvYcCXj0/0eT770smOrSppFk/oymr6jDjP75/pZYRHg7O4gUxjSHtCafxbIARLv6on6jyFdtGjcSDehsLH3GCFxDNmHuXBH
X-Gm-Message-State: AOJu0YyZMpxOvB7rlmWZTut827USMP42kgAf6DiF+yWXpDnUUQIhMazG
	oPuYJ9JewILtpeYCRpaLMvYhKikw8rH8bJ45lRLYEsmEN4a6Tt4vRw5Ptk8MSBudnCOqA/lsZ29
	iVh9jlTwk9kCBCliWd2ak1MiPTLc=
X-Google-Smtp-Source: AGHT+IFj//da9CEI6y4v/K9Y8QBPkyt8sy5dvcm2kpt4mUdM50w41R+iPuZIgczVOeVY+TyGtPCWiL6to0eXBo9aphc=
X-Received: by 2002:a05:6512:2823:b0:513:42e:ddf0 with SMTP id
 cf35-20020a056512282300b00513042eddf0mr755370lfb.36.1709958896683; Fri, 08
 Mar 2024 20:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
 <c0d7bafd43823ef9df5a73bc80b90cf003988bc9.1709907271.git.gitgitgadget@gmail.com>
 <xmqqle6shgkw.fsf@gitster.g> <48b2d5b1-a59f-44c3-94ba-e7f81913b7f5@gmail.com> <xmqqwmqcfz4y.fsf@gitster.g>
In-Reply-To: <xmqqwmqcfz4y.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 8 Mar 2024 20:33:00 -0800
Message-ID: <CABPp-BFBNDkdL5Z-VOrv2Z3aWaA3OpWFqd6ZGmU9YC8jBRsAog@mail.gmail.com>
Subject: Re: [PATCH 3/4] merge options: add a conflict style member
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood123@gmail.com, 
	Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:48=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> phillip.wood123@gmail.com writes:
>
> > I agree it is confusing, Elijah renamed it from ll-merge.c relatively
> > recently 6723899932e (merge-ll: rename from ll-merge, 2023-05-16). It
> > looks like the idea was to group it with the other merge* files:
>
> That reasoning cuts both ways.  When you are only interested in the
> upper level API functions, being able to skip ll-anything as "low
> level details" is a powerful thing.  merge-ll & hash-ll separated
> far apart will make it impossible.

merge-ll is wildly different than every other *-ll.h file we have in
the tree; the latter set of files may be misnamed, for reasons other
than what you are suggesting here.  hash-ll, hex-ll, etc. exist due to
the main include file having some rarely used API that require more
#include statements, and most users of e.g. hex functions can get away
with just including hex-ll.h rather than the full hex.h.  Thus,
hex-ll.h is _not_ "low level details that you can skip", but "the
_primary_ data structures and functions".  It doesn't get the name
hex.h, though, because if we did that then the folks that need both
primary parts of the API and the occasional additional function would
need to have two hex-related includes.  Also, every function declared
within hex-ll.h is still defined within hex.c; there is no separate
hex-ll.c file, and the same is true of all the other *-ll.h files
other than merge-ll.h.  As such, there is absolutely no relation
between hex-ll.h, hash-ll.h, fsmonitor-ll.h, etc.  Using an ll- prefix
on those filenames thus makes no sense to me.  (It's not clear that
-ll even makes sense as a suffix for these files either, but it's not
clear what else to use instead.  If I recall correctly I originally
put forward "-basics" as a possible name suffix for these files, but
someone else suggested "-ll", and not having any better ideas or
strong opinions I just went with it.)

merge-ll is different in that it is actually a separate level of the
API, and there are both a merge-ll.h file and a merge-ll.c file.

I originally had proposed only adding the hex-ll.h, hash-ll.h,
fsmonitor-ll.h, etc. files, but you suggested that ll-merge should
either be renamed or that these new files should be
(https://lore.kernel.org/git/CABPp-BErrVUnuDjL73edDpmkKUvs6Ny6cYwvueXw1toB4=
JcF-Q@mail.gmail.com/).


Now, all that said, and assuming we were to go back to a world where
the other *-ll.h files don't exist (or are renamed independently with
a different suffix), I'm still not understanding why ll-merge makes
more sense to you and Phillip than merge-ll.  Could you explain more?
If you're only interested in the upper-level API functions, that
suggests you are already at the function level and looking within a
given file.  The low-level functions are already split out into a
separate file, so you just don't go looking at that separate file.
However, if you're interested in "where in this codebase do I find the
stuff related to merging", then you aren't in a file but in a
directory listing.  The first usecase gains no benefit from renaming
these files back to ll-merge.[ch], while the other usecase would have
been much improved in my experience from being named merge-ll.[ch].
Granted, it's a really minor point, which was why I never brought it
up until you suggested making all the other *-ll.h files and
ll-merge.[ch] consistent; since renaming the other *-ll.h files made
no sense at all to me, I went with renaming ll-merge.[ch] to
merge-ll.[ch].

There's probably some other angle to this that you two are viewing
this from that just isn't apparent to me.  Sorry for not seeing it
(yet).  Hopefully the above context is at least helpful, though.
