Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FF5382
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046690; cv=none; b=rIxjkcp+cYaDxC1JWG2/48iibR4nw6P2yxgCw4NmUCv4upeNwR/MP076k8fod5+F3Ph7IrJukdYZ82K4hC/5pBTQIYftUuNVITo/0xouyEg+V8veNka/kfuu9Do5X7ME4WZORTJmQ6Ng89BqA45tjJydRNRSMkg6h9zZXAHR7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046690; c=relaxed/simple;
	bh=IHRf6rPYofwsyEBgYBejVeai4EX3u6HO6t1DaxbXITk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IQ/8Yj02khV5IOWH/Z9N/SBGVQyXz2B4Z41ZQHf/yLu8FAjP5N3Y6c9IZ9kSbnojC+2xcFEAHgRBeT/MNo2+M4HSCJAn76ai8HNoonPJJPzqodGxlMhh9GOg2rKpN8H3RYsK39wjdtIxt92IySlJ52x6LouF7LnMB2jjUsuNfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+E6AQal; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+E6AQal"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dca5c631ffso1723995a12.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 17:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708046688; x=1708651488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvQLd8Y6ySdSpXC5RDi8ctmeHsdGCw31J5Co4XO4Sq4=;
        b=l+E6AQalqBRDj/Y2OX4LJkG1bFsfKtTqxhnivw5mPBW+Qs93C1Vzfy9hbNQ87PBEQi
         Qtp9Gn+B1+THcPM/XhOF3q6HJMMUaeutclGuybpKDkp9RSgU6+lVlvGMmQsheUK42ZJF
         v41t+HSDBgAd/SeaWaQzr6wpm4Qt2KgLSa4LpjdrH00Zqi7nD96uwOkuOCXkPACg2yoR
         dnbImV3EnnvWxd7of52CXsTXcshcQ9bG6SbyQXpFrr//9vUSg4xzeq3YfhGU9A51yTez
         H7e6Vcg3KtdumbO8Ss38fmylEAB/a5IHkU8+pef7E8bQ8NJj2YtD5a3XALqWheg8AV8U
         VAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046688; x=1708651488;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RvQLd8Y6ySdSpXC5RDi8ctmeHsdGCw31J5Co4XO4Sq4=;
        b=mh8lwzRqD2rSfmoUBzHuP2xa5n2Lp9zG7db5tYTJsihrV06+SAyhAOb+LvePh5/3G/
         GbvReb2H5DyEYg9njdoPO9CtS5XzUgrGzAfa+YGjkH4aqNefSgOqujYa+evPyye0nfsB
         kEM3GpzFAvqMWI95YzVdTvfv+o8khq5TtKwGudFwXDxk+aYGX2rlF8oOUHwneBo1x5MG
         hZRQKlcEMQJeIFtQQPwcp7PUuJrcXXD8B5JmSV85CNuRBDSSwwi+Bqq201vyVSmgtH1V
         ZMFrYR0z1g8f2nq5eRA5fFsr1PeWGB0pYqZzqu34p8jVLV+JSNxJYiiitZuj6m/mlxrA
         Lu5Q==
X-Gm-Message-State: AOJu0Yxj4Z/5//y9yQTZBrkC5sShewHBhM1UEBiUTCPRAfejHu1yEO4i
	MSWr2w9eS8tEFd3TgWgfLVulzDdzyW1Dbxfc3CVfFgKVjVp+CQQxh2wh8q2iFPCVLbI+40VDQS1
	UCg==
X-Google-Smtp-Source: AGHT+IGx2ATJaQsN41y+L1HraI8d8r5O5mtxXbmHiIVH1D4zgmHcQrrjxV4czle9W9hOyvPbq7vEyvrQ3jo=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a02:990:b0:5dc:97e:6981 with SMTP id
 cl16-20020a056a02099000b005dc097e6981mr10125pgb.3.1708046688208; Thu, 15 Feb
 2024 17:24:48 -0800 (PST)
Date: Thu, 15 Feb 2024 17:24:46 -0800
In-Reply-To: <CAP8UFD3N8h4FnfvFYYWrV54a7WcOwHY862DjxxPKSKr4jEwU7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-5-christian.couder@gmail.com> <owlyil2s9eq6.fsf@fine.c.googlers.com>
 <CAP8UFD3N8h4FnfvFYYWrV54a7WcOwHY862DjxxPKSKr4jEwU7Q@mail.gmail.com>
Message-ID: <owlyv86p8ald.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 4/4] rev-list: allow missing tips with --missing=[print|allow*]
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 13, 2024 at 11:33=E2=80=AFPM Linus Arver <linusa@google.com> =
wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>> > While at it let's add a NEEDSWORK comment to say that we should get
>> > rid of the existing ugly dumb loops that parse the
>> > `--exclude-promisor-objects` and `--missing=3D...` options early.
>
>> > @@ -1019,6 +1019,10 @@ Unexpected missing objects will raise an error.
>> >  +
>> >  The form '--missing=3Dprint' is like 'allow-any', but will also print=
 a
>> >  list of the missing objects.  Object IDs are prefixed with a ``?'' ch=
aracter.
>> > ++
>> > +If some tips passed to the traversal are missing, they will be
>> > +considered as missing too, and the traversal will ignore them. In cas=
e
>> > +we cannot get their Object ID though, an error will be raised.
>>
>> The only other mention of the term "tips" is for the "--alternate-refs"
>> flag on line 215 which uses "ref tips". Perhaps this is obvious to
>> veteran Git developers but I do wonder if we need to somehow define it
>> (however briefly) the first time we mention it (either in the document
>> as a whole, or just within this newly added paragraph).
>
> I did a quick grep in Documentation/git*.txt and found more than 130
> instances of the 'tip' word. So I think it is quite common in the
> whole Git documentation and our glossary would likely be the right
> place to document it if we decide to do so.

SGTM.

> Anyway I think that topic
> is independent from this small series.

Agreed.

>> Here's an alternate wording
>>
>>     Ref tips given on the command line are a special case.
>
> `git rev-list` has a `--stdin` mode which makes it accept tips from
> stdin

Ah, thanks for the context.

> , so talking about the command line is not enough. Also maybe one
> day some config option could be added that makes the command include
> additional tips.

>> They are
>>     first dereferenced to Object IDs (if this is not possible, an error
>>     will be raised). Then these IDs are checked to see if the objects
>>     they refer to exist. If so, the traversal happens starting with
>>     these tips. Otherwise, then such tips will not be used for
>>     traversal.
>>
>>     Even though such missing tips won't be included for traversal, for
>>     purposes of the `--missing` flag they will be treated the same way
>>     as those objects that did get traversed (and were determined to be
>>     missing). For example, if `--missing=3Dprint` is given then the Obje=
ct
>>     IDs of these tips will be printed just like all other missing
>>     objects encountered during traversal.
>
> Your wording describes what happens correctly, but I don't see much
> added value for this specific patch compared to my wording which is
> shorter.
>
> Here I think, we only need to describe the result of the command in
> the special case that the patch is fixing. We don't need to go into
> details of how the command or even --missing works. It could be
> interesting to go into details of how things work, but I think it's a
> separate topic. Or perhaps it's even actually counter productive to go
> into too much detail as it could prevent us from finding other ways to
> make it work better. Anyway it seems to me to be a separate topic to
> discuss.

Fair enough.

>> But also, I realize that these documentation touch-ups might be better
>> served by an overall pass over the whole document, so it's fine if we
>> decide not to take this suggestion at this time.
>
> Right, I agree. Thanks for telling this.
>
>> Aside: unfortunately we don't seem to define the relationship between
>> ref tips (e.g., "HEAD"), object IDs (40-char hex string), and the actual
>> objects (the real data that we traverse over). It's probably another
>> thing that could be fixed up in the docs in the future.
>
> Yeah, and for rev-list a tip could also be a tree or a blob. It
> doesn't need to be a "ref tip". (Even though a ref can point to a tree
> or a blog, it's very rare in practice.)

Interesting, thanks for the info.

BTW I appreciate you (and others on the list too) taking the time to
explain such subtleties. Although I've been using Git since 2008 a lot
of the terms used around in the codebase can feel quite foreign to me.
So, thanks again.

>> > +      * to manage the `--exclude-promisor-objects` and `--missing=3D.=
..`
>> > +      * options below.
>> > +      */
>> >       for (i =3D 1; i < argc; i++) {
>> >               const char *arg =3D argv[i];
>> >               if (!strcmp(arg, "--exclude-promisor-objects")) {
>> >
>> > [...]
>> >
>> > @@ -2178,13 +2183,18 @@ static int handle_revision_arg_1(const char *a=
rg_, struct rev_info *revs, int fl
>> >       if (revarg_opt & REVARG_COMMITTISH)
>> >               get_sha1_flags |=3D GET_OID_COMMITTISH;
>> >
>> > +     /*
>> > +      * Even if revs->do_not_die_on_missing_objects is set, we
>> > +      * should error out if we can't even get an oid, ...
>> > +      */
>>
>> Perhaps this wording is more precise?
>>
>>     If we can't even get an oid, we are forced to error out (regardless
>>     of revs->do_not_die_on_missing_objects) because a valid traversal
>>     must start from *some* valid oid. OTOH we ignore the ref tip
>>     altogether with revs->ignore_missing.
>
> This uses "valid oid" and "valid traversal", but I am not sure it's
> easy to understand what "valid" means in both of these expressions.
>
> Also if all the tips passed to the command are missing, the traversal
> doesn't need to actually start. The command, assuming
> `--missing=3Dprint` is passed, just needs to output the oids of the tips
> as missing oids.
>
> I also think that "ref tip" might be misleading as trees and blos can
> be passed as tips.
>
> So I prefer to keep the wording I used.

Makes sense, SGTM.

>> > +      * ... as
>> > +      * `--missing=3Dprint` should be able to report missing oids.
>>
>> I think this comment would be better placed ...
>>
>> >       if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, =
&oc))
>> >               return revs->ignore_missing ? 0 : -1;
>> >       if (!cant_be_filename)
>> >               verify_non_filename(revs->prefix, arg);
>> >       object =3D get_reference(revs, arg, &oid, flags ^ local_flags);
>>
>> ... around here.
>
> In a previous round, I was asked to put such a comment before `if
> (get_oid_with_context(...))`.

Sorry, I missed that.

> So I prefer to avoid some back and forth
> here.

SGTM.

>> > +++ b/t/t6022-rev-list-missing.sh
>> > @@ -78,4 +78,60 @@ do
>> >       done
>> >  done
>> >
>> > +for missing_tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
>> > +do
>> > +     # We want to check that things work when both
>> > +     #   - all the tips passed are missing (case existing_tip =3D "")=
, and
>> > +     #   - there is one missing tip and one existing tip (case existi=
ng_tip =3D "HEAD")
>> > +     for existing_tip in "" "HEAD"
>> > +     do
>>
>> Though I am biased, these new variable names do make this test that much
>> easier to read. Thanks.
>
> Thanks for suggesting them and for your reviews.

You're welcome!
