Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B44C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 02:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbiC3Cfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242013AbiC3Cfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 22:35:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8081856418
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:34:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r2so23226461iod.9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b0JwVX06FU3kDxyGGeLmHw9PFleS9yYadeciDJuR71M=;
        b=ij5BiiK1nEBSKAgsI+zJcp9A2QVywuJW+OnXiVzuU9nYSqKcnk/HvjRdMqVIaMiAKw
         ObLalXTUazXv9BLkf3lzumyYtUeQFmalZlMT8/6SkXnVJClgTQpcVB7kuQp+FbPwFx0B
         949pXKc+ETJyOZUDlRiCdwW16mYpngFLAfw05EUMXCmlTcNvx8W2NKXkHi9liizdHnij
         ToDc4HxD/j3pVTawh1qqN67T3mvGVxxH+VjhY0Eo5iT7l9ldN3oPzJMuUjzWaqwR4mMW
         ptO/wRe07yGyP045b5pdyYwshYk/nYYscXSWmrYAisCxu4aadkIJAwGhuCUQdY7CeO4H
         u/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b0JwVX06FU3kDxyGGeLmHw9PFleS9yYadeciDJuR71M=;
        b=XfN/J/1ZNZ4qg+xuIe3Zz003BRuwwhMqqMc9ZXMOECzSK5WsL09CPm9O2Vpt9sAFgk
         x+VVCikt1FOGo6QXJ7ZE1Wgj6qJAqVgsYEoUUCxDGq3WWtwjzkHYblzjsHk/aWp1knFj
         V2y77Dx390iYKAFwYHqZUi/0XER1ILmcbZQ371oege885Uoda1ipLEo4s/mWxk8yLHWD
         uVSS8d8Vc3HJOoIrW32A4iFHGBBYfPfvmTJ+BrFMrsvzJCD/7o3MCNHNQfVY2zY2aEwk
         9ttsojHO+ZVfSPIIomVA5aGAXkGPmB3KU81fAOPMf9AIn/aU4nsXvdrXjpp+FjEBSq1n
         lS7g==
X-Gm-Message-State: AOAM532qRNM45rM3KsbNtpQzaCJfY+IQv/JjycQj4hASfxUXB6WLgUz8
        XC/VEl3RlUH7/+DfXjuvbMV7XQ==
X-Google-Smtp-Source: ABdhPJyan/rdcnUZ2XZefS7SZfRXisyuS5D51dB2ovMhnYaLuGCdmDVjS5ZCkLs+zHnib3JUXysqpg==
X-Received: by 2002:a05:6638:2589:b0:31a:4a70:b070 with SMTP id s9-20020a056638258900b0031a4a70b070mr16913306jat.208.1648607645706;
        Tue, 29 Mar 2022 19:34:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d85d2000000b00649254a855fsm9851115ios.26.2022.03.29.19.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 19:34:05 -0700 (PDT)
Date:   Tue, 29 Mar 2022 22:34:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Message-ID: <YkPBnIt6K0crowpb@nand.local>
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
 <220329.86h77h2ju3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220329.86h77h2ju3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 11:04:18AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Mar 23 2022, Taylor Blau wrote:
>
> > On Wed, Mar 23, 2022 at 03:22:13PM -0400, Derrick Stolee wrote:
> >> On 3/23/2022 2:03 PM, Josh Steadmon wrote:
> >> > prepare_repo_settings() initializes a `struct repository` with various
> >> > default config options and settings read from a repository-local config
> >> > file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only
> >> > in git repos), prepare_repo_settings was changed to issue a BUG() if it
> >> > is called by a process whose CWD is not a Git repository. This approach
> >> > was suggested in [1].
> >> >
> >> > This breaks fuzz-commit-graph, which attempts to parse arbitrary
> >> > fuzzing-engine-provided bytes as a commit graph file.
> >> > commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
> >> > since we run the fuzz tests without a valid repository, we are hitting
> >> > the BUG() from 44c7e62 for every test case.
> >> >
> >> > Fix this by refactoring prepare_repo_settings() such that it sets
> >> > default options unconditionally; if its process is in a Git repository,
> >> > it will also load settings from the local config. This eliminates the
> >> > need for a BUG() when not in a repository.
> >>
> >> I think you have the right idea and this can work.
> >
> > Hmmm. To me this feels like bending over backwards in
> > `prepare_repo_settings()` to accommodate one particular caller. I'm not
> > necessarily opposed to it, but it does feel strange to make
> > `prepare_repo_settings()` a noop here, since I would expect that any
> > callers who do want to call `prepare_repo_settings()` are likely
> > convinced that they are inside of a repository, and it probably should
> > be a BUG() if they aren't.
>
> I think adding that BUG() was overzelous in the first place, per
> https://lore.kernel.org/git/211207.86r1apow9f.gmgdl@evledraar.gmail.com/;

I think Junio raised a good point in

    https://lore.kernel.org/git/xmqqcznh8913.fsf@gitster.g/

, though some of the detail was lost in 44c7e62e51 (repo-settings:
prepare_repo_settings only in git repos, 2021-12-06).

> I have that in my local integration branch, because I ended up wanting
> to add prepare_repo_settings() to usage.c, which may or may not run
> inside a repo (and maybe we'll have that config, maybe not).

I see what you're saying, though I think we would be equally OK to have
a default value of the repo_settings struct that we could rely on. I
said some of this back in

    https://lore.kernel.org/git/Yjt6mLIfw0V3aVTO@nand.local/

, namely the parts around "I would expect that any callers who do want
to call `prepare_repo_settings()` are likely convinced that they are
inside of a repository, and it probably should be a BUG() if they
aren't."

Thinking in terms of your message, though, I think the distinction (from
my perspective, at least) is between (a) using something called
_repo_-settings in a non-repo context, and (b) calling a function which
is supposed to fill in its values from a repository (which the caller
implicitly expects to exist).

Neither feel _good_ to me, but (b) feels worse, since it is making it OK
to operate in a likely-unexpected context with respect to the caller's
expectations.

Anyway, I think that we are pretty far into the weeds, and it's likely
time to turn around. I don't have that strong a feeling either way, and
in all honesty either approach is probably just fine.

Thanks,
Taylor
