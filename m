Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADAEC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 00:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbiBXAIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243114AbiBXAIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 19:08:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275225E740
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:08:24 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so783025ejc.8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fk/cmaVQeu//SiNG0NvogWeuASMmwnfUIyvURMAE63Q=;
        b=H/4JvHjjPtKM9DIuMzAypiFjNE5T+3Zd7Ki0/xEPDLtaUfkHQ0v1w5ztE+IrBqK2rf
         fC/tsBmt3b44oj7ca1r47p1t9J9ozQCLmfaVrVPs0FA47COeK1pgTHiPWk1HfAmaRVkR
         4AkFCfa+c2nXimPmpyXdzjcVR25OaaPEAVA6tFQVwYma9xP2IDdTC0oJuchYkFoQ/W9T
         OKUXi4evbp+UJs8Ji3HW5uTulwd2AZLg5dnIH7S7g6GCIM/54l1wVbyNm5oFAXB09BHD
         KijURLMMplMH6Ippi4btdNgE3IS9nSvZgzZR7HxWEilkc3KXjsWPOqy0wgRtzazUfcn1
         Lczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fk/cmaVQeu//SiNG0NvogWeuASMmwnfUIyvURMAE63Q=;
        b=sQXw2dYs2qnsipwmyVSLEfTWBcfBPhg1ORvqXk6JHb/aCPTDawIjTCebxvMHKB8jZz
         Avk58xkP0DjOqwVESpZLTIjgyqU6GRCZUEBRDtRBKulgH39vhuKl+O9wXGy502GgoPg0
         1h1jQomuzroB8oOOeswSbK3c/iESehol7hm96Zt2eM1V9jS9zz7nEDe5q+oZT58g/PuU
         dpKQW5zQITT5JRpxkVDtBirE+CMVxXJAFofWlIsLShVgB+9Y9paN1Nee3x+KtzvtSyNt
         1KsmTf2t4QGWWcZtJ7bQRKbEeS0waPDv2uXXWqTemsk3b54Hi51NfkKQvhYHAUXWvYLz
         RXzA==
X-Gm-Message-State: AOAM5310X0+O7PikuFZpDur3/DguJN6hRxPxG1U67DmPhsZ14b04/Xko
        K+bz24rya6nHVhX7I7zIcfaL666sYBY=
X-Google-Smtp-Source: ABdhPJxNJdkIwlwUtpOtNzB6XtPWaNFA+53ZbVBXpRszHaNHbT99im0NkR9BaYkHfFFRoyWqJZuq3w==
X-Received: by 2002:a17:906:69c5:b0:6cf:d164:8b32 with SMTP id g5-20020a17090669c500b006cfd1648b32mr125818ejs.233.1645661302628;
        Wed, 23 Feb 2022 16:08:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j13sm608546edw.24.2022.02.23.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:08:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nN1gD-0007oR-JE;
        Thu, 24 Feb 2022 01:08:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] switch: mention the --detach option when dying due to
 lack of a branch
Date:   Thu, 24 Feb 2022 00:56:44 +0100
References: <20220223073125.640133-1-alexhenrie24@gmail.com>
 <xmqqwnhlp4h1.fsf@gitster.g>
 <CAMMLpeQWjs0C4VwfpzOhZvY0Tm2YTnC74tyUeBG9bBzsNA42_w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAMMLpeQWjs0C4VwfpzOhZvY0Tm2YTnC74tyUeBG9bBzsNA42_w@mail.gmail.com>
Message-ID: <220224.861qztazyi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Alex Henrie wrote:

> On Wed, Feb 23, 2022 at 4:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> > Users who are accustomed to doing `git checkout <tag>` assume that
>> > `git switch <tag>` will do the same thing. Inform them of the --detach
>> > option so they aren't left wondering why `git switch` doesn't work but
>> > `git checkout` does.
>>
>> An error message certainly would help over showing
>>
>>         fatal: a branch is expected, got tag 'abc'
>>
>> but I have to wonder why we shouldn't DWIM and detach the HEAD at
>> the commit the user wanted to.  That would also solve the issue of
>> leaving them wondering why switch is broken and checkout is not, no?
>>
>> If the advice for detached HEAD state is enabled, then the user will
>> be reminded that they are not on any branch the usual way when the
>> HEAD is detached at the named commit.  And if the advice is not
>> enabled, then they will not be helped by this new advise() message
>> we add here.
>
> Before commit 7968bef06b "switch: only allow explicit detached HEAD",
> `git switch` did not require --detach to enter a detached HEAD state.
> The justification in the commit message is worth reading, but I don't
> have an opinion on whether or not it was a change for the better.
>
>> > +     if (advice_enabled(ADVICE_DETACHED_HEAD))
>> > +             advise(_("The specified commit is not a local branch.\n"
>> > +                      "If you want to enter detached head mode, try again with the --detach option."));
>> > +
>>
>> "detached HEAD" is a state, and not a mode.
>>
>> s/enter detached head mode/detach HEAD at the commit/ perhaps.
>
> Sure. I'll send a v2 tonight.

I think another thing that needs updating here is the
Documentation/config/advise.txt.

I.e. it explicitly says this is advice we emit *after* we've switched to
a detached head, instructing you how to proceed.

But here you're adding another message guarded by that
ADVICE_DETACHED_HEAD which doesn't fit that description, but is rather
suggesting that you may want to use the --detach option.

After you use the --detach option you'll get the existing (and described
by the docs) ADVICE_DETACHED_HEAD message.

The two things we could do is to adjust the docs and use
ADVICE_DETACHED_HEAD for both, or to add a new
ADVICE_SUGGEST_DETACHED_HEAD category with a new
advice.suggestDetachedHead config.

Also, you say "doesn't work", so is this about to die() after this
advice is printed? What does the complete output look like then? Usually
we'd emit the "die" message before the advice message

*reads the surrounding code a bit*

Ah, so yes, we'd do that in that order now.

I think we'd like to instead use die_message(), followed by an optional
advise(), followed by exit(). Maybe like this?:

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d9b31bbb6d6..22cf9d6ad1b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1397,23 +1397,32 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 {
 	struct object_id oid;
 	char *to_free;
+	int code;
 
 	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
 		const char *ref = to_free;
 
-		if (skip_prefix(ref, "refs/tags/", &ref))
-			die(_("a branch is expected, got tag '%s'"), ref);
-		if (skip_prefix(ref, "refs/remotes/", &ref))
-			die(_("a branch is expected, got remote branch '%s'"), ref);
-		die(_("a branch is expected, got '%s'"), ref);
+		if (skip_prefix(ref, "refs/tags/", &ref)) {
+			code = die_message(_("a branch is expected, got tag '%s'"),
+					   ref);
+			goto out;
+		}
+		if (skip_prefix(ref, "refs/remotes/", &ref)) {
+			code = die_message(_("a branch is expected, got remote branch '%s'"),
+					   ref);
+		}
+		code = die_message(_("a branch is expected, got '%s'"), ref);
+		goto out;
 	}
-	if (branch_info->commit)
-		die(_("a branch is expected, got commit '%s'"), branch_info->name);
-	/*
-	 * This case should never happen because we already die() on
-	 * non-commit, but just in case.
-	 */
-	die(_("a branch is expected, got '%s'"), branch_info->name);
+	if (branch_info->commit) {
+		code = die_message(_("a branch is expected, got commit '%s'"),
+				   branch_info->name);
+		goto out;
+	}
+	BUG("unreachable with '%s'", branch_info->name);
+out:
+	/* advice here */
+	exit(code);
 }
 
 static void die_if_some_operation_in_progress(void)

But that's probably a lot less nasty if die_expecting_a_branch() is made
to call a helper that just does a "return die_message()" with a "return
0" fallback, and on "0" we call BUG(...).

