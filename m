Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24E69DE7
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708173959; cv=none; b=sGTQrkgCMb5C0xsih0Km1tqtcVTw85DiWN4zs+7J4T9/nVgiAlyQ0BjN5X3nhS5VO35Di8cVX77YrBZKpDP42UpHz3lS17BsttMr2yzGqI1aEsLG6hlh2vMvWmgMUooK8OyXCyHB9QXMPQSzi+i9Fi2P0PAdw8Vk9RzM1Aj+FuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708173959; c=relaxed/simple;
	bh=ZxDfctFJNp1zAX1B6Z6EjUTIcr7EyEZNr/1j6D4/Rn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u53S+OUL6TNe307eZCSwMwBVyWeF052CqiGT5/sCjMcbv7EZDjsdc4O614QU4yY2nJACwAc26FJ7yBVT1Rs9+Lna8bsm7b/WesHx63Z/xj/YaAJPqlFYH1VyXY4uwF/AaUvIQxlJYsT4IyU0OiB1F2+FBQlN+7RZni4crX2V7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faXJnBbn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faXJnBbn"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563d696ce87so2896127a12.0
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 04:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708173956; x=1708778756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jURYZMEL6sKlOMkhdXZ3ReWl/LavQ2AW5sLJBKPx4KQ=;
        b=faXJnBbnur7ItbgIUlSx9qzpHszxZWO5Kintn84CEloSrpfNj+PUVEh1ShBOdg57fe
         M40mlKwJGISZcGOQhbmN/vD/hfuIkX9ZjjWeUgRz2Q4ed0WpCPVVcZ4t9yx44XkLVCFP
         oqTd/u3M3kL4B7wrKyElQv8vORLh5NbRnBS3eyAo/qxP/gkyPcGlPk6yNiVuIMFkOW5c
         Ue7iWU6hFsSanL/ytooUHBZcZPeb1XOqikukoVGWpzSa0fBNZU4oe4fAF/TMzxTsl8pH
         YDBuoQDU2FXUAHJ2frMz7wVBGrxxnj+mOkOBXDrRUW6lo72d0O7BiB/ny8+jcA8+Dxb9
         WtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708173956; x=1708778756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jURYZMEL6sKlOMkhdXZ3ReWl/LavQ2AW5sLJBKPx4KQ=;
        b=XXJ1ADSedu9k1tRiPIQ/dAYYV747TO8AWeeT1AeNreK3fuWSPlGiWx+sGP+AC5lZht
         U8kQVFjvggY8uhfrAtV0dOawa9ARdZhcYcbFhIFqgCK9b/bxdybID0CbkdTO5E0YY1NV
         4Jsi/OifFqtpiQc5xpqqR/E84F9/rHK50UOZLdTBOYY6Tx5FMPfGXwvcZDO4d7lCFI5s
         /cxtj2bFf6wErLJ270Tn9iwKGNisiE7ySVf0dIb8u7/Eedkz5HaRT8rl5GEuhiiH5D3B
         UDwhsss75kpy4O1OIGy4tVoE+GbKLTrjrHK+1EDJHIR44fJDiOLK6tMEdiDdcSn//I3L
         babA==
X-Forwarded-Encrypted: i=1; AJvYcCWPOz5zXyjDJn8Z+AROXIl9+mUmmQ9m9QIRLt4zgTmR+Jm6oWZVQc3jQmIwEYbkIimGxgeVxYUucKeayPxhCJoSw6cW
X-Gm-Message-State: AOJu0YwvVE1vZ4yLACMs8pxsOjQ5yxsaJOnk7G9AzV+zMXoXLqWO3Q5/
	7lRu7W8y9tHcGnCkFDzUa8nbSrRVZuVdY8OkmhWc1dNJ8NrZMvmEKZkBcjbt7IIjisTSUsBOK4o
	RKmEwV/CIviUxYiPyDAFuzddTVWw=
X-Google-Smtp-Source: AGHT+IEtSDxg/vqUrhrdeGNVJFyZiX0NbYze9QA7wNKxSFPmaQhkEib9RhUW0qg81L5RCXKrHfMz9goFWmGOCzbN4hk=
X-Received: by 2002:a05:6402:2b8f:b0:561:3704:329c with SMTP id
 fj15-20020a0564022b8f00b005613704329cmr10401237edb.8.1708173955592; Sat, 17
 Feb 2024 04:45:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl> <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
 <xmqqy1bxiiop.fsf@gitster.g> <20240213080014.GB2225494@coredump.intra.peff.net>
 <CA+CvcKR9sH=qZB4oZvX9RWd+4H3Bq8WV_qUOiSj_Tsf=Dr_Xvw@mail.gmail.com> <20240215150430.GA3453@coredump.intra.peff.net>
In-Reply-To: <20240215150430.GA3453@coredump.intra.peff.net>
From: Maarten Bosmans <mkbosmans@gmail.com>
Date: Sat, 17 Feb 2024 13:45:39 +0100
Message-ID: <CA+CvcKSQCUukfLNnRkmTp=K=aXBRaxQnattfL+QexgOsYX18nA@mail.gmail.com>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Op do 15 feb 2024 om 16:04 schreef Jeff King <peff@peff.net>:
>
> On Thu, Feb 15, 2024 at 08:46:02AM +0100, Maarten Bosmans wrote:
>
> > > How about:
> > >
> > >   cat some_commit_ids |
> > >   git show --stdin -s -z --format='%H%n%N'
> > >
> > Wouldn't that fail horribly with non-text blobs?
>
> Yes, if you have NULs embedded in your notes then it won't work. Any
> batch output format would require byte counts, then. If we wanted to add
> a feature to support that, I would suggest one of:
>
>   - teach the pretty-print formatter a new placeholder to output the
>     number of bytes in an element. Then you could do something like
>     "%H %(size:%N)%n%N", but it would be generally useful for other
>     cases, too.
>
>   - teach the pretty-print formatter a variant of %N that outputs only
>     the oid of the note, note the note content itself. And then you
>     could do something like:
>
>       git log --format='%(note:oid) %H' |
>       git cat-file --batch='%(objectname) %(objectsize) %(rest)'
>
>     to get the usual cat-file output of each note blob, but associated
>     with the commit it's attached to (the "%(rest)" placeholder for
>     cat-file just relays any text found after the object name of each
>     line). You might need to do some scripting between the two to handle
>     commits with no note.
>
> Of the two, I'd guess that the second one is a lot less work to
> implement (on the Git side; on the reading side it's a little more
> involved, but still should be a constant number of processes).

The second one is attractive for another reason than implementation
simplicity. While the first one offers more flexibility, the second
reuses the existing cat-file batch format, so the interface between
git and scripts is familiar and consistent.

> One variant of the second one is to use "git notes list". For example,
> you can get all notes via cat-file like this right now:
>
>   git notes list |
>   git cat-file --batch='%(objectname) %(objectsize) %(rest)'

So the cat-file batch output is suitable for blobs containing newline
or NUL characters. But I struggle a bit with what would be an easy way
of using this format in a shell script. Something with multiple read
and read -N commands reading from the output, I guess.
The git codebase has `extract_batch_output()` in t1006. This uses a
separate perl invocation to parse the cat-file output, which confirms
my suspicion there isn't a straight-forward way to do this in e.g.
just a bash script.

That was why my first steps were to accept that a launching a separate
process per note in a bash loop is a pretty clear and well understood
idiom in shell scripts and try to make the git part of that a bit more
efficient.

> You can get individual notes by asking for "git notes list <commit>",
> but it will only take one at a time. So another easy patch would be
> something like (indentation left funny to make the diff more readable):
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index e65cae0bcf..5fdad5fb8f 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -446,22 +446,22 @@ static int list(int argc, const char **argv, const char *prefix)
>                 argc = parse_options(argc, argv, prefix, options,
>                                      git_notes_list_usage, 0);
>
> -       if (1 < argc) {
> -               error(_("too many arguments"));
> -               usage_with_options(git_notes_list_usage, options);
> -       }
> -
>         t = init_notes_check("list", 0);
>         if (argc) {
> -               if (repo_get_oid(the_repository, argv[0], &object))
> -                       die(_("failed to resolve '%s' as a valid ref."), argv[0]);
> +               retval = 0;
> +               while (*++argv) {
> +               if (repo_get_oid(the_repository, *argv, &object))
> +                       die(_("failed to resolve '%s' as a valid ref."), *argv);
>                 note = get_note(t, &object);
>                 if (note) {
> -                       puts(oid_to_hex(note));
> -                       retval = 0;
> +                       if (argc > 1)
> +                               printf("%s %s\n", oid_to_hex(note), oid_to_hex(&object));
> +                       else
> +                               puts(oid_to_hex(note));
>                 } else
> -                       retval = error(_("no note found for object %s."),
> +                       retval |= error(_("no note found for object %s."),
>                                        oid_to_hex(&object));
> +               }
>         } else
>                 retval = for_each_note(t, 0, list_each_note, NULL);
>
>
> That would allow:
>
>   git rev-list ... |
>   xargs git notes list |
>   git cat-file --batch='%(objectname) %(objectsize) %(rest)'
>
> We could even add a "--stdin" mode to avoid the use of xargs.

Yes, a --stdin mode for `git notes list` would be a useful building
block for scripting indeed.
I'll probably give it a try when this patch series succeeds.

Maarten
