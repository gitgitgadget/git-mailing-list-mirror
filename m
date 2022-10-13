Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E465BC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 10:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJMKqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMKqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 06:46:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBD63204C
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 03:46:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k2so3039310ejr.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fb4u+qqfoqKFCnIHR6p/QvpB6Fm+IW1tqZNh6cJCM3Y=;
        b=Rgl5Ll7mDr2EO0udaGcZbADe9P13ep9qhdqGyXq60HYcCYmRlXXNKEw3zTXz5jMuSz
         Z/P2CDDAj8rcFctRXPLiGqABaqX2fxY4H2c0MzN+vpAVblQEDYT2N76MUWF8VF4WchrO
         z12ySNrjKnXBni50S7UYoWVsE9zipKPDpcxJJY1FS8AtC8IUhYKaxYipsoaj2PzduO0a
         ye4fAjYpMlFRsZ0Xw9Mb0Dbv5sE4nXwofRw1STsQczE813XpU6StG0ljVkdIlbju3+HN
         G/VF5QwaqjS5b+kJuzLrYJZlMyAF3jn0fysvR97WUDIt9Gi9MDk7j7//NyEr6yzLtoWW
         rOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fb4u+qqfoqKFCnIHR6p/QvpB6Fm+IW1tqZNh6cJCM3Y=;
        b=RypTGAmxEITJQK/5OxobDT0eFrEiTKjdL5sSsllDtbe3edTAP+aXgZPFlpyT4wZbXB
         Dcc4TiJyybA07M0VLpKRev3xHYhkMID9FNPWWO4BuGAKq6CSI950TDpqS4nRm3ysvEpM
         H8eo880hpy6m9F87bhbpJ3M6qSLNJa5HxBiYaUn52207UxAq6tE48vsN2aexwuzOQdlL
         M35ocLn8n00uASqYwJd8EYT60Hz6dPvHiBjgKZstFRc2gzN8tza7+/YdRNu40j97NmwB
         VWiv2yHcw1nnpYlGfBV9j+tv8JCUiBX5s1TEdS8eBS8TLN7Aqib6W8gJXanY/Ag023I9
         LPdA==
X-Gm-Message-State: ACrzQf0wHOawvA2sgh/wcYhOUT4O4puJq7iAzaLZgHAYkqAHaKtiZMga
        Z79jBtOJtVhHBWxOog0D/SQ=
X-Google-Smtp-Source: AMsMyM7REbABlpWkF/psD9gicWqrQdVRqRfg44P+0QSu6Ij/FP1eUieUoz4hxFO9BMOs8VzJDa+OzA==
X-Received: by 2002:a17:906:fd85:b0:77b:b538:6472 with SMTP id xa5-20020a170906fd8500b0077bb5386472mr25775041ejb.48.1665657980604;
        Thu, 13 Oct 2022 03:46:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bm22-20020a0564020b1600b0044f21c69608sm12898871edb.10.2022.10.13.03.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 03:46:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oivjH-004i7I-1E;
        Thu, 13 Oct 2022 12:46:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        --cc=avarab@gmail.com, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 2/2] notes.c: fixed tip when target and append note
 are both empty
Date:   Thu, 13 Oct 2022 12:23:50 +0200
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
 <20221013055654.39628-3-tenglong.tl@alibaba-inc.com>
 <221013.86wn94kqq1.gmgdl@evledraar.gmail.com>
 <c0211f35-bb26-7ca8-6f9d-a62507e55e8a@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c0211f35-bb26-7ca8-6f9d-a62507e55e8a@gmail.com>
Message-ID: <221013.86sfjsknlw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 13 2022, Phillip Wood wrote:

> On 13/10/2022 10:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Oct 13 2022, Teng Long wrote:
>>=20
>>> From: Teng Long <dyroneteng@gmail.com>
>>>
>>> When "git notes append <object>" is executed, if there is no note in
>>> the given object and the appended note is empty, the command line
>>> prompt will be as follows:
>>>
>>>       "Removing note for object <object>"
>>>
>>> Actually, this tip is not that accurate, because there is no note in
>>> the original <object>, and it also does no remove work on the notes
>>> reference, so let's fix this and give the correct tip.
>>>
>>> Signed-off-by: Teng Long <dyroneteng@gmail.com>
>>> ---
>>>   builtin/notes.c  | 13 +++++++++++--
>>>   t/t3301-notes.sh |  3 ++-
>>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/builtin/notes.c b/builtin/notes.c
>>> index 1ca0476a27..cc1e3aa2b6 100644
>>> --- a/builtin/notes.c
>>> +++ b/builtin/notes.c
>>> @@ -567,9 +567,10 @@ static int append_edit(int argc, const char **argv=
, const char *prefix)
>>>   	struct notes_tree *t;
>>>   	struct object_id object, new_note;
>>>   	const struct object_id *note;
>>> -	char *logmsg;
>>> +	char *logmsg =3D NULL;
>> Hrm, interesting that (at least my) gcc doesn't catch if we don't
>> NULL-initialize this, but -fanalyzer does (usually it's not needed for
>> such trivial cases0. Anyawy...
>
> I don't think its written to if we take the 'else if' branch added by
> this patch so we need to initialize it for the free() at the end.

Yes, sorry about not being clear. It *does* need to be uninitialized, I
was just narrating my surprise at this not being a case where my
compiler caught it when I was locally testing this.

Then I remembered this is one of those cases where clang is slightly
better at analysis, gcc without -fanalyzer says nothing, but clang by
default will note (if you remove the NULL initialization here):

	builtin/notes.c:641:13: error: variable 'logmsg' is used uninitialized whe=
never 'if' condition is true [-Werror,-Wsometimes-uninitialized]
	        } else if (!cp.buf.len) {
	                   ^~~~~~~~~~~
	builtin/notes.c:653:7: note: uninitialized use occurs here
	        free(logmsg);
	             ^~~~~~
	builtin/notes.c:641:9: note: remove the 'if' if its condition is always fa=
lse
	        } else if (!cp.buf.len) {
	               ^~~~~~~~~~~~~~~~~~
	builtin/notes.c:570:14: note: initialize the variable 'logmsg' to silence =
this warning
	        char *logmsg;
	                    ^
	                     =3D NULL

Anyway, nothing needs to be changed about the code here, sorry about the
distraction. I should have left it at something like "this NULL
initialization is needed".

>>>   	const char * const *usage;
>>>   	struct note_data d =3D { 0, 0, NULL, STRBUF_INIT };
>>> +	struct note_data cp =3D { 0, 0, NULL, STRBUF_INIT };
>> This is probably better "fixed while at it" to set both to use "{
>> .buf =3D
>> STRBUF_INIT }", rather than copying the pre-C99 pattern.
>
> We only seem to be using cp.buf.len so we can test check if the
> original note was empty so I think it would be better just to add
>
> 	int note_was_empty;
>
> `	...
>
> 	note_was_empty =3D !d.buf.len

That's a good catch, and one I didn't catch on my read-through, i.e. in
general this seems like a "was the strbuf empty?" pattern, before we
re-append to it.

But playing with it further:
=09
	diff --git a/builtin/notes.c b/builtin/notes.c
	index cc1e3aa2b6b..262bbffa375 100644
	--- a/builtin/notes.c
	+++ b/builtin/notes.c
	@@ -570,7 +570,6 @@ static int append_edit(int argc, const char **argv, co=
nst char *prefix)
	 	char *logmsg =3D NULL;
	 	const char * const *usage;
	 	struct note_data d =3D { 0, 0, NULL, STRBUF_INIT };
	-	struct note_data cp =3D { 0, 0, NULL, STRBUF_INIT };
	 	struct option options[] =3D {
	 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
	 			N_("note contents as a string"), PARSE_OPT_NONEG,
	@@ -616,8 +615,6 @@ static int append_edit(int argc, const char **argv, co=
nst char *prefix)
=09=20
	 	prepare_note_data(&object, &d, edit && note ? note : NULL);
=09=20
	-	strbuf_addbuf(&cp.buf, &d.buf);
	-
	 	if (note && !edit) {
	 		/* Append buf to previous note contents */
	 		unsigned long size;
	@@ -638,21 +635,16 @@ static int append_edit(int argc, const char **argv, =
const char *prefix)
	 			BUG("combine_notes_overwrite failed");
	 		logmsg =3D xstrfmt("Notes added by 'git notes %s'", argv[0]);
	 		commit_notes(the_repository, t, logmsg);
	-	} else if (!cp.buf.len) {
	+	} else if (!d.buf.len) {
	 		fprintf(stderr,
	 			_("Both original and appended notes are empty in %s, do nothing\n"),
	 			oid_to_hex(&object));
	 	} else {
	-		fprintf(stderr, _("Removing note for object %s\n"),
	-			oid_to_hex(&object));
	-		remove_note(t, object.hash);
	-		logmsg =3D xstrfmt("Notes removed by 'git notes %s'", argv[0]);
	-		commit_notes(the_repository, t, logmsg);
	+		BUG("this is not reachable by any test now");
	 	}
=09=20
	 	free(logmsg);
	 	free_note_data(&d);
	-	free_note_data(&cp);
	 	free_notes(t);
	 	return 0;
	 }
=09
This 2/2 makes that "else" test-unreachable, so whatever else we do here
we should start by making sure that by adding the "else if" we still
have test coverage for the "else".
