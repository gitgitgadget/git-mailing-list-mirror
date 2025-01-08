Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B6185B6D
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374874; cv=none; b=m0NBpgFg59ewORjVg/R6X7wFexvtEM/8VhHqAJixIN2wrao/+zsZHGhYq2JnyF61cse6aNxMmCbfdLCvAzQbQg9p3tIB0/YyGDEgIh/+mLq3XytNqan8VGQiPv9O7Y44nYMKFGRdUZrCZzzvl8rROZIrv4UO5mzfriGmDg98jIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374874; c=relaxed/simple;
	bh=CxRiAEkMWB0qkC0d3QD0zKQbvZfZ354zogCsa2Aw0M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC6XKjsQ9VOjJSDLRQRb019wErTHxptl7h+T/Spt+A+NfOOvn3HpG5Dkjyi3v4xekRbPDKprUf2fAak3zDQW8i1c+vGS3BNQn5e9muOq6hmWCcO/hUWZP6/Kqc51HYcWT5x2Vkr5QWtcWh+gJMqA463tJ5Oq6jaX3Gb/GupJkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdIfkcBb; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdIfkcBb"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e3167b90dso150743a34.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 14:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736374871; x=1736979671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhqn4dhRf+istBoTOi1GAhDv4EIpqNUFQ+xVrNJs15Y=;
        b=CdIfkcBbdH/vBVkeKo6ywXtUgejCokutCVfcYcvfSRbs23MiiU4+tZrlRIpXJetk8y
         akC3wv3t0FadMYGOh4y5LhI/ccc38leuTCkPg40v1q4JK5D1o+1A00ZOuelOa3bW1vSJ
         x0DsQLGLwDAm+8Ygj7poiKsIlZB5COZbck84yE8ohxi8Q8I3XoFzNUnJUuqiW4Vot53Q
         TVi+AnP0/JCJOP9q09/dQkrKUBZti1O/7tnPUH+gveOz9wi0mvLOw2S1xROjxJIcPIk2
         AjmXZzqf89Brb50J/kl7ZuFjRjzk4XbMA12+0PSoj/yLN+qkZRoEdWUOupbAp7QOEdWR
         Yx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374871; x=1736979671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhqn4dhRf+istBoTOi1GAhDv4EIpqNUFQ+xVrNJs15Y=;
        b=Pjrdi5b0lvmhxy94/pNFQj3PtR4cbfzkPXT9Ar8dIuVbBWKvLQgIqU21WClGVsy6UI
         mBJo1bylBvEWZLQW8LG4RNuqJYQ+iSxDdl+Updzdoeq9lM3rAlew4reJJ/kEhiV6sf3W
         VIR4vwT0jd/oc70yJnqHDhSv8Oz/tvgtK+0RZnvtwq8r4+RgHLCBTHcRez6ZT0C2JFQm
         XG0LcShnco3ZCBX9d5WwW9eEX7WiawLUZU1A6gZLBr4fwsRaDvi6ziI5l4OhUZjYoD7Q
         7zZB9dhWqmNRAPMsjyTYjwm8+LGVaF4AK35z1pEPgfu6DZ1sRoJheMBTipc0yjfYedxU
         VDvg==
X-Gm-Message-State: AOJu0YxchnXnyP/ufIhP7D4XHKNx3k0zuBwYV7Pcv/sPRwYGEcYaK0wc
	X6MPnLxNN0/ZrVW27tRiAqzMSxgZiLI35BYcjJp8lDjlbSL3vgQR7K1lEw==
X-Gm-Gg: ASbGncs8sL6PuOuag980yItDQLxYVo0C2LyQ0TOK7wr+SzTBPzXcPq5X43XPNlouqIX
	WPEwAdM0r/8y4U36K+n458JnNMsEebovNUGu8D3t6mUhtgjxGjVh8hRypkWpPSQDTvi3ei0oA4a
	otHnzuysYBJFc4Oz+dfSMMYZ3d9Rb/24EDe4FPlndPQUbHSgQVi68J1UrtjR14JeYkS6nIDG4sA
	LL+eaEriOh0tuR+ciMY1nZmN2B1HfgRQX1irTQ9UzTsucGVhQ==
X-Google-Smtp-Source: AGHT+IHFQuT25JXTeuquSz9qH250g3i5Zl+f3VeTuoaeGspM03IX0T/FRErBAdiCazp4rmvYpXX5Cg==
X-Received: by 2002:a05:6830:4410:b0:71d:4698:7b24 with SMTP id 46e09a7af769-721e2e7073emr3420437a34.16.1736374871235;
        Wed, 08 Jan 2025 14:21:11 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231862a215sm10138a34.66.2025.01.08.14.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:21:10 -0800 (PST)
Date: Wed, 8 Jan 2025 16:18:35 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH] rev-list: print missing object type with
 --missing=print-type
Message-ID: <onddu4fjgo2q7f6r7f6kgqctrbhshkll23z6ocsxiiqxbynap5@msq7qtj2un4w>
References: <20250108034012.211043-1-jltobler@gmail.com>
 <xmqqjzb5pc6t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzb5pc6t.fsf@gitster.g>

On 25/01/08 07:17AM, Junio C Hamano wrote:
> The users need to be told what this "type" information really means,
> as its meaning is quite different from what "git cat-file -t <oid>"
> would give them.  We do not have the object, so we are not learning
> its type from the object itself.  How much trust should the users
> put in this information, for example?
> 
> That comes back to the "where does it come from" that the future
> readers of "git log" and reviewers need to be told by the proposed
> log message.  Knowing the internals, I know you'd be getting it from
> the "containing" objects, e.g., an object name that was found on the
> "parent" object header field of another commit, which is _expected_
> to be a commit, or an object name that was found in a tree entry
> whose mode bits were 100644, which is _expected_ to be a blob, etc.

I'll update the log message in the next version to explain how
information about a missing object gets inferred. As you explained, this
is relying on the containing object to figure this out. This is why for
some missing objects it may not be possible to infer the type. For
example, if a missing object is only reffered to by a reference, there
is not a containing object that can be used.

> There are other places that you _could_ glean information about
> (possibly missing) objects.  An object that is found during
> "rev-list --objects" traversal (which is the topic of this patch
> after all) but turned out to be missing may not just have an
> expected type (because it was found in a tree object that we
> successfully read) but also the full path to the object in the
> top-level tree, for example.
> 
> In modern Git, there are even more places that you may be able to
> use, like commit-graph that not just hints the object itself is a
> commit, but what its parents are and when the commit was created.
> 
> Note that I am not suggesting to implement more code to learn "type"
> information from more places than the current patch is doing.  At
> least not in this iteration of the patch.  What I am getting at is
> that it would help us to avoid unnecessarily limiting ourselves by
> stressing on "type" too much if we at least imagine what the
> possible sources of these extra pieces of information are and what
> they could provide.
> 
> As I suspect that we would want to leave the door open for us to
> extend this later, I would perhaps suggest an output format format
> like:
> 
>     ?<object name> [<token>=<value>]...

I think this is a great idea. To select which attributes get printed
with the missing object we could add an option. Something like:

  $ git rev-list --objects --missing=print \
  --missing-attr=path --missing-attr=type

I like the idea of also adding a path attribute, but this raises a
couple of questions. The way `--missing=print` currently works is that
it prints the unique set of missing object IDs. A missing object could
possibly be referenced by multiple trees and thus have multiple valid
paths. There are a couple of different ways this situation could be
handled:

  - We could record each of the encounted paths for an object and print
    out each. Something like: `?<oid> path=foo path=bar`

  - Historically, `--missing=print` would only ever print a single
    instance of the OID, but we could print a missing object with
    multiple paths each on a separate line. Something like this:
          
      ?e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 path=foo
      ?e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 path=bar

  - We could keep it simple a just report a single path per missing
    object. It doesn't capture the whole picture, but it does provide
    some insight into the missing object.

Since this missing object type is also inferred from the containing
object, in theory different containing objects could indicate different
types for the missing object. I'm not sure though if this is a scenario
worth accounting for. Maybe it would be fine to rely on a single
containing object to provide the type and assume it is consistent across
the others.

For paths, I'm currently leaning towards having each identified path
printed out as a separate attribute on the same line. For types, I'm
thinking we can just print a single type and assume it is consistent.
I'm certainly open to suggestions though. :)

> where <token> tells what kind of extra information it is.  I expect
> that the initial implementation only knows about "type" as the
> <token>.  For future extensibility, we only need to say that under
> the syntax:
> 
>  (1) How multiple attributes are shown?
>  (2) How would a <value> with SP or LF in it is represented?
> 
> My suggestion is to have multiple <token>=<value> on the same line,
> with a SP in between, and problematic bytes in <value> are quoted,
> using cquote(). i.e. a <token>=<value> whose <value> part does not
> begin with a double-quote ends at the first SP after it, otherwise
> <value> is taken as a C-quoted string inside a pair of double-quote.

Ok, so using a path value as an example, if it contains a SP, or a
special character that would be handled by `quote_c_style()` it should
be wrapped in double-quotes to indicate that it is all part of the
single attribute. That makes sense.

> If you are adventurous, I would not mind seeing "path" implemented
> as another token, since that would be fairly easily obtainable, but
> it does not have to be in the initial attempt.

Handling paths appears pretty straight-forward to add and seems like a
good idea. In my next version I'll also add support for a path
attribute. Thanks for the feedback.

-Justin
