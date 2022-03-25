Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAF4C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiCYTk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiCYTin (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C0A23DEA7
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:19:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 5so14981335lfp.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Zzx1J/Q0B/ytOVrDNtBa/aPzfnnlejcsyejTM+gsiE8=;
        b=P6IpjhiXeakvnwWF1E/7/J6ItK2CJYySM/pTYfG56WnN7Q12Zw11H5l4Hkl8ItxKsp
         4POWq27a/XZEcZnCuGqyPPCyAmjol7BMZt7rlD5YIDaNwYMZA5W9XmBS0lEZpzYlpmE5
         flITcF3bzxZCXKxIvu/cLfFDdWnO/AQ99AqLFs/OoeYwG8CZDCH9GHlHAKkQ88e3cZeU
         tNS0LOkwQx0nwZrse3CGg6+kABsuwJuvpsrj6YEtY6KZLbk8pJ2CceHFRSMI1PConFfp
         hDgewHLDtzWjFph6SOS83DDn3tIYeZkj0xkkj3cMVf8wtOW5s8DffcLsxtgquL6mL3cr
         Iclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Zzx1J/Q0B/ytOVrDNtBa/aPzfnnlejcsyejTM+gsiE8=;
        b=axvU0F02Oea+cto7DuhQJiTo9mnUmbcxAIGTVVH5TKp8rr6eaD3lM/3nNHOkJadnKh
         KtoqG095Daa0OnqG9w0taL6uijykyr2rtJsWSipJ2eiTGksY6GiFcPCypoKIalk/dvnq
         cHjuFqYCumSgLh4vLQszg0z0FDyjFGzWrRweVOepdXisIg5RFGTOt7rXJ2aW3FECYyJw
         4AsF0JbD0BFWVF3bHfcrJ4fbgtEvsEKCLOMpfcy5V9UzkmlfWQrZvf340VmU6ArJ2UHo
         WauNFFrFvVxJs8hXl/Db6pOatwsUnoBYourcWvSQvAHGiaZ6JSFW2IPY8BlKQv80q0pJ
         Ug1A==
X-Gm-Message-State: AOAM532Ew7Gl2q6uMOUWqdLffDi1Jj6OrPw5JMP8y+APTIIXJPG4pVTY
        44NhLVJ1SnfaS6EwJjysbiE3RuFp5HID3A==
X-Google-Smtp-Source: ABdhPJyC9vvCvAyX04msC2FKrdo8QoY3ofRqNNoRKsa/S+FHz8kPe+wmyQoR5SGIVM91hAfYh75c9Q==
X-Received: by 2002:a05:6402:350d:b0:419:5099:1f10 with SMTP id b13-20020a056402350d00b0041950991f10mr14911204edd.144.1648231923986;
        Fri, 25 Mar 2022 11:12:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7c38c000000b0041939d9ccd0sm3159360edq.81.2022.03.25.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:12:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXoPq-0026Tm-Ss;
        Fri, 25 Mar 2022 19:12:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
Date:   Fri, 25 Mar 2022 18:34:11 +0100
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
 <d71fa968-be75-f4ad-ea6c-644f9d2b52d9@github.com>
 <220325.86r16qkodl.gmgdl@evledraar.gmail.com>
 <8d368240-dae5-7a66-6c0c-9e0a960ca34c@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <8d368240-dae5-7a66-6c0c-9e0a960ca34c@github.com>
Message-ID: <220325.86mthdlx59.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Derrick Stolee wrote:

> On 3/25/2022 12:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Mar 25 2022, Derrick Stolee wrote:
>> [...]
>>>> We could furthermore combine the two get_object_list() invocations
>>>> here by having repo_init_revisions() invoked on &pfd.revs, but I think
>>>> clearly separating the two makes the flow clearer. Likewise
>>>> redundantly but explicitly (i.e. redundant v.s. a "{ 0 }") "0" to
>>>> "have_revs" early in cmd_pack_objects().
>>>
>>> I disagree, especially when you later want to make sure we free
>>> the data from revs using your release_revisions().
>>=20
>> Because we'll need two release_revisions() instead of one?
>
> And it would be easy to miss one of the two if you are only testing
> certain paths with leak-check on.
>
>>>> This does add the future constraint to opt_parse_list_objects_filter()
>>>> that we'll need to adjust this wrapper code if it looks at any other
>>>> value of the "struct option" than the "value" member.
>>>
>>> So we are coupling ourselves to the implementation of this method.
>>=20
>> Sure, but aren't all OPT_* where the macro is providing some custom
>> callback coupling themselves to how it's implemented?
>
> No, I mean that the callback function you are making here is coupling
> itself to the existing callback function in a novel way.

Yeah, I did start by just copy/pasting its contents, or I could have
both of them call a semi-"private" wrapper, would you prefer one of
those instead?

> I tried to find another example of a nested callback, but I didn't
> even find another instance of creating a new 'struct option'.

I haven't seen a nested one, FWIW OPT_ALIAS() creates a new "struct
option", but in a completely unrelated way, what I'm doing here is
probably novel within the codebase...

>>>> But that regression should be relatively easy to spot. I'm
>>>> intentionally not initializing the "struct wrap" with e.g. "{ 0 }" so
>>>> that various memory sanity checkers would spot that, we just
>>>> initialize the "value" in po_filter_cb(). By doing this e.g. we'll die
>>>> on e.g. this test if we were to use another member of "opt" in
>>>> opt_parse_list_objects_filter()>
>>>
>>> So you are using uninitialized memory as a way to discover any
>>> necessary changes to that coupling. I'm not sure this is super-safe
>>> because we don't necessarily run memory checkers during CI builds.
>>>
>>> I'd rather have a consistently initialized chunk of data that would
>>> behave predictably (and hopefully we'd discover it is behaving
>>> incorrectly with that predictable behavior).
>>=20
>> I'd like to keep this as-is, i.e. if you zero it out it might also
>> behave unpredictably or even in undefined ways (e.g. a NULL ptr
>> dereference). Likewise in my version, but it has the benefit of being
>> caught by some tooling we have.
>
> I guess by "predictable" I mean "well-defined" or "deterministic".
>
> I don't want the build options to change how this works (for instance,
> debug builds sometimes initialize data to zero).

Yeah I agree that does suck.

Honestly I don't care that much in this case, I just wanted to resolve
the topic conflict.

In the general case though I think it's much better to have a flaky
failure caught on some platforms, via valgrind or whatever because we
used uninitialized memory than to have a silent failure (e.g. because
it's always an int=3D0, but we expected something else...)

>>> +struct rev_info_maybe_empty {
>>> +	int has_revs;
>>> +	struct rev_info revs;
>>> +};
>
> Thinking about this a second time, perhaps it would be best to add
> an "unsigned initialized:1;" to struct rev_info so we can look at
> such a struct and know whether or not repo_init_revisions() has
> been run or not. Avoids the custom struct and unifies a few things.
>
> In particular, release_revisions() could choose to do nothing if
> revs->initialized is false.

This plan won't work because that behavior is both undefined per the
standard, and something that's wildly undefined in practice.

I.e. we initialize it on the stack, so it'll point to uninitialized
memory, sometimes that bit will be 0, sometimes 1...

If you mean just initialize it to { 0 } or whatever that would work,
yes, but if we're going to refactor all the callers to do that we might
as well refactor the few missing bits that would be needed to initialize
it statically, and drop the dynamic by default initialization...

> Further, a second repo_init_revisions() could do nothing if
> revs->initialized is true. This allows us to safely "re-init"
> without our own "if (has_revs)" checks...

Yeah if you had a previous repo_init_revisions() you could rely on that.

>>> 	else {
>>> 		if (!pfd.have_revs) {
>>> 			repo_init_revisions(the_repository, &pfd.revs, NULL);
>>> 			pfd.have_revs =3D 1;
>>> 		}
>>> 		get_object_list(&pfd.revs, rp.nr, rp.v);
>>> 	}
>
> ...making this just
>
> 	else {
> 		repo_init_revisions(the_repository, &revs, NULL);
> 		get_object_list(&revs. rp.nr, rp.v);
> 	}
>
>> Conceptually I think the saving of that one line isn't worth it to the
>> reader.
>>=20
>> Then you'd need to read up and see exactly how pfd.revs gets mutated,
>> and its callback etc., only to see we're just doing this to save
>> ourselves a variable deceleration and a call to release_revisions().
>>=20
>>> and then later you can add
>>>
>>> 	if (pfd.have_revs)
>>> 		release_revisions(&pfd.revs);
>
> And this would just be
>
> 	release_revisions(&revs);
>
>>> to clear the memory in exactly one place.
>>=20
>> Yeah, it would work. I'd just prefer control flow that's trivial to
>> reason about over saving a couple of lines here.
>
> I think having multiple revision things that can live at different
> levels (one embedded in a custom struct, one not) is not trivial to
> reason about. If we change the "is this initialized" indicator to be
> within 'struct rev_info', then this gets simpler.

I meant: if you want to read that code through without considering the
"filter" case it's obvious that you can skip the whole "pfd.revs" part
in that case, and that it's only something to do with "filter".

> It seems to me that it is easier to track a single struct and release
> the memory in one place based on its lifespan.

I submitted a patch on top because it looked like your topic was going
to be merged to "next" soon, and I really didn't care much in this case.

But FWIW I think a much more obvious thing to do overall would be to
skip the whole "filter bust me in rev_info" refactoring part of your
series and just add a trivial list_objects_filter_copy_attach() method,
or do it inline with memcpy/memset.

I.e. to not touch the "filter" etc. callback stuff at all, still pass it
to get_object_list(). Can't 2/5 and 3/5 in your series be replaced by
this simpler and smaller change?:

	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
	index 829ca359cf9..4ce76a378c8 100644
	--- a/builtin/pack-objects.c
	+++ b/builtin/pack-objects.c
	@@ -237,8 +237,6 @@ static unsigned long cache_max_small_delta_size =3D 10=
00;
=09=20
	 static unsigned long window_memory_limit =3D 0;
=09=20
	-static struct list_objects_filter_options filter_options;
	-
	 static struct string_list uri_protocols =3D STRING_LIST_INIT_NODUP;
=09=20
	 enum missing_action {
	@@ -3714,7 +3712,8 @@ static void mark_bitmap_preferred_tips(void)
	 	}
	 }
=09=20
	-static void get_object_list(int ac, const char **av)
	+static void get_object_list(int ac, const char **av,
	+			    struct list_objects_filter_options *filter)
	 {
	 	struct rev_info revs;
	 	struct setup_revision_opt s_r_opt =3D {
	@@ -3727,7 +3726,9 @@ static void get_object_list(int ac, const char **av)
	 	repo_init_revisions(the_repository, &revs, NULL);
	 	save_commit_buffer =3D 0;
	 	setup_revisions(ac, av, &revs, &s_r_opt);
	-	list_objects_filter_copy(&revs.filter, &filter_options);
	+	/* attach our CLI --filter to rev_info's filter */
	+	memcpy(&revs.filter, filter, sizeof(*filter));
	+	memset(filter, 0, sizeof(*filter));
=09=20
	 	/* make sure shallows are read */
	 	is_repository_shallow(the_repository);
	@@ -3872,6 +3873,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
	 	int rev_list_index =3D 0;
	 	int stdin_packs =3D 0;
	 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
	+	struct list_objects_filter_options filter_options =3D { 0 };
	 	struct option pack_objects_options[] =3D {
	 		OPT_SET_INT('q', "quiet", &progress,
	 			    N_("do not show progress meter"), 0),
	@@ -4154,7 +4156,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
	 	} else if (!use_internal_rev_list) {
	 		read_object_list_from_stdin();
	 	} else {
	-		get_object_list(rp.nr, rp.v);
	+		get_object_list(rp.nr, rp.v, &filter_options);
	 	}
	 	cleanup_preferred_base();
	 	if (include_tag && nr_result)

And even most of that could be omitted by not removing the global
"static struct" since pack-objects is a one-off anyway ... :)
