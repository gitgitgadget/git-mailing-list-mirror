Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8404C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377799AbiBUO2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:28:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377781AbiBUO23 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:28:29 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152CB1EC7B
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:28:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m17so29689847edc.13
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xviSCgc/lRfPaYOZZAXb7ddQ1a9reO3GbNcg98AK/OQ=;
        b=POM7uXi8KupJYfc9q1ZC86Bu4F4kH4mv+hzzRCza6NJWwE8qd+sKo2Yoal/wD5u7FZ
         9J/cQIc7m4fsL+sEvm63Sj5cTGKANafqbsz+JcemIBGUcBI75iW+d8BAKwN5Wa7DFfCV
         kiEgZKzN5eBABXrysJH0lz0ZDQPRjxBcHCva0heH6qG9mX/P0toc/qE8cisVTBysqx3M
         2b3N9EgLVnb+duZaMHuXxH9WJDnGMSKki/WrWdQYh8sbGRHMOg5QfytNRlN+ZZTLLjhX
         jpP1yW/eJ27vJid88jbJ4tceuKtyYJRenO00rgf6Z+sQiTrCQeNBSaH3HRt8ToMHQNKf
         2u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xviSCgc/lRfPaYOZZAXb7ddQ1a9reO3GbNcg98AK/OQ=;
        b=5XMzZjw7N4zXN7WBwDvbXx5kxn9gDZfyxymp7HRUqQDodOx+xBD/7FHPsC1hNK4evv
         jTC0adDzA+yET7B5Ug6lqRQuLgOE/jSG5NIBAUZ7Tp0ao8/u0m0bzw6vEuWOP3v9j2rM
         rT1rTlpWOXdXUWWLkYGcp26zpevNNex1h5ik86mxUmcue5fZ7z34TLVc9nSqgnNlNy62
         HP/TeYpb9D2CmcVBCjd4BG8PRG/JrgQddED2wi0h3AywZ0/7n+mheG+f9hYt8xYBVvg/
         oPqpIUoc+TN6iIq3PwBFamzc5OTvNd5fDVDtVp7uSOfBJOho2xrdCrSY4ot9Tt8FtFMc
         /Mow==
X-Gm-Message-State: AOAM531VlLrVvladKMuWi2xEXoSQ4fyx64btq9hoIJkjXXET7yeIUTwB
        olDaizbcH5vpQbcUYVfhLp/xcVqcHq4=
X-Google-Smtp-Source: ABdhPJzogkyc7aKDxKTsPT7a/aHdySH9N5n9G/RWGIkuFt8EQKX9mjvnMmmNopuBoYsJYLXfEPQErw==
X-Received: by 2002:aa7:c446:0:b0:410:9a8e:9b85 with SMTP id n6-20020aa7c446000000b004109a8e9b85mr21254959edr.319.1645453683312;
        Mon, 21 Feb 2022 06:28:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i6sm5267354eja.132.2022.02.21.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:28:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nM9fV-005dbC-NV;
        Mon, 21 Feb 2022 15:28:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
Date:   Mon, 21 Feb 2022 15:27:56 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet>
 <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org>
 <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
 <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
Message-ID: <220221.8635kccn0u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Johannes Schindelin wrote:

> Hi Elijah,
>
> On Fri, 4 Feb 2022, Elijah Newren wrote:
>
>> On Fri, Feb 4, 2022 at 3:10 PM Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Sat, 29 Jan 2022, Elijah Newren wrote:
>> >
>> > > On Sat, Jan 29, 2022 at 12:23 AM Johannes Sixt <j6t@kdbg.org> wrote:
>> > > >
>> > > > Just a heckling from the peanut gallery...
>> > > >
>> > > > Am 29.01.22 um 07:08 schrieb Elijah Newren:
>> > > > > On Fri, Jan 28, 2022 at 8:55 AM Johannes Schindelin
>> > > > > <Johannes.Schindelin@gmx.de> wrote:
>> > > > >> Meaning: Even if stage 3 is missing from the first conflict and stage 1 is
>> > > > >> missing from the second conflict, in the output we would see stages 1, 2,
>> > > > >> 2, 3, i.e. a duplicate stage 2, signifying that we're talking about two
>> > > > >> different conflicts.
>> > > > >
>> > > > > I don't understand why you're fixating on the stage here.  Why would
>> > > > > you want to group all the stage 2s together, count them up, and then
>> > > > > determine there are N conflicting files because there are N stage 2's?
>> > > >
>> > > > Looks like you are misunderstanding Dscho's point: When you have two
>> > > > conflicts, the first with stages 1 and 2, the second with stages 2 and
>> > > > 3, then the 2s occur lumped together when the 4 lines are printed in a
>> > > > row, and that is the cue to the parser where the new conflict begins.
>> > > > Dscho did not mean that all N 2s of should be listed together.
>> > >
>> > > Ah, so...I didn't understand his misunderstanding?  Using stages as a
>> > > cue to the parser where the new conflict begins is broken; you should
>> > > instead check for when the filename listed on a line does not match
>> > > the filename on the previous line.
>> >
>> > But that would break down in case of rename/rename conflicts, right?
>> >
>> > > In particular, if one conflict has stages 1 and 2, and the next conflict
>> > > has only stage 3, then looking at stages only might cause you to
>> > > accidentally lump unrelated conflicts together.
>> >
>> > Precisely. That's why I would love to have a way to deviate from the
>> > output of `ls-files -u`'s format, and have a reliable way to indicate
>> > stages that belong to the same merge conflict.
>>
>> Ah, attempting to somehow identify and present logical separate
>> conflicts?  That could be awesome, but I'm not sure it's technically
>> possible.  It certainly isn't with today's merge-ort.
>>
>> Let me ask some questions first...
>>
>> If I understand you correctly then in the event of a rename/rename,
>> i.e. foo->bar & foo->baz, then you want foo's, bar's, & baz's stages
>> all listed together.  Right?  And in some way that you can identify
>> them as related?
>
> Yes, that was kind of my idea ;-)
>
>> If we do so, how do we mark the beginning and the end of what you call
>> "the same merge conflict"?  If you say it's always 3 stages (with the
>> possibility of all-zero modes/oids), then what about the rename/rename
>> case above modified so that the side that did foo->baz also added a
>> different 'bar'?  That'd be 4 non-zero modes/oids, all of them
>> relevant.  Or what if the side that did foo->bar also renamed
>> something else to 'baz', giving us even more non-zero stages for these
>> three paths?  Perhaps you consider these different conflicts and want
>> them listed separately -- if so, where does one conflict begin and
>> another start and which stages are parts of which conflict?
>
> Thank you for calling me out on an only half-finished thought.
>
> To be quite honest, I previously did not have much time to think of the
> non-trivial nature of representing merge conflicts in a web UI when
> performing merges with rename detection, in particular when performing
> _recursive_ merges (where, as you point out so correctly, an arbitrary
> number of rename conflicts can happen _for the same file_).
>
> Of course, this gets even more complicated when we're also thinking about
> type changes (file -> symlink, file -> directory, and vice versa).
>
>> If you are attempting to somehow present the stuff that "belongs to
>> the same merge conflict" are you also trying to identify what kind of
>> merge conflict it is?  If so, do you want each type of merge conflict
>> listed?  For example, let's switch from the example above of logically
>> disjoint paths coming together to result in more than 3 stages, and
>> instead pick an example with a single logical path with less than
>> three stages.  And now let's say that path has multiple conflicts
>> associated with it; let's use an example with 3: rename/delete +
>> modify/delete + directory/file (one side renames foo->bar while
>> modifying the contents, the other side deletes foo and adds the
>> directory 'bar/').  In this case, there is a target file 'bar' that
>> has two non-zero modes/oids in the ls-files-u output.  If all three
>> types of conflicts need to be listed, does each need to be listed with
>> the two non-zero modes/oids (and perhaps one zero mode/oid), resulting
>> in six listings for 'bar'?  Or would the duplication be confusing
>> enough that we instead decide to list some merge conflicts with no
>> stages associated with them?
>>
>> Thinking about both sets of questions in the last two paragraphs from
>> a higher level -- should we focus on and group the higher order stages
>> by the individual conflicts that happen, or should we group them by
>> the paths that they happen to (which is what `ls-files -u` happens to
>> do), or should we not bother grouping them and instead duplicate the
>> higher order stages for each logical conflict it is part of?
>>
>> As an alternative to duplicating higher order stages, do we sometimes
>> decide to "lump" separate conflicts together and treat them as one
>> conflict?  If so, what are the rules on how we decide to lump
>> conflicts and when not to?  Is there a bright line boundary?  And can
>> it be done without sucking in arbitrarily more stages for a single
>> conflict?
>>
>>
>> Some testcases that might be useful while considering the above
>> questions: take a look at the "rad", "rrdd", and "mod6" tests of
>> t6422.  How many "same merge conflicts" are there for each of those,
>> and what's the boundary between them?  And can you give the answer in
>> the form of rules that generically handle all cases, rather than just
>> answering these three specific cases?
>>
>>
>> I've thought about this problem long and hard before (in part because
>> of some conversations I had with Edward Thompson about libgit2 and
>
> Not a big deal for _me_, but I seem to remember that Ed cared a lot about
> having no p in their surname ;-)
>
>> merging at Git Merge 2020).  It wasn't at all clear to me that libgit2
>> had considered anything beyond simple rename cases.  The only rules I
>> ever figured out that made sense to me was "group the stages by target
>> filename rather than by logical conflict" (so we get `ls -files -u`
>> populated) and print a meant-for-human message for each logical
>> conflict (found in the <Informational Messages> section for
>> merge-tree), and make NO attempt to connect stages by conflict type.
>>
>> I'm sure that's not what you wanted to hear, and maybe doesn't even
>> play nicely with your design.  But short of ignoring the edge and
>> corner cases, I don't see how to solve that problem.  If you do just
>> want to ignore edge and corner cases, then just ignore the
>> rename/rename case you brought up in the first place and just use
>> `ls-files -u`-type output as-is within your design.  If you don't want
>> to ignore edge cases and want something that works with a specific
>> design that somehow groups conflicted file stages by conflict type,
>> then we're going to have to dig into all these questions above and do
>> some big replumbing within merge-ort.
>
> There is sometimes a big difference between what I want to hear and what I
> need to hear. Thank you for providing so many details that I needed to
> hear.
>
> So let's take a step back and look at my goal here, as in: the
> over-arching goal: to use merge-ort on the server side.
>
> From what you said above, it becomes very clear to me that there is very
> little chance to resolve such conflicts on the server side.
>
> For example, if a topic branch renames a file differently than the main
> branch, there is a really good chance that the user tasked with merging
> the topic branch will have to do a whole lot more than just click a few
> buttons to perform that task. There might very well be the need to edit
> files that do not contain merge conflict markers (I like to call those
> cases "non-semantic merge conflicts"), and almost certainly local testing
> will be necessary.
>
> So I guess the best we can do in those complicated cases is to give a
> comprehensive overview of the problems in the web UI, with the note that
> this merge conflict has to be resolved on the local side.
>
> Which brings me to the next concern: since `merge-tree` is a low-level
> tool meant to be called by programs rather than humans, we need to make
> sure that those messages remain machine-parseable, even if they contain
> file names.
>
> Concretely: while I am not currently aware of any web UI that allows to
> resolve simple rename/rename conflicts, it is easily conceivable how to
> implement such a thing. When that happens, we will need to be able to
> teach the server-side code to discern between the cases that can be
> handled in the web UI (trivial merge conflicts, trivial rename/rename
> conflicts) as compared to scenarios where the conflicts are just too
> complex.
>
> Here's an excerpt from t4301:
>
> -- snip --
> Auto-merging greeting
> CONFLICT (content): Merge conflict in greeting
> Auto-merging numbers
> CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
> CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
> -- snap --
>
> This is the complete set of messages provided in the `test conflict
> notices and such` test case.
>
> I immediately notice that every line contains at least one file name.
> Looking at https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1899, it
> does not seem as if the file names are quoted:
>
> 		path_msg(opt, path, 1, _("Auto-merging %s"), path);
>
> (where `path` is used verbatim in a call to `merge_3way()` before that,
> i.e. it must not have been quoted)
>
> I would like to register a wish to ensure that file names with special
> characters (such as most notably line-feed characters) are quoted in these
> messages, so that a simple server-side parser can handle messages starting
> with `Auto-merging` and with `CONFLICT (content): Merge conflict in `, and
> "throw the hands up in the air" if any other message prefix is seen.
>
> Do you think we can switch to `sq_quote_buf_pretty()` for these messages?
> For the `Auto-merging` one, it would be trivial, but I fear that we will
> have to work a bit on the `path_msg()` function
> (https://github.com/git/git/blob/v2.35.1/merge-ort.c#L630-L649) because it
> accepts a variable list of arguments without any clue whether the
> arguments refer to paths or not. (And I would be loathe to switch _all_
> callers to do the quoting themselves.)
>
> I see 28 calls to that function, and at least a couple that pass not only
> a path but also an OID (e.g.
> https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1611-L1613).
>
> We could of course be sloppy and pass even OIDs through
> `sq_quote_buf_pretty()` in `path_msg()`, knowing that there won't be any
> special characters in them, but it gets more complicated e.g. in
> https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1648-L1651, where we
> pass an `strbuf` that contains a somewhat free-form commit message.
>
> I guess we could still pass those through `sq_quote_buf_pretty()`, even if
> they are not paths, to ensure that there are no special characters in the
> machine-parseable lines.
>
> What do you think?
>
> Ciao,
> Dscho

