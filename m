Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86677C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 20:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiFAUms (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiFAUml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 16:42:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4525291
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 13:24:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so3820428wrg.12
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Q6ZGcC3L5OivyQub6J0aDkP+3Bqbx1WHGWtWSB/PGZI=;
        b=XGA/oY91sNNqtF4q72hRX5MY9joUhOZYTOGMSGmfNXutN58GB0co+6Z4RtGZUHaGYC
         H1WL2EoYzhO4Nj3R5P63new8uDok0yuq1PrpABZXzelaa6q2MptRepTtm+irURWrRg1Y
         L1eOnaBU8IF72vyrXLDqen5Kl4KFO+u/psC0vnrri5YciimIBHvNNtpt1rjcrOHM+oCa
         kgKmdOYrjf8azEKNr251WH4SPKWVEBi4xZEEM/MW44OU1RWaO3Gn6DjSlB7byOxPDeA4
         BU1Dps3nunKSgXUjt2rNilB4mqXQ4Sth6AcltBdKoyPklIzevZp10/k8c8WoWma1ZmyZ
         xlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Q6ZGcC3L5OivyQub6J0aDkP+3Bqbx1WHGWtWSB/PGZI=;
        b=sjqR47JFg4nLwFXwL2rHGhDxJ3oI20VPDYXDfY4cFg+/z3x7HxntFMyiezpRoNgI2P
         +78glK0qDC8KL5U15rGiZI/5zvuZoqOkcZtDa7ymTtDko3Y2F2kDRW0YMYKSZsJpf/at
         oJ+vWxL8mYd4k9h54YURA5P5P+UZfKlGAebcWpM+JvlWDiMosGRHFP9w0lfLUuujRuQH
         58IMF63UyfV0i4WAu6O2uI32D1vFMCxBZQEGbd+4gem8KAvpEsCVnLK4bjNKXIyP0zOR
         1ce55ny+tyIotK43c8ZGi8xNWshpi6HgFP+666XNSiuGxseD0tUuF8xv7D7+2rzfscQ6
         rx5g==
X-Gm-Message-State: AOAM5336jbtVEEtNCzu4Ui2ii2q8l2y3ezAU95X5q+Q1IP7GebT5uJL0
        yJeOKl8gyx2Zn5EJ7d7iKk8w1Z2xOqQ=
X-Google-Smtp-Source: ABdhPJwqKWwnDWaG0NV9JhOKMlrBE+RpJe1xY3YCExmG5UTq1CV2NDeXicCSA6B8wDGE+E800/ubjA==
X-Received: by 2002:a17:906:53ca:b0:6fe:ae32:e01e with SMTP id p10-20020a17090653ca00b006feae32e01emr1038318ejo.455.1654112998506;
        Wed, 01 Jun 2022 12:49:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p3-20020aa7c4c3000000b0042db87b5ff4sm1424133edr.88.2022.06.01.12.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 12:49:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwULs-001Joz-Um;
        Wed, 01 Jun 2022 21:49:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
Subject: Re: [PATCH v3 2/2] usage: add warn_once() helper for repeated warnings
Date:   Wed, 01 Jun 2022 21:33:08 +0200
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
 <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
 <220601.868rqg1qo2.gmgdl@evledraar.gmail.com>
 <8f96563b-87c5-2a8c-fe35-19fd0cc3c7d2@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8f96563b-87c5-2a8c-fe35-19fd0cc3c7d2@github.com>
Message-ID: <220601.86r148yxi3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 01 2022, Derrick Stolee wrote:

> On 6/1/2022 8:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:>=20
>> On Wed, Jun 01 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
>>>
>>> The previous change added a warning when valid_remote() detects
>>> credentials in the URL. Since remotes are validated multiple times per
>>> process, this causes multiple warnings to print.
>>=20
>> Why are we validating remotes multiple times per process? Can't we just
>> do it once?
>>=20
>> Is this a case of two callers going through the whole machinery and not
>> being aware of one another?
>>=20
>> Perhaps it's a pain to deal with that in this case, but it would be
>> better to note why here than taking it as a given.
>
> We could certainly investigate this more, but it seems like a more
> problematic approach than the one taken here. We could add a "is_valid"
> bit to struct remote, but then could some code path modify that struct
> after it was validated?

I tested this a bit and I think this alternate approach is simpler, and
it passes your tests:
=09
	diff --git a/remote.c b/remote.c
	index faa2f834635..56ce2c83022 100644
	--- a/remote.c
	+++ b/remote.c
	@@ -60,7 +60,7 @@ static void check_if_creds_in_url(const char *url)
	 		      "<redacted>", 10);
=09=20
	 	if (!strcmp("warn", value))
	-		warn_once(_("URL '%s' uses plaintext credentials"), redacted.buf);
	+		warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
	 	if (!strcmp("die", value))
	 		die(_("URL '%s' uses plaintext credentials"), redacted.buf);
=09=20
	@@ -69,12 +69,17 @@ static void check_if_creds_in_url(const char *url)
=09=20
	 static int valid_remote(const struct remote *remote)
	 {
	-	for (int i =3D 0; i < remote->url_nr; i++)
	-		check_if_creds_in_url(remote->url[i]);
	-
	 	return (!!remote->url) || (!!remote->foreign_vcs);
	 }
=09=20
	+static void valid_remote_at_end(const struct remote *remote)
	+{
	+	int i;
	+
	+	for (i =3D 0; i < remote->url_nr; i++)
	+		check_if_creds_in_url(remote->url[i]);
	+}
	+
	 static const char *alias_url(const char *url, struct rewrites *r)
	 {
	 	int i, j;
	@@ -687,6 +692,7 @@ remotes_remote_get_1(struct remote_state *remote_state=
, const char *name,
	 		add_url_alias(remote_state, ret, name);
	 	if (!valid_remote(ret))
	 		return NULL;
	+	valid_remote_at_end(ret);
	 	return ret;
	 }

I.e. we already have one spot where we get the full remote config, you
were just hooking into valid_remote() which we call N times while doing
that, let's just call it at the end.

Aside from general de-duplication APIs that to me seems like a more
sensible approach here, i.e. surely we should be getting the remote
config once, let's stick such a validation loop in that place.

And it seems we do, the stack is e.g.:
=09
	(gdb) bt
	#0  warn_once (warn=3D0x79f1f3 "URL '%s' uses plaintext credentials") at u=
sage.c:297
	#1  0x0000000000688a98 in check_if_creds_in_url (url=3D0x8677a0 "https://u=
sername:password@localhost") at remote.c:63
	#2  0x0000000000688858 in valid_remote_at_end (remote=3D0x872a40) at remot=
e.c:80
	#3  0x0000000000688397 in remotes_remote_get_1 (remote_state=3D0x85ca00, n=
ame=3D0x861f10 "origin", get_default=3D0x681d00 <remotes_remote_for_branch>=
) at remote.c:695
	#4  0x0000000000681fd7 in remotes_remote_get (remote_state=3D0x85ca00, nam=
e=3D0x861f10 "origin") at remote.c:702
	#5  0x0000000000682071 in remote_get (name=3D0x861f10 "origin") at remote.=
c:709
	#6  0x0000000000433b05 in cmd_clone (argc=3D2, argv=3D0x7fffffffd028, pref=
ix=3D0x0) at builtin/clone.c:1146
	#7  0x0000000000407d6b in run_builtin (p=3D0x8259f8 <commands+504>, argc=
=3D3, argv=3D0x7fffffffd028) at git.c:466
	#8  0x0000000000406802 in handle_builtin (argc=3D3, argv=3D0x7fffffffd028)=
 at git.c:720
	#9  0x0000000000407746 in run_argv (argcp=3D0x7fffffffcecc, argv=3D0x7ffff=
fffcec0) at git.c:787
	#10 0x00000000004065bb in cmd_main (argc=3D3, argv=3D0x7fffffffd028) at gi=
t.c:920
	#11 0x000000000051279a in main (argc=3D7, argv=3D0x7fffffffd008) at common=
-main.c:56

You put the validation in a function we called N times in
remotes_remote_get_1(), but if we just put it once in
remotes_remote_get_1()....

>>> To avoid these kinds of repeated, advisory warnings, create a new
>>> warn_once() helper that behaves the same as warning(), but only after
>>> formatting the output string and adding it to a strset. If that addition
>>> signals that the string already exists in the strset, then do not print
>>> the warning.
>>=20
>> This feels quite iffy given the low-level API & the rest of it aiming to
>> be thread-safe, see 2d3c02f5db6 (die(): stop hiding errors due to
>> overzealous recursion guard, 2017-06-21) for such a case.
>
> It makes sense to keep the low-level library as thread-safe as possible.
>
> Would it be enough to document this particular caller as not thread-safe?

See above, but I'd think we really should consider alternatives before
leaving such landmines in place.

I.e. this is called by remote.c, which is common library code itself,
someone implementing threads somewhere isn't going to be thinking about
or reading caveats about libraries remote.c itself uses unless they're
quite lucky...

>>> In the case of the credentials in a URL, the existing test demonstrates
>>> this per-process limitation: 'git clone' runs 'git-remote-curl' as a
>>> child process, giving two messages. This is an improvement over the
>>> previous six messages.
>>=20
>> If we know about this limitation and we're going to be checking the same
>> URLs why not do slightly better and pass down a "don't warn please" to
>> the sub-process?>> Or do we think it might warn about *different* URLs, =
aren't these always
>> the same (i.e. we read the full config)?
>
> While this example of 'git clone' to 'git-remote-curl' will not use a
> different URL, I can imagine other child process connections that could
> expose a different URL. Having a blanket statement "don't emit these
> warnings" seems unlikely to be helpful for those cases.

Yes, I can imagine we might want to do that, but until we find such an
API user it seems much simpler to warn in the "primary",
i.e. clone/fetch & not the helper process.

Unless there's cases I'm missing where the "primary" is aware of the URL
and the others aren't (and even then we could just do this the other way
around, no?)

Also isn't such a warning behavior unnecessarily verbose, i.e. does this
(I haven't checked in detail) warn about any such bad URL in config
anywhere, not just the one you're actually using at the moment, or at
least the one for your current remote?

In that case (if we end up having trouble with this) perhaps just
warning about the URL we use would be Good Enough and simpler.

>> If you used advice instead of a warning you'd get a config key to pass
>> for free to disable it, and that might be a better thing to do in any
>> case (i.e. a better fit for this case). But we could also just check
>> getenv("GIT_URL_REDACTED_WARNING") or whatever, which seems easy
>> enough...
>
> To make the environment variable work properly, we would need to pass a
> list of URLs in the variable that could seed the strset, to avoid dropping
> warnings for new cases as mentioned earlier.

I think a much simpler thing to do is to just set a variable in clone.c
and fetch.c and have those emit this, and otherwise stay quiet.

The reason you have duplication now is because clone is calling a remote
helper.

>>> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
>>> index cba3553b7c4..6ae3eec9eb6 100755
>>> --- a/t/t5601-clone.sh
>>> +++ b/t/t5601-clone.sh
>>> @@ -75,7 +75,10 @@ test_expect_success 'clone warns or fails when using=
 username:password' '
>>>  	test_must_fail git -c fetch.credentialsInUrl=3Dallow clone https://us=
ername:password@localhost attempt1 2>err &&
>>>  	! grep "URL '\''https://username:<redacted>@localhost'\'' uses plaint=
ext credentials" err &&
>>>  	test_must_fail git -c fetch.credentialsInUrl=3Dwarn clone https://use=
rname:password@localhost attempt1 2>err &&
>>> -	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses=
 plaintext credentials" err &&
>>> +	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses=
 plaintext credentials" err >warnings &&
>>> +	# The warning is printed twice, for the two processes:
>>> +	# "git clone" and "git-remote-curl".
>>> +	test_line_count =3D 2 warnings &&
>>>  	test_must_fail git -c fetch.credentialsInUrl=3Ddie clone https://user=
name:password@localhost attempt2 2>err &&
>>>  	grep "fatal: URL '\''https://username:<redacted>@localhost'\'' uses p=
laintext credentials" err

Speaking of which, we really should test this "we expect N warning(s)"
for both fetch & clone, shouldn't we? Ditto push.

>>>  '
>>=20
>> Hrm, between 1/2 and this I think this is a good example of a "just use
>> test_cmp" caveat.
>>=20
>> I.e. reading 1/2 it's snuck past us that there's this existing caveat in
>> the warning being added, i.e. that we should really warn 1 times, but
>> are doing in N times, but as we use ad-hoc "grep" instead of
>> test_cmp-ing the full output that's not obvious.
>>=20
>> I think this would be much more obvious as:
>>=20
>> 	warning=3D"<your warning msg>" &&
>> 	cat >expect <<-EOF &&
>> 	$warning
>>         $warning
>> 	EOF
>
> There are other warnings coming over stderr, including the "Cloning
> into..." message and the resulting "fatal:" message because that URL
> doesn't actually exist. I chose to decouple this test to the exact
> phrasing of those messages.

FWIW:

	grep ^warning: >warnings &&
	test_cmp ...

Would take care of that.

>> But even better (and per the above, I'm not convinced about the
>> direction, but leaving that aside): Here we have a choice between having
>> 1/2 and 2/2 in that order and having 2/2 add a new API that has its
>> first user right away, but at the cost of fixing a bug we just
>> introduced in 1/2.
>>=20
>> I think even if we can't find another API user for this proposed usage.c
>> addition, just adding it without a user & adding what's now 1/2 as the
>> 2nd commit would be preferrable. Then we're not doing a "oops, bug fix"
>> while we're at it.
>
> I wouldn't call this a "oops, bug fix" but instead "let's improve what was
> working, but noisy." This also gives us the opportunity to see the code in
> usage.c get tested immediately as it is introduced, which is an important
> property to keep in mind when organizing a patch series.

*nod*, just a thought.

>>> +static struct strset prev_warnings =3D STRSET_INIT;
>>> +
>>> +void warn_once(const char *warn, ...)
>>> +{
>>=20
>> If we do end up keeping this (per the above I'm thinking while it's just
>> this caller it should probably own this problem):
>>=20
>> I have a local change to clean up this warn v.s. warning inconsistency
>> in usage.c, but now it's all in internal code.
>>=20
>> But let's not add to it by adding a warn_once(), it should be called
>> warning_once().
>
> Sure. The phrase "warn once" is a valid sentence, while "warning once" is
> not, but I can see some benefit to having consistent naming here.
>
> If the "warning()" method was not already present so much throughout the
> codebase, then I would advocate that "warn()" is a better verb form. This
> would be similar to "die()" and even "error()" could be interpreted as a
> verb. However, that would be too large of a change to be worthwhile.

Yeah I'd also prefer warn() myself, but since we have warning() and
warning_errno() consistency is better...

>> We're also missing an "errno" variant, which might be fine for now,
>> ditto variants for the other non-fatal functions (error &
>> die_message). That might be OK for now, but probably worth noting.
>
> Noted.
>
>>> +void warn_once(const char *warn, ...)
>>> +{
>>> +	char buf[1024];
>>> +	va_list params;
>>> +	va_start(params, warn);
>>> +
>>> +	if (vsnprintf(buf, sizeof(buf), warn, params) >=3D 0) {
>>=20
>> It doesn't matter for the end result, but let's compare with "< 0" like
>> the other vsnprintf() caller in the file.
>
> Except that we do something after this block in both cases, so the
> condition needs to be swapped or else duplicate code.

*nod*, just a thought while skimming it.

>> And how is this unlike that vsnprintf() in not needing the same error
>> handling vreportf() does here:
>>=20
>> 	*p =3D '\0'; /* vsnprintf() failed, clip at prefix */
>>=20
>> Seems like either a bug, or that other code being something we should be
>> dropping.
>
> No, because the params are passed to warn_routine() in the section of code
> you cropped out:
>
> +	va_start(params, warn);
> +	warn_routine(warn, params);
> +	va_end(params);
>
> That warn_routine does the "clip at prefix" fix. if we have a failure in
> vsnprintf() here, then we are skipping the "only once" check and going
> straight to that logic.

Ah, makes sense. I missed that.

>>> +		if (!strset_add(&prev_warnings, buf)) {
>>=20
>> More on the general API usability front: E.g. builtin/pack-objects.c
>> seems like it could make use of thing like this in two places.
>>=20
>> But the API you've added here would only be usable for 1/2, i.e. you
>> format and de-dup on the full warning, whereas at least 1/2 of those
>> callers wants to de-dup on the un-formatted string (grep for 'static int
>> warned').
>>=20
>> Which (and I'm sounding like a broken record:) is another thing that me
>> wonder if the general API is premature, i.e. it's a red flag that we
>> have existing code that could benefit from it, if not for an arbitrary
>> limitation, in this case fixing the limitation would mean the churn of
>> either adding a new function, or a new parameter to all callers. I.e. a
>> "int dedup_on_args" or similar.
>
> You are advocating that since there is one example of something that
> doesn't fit this exact scenario, then we shouldn't move forward on
> something that _does_ have immediate use (and potential use in other
> places). This seem unnecessarily pedantic.

I didn't mean to be pedantic, sorry.

My thinking was more along the lines that I've seen roughly this pattern
in a few other places, and a proposed new library utility for generic
use is both more convincing, and tends to have bugs shook out of it if
we go the extra mile to convert existing API users.

Anyway, per the above I think this one is more easily handled by its
caller by just moving the check up one function call...

> This specific method is a good foundation for possibly extending it if
> there is value in doing so.

>>> +			va_end(params);
>>> +			return;
>>> +		}
>>> +	}
>>> +	va_end(params);
>>> +
>>> +	va_start(params, warn);
>>=20
>> I'm rusty on the varargs API (and haven't tested) but didn't we need
>> va_copy() if we're iterating twice, or was that just if we're passing it
>> to another function and using it ourselves...
>
> Well, outside of the fact that this function is tested and it works,
> the documentation says this about the 'params' argument (named 'ap'
> in the function prototype):
>
>   If ap has already been passed as first argument to a previous call to
>   va_start or va_copy, it shall be passed to va_end before calling this
>   function.
>
> So, va_end(params) makes it safe to call va_start(params, warn) again.

Yes, thanks. This was just from digging around in now
obviously-incorrect wetware :)
