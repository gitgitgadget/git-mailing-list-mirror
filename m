Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141036F082
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380603; cv=none; b=qZbt3ceT1cL374oWi9Be8y7BOU0eITrMiKuQm9i3GSbw6v2Cg1kJYl/Hsk4T/gJjTmgPKvhBkjk0dcSYnqA7kj9WOSKo44HY3bdyy8zH7f86wBTpjT9jbKarC5LeZKbl2GownRSjTKHo3aFohrujaiiVB/b/OGJqMJr/NUke0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380603; c=relaxed/simple;
	bh=L0A9xgdPfBOJuHvTPrXS0FLOI8o/mttXkgqgke8yO8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pmtm9KeUnwOnhsHDko8sA8S7ynGWbH6TCqxLZlskHVPT0laXakGpe6Ttq9KJIBqrEjsl1VN2vTJnm0sBh7ly/5Ul0Hbpzsi5KjXoGHo9G9UFED9Iu588hfEDXVk0Hjju2Inrnju/BJ1kYahhrIA21N35/uiq0V/h9tqHHrsnDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxSOImSd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxSOImSd"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efe82b835fso34890147b3.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 00:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707380600; x=1707985400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4o8h+ad9MsQ+5BkP9j4teExHuhdDRqsK4fOwzuiOZ40=;
        b=DxSOImSdVYOdIhOTabbeK3GJCOqo7zMvNtAX/777k3++1d8n56GvBjlt5WXlXJY7YR
         24wOZrm2O1Aoj+5/1yQucfztfgYE7nAeD+NyKlCrinTD1Ngz4UtKzhDEJPj0Fxzj2jsJ
         ZJ8jEq+vI23PpWxjbYycPKwiWfaN4v4N2MqBxGlKC3cdSDbgs5pQ2pY8Zc7R/IZE3Dyl
         ESKqa+VT2V4hcMTGvHtlaZsP1ToCoAZz1rlb0Uuu6eFyuocjH7cHirtfcTZc07QE9DgJ
         IWNzMjdiXyvDb20ENUssilWcSknEl6coB2g4ZBn07vOCp3MsytJPionUljzlnwc3DWZS
         3TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380600; x=1707985400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4o8h+ad9MsQ+5BkP9j4teExHuhdDRqsK4fOwzuiOZ40=;
        b=OGE7sXR7tZFvhiP5ut0S1KAYEq3IDYZa6fcPYvYXHxMvy55lJc/OR1RQe6PFF91uhc
         Iq0qLtl0uzVVUvZEBZy+C9LjMLBkoa7Dui5vaXTPXOgvTwKXvj9A9Bu99n2DdS2iz0A3
         BkNJAFiBf5eSq3xCHhAGVDq0GRMPNFpxttG7OMvD2oec9F7hU6C6ly/FC1ZK5e+93xjU
         HgvsAVWP/3Z8OFk4lnLe7Ge/0+zj1s2BpuxP8cnUHJd7oA/QcMw3aPw1g+tqrm983VoH
         Rxn5gGntR8/rAmkYkLP8TG+GxCtcYeJbuREhCfMG6dQ9QXE0qv4RnD8JRkScn6JykbFk
         Z6Cw==
X-Gm-Message-State: AOJu0Yx9oZQw0IgLBepi3rQKFJXkGfnVXRk7mhCcdRqjrG0Az7BqMZ+V
	8i+qXk2GYoJnL42CL/CJEibJllQXZORFYygTAqeHjeRsJSALLnkFyvlXekZzzryxSvAOVNn5Ptd
	JPA==
X-Google-Smtp-Source: AGHT+IFIKjuj1SLs6xSyGsTn5tV8arrJDXROv+7tM7I9APZdWAmLwg3YmunTYKiRnwt1EiIbV8VAbSFPJKY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:13ce:b0:dc6:d8d9:7d7b with SMTP id
 y14-20020a05690213ce00b00dc6d8d97d7bmr1823334ybu.5.1707380600041; Thu, 08 Feb
 2024 00:23:20 -0800 (PST)
Date: Thu, 08 Feb 2024 00:23:18 -0800
In-Reply-To: <20231002024034.2611-1-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org> <20231002024034.2611-1-ebiederm@gmail.com>
Message-ID: <owlyfry3cqkp.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 01/30] object-file-convert: stubs for converting from
 one object format to another
From: Linus Arver <linusa@google.com>
To: "Eric W. Biederman" <ebiederm@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Two basic functions are provided:
> - convert_object_file Takes an object file it's type and hash algorithm
>   and converts it into the equivalent object file that would
>   have been generated with hash algorithm "to".

Should probably be

    - convert_object_file takes an object file, its type, and hash algorithm
      and converts it into the equivalent object file using hash
      algorithm "to".

It would be nice if you gave the function name some clue of what sort of
conversion is being done though. Something like
"convert_object_file_hash" or "switch_object_file_hash". I like "switch"
because the word "hash" itself means to convert some input bytes into
another set of (aka "hashed") bytes, and the indirect shadowing of
"convert" in this way can be avoided here by using a different word.The
whole point of this function is to switch the hashing scheme from one to
another, while still keeping everything else the same, so "switch" seems
more appropriate.

Unless, of course, we already pervasively use "convert" this way
elsewhere in the codebase (I have not checked).

>   For blob objects there is no conversation to be done and it is an

s/conversation/conversion

>   error to use this function on them.

Could you explain why no conversion is needed for blob objects, and also
why it should be an error (and not just a NOP)?

In the code we can also call BUG() if the from/to algos are the same.
It's probably worth mentioning in here as well?

Also for such detailed explanations, I think it's much better
to place them as comments directly above the function (and only mention
the important bits about these helper functions, other than the fact
that they will come in handy in later patches, in the log message).

>   For commit, tree, and tag objects embedded oids are replaced by the
>   oids of the objects they refer to with those objects and their
>   object ids reencoded in with the hash algorithm "to".

That's a little wordy. I assume embedded oids just mean oids that these
objects refer to (e.g., commit objects have oids, but for example the
tree referred by a commit would be an example of an embedded oid). If
so, then how about just

    For commit, tree, and tag objects both their oids and embedded
    (dependent) oids are converted using hash algorithm "to".

I dropped "reencoded" in favor of "converted" btecause that's the verb
you use in your function name "convert_object_file()".

>   Signatures
>   are rearranged so that they remain valid after the object has
>   been reencoded.

Maybe s/reencoded/converted here as well? But also, it sounds odd to me
that signatures are simply "rearranged" and not "regenerated" or
"recreated" becaues "rearranged" means keeping most of the old stuff
around but just repositioning them, which doesn't sound like it's doing
justice to the meaning of a hash algo transition.

> - repo_oid_to_algop which takes an oid that refers to an object file
>   and returns the oid of the equivalent object file generated
>   with the target hash algorithm.

The name is odd to me because "repo_oid" doesn't make sense (a repo
is not an object so it doesn't have an oid), but also the "to_algop"
name (AFAICS "algop" just means "pointer to algorithm" in the codebase,
for examle in <hash-ll.h>).

Here's a possible rewording:

    - switch_oid_hash takes an object file's oid and returns a new one
      using hash algorithm "to".

> The pair of files object-file-convert.c and object-file-convert.h are
> introduced to hold as much of this logic as possible to keep this
> conversion logic cleanly separated from everything else and in the
> hopes that someday the code will be clean enough git can support

Did you mean "clean enough so that Git ..."?

> compiling out support for sha1 and the various conversion functions.

FYI you can cut down this ambitious sentence into two for readability,
like this:

    The new files object-file-convert.{c,h} hold as much of this logic
    as possible to keep this conversion logic cleanly separated from
    everything else. This separation will help us easily phase out SHA1
    support (perhaps as a compile-time flag) in the future.

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  Makefile              |  1 +
>  object-file-convert.c | 57 +++++++++++++++++++++++++++++++++++++++++++
>  object-file-convert.h | 24 ++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 object-file-convert.c
>  create mode 100644 object-file-convert.h
>
> diff --git a/Makefile b/Makefile
> index 577630936535..f7e824f25cda 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1073,6 +1073,7 @@ LIB_OBJS += notes-cache.o
>  LIB_OBJS += notes-merge.o
>  LIB_OBJS += notes-utils.o
>  LIB_OBJS += notes.o
> +LIB_OBJS += object-file-convert.o
>  LIB_OBJS += object-file.o
>  LIB_OBJS += object-name.o
>  LIB_OBJS += object.o
> diff --git a/object-file-convert.c b/object-file-convert.c
> new file mode 100644
> index 000000000000..4777aba83636
> --- /dev/null
> +++ b/object-file-convert.c
> @@ -0,0 +1,57 @@
> +#include "git-compat-util.h"
> +#include "gettext.h"
> +#include "strbuf.h"
> +#include "repository.h"
> +#include "hash-ll.h"
> +#include "object.h"
> +#include "object-file-convert.h"
> +
> +int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
> +		      const struct git_hash_algo *to, struct object_id *dest)
> +{
> +	/*
> +	 * If the source algorithm is not set, then we're using the
> +	 * default hash algorithm for that object.
> +	 */
> +	const struct git_hash_algo *from =
> +		src->algo ? &hash_algos[src->algo] : repo->hash_algo;

Hmm, if we're only using "repo" to grab its hash_algo member as a
fallback, should this function be broken down into 2, one to get the
fallback algo and another that has the meat of this function without the
"repo" parameter?

I haven't read the rest of the series yet, let me keep reading.

> +
> +	if (from == to) {
> +		if (src != dest)
> +			oidcpy(dest, src);
> +		return 0;
> +	}
> +	return -1;
> +}

It's curious to me that you treat same-hash-algo as a NOP here, but as a
BUG() in the other helper. Why the difference (perhaps add a comment)?

> +int convert_object_file(struct strbuf *outbuf,
> +			const struct git_hash_algo *from,
> +			const struct git_hash_algo *to,
> +			const void *buf, size_t len,
> +			enum object_type type,
> +			int gentle)

Is there a particular reason you chose to put the out parameter (outbuf)
at the beginning, rather than at the end? In the other helper function
the "dest" out param comes at the end. Style conflict...?

Also, you don't use buf or len, so you could have kept them out from
this patch (so that you only add them later as needed).

> +{
> +	int ret;
> +
> +	/* Don't call this function when no conversion is necessary */

Please avoid double-negation. How about simply

    /* Refuse nonsensical conversion */

or simply drop the comment (as the BUG() description already serves the
same purpose?)

> +	if ((from == to) || (type == OBJ_BLOB))
> +		BUG("Refusing noop object file conversion");

I think it would be better if you separated these out and gave them
different BUG() messages. If we barf with a BUG() it would be so much
more helpful if the message we get is as specific as possible, rather
than leaving us guessing whether (as in this case) we passed in
identical hash algos or whether we tried to handle a blob object. Since
you already have the switch statement below, the OBJ_BLOB case could go
there easily enough.

Nit: I think BUG() messages are not supposed to be capitalized.

> +	switch (type) {
> +	case OBJ_COMMIT:
> +	case OBJ_TREE:
> +	case OBJ_TAG:
> +	default:
> +		/* Not implemented yet, so fail. */
> +		ret = -1;
> +		break;
> +	}
> +	if (!ret)
> +		return 0;
> +	if (gentle) {
> +		strbuf_release(outbuf);

What does "gentle" mean here? But also if you are just freeing the
outbuf, then why not just name this param "free_outbuf"? But also it
seems a bit odd that the caller (who presumably owns the outbuf) is
asking a conversion function to possibly free it before returning.

> +		return ret;
> +	}
> +	die(_("Failed to convert object from %s to %s"),
> +		from->name, to->name);
> +}
> diff --git a/object-file-convert.h b/object-file-convert.h
> new file mode 100644
> index 000000000000..a4f802aa8eea
> --- /dev/null
> +++ b/object-file-convert.h
> @@ -0,0 +1,24 @@
> +#ifndef OBJECT_CONVERT_H
> +#define OBJECT_CONVERT_H
> +
> +struct repository;
> +struct object_id;
> +struct git_hash_algo;
> +struct strbuf;
> +#include "object.h"

It looks a bit odd that the forward declarations of these structs come
before the #include line. I don't think that's the pattern in our
codebase (maybe I'm wrong?).

In hindsight, the log message could have added that switching back
and forth between different hash algos is a fundamental (but currently
missing) operation, and that this is the reason why these conversion
functions (currently unfinished) are necessary as the first step for the
patch series. I realize that you've stated as much in your cover letter,
but it is always nice to have the intent embedded in the log message(s)
where applicable (such as the case in this patch that introduces a brand
new header file) to save future developers the hassle of looking up the
relevant cover letter.

Thanks.

> +int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
> +		      const struct git_hash_algo *to, struct object_id *dest);
> +
> +/*
> + * Convert an object file from one hash algorithm to another algorithm.
> + * Return -1 on failure, 0 on success.
> + */
> +int convert_object_file(struct strbuf *outbuf,
> +			const struct git_hash_algo *from,
> +			const struct git_hash_algo *to,
> +			const void *buf, size_t len,
> +			enum object_type type,
> +			int gentle);
> +
> +#endif /* OBJECT_CONVERT_H */
> -- 
> 2.41.0
