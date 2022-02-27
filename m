Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD7C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 10:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiB0KV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 05:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiB0KVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 05:21:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20E6D4E3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:20:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gb39so19337311ejc.1
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ih96SU8ox3R69qowJkbWBb3hz7j0OUNL1iLsuHpH5sM=;
        b=k+saFmEeH81JHOQNbXEJ/S9J/JfoUzW8SsDOxDDsbDbSZBPVru6uCeEd7RvSN0tZlk
         aW/FoBq8EBIG0omdYSVfndl/UHSS09mxHSMyYw5OsCSfhYrsLUWowmyVS4bZPDr1T2yZ
         NrnOHQks9bJTvP5Z37819MChzrx23kSs6b7yhu8tBjWhllhC4as6MXUottmwhrks28Qj
         hHAGYBRllAnH520ZfOEIPPVTvGpf/UpuTGbh60bntccmioylBjJCqnjVFyAxCX9fs44L
         yT3NaqeKH+Q4PLWWOHtmaPtrwbV81bQVhdpRSTY7QUgsj0vbmjSzuohaiiNVoGXZIv1K
         pzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ih96SU8ox3R69qowJkbWBb3hz7j0OUNL1iLsuHpH5sM=;
        b=Cbzv8SJdPQuYsN2azHXd9eApK+kXlmT2mCOFbSeA+VRFGX4X2AZS8+xwMMcHOjiIgq
         Zrvv5YtMFo0NcJ7DIlK+S5pRunX3idhGLMYWP+gamau8sP8iwYFZg41q5ViulVc0jCD3
         au9RzlRwDfa06yN+0QfYF6wwLIaoYG+/gKC1o6IhmtXWZ0tDtOnCrmA4qhzW0D6pxYyG
         n2jHPjkCI+MSnL1+tt18Q2PbaXSTkatXACrVYmdAw/JP0rxay1rIRi31BgizjyXWs7sa
         w6BGLJBqbBrb8RKrPxd7SyTVgAI1IDiEAXrwCfvGNMEDWhHvjprOraE/z8i3Rm/HqhTZ
         WX5w==
X-Gm-Message-State: AOAM532QcAxB/rIAdJOLXU3dZKmimpuM6QqKYu/+GjZX50l76zno55mW
        6695Us2lJ+qKkQqrKWiJ2Ti+y973Ksg=
X-Google-Smtp-Source: ABdhPJyQMTmo774Anq/HvJ3VKZN1DLDWDM9mSAPEDcTTeJEtcR5TPCEqmcWmOwPq4dMpBvtqA5dCtw==
X-Received: by 2002:a17:906:2b0c:b0:6cd:307c:1f02 with SMTP id a12-20020a1709062b0c00b006cd307c1f02mr11624117ejg.84.1645957247413;
        Sun, 27 Feb 2022 02:20:47 -0800 (PST)
Received: from gmgdl (2a02-a45a-de66-1-9692-d742-9006-d30e.fixed6.kpn.net. [2a02:a45a:de66:1:9692:d742:9006:d30e])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709064a5500b006cdf30e03f8sm3213260ejv.66.2022.02.27.02.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 02:20:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOGfV-0010AP-WD;
        Sun, 27 Feb 2022 11:20:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Justin Donnelly <justinrdonnelly@gmail.com>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] In PS1 prompt, make upstream state indicators
 consistent with other state indicators
Date:   Sun, 27 Feb 2022 11:19:03 +0100
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
 <220225.86czjb874f.gmgdl@evledraar.gmail.com>
 <CAGTqyRwTEdwut4HKD2=MaBfG_tZqN_TjGPAjChzmjBubC0-wuQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAGTqyRwTEdwut4HKD2=MaBfG_tZqN_TjGPAjChzmjBubC0-wuQ@mail.gmail.com>
Message-ID: <220227.86wnhg626a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 26 2022, Justin Donnelly wrote:

> Thanks for the feedback. Comments interleaved below.
>
> On Fri, Feb 25, 2022 at 7:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Fri, Feb 25 2022, Justin Donnelly via GitGitGadget wrote:
>>
>> I couldn't find any glaring issues here on a quick review, just a note.
>>
>> > These patches are about the characters and words that can be configure=
d to
>> > display in the PS1 prompt after the branch name. I've been unable to f=
ind a
>> > consistent terminology. I refer to them as follows: [short | long] [ty=
pe]
>> > state indicator where short is for characters (e.g. ?), long is for wo=
rds
>> > (e.g. |SPARSE), and type is the type of indicator (e.g. sparse or upst=
ream).
>> > I'd be happy to change the commit messages to a different terminology =
if
>> > that's preferred.
>>
>> I think that terminology is correct, in case you haven't seen it
>> git-for-each-ref(1) talks about the "short" here as "short",
>> "trackshort" etc.
>>
>> > There are a few inconsistencies with the PS1 prompt upstream state ind=
icator
>> > (GIT_PS1_SHOWUPSTREAM).
>> >
>> >  * With GIT_PS1_SHOWUPSTREAM=3D"auto", if there are no other short sta=
te
>> >    indicators (e.g. + for staged changes, $ for stashed changes, etc.)=
, the
>> >    upstream state indicator appears adjacent to the branch name (e.g.
>> >    (main=3D)) instead of being separated by SP or GIT_PS1_STATESEPARAT=
OR (e.g.
>> >    (main =3D)).
>> >  * If there are long state indicators (e.g. |SPARSE), a short upstream=
 state
>> >    indicator (i.e. GIT_PS1_SHOWUPSTREAM=3D"auto") is to the right of t=
he long
>> >    state indicator (e.g. (main +|SPARSE=3D)) instead of with the other=
 short
>> >    state indicators (e.g. (main +=3D|SPARSE)).
>>
>> I think it would really help to in each commit message have a
>> before/after comparison of the relevant PS1 output that's being changed.
>
> I agree that a before/after comparison would probably make it easier
> to understand. Maybe some examples without upstream (for a baseline to
> compare against) and a table that shows before/after for upstream.
>
> `__git_ps1` examples without upstream:
> (main)
> (main %)
> (main *%)
> (main|SPARSE)
> (main %|SPARSE)
> (main *%|SPARSE)
> (main|SPARSE|REBASE 1/2)
> (main %|SPARSE|REBASE 1/2)
>
> Of note:
> 1. If there are short state indicators, they appear together after the
> branch name and separated from it by `SP` or `GIT_PS1_STATESEPARATOR`.
> 2. If there are long state indicators, they appear after short state
> indicators if there are any, or after the branch name if there are no
> short state indicators. Each long state indicator begins with a pipe
> (`|`) as a separator.
>
> Patch 2 before/after:
> | Before           | After            |
> | ---------------- | ---------------- |
> | (main=3D)          | (main =3D)         |
> | (main|SPARSE=3D)   | (main =3D|SPARSE)  |
> | (main %|SPARSE=3D) | (main %=3D|SPARSE) |
>
> Patch 3 before/after:
> | Before                          | After                           |
> | ------------------------------- | ------------------------------- |
> | (main u=3D)                       | (main|u=3D)                       |
> | (main u=3D origin/main)           | (main|u=3D origin/main)           |
> | (main u+1)                      | (main|u+1)                      |
> | (main u+1 origin/main)          | (main|u+1 origin/main)          |
> | (main % u=3D)                     | (main %|u=3D)                     |
> | (main % u=3D origin/main)         | (main %|u=3D origin/main)         |
> | (main % u+1)                    | (main %|u+1)                    |
> | (main % u+1 origin/main)        | (main %|u+1 origin/main)        |
> | (main|SPARSE u=3D)                | (main|SPARSE|u=3D)                |
> | (main|SPARSE u=3D origin/main)    | (main|SPARSE|u=3D origin/main)    |
> | (main|SPARSE u+1)               | (main|SPARSE|u+1)               |
> | (main|SPARSE u+1 origin/main)   | (main|SPARSE|u+1 origin/main)   |
> | (main %|SPARSE u=3D)              | (main %|SPARSE|u=3D)              |
> | (main %|SPARSE u=3D origin/main)  | (main %|SPARSE|u=3D origin/main)  |
> | (main %|SPARSE u+1)             | (main %|SPARSE|u+1)             |
> | (main %|SPARSE u+1 origin/main) | (main %|SPARSE|u+1 origin/main) |
>
> Note: These tables are inspired by [Markdown Guide extended
> syntax](https://www.markdownguide.org/extended-syntax/#tables), but I
> didn't wrap the PS1 prompt text in backticks or escape the pipe
> because I thought that would make it more confusing. In short, they're
> meant to be viewed as (monospaced font) text, not Markdown.

Thanks. These comparisons are really useful & would be nice to work into
relevant commit messages in a re-roll.

I withdraw any suggestions about making this "main|SPARSE|u=3D" instead of
"main=3D|SPARSE|u" or whatever. I think such a thing might still make
sense, but it's clearly unrelated to the improvements you're making
here.

>>
>>
>> I'm not sure how to readthis example. So before we said "main +=3D|SPARS=
E"
>> but now we'll say "main +|SPARSE=3D", but without sparse we'll say
>> "main=3D"?
>>
>> Aren't both of those harder to read than they need to be, shouldn't it
>> be closer to:
>>
>>     main=3D |SPARSE
>>
>> Or:
>>
>>     main=3D |+SPARSE
>>
>> Or:
>>
>>     main=3D +|SPARSE
>>
>> I can't recall what the "+" there is (if any).
>
>
> `+` is for staged changes (if `GIT_PS1_SHOWDIRTYSTATE` is a nonempty
> value). So it's not directly related to upstream, but the addition of
> another short state indicator changes things.

Thanks!

>>
>>
>> I.e. the "=3D" refers to the ahead/behind state of "main, it seems odd in
>> both versions of your example that we're splitting it off from "main"
>> because we have "SPARSE" too.
>>
>> But maybe I'm missing something...

