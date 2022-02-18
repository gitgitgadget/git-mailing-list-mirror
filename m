Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05740C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 00:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiBSASn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:18:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiBSASm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 19:18:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69D4606DA
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 16:18:24 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lw4so18471934ejb.12
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 16:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=31/eTX6eSeY9LOjQKxXxc5XdTRtQDaxGGs7ka0GjPWc=;
        b=kyVmrvMU0IiRkKJ+RbqTAbxIo2PUcM63WfnHdy3iIO+pU+ndSOy0FRFEclb9CdyxnH
         a7cx8d3ijeISp3w9gG7FsCWwrVKsC4CzhWkw2csvp7xtI0m7wAXEh4k05EWw7nW4TXAV
         143sCPoMRMQT65Cno5U6ApPoaGfeeCENhiFuaPiOy11zpv5Pd5eetiAKkiem8BWGQkCV
         SwFrUWhMOD+Xy/hbN5lr9nmKzpH4hGsod9I4citcNWvemsxzeaR9hrdiBWK1pF82KzXu
         UxCE56m+xTrGAKHkefqeiJ5JV05+DMrJQ+r9KKFEK/7tUIlQ98b+StalLC4MRnY7fJ3l
         AEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=31/eTX6eSeY9LOjQKxXxc5XdTRtQDaxGGs7ka0GjPWc=;
        b=jl0o/P0gmgUNbk81KgNxyZHtSig6G3hs8DNqbvVOZ7flKc3znyoeSiqqRolxCHngXl
         2PjCCW/ARyr+qsXxzFK18bBgXwBiESQ1rn3iV7mjbpJfeDNvqXM9TInIl2n/2ljyIfX+
         iQd5eYX3GyZozIcGRsARsP6wIt0ege4pH55QmB7cALDZtKiDqb+U0NTONt4o20VWux+b
         X4f+qwK5XNVUnrWUdexkE459dz3HZHSt2p20HBg/SVecKbeQZl/E+p9N8H8UDMkTJGvG
         ApXLQcmKFihBr/h5TCPzQD2Yf/FFF8cJ7JPiB6VbXnNCFxhemCvXYDxqEznTuX1+Wsmn
         5sVw==
X-Gm-Message-State: AOAM532IyeOOq3WTvOBnz1OCxMmaDYtsfZLniAipMfz6IjyhKBz2Xzd+
        A8J+xT9xPcQlQ9CntuLdOuA=
X-Google-Smtp-Source: ABdhPJxRcG7ob4rhGoeLGIqQwPl1UMjKXxlYaNzPyDzPNdROIdHzWQHrJ1CXt1KUDUOc3xl5k6rdPQ==
X-Received: by 2002:a17:906:d9db:b0:6ce:8bfb:53c9 with SMTP id qk27-20020a170906d9db00b006ce8bfb53c9mr8177465ejb.10.1645229902874;
        Fri, 18 Feb 2022 16:18:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l12sm3206649edt.1.2022.02.18.16.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:18:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLDS9-004Z85-IX;
        Sat, 19 Feb 2022 01:18:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Merlin (they / them) Patterson" <merlinpatt@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "Merlin (they/them)" <merlinpatt+githubgit@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] docs: update coding guidelines to be more inclusive
Date:   Sat, 19 Feb 2022 00:18:35 +0100
References: <pull.1070.git.git.1645029267415.gitgitgadget@gmail.com>
 <xmqq4k4ycvgb.fsf@gitster.g> <220217.86a6epiyii.gmgdl@evledraar.gmail.com>
 <xmqqfsog512t.fsf@gitster.g>
 <CAFZ26y3re+fJapXzLOpf73F-ECXhg2sCoBtm_=VUFy5nbN2UVQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFZ26y3re+fJapXzLOpf73F-ECXhg2sCoBtm_=VUFy5nbN2UVQ@mail.gmail.com>
Message-ID: <220219.8635kfhfoy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[You need to configure your E-Mail client to stop sending HTML E-Mail to
the Git mailing list. It's all being rejected by kernel.org. See
e.g. https://lore.kernel.org/git/pull.1070.git.git.1645029267415.gitgitgadget@gmail.com/
where only your initial posting is visible, but not your replies.

It's also good etiquette on the ML not to top-post your replies, but to
reply inline. Except perhaps when not in reply to specific points, such
as this part of my reply :)

For other ML readers who weren't directly CC'd I'm quoting your reply to
my <220217.86a6epiyii.gmgdl@evledraar.gmail.com> here in full (sent Thu,
17 Feb 2022 10:51:35 -0500
as<CAFZ26y0VPVyAjq4Fh+CQRMu=J9rYZG6PQWpHFiWRKZJFb3aAEw@mail.gmail.com>):]

On Thu, Feb 17 2022, Merlin (they / them) Patterson wrote:

> Removing "male" and "female" allows for a broader statement of "don't assume any gender and always keep it gender neutral".
> What if I change it to remove the bit about the example person altogether?
>
> * In order to ensure the documentation is inclusive, think twice before using
>
> The example given starts off with people and has he/she/they/it in it. This ties "it" to he/she/they, making it sound like "it" also refers to a person.
> I don't think the program part makes sense as part of that example anyway. How about that be separated into its own example?
>
> * --short:: Should a person want shorter output, he/she/they can...
> * --short:: Should a program want shorter output, it can...

Yes, as the person who wrote this whole thing initially I don't really
stand by it, i.e. it was edited from a throwaway comment of mine.

For what it's worth I don't really find the he/it person/program of it
ambiguous, but what do I know?:)

Aside from that referring to an "it" in the context of our documentation
*is* something we need to do. Git the program is often (usually?)
invoked by other programs, not directly by human agency.

In any case, what do you think about this instead:
	
	diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
	index c37c43186ea..2bcb748aaa3 100644
	--- a/Documentation/CodingGuidelines
	+++ b/Documentation/CodingGuidelines
	@@ -600,12 +600,6 @@ Writing Documentation:
	      --short:: Use this to emit output in the short-format.
	      --short:: You can use this to get output in the short-format.
	      --short:: A user who prefers shorter output could....
	-     --short:: Should a person and/or program want shorter output, he
	-               she/they/it can...
	-
	-    This practice often eliminates the need to involve human actors in
	-    your description, but it is a good practice regardless of the
	-    avoidance of gendered pronouns.
	 
	   - When it becomes awkward to stick to this style, prefer "you" when
	     addressing the the hypothetical user, and possibly "we" when
	@@ -619,16 +613,10 @@ Writing Documentation:
	       Use this instead of --xyz. This option might be removed in future
	       versions.
	 
	-  - If you still need to refer to an example person that is
	-    third-person singular, you may resort to "singular they" to avoid
	-    "he/she/him/her", e.g.
	-
	-      A contributor asks their upstream to pull from them.
	-
	-    Note that this sounds ungrammatical and unnatural to those who
	-    learned that "they" is only used for third-person plural, e.g.
	-    those who learn English as a second language in some parts of the
	-    world.
	+  - Referring to users as a cast of characters (Alice, Bob etc.) or in
	+    the third-person singular is too obscure to worry about for the
	+    purposes of this style guide. Search the mailing list archive for
	+    "third-person singular" for more.
	 
	  Every user-visible change should be reflected in the documentation.
	  The same general rule as for code applies -- imitate the existing
	

> As for the part about removing "those who learn English as a second language in some parts of the world.", I stand by that.
> Even native English speakers also believe that "they" is only a third person plural. That's not restricted to non-native English speakers.
> Also, it's weird to give an example for this. Either a person learned that "they" can be both singular and plural or they didn't. Whether they learned English as a second or other language
> is irrelevant.
> How does providing an example benefit anyone?

...

On Thu, Feb 17 2022, Merlin (they / them) Patterson wrote:

> "It" and "they" shouldn't be grouped together. Examples using "it" must be separated from examples using "they". This prevents confusion around which word refers to what. And it ensures that
> a person is not thought of as an "it".
>
> This is why I suggested that I could split the example so "it" clearly refers to "the program" and can't be confused as referring to a person.
>
> As for removing the example about non-native English speakers, I gave my reasoning but I'll give it again. The example doesn't help anyone. A lot of native English speakers also think "they"
> can only be plural.[...]

I think this came about because of a previous discussion that you'll
find in the list archive where some native speakers were maintaining
that "they" in this context was widely accepted usage because it had
made it into some style guides single-digit years ago.

I.e. this was a perhaps flawed attempt to say something like "this
phrasing sounds weird, but it's actually correct".

As someone who speaks at least 4 languages regularly with levels of
proficiency ranging from native to something that sound as though I'm
trying to butcher the language, I can assure you that advice like that
*is* really useful to a non-native speaker.

I.e. whatever you or anyone else thinks about this usage of "they" it
*is* relatively obscure usage of English. I'd even bet that for some
readers of this document it's the first time they've ever seen it.

So just like the pronoun "thy", it's useful to add a small explanation
that it's in fact not a typo or something.

> Explicitly calling out non-native English speakers as making this
> mistake can have an alienating effect.

I realize I'm just shouting into the ether from my little soap box at
this point, but the alienating thing to non-native speakers isn't that
we might be told that our English isn't as good as that of non-native
speakers.

It's okey, really. We know.

It's the opposite, it's that a lot of people aren't assuming that others
who who want to participate in this project might have 1/10th of their
reading comprehension and reading speed when it comes to dense technical
documentation like this.

Because if they did we might have less of the "read this before you
contribute" documentation, or more narrowlry tailor it to practical
issues contributors are likely to encounter.

Which is why I've been maintaining (and still do) that removing most of
this is the right thing to do. It's clearly something anyone maintaining
our documentation is unlikely to encounter or have to worry about, and
therefore doesn't at all belong as a hurdle we put in the way of any new
contributor in the form of documentation we advise them to read before
they submit their first patch.
