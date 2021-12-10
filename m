Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC74C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 11:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhLJLoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 06:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhLJLoi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 06:44:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1BAC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 03:41:03 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so29558478edd.3
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 03:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vs5oZBWgpt0TX1l00Ou97DfNIRUOGMJx0wWmnd1N6cs=;
        b=lDdFNFw63sN6L6+LdmqtW0rjTyrAnEI4Am0CBS9z/xTwDtCb75h1Yc0+C3quQ2yNY0
         c7OM4Vk0BvjVZ4htqfZcRwbwLJuiqIEuxC9kUtLZBZz0Ljuam7xOlfAxc7ATdDfxVZMu
         NzyosiUCN+idGlhM4DItazdfzgy57XH7vCQ2ixvhFYgdql2hWOIT+av0nkJu2CFNAvbC
         7Z7e6dJOeTtyvJgRqvv4Z5dkCPVLDxG8qcb7RuEao7GR/3VCF31B5XkXOFIQfv6yF1Hj
         6eStAaZvTAziQBBXec4gjuvzLuMaGs1iNHUgB1L+GYdz7+B7lfRi9wHA1j9oe4ZS4C/N
         TSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vs5oZBWgpt0TX1l00Ou97DfNIRUOGMJx0wWmnd1N6cs=;
        b=hnPWrwoP9PR+n7eAuaoQezBz+DxZh6q8XP0dXKfg1oXOt2I7oR0HPCPyf9xXWetDuG
         o0eqOKmg8br/L6E0ERHn98+/RmzWB9XkuKvo/YivJls9flUR/RuzfEeRhsx3IGY+PBFE
         IxIINaB4RUcfvom6A0i2S30cyxJh756+xVHfCv6H/08hX/rmMKeNxJy7nbv5858y968u
         smnOQzOeBCpWgPwxywkKs2LsE+jdjAgPjrgbqnapZHRZkZygtr5qfB8XwC2i1jkUuK7k
         TSu1RhcKjCgSWijFcpL+GX6I0hyBUDRfY5PoCfdZaEFl8AsTu+CPaP6ofUES/cNVlb2g
         3S4g==
X-Gm-Message-State: AOAM5309oGuALiUkesbO9GFD53qcElemUCYH4Pr0lvb0LO0hG3buy+qv
        TEMSGsJAFLRW42W5Q4nEwussi9a0wqVQOA==
X-Google-Smtp-Source: ABdhPJxqFZdQ8+ptZC+tA3Qteq6ypBH/8PPCrn5Ant3UQqP+p0pJg22Mhcdnj0QO+fcu86JiMRj4Ag==
X-Received: by 2002:a17:906:3085:: with SMTP id 5mr22781164ejv.365.1639136462111;
        Fri, 10 Dec 2021 03:41:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ig1sm1295641ejc.77.2021.12.10.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 03:41:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mveGq-000Ipj-Ss;
        Fri, 10 Dec 2021 12:41:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Subject: Re: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Date:   Fri, 10 Dec 2021 12:30:01 +0100
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <211210.86r1ale0o0.gmgdl@evledraar.gmail.com>
 <BN8PR12MB3361388476E57E097DEBF9F7C8719@BN8PR12MB3361.namprd12.prod.outlook.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <BN8PR12MB3361388476E57E097DEBF9F7C8719@BN8PR12MB3361.namprd12.prod.outlook.com>
Message-ID: <211210.86h7bgd6wj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Joel Holdsworth wrote:

>> The commit messages could just really use some extra hand-holding and
>> explanation, and a clear split-out of things related to the version bump v.s.
>> things not needed for that, or unrelated refactorings.
>
> Yes, I am getting this message loud and clear. I will resubmit with more detailed commit messages today.

Thanks...

> To explain the story here: I started using git-p4 as part of my
> work-flow, and I expect to need it for several years to come. As I
> began to use it, I found that a series of bugs - mostly related to
> character encoding. In fixing these, I found that some of the troubles
> were specific to Python 3 - or rather Python 2's less strict approach
> to distinguishing between byte sequences and textual strings allowed
> the script to proceed Python 2 even though what it was doing was in
> fact invalid, and was potentially corrupting data.
>
> A common problem that users are encountering is that the script
> attempts to decode incoming textual byte-streams into UTF-8
> strings. On Python 3 this fails with an exception if the data contains
> invalid UTF-8 codes. For text files created in Windows, CP1252 Smart
> Quote characters: 0x93 and 0x94 are seen fairly frequently. These
> codes are invalid in UTF-8, so if the script encounters any file or
> file name containing them, it will fail with an exception.
>
> Tzadik Vanderhoof submitted a patch attempting to fix some of these issues in April 2021:
> https://lore.kernel.org/git/20210429073905.837-1-tzadik.vanderhoof@gmail.com/
>
> My two comments about this patch are that 1. It doesn't fix my issue, and 2. Even with the proposed fallbackEncoding option it still leaves git-p4 broken by default.
>
> A fallbackEncoding option may still be necessary, but I found that most of the issues I encountered could be side-stepped by simply avoiding decoding incoming data into UTF-8 in the first place.
>
> Keeping a clean separation between encoded and decoded text is much
> easier to do in Python 3. If Python 2 support must be maintained, this
> will require careful testing of separate code-paths both platforms
> which I don't regard as reasonable given that Python 2 is thoroughly
> deprecated. Therefore, this first patch-set focusses primarily on
> removing Python 2 support.

This all makes perfect sense to me (having never used git-p4). Having
this sort of explanation be part of the relevant commit message would be
great :)

I haven't worked extensively with Python myself, but I've understood
that its Unicode support was a big pain before v3 as you describe, which
is just the sort of thing that would justify a version prereq bump, even
if it's a bit painful to some users on older systems (if even that,
maybe everyone's upgraded already...)

> Furthermore, because I expect to be using git-p4 in my daily work-flow
> for some time to come, I am interested in investing some effort into
> improving it. There are bugs, unreliable behaviour, user-hostile
> behaviour, as well as code that would benefit from clean-up and
> modernisation. In submitting these patches, I am trying to get a read
> on to what extent such efforts would be accepted by the Git
> maintainers.

I don't think there's any reason we wouldn't accept these sorts of
changes.

The comment from me (and others I see) is purely on the topic of making
them easier to review, i.e. splitting out "this is for a version
upgrade" v.s. "this is just better Python style" or whatever.

> Is it preferable that patch-sets have a tight focus on a single topic?
> I am already dividing up my full patch collection. I can divide it
> further if requested. I am happy to do this, I was just worried that
> it just might make longer to get all my patches through review.

Yeah this project really prefers to do it that way. A good example is
this recent 19-part series:
https://lore.kernel.org/git/20211210095757.gu7w4n2rqulx2dvg@fs/T/#m5d9e8180551907578d56cdd6cd6244b9df6b59d5

This would probably be 1-3 patches, or even 1 patch in some other
projects, but especially with repetitive formatting changes I think it's
fair to say that we prefer for them to be split up closer to that,
i.e. one commit with some %s -> {} formatting change explaining why
(probably just style, preferenc) etc.

There's also the option of splitting things into different patch
series. I'd say if you e.g. have one series of "we're dropping python 2
support" and another "here's nice formatting changes" it would be nice
to split those into two different patch serieses.

But that's always a matter of taste & how easy it is. If they
extensively textually conflict it's often worth it to just stack them
together, or if they changes are all small/easy enough to review some
"while we're at it..." changes are generally fine.

Finally, for a re-submission it's also nice to find people who've worked
on the relevant code (with some fuzzing for "is this person likely to
still be active in the project?") and CC them on the series, or in this
case people who've made recent changes to git-p4.py.

>> Some of these changes also just seem to be entirely unrelated refactorings,
>> e.g. 6/6 where you're changing a multi-line commented regexp into
>> something that's a dense one-liner. Does Python 3 not support the
>> equivalent of Perl's /x, or is something else going on here?
>
> I will improve the commit message to explain the changes being made here.
>
> The regexp is matching RCS keywords:
> https://www.perforce.com/manuals/p4guide/Content/P4Guide/filetypes.rcs.html
> - $File$, $Author$, $Author$ etc., a very simple match. We could keep
> it multi-line, though this seems overkill to me.

Sure, my preference in Perl would be to split it, but I'm never going to
be maintaining git-p4.py, so... :)

I.e. I think it's perfectly fair to roll it into some general "this
improves readability" changes, just as long as they're clearly labeled
as such.

> The main significance of this change that previously git-p4 would
> compile one of these two regexes for every single file processed. This
> patch just pre-compiles the two regexes (now binary regexes, not utf-8
> regexes) at the start of the script.

Makes sens, and another thing that would be perfect for pretty much
copy/pasting as-is to a re-rolled commit's message :)
