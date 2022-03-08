Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28003C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 13:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiCHNv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiCHNv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 08:51:56 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2263818B
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 05:50:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw13so39234795ejc.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KGjzz0miwubJD/2Ajwn7C8IUh3G6gE3r9aDjTn1pmRs=;
        b=g5LnefHazvXnXm8yp1afwi0/AeItFAvUwj4pZ6akC499tuIYGGzPN1LulVKTrvRTN5
         /JrD0y/mZgrYEnKGVWs3XaTVdDL7iG9TfMHMJnVbs1Jkcxjk+UkF1CSSjORo4OE35JWK
         OH0y+7b0Ruyksmez62pHfPhNsLK9bZNNLL9WuB1iUCewUP3IvoBdUpVCIn43puF5fzBa
         LzkJFOHe0FQHnRqWTKDeN3rxTlpKmRlQm4HcaajiWRuFmpP2506yW4pWPIiEvBIfrgLu
         cZnAgD0PAJU0N43DkFVqo6gC1cOKwgBbL3N2jQCKCEH7A2ZddR8nLv82Wse6EkvBdVqJ
         i6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KGjzz0miwubJD/2Ajwn7C8IUh3G6gE3r9aDjTn1pmRs=;
        b=uzyr2cBEHyewW86rBHgw6Dmv/870/Gm0qMWer1y7lHdKixmb7BsIk/PgyJ8/IFhTSW
         lB5UVLdiJyMPCETC+KT2AnyDean2xignASjtqaTG+YvPhkviy8VyH/CaMrF9/YCjCmYa
         0Y0ciBLi0nUd4jdqYn+KGCyJBoya7W+6ZJIzTZw2byk32s3o8IkGN/NkqnBU3VKw61xC
         EFZwRyRMBYS5FCUSR2f2uCZ6yZM8AmJW5ah5o8To9+IfvlnkwR14LAeKydXD+N4o/E28
         Z2cNkYK9wmeMNOYy52LrD8e5kLrYR/ZIhTAxXTNFJGCbcwqhtJqBHgivQSq72skyoeCf
         0Eqg==
X-Gm-Message-State: AOAM532cdIRSmyL5/Qnac8buOC++iqpkykMOzpOt2j2Z4811rLHZZV1v
        6u1QwytkhYrW/M6Flak2yrR5VgoH0QBIUA==
X-Google-Smtp-Source: ABdhPJy/IjMqsYREce3Uqv9v16E8NKSushWG7KlJRMXzoUL3V6W+kbFZtk/4NFanvMydERnu188Dtw==
X-Received: by 2002:a17:907:7656:b0:6d0:1f5a:2bec with SMTP id kj22-20020a170907765600b006d01f5a2becmr13315496ejc.164.1646747457676;
        Tue, 08 Mar 2022 05:50:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hb19-20020a170906b89300b006daa95d178esm5230105ejb.60.2022.03.08.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:50:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRaEq-001vS3-LB;
        Tue, 08 Mar 2022 14:50:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rebase: help user when dying with preserve-merges`
Date:   Tue, 08 Mar 2022 14:45:59 +0100
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
 <cd06aa68c2fc65551cd810a1c2c0941c51433163.1645526016.git.gitgitgadget@gmail.com>
 <220222.86czje7w4i.gmgdl@evledraar.gmail.com>
 <c04eba64-0357-cfdd-2ffe-3905ce4f4cb9@iee.email>
 <220223.86r17t6fvf.gmgdl@evledraar.gmail.com>
 <7cb42ab5-92c5-0a48-ffba-4f6b55ef130c@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <7cb42ab5-92c5-0a48-ffba-4f6b55ef130c@iee.email>
Message-ID: <220308.86zgm0wo1r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Philip Oakley wrote:

> On 23/02/2022 10:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Feb 22 2022, Philip Oakley wrote:
>>
>>> On 22/02/2022 15:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> On Tue, Feb 22 2022, Philip Oakley via GitGitGadget wrote:
>>>>
>>>>> From: Philip Oakley <philipoakley@iee.email>
>>>>>
>>>>> Git will die if a "rebase --preserve-merges" is in progress.
>>>>> Users cannot --quit, --abort or --continue the rebase.
>>>>>
>>>>> This sceario can occur if the user updates their Git, or switches
>>>>> to another newer version, after starting a preserve-merges rebase,
>>>>> commonly via the pull setting.
>>>>>
>>>>> One trigger is an unexpectedly difficult to resolve conflict, as
>>>>> reported on the `git-users` group.
>>>>> (https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)
>>>>>
>>>>> Tell the user the cause, i.e. the existence of the directory.
>>>>> The problem must be resolved manually, `git rebase --<option>`
>>>>> commands will die, or the user must downgrade. Also, note that
>>>>> the deleted options are no longer shown in the documentation.
>>>> I can go and read the linked thread for the answer, but:
>>>>
>>>>>  		if (is_directory(buf.buf)) {
>>>>> -			die("`rebase -p` is no longer supported");
>>>>> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
>>>>> +			"You still have a `.git/rebase-merge/rewritten` directory, \n"
>>>>> +			"indicating a `rebase preserve-merge` is still in progress.\n");
>>>>>  		} else {
>>>>>  			strbuf_reset(&buf);
>>>>>  			strbuf_addf(&buf, "%s/interactive", merge_dir());
>>>> As much of an improvement this is, I'd be no closer to knowing what I
>>>> should do at this point.
>>>>
>>>> Should I "rm -rf" that directory, downgrade my version of git if I'd
>>>> like to recover my work (as the message alludes to).
>>>>
>>>> In either case I'd think that this is getting a bit past the length
>>>> where we'd have just a die() v.s. splitting it into a die()/advise()
>>>> pair. I.e. to have the advise() carry some bullet-point list about X/Y=
/Z
>>>> solutions, with the die() being a brief ~"we did because xyz dir is
>>>> still here".
>>>>
>>>>
>>> Hi =C3=86var,
>>>
>>> Exactly. This is a slightly special, but real, case. The previous
>>> message was essentially totally opaque to users. An "If I were you I
>>> wouldn't start from here" response is somewhat true, so we simply tell
>>> the user how they got to receive the fatal message. They can then take
>>> any of the options they choose.
>>>
>>> Ultimately the user downgraded and managed to use "rebase --continue",
>>> as advised by Git, without the response "fatal:" to complete their old
>>> preserve-merges rebase.
>> Right. I'm pointing out that in this proposed version of the die()
>> message we stop just short of actually telling the user how to proceed.
>>
>> I.e. just that they have a X directory, not that they should either
>> remove X and lose their work, or downgrade git, proceed, and then
>> upgrade git.
> In a sense, that is it. They are in a difficult place, but with at least
> a little information to seek further information and start making their
> choices. Before, they (users in difficulty) were rather uninformed.

Yes, it's definitely an improvement. I'm just wondering if we can tell
them a bit more so that they're not needing to search "what do do about
.git/rebase-merge/rewritten" on Google/stackoverflow/whatever.

I.e. can we just specifically say that they either need to downgrade,
continue, upgrade, or alternatively rm -rf it, depending on wheher
they'd like to not lose their work, or if that's OK?

>>> They'll hit a similar fault in short order because when they next `pull`
>>> they'll be slipped into trying the preserve-merge rebase again - that's
>>> the 2/2 patch, making sure they know why.
>> Well, this is "rebase". You can have been running rebases in a
>> repository without ever having any interactions with remotes.
> True. That is a possibility. But we have also removed the preserve
> option for interaction with remotes as well.

*Nod*, presumably you mean its removal from "builtin/pull.c" etc.
>>
>> And even if you had interactions with remotes you might be doing so via
>> "git fetch" followed by "git rebase", and might not ever invoke "git
>> pull".
>>
>> And even if you did a "git pull" later shouldn't the error you got here
>> be sufficiently stand-alone as to tell you what to do, without needing a
>> later "pull"?
> Why are we delaying telling the user that they would have problems there
> as well? It shouldn't be a game about how many ways we can trip up the us=
er.
>
> It's a pity the problem has split into the different ways into disaster.

I'm just saying that the reason the message is a bit confusing is
because we *are* delaying it. I.e. we could give a more specific error
message in builtin/pull.c, but the "preserve merges" scaffolding was
already removed from it.

Which is why we're doing it in builtin/rebase.c, and suggesting "tweak
your pull settings", to a user who may or may not have arrived there
after a "pull" (and may not be using remotes at all).

I think overall that's OK in this case, i.e. this fix shouldn't be held
up by putting that scaffolding in place in builtin/pull.c again to
slightly improve the error.

But perhaps in the 2/2 error just say instead: "if you arrived here via
'git pull' ....". I.e. no extra code, just a slight tweak to the
message, and any user seeing it by invoking "rebase" directly won't be
further confused about why the error is saying something about "pull"
(which they didn't run).
