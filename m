Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92955C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFF961039
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbhJ0S4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhJ0S4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:56:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAABC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:54:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q16so6371867ljg.3
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=R/kbmzHckeyINS2c+zFyiG79mJio3XwGjtwHM7ET0BM=;
        b=JLHw/3zdUPkFPC/zUVcbMNJtvAP8Vn7hlxNCO0scUCA0FmBEyi8VfxHsMJecsanPyN
         z6/G4+b5nnXtlaYUwdAS1WcBn/e0XQud8JVZgEuP3GvhuNrAtsav42ICzt/hnum/CA4X
         +Q2ziOvlC66yFV61poMlnU59Y0yZ5o3ibU7QPUZ+3kjj3I1f/S5ni7q4V26j0glFFiI5
         rFSEEHzmqu0hFmK2hpXdYvV9TdU/jLX8HANH/D6Roq4fwpNibD0J9dU4/3G/qFYJSkvq
         uzxABLW5ZJgNEg/kBandrR6UDB0FGtCKKGI9PDjJfNK+R25O9vf/lnx7KxfDnaFa3J4v
         83Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=R/kbmzHckeyINS2c+zFyiG79mJio3XwGjtwHM7ET0BM=;
        b=MfzFNMM9qUYBRofdxO6Hc8MvgQx+eLhXeiWMcqUP5v8PgjCYccBfLO3TXidZ6gC0CH
         bqYQfpo70Z4EhLPZW7P4dEDPNBvRhZX7kXDnHhz4Q6waz8S8Gc1jgGvVfvkDV7NyUBca
         oBrD50oTh1abPZyBSW9XD/XGYbDsGIqDSuJFtyKmt84hj01oRqfGUV3BWuh7ncGfNW3l
         GjqRVobzXglD15c1xJ8SldCeV0d5+TAnjSnusudHowQhd4WqvYgzalXx5XvEFU0G6qPd
         p66SSTDZvXO1FeNC5Fz5rz4lqufr+iq1orPlmbxtScog9/984wrkYboYvwhZKaDVZj2u
         zkzg==
X-Gm-Message-State: AOAM532x0zEWcWpb4yOwqqkK4h3qvN45luCFqWRexFVU8V0Zi15IyDc2
        vKx1Pl1speHOaVmeAh9jPAA=
X-Google-Smtp-Source: ABdhPJwVWSZaP2Pejlu8qernmZGfezpVxuCMinxiESDAYYO8zhOIRnwX1lbgTVE3DsQ+/H20KypjiQ==
X-Received: by 2002:a2e:894d:: with SMTP id b13mr16668297ljk.71.1635360852244;
        Wed, 27 Oct 2021 11:54:12 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i6sm74411lfr.163.2021.10.27.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:54:11 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: changing the experimental 'git switch'
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
        <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
        <87h7d5yrxy.fsf@osv.gnss.ru>
        <211026.86sfwo20kr.gmgdl@evledraar.gmail.com>
Date:   Wed, 27 Oct 2021 21:54:10 +0300
In-Reply-To: <211026.86sfwo20kr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 26 Oct 2021 00:23:29 +0200")
Message-ID: <871r469u3x.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, Oct 25 2021, Sergey Organov wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>> [...]
>>
>>> I really don't know, but I do think that the most viable path to a
>>> better UX for git is to consider its UX more holistically.
>>>
>>> To the extent that our UX is a mess I think it's mainly because we've
>>> ended up with an accumulation of behavior that made sense in isolation
>>> at the time, but which when combined presents bad or inconsistent UX to
>>> the user.
>>
>> Yep. Moreover, this practice of "making sense" being the primary
>> reasoning factor doesn't work very well even in isolation, for single
>> Git sub-commands. As there is no defined underlying UI model, or rules,
>> or even clear guidelines of how to properly design command-line options,
>> multiple authors, all having their own sense and having no common ground
>> to base their decisions on, inevitably produce some spaghetti UI.
>
> Yes we're definitely lacking on the documentation front here at least,
> but I do think we have quite a bit of consistency in the form of
> parse_options() users....

Yes, parse_potions() is definitely a good step in the right direction.
It's not the magic pill though, as even if it gives all the tools for
proper options parsing and design, it still can't prevent all the ugly
hacks applied to the resulting program state after options are already
parsed.

>
>> The UI model to be defined, provided we are serious about aiming at a
>> good design, in fact has at least 2 aspects to address:
>>
>> 1. Uniform top-level syntax of all the Git commands.
>
> have have e.g. hash-object but nothing like hash_object, there's that at
> least..., but also mktag, not make-tag, so....

Naming conventions are nice to have too, but here I was more after
something like "man git" starting with more restrictive synopsis than it
is now, say:

SYNOPSIS

  git [COMMON_OPTIONS] [OBJECT] [OBJ_OPTIONS] [COMMAND] [ARGS]

  OBJECT := { branch, tag, stash, ... }

  COMMAND := OBJECT-dependent
  ...

So that, say, removal of file, tag, branch, etc., all were similar, say:

    git file delete
    git branch delete
    git tag delete
    git submodule delete

A measures to short-cut these full forms could probably be introduced,
so that, say, "git delete" is in fact parsed as "git file delete", and
then synonyms could be introduces, so that current "git rm" is still
accepted and becomes "git file delete" after parsing.

As has been mentioned elsewhere, it'd be nice to get some expertise in
the field of syntax and semantics of textual UIs to work on a suitable
design. I'm none of an expert in the field, just someone interested in
the topic.

>
>> 2. Uniform rules to handle command-line options.
>>
>> Being hard to produce simple yet flexible design by itself, the problem
>> is further complicated by the need to absorb as much of the existing UI
>> as reasonably possible.
>>
>> Once a model is defined though, we should be able to at least ensure new
>> designs fit the model, and then, over time, gradually replace legacy UIs
>> that currently don't fit.
>>
>> As a side-note, from this standpoint, discussing deep details of "git
>> switch" options, or even relevancy of introducing of "git switch" in the
>> first place, has still no proper ground.
>>
>> Not even touching (1) for now, let me put some feelers out to see if we
>> can even figure how the rules or guidelines for command-line options
>> design may look like.
>
> Having hacked quite a bit on parse_options() recently, including quite a
> bit of unsubmitted work I've got some opinions in this area :)

Sure as hell you have! I only touched a little bit of it, and even that
raised some opinions ;-)

>
> That API is as close as we get to uniform UX in this area.

I'm all for the continuous work in this area, and thank you for taking
so much care of it.

>
>> 1. All options are divided into 2 classes: basic options and convenience
>>    options.
>
> Are you thinking of things like "git config --bool" v.s. "git config
> --type=bool" (let's ignore that we discourage the former for now), or
> more like "common" v.s. "obscure" ?

Neither. Basic options are to cover all the needed functionality, and
convenience options are to have most useful combinations of basic
options handy in a short form.

>
>> 2. Minimalism. Every basic option should tweak exactly one aspect of
>>    program behavior.
>
> Generally, although for things like "git log" you quickly end up with
> wanting to have pseudo-mode options imply one thing or the other,
> sometimes for the better, sometimes wfor worse.

In this model this is covered exactly by "convenience options". The
primary difference to the current status quo being that they don't
"imply" anything, or "defaults" anything, whatever that might mean. They
are simple textual synonyms for a set of basic options.

User will mostly use convenience options, turning to basic option(s)
only when they need to achieve something very specific and not that
usual, or for scripting, or for aliasing.

>
>> 3. Orthogonality. Every basic option should not "imply" any other
>>    option, nor change the behavior of any other option.
>
> Yeah, generally.
>
>> 4. Reversibility. Every basic option should have a way to set it to any
>>    supported value at any moment, including setting it back to its
>>    default value.
>
> Yeah, for sure, we're generally quite good at this with parse_options(),
> but there's exceptions (particularly with callbacks).

Yes, parse_options() is definitely a step in the right direction. Though
do I already repeat myself?

>
>> 5. Grouping for convenience. A convenience option (usually with a short
>>    syntax), should be semantically equivalent to an exact sequence of
>>    basic options, as if it were substituted at the place of the
>>    convenience option, and should not otherwise tweak program behavior.
>>    I.e., a convenience option should be simple textual synonym for
>>    particular sequence of basic options.
>
> I think some examples for the above in terms of current git commands
> would be quite helpful, I'm struggling to think of examples for some of
> these.

OK, let's try something from "git log".

      --first-parent
           Follow only the first parent commit upon seeing a merge commit. [...]

           This option also changes default diff format for merge commits to first-parent, see
           --diff-merges=first-parent for details.


This violates the model as it changes both how commits are selected
(changes program behavior) and changes some default governed by another
option.

To adhere to the model, it might rather have been:

   --follow-first-parent
      Follow only the first parent commit upon seeing a merge commit.

   --first-parent
      Synonym for --follow-first-parent --diff-merges=first-parent

Here, --follow-first-parent and --diff-merges=first-parent are both
basic options, while --first-parent is convenience option. Please notice
how --first-parent is described entirely in terms of other options,
without anything else, so, saying:

   git log --first-parent

is *exactly* the same as saying:

   git log --follow-first-parent --diff-merges=first-parent

only shorter. [ OPT_SYNONYM()? ]

In this model all the functionality is to be covered by orthogonal
good-behaving basic options, and then convenience options are defined to
be like that, convenience, adding zero essential functionality.

This would force an author of an option suitable for their current work
at hand to think and design suitable additional *basic* option(s) first,
and only then define new convenience option(s) in terms of basic
option(s) as needed.

>
>> Please notice that in the above model basic option having a short form
>> is formally considered to be a short convenience option that is a
>> synonym for long basic option.
>>
>> There are obviously some other useful guidelines that could be defined,
>> or some alternate approach could be chosen,but the primary point is that
>> if we want a consistent UI, we do need some rules, and we need
>> convenient implementation of the model agreed upon, and then ensure that
>> from all the designs that "make sense", only those that fit into
>> underlying model are accepted.
>
> There was a recent discussion about cat-file option parsing semantics at
> https://lore.kernel.org/git/87tuhuikhf.fsf@evledraar.gmail.com/
>
> I have this unsubmitted (and updated from that discussion) patch to make
> "cat-file" help friendlier:
> https://github.com/avar/git/commit/bd32f57cd21
>
> I wonder what you think abut that new output v.s. the old.

[Un]fortunately I'm not familiar with cat-file at all, and after reading
a few lines of the discussion you've referenced made me think I don't
want to, sorry. In general, I do think it's nice you are working hard on
the interfaces.

>
> More generally, I've wanted to have some mode for parse_options() for a
> while now to label a given option X as only going with option. We have
> OPT_CMDMODE() for things that are mutually exclusive with all other
> options, but not anything like a OPT_SUBCMDMODE() or whatever (and
> sometimes such a thing would go with N "top-level modes", not just
> one).

To me this looks like attempts to cover as much of the existing
use-cases for options in Git as possible, be them good or bad. This is
very nice to have anyway, but otherwise is orthogonal to the task of
defining simple interface model that'd be targeted at eventually
obsolete such support.

>
> Right now you need to do that manually, see the usage_msg_opt[f]()
> verbosity at:
> https://github.com/avar/git/blob/avar/cat-file-usage-and-options-handling/builtin/cat-file.c#L679-L755
>
> I thing like that would be really useful, and would go a long way
> towards consistent UX, as you could generate the sort of "grouped help"
> shown in the commit link above with it, as well as have things like:
>
>     git some-command --top-level-option --op<TAB>
>
> Tab-complete only those --op* options that go with that
> --top-level-option.

Probably this --top-level-option should better have been sub-command
rather than option in proper UI design. An option that changes semantics
so much that a bunch of options is to be replaced with something else
should probably be simply prohibited.

In general, it's pain in the ass to handle options dependencies in
universal APIs such as parse_options(), so the best way of handling this
is to (eventually) get rid of the dependencies. Yeah, as usual, that's
simpler to say than to do, I know.

>
> I guess what I'm saying is that I agree with you, but just think that
> incremental changes to these UX APIs is the most viable way forward.

No objections. My primary point in this discussion is rather that
incremental changes only work fine when there is defined target that
governs the direction of the steps being taken, and as far as I can see
we still have no such target, or maybe even no agreement on significance
of having one.

That said, the unified parse_options() being used everywhere will
definitely simplify transition to an advanced design in the future,
should such transition be ever attempted.

BTW, I didn't try hard, but talking about incremental changes, is it
possible to convert part(s) of handle_revision_opt() to the
parse_options() API? For example, diff_merges_parse_opts() is right now
mostly isolated part of handle_revision_opt(). Is it feasible to convert
it to use parse_options()?

Thanks,
-- Sergey Organov
