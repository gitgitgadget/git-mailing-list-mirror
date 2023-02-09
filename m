Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EBBC05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 10:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBIK6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 05:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjBIK6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 05:58:13 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF25DC10
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 02:57:36 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jg8so5143943ejc.6
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 02:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fjiLOSD8W7pvHJPzLIPuvrJmBLaqO2ZaqGzlQx8tOVw=;
        b=GBohqKRauSkgRHTJMo7s2ABbA7dxrZt0uZ/v7gheo/IZo4Y/Y6pQEGDW6rtcQ7n5mS
         VHry5qaXri3bPieEGqZ5B0S6gcTsIYMpdE2tqJDtcFqZUzdkZZ4pR6JDLe8906VEtkz5
         mq9/Jc4D7w5eqkwqXLiXD4Gui+5foUr1Fcw37SwYRMiPZdfNOwEqdm0KfQLoMYFTkuK7
         HdBtxzIeIFyCxFjVn+InaIto/cVA9yn+lvzPkI+DrhtqIa+csQ/kJMCA7IGAw3fYCIAK
         YQR+CQkn7FXsfDjcVW1GPQWNp51w2E16/Ae0YLK1kMKSiOArIGoIbqC0cWUz5sWfeG50
         rRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjiLOSD8W7pvHJPzLIPuvrJmBLaqO2ZaqGzlQx8tOVw=;
        b=khEUjrN7J6rS3yfYxw6iSU3rDz3JWOlmJ7Pt0t8FsBqCwdPzMK7MsNHF25N2vre7q7
         vXfJgaiiZNV9aPGAKPH8b6BWv4EIeaOQDHyCTBAhsxVidBoEUf4YL89q/yIKb3H66JXC
         gwfE7rJ3b8hrvmimR41TEZmIwf3P5imdYMiRy+jmLz0ecmJgX/JYerngZJAtun3uT6ut
         ZJvVAMqbio4Cwe+meOCMlwAs+fRvfBcggtrdxoyvLFbdJmniaqFeLNalYlt7+BfyOb/X
         n3Q/7og3udw6rfdbRgCNz2czFNkMb88jJ8yIxUvrhAHL1WnuErdkW6h/CQhDQrYde+Dy
         9sPQ==
X-Gm-Message-State: AO0yUKVpkVoXKZKc7xt/L32zbuwqf20K6uqrLq9Am72at6V8G6y8LYCy
        rpfM+MK70sAQi53bsZzyovPCg6GEMtY1LBqB
X-Google-Smtp-Source: AK7set9a8DvwDL4p7bJzOjq/yqod8f68lewnBqAgK7HpbfBy17xW74KYqIuifoYY21Q2A5FF09CpWg==
X-Received: by 2002:a17:907:c683:b0:887:d0e6:fa28 with SMTP id ue3-20020a170907c68300b00887d0e6fa28mr12628020ejc.1.1675940248738;
        Thu, 09 Feb 2023 02:57:28 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709063a5700b0087bcda2b07bsm696167ejf.202.2023.02.09.02.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:57:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQ4cJ-001iQF-2Q;
        Thu, 09 Feb 2023 11:57:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai <johncai86@gmail.com>, phillip.wood@dunelm.org.uk,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: "bad" diffs (was: [PATCH 2/2] diff: teach diff to read gitattribute
 diff-algorithm)
Date:   Thu, 09 Feb 2023 11:31:03 +0100
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <19f6b40b-d8e8-e86c-5a9a-b35f42909118@dunelm.org.uk>
 <7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gmail.com>
 <CABPp-BGhuTyq_hrpMc+Ky3yt1UgO7DcAsgcYH15FK--QLdCsQw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CABPp-BGhuTyq_hrpMc+Ky3yt1UgO7DcAsgcYH15FK--QLdCsQw@mail.gmail.com>
Message-ID: <230209.868rh7xg14.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, Elijah Newren wrote:

> [...] I
> think "myers" is default for historical reasons and histogram is
> better not just for special Salesforce xml files, but code files too.
> The output makes more sense to users.  So much so that even though my
> simple testing suggested it had a 2% performance penalty compared to
> myers, I forced ort to use it[1] even though I designed  everything
> else in that algorithm around eking out maximum performance.  Others
> who have tested the diff algorithms have also found histogram has very
> similar performance to myers, and oftentimes even beats it[2][3].
> Also, worries about invalidating rerere caches[4] was real, but we
> already paid that price when we switched to ort.

FWIW as someone who went through that one-time pain for my many git.git
topics it wasn't even a price, it was paying me!

Maybe it's just confirmation bias, or looking at the conflicts with
fresh eyes, but I found I mis-solved some of them seemingly because the
output from the old conflicts was so confusing, but much better with
"ort".

> And if performance
> is still a worry, [3] gives me reason to believe we can make our
> histogram implementation faster.  Finally, for the period of time when
> Palantir was letting me make an internal git distribution (mostly for
> testing ort), I also carried a patch that changed the default diff
> algorithm to histogram (not just for ort, but for diff/log/etc. as
> well).  Never had any complaints from the users from it.  Perhaps you
> could do the same in your local version of git used by gitaly?

I think that might be worth considering for GitLab, John? Although the
bias has definitely been to go with vanilla git semantics, but it sounds
like you might be in favor of endorsing a patch to change the default,
so if that happens to solve the problem...

> I also think the user request got converted to a particular
> solution without looking at the wider problem space:  The idea seemed
> to assume "myers" is default for a good reason, and thus asked for an
> option to use something else.  I'm not sure the assumption is valid;=20

Just on the "wider problem", I've also looked at a lot of "bad diffs"
and there's interesting cases where histogram does equally bad as the
others *from most user's POV*, but from a "let's make a small diff" for
a computer it's perfect.

I've seen this most commonly with repetative file formats, e.g JSON-like
ones are a good example. You've probably looked at this exact thing N
times, but in case it's useful consider:
=09
	$ cat a
	{
	        thing =3D> 'foo',
	        a =3D> 'b',
	},
	{
	        c =3D> 'd',
	        thing =3D> 'bar',
	}
	$ cat b
	{
	        thing =3D> 'foo',
	        a =3D> 'b',
	},
	{
	        c =3D> 'd',
	},
	{
	        e =3D> 'f',
	        thing =3D> 'bar',
	}

Here all of our diff algorithms generate this equally terrible diff, or
a great diff, depending on your POV :):
=09
	diff --git a/a b/b
	index 186017c1f38..5afadde1800 100644
	--- a/a
	+++ b/b
	@@ -4,5 +4,8 @@
	 },
	 {
	        c =3D> 'd',
	+},
	+{
	+       e =3D> 'f',
	        thing =3D> 'bar',
	 }

The problem here is that from the user's POV they didn't add a closing
bracket, comma, open bracket etc. They added a whole new copy/pasted
block, and then modified a key-value in the subsequent one.

But the diff engine doesn't know about any of that, and will "helpfully"
proceed to "steal" parts of the previous block.

All of the cases where users have asked me (in person) about some bad
diffs have pretty much come down to this sort of thing.

In those cases one of the algorithms sometimes *happened* to find a
"better" diff, but in my experience it's been a
wrong-clock-is-right-twice-a-day sort of thing.

I've wondered if we couldn't have some much more stupid but effective
solution to these common cases. All of the ones I remember could
basically be expressed as a hypothetical:

	[diff "c"]
        balanceBrackets =3D true

Where we'd try as hard as we could not to produce diffs that had
un-balanced brackets. I.e. in this case (I manually produced this by
converting the brackets[1] to []'s, then changing them back:
=09
	diff --git a/a b/b
	index 186017c1f38..05cdd03bfa4 100644
	--- a/a
	+++ b/b
	@@ -2,7 +2,10 @@
	        thing =3D> 'foo',
	        a =3D> 'b',
	 },
	+{
	+       x =3D> 'y',
	+},
	 {
	-       c =3D> 'd',
	+       c =3D> 'f',
	        thing =3D> 'bar',
	 }

That's a much worse diff to a computer (now 11 lines, v.s. 8 lines
before), but I'd think to most users that's *much* more understandable,
just by knowing just a bit about the language (although I'd argue we
could go as far as assuming this in general, with how common balanced
brackets[1] are across languages).

P.S.: Funny story: at <pastjob> I once helped a user who'd been
      struggling for hours to turn their already working change into
      something that made more sense with "git diff".

      We eventually managed to come up with something that looked
      "right", I can't remember how, probably some mixture of -U<n>,
      diff algorithm etc.

      Their next question was "Ok, so how do I commit this?", referring
      to "this particular version of the diff".

      Which, having already spent more time than I'd like to admit in
      trying to "help" them was a good reminder to first ask what
      problem we're trying to solve :)

1. By "balanced bracket" I'm referring not just to "{}", but what's
   considered a "mirrored" character in Unicode. I.e. not just ()[]{}<>
   etc., but also =E2=88=88=E2=88=8B and the like (see
   e.g. https://www.compart.com/en/unicode/U+2208)

   For better or worse the Perl 6 language has this as part of its
   grammar, see e.g.:
   https://andrewshitov.com/2018/01/23/embedded-comment-delimiters-in-perl-=
6/
