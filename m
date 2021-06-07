Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FAFC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE2561185
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhFGTtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFGTtH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 15:49:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC1C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 12:47:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ho18so17647081ejc.8
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gpMVnoMJ0MMqf8Pa+MZAXe4MygvnC+SNxdlwq+OWv0M=;
        b=nYAtpNdlyY1VqeaxyTHx8QaiinSSWwDCC6CPGHI7lAUwh1xIN/KtkJ6Su/ddxtqnsn
         Z5CpHY44BYzHWxGk2agQv0oQCE6FMyBaQ5x2VBBzVNMby9iZfxot1ts8rL25751bWD18
         a6U38Da671909jj1cvdY49pa2KpAX4SeKcKkegk0trg0j5c3LFc9zFD/05bV86AE11Z9
         vFaxtadTRhFMzA/jEZNvkV/oVGLgzAv33BJucpTnrWzSeK2FBTRPBbQJ6fn0OpBui8OV
         1yDH1BpwGLqA9w1F3p1VMmYynWwlVD+kK4hujGW9mucprQNYgT1xWnhmN8vuAll52kgW
         MwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gpMVnoMJ0MMqf8Pa+MZAXe4MygvnC+SNxdlwq+OWv0M=;
        b=pQi7QaktRV4XpiXUWvaY6BOBliIUKqrdTp5vjHM/iLchTOjKCw2FKPgSh0ud5JRpMP
         WxmN5qMsA9l+AFqlirZutWFEkESKgbg8Io1DwmLhJ65t4ut1AfmCSDbHfkf/hbXfNPfj
         03ox8QHwB4IBknHfU+SzWj+LtLFOG5Vnxh8tJj3CwSd/SR7v5h4/ioqVJipWQp7/k6HK
         Qwb8ZBJFs3ok0waJaPBEi4k9O4/EfuwP0qNL774yehpJux6T5uTI3hoVbsZPzxPJXpsM
         pfY+WJMhUBv7Yp7FoQXUd3Vrk9ynXWjydiqq9BGDvo2uOyIge9MEbZoPoB6zoX7G/qS2
         Ba9Q==
X-Gm-Message-State: AOAM533xFb/5Ab/T0a2wlWEMtIe8ZAf+eRAfNYtA3C3gXZGvU3EkAy5b
        ye7H2ul1XvQLzw/l4A2cvX0Vb0kDkXIxdA==
X-Google-Smtp-Source: ABdhPJwJ6PwhCXglKwa9jOe1Z9kl+1NiWPetWO4PGwaIZnd22sie/k2xxXlJE61xX8TGeMPB/fXFxQ==
X-Received: by 2002:a17:906:c141:: with SMTP id dp1mr19911280ejc.87.1623095233397;
        Mon, 07 Jun 2021 12:47:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm562718eds.24.2021.06.07.12.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 12:47:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Date:   Mon, 07 Jun 2021 20:31:07 +0200
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
Message-ID: <875yyp4fun.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> [...]
> If we use singular "they/them" pronouns instead of "he/him" or "she/her"
> pronouns, then we can avoid this congitive load on the reader.
>
> Using singular "they" is also incredibly efficient. Choosing a gendered
> pronoun is usually arbitrary between "he" or "she". Using constructs
> such as "he or she", "s/he", or "(s)he" are more complicated than
> singular "they".

Somewhat humorous & somewhat serious aside: Maybe it's just me, but when
I read "incredibly efficient" I was thinking more of an energy drink
filled with with nanites that would directly update my brain with the
documentation, not the minutia of how we go about wording things :)

Continuing; Snipping around a bit in your E-Mail (a sentence copied from
"[...]"  above:

> If the reader does not consider that pronoun to apply to them,
> then they can experience cognitive dissonance that removes focus from
> the information. [...]
> When choosing a gendered pronoun, that pronoun no longer applies to
> nearly half of possible readers. Even if we alternated between "he/him"
> and "she/her" perfectly evenly, we would still expect male and female
> readers to experience an incorrect pronoun half the time. However, some
> readers will not prescribe to either of these binary genders. Those
> readers hence suffer an incorrect pronoun the entire time. Singular
> "they" applies to every reader.

I'd expect most people to not actively read technical documentation and
try to personally actively ascribe themselves to prose that clearly
forms an example of something they may or may not do.

If that is how people commonly read documentation and find it
off-putting I'd expect gendered language to be the least of our
problems, since even with s/\bhe|she\b/they/g so much of what's left is
still referring to hypothetical situations most users won't want to find
themselves in.

Maybe I'm overthinking this, but per the above I'd think if this is a
problem with losing the reader that we'd need more structural solutions
to it in the common case, e.g. more guarded language that you should not
read further if you don't care about XYZ aspect of the technical feature
we're about to discuss.

> Perhaps due to similar reasons, official style guides have changed their
> stance on singuler "they" in recent years. For example, the APA style
> guide changed their official recommendation in 2019 [1]. The MLA
> handbook also references helpful ways to use singular "they" [2]. While
> not fully endorsing it, the Chicago Manual of Style has removed its
> blanket ban on singular "they" [3] (the previous recommendation was to
> only use "it" as a singular non-gendered pronoun).
>
> [1] https://apastyle.apa.org/blog/singular-they
> [2] https://style.mla.org/using-singular-they/
> [3] https://libraries.indiana.edu/chicago-manual-style-singular-pronoun-t=
hey
>
> While not all styleguides are updating their recommendations, we can
> make a choice as a project to adopt the concept because of the
> efficiencies above, as well as the benefits of increased inclusion.
>
> To futher justify singular "they" as an acceptable grammatical concept,
> I include the careful research of brian m. carlson who collected their
> thoughts on this matter [2] (lightly edited):

It seems strange to attempt to summarize the previous discussion in the
cover letter and here thoroughly, and make not even a passing mention of
the counter-argument I presented to it in [1]; which resulted in most of
the replies to that thread, and which the maintainer you're trying to
get to apply this patch seemed to agree with. More on that at the end.

> If we refer to a specific person, then using a gendered pronoun is
> appropriate. Examples within the Git codebase include:
>
> * References to real people (e.g. Linus Torvalds, "the Git maintainer").
>   Do not misgender real people. If there is any doubt to the gender of a
>   person, then use singular "they".

Sure.

> * References to fictional people with clear genders (e.g. Alice and
>   Bob).

I don't think using the Alice & Bob examples is necessarily a problem,
but while we're discussing writing inclusive technical docs I think
their use is probably a bigger problem than the pronoun issue you're
presenting here.

That's because often using those characters is an overly clever
reference to their use in crypto circles, and thus the developer often
ends up writing documentation that simply assumes that the fact that
"Eve" is the "Eavesdropper" is obvious to the reader.

Whenever I read documentation like that I end up Googling it and end up
at the "Cast of Characters" section in the relevant Wikipedia page, just
to see if I'm missing something. It doesn't make for accessible
documentation.

I think the use in Documentation/gittutorial.txt that you didn't end up
changing is a good example of something that would be better rewritten
as "you" and then referring to "bob" as some generic remote repository
instead, I haven't seen an overly clever example of Alice/Bob/Eve
etc. in git.git's docs, but maybe it's there somewhere.

> * Sample text used in test cases (e.g t3702, t6432).

It seems strange to exclude arbitrary uses of passages from Beowulf and
quoting of Plato in diff/merge tests from a commit that's otherwise
arguing that arbitrary uses of "he" or "she" is going to lose the reader.

After all we do have a need to refer to the hypothetical user in some
manner in the prose of our documentation, but those tests will pass if
we rot13 the gendered-pronoun-using relevant text, or otherwise replaced
all the input with gibberish following similar whitespace rules.

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> index e3af089ecf26..78cd399f7cf5 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -648,3 +648,8 @@ Writing Documentation:
>   inline substituted text+ instead of `monospaced literal text`, and with
>   the former, the part that should not get substituted must be
>   quoted/escaped.
> +
> + When referring to an anonymous user, use singular "they/them" pronouns
> + as opposed to choosing between "he/him" and "she/her". [...]

I do think most of the changes in patches 1-3 were an obvious
improvement and that we could really do with some general extension of
preferred prose in the "Writing Documentation" section you're
modifying.

I think advice about that should really start more generically, this
seems like losing the forest for the trees. E.g. do we write things
like:

    --force: You can use this to force the command to do XYZ

Or:

    --force: Skip sanity checks, do XYZ

I'd like to think that we'd mostly prefer the latter, and that also
nicely sidesteps the issue you're tackling here.

I think any such advice would be better off by stating that our usual
preference is to describe things in the abstract, continuing to
preferring to assume that we're talking directly at the user:

    You can use use --force to disable the safety.

As opposed to needlessly introducing more verbose and possibly gendered
prose:

    Should the user wish to disable the safety features, they can use
    the --force option.

This patch hunk also seems like it would be better worked into the first
3-4 paragraphs of "Writing Documentation" somehow, rather than tacking
it at the end. That's where we've started to discuss US v.s. UK English,
following existing conventions etc.

> [...] Do not use more complicated constructs such as "he or she" or
> "s/he".[...]

I note that one thing you didn't tackle at all in [1] & downthread is
the problem we have that's really not present in the style manuals
you're referring to.

That is, once we've done with avoiding verbosity per the above &
preferring "you" over anything else we're usually left referring to a
generic concept of an OS user.

Such a thing does not have any gender, and need not be tied to any
particular life form. It's usually something authors of manuals of style
don't need to consider outside of sci-fi novels.

I think we'd do well to prefer imitating how e.g. C library docs usually
deal with that over any MOS, which is to just say something like "a user
with permission xyz can...." or whatever. It's just weird to think of
say a git command run by my sshd or www-data user as a "they", just as I
wouldn't use "he" or "she".

> [...] This recommendation also applies to code comments and commit
> messages.

Since you were seeking ACKs in the CL this is overall a NACK from
me. For reasons noted in the thread starting at [1] so I won't repeat
most of that here; but briefly: I do think extending this to commit
messages in particular is over-reaching.

Our installed documentation is one thing, but commit messages are much
closer to the prose people are personally comfortable with, every hurdle
we put to accepting patches, particularly ones that seem arbitrary and
without good technical reasons are also something that harms inclusion &
project velocity.

This whole thing also started in reply to one patch submitted by L=C3=A9na=
=C3=AFc
Huard (a non-native speaker of English), which he promptly re-rolled
after this whole pronoun thread started. Grepping around with:

    git log --grep=3D'\b(he|she)\b' -i origin/master

And mentally grepping out changes referring to specific people (just
generic examples), I see one change in 2021, then you've got to go back
to 2017 to find the next one (I just skimmed this, maybe I missed some),
you very quickly get to 2014.

I think I'd feel even stronger that we didn't need this in transitory
commit message examples even if it were more common, per the argument in
[1].

But given how rare it is anyway seeking to enforce a policy on commit
messages just seems like an over-reaction to a specific recent
contribution.

In summary: My "NACK" is mostly on the "and commit messages". Just
because *generally* we should be less nitpicky about personal preferred
prose there, I'd feel the same way about insisting on US English only or
whatever. We should be forgiving in what we accept there.

Installed docs are another matter entirely, I'm very much in favor of
having some extensions to the existing style guide there. I do think as
argued above we should start more generically, and it's not just
bikeshedding. As argued above I think we should mostly be recommending
different prose entirely, as apposed to now actively recommending "they"
(which if you discuss e.g. "a user" mostly won't be needed).

1. https://lore.kernel.org/git/87wnrooa17.fsf@evledraar.gmail.com/
