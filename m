Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ADBC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352112AbiHSVD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352081AbiHSVDy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:03:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F41C931
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:03:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k9so6480552wri.0
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=pEOpm0YrmX5kgetuG/L9IYdl/r1B+kQ4jsdXYkzc5V0=;
        b=dyZzIbckiV0S0EfCOVm9fMs+OL5Mi/04ub/070IlXgV/lvnTfZem8tCvbwlSjtAQRi
         yDTjm9W7VK+91UA0Bx1HFVZYtJ0vmXqf6nAVIcg1xVnerFjnESKS6g7OQu9fAL+/AwIE
         n5670WPbS+ir4peJLRjhwbohjoL7zWyU7fk0WZ6P1Xrt5EP9L+aJT8dMr5Crm1n+MODp
         SSgcU/qIbr6oEW5vvHid+mNJdEEdHnLqmca+Si3jYhOo8InH5sE6cRYIDPBGNunCTqbw
         n72I/ecQrdb6Zvrtxy6hsXItEiF6n5tjHjJMMjYyFawAGxpArMP5GI9PweahySIa2BwY
         SwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=pEOpm0YrmX5kgetuG/L9IYdl/r1B+kQ4jsdXYkzc5V0=;
        b=NaQQkYutqRPhTV/RsS0nIVH2ODTmrne2ADeHrkyGf3vjycETcdJrJCbj+DfYxgYnz4
         PH5adO0CqqHi7WUGxByRavNQD3Ul/RJydYoETwpsJH1wVxqWycZjPb22WpcQBsv7m/nu
         Fe1WhBoTMI/yUcOTC25InAcl1iVMFwUr0aD142MpVJrdUpiO+rhd0CrodbT+AOm0GkTy
         Pof/bkW8/bLLx0ZuRcmErNHwXfpuNl9+PKa73bp+8N3r4gOnM6iHQSqC4aUTuRThBqKj
         ALX952A6uDZg6Y49ARamwMtD0ntdm/Jn1PTtI6+N7Q02gCYooZ5wh0YNJ0G6sstGN+fq
         E04A==
X-Gm-Message-State: ACgBeo019drP8kfX91SAp8vxPGpJRN8UWzg7b8N36+IZuNLWdXcvwVS+
        pKEX+Ve5wbPR/M9g/FZ87XORHr2T3uqFOg==
X-Google-Smtp-Source: AA6agR4YXLw5V72xb43eawPATvIp+r3sRZPRBH0bfTNW49PW0E4ql1XFOjmXMTwmNLJFVBf+kv/YUw==
X-Received: by 2002:a05:6000:1542:b0:220:603d:ec93 with SMTP id 2-20020a056000154200b00220603dec93mr5384156wry.73.1660943030918;
        Fri, 19 Aug 2022 14:03:50 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c511600b003a601707174sm7073142wms.33.2022.08.19.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:03:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP99h-000vPd-0M;
        Fri, 19 Aug 2022 23:03:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] annotating unused function parameters
Date:   Fri, 19 Aug 2022 22:58:08 +0200
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
 <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
 <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
Message-ID: <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Derrick Stolee wrote:

> On 8/19/2022 9:58 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Aug 19 2022, Jeff King wrote:
>>=20
>>> I've been carrying a bunch of patches (for almost 4 years now!) that get
>>> the code base compiling cleanly with -Wunused-parameter. This is a
>>> useful warning in my opinion; it found real bugs[1] when applied to the
>>> whole code base. So it would be nice to be able to turn it on all the
>>> time and get the same protection going forward.
>>> [...]
>>> And of course the most important question is: do we like this direction
>>> overall. This mass-annotation is a one-time pain. Going forward, the
>>> only work would be requiring people to annotate new functions they add
>>> (which again, is mostly going to be callbacks). IMHO it's worth it. In
>>> addition to possibly finding errors, I think the annotations serve as an
>>> extra clue for people reading the code about what the author intended.
>>=20
>> I've known you've had this out-of-tree for a while, and really like that
>> it's on the path to getting integrated.
>>=20
>> But I have a hang-up about it, which is that I though __attribute__
>> (unused) didn't work like *that*.
>>=20
>> What it means (and maybe only I find this counter-intuitive) is "trust
>> me, this is unused, but don't check!", furthermore it causes the
>> compiler to completely ignore the variable for the purposes of *all*
>> warnings, not just the unused one.
>
> That's not the reason for the attribute at all. It's supposed to say "I
> know this is unused, but I still need it to be in the parameter list for
> other reasons. Don't create a warning for this case."
>
> Interpreting it the way you are means "don't do the analysis. Just throw a
> warning." which doesn't make any sense.
>
>> I may still be missing something, but I wonder if this squashed in
>> wouldn't be much better:
>>=20=09
>> 	diff --git a/git-compat-util.h b/git-compat-util.h
>> 	index a9690126bb0..e02e2fc3f6d 100644
>> 	--- a/git-compat-util.h
>> 	+++ b/git-compat-util.h
>> 	@@ -190,9 +190,9 @@ struct strbuf;
>> 	 #define _SGI_SOURCE 1
>>=20=09=20
>> 	 #if defined(__GNUC__)
>> 	-#define UNUSED(var) UNUSED_##var __attribute__((unused))
>> 	+#define UNUSED(var) var __attribute__((deprecated ("not 'deprecated', =
but expected not to be used!")))
>> 	 #else
>> 	-#define UNUSED(var) UNUSED_##var
>> 	+#define UNUSED(var) var
>> 	 #endif
>
> Does the deprecated attribute imply unused? Or at the very least, does it
> avoid the -Wunused-parameter warnings?
>
> It might be helpful to _also_ have a deprecated annotation so we know to
> remove the UNUSED macro if a parameter starts being used again. The
> existing macro changes the variable name so we would get compiler errors
> if we started using it, but we could have a better message indicating
> exactly why things are not working.
>
> So in that sense, you are onto something. Should we use both attributes?
>
> At the very least, the warning message you recommend in the 'deprecated'
> attribute could be more direct about what we expect.
>=20=09=20
> 	 #if defined(__GNUC__)
> 	-#define UNUSED(var) UNUSED_##var __attribute__((unused))
> 	+#define UNUSED(var) var __attribute__((unused)) \
> 				 __attribute__((deprecated ("remove UNUSED macro before using")))
> 	 #else
> 	-#define UNUSED(var) UNUSED_##var
> 	+#define UNUSED(var) var
> 	 #endif
>=20=09=20
> 	 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */

Yes, I spoke too soon, sorry. We still need ((unused)). FWIW the below
on top of master and doing:

	 make bisect.o CFLAGS=3D-Wunused-parameter

Does the right thing for me, and then warns if you uncomment that "//"
commented fprintf().

The reason I was confused is that -Wunused-parameter is *not* needed
with ((deprecated)) to error if the variable is used, but it *is* needed
to hide it from -Wunused-parameter if you're trying to find the next
thing to mark as "UNUSED" (or to refactor away).

I think the below version of it also shows that you don't need to pass
the variable name to the macro. If the only reason for that was to avoid
accidental use it seems like the ((deprecated)) attribute should cover
it.

I'd prefer it if we could avoid the funny syntax, it's highlighted a bit
weirdly in my editor, and I suspect I'm not the only one, but mainly
having the extra compiler-enforced sanity checking of checking if it's
accidentally used, without renaming the variable, which seems like a bit
of a hack.

diff --git a/bisect.c b/bisect.c
index 38b3891f3a6..fd581b85a72 100644
--- a/bisect.c
+++ b/bisect.c
@@ -441,7 +441,7 @@ void find_bisection(struct commit_list **commit_list, i=
nt *reaches,
 }
=20
 static int register_ref(const char *refname, const struct object_id *oid,
-			int flags, void *cb_data)
+			int flags UNUSED, void *cb_data UNUSED)
 {
 	struct strbuf good_prefix =3D STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
@@ -1160,8 +1160,9 @@ int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
=20
-static int mark_for_removal(const char *refname, const struct object_id *o=
id,
-			    int flag, void *cb_data)
+static int mark_for_removal(const char *refname,
+			    const struct object_id *oid UNUSED,
+			    int flag UNUSED, void *cb_data)
 {
 	struct string_list *refs =3D cb_data;
 	char *ref =3D xstrfmt("refs/bisect%s", refname);
diff --git a/git-compat-util.h b/git-compat-util.h
index 36a25ae252f..7f7395fc9f7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -189,6 +189,12 @@ struct strbuf;
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
=20
+#if defined(__GNUC__)
+#define UNUSED __attribute__((unused)) __attribute__((deprecated ("marked =
with UNUSED")))
+#else
+#define UNUSED
+#endif
+
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 # if !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0600
@@ -302,7 +308,8 @@ typedef unsigned long uintptr_t;
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
 #else
-static inline const char *precompose_argv_prefix(int argc, const char **ar=
gv, const char *prefix)
+static inline const char *precompose_argv_prefix(int argc UNUSED, const ch=
ar **argv UNUSED,
+						 const char *prefix)
 {
 	return prefix;
 }
@@ -397,7 +404,8 @@ typedef uintmax_t timestamp_t;
 #endif
=20
 #ifndef platform_core_config
-static inline int noop_core_config(const char *var, const char *value, voi=
d *cb)
+static inline int noop_core_config(const char *var UNUSED, const char *val=
ue UNUSED,
+				   void *cb UNUSED)
 {
 	return 0;
 }
@@ -410,7 +418,7 @@ int lstat_cache_aware_rmdir(const char *path);
 #endif
=20
 #ifndef has_dos_drive_prefix
-static inline int git_has_dos_drive_prefix(const char *path)
+static inline int git_has_dos_drive_prefix(const char *path UNUSED)
 {
 	return 0;
 }
@@ -418,7 +426,7 @@ static inline int git_has_dos_drive_prefix(const char *=
path)
 #endif
=20
 #ifndef skip_dos_drive_prefix
-static inline int git_skip_dos_drive_prefix(char **path)
+static inline int git_skip_dos_drive_prefix(char **path UNUSED)
 {
 	return 0;
 }
@@ -490,11 +498,13 @@ static inline void extract_id_from_env(const char *en=
v, uid_t *id)
 	}
 }
=20
-static inline int is_path_owned_by_current_uid(const char *path, struct st=
rbuf *report)
+static inline int is_path_owned_by_current_uid(const char *path, struct st=
rbuf *report UNUSED)
 {
 	struct stat st;
 	uid_t euid;
=20
+	//fprintf(stderr, "%p", (void*)report);
+
 	if (lstat(path, &st))
 		return 0;
=20
diff --git a/object-store.h b/object-store.h
index 5222ee54600..218ffe73604 100644
--- a/object-store.h
+++ b/object-store.h
@@ -141,7 +141,7 @@ struct packed_git {
=20
 struct multi_pack_index;
=20
-static inline int pack_map_entry_cmp(const void *unused_cmp_data,
+static inline int pack_map_entry_cmp(const void *unused_cmp_data UNUSED,
 				     const struct hashmap_entry *entry,
 				     const struct hashmap_entry *entry2,
 				     const void *keydata)

